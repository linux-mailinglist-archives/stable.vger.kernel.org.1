Return-Path: <stable+bounces-169197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E24B238B7
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF0F3AD875
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF272ED157;
	Tue, 12 Aug 2025 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hAoWN4jB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4701A2FDC53;
	Tue, 12 Aug 2025 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755026707; cv=none; b=ceDQH6uI6c8GWZSoJmG6Wgf2pvFnWCtZEytt0el9W1thZUge0LoY+xPFxl0vMUzM/a7A0Lply8p6FxiGY+ohOah3E70t5Se8xkfeQg0hY9uXKuZFUnkbyBBbmqO1/oRo26WY6pnpAmACJs95Cf3uJzmhZnWUVtQ6LrsrPOjRfEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755026707; c=relaxed/simple;
	bh=h6MqeSS5+wOWPURc3XxaJEt8/oHHG9t4+0ZL2jAd5AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGr0RjS3/lIdE9uCaa6iA11VSGOIB1kNaqk4r6Jhv4JyGotG0Svx2wYDPIwdHVoD9g7mt7MrpiOy6/lZuvYA4YeTNnM2YKSKN+c60Bl3otiR/WEQIUltyveK4T5emHpmePxI2kJn2ZRKubIyyRNRxFQa6hyRYMM/nBl9JS5xrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hAoWN4jB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F85C4CEF0;
	Tue, 12 Aug 2025 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755026706;
	bh=h6MqeSS5+wOWPURc3XxaJEt8/oHHG9t4+0ZL2jAd5AE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hAoWN4jBqC0MO+qZ6C9lUAq/DHgGmFSZZEL+i1w+Rs5DkoWdYV54m2nGAIDMHSgrd
	 95v1mK8+i5/Az7TX/3Dl1B2ebi6aYMshKgSbWxqoSUOmZnn2UjHqPlpomaJxo78A0z
	 eWHkEih7GlsoiVDXd/hav54e9NyWUVYDo8kP8dvI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 417/480] ASoC: SOF: Intel: hda-sdw-bpt: fix SND_SOF_SOF_HDA_SDW_BPT dependencies
Date: Tue, 12 Aug 2025 19:50:25 +0200
Message-ID: <20250812174414.614323138@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 614d416dd8aee2675fb591c598308a901a660db8 ]

The hda-sdw-bpt code links against the soundwire driver, but that fails when
trying to link from built-in code into loadable module:

x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_close_stream.isra.0':
intel_ace2x.c:(.text+0x137a531): undefined reference to `hda_sdw_bpt_close'
x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_send_async':
intel_ace2x.c:(.text+0x137aa45): undefined reference to `hda_sdw_bpt_open'
x86_64-linux-ld: intel_ace2x.c:(.text+0x137ab67): undefined reference to `hda_sdw_bpt_close'
x86_64-linux-ld: intel_ace2x.c:(.text+0x137ac30): undefined reference to `hda_sdw_bpt_send_async'
x86_64-linux-ld: vmlinux.o: in function `intel_ace2x_bpt_wait':
intel_ace2x.c:(.text+0x137aced): undefined reference to `hda_sdw_bpt_wait'

Ensure that both SOUNDWIRE_INTEL and SND_SOF_SOF_HDA_SDW_BPT are selected
at the same time by SND_SOC_SOF_INTEL_LNL, and that this happens even if
SND_SOC_SOF_INTEL_SOUNDWIRE is a loadable module but SND_SOC_SOF_INTEL_LNL
is built-in.

This follows the same logic as commit c5a61db9bf89 ("ASoC: SOF: fix
intel-soundwire link failure").

Fixes: 5d5cb86fb46e ("ASoC: SOF: Intel: hda-sdw-bpt: add helpers for SoundWire BPT DMA")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20250805160451.4004602-1-arnd@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index dc1d21de4ab7..4f27f8c8debf 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -266,9 +266,10 @@ config SND_SOC_SOF_METEORLAKE
 
 config SND_SOC_SOF_INTEL_LNL
 	tristate
+	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE != n
 	select SND_SOC_SOF_HDA_GENERIC
 	select SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
-	select SND_SOF_SOF_HDA_SDW_BPT if SND_SOC_SOF_INTEL_SOUNDWIRE
+	select SND_SOF_SOF_HDA_SDW_BPT if SND_SOC_SOF_INTEL_SOUNDWIRE != n
 	select SND_SOC_SOF_IPC4
 	select SND_SOC_SOF_INTEL_MTL
 
-- 
2.39.5




