Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ECD775D09
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjHILdQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjHILdP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:33:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D593E3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C1863442
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:33:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF59C433C8;
        Wed,  9 Aug 2023 11:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580794;
        bh=UpHjY8lhyxAMt43nsF/tBQenGyYnAxrk+fVsdIxA28s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r9+reYBxWI1u/Uf7PbKhuu/+TB2AcstqGFPr+og0Dv87gUkiTV0gaXT4xzmHFbHQJ
         TNq+s31gtACn6lDOs8jUaG3k311Yc4h63BxzqkfKaAjM6CNlT2B068wKhmPUuHaL3X
         DlP9L1VNLPu3eAHjC/Lm5bDuWIN/qKVFRS05JcdY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 144/154] ceph: defer stopping mdsc delayed_work
Date:   Wed,  9 Aug 2023 12:42:55 +0200
Message-ID: <20230809103641.625048891@linuxfoundation.org>
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

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit e7e607bd00481745550389a29ecabe33e13d67cf ]

Flushing the dirty buffer may take a long time if the cluster is
overloaded or if there is network issue. So we should ping the
MDSs periodically to keep alive, else the MDS will blocklist
the kclient.

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/61843
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/mds_client.c |  4 ++--
 fs/ceph/mds_client.h |  5 +++++
 fs/ceph/super.c      | 10 ++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 6ceda2a4791c4..f7acf9680c9b6 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4074,7 +4074,7 @@ static void delayed_work(struct work_struct *work)
 
 	dout("mdsc delayed_work\n");
 
-	if (mdsc->stopping)
+	if (mdsc->stopping >= CEPH_MDSC_STOPPING_FLUSHED)
 		return;
 
 	mutex_lock(&mdsc->mutex);
@@ -4246,7 +4246,7 @@ static void wait_requests(struct ceph_mds_client *mdsc)
 void ceph_mdsc_pre_umount(struct ceph_mds_client *mdsc)
 {
 	dout("pre_umount\n");
-	mdsc->stopping = 1;
+	mdsc->stopping = CEPH_MDSC_STOPPING_BEGIN;
 
 	lock_unlock_sessions(mdsc);
 	ceph_flush_dirty_caps(mdsc);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 14c7e8c49970a..4fbbc33023c97 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -348,6 +348,11 @@ struct cap_wait {
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
index 279334f955702..0e38678d5adda 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1180,6 +1180,16 @@ static void ceph_kill_sb(struct super_block *s)
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
-- 
2.40.1



