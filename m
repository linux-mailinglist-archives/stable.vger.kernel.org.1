Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C98771AD4
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 08:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHGGyt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 02:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjHGGyr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 02:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CA21A4
        for <stable@vger.kernel.org>; Sun,  6 Aug 2023 23:54:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC45261578
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 06:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB8C3C433C8;
        Mon,  7 Aug 2023 06:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691391285;
        bh=wJmKP7vU9LqHN7dLIk2aKflanQhNr9cs/mG+f4wocsY=;
        h=Subject:To:Cc:From:Date:From;
        b=Qmkd67jjGPyk1sIP/Pa9crVspXiG2muN+cHkmfjb/r7qzpNMpt0i/lQHoK99vPSSB
         JhWqqdUMkMTN1tQBvxubcvv8YYOtrpFSC9HtQQsA7G4w6fI3Q3DVUcW0erMnv2xptn
         lySgsvDhBMlTVtwLP2TYahjQVp26wTf5wDVwAfUg=
Subject: FAILED: patch "[PATCH] ceph: defer stopping mdsc delayed_work" failed to apply to 4.19-stable tree
To:     xiubli@redhat.com, idryomov@gmail.com, mchangir@redhat.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 08:54:34 +0200
Message-ID: <2023080734-unenvied-relocate-bccd@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x e7e607bd00481745550389a29ecabe33e13d67cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080734-unenvied-relocate-bccd@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

e7e607bd0048 ("ceph: defer stopping mdsc delayed_work")
470a5c77eac0 ("ceph: use kill_anon_super helper")
fa9967734227 ("ceph: fix potential mdsc use-after-free crash")
3a3430affce5 ("ceph: show tasks waiting on caps in debugfs caps file")
7b2f936fc828 ("ceph: fix error handling in ceph_get_caps()")
1199d7da2d29 ("ceph: simplify arguments and return semantics of try_get_cap_refs")
ff4a80bf2d3f ("ceph: dump granular cap info in "caps" debugfs file")
0c44a8e0fc55 ("ceph: quota: fix quota subdir mounts")
2ee9dd958d47 ("ceph: add non-blocking parameter to ceph_try_get_caps()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e7e607bd00481745550389a29ecabe33e13d67cf Mon Sep 17 00:00:00 2001
From: Xiubo Li <xiubli@redhat.com>
Date: Tue, 25 Jul 2023 12:03:59 +0800
Subject: [PATCH] ceph: defer stopping mdsc delayed_work

Flushing the dirty buffer may take a long time if the cluster is
overloaded or if there is network issue. So we should ping the
MDSs periodically to keep alive, else the MDS will blocklist
the kclient.

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/61843
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 66048a86c480..5fb367b1d4b0 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4764,7 +4764,7 @@ static void delayed_work(struct work_struct *work)
 
 	dout("mdsc delayed_work\n");
 
-	if (mdsc->stopping)
+	if (mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHED)
 		return;
 
 	mutex_lock(&mdsc->mutex);
@@ -4943,7 +4943,7 @@ void send_flush_mdlog(struct ceph_mds_session *s)
 void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 {
 	dout("pre_umount\n");
-	mdsc->stopping = 1;
+	mdsc->stopping = CEPH_MDSC_STOPPING_BEGIN;
 
 	ceph_mdsc_iterate_sessions(mdsc, send_flush_mdlog, true);
 	ceph_mdsc_iterate_sessions(mdsc, lock_unlock_session, false);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 724307ff89cd..86d2965e68a1 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -380,6 +380,11 @@ struct cap_wait {
 	int			want;
 };
 
+enum {
+       CEPH_MDSC_STOPPING_BEGIN = 1,
+       CEPH_MDSC_STOPPING_FLUSHED = 2,
+};
+
 /*
  * mds client state
  */
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 3fc48b43cab0..a5f52013314d 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1374,6 +1374,16 @@ static void ceph_kill_sb(struct super_block *s)
 	ceph_mdsc_pre_umount(fsc->mdsc);
 	flush_fs_workqueues(fsc);
 
+	/*
+	 * Though the kill_anon_super() will finally trigger the
+	 * sync_filesystem() anyway, we still need to do it here
+	 * and then bump the stage of shutdown to stop the work
+	 * queue as earlier as possible.
+	 */
+	sync_filesystem(s);
+
+	fsc->mdsc->stopping = CEPH_MDSC_STOPPING_FLUSHED;
+
 	kill_anon_super(s);
 
 	fsc->client->extra_mon_dispatch = NULL;

