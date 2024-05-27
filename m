Return-Path: <stable+bounces-46875-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 348F68D0B9F
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660121C21606
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974E155CA7;
	Mon, 27 May 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MhrM+dhv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8508E17E90E;
	Mon, 27 May 2024 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837078; cv=none; b=NPnCeuL5+reCUbD/Ngpdo0A/MYq1/8emdhEnnnm3QJOQuY8wJkB4OBxEIdrb4zKHotDYae0MT2vaC8vVSoWrptp9xLZ8rVQ84xrRjJ+X14SY1NtDWBkgFpeH4fdVM05JxA6Lj7hoNTdVo1XHgynK3HRmC+ST3XqjeQp8CjEqOxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837078; c=relaxed/simple;
	bh=ANYjsFAeoSFmYadc5+qrtXxvZMiTpIZRNLp0YmOekBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nSGxtqOXmywNutUoie3UFLT+NHx6wf7GZ9UVBmri4/LlQWxywybcNvwqka3XLisiR+Ct+YLErukcMqelxKE987HfXN6CQsRUMVYIx0VzRspfgIJ/8uPDKpxLsfS+lQALzJWnx+L7ynpwshdrxq+rAzn+tii6gYl5llHXzVPmJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MhrM+dhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1456DC2BBFC;
	Mon, 27 May 2024 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716837078;
	bh=ANYjsFAeoSFmYadc5+qrtXxvZMiTpIZRNLp0YmOekBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhrM+dhvKEwsGVTZOKN/GfjaevDId3MYJ16zKhwF+Hd7JUxZbakLlP6nCDYEzsvrT
	 drXT7n0vr82mkMowyUoqZfMZcAzy1NTUjts4GNIXhF2ev3YAlI2XTrY4dOqINKwfvx
	 eIe+I6jvkdBr/IrHXQ/A2M+PHpVjlFBuQoEcICbk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 301/427] ASoC: SOF: Intel: mtl: Correct rom_status_reg
Date: Mon, 27 May 2024 20:55:48 +0200
Message-ID: <20240527185630.274189451@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 1f1b820dc3c65b6883da3130ba3b8624dcbf87db ]

ACE1 architecture changed the place where the ROM updates the status code
from the shared SRAM window to HFFLGP1QW0 register for the status and
HFFLGP1QW0 + 4 for the error code.

The rom_status_reg is not used on MTL because it was wrongly assigned based
on older platform convention (SRAM window) and it was giving inconsistent
readings.

Fixes: 064520e8aeaa ("ASoC: SOF: Intel: Add support for MeteorLake (MTL)")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Link: https://msgid.link/r/20240403105210.17949-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/mtl.c | 4 ++--
 sound/soc/sof/intel/mtl.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 060c34988e90d..1454e2a98c3b0 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -727,7 +727,7 @@ const struct sof_intel_dsp_desc mtl_chip_info = {
 	.ipc_ack = MTL_DSP_REG_HFIPCXIDA,
 	.ipc_ack_mask = MTL_DSP_REG_HFIPCXIDA_DONE,
 	.ipc_ctl = MTL_DSP_REG_HFIPCXCTL,
-	.rom_status_reg = MTL_DSP_ROM_STS,
+	.rom_status_reg = MTL_DSP_REG_HFFLGPXQWY,
 	.rom_init_timeout	= 300,
 	.ssp_count = MTL_SSP_COUNT,
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
@@ -755,7 +755,7 @@ const struct sof_intel_dsp_desc arl_s_chip_info = {
 	.ipc_ack = MTL_DSP_REG_HFIPCXIDA,
 	.ipc_ack_mask = MTL_DSP_REG_HFIPCXIDA_DONE,
 	.ipc_ctl = MTL_DSP_REG_HFIPCXCTL,
-	.rom_status_reg = MTL_DSP_ROM_STS,
+	.rom_status_reg = MTL_DSP_REG_HFFLGPXQWY,
 	.rom_init_timeout	= 300,
 	.ssp_count = MTL_SSP_COUNT,
 	.ssp_base_offset = CNL_SSP_BASE_OFFSET,
diff --git a/sound/soc/sof/intel/mtl.h b/sound/soc/sof/intel/mtl.h
index ea8c1b83f7127..3c56427a966bf 100644
--- a/sound/soc/sof/intel/mtl.h
+++ b/sound/soc/sof/intel/mtl.h
@@ -70,8 +70,8 @@
 #define MTL_DSP_ROM_STS			MTL_SRAM_WINDOW_OFFSET(0) /* ROM status */
 #define MTL_DSP_ROM_ERROR		(MTL_SRAM_WINDOW_OFFSET(0) + 0x4) /* ROM error code */
 
-#define MTL_DSP_REG_HFFLGPXQWY		0x163200 /* ROM debug status */
-#define MTL_DSP_REG_HFFLGPXQWY_ERROR	0x163204 /* ROM debug error code */
+#define MTL_DSP_REG_HFFLGPXQWY		0x163200 /* DSP core0 status */
+#define MTL_DSP_REG_HFFLGPXQWY_ERROR	0x163204 /* DSP core0 error */
 #define MTL_DSP_REG_HfIMRIS1		0x162088
 #define MTL_DSP_REG_HfIMRIS1_IU_MASK	BIT(0)
 
-- 
2.43.0




