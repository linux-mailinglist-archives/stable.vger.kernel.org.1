Return-Path: <stable+bounces-72211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 209A69679B4
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B7151C209A1
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066F0186E33;
	Sun,  1 Sep 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0OKsRmjP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7383183CDB;
	Sun,  1 Sep 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209199; cv=none; b=jWuUjAlq8dRceyr+yuv3gU/3t88dTnFyE77KEvseKe45GqGE3UKPuoeTltNZb6vUTm21iqQ/+ddlwrnLT2qcWSkk4HUuG/wazCE4b/HRHbt+UrOfJkr03K3kUyAZFuyv4MhaVTtw1WQqZTCafVg1T+9wxno9EL+0UXvTRTIW4vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209199; c=relaxed/simple;
	bh=LWNfzgFqzAS9hKl1mmPspO7o2XXHUxGU0X3NmP4uJwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5IlmhGK86YVzXARpzS/qsEeMTjHxM2HzSH8Nd8yl0z556ONwsDDY1oDMMNA0lA2k/3/zMcpM0QABUitiDAn3XVYa+b62yu6bf5q8mHs1KwTSdaoz9NW25Eo7ysiD09dpHAuGWRqgLhBYlwx6PkpjJNIIWMIKWD6QqaPyLFDDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0OKsRmjP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE54C4CEC3;
	Sun,  1 Sep 2024 16:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209199;
	bh=LWNfzgFqzAS9hKl1mmPspO7o2XXHUxGU0X3NmP4uJwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0OKsRmjPoXS8oPW1CwkwcyQc7r5IYF5FTpRV1Y5kn5/Icl2FFkXlvq1VGpM9shhxB
	 Hv7qu/P2Liknw5YGwL2Lpt0WslgFb/qQmNGV5suF6UTXb4v2BwCNt04j1hAy1tsErP
	 ByYOnyysBq/7huicbfkBtkrJ1mThNXZhJGTJbDeM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 32/71] ASoC: SOF: amd: Fix for acp init sequence
Date: Sun,  1 Sep 2024 18:17:37 +0200
Message-ID: <20240901160803.103985992@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160801.879647959@linuxfoundation.org>
References: <20240901160801.879647959@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

[ Upstream commit a42db293e5983aa1508d12644f23d73f0553b32c ]

When ACP is not powered on by default, acp power on sequence explicitly
invoked by programming pgfsm control mask. The existing implementation
checks the same PGFSM status mask and programs the same PGFSM control mask
in all ACP variants which breaks acp power on sequence for ACP6.0 and
ACP6.3 variants. So to fix this issue, update ACP pgfsm control mask and
status mask based on acp descriptor rev field, which will vary based on
acp variant.

Fixes: 846aef1d7cc0 ("ASoC: SOF: amd: Add Renoir ACP HW support")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20240816070328.610360-1-Vijendar.Mukunda@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/amd/acp.c | 19 +++++++++++++++++--
 sound/soc/sof/amd/acp.h |  7 +++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index f8d2372a758f4..e4e046d4778e2 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -363,6 +363,7 @@ static int acp_power_on(struct snd_sof_dev *sdev)
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int base = desc->pgfsm_base;
 	unsigned int val;
+	unsigned int acp_pgfsm_status_mask, acp_pgfsm_cntl_mask;
 	int ret;
 
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + PGFSM_STATUS_OFFSET);
@@ -370,9 +371,23 @@ static int acp_power_on(struct snd_sof_dev *sdev)
 	if (val == ACP_POWERED_ON)
 		return 0;
 
-	if (val & ACP_PGFSM_STATUS_MASK)
+	switch (desc->rev) {
+	case 3:
+	case 5:
+		acp_pgfsm_status_mask = ACP3X_PGFSM_STATUS_MASK;
+		acp_pgfsm_cntl_mask = ACP3X_PGFSM_CNTL_POWER_ON_MASK;
+		break;
+	case 6:
+		acp_pgfsm_status_mask = ACP6X_PGFSM_STATUS_MASK;
+		acp_pgfsm_cntl_mask = ACP6X_PGFSM_CNTL_POWER_ON_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (val & acp_pgfsm_status_mask)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + PGFSM_CONTROL_OFFSET,
-				  ACP_PGFSM_CNTL_POWER_ON_MASK);
+				  acp_pgfsm_cntl_mask);
 
 	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, base + PGFSM_STATUS_OFFSET, val,
 					    !val, ACP_REG_POLL_INTERVAL, ACP_REG_POLL_TIMEOUT_US);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 14148c311f504..b1414ac1ea985 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -22,8 +22,11 @@
 #define ACP_REG_POLL_TIMEOUT_US                 2000
 #define ACP_DMA_COMPLETE_TIMEOUT_US		5000
 
-#define ACP_PGFSM_CNTL_POWER_ON_MASK		0x01
-#define ACP_PGFSM_STATUS_MASK			0x03
+#define ACP3X_PGFSM_CNTL_POWER_ON_MASK		0x01
+#define ACP3X_PGFSM_STATUS_MASK			0x03
+#define ACP6X_PGFSM_CNTL_POWER_ON_MASK		0x07
+#define ACP6X_PGFSM_STATUS_MASK			0x0F
+
 #define ACP_POWERED_ON				0x00
 #define ACP_ASSERT_RESET			0x01
 #define ACP_RELEASE_RESET			0x00
-- 
2.43.0




