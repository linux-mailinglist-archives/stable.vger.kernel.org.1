Return-Path: <stable+bounces-75705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4078B973FD3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00664289608
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5231BE840;
	Tue, 10 Sep 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZNH7bQq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE891BE235;
	Tue, 10 Sep 2024 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989021; cv=none; b=XdVpK455q8Ff1sOWT1S4ctykUf/N1LdO1VAyCTK1UiYH9uYWiYvzPKfNFnFlfo/wlt4bTob4Xj5fPpPY/TJQITKzj0gciml0q4KCavG74SW4JeRBjVN5r2o4Ihy462tar0Iogr5E/CqA/1vS+ZhsToNi0UXj/3M1Jtsogim3OYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989021; c=relaxed/simple;
	bh=6Iv7JVQx9bVwxMpEDS5nzTO1tdlTzFidyglg+NVlm8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RYnPD2slJT4gDV3zx0wkCzvedswUg3akEjurXX7ZE9V5bJRw0GU6Xrd/B0H07ywEJy86Hw7Ki7CCcVS1fnSF5ejfkbgD0sg1CCUPMz5gKSRPEXB/p0fJfCHeZs1yzzAlGBrqCIojgE87e4Y3qD/anj8TKA/GEwBhHxrwFmIQa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZNH7bQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8FF1C4CEC4;
	Tue, 10 Sep 2024 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989020;
	bh=6Iv7JVQx9bVwxMpEDS5nzTO1tdlTzFidyglg+NVlm8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZNH7bQqj5gNK9K4ZCXlh954Uo/EC4kkphna+yA2i/K6EWfaKEPnolAjXDurKcBoe
	 8LrHL4CDcXvqqrL42N6MWOk0VPeo42sFON0DjGu1keHZWgpyGqZY3mjkCA+reJ8Yxr
	 pUv1broLNCEI2rByIgjm0uqErwrlZevbw3NFlhHLhOt1r2sMhl7NVfSvvu6dWZ2D9d
	 PKdHhvDuUDKwQmbeFnu01C7M7Rt0iR7CkCItkfX6n4TDFhoULHYV+jxZJxbIVPuzlH
	 wRn+LX2dH72ktiDC44zqMONnwyacd7OBxQ3aorT2N0cSb0u8cNaRfZ6REA241eKwIq
	 Jrf6vqQicNyhQ==
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
Subject: [PATCH AUTOSEL 6.1 3/8] ASoC: intel: fix module autoloading
Date: Tue, 10 Sep 2024 13:23:23 -0400
Message-ID: <20240910172332.2416254-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910172332.2416254-1-sashal@kernel.org>
References: <20240910172332.2416254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.109
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
index b4893365d01d..d5c48bed7a25 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -817,6 +817,7 @@ static const struct of_device_id kmb_plat_of_match[] = {
 	{ .compatible = "intel,keembay-tdm", .data = &intel_kmb_tdm_dai},
 	{}
 };
+MODULE_DEVICE_TABLE(of, kmb_plat_of_match);
 
 static int kmb_plat_dai_probe(struct platform_device *pdev)
 {
-- 
2.43.0


