Return-Path: <stable+bounces-105444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F21F9F979B
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 18:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DC8A161C59
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BA4222D5C;
	Fri, 20 Dec 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwT/xf/w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2021B1BC;
	Fri, 20 Dec 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734714721; cv=none; b=plsOGKSmcyYTdJrN7hU1doU/cgMSCgtth1M3vf33C4tFn6yeHEyMS541R4tTB8G0b8ew+WTT7thhN78hD0C3OnYlP9G8Ct1SHtgKTMCCFTYYMs+8MQXYWGM3UbsEtTFo5wJc3eKQn/h7TqQgQPoz79zmfN3jrIttAc3wHgkbW9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734714721; c=relaxed/simple;
	bh=33m6lb2+l5zflSdPhD7G2Tp7gorctVLffdLujWOBBLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=STObhpSG7Whmg4hlmIG1S+W0nMRHtsE0dgcKUNSkGYdXYiGyg6+GiO3L4Ey8F6nTshy1OVcdkbzS+NPSNB1i5q1gmWPVAQ60uPKPkkk1WJbzANQl8Px4pW0tbv+7z2+ILYAn8n3fGy1NyInidG8TYSzXpPYfGy7nyFvEwpRLlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwT/xf/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35B0C4CED7;
	Fri, 20 Dec 2024 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734714721;
	bh=33m6lb2+l5zflSdPhD7G2Tp7gorctVLffdLujWOBBLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pwT/xf/wY96ABKpDMcRzKnAIf3Rr3hX+iGAOAy5XVxW79fRSUU74phsmltTBHZlHC
	 Gv3Z9WvOHCg4uelIY0G21TfSSSVvX9Cl73vtOKbS+2A2jh0E2HrBBEqsvoCSuQiK0S
	 UzAXU9iQjADGsbZqJDn4pq/1k92Kb8Biu3xtHjcCiLpc8ab+9rYLOPRY95EddvVgG/
	 uA9AnYVgwS19rPOk4mDEyCXd1IHhztLjj50fwmqRO4+y5moksWv4ExfR6qpCBui2o6
	 UUx+HqG+mmQj+pB+zOy6MN2SEmVJlXlvAH17g7YuL1zipr4bo2gzukr/TICDlm7m00
	 8dC3TSx1VtfbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vasiliy Kovalev <kovalev@altlinux.org>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kailang@realtek.com,
	sbinding@opensource.cirrus.com,
	simont@opensource.cirrus.com,
	josh@joshuagrisham.com,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 12/29] ALSA: hda/realtek: Add new alc2xx-fixup-headset-mic model
Date: Fri, 20 Dec 2024 12:11:13 -0500
Message-Id: <20241220171130.511389-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220171130.511389-1-sashal@kernel.org>
References: <20241220171130.511389-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.6
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

[ Upstream commit 50db91fccea0da5c669bc68e2429e8de303758d3 ]

Introduces the alc2xx-fixup-headset-mic model to simplify enabling
headset microphones on ALC2XX codecs.

Many recent configurations, as well as older systems that lacked this
fix for a long time, leave headset microphones inactive by default.
This addition provides a flexible workaround using the existing
ALC2XX_FIXUP_HEADSET_MIC quirk.

Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
Link: https://patch.msgid.link/20241207201836.6879-1-kovalev@altlinux.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5b518a44b78a..e982b34ebe54 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -11183,6 +11183,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC255_FIXUP_ACER_HEADPHONE_AND_MIC, .name = "alc255-acer-headphone-and-mic"},
 	{.id = ALC285_FIXUP_HP_GPIO_AMP_INIT, .name = "alc285-hp-amp-init"},
 	{.id = ALC236_FIXUP_LENOVO_INV_DMIC, .name = "alc236-fixup-lenovo-inv-mic"},
+	{.id = ALC2XX_FIXUP_HEADSET_MIC, .name = "alc2xx-fixup-headset-mic"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.39.5


