Return-Path: <stable+bounces-221802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAaREQSdo2nFIQUAu9opvQ
	(envelope-from <stable+bounces-221802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:57:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFA1CC5E0
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E0832B926B
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D9E2DF126;
	Sun,  1 Mar 2026 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4qiDItc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766192C11D3
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329173; cv=none; b=irnmmwfwcnry+jPTDVvA2hE7T9PAKSNXMgjVLa0f+bpeo7LPlgqSqV8/oV1naTv6uCbFRuJ8j2vzbfgJ7aUe5ZbAKK0OBb8Dc2IPK86xdCrgxtbvI8HkkuPnQ+d5vgXefo7LtbAaUekYHF3UGaYmWCXbdF/eEJpLyQN54EhSd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329173; c=relaxed/simple;
	bh=xLAmtX6CpJX7sWovQGFE/2ZUbEacfdrmX3oqcXISffo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgBo3u9SxkySiOQFn8Hto43ujFpLgwmlyG2kLuLy5jnqzSkvsLsnv3MIeLwp+FXXRTik3ix2aVuFwo6Ea2glONhOss8R/PR1gM8iuBDH5B33Kfslc+zaTnsvTSt/08YGoWRF+BfoOA4G7U6ucELSPcI4g0sQ5pQ9/dtybF5ZYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4qiDItc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78A0C19421;
	Sun,  1 Mar 2026 01:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329173;
	bh=xLAmtX6CpJX7sWovQGFE/2ZUbEacfdrmX3oqcXISffo=;
	h=From:To:Cc:Subject:Date:From;
	b=R4qiDItcFC1/6kThYaF1Ufr/6v6Arja0xBjgUUXRwKktCcYtwRSpRSXDWYzx+5yDi
	 UqC11UgGTx3IxC3X25OGN6TeO+9WNA0l2aLFpZlwjpwdjs0tkJkXoRRy4ejnC4XsUh
	 qgZL3EhZfzFKHHLP1kKEflST7/b7eH7oPkehgL0ooKTMHr1XA6zk4kX+T+21gyJRS8
	 6Unr+/moaCVMsonNizjorvENZbP78rLnmo8BKB4ZBxz5SchTTFAKEZb+TTGcXlLiLN
	 YHl/KY/aVk2R5fggVziWomo/WhNA2//BiNrdEOaQWKXH1zwkfjIpy23nPSTRMJTomq
	 3K1XEcDVubNnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	alexander.deucher@amd.com
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: FAILED: Patch "drm/amdgpu: keep vga memory on MacBooks with switchable graphics" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:39:31 -0500
Message-ID: <20260301013931.1700539-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.freedesktop.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-221802-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,gitlab.freedesktop.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91AFA1CC5E0
X-Rspamd-Action: no action

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 096bb75e13cc508d3915b7604e356bcb12b17766 Mon Sep 17 00:00:00 2001
From: Alex Deucher <alexander.deucher@amd.com>
Date: Mon, 16 Feb 2026 10:02:32 -0500
Subject: [PATCH] drm/amdgpu: keep vga memory on MacBooks with switchable
 graphics

On Intel MacBookPros with switchable graphics, when the iGPU
is enabled, the address of VRAM gets put at 0 in the dGPU's
virtual address space.  This is non-standard and seems to cause
issues with the cursor if it ends up at 0.  We have the framework
to reserve memory at 0 in the address space, so enable it here if
the vram start address is 0.

Reviewed-and-tested-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4302
Cc: stable@vger.kernel.org
Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d35d9719d5668..6a6b334428f6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1068,6 +1068,16 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		adev->mman.keep_stolen_vga_memory = true;
 		break;
+	case CHIP_POLARIS10:
+	case CHIP_POLARIS11:
+	case CHIP_POLARIS12:
+		/* MacBookPros with switchable graphics put VRAM at 0 when
+		 * the iGPU is enabled which results in cursor issues if
+		 * the cursor ends up at 0.  Reserve vram at 0 in that case.
+		 */
+		if (adev->gmc.vram_start == 0)
+			adev->mman.keep_stolen_vga_memory = true;
+		break;
 	default:
 		adev->mman.keep_stolen_vga_memory = false;
 		break;
-- 
2.51.0





