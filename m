Return-Path: <stable+bounces-212535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJBSHJI0eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:08:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 082E6A5259
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:08:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7C5C32EB2A0
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAE9305057;
	Wed, 28 Jan 2026 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I3IyOU2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767DB30F548;
	Wed, 28 Jan 2026 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615845; cv=none; b=r+xqDzkLjtJ0s532syaQBRhxxsT19PoKxJLMjIdXfyV9ar/7l6SNJ1E0dzkr+TVa/hMNM9hV6jOy6gGR//sCHoaJ97I5oFuuI2P9iyb59sI7S2snv0UeoGaAJ8hZZt1V3YbJXCR0EqzLoeOvQn4ZJBFb1vSMsAsjrP5xd7AzSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615845; c=relaxed/simple;
	bh=286HZWHnw2KVQvpZ2c4JbZPlK/VmRtO3KFtskuCyI3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6q9Qg8QMhp9v2ViNlg+cWkw5FDcTHt5Uzv3ijMhvvATvTRggxAwpaPNFfFCWoGDvZBw2Y8cpeB5dnfevFXMcWT//BCFMD24aG5J35BjuoFZp9RsyR7cIBj8YksXJ9CBbemuU1r98DQ2J5c7cuWvYHiAP3zjajdl6i6Yl9qJoCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I3IyOU2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A773C4CEF1;
	Wed, 28 Jan 2026 15:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615844;
	bh=286HZWHnw2KVQvpZ2c4JbZPlK/VmRtO3KFtskuCyI3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3IyOU2IT+NE23q6+zvWaBT/L3cdnsdbtdQ4S/kqAvjaKn16XlISSCRgJ6Maw/JQ/
	 P+onAQ2+RvXywO95fFDx+LOCDGU1hCrud/aYcjrV4lGPCqULpFDrWRnA04qSsTniu3
	 dFtq2OMOhOJeOPoi+z5ayFAiK5yn7Ohzot9mypcQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 129/227] drm/amd/pm: Fix si_dpm mmCG_THERMAL_INT setting
Date: Wed, 28 Jan 2026 16:22:54 +0100
Message-ID: <20260128145349.104092796@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212535-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,amd.com,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 082E6A5259
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 4ca284c6d15dda481f714e3687a1d5fb70b3bf5c ]

Use WREG32 to write mmCG_THERMAL_INT.
This is a direct access register.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 2555f4e4a741d31e0496572a8ab4f55941b4e30e)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 3a9522c17fee3..70499bf50ad47 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7600,12 +7600,12 @@ static int si_dpm_set_interrupt_state(struct amdgpu_device *adev,
 		case AMDGPU_IRQ_STATE_DISABLE:
 			cg_thermal_int = RREG32_SMC(mmCG_THERMAL_INT);
 			cg_thermal_int |= CG_THERMAL_INT__THERM_INT_MASK_HIGH_MASK;
-			WREG32_SMC(mmCG_THERMAL_INT, cg_thermal_int);
+			WREG32(mmCG_THERMAL_INT, cg_thermal_int);
 			break;
 		case AMDGPU_IRQ_STATE_ENABLE:
 			cg_thermal_int = RREG32_SMC(mmCG_THERMAL_INT);
 			cg_thermal_int &= ~CG_THERMAL_INT__THERM_INT_MASK_HIGH_MASK;
-			WREG32_SMC(mmCG_THERMAL_INT, cg_thermal_int);
+			WREG32(mmCG_THERMAL_INT, cg_thermal_int);
 			break;
 		default:
 			break;
@@ -7617,12 +7617,12 @@ static int si_dpm_set_interrupt_state(struct amdgpu_device *adev,
 		case AMDGPU_IRQ_STATE_DISABLE:
 			cg_thermal_int = RREG32_SMC(mmCG_THERMAL_INT);
 			cg_thermal_int |= CG_THERMAL_INT__THERM_INT_MASK_LOW_MASK;
-			WREG32_SMC(mmCG_THERMAL_INT, cg_thermal_int);
+			WREG32(mmCG_THERMAL_INT, cg_thermal_int);
 			break;
 		case AMDGPU_IRQ_STATE_ENABLE:
 			cg_thermal_int = RREG32_SMC(mmCG_THERMAL_INT);
 			cg_thermal_int &= ~CG_THERMAL_INT__THERM_INT_MASK_LOW_MASK;
-			WREG32_SMC(mmCG_THERMAL_INT, cg_thermal_int);
+			WREG32(mmCG_THERMAL_INT, cg_thermal_int);
 			break;
 		default:
 			break;
-- 
2.51.0




