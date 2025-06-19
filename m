Return-Path: <stable+bounces-154788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 176F3AE02E9
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD5D3AC1D3
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3650D225404;
	Thu, 19 Jun 2025 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aC/OxisT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F89225387;
	Thu, 19 Jun 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750330026; cv=none; b=T69+M68HQ0AhVQw11t1ImrF0qHUVCSOS/w2pHSVISYl1Tu6LG20QdICQth11BlcVQt++pABKvQ0A5s86jJ3THU4wZYG5lLjwKj0Eo8UPYbFCJdBm1oGMy7Fd2rUmSGOEHhvmNflTxvo26ybgYDTDA7nZgPsmcmNq/rGn5jaNeL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750330026; c=relaxed/simple;
	bh=GzuzxFMmyK8PMy+gSaGoEj7793QPKYN/ED3imAIfUno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ix6LmeGs8uIDsg+cW1YI0JE5it0M/17Sl59OBGx7fo77cE/EqhS42J7lrFgCiwO5UYpQUgepKJgRn2OONYPqL9TDRH7WxSgAGCHRylK9CUS9HF0G8UwedMrtRQefPrGUFz6D/kgRfHPR7yIufjOxCOLvPB/rKdyp+etkJ04oCOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aC/OxisT; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750330025; x=1781866025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GzuzxFMmyK8PMy+gSaGoEj7793QPKYN/ED3imAIfUno=;
  b=aC/OxisTCjaqErvjXyaymk78D2ATO/cfSrLJPJ6VudipVXpJCConCuhI
   vGRW3oRmgFxlkfk4w7A/yuCCljSqCjQHItq2vzKlH3xTPGfMqVgXXHUnS
   AmMmXxFRuFGqwXOZtbqn1HjeHcWtPUAkG7T6+5pCAuJk0WjUgCtZWV0QP
   7U3gR2h8tAVD+Sz0Qv4ieiaz1ECPAsje7JAnRt97aDSUDdg+u3IatC4Ae
   m4O9cHrwv1sI4vAola7DTM44+yKD8O7gDdJLJPg9M6t5lsBT/tgZTyEnw
   bu9ThauoF+dS6KscQRvMwO/CBglsjoRec1FZn9+MeMtOmSAtZ2ofEI0+I
   A==;
X-CSE-ConnectionGUID: 0BjrBofOQ+GkOLXfe2hUWw==
X-CSE-MsgGUID: 7XHBR+OZQJeG3bBre5tmmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52280513"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="52280513"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 03:47:05 -0700
X-CSE-ConnectionGUID: E8KGf3FeTvqjZE4wUVaPTA==
X-CSE-MsgGUID: MhVAypXUT7Ca2z+j7OkaSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; 
   d="scan'208";a="150051460"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.182])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 03:47:02 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: Intel: sof-function-topology-lib: Print out the unsupported dmic count
Date: Thu, 19 Jun 2025 13:47:05 +0300
Message-ID: <20250619104705.26057-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is better to print out the non supported num_dmics than printing that
it is not matching with 2 or 4.

Fixes: 2fbeff33381c ("ASoC: Intel: add sof_sdw_get_tplg_files ops")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
---
 sound/soc/intel/common/sof-function-topology-lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/sof-function-topology-lib.c b/sound/soc/intel/common/sof-function-topology-lib.c
index 90fe7aa3df1c..3cc81dcf047e 100644
--- a/sound/soc/intel/common/sof-function-topology-lib.c
+++ b/sound/soc/intel/common/sof-function-topology-lib.c
@@ -73,7 +73,8 @@ int sof_sdw_get_tplg_files(struct snd_soc_card *card, const struct snd_soc_acpi_
 				break;
 			default:
 				dev_warn(card->dev,
-					 "only -2ch and -4ch are supported for dmic\n");
+					 "unsupported number of dmics: %d\n",
+					 mach_params.dmic_num);
 				continue;
 			}
 			tplg_dev = TPLG_DEVICE_INTEL_PCH_DMIC;
-- 
2.49.0


