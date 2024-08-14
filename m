Return-Path: <stable+bounces-67658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2C3951C94
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 16:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13262839C6
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A861B32D7;
	Wed, 14 Aug 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QdWlb2e5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AEB1B32D6;
	Wed, 14 Aug 2024 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644375; cv=none; b=NuzazRsdnvNjSkHMeLZuHQIvi2bKSR23bN63xH6XzE71TrtSGFamuaNgXLZY55zSwPw8SdHO0anvN3NRMd+JDEe4COZSpOXffOuT6/mmZb79XNRv375TQtoykz5byFjPUfVqbtf1tU6fScmfhtPv0hlZruNfUAmj0YpOW74os4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644375; c=relaxed/simple;
	bh=gdSNo/XQZDdVrV4zR7eon61VyrS8pAXXJU1DqdBYTCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WdD/Zr1UDzcINom7uq/u+fLx+XyXfAlw+t+On6zXs5aSuypC0XWKcGw0fpa3j+IO2eF7XP40k/2w2d7KcWOTkzVWUfbGOKQACrvmyKZCOha+cq1t+TWQzzAOJZ98799ukK0mJ/QSON1wTi9Vsnz9TTXyxVbZqKYtAJ7ViZuTyNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QdWlb2e5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723644374; x=1755180374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gdSNo/XQZDdVrV4zR7eon61VyrS8pAXXJU1DqdBYTCI=;
  b=QdWlb2e5lCkX+lSFg8qhJuHC5WZV/c4asc0NlBECPF555w1ik2S0HMZt
   2/gzQPx5llO+7t0Ew6Oox46g/UcqImvuPJNuiRcd75t5On4JcjaLWL3H4
   j27Z8QOwz2oxEpXFNuGNLBBuhhzrpAM21804z5a++1QG1Vlil5XdVThly
   XDNX/93Rjy+QHSnD91wi9E1j2psZ4RTBWjFmCd9VFGxZAFMcx5lh8ZXAj
   gkgT9pYbtxDkawQf29piEO9qxWWf8j835k53MnVvfFFR2iKSNL7ngAkdA
   YkJEWKnb0ozQEJs/0k8pImcvEbXnfTX+wqj5ZAUVQh/ahPJZUNbizcP3u
   g==;
X-CSE-ConnectionGUID: PHNfdYl5TsyqMEgABcKHBw==
X-CSE-MsgGUID: 5us6uhKFQzGJFzd9XLSFUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="13010082"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="13010082"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 07:06:14 -0700
X-CSE-ConnectionGUID: Il7yoo66SryMa0PimKRlyQ==
X-CSE-MsgGUID: QZil8iRtQeaxJ9js/K/NXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59305716"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orviesa006.jf.intel.com with ESMTP; 14 Aug 2024 07:06:10 -0700
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
Subject: [PATCH for stable 2/2] ASoC: topology: Fix route memory corruption
Date: Wed, 14 Aug 2024 16:06:57 +0200
Message-Id: <20240814140657.2369433-3-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com>
References: <20240814140657.2369433-1-amadeuszx.slawinski@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 sound/soc/soc-topology.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index e7a2426dd7443..7e8fca0b06628 100644
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


