Return-Path: <stable+bounces-98647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACF09E4990
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B4631880318
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E0F207652;
	Wed,  4 Dec 2024 23:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSP0p+LC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14817218820;
	Wed,  4 Dec 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733355005; cv=none; b=Q29B+lnEaFycEmELwgljHW2ez5TsnhfUJ6BdOs0aiPqQfbrMFBsh7Vu+R8RMJBT31e0dfhmiCCNrom/6G51dgydp1VWafaUnL0NRpdtgqWZrs6CrQZqOli83NRFnsoKM0NuK+7+xrZ9lrXKnQWuOxRH3F/AwpyqGPkzBu/Hnz8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733355005; c=relaxed/simple;
	bh=mmK9+h4dECffnmjJN4de6/rK1ndlXYUDT0C55JvoVAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axKUcR84rluRb2Rd2H2rhZeE5FB38SN3MMtnsqoRcCk+o2lfxC9LFGdeAJXnxBmRNJkIEnYxFjyDFf/kHQVR0/Pl1eHzmL4StbCQFrcSaKgvAA47Vv7DnJcpWGMcbHlLx9Uhz5/VHZZYyMe1dsqoeagEPER7mhuR22FoduNSzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSP0p+LC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDADC4CED2;
	Wed,  4 Dec 2024 23:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733355004;
	bh=mmK9+h4dECffnmjJN4de6/rK1ndlXYUDT0C55JvoVAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QSP0p+LCeTiihnhfyYI21PQSJ4E1c9Vbd50nB8fU/5HmV6+MMmeJ4jdsmT3vmWgSO
	 ZXExrhlL0OApfHkbeH/JmjXXr92BiQBzSMjw4JIOi2JWzRKJnPdFR1WxiBf4BRP9PG
	 HEX8SMiHqlC3/21GMB3Cfp9itrJDIJEcTgLi1+qT4SuVRyaReI6vlfrhV3osDkaMw7
	 /hTpb3djUfEbZppMQIMXjfzHl6MQW2ysamyTozcJ0UdHoZG/t7d5tdRf2kVS09Id16
	 8nQX9r9PwHz+rHJQYKobB2iIeL47J23Cym/Ir9RXYQLkxcnI9+sdb6NoIFHdUQLsDH
	 06wW+LsCAyNxQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>,
	Tova <blueaddagio@laposte.net>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	end.to.start@mail.ru,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 09/10] ASoC: amd: yc: Add quirk for microphone on Lenovo Thinkpad T14s Gen 6 21M1CTO1WW
Date: Wed,  4 Dec 2024 17:18:07 -0500
Message-ID: <20241204221820.2248367-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221820.2248367-1-sashal@kernel.org>
References: <20241204221820.2248367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.63
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <ukleinek@debian.org>

[ Upstream commit cbc86dd0a4fe9f8c41075328c2e740b68419d639 ]

Add a quirk for Tova's Lenovo Thinkpad T14s with product name 21M1.

Suggested-by: Tova <blueaddagio@laposte.net>
Link: https://bugs.debian.org/1087673
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
Link: https://patch.msgid.link/20241122075606.213132-2-ukleinek@debian.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index f87333cb82e06..369a8618b705a 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -220,6 +220,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21M1"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


