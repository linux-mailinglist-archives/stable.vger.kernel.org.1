Return-Path: <stable+bounces-98622-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D359E4946
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D3816B6E1
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EA6213243;
	Wed,  4 Dec 2024 23:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jalvYWax"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868120C495;
	Wed,  4 Dec 2024 23:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354904; cv=none; b=iznSZIPrFwNeb4uauWIiIRkfot9M2HmMFiCQsTwXXbdPZMRtpH9Vgt4vFbBcoA2EaKK6KtILThVaGECBXmNqGZQzMsWgiTuSAhF9u7K9ALCNh1m1IV0UaY8KZu5l22LOrG8FYqYhreQJ9jySHQk1u+hZGV/U7XKXF2U9J+p8mvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354904; c=relaxed/simple;
	bh=lIugWdpgcO45/QhH4J7hcSoI3lVioiEYiW3CfvMLArM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgtK06q2vWkw/i5RMy7HI9gy4Ff9SWvt5vVb/ShqFtMPA5tQeB/0ZSk98ZAO5QVHtdF8Fc3GyZLUNgKsqSam3cupPoJJECSoZu+5xKI3AqBRUcW7+UxqqUlkrMETK5Ze6ayneosLULVDM+F4nxZMgQq5R/BHuo7wW7kAYAZIxrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jalvYWax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A89CC4CECD;
	Wed,  4 Dec 2024 23:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354903;
	bh=lIugWdpgcO45/QhH4J7hcSoI3lVioiEYiW3CfvMLArM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jalvYWaxzE3wmftqXcQYpe0sRpahMZo/KhI/44wP0Rkqh0AfF/IMbem/GLZmLfKEu
	 ITfZfrcPaTsbSHfLVUY2+v8e6Z4suXUwkYWLMbEkTAqNincEpK3CIyyF2m3KOaat2j
	 U7WTiiwD+xP+Y8Hw8OwDryKrnQVTUjwGmBxwIO03glctUtoAtX0t0V85KvRQn4yXka
	 L1I2s4v7WFJ2ndP64LxcYwK0MKv2RZUDPIoU+lNb4Ts8tfmr/P+nSyJchQNsm8iada
	 IrSUzcVNbeabclZ2liQGb0sxMrXfuR9PjM1cUHwA6opArp501l2xoBzP+QWsjfaFuH
	 y6Fzv/i4eohgw==
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
Subject: [PATCH AUTOSEL 6.12 14/15] ASoC: amd: yc: Add quirk for microphone on Lenovo Thinkpad T14s Gen 6 21M1CTO1WW
Date: Wed,  4 Dec 2024 17:16:08 -0500
Message-ID: <20241204221627.2247598-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221627.2247598-1-sashal@kernel.org>
References: <20241204221627.2247598-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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
index 1b9834ee5d461..6439c175552af 100644
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


