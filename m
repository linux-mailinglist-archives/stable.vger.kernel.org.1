Return-Path: <stable+bounces-247798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FLTEdIyB2qQswIAu9opvQ
	(envelope-from <stable+bounces-247798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:50:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A392D551B13
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95D46300CBF1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AAA38C400;
	Fri, 15 May 2026 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBV4K03M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489E29BD88
	for <stable@vger.kernel.org>; Fri, 15 May 2026 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778856509; cv=none; b=QMaiCOA1w7K71Gf3DSXntiH1UhRcckVn00KkzsKSsDUov7Vb9zbunOAAk5EGOOwQL4Owy6wDhPtC1ewSvbY/ZV6Mq3NFTCp9dyeF0xydVUrhEQKV6VztGmUIU3ScDD1jrnHCa+Yy9nCXr6oGdqsJay9npasMPUiYeTTONDsIqG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778856509; c=relaxed/simple;
	bh=B/RkUyzlnd6DJ0wbKlw5s7CVN5dR5MAVDriAAwel4Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NohpT1fYSk2lBzaBSAmBxWL0AxLAg3DV8JCgYz8L5VL43fgluQOg/ze4+Ir0xx4ms0+kNAzj1auNpq7SYWP+5nhW1HSgucUc2SYrbvXEtbV9sZxRfpPdNPDCjonJ8BpcKE5nGNlnewq7XBh0DBvzbYeUilBP7CBzMPO2IPrIfQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBV4K03M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDC7C2BCB0;
	Fri, 15 May 2026 14:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778856509;
	bh=B/RkUyzlnd6DJ0wbKlw5s7CVN5dR5MAVDriAAwel4Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VBV4K03MStudOdkmFhm77T0sArn2XzY3Jd2yCxL8ans5X/1dzxWbnq9aiXnhIuqTd
	 YusXry6ETRaZKglOsdT2JO64bOHLmBsoohi7UfRAsNZjd5NtZk3NjHruFLFKo6wIpQ
	 ILNpUK8fiQr3LnfilJcPiFPKmp28yfayjiLe9PFegt5BqWz7DFiu6L9nzJGcOPwBVP
	 MnwUlouQM8io/nlqNsRRd+c89cDyD2ps+UPDeRgbEZ+PTlzqEwW31kYOX6ic3IvYwu
	 wBes2IaZ0njs3w/itEkkpxDy6TdaRt+8kDGgtKXOpFRU4htZWQ7j/UAQVdMdwfECbl
	 sRarGUiDKeMLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yochai Eisenrich <yochaie@sweet.security>,
	Yochai Eisenrich <echelonh@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] btrfs: fix btrfs_ioctl_space_info() slot_count TOCTOU which can lead to info-leak
Date: Fri, 15 May 2026 10:48:27 -0400
Message-ID: <20260515144827.3249028-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051218-vitality-aloft-35e3@gregkh>
References: <2026051218-vitality-aloft-35e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A392D551B13
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[sweet.security,gmail.com,suse.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247798-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sweet.security:email]
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
index 388eee966a7a5..d56d6144707bb 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3612,7 +3612,7 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 		return -ENOMEM;
 
 	space_args.total_spaces = 0;
-	dest = kmalloc(alloc_size, GFP_KERNEL);
+	dest = kzalloc(alloc_size, GFP_KERNEL);
 	if (!dest)
 		return -ENOMEM;
 	dest_orig = dest;
@@ -3668,7 +3668,8 @@ static long btrfs_ioctl_space_info(struct btrfs_fs_info *fs_info,
 	user_dest = (struct btrfs_ioctl_space_info __user *)
 		(arg + sizeof(struct btrfs_ioctl_space_args));
 
-	if (copy_to_user(user_dest, dest_orig, alloc_size))
+	if (copy_to_user(user_dest, dest_orig,
+		 space_args.total_spaces * sizeof(*dest_orig)))
 		ret = -EFAULT;
 
 	kfree(dest_orig);
-- 
2.53.0


