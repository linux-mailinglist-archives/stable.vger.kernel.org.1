Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5FC775D01
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjHILcy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjHILcx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:32:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998C619A1
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3980763420
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BFBC433C7;
        Wed,  9 Aug 2023 11:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580771;
        bh=yXhS/abqS7zlCSJ3cHBMaA/Hp27HnZgm0SZKGE/FGCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cd1na0rXATLodfAlD04PfSEe3DWwFbIQDm0u8rbh+vO1EI7NQTEk0hkLYimDDs7Nv
         aFiKBQcaHkJzGxZBnKOHjYCYY/1vxOPEJZguyVKiZTp3tj9FFxPfCziMfCHQj3WML1
         d+Zln+A4O9dN63Sv/A/TWbYMfy64sap0QaBXfHes=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jeff Layton <jlayton@kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 142/154] ceph: show tasks waiting on caps in debugfs caps file
Date:   Wed,  9 Aug 2023 12:42:53 +0200
Message-ID: <20230809103641.564000283@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 3a3430affce5de301fc8e6e50fa3543d7597820e ]

Add some visibility of tasks that are waiting for caps to the "caps"
debugfs file. Display the tgid of the waiting task, inode number, and
the caps the task needs and wants.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: e7e607bd0048 ("ceph: defer stopping mdsc delayed_work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c       | 17 +++++++++++++++++
 fs/ceph/debugfs.c    | 13 +++++++++++++
 fs/ceph/mds_client.c |  1 +
 fs/ceph/mds_client.h |  9 +++++++++
 4 files changed, 40 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 243e246cb5046..4e88cb9907230 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2790,7 +2790,19 @@ int ceph_get_caps(struct file *filp, int need, int want,
 		if (ret == -EAGAIN)
 			continue;
 		if (!ret) {
+			struct ceph_mds_client *mdsc = fsc->mdsc;
+			struct cap_wait cw;
 			DEFINE_WAIT_FUNC(wait, woken_wake_function);
+
+			cw.ino = inode->i_ino;
+			cw.tgid = current->tgid;
+			cw.need = need;
+			cw.want = want;
+
+			spin_lock(&mdsc->caps_list_lock);
+			list_add(&cw.list, &mdsc->cap_wait_list);
+			spin_unlock(&mdsc->caps_list_lock);
+
 			add_wait_queue(&ci->i_cap_wq, &wait);
 
 			flags |= NON_BLOCKING;
@@ -2804,6 +2816,11 @@ int ceph_get_caps(struct file *filp, int need, int want,
 			}
 
 			remove_wait_queue(&ci->i_cap_wq, &wait);
+
+			spin_lock(&mdsc->caps_list_lock);
+			list_del(&cw.list);
+			spin_unlock(&mdsc->caps_list_lock);
+
 			if (ret == -EAGAIN)
 				continue;
 		}
diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
index facb387c27356..c281f32b54f7b 100644
--- a/fs/ceph/debugfs.c
+++ b/fs/ceph/debugfs.c
@@ -139,6 +139,7 @@ static int caps_show(struct seq_file *s, void *p)
 	struct ceph_fs_client *fsc = s->private;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	int total, avail, used, reserved, min, i;
+	struct cap_wait	*cw;
 
 	ceph_reservation_status(fsc, &total, &avail, &used, &reserved, &min);
 	seq_printf(s, "total\t\t%d\n"
@@ -166,6 +167,18 @@ static int caps_show(struct seq_file *s, void *p)
 	}
 	mutex_unlock(&mdsc->mutex);
 
+	seq_printf(s, "\n\nWaiters:\n--------\n");
+	seq_printf(s, "tgid         ino                need             want\n");
+	seq_printf(s, "-----------------------------------------------------\n");
+
+	spin_lock(&mdsc->caps_list_lock);
+	list_for_each_entry(cw, &mdsc->cap_wait_list, list) {
+		seq_printf(s, "%-13d0x%-17lx%-17s%-17s\n", cw->tgid, cw->ino,
+				ceph_cap_string(cw->need),
+				ceph_cap_string(cw->want));
+	}
+	spin_unlock(&mdsc->caps_list_lock);
+
 	return 0;
 }
 
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 3bf81fe5f10a3..6ceda2a4791c4 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4174,6 +4174,7 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 	INIT_DELAYED_WORK(&mdsc->delayed_work, delayed_work);
 	mdsc->last_renew_caps = jiffies;
 	INIT_LIST_HEAD(&mdsc->cap_delay_list);
+	INIT_LIST_HEAD(&mdsc->cap_wait_list);
 	spin_lock_init(&mdsc->cap_delay_lock);
 	INIT_LIST_HEAD(&mdsc->snap_flush_list);
 	spin_lock_init(&mdsc->snap_flush_lock);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 5cd131b41d84f..14c7e8c49970a 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -340,6 +340,14 @@ struct ceph_quotarealm_inode {
 	struct inode *inode;
 };
 
+struct cap_wait {
+	struct list_head	list;
+	unsigned long		ino;
+	pid_t			tgid;
+	int			need;
+	int			want;
+};
+
 /*
  * mds client state
  */
@@ -416,6 +424,7 @@ struct ceph_mds_client {
 	spinlock_t	caps_list_lock;
 	struct		list_head caps_list; /* unused (reserved or
 						unreserved) */
+	struct		list_head cap_wait_list;
 	int		caps_total_count;    /* total caps allocated */
 	int		caps_use_count;      /* in use */
 	int		caps_use_max;	     /* max used caps */
-- 
2.40.1



