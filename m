Return-Path: <stable+bounces-247736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECZDIoYTB2rgrQIAu9opvQ
	(envelope-from <stable+bounces-247736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:37:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E364754FB04
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9953330D9E66
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD34347DF8A;
	Fri, 15 May 2026 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAoBXM1A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE647DF96
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847307; cv=none; b=bVHCV4g+5QMbpgJGY6V/GxatJOLhZtHia0rOuDdO58Pc+qy2uyGeb8LxdZD+ElAXmsegOkH6XTIey2/bMouGdoZ+8d3A74vRr96K7/GGlirFKuD60MAhTuy1T2BV+MVDJvzJkPzvHuCjBuRwx3CbwQ70x6g/ovRvmXaqqk8bSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847307; c=relaxed/simple;
	bh=yRpV3OluRDaHynaDo5gv2zLEgNY3lv8rnwD47+mRWCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGEHyYXtWH9m0Mu2Rh09xbEFJ5a9bFmpZTjjR0ti801a9D3RZq22Hse85enAq4UTqMIigNH17R/VmIvJ043NSwarH9Y5vY+Jib4/KDCOX/7HnYWSP4Iwy/VZzQE36z9V9BEdzc6+2GnzpY01uNkhO582yZsuHuLPV3fg8Ug3agU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAoBXM1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49E6C2BCB0;
	Fri, 15 May 2026 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778847306;
	bh=yRpV3OluRDaHynaDo5gv2zLEgNY3lv8rnwD47+mRWCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KAoBXM1A9m+Fn4umTVTQx+189Mpx0Z4VjlD9ErveP0k54XI6NNbNwcnJc12+FqkId
	 POEC49UtWsXYDtC7A2+mv8/8t6aaRqwp4hsPeg0ej8/HDZ4df3S6lf+n91033yVUmv
	 gPrszXmcBxEHyrxIsFPxYMYA/ZtMk6gnH3sP50Tz8axpCPf4q6cOMA66RUQDLi87dp
	 /WSg6AuSSptTzr2AcR9ZkirbwSnzQ2Dn80qJoO3eiYyR4ZvgcaMbkHiWmsBlFdARhs
	 gu3PDKWyUomgVNtvFSA04S8G4JuKHKxnXcJpbnubkirLDMw55fNzzVPSk6FCgLnDpu
	 5jY74doBhgl1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yochai Eisenrich <yochaie@sweet.security>,
	Yochai Eisenrich <echelonh@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak
Date: Fri, 15 May 2026 08:15:04 -0400
Message-ID: <20260515121504.3129260-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051218-unlaced-distill-76af@gregkh>
References: <2026051218-unlaced-distill-76af@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E364754FB04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sweet.security,gmail.com,suse.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247736-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Yochai Eisenrich <yochaie@sweet.security>

[ Upstream commit 973e57c726c1f8e77259d1c8e519519f1e9aea77 ]

btrfs_ioctl_space_info() has a TOCTOU race between two passes over the
block group RAID type lists. The first pass counts entries to determine
the allocation size, then the second pass fills the buffer. The
groups_sem rwlock is released between passes, allowing concurrent block
group removal to reduce the entry count.

When the second pass fills fewer entries than the first pass counted,
copy_to_user() copies the full alloc_size bytes including trailing
uninitialized kmalloc bytes to userspace.

Fix by copying only total_spaces entries (the actually-filled count from
the second pass) instead of alloc_size bytes, and switch to kzalloc so
any future copy size mismatch cannot leak heap data.

Fixes: 7fde62bffb57 ("Btrfs: buffer results in the space_info ioctl")
CC: stable@vger.kernel.org # 3.0
Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[ adapted upstream's `return -EFAULT;` to stable's `ret = -EFAULT;` fall-through to existing `out:` cleanup label ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 835ce20304104..b84b1cce17723 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3977,7 +3977,7 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 
 	space_args.total_spaces = 0;
-	dest = kmalloc(alloc_size, GFP_KERNEL);
+	dest = kzalloc(alloc_size, GFP_KERNEL);
 	if (!dest)
 		return -ENOMEM;
 	dest_orig = dest;
@@ -4033,7 +4033,8 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 	user_dest = (struct btrfs_ioctl_space_info __user *)
 		(arg + sizeof(struct btrfs_ioctl_space_args));
 
-	if (copy_to_user(user_dest, dest_orig, alloc_size))
+	if (copy_to_user(user_dest, dest_orig,
+		 space_args.total_spaces * sizeof(*dest_orig)))
 		ret = -EFAULT;
 
 	kfree(dest_orig);
-- 
2.53.0


