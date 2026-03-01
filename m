Return-Path: <stable+bounces-222337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FjxHC+ko2mRIwUAu9opvQ
	(envelope-from <stable+bounces-222337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:27:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A541CD91C
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43877355F01C
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C85308F3E;
	Sun,  1 Mar 2026 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dnf7i1NI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AD02C08AD;
	Sun,  1 Mar 2026 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330629; cv=none; b=rb45gHunHCxsZK0P3Y1FOdMHSj3DtuPRuSDRbA/BvE8hzvXyjil8JDXDUGGqUnlbyOTTPFOLNYXIIpq7K4oZmjD4Npd3qTsHsgKzhUbLQ3YSqt/I+Su8jHvy6IPbtBnwadf5xzKDeDLzQgxGmu3PkCJ9ijhhJLx5urhvvC2E5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330629; c=relaxed/simple;
	bh=L0960m72NnIWVCruNmRwFmFJT+Ql0lIQBjfJvxICOEI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pCKoMp3Zs3NCovRqbLtBSjZ5aZ/AqIQIHwP2id7AE2pngFnEH4J4na0RZ26D875awquxbndDeRaYxR1b5NNEohUfHorbVh1ZoEnePIO5ZRTcLCfUafNGS604v5ux7O+geefys+G6h4V42OrNHtCkj3Wgt07Cwva2jIuIUwOH9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dnf7i1NI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8378C19421;
	Sun,  1 Mar 2026 02:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330629;
	bh=L0960m72NnIWVCruNmRwFmFJT+Ql0lIQBjfJvxICOEI=;
	h=From:To:Cc:Subject:Date:From;
	b=Dnf7i1NIDiBotp8ztL7UE1pvVVWhDPw6zQBsZLydo0bLZZ4ehUJBBdoGR1b+RoTtj
	 Wb6W5QrihfG46ChMUWLkTbkX1wcApzrs0L6VI5YKkqviQNkVOEmYHvRO7JXYIynED0
	 ArgSEKAXzBIdKUi7+osTJu1RycJ+GFqQgqjL89sx0s6CJck7+cGWNhoUwWREn4svm2
	 CuneyBEqKn+rmmdCPalR1HBtp9pDDXYGqPUZBd8IsImULqK6tJll5RWgIus3tC+7f2
	 2ldeRinl/w9wmBVBKY1bL7Omuo8In+lFAzDGkC1yMW6CMZhgdnKfQwXDzCBT++6BVs
	 bimX35jCzeXeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	lihaoxiang@isrc.iscas.ac.cn
Cc: Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org
Subject: FAILED: Patch "parisc: kernel: replace kfree() with put_device() in create_tree_node()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:03:47 -0500
Message-ID: <20260301020347.1731933-1-sashal@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222337-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C2A541CD91C
X-Rspamd-Action: no action

The patch below does not apply to the 5.10-stable tree.
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





