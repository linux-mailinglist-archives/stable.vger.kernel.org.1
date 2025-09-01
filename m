Return-Path: <stable+bounces-176825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCF6B3DF15
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 11:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8981917D0F7
	for <lists+stable@lfdr.de>; Mon,  1 Sep 2025 09:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBE82F5326;
	Mon,  1 Sep 2025 09:55:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B5A277813
	for <stable@vger.kernel.org>; Mon,  1 Sep 2025 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720519; cv=none; b=cX+JbzP7tzsvSQb9udberjM0ySm0tbzaFvc91Vce7IVEbbUN/9mYdLDWKtG/XlG1Xk69zi3z34GHYZrDgRS8iTOJXHO4bdIjuJE+DeH3PJOlDYBtTDDxcMKq1tmI5W0R3SdJ42RFpOJKENAd7/uUnLW5QU4rCcV6ZsxjmHrdamI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720519; c=relaxed/simple;
	bh=E+aU38H5ZfHkZCuMEeFU7lgG0rhHE2CgsBMrIa0vP/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lE5EjsUDzPLPitlIROx3mz/f1KH1A+PLYfq8ezD2+d1KRG++UwP5AYF1EGHS6ySGthwo8tA1FOgxYgQmNKnamIcw0nW9yoNHMyH33Zxxh2ZZ8ny2w24gJCHe3Q0yaPAJyNvJVflfGVJQYJs9mXph7em53KBvtUvDdIlZ3cRK0C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from pomiot (c144-154.icpnet.pl [85.221.144.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2954733BE9F;
	Mon, 01 Sep 2025 09:55:12 +0000 (UTC)
From: =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To: stable@vger.kernel.org
Cc: Brent Lu <brent.lu@intel.com>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
Subject: [PATCH linux-5.10.y 5/5] ASoC: Intel: sof_da7219_mx98360a: fail to initialize soundcard
Date: Mon,  1 Sep 2025 11:54:40 +0200
Message-ID: <20250901095440.39935-5-mgorny@gentoo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901095440.39935-1-mgorny@gentoo.org>
References: <2025082909-plutonium-freestyle-5283@gregkh>
 <20250901095440.39935-1-mgorny@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Brent Lu <brent.lu@intel.com>

commit 0f32d9eb38c13c32895b5bf695eac639cee02d6c upstream.

The default codec for speaker amp's DAI Link is max98373 and will be
overwritten in probe function if the board id is sof_da7219_mx98360a.
However, the probe function does not do it because the board id is
changed in earlier commit.

Fixes: 1cc04d195dc2 ("ASoC: Intel: sof_da7219_max98373: shrink platform_id below 20 characters")
Signed-off-by: Brent Lu <brent.lu@intel.com>
Link: https://lore.kernel.org/r/20210726094525.5748-1-brent.lu@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 sound/soc/intel/boards/sof_da7219_max98373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_da7219_max98373.c b/sound/soc/intel/boards/sof_da7219_max98373.c
index 387bc8c962d9..16930cab4e28 100644
--- a/sound/soc/intel/boards/sof_da7219_max98373.c
+++ b/sound/soc/intel/boards/sof_da7219_max98373.c
@@ -404,7 +404,7 @@ static int audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	/* By default dais[0] is configured for max98373 */
-	if (!strcmp(pdev->name, "sof_da7219_max98360a")) {
+	if (!strcmp(pdev->name, "sof_da7219_mx98360a")) {
 		dais[0] = (struct snd_soc_dai_link) {
 			.name = "SSP1-Codec",
 			.id = 0,

