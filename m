Return-Path: <stable+bounces-75711-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E5973FFB
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA9C286530
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF831A4F24;
	Tue, 10 Sep 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ/9pUz4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2828E1A2C0C;
	Tue, 10 Sep 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989036; cv=none; b=lLDmwszgiFCMbo8ZGn9EZMxpOCOS+Ci+/ERLNbwnSo+efXHIo/Fx2wBejsfU9Eq5plQP0PUqY77gW+bxGEVUI4hL21QFcliwWTK8Z41FiJZSM6Z7qJckXxgIpunnzHrvnUQ/5V4cvjE8KCvDe9j1Hufszbn8pGDBtyjgq+hUE3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989036; c=relaxed/simple;
	bh=hkwRpH1tL1PFIOxTO9aR4Vq5sOYyIJDhKWEBLiehR3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIMhPqA26jantEHH+B5ZoetBt1LQ6j7z9kFZ9Qym8SM3BD4SLz7xJvQ4UZrg7OCGCGVF8Z7I/pXriBw3LS6CLPw3X/6RiFVbG/UqkRoLp/7ocdzLEDB9RPO1tmo9qFepJ4dKghNuWGR2A23BRnkLaH8kViFf9AzIQah18xS95K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ/9pUz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3252C4CECC;
	Tue, 10 Sep 2024 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989035;
	bh=hkwRpH1tL1PFIOxTO9aR4Vq5sOYyIJDhKWEBLiehR3I=;
	h=From:To:Cc:Subject:Date:From;
	b=LJ/9pUz4T64FN3bLaNy/2FoMrTvvl/7poK3c5y+x2rFxQLKCsZCN7wLWTJCo/4pse
	 d7SaJgmw9gwcrCsMjWgq+j1m4e+vxkE8FcczxhMLvoX7XaXq+JNSaeC9yIaNixstSV
	 G2n0ivEEhKysM8/Sf8g5U7Kelo/e1h7sNch0bDwCXqSyt9BGwMZVDrvhkzp8GnwbDX
	 SZaAv48P3fjUrqU4s3X70PMvIWt5GkGfu1nR3KZjHdXY24tckM8b7xXsMKb79sHnpq
	 gLP2jdrNiBdRUcf7uJ2J6bCn7zBS8SUWTep/sBguaOuFPdx7VTbX3+F6wBlLPu6zbq
	 oijp26iYeKvVA==
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
Subject: [PATCH AUTOSEL 5.15 1/5] ASoC: intel: fix module autoloading
Date: Tue, 10 Sep 2024 13:23:45 -0400
Message-ID: <20240910172352.2416462-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.166
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
index a6fb74ba1c42..86a4c32686e7 100644
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


