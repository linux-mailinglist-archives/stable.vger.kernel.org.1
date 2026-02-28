Return-Path: <stable+bounces-220510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OzCCzI5o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:51:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EA71C6549
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93CB33223904
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2363CAF78;
	Sat, 28 Feb 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SL0NYL4O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900613CAF6D;
	Sat, 28 Feb 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300394; cv=none; b=iPJUnR2WuTbJXyGOiz9RMSog9xjYQRuP3IrSpmQtL1BJIKcnA9dcIdfykIT15Uz2j9nQwm54uymcKqKsA+JYwIhtQH4ckRm2jLOWb+ReejXrxSFmtumjMuD/ZWLasXiEopLMyQiMUs/GIrlCYXFON+QiZlJxtMGbQvtDqQf+OWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300394; c=relaxed/simple;
	bh=Z0zHhq6U1lG+GvEXgpJNjSHVhFdAXGkDjCx+HiB5Zhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkzlE9fXUYJVTykAjSn4cejSuk4ZzN103BQ7e0oGDebe9zgom/htO5vAcQVYt+8HCfiTObR5dI+/13s6wJv7hNk66+DuiA+Y/kS70uSY1Ej96CrZEgJJT2QDvhEINE4bOqIm3ypN6uPVSI6ecgrpSJWOoW4kP64uB6E14E5zeXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SL0NYL4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D439FC116D0;
	Sat, 28 Feb 2026 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300394;
	bh=Z0zHhq6U1lG+GvEXgpJNjSHVhFdAXGkDjCx+HiB5Zhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SL0NYL4Ou4PkS9p87WUycS5+BfI1Ix3n1Zl7M+XmVsfKZ7P+XzIioH/c7jam/RT1E
	 64XTOdvAyAInjCF+u8HX5dKDdUBrGNuKYuU+y3KZbZ4ELf5e+FMPvZj7eepO7kjZtN
	 6f0z3oz/XrZXLDEWGLzCRE7VDiGEUVtbVczqIpzhajfK7LwOhc5w07BXrnMVlCov+O
	 olzl5FFZisQicUNsG4LcsAKAoH5cUa0uJPiO5BxdZJMwWzemsO3T6faxt+DaqF1NoL
	 XtbLf6O3JTLQ5WykCvt9HeAak73JSZtZHW5vSgfqEzpi6ExvPGUF1DluHDJkouz3Uo
	 Z6BrDB6uzgDWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: decce6 <decce6@proton.me>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 431/844] drm/amdgpu: Add HAINAN clock adjustment
Date: Sat, 28 Feb 2026 12:25:44 -0500
Message-ID: <20260228173244.1509663-432-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220510-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 84EA71C6549
X-Rspamd-Action: no action

From: decce6 <decce6@proton.me>

[ Upstream commit 49fe2c57bdc0acff9d2551ae337270b6fd8119d9 ]

This patch limits the clock speeds of the AMD Radeon R5 M420 GPU from
850/1000MHz (core/memory) to 800/950 MHz, making it work stably. This
patch is for amdgpu.

Signed-off-by: decce6 <decce6@proton.me>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 695432d3045ff..2d8d86efe2e73 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3464,6 +3464,11 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 			max_sclk = 60000;
 			max_mclk = 80000;
 		}
+		if ((adev->pdev->device == 0x666f) &&
+		    (adev->pdev->revision == 0x00)) {
+			max_sclk = 80000;
+			max_mclk = 95000;
+		}
 	} else if (adev->asic_type == CHIP_OLAND) {
 		if ((adev->pdev->revision == 0xC7) ||
 		    (adev->pdev->revision == 0x80) ||
-- 
2.51.0


