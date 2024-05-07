Return-Path: <stable+bounces-43336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5598BF1D6
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0C721C233C8
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3479E148858;
	Tue,  7 May 2024 23:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAiD91Ay"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24FF1487F7;
	Tue,  7 May 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715123445; cv=none; b=cz4nqBOq1ZzYfXQrLUtJizqWib3HL6+L2+BicYcIcPx+M794ubPCZuX/vYoYhXxMGUTFgZNjpAU4nNHrraAOE5PeTqKIu15N9NXmfEdWNsoqoijTlPMzAAqMAICDC3uGjhx/pXXMcfp+w8EWRiQZhajC/ZpTnzLWtCsrCr8AgEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715123445; c=relaxed/simple;
	bh=tzAO42lNI2hbn6/bD9ofHq+ScsvGfmTLGzi8KkdDbrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxxU5k3/VW3da1mdRr1Co1mmyIsr3qoiM3ym7tVXtqRRyBd7poWUtkzjbmaaViQ7zcTleGM7/Ibws4XVS6z3r9hpFsl7I4GVW5TPW64kHBh/kEVlB2DLCn7l0oXXx+4h/fN399VS7cQiXbhBReUm5viotLzxL/conNDwmQXeRis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAiD91Ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAC3C2BBFC;
	Tue,  7 May 2024 23:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715123444;
	bh=tzAO42lNI2hbn6/bD9ofHq+ScsvGfmTLGzi8KkdDbrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAiD91AycrK7kvIgvzgGKEAvY1a3YcXEfPcS13Iy8gx7Vcm+RzG33qqiFqJlB2SHi
	 f1pOALfSKc8+DXpilpCu/qFCS3tO2pedd40FdiFqV3sEZU3KAdefBRnB9PRJCOj4Re
	 Z+kaOIMMygC/YBHeQhcigMWo25a0vv5snw1hAYXz8g6ylLBTMZj4NZ15/GfoVX7vWq
	 voqeSSsMbcCQShcEEnIn4WhOHGrpMmERwtOn+5g0Iv3QO/he9hyc8ol8G7d/WobGm/
	 2h1jdmJaC2rRxTk114Za43UkKEKlbZK49lXo+NSNwU0FhLSnLZdaRUeZGHbz35pd7g
	 HHt/s1w4cfJTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "end.to.start" <end.to.start@mail.ru>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	jeremy@system76.com,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/43] ASoC: acp: Support microphone from device Acer 315-24p
Date: Tue,  7 May 2024 19:09:26 -0400
Message-ID: <20240507231033.393285-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507231033.393285-1-sashal@kernel.org>
References: <20240507231033.393285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: "end.to.start" <end.to.start@mail.ru>

[ Upstream commit 4b9a474c7c820391c0913d64431ae9e1f52a5143 ]

This patch adds microphone detection for the Acer 315-24p, after which a microphone appears on the device and starts working

Signed-off-by: end.to.start <end.to.start@mail.ru>
Link: https://msgid.link/r/20240408152454.45532-1-end.to.start@mail.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 69c68d8e7a6b5..1760b5d42460a 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -430,6 +430,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "MRID6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MDC"),
+			DMI_MATCH(DMI_BOARD_NAME, "Herbag_MDU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


