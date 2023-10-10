Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D337C4373
	for <lists+stable@lfdr.de>; Wed, 11 Oct 2023 00:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjJJWGc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 10 Oct 2023 18:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjJJWGb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Oct 2023 18:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ADAB4
        for <stable@vger.kernel.org>; Tue, 10 Oct 2023 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696975511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1DAsNmGZUyXNq+0RsyEaZwIKrlbsqv6ED1CKmPYg80=;
        b=Hlg2SDnxVRgEj27xMFm+vZbYPqkfz3ejtdYEk8BS+pm35m86m7zLHpyf6pq4Z14l4VGRrp
        ond1bdiC4hlYFMt19NUgSav7aelcRheqL+XPfLO6ZYXWROLwesAfbOFVXl89dO/j0T52iL
        jspamnCRgV3sQkjwCW3baEhJ4gUQ/FI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-633-4Hpfvi0yNsaBQe9pAvAUug-1; Tue, 10 Oct 2023 18:04:58 -0400
X-MC-Unique: 4Hpfvi0yNsaBQe9pAvAUug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B76FB38008A3;
        Tue, 10 Oct 2023 22:04:57 +0000 (UTC)
Received: from fs-i40c-03.fs.lab.eng.bos.redhat.com (fs-i40c-03.fs.lab.eng.bos.redhat.com [10.16.224.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8670D9A;
        Tue, 10 Oct 2023 22:04:57 +0000 (UTC)
From:   Alexander Aring <aahringo@redhat.com>
To:     teigland@redhat.com
Cc:     cluster-devel@redhat.com, gfs2@lists.linux.dev,
        christophe.jaillet@wanadoo.fr, stable@vger.kernel.org,
        aahringo@redhat.com
Subject: [PATCH RESEND 3/8] fs: dlm: Remove some useless memset()
Date:   Tue, 10 Oct 2023 18:04:43 -0400
Message-Id: <20231010220448.2978176-3-aahringo@redhat.com>
In-Reply-To: <20231010220448.2978176-1-aahringo@redhat.com>
References: <20231010220448.2978176-1-aahringo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

There is no need to clear the buffer used to build the file name.

snprintf() already guarantees that it is NULL terminated and such a
(useless) precaution was not done for the first string (i.e
ls_debug_rsb_dentry)

So, save a few LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/debug_fs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index c93359ceaae6..42f332f46359 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -986,7 +986,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 2 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_locks", ls->ls_name);
 
 	ls->ls_debug_locks_dentry = debugfs_create_file(name,
@@ -997,7 +996,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 3 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_all", ls->ls_name);
 
 	ls->ls_debug_all_dentry = debugfs_create_file(name,
@@ -1008,7 +1006,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 4 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_toss", ls->ls_name);
 
 	ls->ls_debug_toss_dentry = debugfs_create_file(name,
@@ -1017,7 +1014,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 						       ls,
 						       &format4_fops);
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_waiters", ls->ls_name);
 
 	ls->ls_debug_waiters_dentry = debugfs_create_file(name,
@@ -1028,7 +1024,6 @@ void dlm_create_debug_file(struct dlm_ls *ls)
 
 	/* format 5 */
 
-	memset(name, 0, sizeof(name));
 	snprintf(name, sizeof(name), "%s_queued_asts", ls->ls_name);
 
 	ls->ls_debug_queued_asts_dentry = debugfs_create_file(name,
-- 
2.39.3

