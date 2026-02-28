Return-Path: <stable+bounces-220286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMNFDhU0o2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02F1C5DCD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2989A314BB7F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02B386541;
	Sat, 28 Feb 2026 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmcQCwOg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4E647DF8D;
	Sat, 28 Feb 2026 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300190; cv=none; b=jalxt6Umym0qeFGVGAR9L/EEWfDWyKXjDQS9gQGxFlzb7UmmEEw/YInjhhwkhAdypIRWq8rNyBsWI6YMRP6DTnYX2cRqCD9ucZvtV4JCaSoAIZqquLCxNl1pZtawJKV+u8rjixXYXUQQCAG+yCw33jt/XNy1eJsvF+QwQZcyBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300190; c=relaxed/simple;
	bh=izAzawfvB3pkXRT8YBMZCsjJaDUIZ/broNuKGcM473A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSv4t3gnFlMw3Glw0lOD+hNFtCA+CqlEnin7HEFk+GY1Sui7nUmADGz6+uqO5YRDHKpISPT/bDNEkWZ8+3D9zkpWn0y9NmyeS7+Taao4U7sGjlcY3QvBhPJJLukFlaC2xVu5NIC060ZYsqICDj79VneJ870s/iAfIrjDq75cQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmcQCwOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BCEC19423;
	Sat, 28 Feb 2026 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300190;
	bh=izAzawfvB3pkXRT8YBMZCsjJaDUIZ/broNuKGcM473A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kmcQCwOgjnUhkILpQywAbYG5Y+bwZPiaDceWVIbUWxEjxypPclFgzPxiu2udzoTYM
	 ICtx2jFpAWkZXhAWl/iOk5zXVlhExqc/vKcSnrLYcrHvWhndzAb0plp3JS9HFUG1GA
	 ViG22tYo4BGkT7ESga28CzwD3LHmPDN5ZUR2+J/iw4n8ue4vJ69u4PEed+Ljdt9iG9
	 L5Fg09dOBwFmdRu2inMLAqFlkgVTKF+psN0L2Hedwp4g+FaROKHRIqcdYGYZoNhHSp
	 3W7IhSvLv5L7L5B9RO4a2vDmjF1PxRQSWjt4ZEWnYsMrpeTwvGm3HhfOzLDpcQH0Mm
	 lDPCB01f4KljA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Manikandan Muralidharan <manikandan.m@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 208/844] drm/atmel-hlcdc: fix use-after-free of drm_crtc_commit after release
Date: Sat, 28 Feb 2026 12:22:01 -0500
Message-ID: <20260228173244.1509663-209-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220286-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8D02F1C5DCD
X-Rspamd-Action: no action

From: Ludovic Desroches <ludovic.desroches@microchip.com>

[ Upstream commit bc847787233277a337788568e90a6ee1557595eb ]

The atmel_hlcdc_plane_atomic_duplicate_state() callback was copying
the atmel_hlcdc_plane state structure without properly duplicating the
drm_plane_state. In particular, state->commit remained set to the old
state commit, which can lead to a use-after-free in the next
drm_atomic_commit() call.

Fix this by calling
__drm_atomic_helper_duplicate_plane_state(), which correctly clones
the base drm_plane_state (including the ->commit pointer).

It has been seen when closing and re-opening the device node while
another DRM client (e.g. fbdev) is still attached:

=============================================================================
BUG kmalloc-64 (Not tainted): Poison overwritten
-----------------------------------------------------------------------------

0xc611b344-0xc611b344 @offset=836. First byte 0x6a instead of 0x6b
FIX kmalloc-64: Restoring Poison 0xc611b344-0xc611b344=0x6b
Allocated in drm_atomic_helper_setup_commit+0x1e8/0x7bc age=178 cpu=0
pid=29
 drm_atomic_helper_setup_commit+0x1e8/0x7bc
 drm_atomic_helper_commit+0x3c/0x15c
 drm_atomic_commit+0xc0/0xf4
 drm_framebuffer_remove+0x4cc/0x5a8
 drm_mode_rmfb_work_fn+0x6c/0x80
 process_one_work+0x12c/0x2cc
 worker_thread+0x2a8/0x400
 kthread+0xc0/0xdc
 ret_from_fork+0x14/0x28
Freed in drm_atomic_helper_commit_hw_done+0x100/0x150 age=8 cpu=0
pid=169
 drm_atomic_helper_commit_hw_done+0x100/0x150
 drm_atomic_helper_commit_tail+0x64/0x8c
 commit_tail+0x168/0x18c
 drm_atomic_helper_commit+0x138/0x15c
 drm_atomic_commit+0xc0/0xf4
 drm_atomic_helper_set_config+0x84/0xb8
 drm_mode_setcrtc+0x32c/0x810
 drm_ioctl+0x20c/0x488
 sys_ioctl+0x14c/0xc20
 ret_fast_syscall+0x0/0x54
Slab 0xef8bc360 objects=21 used=16 fp=0xc611b7c0
flags=0x200(workingset|zone=0)
Object 0xc611b340 @offset=832 fp=0xc611b7c0

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Reviewed-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Link: https://patch.msgid.link/20251024-lcd_fixes_mainlining-v1-2-79b615130dc3@microchip.com
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index ec1fb5f9549a2..e55e88d44e829 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -1160,8 +1160,7 @@ atmel_hlcdc_plane_atomic_duplicate_state(struct drm_plane *p)
 		return NULL;
 	}
 
-	if (copy->base.fb)
-		drm_framebuffer_get(copy->base.fb);
+	__drm_atomic_helper_plane_duplicate_state(p, &copy->base);
 
 	return &copy->base;
 }
-- 
2.51.0


