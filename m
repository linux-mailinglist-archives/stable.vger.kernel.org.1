Return-Path: <stable+bounces-118791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8560A41C5C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D3E7A8ACB
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2599325C6F5;
	Mon, 24 Feb 2025 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjxWHCtC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D451224BC05;
	Mon, 24 Feb 2025 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395821; cv=none; b=sFAnM/ATQ+XC51gjJvEfW5w2z4+MeMe+OUGaywirkSGe2MYX9tmXzlMO8KwRt+foQcfxKmLox3Wsl+rbXzH1u9v/54k4Z40teReAFqYlYf/NnpYNfeTDrPT2qHf9H5brpuB9C+p18WUSZPHyeJBYMWnQZIyKpB4pL1lfun5+D9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395821; c=relaxed/simple;
	bh=a2f25K9QwtaDClWgwe/qXxEPp0YFKpRPiQ8LDTtkrFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2PgfVtjF8uf4fsQUTxsjcbVj6Ufl3QQB2jSuKx1lcv5e7PeKo4LwvMeKS5VhHbGZzsvjDYtb8es6Twl4hm2/6JARxDh77Lqb6q8H4V9EjJHvLDpf77wDhYqf6ntID66ap71qL91iiMCSUCgLD0Jsq9iLlh9w46q5VOjK4o0v9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjxWHCtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B5DFC4CEE6;
	Mon, 24 Feb 2025 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395821;
	bh=a2f25K9QwtaDClWgwe/qXxEPp0YFKpRPiQ8LDTtkrFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NjxWHCtC7lQcfXN2t1TLoYb7TQyymitiFe6kceiOdfn55OoskGnixdD6sR5QvH4j/
	 IyUwnlQocLE6QtsACDfhXBaA+y4BobCdHS+yrdEq1jiWAkcYihaQ3ycQwx2SU56/Of
	 ImFie/TWg1TK/OCI12aJKdzyhM+ZJM5KJ4sK/7Cdc3nJyT/MhbIYV2ZpgcPJ37Tos3
	 d85bRoOPUbmO4Qb5i1GZpW8eU0kff5YSpukjke0dvSfdLFIjCtEXsEgsVZzDGgECz+
	 wLVppSsETAEUwciHAdNmJYRDLa0sPGoZ2li0bRBKZPmbJgjmogBQIlSZQ+E4ZCrALF
	 x6S1UzSPrMJ+A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	brent.lu@intel.com,
	rf@opensource.cirrus.com,
	ckeepax@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 07/32] ASoC: Intel: soc-acpi-intel-mtl-match: declare adr as ull
Date: Mon, 24 Feb 2025 06:16:13 -0500
Message-Id: <20250224111638.2212832-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
Content-Transfer-Encoding: 8bit

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 20efccc53abf99fa52ea30a43dec758f6b6b9940 ]

The adr is u64.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://patch.msgid.link/20250204033134.92332-3-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index 03fc5a1870123..9b9098485b8c3 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -330,7 +330,7 @@ static const struct snd_soc_acpi_adr_device rt1316_3_single_adr[] = {
 
 static const struct snd_soc_acpi_adr_device rt1318_1_single_adr[] = {
 	{
-		.adr = 0x000130025D131801,
+		.adr = 0x000130025D131801ull,
 		.num_endpoints = 1,
 		.endpoints = &single_endpoint,
 		.name_prefix = "rt1318-1"
-- 
2.39.5


