Return-Path: <stable+bounces-56174-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681F291D53B
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 02:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C85FB20ADC
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 00:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B100B14D430;
	Mon,  1 Jul 2024 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0BRjUKt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5CB2A1CF;
	Mon,  1 Jul 2024 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719792852; cv=none; b=Dh6TaY/NDNtuqwNz7jbFm1o1aaRZXHyoZ+zQnUFvFMc8y0LmByVKx6n3pGWo+NzEiLnqIRB1vxsXuYsDi+bIiwzxC/FUnUmekmI4fB//jgWxH5TE+szwrrDot4BGY9fNyE+0dbj6lnv40SkWzSJbxdrJVitIYpxkyATGmKyZyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719792852; c=relaxed/simple;
	bh=WWkSwEc2053YOi1KCrFaGjdlOUhwN2v3DU5romcCZEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSrnNWgCwmYvKKw5TizN5R7zbF7la42IDYgXUbiGbDA0n+kmotrGothm6TxjuZ+J29UtpABMydavBNlBB5RB3sWJAu9tXpkgjnqYRAWPRdaTI6zbuK8MGmxc17IJNEaQPXH7DJ5TtTKPBUYia9tpj5MCVL6RSFTF8dA3HiTvLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0BRjUKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7849DC32786;
	Mon,  1 Jul 2024 00:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719792852;
	bh=WWkSwEc2053YOi1KCrFaGjdlOUhwN2v3DU5romcCZEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a0BRjUKt6TK3hH6rKx8zjlnYDMfW7NgFnhigtpR4cpQYOEFQ8nDXB1R3ikOxtBor7
	 QIal/rMrjwyxP1oVbTCfGmvue9s8hFIBh3m68CEmbT40bQ8n1NkIw9SCkrSTx2cACz
	 7R5ZGCoraEKVEdryYp9VnNTHV87ZfVLVgdBaKCvjeq9QmkDXZeDeZoj4xIHwM039+C
	 pQmn7Yyl6jZC4yNwVSaLEMKzahvmdVZWbqJsI+6ACqVdUzwXNygXZp8VqZV/8exOlS
	 a3WO3qF1k7pbtAgo7UiwrPsnWETZtDOlJPIyiVFVTzjvPprMcS+Me5e2u6xU3q53fr
	 5MQm57B8R2HoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	rf@opensource.cirrus.com,
	broonie@kernel.org,
	shenghao-ding@ti.com,
	sbinding@opensource.cirrus.com,
	lukas.bulwahn@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/12] ALSA: hda: cs35l56: Select SERIAL_MULTI_INSTANTIATE
Date: Sun, 30 Jun 2024 20:13:30 -0400
Message-ID: <20240701001342.2920907-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701001342.2920907-1-sashal@kernel.org>
References: <20240701001342.2920907-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.36
Content-Transfer-Encoding: 8bit

From: Simon Trimmer <simont@opensource.cirrus.com>

[ Upstream commit 9b1effff19cdf2230d3ecb07ff4038a0da32e9cc ]

The ACPI IDs used in the CS35L56 HDA drivers are all handled by the
serial multi-instantiate driver which starts multiple Linux device
instances from a single ACPI Device() node.

As serial multi-instantiate is not an optional part of the system add it
as a dependency in Kconfig so that it is not overlooked.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Link: https://lore.kernel.org/20240619161602.117452-1-simont@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 21046f72cdca9..f8ef87a30cab2 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -141,6 +141,7 @@ config SND_HDA_SCODEC_CS35L56_I2C
 	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
 	select FW_CS_DSP
+	select SERIAL_MULTI_INSTANTIATE
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L56_SHARED
 	select SND_HDA_SCODEC_CS35L56
@@ -155,6 +156,7 @@ config SND_HDA_SCODEC_CS35L56_SPI
 	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
 	select FW_CS_DSP
+	select SERIAL_MULTI_INSTANTIATE
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L56_SHARED
 	select SND_HDA_SCODEC_CS35L56
-- 
2.43.0


