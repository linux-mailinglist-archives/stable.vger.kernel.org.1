Return-Path: <stable+bounces-82150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2471D994B6D
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0671F2759A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5E21DFD85;
	Tue,  8 Oct 2024 12:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DCnN5OYy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD001DE2AD;
	Tue,  8 Oct 2024 12:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391318; cv=none; b=VxpHbZ1Nn/W48/N28N8KgY9KpYloi81YwdAx6GGwB7wiH4TOwR3jkU8TTTAT7JLfEKbv65fOquXVHXznMNaLs8OD96R/FNtI9v+NTQYk2rGnhqx+kj6gtBWdl2B28gKNOj6MSQL9CesPCyfqKNHTHXnYTqPTefum03IHD6nzU3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391318; c=relaxed/simple;
	bh=d02Px65IdyRZyjnXDZfQkxf8B9pp8KiBu7FU4NgjbOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdNelTfNI50tdIKeNDudgGZiinbOhKBq5zF/g0Hjfi1pW2+31MpV7FEn0bPY52oIJGZlZC84539ezaiq59wF56Upo9frA3ARzSStcdILT5WbZ8YcKS7Kmk3jurfS2/WfzVceuuOFuzMq4sV37wkx+x4/RJCR0PZ40it7RNj+fw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DCnN5OYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4593AC4CECD;
	Tue,  8 Oct 2024 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391318;
	bh=d02Px65IdyRZyjnXDZfQkxf8B9pp8KiBu7FU4NgjbOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCnN5OYyX7A/04CX+irJlqKioqmYd/hP2JWTSeqcnCJ/2aBdsDbSVuDhbCLlIKMh8
	 mtRrdy8P8My3/HsC4X9WauL4WTn094mfxZxVaAnZOfMvczT/ZSdcgoqUrRQYfvI93U
	 ESxPvUeMMQqkAxeP34Whe8QjRV43PJ+icPRpnTAM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hui Wang <hui.wang@canonical.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 069/558] ASoC: imx-card: Set card.owner to avoid a warning calltrace if SND=m
Date: Tue,  8 Oct 2024 14:01:39 +0200
Message-ID: <20241008115704.931819626@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

[ Upstream commit 47d7d3fd72afc7dcd548806291793ee6f3848215 ]

In most Linux distribution kernels, the SND is set to m, in such a
case, when booting the kernel on i.MX8MP EVK board, there is a
warning calltrace like below:
 Call trace:
 snd_card_init+0x484/0x4cc [snd]
 snd_card_new+0x70/0xa8 [snd]
 snd_soc_bind_card+0x310/0xbd0 [snd_soc_core]
 snd_soc_register_card+0xf0/0x108 [snd_soc_core]
 devm_snd_soc_register_card+0x4c/0xa4 [snd_soc_core]

That is because the card.owner is not set, a warning calltrace is
raised in the snd_card_init() due to it.

Fixes: aa736700f42f ("ASoC: imx-card: Add imx-card machine driver")
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Link: https://patch.msgid.link/20241002025659.723544-1-hui.wang@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/imx-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/imx-card.c b/sound/soc/fsl/imx-card.c
index 0e18ccabe28c3..ce0d8cec375a8 100644
--- a/sound/soc/fsl/imx-card.c
+++ b/sound/soc/fsl/imx-card.c
@@ -713,6 +713,7 @@ static int imx_card_probe(struct platform_device *pdev)
 
 	data->plat_data = plat_data;
 	data->card.dev = &pdev->dev;
+	data->card.owner = THIS_MODULE;
 
 	dev_set_drvdata(&pdev->dev, &data->card);
 	snd_soc_card_set_drvdata(&data->card, data);
-- 
2.43.0




