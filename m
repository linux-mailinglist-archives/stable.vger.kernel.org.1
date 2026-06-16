Return-Path: <stable+bounces-266118-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b8StDcuWMWpmngUAu9opvQ
	(envelope-from <stable+bounces-266118-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:32:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A14D6943A4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:32:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=fQiiajnM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266118-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266118-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8738C30046B2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34224418D7;
	Tue, 16 Jun 2026 18:32:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDA3DA7E1;
	Tue, 16 Jun 2026 18:32:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781634758; cv=none; b=DJjGqtnMtp0WRu9bM0mSwElqVzNX2pUrH8q5Ncrxgy78pndXTXFkUpPTJKtNiRJVVImkeU0r+nxAJi5M7Q67wbqUmGE2hOz3SYeJ0X4+PEqWxqMekrtO4ZujHHrHn1JKSNLjZt9PMvfyN4H2g+Wr2gEwhTQfcZthewiNziWkbfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781634758; c=relaxed/simple;
	bh=Uzrkh0ozEfXTQqUvOtIuNuhfcWHXtVOrxqD3AJp5mG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEbFXJ8VHiXCv7+AzxJY0y0RYiyYFzX/rNWcYYJ9/sCjvGazxxOOMBFRMPTnPxQJaQewIe7OJgnv+Kg9N1PdkkPtNEQagsgGAcXGywWPGQyuFZoA73IPPCavCQsdL5ScD64DN2orMSES4KIJHQBUawQO8NuLdc1cn1dDtJyjEi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fQiiajnM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3951F00A3A;
	Tue, 16 Jun 2026 18:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781634757;
	bh=MGjZw+d/o+5ru1Pt77ERsKxPNWthmbaT4WRyZXpjqiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fQiiajnMYwDu5iGqZHoSSeF7tl9bpaffgYVeh+jc4fqKFsQ8oqx+N4eEG6sEj2NaQ
	 QvS+wmDaU0Mp+CusfOYdKq8MrpgkYv8eY83N5gGZkZWbUDF3S1ggi7VkyuHzOAzqHZ
	 3g5ZbLueVwWKJtBcTuCs41mle8ksAZsD/+W8QD2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yochai Eisenrich <echelonh@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 324/411] btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak
Date: Tue, 16 Jun 2026 20:29:22 +0530
Message-ID: <20260616145118.376023614@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-266118-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:echelonh@gmail.com,m:dsterba@suse.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,suse.com:email,sweet.security:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A14D6943A4

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/ioctl.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3612,7 +3612,7 @@ static long btrfs_ioctl_space_info(struc
 		return -ENOMEM;
 
 	space_args.total_spaces = 0;
-	dest = kmalloc(alloc_size, GFP_KERNEL);
+	dest = kzalloc(alloc_size, GFP_KERNEL);
 	if (!dest)
 		return -ENOMEM;
 	dest_orig = dest;
@@ -3668,7 +3668,8 @@ static long btrfs_ioctl_space_info(struc
 	user_dest = (struct btrfs_ioctl_space_info __user *)
 		(arg + sizeof(struct btrfs_ioctl_space_args));
 
-	if (copy_to_user(user_dest, dest_orig, alloc_size))
+	if (copy_to_user(user_dest, dest_orig,
+		 space_args.total_spaces * sizeof(*dest_orig)))
 		ret = -EFAULT;
 
 	kfree(dest_orig);



