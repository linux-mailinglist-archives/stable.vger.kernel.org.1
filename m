Return-Path: <stable+bounces-220129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KxcNfwpo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A32E61C517A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4202A3098112
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EE334CFD3;
	Sat, 28 Feb 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+uLclxH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901F8481666;
	Sat, 28 Feb 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300039; cv=none; b=qi9xslZ4n7gOh0MgHDMUgmyeq+RRoocc7Or9Mng2U8tXSn0brLOaaEzUW89He02/uoaRas1p6fTi7zRQmeOdBQQUBYBnkwxTu0mPaNnu/f3korz9uZf+/gIA8bSSywlyowLb1OP0m+EJ9CPj1JrtnB0Ho4hYpEbm+GeiNq8WDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300039; c=relaxed/simple;
	bh=xw88FVVbPcXSiYHWeteOKEwT0qvb3ts8yZxMO2C0w3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDEKH/UDGpPh8FOhtIIBrliOQZKEmjrfOvidNNwcjQ5LG+Y2GKN5XbNUlPQdZ/+I9K/D7kwvzuUBheAd27URQ7L8bzPHMBVuwFoemGIMDnRC9ozmxmKK5JRww1rxr6auz9cbQ+V2T9S9r/VGtYFiWxIbha9b0sH2PO8zldoQ0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+uLclxH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E12C116D0;
	Sat, 28 Feb 2026 17:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300039;
	bh=xw88FVVbPcXSiYHWeteOKEwT0qvb3ts8yZxMO2C0w3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+uLclxH4pcdzfAl8UGKnq97tQMQOWSswod1eip4TKSV+Q1tdtOrL1o0UnGoXx4+3
	 SJ36oUhp50va8tlHGIsSVb1mnwrEFKumRZiqxS+6/TskOLUs6/1Ik7iHib6mtiSgds
	 I8NnTLSls5F3KqKt1V7fRQr+iizvvv2AIrV22eWAkr6sJbW1e+eiYF3BXqCXMgzGeH
	 +h0kNR5EGVdilHqnkbIzXabfdcB6RHNEZ7q0ACtPIIIUTaAG7i5c6dJ0hvMTbTgm2/
	 6yv8cEBBcEHLddvuhyUvYH1GoLbS6zPCcDGJbjm5CkIDkwBnsR1vaP24+pxZDJCvIz
	 sa0RP1rRpR9ug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: jinbaohong <jinbaohong@synology.com>,
	Qu Wenruo <wqu@suse.com>,
	Robbie Ko <robbieko@synology.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 051/844] btrfs: handle user interrupt properly in btrfs_trim_fs()
Date: Sat, 28 Feb 2026 12:19:24 -0500
Message-ID: <20260228173244.1509663-52-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220129-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,synology.com:email]
X-Rspamd-Queue-Id: A32E61C517A
X-Rspamd-Action: no action

From: jinbaohong <jinbaohong@synology.com>

[ Upstream commit bfb670b9183b0e4ba660aff2e396ec1cc01d0761 ]

When a fatal signal is pending or the process is freezing,
btrfs_trim_block_group() and btrfs_trim_free_extents() return -ERESTARTSYS.
Currently this is treated as a regular error: the loops continue to the
next iteration and count it as a block group or device failure.

Instead, break out of the loops immediately and return -ERESTARTSYS to
userspace without counting it as a failure. Also skip the device loop
entirely if the block group loop was interrupted.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Robbie Ko <robbieko@synology.com>
Signed-off-by: jinbaohong <jinbaohong@synology.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1bf081243efb2..8bdb609f58a7e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6555,6 +6555,10 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 						     range->minlen);
 
 			trimmed += group_trimmed;
+			if (ret == -ERESTARTSYS || ret == -EINTR) {
+				btrfs_put_block_group(cache);
+				break;
+			}
 			if (ret) {
 				bg_failed++;
 				bg_ret = ret;
@@ -6568,6 +6572,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			"failed to trim %llu block group(s), last error %d",
 			bg_failed, bg_ret);
 
+	if (ret == -ERESTARTSYS || ret == -EINTR)
+		return ret;
+
 	mutex_lock(&fs_devices->device_list_mutex);
 	list_for_each_entry(device, &fs_devices->devices, dev_list) {
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
@@ -6576,6 +6583,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 		ret = btrfs_trim_free_extents(device, &group_trimmed);
 
 		trimmed += group_trimmed;
+		if (ret == -ERESTARTSYS || ret == -EINTR)
+			break;
 		if (ret) {
 			dev_failed++;
 			dev_ret = ret;
@@ -6589,6 +6598,8 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
 			"failed to trim %llu device(s), last error %d",
 			dev_failed, dev_ret);
 	range->len = trimmed;
+	if (ret == -ERESTARTSYS || ret == -EINTR)
+		return ret;
 	if (bg_ret)
 		return bg_ret;
 	return dev_ret;
-- 
2.51.0


