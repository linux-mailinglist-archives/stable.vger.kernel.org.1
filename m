Return-Path: <stable+bounces-120104-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5AA4C753
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B989F3A5CC4
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED1A22CBED;
	Mon,  3 Mar 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYNpP7lC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BBD22B586;
	Mon,  3 Mar 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019407; cv=none; b=ngJhUKTH5yZ4KeBBfr3vyW24dN/t31037bw/tY4R035or7ujcZrUm3V41kO+pA08aCs+e5pY4w1VC6xKHqHcGFrERq8RnWcwr7jV7rcqXQDCE6qW3OzugVjyZCzRB5khlkG/9ZBpTDm6+RbEapV+svalGU2XEStmLhPpqwB7F74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019407; c=relaxed/simple;
	bh=B/jYQBJmmTDK3Ilg+X1nlKmMXYvNdEakUMLvXaQ3S7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsyN498X12SWrTFOpcxkM3Y8LtrwFscY+gxYNiAISrGeNK/3CGVIp5I48imHHQTXewxM+DbdsIghJ3SlSi5gA6LI/SvpBG8M7+IHFUq0ffiIlAv3ZmP4rpNvwFEIC2CYxUYVnom5/wRzHtY5o9WRi87dmTbB+QWmYppOPuxvLj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYNpP7lC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2788EC4CEE4;
	Mon,  3 Mar 2025 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019406;
	bh=B/jYQBJmmTDK3Ilg+X1nlKmMXYvNdEakUMLvXaQ3S7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYNpP7lCAau1CxO6IWydNfs+XV9kFRHYXR2oJhzqumBlCb8SGyMcNmMVokXAvMp2j
	 vcbtjSVMy9rKwTXeRo50tH+WCxtiAZs9bc8iMDOUsK8nmBXg5RlDZnyq/iMiUfsunJ
	 ITtU/wrzlzyGqfNE8hmUhAprusW+ZnIWtOl34cGXOkw0M/8sekw1gyrxyZGptQMrI+
	 fnuei7oWlYQ60rl5Ut2h7d/o6VAznMsfmrNX7GGc7/tZCPQPILVNeE9PbOTzHAxddc
	 P3sCMA5F15z5sSH6FLAQAcKN74+LEBIjui7mvy5PB06NrnQzcZHlqlXOO/ntMcNg7p
	 NF6h6Mhx07RrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	daniel.baluta@nxp.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	brent.lu@intel.com,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 07/17] ASoC: SOF: Intel: don't check number of sdw links when set dmic_fixup
Date: Mon,  3 Mar 2025 11:29:39 -0500
Message-Id: <20250303162951.3763346-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303162951.3763346-1-sashal@kernel.org>
References: <20250303162951.3763346-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.5
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 56a677293509b2a0d39ac8d02b583c1ab1fe4d94 ]

Currently, we assume that the PCH DMIC pins are pin-muxed with SoundWire
links. However, we do see a HW design that use PCH DMIC along with 3
SoundWire links. Remove the check now.
With this change the PCM DMIC will be presented if it is reported by the
BIOS irrespective of whether there are SDW links present or not.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20250225093716.67240-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index be689f6e10c81..a1ccd95da8bb7 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1312,22 +1312,8 @@ struct snd_soc_acpi_mach *hda_machine_select(struct snd_sof_dev *sdev)
 		/* report to machine driver if any DMICs are found */
 		mach->mach_params.dmic_num = check_dmic_num(sdev);
 
-		if (sdw_mach_found) {
-			/*
-			 * DMICs use up to 4 pins and are typically pin-muxed with SoundWire
-			 * link 2 and 3, or link 1 and 2, thus we only try to enable dmics
-			 * if all conditions are true:
-			 * a) 2 or fewer links are used by SoundWire
-			 * b) the NHLT table reports the presence of microphones
-			 */
-			if (hweight_long(mach->link_mask) <= 2)
-				dmic_fixup = true;
-			else
-				mach->mach_params.dmic_num = 0;
-		} else {
-			if (mach->tplg_quirk_mask & SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER)
-				dmic_fixup = true;
-		}
+		if (sdw_mach_found || mach->tplg_quirk_mask & SND_SOC_ACPI_TPLG_INTEL_DMIC_NUMBER)
+			dmic_fixup = true;
 
 		if (tplg_fixup &&
 		    dmic_fixup &&
-- 
2.39.5


