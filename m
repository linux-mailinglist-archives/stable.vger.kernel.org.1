Return-Path: <stable+bounces-221492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPEILpSlo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-221492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:33:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0C51CDAC4
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4798F304BCE7
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031AF285073;
	Sun,  1 Mar 2026 01:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv/FtBWk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB41284662;
	Sun,  1 Mar 2026 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328399; cv=none; b=gf84iARKaZ7s5uAw0d8LzE02v1cJClnDjk6w1O864hub8ylHv4tLzuNOIBGqI9NSP0R7+iFms2JBXdbwpPtHHDh2igvQjfBWDiukGQkOzzA663OpOkNTd82kFUkcrDB5UD3t9B+M7jSKS+QKNfpDmh6DxpYBo8Vaag3XopsGqMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328399; c=relaxed/simple;
	bh=JgxoWK/vOG+PNIAY8T9kfJhTeLs8QYNGZyeT2PgAriU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lA8h7hVPESaJsXXYJmcDfIG4YaiCl0X5M01LDPda7XgzlWZDkBP4hmh8UA2LkCzr1dNsNpS5wH9v3l1RNJUswmHjd6s/GPVHvfn7vr74QhQI9BA3/7B+ew3NfSX8GPZz3rJwXQ2dTjbzi9SY7Cjb9yqpqEoOHrC2zd1Zw3HeJEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv/FtBWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DF9C19421;
	Sun,  1 Mar 2026 01:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328399;
	bh=JgxoWK/vOG+PNIAY8T9kfJhTeLs8QYNGZyeT2PgAriU=;
	h=From:To:Cc:Subject:Date:From;
	b=Xv/FtBWkXGrIVR6ERdJUEKVxgZ45vo91izQLQwEd9UuGRCkFx5q9NxfedhR11Oj11
	 DBRaZBaIt/2ZGsibtGbnd1hHZMUmhfsvf8Le815U5kuZo54F7g4ZEpsNQzmYLJFWDx
	 COjtP6/eC2pbtM/lLBc0sofbKGsou1hPwpQKJuptHlfsw1cNxhGitCFUnzefM8D5Ni
	 /5XzYCtZgl8EbSP9yI0PVTt4gLcIoq5nhbTkHsZp6uTIkgBEqB0FDEbouI5HuLkfmr
	 I+nHfdVnd+WXAuVQ71FQWL+my41eKN/h0gin9gTxRH+IbVedAVrJ+CFbxeD52kRZpF
	 FA8kdUiktZiZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org
Subject: FAILED: Patch "parisc: kernel: replace kfree() with put_device() in create_tree_node()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:26:37 -0500
Message-ID: <20260301012638.1684034-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221492-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 1A0C51CDAC4
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From dcf69599c47f29ce0a99117eb3f9ddcd2c4e78b6 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Date: Fri, 19 Dec 2025 21:19:26 +0800
Subject: [PATCH] parisc: kernel: replace kfree() with put_device() in
 create_tree_node()

If device_register() fails, put_device() is the correct way to
drop the device reference.

Found by code review.

Fixes: 1070c9655b90 ("[PA-RISC] Fix must_check warnings in drivers.c")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 arch/parisc/kernel/drivers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index 8d23fe42b0cee..809e3c171ad54 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -435,7 +435,7 @@ static struct parisc_device * __init create_tree_node(char id,
 	dev->dev.dma_mask = &dev->dma_mask;
 	dev->dev.coherent_dma_mask = dev->dma_mask;
 	if (device_register(&dev->dev)) {
-		kfree(dev);
+		put_device(&dev->dev);
 		return NULL;
 	}
 
-- 
2.51.0





