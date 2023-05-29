Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A34871510C
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 23:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjE2Vpa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 17:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE2Vp3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 17:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9DBDE
        for <stable@vger.kernel.org>; Mon, 29 May 2023 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685396684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4Tm1OBlPtL32lfL8k1O2kMnI4p0B0SfEHtzeOYu6Ug=;
        b=OEsZ6uxOnD4MLpAg5BWwttfQfxWZ+otYP2kduMVocxpo1PHioDQn/8eZkuZvUsXft0Q4vc
        NMIT/Y3mbTqw6oO6wnB5i5k2HvEXFFgJUImMCCs5MopyxtYHZHNLaiX2af9prRm/2b8pnD
        cxU3S8Ly8FhjlQfwljWrralrX7RWLn8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-uJi-lxi-MLKtBiul_ZYVDQ-1; Mon, 29 May 2023 17:44:42 -0400
X-MC-Unique: uJi-lxi-MLKtBiul_ZYVDQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF675185A78E
        for <stable@vger.kernel.org>; Mon, 29 May 2023 21:44:42 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 882F02166B2E;
        Mon, 29 May 2023 21:44:42 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH dlm/next 05/12] fs: dlm: don't check othercon twice
Date:   Mon, 29 May 2023 17:44:33 -0400
Message-Id: <20230529214440.2542721-5-aahringo@redhat.com>
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

This patch removes an another check if con->othercon set inside the
branch which already does that.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lowcomms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index 5aad4d4842eb..b28505b8b23b 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1497,8 +1497,7 @@ int dlm_lowcomms_close(int nodeid)
 	call_srcu(&connections_srcu, &con->rcu, connection_release);
 	if (con->othercon) {
 		clean_one_writequeue(con->othercon);
-		if (con->othercon)
-			call_srcu(&connections_srcu, &con->othercon->rcu, connection_release);
+		call_srcu(&connections_srcu, &con->othercon->rcu, connection_release);
 	}
 	srcu_read_unlock(&connections_srcu, idx);
 
-- 
2.31.1

