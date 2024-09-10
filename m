Return-Path: <stable+bounces-75693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A13973F89
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C0A01F2A159
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C7A1BA290;
	Tue, 10 Sep 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDzJZ6tx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE751BA287;
	Tue, 10 Sep 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988990; cv=none; b=QAapRUC0Jkk6nLtl/43EOSCDIK2GYnSwLJa3E7yZni4OCbyi6NFDK70brcjyRiTaj7nJSCV0VL9zo1W/TAEl6S/VZhkIM52tdbPt0Y3PYlg0ZiHGG/KrneDUeihh7vdaYrQ0ynZzOQIrHGdcIYUTbjurzU3g9SzxlZJ/rEmdWJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988990; c=relaxed/simple;
	bh=9aQZ6bj0xYFaHsiENf5jNVgAkdUDB+cDSygiosOo0Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mz1BTUWlwTXF/sLMPaKPOgWtZCqFzV0bgv3TJngIVaePe5vF1z3iaWoQ8UwJAhptSFXGD2pLhRZom8E58yZFjYZJJp+GkL2ZQwWFdZvN5+FERqY6CW7tUeZL2axkygbRusR70S6wignN7yBcwROiRGBUHhaigN9/pMYvJfLiqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDzJZ6tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AAFC4CEC4;
	Tue, 10 Sep 2024 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725988990;
	bh=9aQZ6bj0xYFaHsiENf5jNVgAkdUDB+cDSygiosOo0Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mDzJZ6txyI0hXZ84xmtXsZNbEdBYepOuKEEYyzhpY8j9yHSizFtBYiuWtlQRprPLJ
	 /FYJX66lYN2E50jTSKzqnIEq4LxfpPq8u7NsZjJ4jftk8lBwRZhDq4A9meCK0binAl
	 UaWTR+t9L9tWb8cPEjPmgDycP+lCEj6ClO6/PityyyJM//xYftj4vycf/sDOvtb2uW
	 5GfqFIgX8e3u5QJ7pAEFS+tQfUK5OSpM+/gG5aoIqT6Cvu7wUXcq5R61SRoofvoGGa
	 4NOqPTNZJdF9iFpmNxVG7qDco8731T1UqEMfWVV+g5bBgpFqc5qdxssypwpVjgVp1N
	 XPTzBvfZXGFeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liao Chen <liaochen4@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	robh@kernel.org,
	kuninori.morimoto.gx@renesas.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 03/12] ASoC: intel: fix module autoloading
Date: Tue, 10 Sep 2024 13:22:45 -0400
Message-ID: <20240910172301.2415973-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172301.2415973-1-sashal@kernel.org>
References: <20240910172301.2415973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.50
Content-Transfer-Encoding: 8bit

From: Liao Chen <liaochen4@huawei.com>

[ Upstream commit ae61a3391088d29aa8605c9f2db84295ab993a49 ]

Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
based on the alias from of_device_id table.

Signed-off-by: Liao Chen <liaochen4@huawei.com>
Link: https://patch.msgid.link/20240826084924.368387-2-liaochen4@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/keembay/kmb_platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/keembay/kmb_platform.c b/sound/soc/intel/keembay/kmb_platform.c
index 6b06b7b5ede8..ffe558ef4922 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -815,6 +815,7 @@ static const struct of_device_id kmb_plat_of_match[] = {
 	{ .compatible = "intel,keembay-tdm", .data = &intel_kmb_tdm_dai},
 	{}
 };
+MODULE_DEVICE_TABLE(of, kmb_plat_of_match);
 
 static int kmb_plat_dai_probe(struct platform_device *pdev)
 {
-- 
2.43.0


