Return-Path: <stable+bounces-222002-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EJGMCGro2nfJQUAu9opvQ
	(envelope-from <stable+bounces-222002-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:57:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EE21CE179
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AC5533981FE
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6B42FF67A;
	Sun,  1 Mar 2026 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnMGn8eT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6952DB7B5;
	Sun,  1 Mar 2026 01:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329666; cv=none; b=llezP6peoZGPJchBVfF50gwYd6y1vVbWiEHpuVYRPY+HvX4QL1++wFov2W9X2r4bPUqkJvjKbkixNTb6fI7twLcrC3lgImHqj+K0Zx3AOUxLu1j6sTrFU342bmJGnSZz22CUBuKStFzUVuyDL5nAFQq5QwHNEkuGwGHfELUBb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329666; c=relaxed/simple;
	bh=gu8+Qxm8tb3qoxOf8pBUFsp5jI64pyZL1MssQ1dG6SM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHqVQevTRJ6dCx+elAs91rbdhZ/8iFbgi3skyscK8jl6pCkJBB1tBSmPmRmYDMiB1yjLWeOFwVwU/Gn3Ou6KDMq9Ct1jWC2jnh6uJA1Q4HKaZOK4+99AvC6Hhz4yxs7A5/Yc9dO6GvWCeWMwOOIh2FYi0zB54iKlpKReDwi6FlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnMGn8eT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3DAC19425;
	Sun,  1 Mar 2026 01:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329666;
	bh=gu8+Qxm8tb3qoxOf8pBUFsp5jI64pyZL1MssQ1dG6SM=;
	h=From:To:Cc:Subject:Date:From;
	b=pnMGn8eTGuZ+wmln+kDnlf4cZ/EkWxg7XrGRY8fsvWqE3bLs8S9O9vQgDZXVkRGO3
	 dzVNeQGaQFtlEMzIJ7J7dIPJ1/4QJi1EplUGQgEtkXEtGL8Unb35QEbVItlfSUnriB
	 +2RU+jzOgsEaXdusBa0y54Dj0iRM7xP8lRFbFI29yyYEKJL/YFarrPT3tdpONOT7Bv
	 tMvFPXrfGh7M+oAGa+Xjy0wBtuU+XdIjpD4ktptDs/F84a74WI2SKdDjHMVmXx6KlE
	 YhbMC+lufRzdxX0ACs1BU30a0rVK84Xo/YaDMmkY5jj0fz2Ik1yHf4eUScKVP4wuxB
	 5L7TNvEP2q2pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	a.vatoropin@crpt.ru
Cc: Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "fbcon: check return value of con2fb_acquire_newinfo()" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:47:44 -0500
Message-ID: <20260301014744.1711703-1-sashal@kernel.org>
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
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org,lists.freedesktop.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222002-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 56EE21CE179
X-Rspamd-Action: no action

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 011a0502801c8536f64141a2b61362c14f456544 Mon Sep 17 00:00:00 2001
From: Andrey Vatoropin <a.vatoropin@crpt.ru>
Date: Wed, 17 Dec 2025 09:11:05 +0000
Subject: [PATCH] fbcon: check return value of con2fb_acquire_newinfo()

If fbcon_open() fails when called from con2fb_acquire_newinfo() then
info->fbcon_par pointer remains NULL which is later dereferenced.

Add check for return value of the function con2fb_acquire_newinfo() to
avoid it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d1baa4ffa677 ("fbcon: set_con2fb_map fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/core/fbcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 34ea14412ace1..36e380797a9e4 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1068,7 +1068,8 @@ static void fbcon_init(struct vc_data *vc, bool init)
 		return;
 
 	if (!info->fbcon_par)
-		con2fb_acquire_newinfo(vc, info, vc->vc_num);
+		if (con2fb_acquire_newinfo(vc, info, vc->vc_num))
+			return;
 
 	/* If we are not the first console on this
 	   fb, copy the font from that console */
-- 
2.51.0





