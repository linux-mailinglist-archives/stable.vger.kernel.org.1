Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0272C095
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbjFLKxc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbjFLKxK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:53:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1957EAD21
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:37:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 087DB61297
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F881C433EF;
        Mon, 12 Jun 2023 10:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566275;
        bh=VRkmYk+L3lsQGaGcn+zs9+U1KfTNw9Ps3tNLs9pALlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xy87zfQkr2YMuwdziKxXR9WFTYZeJIcfMnfryPDyNL74umEeXPdNIbz0hKFl09RiL
         FaKnxvhZ+2dcTaEWwRreSq5v6YZS/4lsZ3xnbaW1WHKZs7sQBUgo7MWObxK1JTZG08
         lkTSbFWy0DeTxyGqlkubQmpzGpjC/39YuQWyFKsQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.15 61/91] ceph: fix use-after-free bug for inodes when flushing capsnaps
Date:   Mon, 12 Jun 2023 12:26:50 +0200
Message-ID: <20230612101704.607160202@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

commit 409e873ea3c1fd3079909718bbeb06ac1ec7f38b upstream.

There is a race between capsnaps flush and removing the inode from
'mdsc->snap_flush_list' list:

   == Thread A ==                     == Thread B ==
ceph_queue_cap_snap()
 -> allocate 'capsnapA'
 ->ihold('&ci->vfs_inode')
 ->add 'capsnapA' to 'ci->i_cap_snaps'
 ->add 'ci' to 'mdsc->snap_flush_list'
    ...
   == Thread C ==
ceph_flush_snaps()
 ->__ceph_flush_snaps()
  ->__send_flush_snap()
                                handle_cap_flushsnap_ack()
                                 ->iput('&ci->vfs_inode')
                                   this also will release 'ci'
                                    ...
				      == Thread D ==
                                ceph_handle_snap()
                                 ->flush_snaps()
                                  ->iterate 'mdsc->snap_flush_list'
                                   ->get the stale 'ci'
 ->remove 'ci' from                ->ihold(&ci->vfs_inode) this
   'mdsc->snap_flush_list'           will WARNING

To fix this we will increase the inode's i_count ref when adding 'ci'
to the 'mdsc->snap_flush_list' list.

[ idryomov: need_put int -> bool ]

Cc: stable@vger.kernel.org
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2209299
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/caps.c |    6 ++++++
 fs/ceph/snap.c |    4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1624,6 +1624,7 @@ void ceph_flush_snaps(struct ceph_inode_
 	struct inode *inode = &ci->vfs_inode;
 	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
 	struct ceph_mds_session *session = NULL;
+	bool need_put = false;
 	int mds;
 
 	dout("ceph_flush_snaps %p\n", inode);
@@ -1668,8 +1669,13 @@ out:
 		ceph_put_mds_session(session);
 	/* we flushed them all; remove this inode from the queue */
 	spin_lock(&mdsc->snap_flush_lock);
+	if (!list_empty(&ci->i_snap_flush_item))
+		need_put = true;
 	list_del_init(&ci->i_snap_flush_item);
 	spin_unlock(&mdsc->snap_flush_lock);
+
+	if (need_put)
+		iput(inode);
 }
 
 /*
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -657,8 +657,10 @@ int __ceph_finish_cap_snap(struct ceph_i
 	     capsnap->size);
 
 	spin_lock(&mdsc->snap_flush_lock);
-	if (list_empty(&ci->i_snap_flush_item))
+	if (list_empty(&ci->i_snap_flush_item)) {
+		ihold(inode);
 		list_add_tail(&ci->i_snap_flush_item, &mdsc->snap_flush_list);
+	}
 	spin_unlock(&mdsc->snap_flush_lock);
 	return 1;  /* caller may want to ceph_flush_snaps */
 }


