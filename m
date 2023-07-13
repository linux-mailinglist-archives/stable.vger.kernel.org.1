Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56380752916
	for <lists+stable@lfdr.de>; Thu, 13 Jul 2023 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbjGMQtz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 13 Jul 2023 12:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjGMQtw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 13 Jul 2023 12:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D5930F9
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689266944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IOMm7l7E2mazcpNUDsbyjCr1jkWKh2/DVK60DKHLsps=;
        b=FF1oLD+bjEjBc5eDBYp/Fnjb3gU2ZY5g+cn+krfTJH/eF6ycPIz6X0zxXhEvIV60Ilc7ns
        T3+e56OWfwe5v0lsdZ1tnzbWmt6V+7RjLpLBW8OdqVX5srnRtcFxnwZRyppNi8Cjst5wgx
        nR8pDeqfAbcMfLspr1Zb1J8P46rFjhg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-JmKZ2_UONJmSpV_ZjXpYOQ-1; Thu, 13 Jul 2023 12:49:02 -0400
X-MC-Unique: JmKZ2_UONJmSpV_ZjXpYOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 72AD6800CA6
        for <stable@vger.kernel.org>; Thu, 13 Jul 2023 16:49:02 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 452B32166B26;
        Thu, 13 Jul 2023 16:49:02 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org, agruenba@redhat.com
Subject: [PATCHv2 v6.5-rc1 1/3] fs: dlm: ignore DLM_PLOCK_FL_CLOSE flag results
Date:   Thu, 13 Jul 2023 12:48:36 -0400
Message-Id: <20230713164838.3583052-2-aahringo@redhat.com>
In-Reply-To: <20230713164838.3583052-1-aahringo@redhat.com>
References: <20230713164838.3583052-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This patch will ignore dlm plock results with DLM_PLOCK_FL_CLOSE being
set. When DLM_PLOCK_FL_CLOSE is set then no reply is expected and a
plock op cannot being matched and the result cannot be delivered to the
caller. In some user space software applications like dlm_controld (the
common application and only knowing implementation using this UAPI) can
send an error back even if an result is never being expected.

This patch will ignore results if DLM_PLOCK_FL_CLOSE is being set, but
requires that the user space application sents the result back with
DLM_PLOCK_FL_CLOSE set which is the case for dlm_controld.

Fixes: 901025d2f319 ("dlm: make plock operation killable")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/plock.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/dlm/plock.c b/fs/dlm/plock.c
index 70a4752ed913..869595a995f7 100644
--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -433,6 +433,14 @@ static ssize_t dev_write(struct file *file, const char __user *u, size_t count,
 	if (check_version(&info))
 		return -EINVAL;
 
+	/* Some dlm user space software will send replies back,
+	 * even if DLM_PLOCK_FL_CLOSE is set e.g. if an error occur.
+	 * We can't match them in recv_list because they were never
+	 * be part of it.
+	 */
+	if (info.flags & DLM_PLOCK_FL_CLOSE)
+		return count;
+
 	/*
 	 * The results for waiting ops (SETLKW) can be returned in any
 	 * order, so match all fields to find the op.  The results for
-- 
2.31.1

