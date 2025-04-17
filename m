Return-Path: <stable+bounces-133256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6854FA924DD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 19:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872B8464817
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDD25B678;
	Thu, 17 Apr 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o/9Ii/nG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45E82594BD;
	Thu, 17 Apr 2025 17:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912534; cv=none; b=GbP24SPeAnUo56RSOHA9+gZurym884Dea3NI9KLclkj36F9K/h+voL3YJAkC4v17jF0W7acDUdY4k/j2QAsIWvK7j0nS/FKC9uGKVOUst3kECzyCzBwbwDhMWaYx/e0nxoBO5aY+QYGrcCBxunwMX7HiH8DSXDcFDYYAJoeXWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912534; c=relaxed/simple;
	bh=g+7hp0C2MY5f9+rpSKjQHgJB4gvTCCpMzaf+ialf81M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pf9spbTyX69Okjb6u56NbKbn1X2F0S/ZyNF+Xk9W6L3kSLJ/DRLqxPaxlYNiH8meRPnVYyrVsmNkUqde+5Xmcl5cfGYQHJjrseINZ45Qt9a/xhhvTw4e0DtDZADJd5Iit5HvSpUk7lJRDUiCoC82F6OXXOzPXDenbiZrK+GkQW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o/9Ii/nG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43793C4CEE4;
	Thu, 17 Apr 2025 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744912533;
	bh=g+7hp0C2MY5f9+rpSKjQHgJB4gvTCCpMzaf+ialf81M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/9Ii/nGVJoOiA1XV/J0inMQ7FWZU1pHSaO/RhAIwm+KlK1Cgxsdsh3kQr9xzdRjv
	 JmezHnlaCt662IIccYOslXkMMpKmCevMSYhlkNZe0XxuENvLhLd+63YdFeiI/QDKsB
	 M0vDvmhvJXJM++fdnv7DFljhAdo4ZX4PUTjYAPcY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.14 001/449] ASoC: Intel: adl: add 2xrt1316 audio configuration
Date: Thu, 17 Apr 2025 19:44:49 +0200
Message-ID: <20250417175118.029372216@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bard Liao <yung-chuan.liao@linux.intel.com>

commit 8b36447c9ae102539d82d6278971b23b20d87629 upstream.

That is a speaker only configuration and 2 rt1316 are on link 0 and 2.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20250305135443.201884-2-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/common/soc-acpi-intel-adl-match.c |   29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -214,6 +214,15 @@ static const struct snd_soc_acpi_adr_dev
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt1316_2_group2_adr[] = {
+	{
+		.adr = 0x000232025D131601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "rt1316-2"
+	}
+};
+
 static const struct snd_soc_acpi_adr_device rt1316_1_single_adr[] = {
 	{
 		.adr = 0x000130025D131601ull,
@@ -547,6 +556,20 @@ static const struct snd_soc_acpi_link_ad
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr adl_sdw_rt1316_link02[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt1316_0_group2_adr),
+		.adr_d = rt1316_0_group2_adr,
+	},
+	{
+		.mask = BIT(2),
+		.num_adr = ARRAY_SIZE(rt1316_2_group2_adr),
+		.adr_d = rt1316_2_group2_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_codecs adl_max98357a_amp = {
 	.num_codecs = 1,
 	.codecs = {"MX98357A"}
@@ -749,6 +772,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_in
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-adl-sdw-max98373-rt5682.tplg",
 	},
+	{
+		.link_mask = BIT(0) | BIT(2),
+		.links = adl_sdw_rt1316_link02,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-adl-rt1316-l02.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_adl_sdw_machines);



