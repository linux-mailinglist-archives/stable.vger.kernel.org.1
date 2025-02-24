Return-Path: <stable+bounces-118821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CC0A41CA8
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 12:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606EF17AD49
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 11:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9842325B69E;
	Mon, 24 Feb 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP2xMtwX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534D5265610;
	Mon, 24 Feb 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395895; cv=none; b=AL83a7GTKUPqZGsTuLlNIxklBi4eHe/D3vjG3n2L1n/Jt6OylrtxWhaAutL1EUmz6YUrv+T1GsjTKm98J351wN1gNeVX6mduDZ8RG9fLkUghOYvl84YUJzpRBJq8u8AeqAzzc2US5h4sJbf/KLuWeR8RHkXF7lD1FkyV7X1TWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395895; c=relaxed/simple;
	bh=vZxWB+MOG4FouT3X1c+8FHsjNA5G5QG3GetSpCYSZFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJCZ+rVfQ21QqNtNTouBKHFw+oGXsXx3Au3RqEVG9HbySbEzeWqeKauDlCYMUA+oA64GTGWx2ok4VQh0jKPROypnm3B1iqfXEsUJ8QZRUdJpiXyngySKOb5eaXw/z6o1FojSTpv0nHe7kEyZqjsHFtaP04/BbRvVMgv+Hhmi3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP2xMtwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7573FC4CED6;
	Mon, 24 Feb 2025 11:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395895;
	bh=vZxWB+MOG4FouT3X1c+8FHsjNA5G5QG3GetSpCYSZFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TP2xMtwXT/2OSXIZxhzdCXdJQTBkGX0nA8hO64anDHpcPp7pWcW/S2uErmkQT7qoj
	 vkjDiaVRUOTNJLW1y2OKs3lQ0/8PHOJav1w6c0/vbGmpmwlsPCA/2v4q3a7IpdU513
	 m2pn0NEdq+ZFtT1QUQ9nRRov8cc/eWotc7O+JMSxk1+42kWQXpkPr0XSb29ViD0+SY
	 RDirZV685E2GOmOmnoRcsRzQD1JTvRSgzE54Y/FEqEWt5uvoSkETqCYdBLmNASMmdX
	 +kF2xODWKrkNyGHHHOPor4/yGZY+deeBBXDVrp4t9XgTzDKZ0gUKB0s/cje1ARh0re
	 qNFj1eSp7Bg5A==
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
Subject: [PATCH AUTOSEL 6.12 05/28] ASoC: Intel: soc-acpi-intel-mtl-match: declare adr as ull
Date: Mon, 24 Feb 2025 06:17:36 -0500
Message-Id: <20250224111759.2213772-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
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
index fd02c864e25ef..a3f7917656371 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -297,7 +297,7 @@ static const struct snd_soc_acpi_adr_device rt1316_3_single_adr[] = {
 
 static const struct snd_soc_acpi_adr_device rt1318_1_single_adr[] = {
 	{
-		.adr = 0x000130025D131801,
+		.adr = 0x000130025D131801ull,
 		.num_endpoints = 1,
 		.endpoints = &single_endpoint,
 		.name_prefix = "rt1318-1"
-- 
2.39.5


