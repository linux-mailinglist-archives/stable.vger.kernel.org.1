Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BECD7BDEFE
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376538AbjJINZQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376708AbjJINZO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:25:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A33DE
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:25:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C18BC433D9;
        Mon,  9 Oct 2023 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696857912;
        bh=w0XoCo3i5YH70W2p/OkCWGbeCMt0VxHGeVl05ct+jZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eyOPoHsb8/4svxlzRTBlgVisR+a96i4bwc4v9LEQWWyZFH3T5KNhB+sCmhYRX2WpA
         cUO6xleDKRHPv+zTVmcX1zcLTmxWgngOEBllWOKKX0fdidCEWSV17oBAQPywqOyI4M
         8KnB0N6omknpq5ZeGyzS9s3vltrSfaspaCZK+Kn0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Benjamin Coddington <bcodding@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 06/75] NFS: rename nfs_client_kset to nfs_kset
Date:   Mon,  9 Oct 2023 15:01:28 +0200
Message-ID: <20231009130111.425294297@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
References: <20231009130111.200710898@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit 8b18a2edecc0741b0eecf8b18fdb356a0f8682de ]

Be brief and match the subsystem name.  There's no need to distinguish this
kset variable from the server.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: 956fd46f97d2 ("NFSv4: Fix a state manager thread deadlock regression")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/sysfs.c b/fs/nfs/sysfs.c
index 8cb70755e3c9e..f7f778e3e5ca7 100644
--- a/fs/nfs/sysfs.c
+++ b/fs/nfs/sysfs.c
@@ -18,7 +18,7 @@
 #include "sysfs.h"
 
 struct kobject *nfs_client_kobj;
-static struct kset *nfs_client_kset;
+static struct kset *nfs_kset;
 
 static void nfs_netns_object_release(struct kobject *kobj)
 {
@@ -55,13 +55,13 @@ static struct kobject *nfs_netns_object_alloc(const char *name,
 
 int nfs_sysfs_init(void)
 {
-	nfs_client_kset = kset_create_and_add("nfs", NULL, fs_kobj);
-	if (!nfs_client_kset)
+	nfs_kset = kset_create_and_add("nfs", NULL, fs_kobj);
+	if (!nfs_kset)
 		return -ENOMEM;
-	nfs_client_kobj = nfs_netns_object_alloc("net", nfs_client_kset, NULL);
+	nfs_client_kobj = nfs_netns_object_alloc("net", nfs_kset, NULL);
 	if  (!nfs_client_kobj) {
-		kset_unregister(nfs_client_kset);
-		nfs_client_kset = NULL;
+		kset_unregister(nfs_kset);
+		nfs_kset = NULL;
 		return -ENOMEM;
 	}
 	return 0;
@@ -70,7 +70,7 @@ int nfs_sysfs_init(void)
 void nfs_sysfs_exit(void)
 {
 	kobject_put(nfs_client_kobj);
-	kset_unregister(nfs_client_kset);
+	kset_unregister(nfs_kset);
 }
 
 static ssize_t nfs_netns_identifier_show(struct kobject *kobj,
@@ -158,7 +158,7 @@ static struct nfs_netns_client *nfs_netns_client_alloc(struct kobject *parent,
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (p) {
 		p->net = net;
-		p->kobject.kset = nfs_client_kset;
+		p->kobject.kset = nfs_kset;
 		if (kobject_init_and_add(&p->kobject, &nfs_netns_client_type,
 					parent, "nfs_client") == 0)
 			return p;
-- 
2.40.1



