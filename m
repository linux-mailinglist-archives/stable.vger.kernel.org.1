Return-Path: <stable+bounces-67678-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA99951F0A
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 17:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB08DB22341
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 15:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C381B9B50;
	Wed, 14 Aug 2024 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c35oT3os"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958A1B8EBF;
	Wed, 14 Aug 2024 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650435; cv=none; b=KAUc5NA9fj2bYEN8zOwfGXWoRHZwTT56FhzAvbUT5+1HpZpyJfSBULPx5arWlQawWGR/Mim7ibjzbimI0SmwTWJ68BJTTmlE2cwf0w9fJB5hwkeL1gPoUQBBK8UciRVapbhx20UaesTDLDBd2ClQWhNkZCJUlkE0eizkFeBgKj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650435; c=relaxed/simple;
	bh=mF3IyTz4B68pPQXgPxWQqg6T2YX1f2V+LIgDKhqHrQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IroAGB/WM0sXBerWf0v+MC91uGxf+e18E0nZW4P3o10fT4dt4IcXkpagadZ5C231+gifLKGN5hdHjSJpOubmRI758QiOBpudGyNLJDExiSB1WYxzK7MqhMRoziZGSBayScEOicBg/uqakTQN2nVjJDtggS8EMh4mbKketqcFsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c35oT3os; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723650434; x=1755186434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mF3IyTz4B68pPQXgPxWQqg6T2YX1f2V+LIgDKhqHrQA=;
  b=c35oT3osToJj35ljfNrEkvbSoYekcEUFREFqsxm44ZPCFPuIIlm2ll3K
   w5dWTJkR/UV7UbmtxDXhiEO2Vz89FXx8hpU2StEVWAz2Gi2cRXkT6mFyH
   6U0GVAg1LpL5pVdEGzjW7NEboxbJ6POZaHUy0KFR2EaCUlaQONPQ+YcfJ
   hS85rmSt8GW1o24B00ePOafuzTVymGOvN8Xu1vrkt1aEdikY+Z8qQjKvX
   X/FAlXzwCQPZ5SMbifIaMXIPeF4wT//xHFbafVTBTLAhbsx62YBxA8gqS
   XroUbLH4yR0FioVO1CKKTxpPCToCYG0KVFqWkPkx3q1FCmnIdMP4iWYQC
   Q==;
X-CSE-ConnectionGUID: 3TM5qvJKREyRo+jJkVSOvw==
X-CSE-MsgGUID: 1znsFfddQQKU6c84vmBzgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="47279532"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="47279532"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 08:47:06 -0700
X-CSE-ConnectionGUID: pTb/7qr1QgWk4nqWPvmY0w==
X-CSE-MsgGUID: 8xM7Sv2hREyamnKvVm16Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="58936611"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orviesa010.jf.intel.com with ESMTP; 14 Aug 2024 08:47:02 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
	tiwai@suse.com,
	perex@perex.cz,
	lgirdwood@gmail.com,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Vitaly Chikunov <vt@altlinux.org>,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH for stable v2 2/2] ASoC: topology: Fix route memory corruption
Date: Wed, 14 Aug 2024 17:47:49 +0200
Message-Id: <20240814154749.2723275-3-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814154749.2723275-1-amadeuszx.slawinski@linux.intel.com>
References: <20240814154749.2723275-1-amadeuszx.slawinski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit 0298f51652be47b79780833e0b63194e1231fa34 ]

It was reported that recent fix for memory corruption during topology
load, causes corruption in other cases. Instead of being overeager with
checking topology, assume that it is properly formatted and just
duplicate strings.

Reported-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Closes: https://lore.kernel.org/linux-sound/171812236450.201359.3019210915105428447.b4-ty@kernel.org/T/#m8c4bd5abf453960fde6f826c4b7f84881da63e9d
Suggested-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240613090126.841189-1-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 52752e0a5dc27..27aba69894b17 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1052,21 +1052,15 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 			break;
 		}
 
-		route->source = devm_kmemdup(tplg->dev, elem->source,
-					     min(strlen(elem->source), maxlen),
-					     GFP_KERNEL);
-		route->sink = devm_kmemdup(tplg->dev, elem->sink,
-					   min(strlen(elem->sink), maxlen),
-					   GFP_KERNEL);
+		route->source = devm_kstrdup(tplg->dev, elem->source, GFP_KERNEL);
+		route->sink = devm_kstrdup(tplg->dev, elem->sink, GFP_KERNEL);
 		if (!route->source || !route->sink) {
 			ret = -ENOMEM;
 			break;
 		}
 
 		if (strnlen(elem->control, maxlen) != 0) {
-			route->control = devm_kmemdup(tplg->dev, elem->control,
-						      min(strlen(elem->control), maxlen),
-						      GFP_KERNEL);
+			route->control = devm_kstrdup(tplg->dev, elem->control, GFP_KERNEL);
 			if (!route->control) {
 				ret = -ENOMEM;
 				break;
-- 
2.34.1


