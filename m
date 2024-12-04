Return-Path: <stable+bounces-98634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77879E4958
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796F4281AE0
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844932165E7;
	Wed,  4 Dec 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOMMlQ01"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C82163B0;
	Wed,  4 Dec 2024 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354952; cv=none; b=X1Omx55OR+krC/PqQVDFR/tiXjLhqG/KekZtpRYb+YtiQs2WYFOoZYcud/aSFl3IxVtmvzko6c4Pohu2X2+MRjtpDY6Hg+hVtv/27anP7NwqghBh1M3xnOI2i1SoOlI/jmvXotXrnrSrxzImrPYw2WFPkE1KZ8RqKrMIk8t3Qv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354952; c=relaxed/simple;
	bh=rtzB1TYr0eHB7a49S5nXx04jBYsRDkVxs6m1JK9ubyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih+hYjpWM6pMLDK0rqJm4YD8EEyfphTPj3ENnB9p1pXTevwGJw99t8ob74z1MwG2loRfPOiU+9aET6s2aAf3rHQuDa+ZFZggDoy+4LVR1BJN4x3dHyVCYXST7DfIf6PLAPCmRyyPHv92wxdPuQQu7khbTXBRIgqkSeUsyTB9Wnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOMMlQ01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4782C4CED2;
	Wed,  4 Dec 2024 23:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354952;
	bh=rtzB1TYr0eHB7a49S5nXx04jBYsRDkVxs6m1JK9ubyE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OOMMlQ01/Up9kJcLdNNFov+J1Uz4KraruBgUvIRLCyNTB3cp4cEyp6sSoeRUtuL9U
	 QW5SWcQGj6RyZsvjFw64KSdQ/QCMrYX8OONcNzJd0LlRoqIygrtUU+b/E3mI32qWG9
	 sy9JrKZMm6AHnDtp9eHxl8hLDQSBXlZ2NKPGJ2L8SRAFV2X9H/VQpiLZwNTSMkoqva
	 AkMsBGlCsGkh+ZoypE3uWgZ4ia74JMoXjh+vYgLZPUPj1E5e7mvFFaZkcMvRFMxBz/
	 jRcEp/QbvBPhU36+LeAKfcodPpo+/awLGcdlaRmZzOfFHX2SG+a7timhMrlGEwEN/D
	 BOUCgKutRtFeA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Far <anf1980@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	end.to.start@mail.ru,
	me@jwang.link,
	venkataprasad.potturu@amd.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 11/15] ASoC: amd: yc: fix internal mic on Redmi G 2022
Date: Wed,  4 Dec 2024 17:17:05 -0500
Message-ID: <20241204221726.2247988-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221726.2247988-1-sashal@kernel.org>
References: <20241204221726.2247988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Alex Far <anf1980@gmail.com>

[ Upstream commit 67a0463d339059eeeead9cd015afa594659cfdaf ]

This laptop model requires an additional detection quirk to enable the
internal microphone

Signed-off-by: Alex Far <anf1980@gmail.com>
Link: https://patch.msgid.link/ZzjrZY3sImcqTtGx@RedmiG
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index dc476bfb6da40..8b2ae20f828cf 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -402,6 +402,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14 2022"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TIMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi G 2022"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


