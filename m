Return-Path: <stable+bounces-98637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3BD9E4974
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037D916A7DF
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C1821764E;
	Wed,  4 Dec 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED4SPubN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CA6217644;
	Wed,  4 Dec 2024 23:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354962; cv=none; b=UDgVcnAk44acbIlipYF/iM0bZcvZYDwvtRXqAvi6VDypUI2vofMEzWnU8e2hzrUtxAfnQD6/E8sa808QKg+NRf4JsqUegKRxujVOsvLU5lqi6sCiU0KjwnkaCf2EKfcG/HbetrD2T7vDIHp5Zos6GAUWaiX6I9ZdtNozdvsaQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354962; c=relaxed/simple;
	bh=sDPMRHK/4/GpMjPlWqGGG2sfr30/QGnzLaU7af6lU5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C9H8tyRR0GqZQpAnntBFrLkZu64s7c6t8DlY77ZyP9072K95UURelgRpdLFnqNcQ6/7M76iJF8APuuKPvJyy5ehIFyap2V70w3dwEkRTngswwpZAhsvq8sWnT3he+EshV4vkqi4T1+WdoV8HFA/RjJnHydq0ucGt1i6FnPEDoVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED4SPubN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC7EC4CED2;
	Wed,  4 Dec 2024 23:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354962;
	bh=sDPMRHK/4/GpMjPlWqGGG2sfr30/QGnzLaU7af6lU5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ED4SPubNzbk9W0oNYV8hs2/ZlfdHkI2f/vFvf3Jzlb1SDW1y1dS9VFbVaaonOsjF6
	 hvw6TlpbNT6NbbvLlKeeWmY0E8j9GhC4Q7Ti+Ls71OQJ0IPmEgmHfgm5qOMMYV64Eq
	 Q0UKNQPFxcQWNCHtDv8AX+Csc3mCm2DpCbxL6uF2Faa01XMFK4Y11t6Pnw8PI8Izn6
	 5ABGWaPvfkSZsTcxlLRpe6RWvIQ9tDKhQ6ceBYXSP1RjmZFiyDSjFD2vTd6JUTxBqC
	 DFv5d8ed/+RCfuySG8/VdnEfcV7gOJczb+0kzys3wjQsAdxbEFilmCMQhN53iVz1ZO
	 cWOmltq5hUohA==
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
Subject: [PATCH AUTOSEL 6.11 14/15] ASoC: amd: yc: Add quirk for microphone on Lenovo Thinkpad T14s Gen 6 21M1CTO1WW
Date: Wed,  4 Dec 2024 17:17:08 -0500
Message-ID: <20241204221726.2247988-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221726.2247988-1-sashal@kernel.org>
References: <20241204221726.2247988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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
index 8b2ae20f828cf..d4bfc4a95e5fd 100644
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


