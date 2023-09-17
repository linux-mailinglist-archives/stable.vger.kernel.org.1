Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5FB7A3D3E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239708AbjIQUkd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241232AbjIQUkF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:40:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4DE10E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:39:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9D2C433C7;
        Sun, 17 Sep 2023 20:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983199;
        bh=TwOMnQnrMPnoJjSaanTpNQi3cj/FTTk+LBqkIZxHzbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IG8oHKtEcmc2xON8xAAUafa6qkxZDS2i/+hKbjEWUpJJs0N1ZN9Dqo1+Q3G8Mza7E
         4A7B3GX2N/PFmQ2DCsNxwYY5ngBM1vmuJ3Ix5NT0coP4/lS0ZJ0jnPQzxqoCgTk7ru
         pk3G1JaH6L6VDfzGfCdYcYHBR+ftzgupP9rlDi14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Josef Bacik <josef@toxicpanda.com>,
        Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>
Subject: [PATCH 5.15 474/511] btrfs: free qgroup rsv on io failure
Date:   Sun, 17 Sep 2023 21:15:01 +0200
Message-ID: <20230917191125.189579279@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3226,6 +3226,13 @@ out:
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
 


