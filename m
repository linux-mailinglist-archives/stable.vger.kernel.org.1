Return-Path: <stable+bounces-213313-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G/sN0dmgmlOTgMAu9opvQ
	(envelope-from <stable+bounces-213313-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 22:19:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D5DEC87
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 22:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ABF4303CC00
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 21:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC37B27A123;
	Tue,  3 Feb 2026 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAF3JvfP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7079C18024
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 21:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770153475; cv=none; b=cVWpfjKj3QL3/uQMnCeRZTb9g4iP/aiXkIY0f5CbwNyo+Ii6hgeaPTMF/XjZdzkHp60Z21kFac0OTBxPdxsKrfvwI7c7FElkC9LX9B+urGA0aJdu4SuLwl7wbxvzkm0nXgvZmIgN9LnJWDsOjfZvoknJjT5wAyIt8EiqE6nG8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770153475; c=relaxed/simple;
	bh=BchQJW8nIJ3VlDkW6bk9LPUrh+GzVALz7YkO4oSFdQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4vN04xry99BQkGo4jvc9k5/0Yi9xQ9Pw3VqEcePQhoh+nV2gwQTdQjxWevPJrlnpbaQmFtsilbaaJ4U61iEypV+bqssdqBmaMefVG1tnJZED1+7vdHjyUaOPQH6so4sJOSJQWBEgZQIMyo+qXnpDeJMk6R6xY0aarRDSZXMyOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAF3JvfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D757C116D0;
	Tue,  3 Feb 2026 21:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770153475;
	bh=BchQJW8nIJ3VlDkW6bk9LPUrh+GzVALz7YkO4oSFdQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CAF3JvfPYS8kmg9bR5SYJI7b9+vNj0c91n7XEDX7YzzZj3dvDB6eRo2DomPxxSQ5b
	 r2VZ0pNoEJ9pj7H8iKr0bOVJYn1yhh+RZoyhkowhn9F5HhFpe69tmI4igRP/Dyvdcr
	 Vo1jFSHfn7NK/mGExYv48XGcPmvc1A3kIyWisK8bONN+nDQqpavOce6SFRxbm5n3Md
	 TWGsq40j8H2/jFVvYvwXv2Hjxqv9dB8cIhSq/E2H51zZSUfou0lxeUJlrEzYF0S6Kn
	 cvUecUWSmq+Qy2aAug3GX94wNDsyUBhxfYj6fJbpucqnHHiYnXIhQJa4zDU2eySxyB
	 xy/5dLcajAzJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Akhil P Oommen <akhilpo@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/msm/a6xx: fix bogus hwcg register updates
Date: Tue,  3 Feb 2026 16:17:52 -0500
Message-ID: <20260203211752.1413731-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020301-scam-headband-6c32@gregkh>
References: <2026020301-scam-headband-6c32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213313-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 111D5DEC87
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit dedb897f11c5d7e32c0e0a0eff7cec23a8047167 ]

The hw clock gating register sequence consists of register value pairs
that are written to the GPU during initialisation.

The a690 hwcg sequence has two GMU registers in it that used to amount
to random writes in the GPU mapping, but since commit 188db3d7fe66
("drm/msm/a6xx: Rebase GMU register offsets") they trigger a fault as
the updated offsets now lie outside the mapping. This in turn breaks
boot of machines like the Lenovo ThinkPad X13s.

Note that the updates of these GMU registers is already taken care of
properly since commit 40c297eb245b ("drm/msm/a6xx: Set GMU CGC
properties on a6xx too"), but for some reason these two entries were
left in the table.

Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
Cc: stable@vger.kernel.org	# 6.5
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Fixes: 188db3d7fe66 ("drm/msm/a6xx: Rebase GMU register offsets")
Patchwork: https://patchwork.freedesktop.org/patch/695778/
Message-ID: <20251221164552.19990-1-johan@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
(cherry picked from commit dcbd2f8280eea2c965453ed8c3c69d6f121e950b)
[ Applied fix to a6xx_gpu.c instead of a6xx_catalog.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 4654c0f362c7d..6666d8f6c17a6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -690,8 +690,6 @@ const struct adreno_reglist a690_hwcg[] = {
 	{REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111},
 	{REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555},
 	{REG_A6XX_GPU_GMU_AO_GMU_CGC_MODE_CNTL, 0x20200},
-	{REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL, 0x10111},
-	{REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL, 0x5555},
 	{}
 };
 
-- 
2.51.0


