Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D72715114
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 23:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjE2VqS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 17:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjE2VqR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 17:46:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D046E0
        for <stable@vger.kernel.org>; Mon, 29 May 2023 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685396684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rMXtxdV6aNwAW8Qp//Bw2aLPTA21SC2e1vso++Us7s=;
        b=eBXr2Sz1lEd+jtBvXWBlMnIANh1S06FPkwCxlNF4gxApgQxekw+DMuOz5Pay0hprC+TO8n
        6cGAGhQgBDW/IhaJ7rKZT7wOcOi6YNvlgWMgdXY41QGyRTyBTgnmN7Pbrf8BKLWNj5oN3i
        aaPjQ+8gzyzq1bGP6ypFRLumg2A39bc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-7JQ8ksSbMHeo7cpiaE1Yrw-1; Mon, 29 May 2023 17:44:43 -0400
X-MC-Unique: 7JQ8ksSbMHeo7cpiaE1Yrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE91E800962
        for <stable@vger.kernel.org>; Mon, 29 May 2023 21:44:42 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B75D12166B2B;
        Mon, 29 May 2023 21:44:42 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH dlm/next 06/12] fs: dlm: cleanup STOP_IO bitflag set when stop io
Date:   Mon, 29 May 2023 17:44:34 -0400
Message-Id: <20230529214440.2542721-6-aahringo@redhat.com>
In-Reply-To: <20230529214440.2542721-1-aahringo@redhat.com>
References: <20230529214440.2542721-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

There should no difference between setting the CF_IO_STOP flag
before restore_callbacks() to do it before or afterwards. The
restore_callbacks() will be sure that no callback is executed anymore
when the bit wasn't set.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index b28505b8b23b..5a7586633cbe 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -735,19 +735,15 @@ static void stop_connection_io(struct connection *con)
 	if (con->othercon)
 		stop_connection_io(con->othercon);
 
+	spin_lock_bh(&con->writequeue_lock);
+	set_bit(CF_IO_STOP, &con->flags);
+	spin_unlock_bh(&con->writequeue_lock);
+
 	down_write(&con->sock_lock);
 	if (con->sock) {
 		lock_sock(con->sock->sk);
 		restore_callbacks(con->sock->sk);
-
-		spin_lock_bh(&con->writequeue_lock);
-		set_bit(CF_IO_STOP, &con->flags);
-		spin_unlock_bh(&con->writequeue_lock);
 		release_sock(con->sock->sk);
-	} else {
-		spin_lock_bh(&con->writequeue_lock);
-		set_bit(CF_IO_STOP, &con->flags);
-		spin_unlock_bh(&con->writequeue_lock);
 	}
 	up_write(&con->sock_lock);
 
-- 
2.31.1

