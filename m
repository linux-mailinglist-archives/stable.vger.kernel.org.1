Return-Path: <stable+bounces-60977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CC793A642
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 20:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61EA0B22C42
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC658158215;
	Tue, 23 Jul 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g3QEH6Vf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6F142067;
	Tue, 23 Jul 2024 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759611; cv=none; b=piCJtgEh2REyGv7tcUWerqsYBC/cso2Wn9B8DkaLmjLXYCkkEL7O/VQvpIXvdM4SLNtoEO+fbRwjWGKky9fjugTHd4bGMk0MQRgwB6/3PacQapCcd2msq4beHRFfD/bV9cIsoe2Kjml8zHqU0neNqqh77h2UNgLhXSgYyPQQZdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759611; c=relaxed/simple;
	bh=Pf/p/4kNr7+HL+EWyinlIWkX69yCifkmg+j3hksABEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIlWXXjeNc0y6V0gG8tBaIRssxPHnn1IeTrCzuX2fLComSwoz0an3jPpDDCINlhxfM55drqNwGwg1ksyOD7vR08LW1Z+CZGRIgx1GfhCnh9i7uT87jK1bzGH7K8EMJnLYBsxbITJIu3OP9Xsszp/V438NgVHEAGDpb12vcAvgmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g3QEH6Vf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BA9C4AF0A;
	Tue, 23 Jul 2024 18:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721759611;
	bh=Pf/p/4kNr7+HL+EWyinlIWkX69yCifkmg+j3hksABEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g3QEH6VfowZ6NenmFgYlsWiMrkiNhA2SGFppx+W+5p0UoIsreWy+4qqkUdwllPrdk
	 PiVxJo4dx81UzS/FU3RZPyKd6vtgBQPLfW4OnUBuPTWRDeObbmGgYg4GjlW6zuKxX9
	 eiYivo0z93030F1rWNi4Zj7PCTMtZ7SIL+Y1O9e8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas GENTY <tomlohave@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 069/129] bytcr_rt5640 : inverse jack detect for Archos 101 cesium
Date: Tue, 23 Jul 2024 20:23:37 +0200
Message-ID: <20240723180407.450980012@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723180404.759900207@linuxfoundation.org>
References: <20240723180404.759900207@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas GENTY <tomlohave@gmail.com>

[ Upstream commit e3209a1827646daaab744aa6a5767b1f57fb5385 ]

When headphones are plugged in, they appear absent; when they are removed,
they appear present.
Add a specific entry in bytcr_rt5640 for this device

Signed-off-by: Thomas GENTY <tomlohave@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20240608170251.99936-1-tomlohave@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 651408c6f399d..5b8b21ade9cfe 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -610,6 +610,17 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 					BYT_RT5640_SSP0_AIF1 |
 					BYT_RT5640_MCLK_EN),
 	},
+	{
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ARCHOS 101 CESIUM"),
+		},
+		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
+					BYT_RT5640_JD_NOT_INV |
+					BYT_RT5640_DIFF_MIC |
+					BYT_RT5640_SSP0_AIF1 |
+					BYT_RT5640_MCLK_EN),
+	},
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
-- 
2.43.0




