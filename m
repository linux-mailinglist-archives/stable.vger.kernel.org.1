Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E97A3B3F
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbjIQUO6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240439AbjIQUOn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:14:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A391F4
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:14:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFDEC433C8;
        Sun, 17 Sep 2023 20:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694981678;
        bh=IElLcl7hKP5cIjm1uOSGAn9LI5C1J2KQwLWTutCt7kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C2+zxMLOy1pKoAZTq2oFMrHrCHbmmEXceVeq82mX6oAXaXQqyBWylVXdLytlPjMOu
         dkJvZ9vu0bgo2WkzRNonXxp7MqBT8OzSjNCCQoatsoqfb+rDmKQ65I2qAE4AVQqh2p
         kusGnNRd1M8HA9pFBivaN0+CFf8hmz0gWWu2ddHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>
Subject: [PATCH 6.1 157/219] btrfs: free qgroup rsv on io failure
Date:   Sun, 17 Sep 2023 21:14:44 +0200
Message-ID: <20230917191046.725838396@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
References: <20230917191040.964416434@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Burkov <boris@bur.io>

commit e28b02118b94e42be3355458a2406c6861e2dd32 upstream.

If we do a write whose bio suffers an error, we will never reclaim the
qgroup reserved space for it. We allocate the space in the write_iter
codepath, then release the reservation as we allocate the ordered
extent, but we only create a delayed ref if the ordered extent finishes.
If it has an error, we simply leak the rsv. This is apparent in running
any error injecting (dmerror) fstests like btrfs/146 or btrfs/160. Such
tests fail due to dmesg on umount complaining about the leaked qgroup
data space.

When we clean up other aspects of space on failed ordered_extents, also
free the qgroup rsv.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
CC: stable@vger.kernel.org # 5.10+
Signed-off-by: Boris Burkov <boris@bur.io>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/inode.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3393,6 +3393,13 @@ out:
 			btrfs_free_reserved_extent(fs_info,
 					ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes, 1);
+			/*
+			 * Actually free the qgroup rsv which was released when
+			 * the ordered extent was created.
+			 */
+			btrfs_qgroup_free_refroot(fs_info, inode->root->root_key.objectid,
+						  ordered_extent->qgroup_rsv,
+						  BTRFS_QGROUP_RSV_DATA);
 		}
 	}
 


