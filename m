Return-Path: <stable+bounces-142995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B588CAB0CC3
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C977AB3E4
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B04B269B11;
	Fri,  9 May 2025 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dkiBSTeY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF1426A1DA;
	Fri,  9 May 2025 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778323; cv=none; b=n/UksG6S9ONYbSqEuzsMexA65oEiL4TB1qV7mhnVXk/x6kA9PIEEgDbf2WZ3oNpMOoKxzIBXM/uF28Jx/nA2zxTicQfI54zFcChChksO6UkURtHio1dO+HQXk/ttl6Gx7US6OSUW4vlDJPQ3oc+LOLe4CUW6UBcbOcELxTqnp6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778323; c=relaxed/simple;
	bh=8IbLnw9mBjgrk+9yg+uifNi0PymoSeiWbk1RPstYs7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YWMBxPYV9P1ro2obNFAW5a2Tso/v0017hfp+OI4JzKXs/rPsUovIg9tHmBMawA78O90gJNppgSWBa/Cgmnc1mI53hiHhiFPO5SM7emppMyUHl7jR3CR3GMymVI6E1hNfROqEuzNrw8QSEYuFetnQFLGwQGYmvbDOvXoa3iuJeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dkiBSTeY; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746778322; x=1778314322;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8IbLnw9mBjgrk+9yg+uifNi0PymoSeiWbk1RPstYs7E=;
  b=dkiBSTeYwwBZNfjLbE7vdE0HUkQ6zm71JGC9ch6K6LSKe5yCQKAZR40I
   58LP6/CZqXgas41xkryA+TRm7w56UqguPYAEaNXUqUNmMQSziHLyI4u70
   QMSAmytygwOtTsj1heFMQPBPC3a4yRzpaVSaDm6JqvkSRfnwgINU+6spl
   lY2abb4NvmgaR3dI2hPixJCcVuO134hSO1WW5r6Q4uaU8/5ALjb9sqfmK
   OtuXoH427IJQb/Gv+XXJos4kAauNEv94vKhazHSb9dwSG+OP816Co1zgg
   D4uZRFT6mQ/eDQ5lsxds/mbplx7kISqSuUOC5r5o/AvrxfGMrpWyKXBxl
   Q==;
X-CSE-ConnectionGUID: r+vQldL2QCOxc9kx0Mf5jw==
X-CSE-MsgGUID: utNmgeb2T/ya1CLFtCu2QQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="36225018"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="36225018"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:12:01 -0700
X-CSE-ConnectionGUID: UPTLarKASvehNtOGMe+Jdw==
X-CSE-MsgGUID: q4AQOU+wTGO7nusOyBZ2gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; 
   d="scan'208";a="167481069"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.132])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 01:11:58 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Intel: hda-bus: Use PIO mode on ACE2+ platforms
Date: Fri,  9 May 2025 11:13:08 +0300
Message-ID: <20250509081308.13784-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep using the PIO mode for commands on ACE2+ platforms, similarly how
the legacy stack is configured.

Fixes: 05cf17f1bf6d ("ASoC: SOF: Intel: hda-bus: Use PIO mode for Lunar Lake")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: stable@vger.kernel.org
---
 sound/soc/sof/intel/hda-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-bus.c b/sound/soc/sof/intel/hda-bus.c
index b1be03011d7e..6492e1cefbfb 100644
--- a/sound/soc/sof/intel/hda-bus.c
+++ b/sound/soc/sof/intel/hda-bus.c
@@ -76,7 +76,7 @@ void sof_hda_bus_init(struct snd_sof_dev *sdev, struct device *dev)
 
 	snd_hdac_ext_bus_init(bus, dev, &bus_core_ops, sof_hda_ext_ops);
 
-	if (chip && chip->hw_ip_version == SOF_INTEL_ACE_2_0)
+	if (chip && chip->hw_ip_version >= SOF_INTEL_ACE_2_0)
 		bus->use_pio_for_commands = true;
 #else
 	snd_hdac_ext_bus_init(bus, dev, NULL, NULL);
-- 
2.49.0


