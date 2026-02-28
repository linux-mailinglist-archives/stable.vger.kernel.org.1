Return-Path: <stable+bounces-220132-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P4fLx8so2mF+AQAu9opvQ
	(envelope-from <stable+bounces-220132-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D760A1C5394
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8362F30876BD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA5F481AAE;
	Sat, 28 Feb 2026 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAdVC39m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947E481AA0;
	Sat, 28 Feb 2026 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300042; cv=none; b=FyjyyXjUsJ04D4yELF3SBxAIrNZFPHHjTKTboBC2DMM4F/74TrZvHmzQUu85iKMrvzhTNQdo7mkAcONq9BFMp2EV16SxAzeFlyS+P08OLNnWODO+dABaK1cWBi524pH3JPm5HXw88uy1avNpJVZ7JXQv+yK+11YlbMDwgWvoX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300042; c=relaxed/simple;
	bh=WQb3T0/L1+8anuTwixTyTOgkjYPaAbTKREJMPMmfGzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2bHgNjBzOGKD1YwSuvfzNW8/0xUA9CR9gC9+ZfAEK/KvUODAft3mzn56LuC9ahQrEdCHLq9H4/AFSe/wykIoiyHd/qH7xds0VuXQ4mpqdoXZ1trmzwxlaqEFn1lTLRuIHfy3wAi5yXHOHOsciWp+vKKLU6wkE0PSgvYmuQYwkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAdVC39m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A70CC4AF09;
	Sat, 28 Feb 2026 17:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300042;
	bh=WQb3T0/L1+8anuTwixTyTOgkjYPaAbTKREJMPMmfGzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAdVC39mG+vnRYTJ0VEeRuWaIuXZb3DVzG4EEFCIttf6rQqoIXCFway8XK6KoH2MR
	 yaQ72p+18VB84bMtUG4cu0c5nuP+aJf7MXgq/YDq5QnuLdTraj2pMrUGvCUcGBNwNi
	 08MbKP/ut45CcuSw4co6It+iRk4OdHO/sVaAdvMBYHlokhgRnhUCRZ0WghdaNYuFOx
	 BjNFwDCL/DU5DhBbBAZtZ134S8WNRbLZCsjorytVRdlXygAsUlEtbniNrOgvUEBKwn
	 GF3EJqQQj54GRwr4WYqpuSj24fcJ8956VsnrZ61/jR7o3jQrDGPk3Q4K+xLPpPU2B/
	 vh+5ZCNb61mmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 054/844] gfs2: fiemap page fault fix
Date: Sat, 28 Feb 2026 12:19:27 -0500
Message-ID: <20260228173244.1509663-55-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220132-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D760A1C5394
X-Rspamd-Action: no action

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit e411d74cc5ba290f85d0dd5e4d1df8f1d6d975d2 ]

In gfs2_fiemap(), we are calling iomap_fiemap() while holding the inode
glock.  This can lead to recursive glock taking if the fiemap buffer is
memory mapped to the same inode and accessing it triggers a page fault.

Fix by disabling page faults for iomap_fiemap() and faulting in the
buffer by hand if necessary.

Fixes xfstest generic/742.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/inode.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index b6ed069b34872..4d65e4a752626 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -2192,6 +2192,14 @@ static int gfs2_getattr(struct mnt_idmap *idmap,
 	return 0;
 }
 
+static bool fault_in_fiemap(struct fiemap_extent_info *fi)
+{
+	struct fiemap_extent __user *dest = fi->fi_extents_start;
+	size_t size = sizeof(*dest) * fi->fi_extents_max;
+
+	return fault_in_safe_writeable((char __user *)dest, size) == 0;
+}
+
 static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		       u64 start, u64 len)
 {
@@ -2201,14 +2209,22 @@ static int gfs2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	inode_lock_shared(inode);
 
+retry:
 	ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
 	if (ret)
 		goto out;
 
+	pagefault_disable();
 	ret = iomap_fiemap(inode, fieinfo, start, len, &gfs2_iomap_ops);
+	pagefault_enable();
 
 	gfs2_glock_dq_uninit(&gh);
 
+	if (ret == -EFAULT && fault_in_fiemap(fieinfo)) {
+		fieinfo->fi_extents_mapped = 0;
+		goto retry;
+	}
+
 out:
 	inode_unlock_shared(inode);
 	return ret;
-- 
2.51.0


