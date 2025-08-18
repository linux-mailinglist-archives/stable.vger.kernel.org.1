Return-Path: <stable+bounces-171490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CB7B2A9BD
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0594F7BAE63
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C055E322A32;
	Mon, 18 Aug 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jdUEBRUr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD75322A1A;
	Mon, 18 Aug 2025 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526101; cv=none; b=SnJkTaSq2AQnigy8pHxA6jRIWlflvjFSXzbkbnOi8SOepdDl24Zfwwa90fI+XO9NsBfuSAyT1ZwGasaJgcp1XbxIWZsbhALhtvXbBjT3p+Yve/Y+h8lQLrhIh3vXdymUgqa5U27xczuSQDZ8kV2P6Y/z5SgNegnqDB41+6hO5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526101; c=relaxed/simple;
	bh=cox8OjX+mbGrzJlKivezC6C4e6zul0qDpuBq/SYHOeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anr9x38phq9UbwYJWVrodmSsY6tJD2aP8cCc4x1sGLv2FCREm95wV5lQZ9zQXknEu4y2Bvjly6jHgTvBDK4TyDqUR5KH5fwyKXViJx58tHaqd3C/Sn2gj+O3/B0aN4nG+CUm7g5XCK6SjKQ3dEG2lIUKxMp12k4q9dN2jUD3aeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jdUEBRUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3ECCC116C6;
	Mon, 18 Aug 2025 14:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526101;
	bh=cox8OjX+mbGrzJlKivezC6C4e6zul0qDpuBq/SYHOeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jdUEBRUrqkBTP6PrmJ0beJ3SxGNRs0rXsLcTmAtXqgwpHxoZ3Oy7iSnWGIrXgwARv
	 Aoq/yjGWzudpoNMy9fXTTf0c3jaAfr/xtarVL9bjOkI7hX+ZClqdfxdHjgFXljkeeN
	 8yMpAr1loRdnvYNmAKlHT6UbL4ERQW3cYr1gowNo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Jakubek <peterjakubek@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 459/570] ASoC: Intel: sof_sdw: Add quirk for Alienware Area 51 (2025) 0CCC SKU
Date: Mon, 18 Aug 2025 14:47:26 +0200
Message-ID: <20250818124523.542564979@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Jakubek <peterjakubek@gmail.com>

[ Upstream commit 1b03391d073dad748636a1ad9668b837cce58265 ]

Add DMI quirk entry for Alienware systems with SKU "0CCC" to enable
proper speaker codec configuration (SOC_SDW_CODEC_SPKR).

This system requires the same audio configuration as some existing Dell systems.
Without this patch, the laptop's speakers and microphone will not work.

Signed-off-by: Peter Jakubek <peterjakubek@gmail.com>
Link: https://patch.msgid.link/20250731172104.2009007-1-peterjakubek@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 504887505e68..c576ec5527f9 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -741,6 +741,14 @@ static const struct dmi_system_id sof_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(SOC_SDW_CODEC_SPKR),
 	},
+	{
+		.callback = sof_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0CCC")
+		},
+		.driver_data = (void *)(SOC_SDW_CODEC_SPKR),
+	},
 	/* Pantherlake devices*/
 	{
 		.callback = sof_sdw_quirk_cb,
-- 
2.39.5




