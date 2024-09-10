Return-Path: <stable+bounces-75716-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DF9974007
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 19:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991A31F214D7
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 17:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406401A2C0E;
	Tue, 10 Sep 2024 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmYVYFh/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF93219F464;
	Tue, 10 Sep 2024 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989050; cv=none; b=W/wj2sQQUKPUcJqzwsX5AfHqakWoZaYE3n2CWezUccT8SOlIPARPLMENbeWqgxJv4CMygj81vKlgV0Zi7roLBv9SGyyUuuE5RZ1Wl4OEHLlXhj4ooSYqrJQq5TDYMIT4e67M42rIs3ItBhILsJGIG0przTkNZkRhimD6QbY5d7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989050; c=relaxed/simple;
	bh=UwzWWmAIpz/ajbTwiMwI7DKpHn4myn5KjbthwRGxsb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aIt7kSYT9MSHlS7DJ0cqPilzzNw+PMjFkpqwIv6iFVeKcxcQp2+CoMrrzC3sgri7KZOr7pWZM0fsSzo85CG5sWpB4skHT5S+KL0i5BnJ4ldH81NTcZR967pq2wRZcMH2kl+cvQivWrFHEkT/Kf6h2Ujkw3RLCEsK7R/uN3aesuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmYVYFh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB353C4CEC3;
	Tue, 10 Sep 2024 17:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725989049;
	bh=UwzWWmAIpz/ajbTwiMwI7DKpHn4myn5KjbthwRGxsb8=;
	h=From:To:Cc:Subject:Date:From;
	b=SmYVYFh/j8PPXLLuo2jAZS39SRRnEi6h2JOj375FwhXQOB7kzftD7IXTtRMw7Bz0v
	 HIS9Sl/KQHcNghrS25PFfPzt4CY+OTDQnMb32vHqw+C1iKjoXA360McVNPWpEWSVpD
	 5jNRP0Vov4MKetkWgxhNyac6UhJbR+/zZJ5RlqhnUMw0QOfVqG6RxSSlpAr5vFORqq
	 GMt42VqDksb5QfWOV7MiKlwoUK7f1IBLlyGDXtIzHhKhQEvrsbGMw9uo+jjJpuRJSy
	 T7zysWyX834H/jMEBPk+dMNZCth+RAuDUPLAHfFt2vMa273Ymx2cQWDeulilxKwkgN
	 wKpISQmyk/f+w==
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
	kuninori.morimoto.gx@renesas.com,
	robh@kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/4] ASoC: intel: fix module autoloading
Date: Tue, 10 Sep 2024 13:24:00 -0400
Message-ID: <20240910172406.2416588-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.225
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
index 291a686568c2..c7b754034d24 100644
--- a/sound/soc/intel/keembay/kmb_platform.c
+++ b/sound/soc/intel/keembay/kmb_platform.c
@@ -634,6 +634,7 @@ static const struct of_device_id kmb_plat_of_match[] = {
 	{ .compatible = "intel,keembay-tdm", .data = &intel_kmb_tdm_dai},
 	{}
 };
+MODULE_DEVICE_TABLE(of, kmb_plat_of_match);
 
 static int kmb_plat_dai_probe(struct platform_device *pdev)
 {
-- 
2.43.0


