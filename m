Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC17715112
	for <lists+stable@lfdr.de>; Mon, 29 May 2023 23:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjE2VqR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 29 May 2023 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjE2VqQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 29 May 2023 17:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B49E3
        for <stable@vger.kernel.org>; Mon, 29 May 2023 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685396685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bjAyQaK3NkAs3edaOJZcql5Xwneq0PBQF5xPGlJrtrc=;
        b=I4gCYNYbIrEqSJqGVpAhhgZ5ncPSnMQrif/jbM8jSr5WEovK0KL4Pc4mGqB7gYe8YI2gmn
        cLnVuWHOXcuYVw4CCEKwpBYAiXbpAfMkF8FkJzaapztMgfoVE2KOukmPL/U3oEW8HiIPTo
        7DxjZHa0ZrOAbsfiYFRWKIswQ85i2Q8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-rptiPHPDMXui-23seD9q0Q-1; Mon, 29 May 2023 17:44:43 -0400
X-MC-Unique: rptiPHPDMXui-23seD9q0Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49A3E80027F
        for <stable@vger.kernel.org>; Mon, 29 May 2023 21:44:43 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 222382166B2B;
        Mon, 29 May 2023 21:44:43 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, aahringo@redhat.com,
        stable@vger.kernel.org
Subject: [PATCH dlm/next 08/12] fs: dlm: warn about messages from left nodes
Date:   Mon, 29 May 2023 17:44:36 -0400
Message-Id: <20230529214440.2542721-8-aahringo@redhat.com>
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

This patch warns about messages which are received from nodes who
already left the lockspace resource signaled by the cluster manager.
Before commit 489d8e559c65 ("fs: dlm: add reliable connection if
reconnect") there was a synchronization issue with the socket
lifetime and the cluster event of leaving a lockspace and other
nodes did not stop of sending messages because the cluster manager has a
pending message to leave the lockspace. The reliable session layer for
dlm use sequence numbers to ensure dlm message were never being dropped.
If this is not corrected synchronized we have a problem, this patch will
use the filter case and turn it into a WARN_ON_ONCE() so we seeing such
issue on the kernel log because it should never happen now.

Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/lock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index debf8a55ad7d..ede903246fa4 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -4616,7 +4616,7 @@ static void _receive_message(struct dlm_ls *ls, struct dlm_message *ms,
 {
 	int error = 0, noent = 0;
 
-	if (!dlm_is_member(ls, le32_to_cpu(ms->m_header.h_nodeid))) {
+	if (WARN_ON_ONCE(!dlm_is_member(ls, le32_to_cpu(ms->m_header.h_nodeid)))) {
 		log_limit(ls, "receive %d from non-member %d %x %x %d",
 			  le32_to_cpu(ms->m_type),
 			  le32_to_cpu(ms->m_header.h_nodeid),
@@ -4754,7 +4754,7 @@ static void dlm_receive_message(struct dlm_ls *ls, struct dlm_message *ms,
 		/* If we were a member of this lockspace, left, and rejoined,
 		   other nodes may still be sending us messages from the
 		   lockspace generation before we left. */
-		if (!ls->ls_generation) {
+		if (WARN_ON_ONCE(!ls->ls_generation)) {
 			log_limit(ls, "receive %d from %d ignore old gen",
 				  le32_to_cpu(ms->m_type), nodeid);
 			return;
-- 
2.31.1

