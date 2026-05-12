Return-Path: <stable+bounces-245641-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNYsLCg7A2qh1wEAu9opvQ
	(envelope-from <stable+bounces-245641-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:37:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B11522ADE
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 041DA3165BE3
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF0E3A599C;
	Tue, 12 May 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Encol0+l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6011E3A48C6
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594519; cv=none; b=E55wMriKZr55YjPmXVDN5pyiepCUnDXnOv99JesmlfPgVYg9bUMlLnkNz90sEwZmR6y4R4NrgAQinv2VJAZkPVn/kG7z5ROF4LxPg2xSC1MpL+Oun/mnghRLqN8eGaUshB0A7mMLtbLR61E6mf5KAxZZocTTB1+RnZimxtiH9Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594519; c=relaxed/simple;
	bh=licDrtZsQZG/givd1AJ5YFuQ2ea6Jk3qVBiyBS49u/U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J6t4Lf0VB+fEILTB4+xEIO7gGKqpRLENZbOuyG/Z5LK16VXM41uZg19N8xot2WC9wFox8CE2jVFObW2XCJllbCRR31x5SLu3YI7bEni1cQPTDv2mJ4yWCYyIKd//rX9/HAT7nnwIKF6egZ1NJCyWp42Ccs9QTzu/Nh6jKvVZLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Encol0+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD77C2BCB0;
	Tue, 12 May 2026 14:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594519;
	bh=licDrtZsQZG/givd1AJ5YFuQ2ea6Jk3qVBiyBS49u/U=;
	h=Subject:To:Cc:From:Date:From;
	b=Encol0+l3llQtpMl+rOtgdIi1aZaIWhz2OiJGopakMN0zTReJQ/x5u2yxjvg45NDH
	 kccv97BPPX8ExQ4TTVyUL9qEyuQeWeJpMZO7ZPeXIfjy06y9DLsDrS70goEkUewk9C
	 /lRSiKG5yv9gGGDTVrJsr0+euOsDIgFBtjHPwJHI=
Subject: FAILED: patch "[PATCH] btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which" failed to apply to 5.15-stable tree
To: yochaie@sweet.security,dsterba@suse.com,echelonh@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:58:18 +0200
Message-ID: <2026051218-vitality-aloft-35e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A9B11522ADE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245641-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[sweet.security,suse.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,linuxfoundation.org:dkim,sweet.security:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 973e57c726c1f8e77259d1c8e519519f1e9aea77
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051218-vitality-aloft-35e3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 973e57c726c1f8e77259d1c8e519519f1e9aea77 Mon Sep 17 00:00:00 2001
From: Yochai Eisenrich <yochaie@sweet.security>
Date: Sun, 22 Mar 2026 08:39:35 +0200
Subject: [PATCH] btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which
 can lead to info-leak

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

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a4d715bbed57..b2e447f5005c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2897,7 +2897,7 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 
 	space_args.total_spaces = 0;
-	dest = kmalloc(alloc_size, GFP_KERNEL);
+	dest = kzalloc(alloc_size, GFP_KERNEL);
 	if (!dest)
 		return -ENOMEM;
 	dest_orig = dest;
@@ -2953,7 +2953,8 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 	user_dest = (struct btrfs_ioctl_space_info __user *)
 		(arg + sizeof(struct btrfs_ioctl_space_args));
 
-	if (copy_to_user(user_dest, dest_orig, alloc_size))
+	if (copy_to_user(user_dest, dest_orig,
+		 space_args.total_spaces * sizeof(*dest_orig)))
 		return -EFAULT;
 
 out:


