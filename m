Return-Path: <stable+bounces-183016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A531FBB2B1E
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518B53C4534
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D0F2D23B8;
	Thu,  2 Oct 2025 07:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eRWv/YYT"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116F827F18C;
	Thu,  2 Oct 2025 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759390234; cv=none; b=jLojIt/vjRxLGwiwlw3MkbZxYYTtEyGaCTDC1SNv5m8AybgSefZFShPVdAKvzAdbObcovMOqOhPLDgaE2yRccu5uF+bBwi/F7im431TxUc12njqKrqFF0dKO4HuaQCzvJWOXtOSlv9ODYAyOCN3JCZdeHhJ0nEcD9Y4NyWFZYoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759390234; c=relaxed/simple;
	bh=aCNTd7y2V+SuHg6WVjBlqABjwCfquQ+5RZdKXqarfmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PQZi9QhaCOuixNmID3XFc27D0Zz9Bb9f8ipRY31oIAZ+t8xpNlVgLqOMltTrVzbMSkpFrtw7qOp9TRTvBluGU5w7Omdc7nAjj08bL+9tw7Y/mslg8jDUHLcqIry/7RJXjImmUt0HKIbacPCGERjsmz2g5tNyIzS46CwMkHuLl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eRWv/YYT; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759390232; x=1790926232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aCNTd7y2V+SuHg6WVjBlqABjwCfquQ+5RZdKXqarfmI=;
  b=eRWv/YYTv66OfRJ5UzwLPP8s0hF8bK04ecWCkTxmuMku/TzOfMiBm0cT
   DcQBzEIqeID2BdvYiPTBuyP6qPSpkIpMstMxDBULxNncOQOxwxGeR7AC0
   LdOKYE34hyjmG3HQmMwQRcgjiskMpHUHQQW/uD5yIiJmlvyeVaSyNV7Zz
   nu1vlyJNQKIFAOB7OziFTbmY2jdgazKSOHb0GumBZmmgeSmiOE70MWAWx
   aZ4+BSE2JW9yEg3w7NFE1QofK3TaItKJ3apjpy8+w05naLEwFawpfVuwk
   FQSqqSrlohJoHXO5/4g5/14T84mIFLbGZG/YBWownIskuz+mGXcca3DEX
   w==;
X-CSE-ConnectionGUID: qkkaX/7FRXOYABSiQKR1iw==
X-CSE-MsgGUID: w/BIBxiEShqMugZZ8Qa2Fw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61630224"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61630224"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:30:31 -0700
X-CSE-ConnectionGUID: OER0keruTw+k30vAlnGvMA==
X-CSE-MsgGUID: l6CDBBbOQwCMDIVEqMIEUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="179758666"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:30:28 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc3-topology: Fix multi-core and static pipelines tear down
Date: Thu,  2 Oct 2025 10:31:25 +0300
Message-ID: <20251002073125.32471-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

In the case of static pipelines, freeing the widgets in the pipelines
that were not suspended after freeing the scheduler widgets results in
errors because the secondary cores are powered off when the scheduler
widgets are freed. Fix this by tearing down the leftover pipelines before
powering off the secondary cores.

Cc: stable@vger.kernel.org
Fixes: d7332c4a4f1a ("ASoC: SOF: ipc3-topology: Fix pipeline tear down logic")
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc3-topology.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index 473d416bc910..f449362a2905 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -2473,11 +2473,6 @@ static int sof_ipc3_tear_down_all_pipelines(struct snd_sof_dev *sdev, bool verif
 	if (ret < 0)
 		return ret;
 
-	/* free all the scheduler widgets now */
-	ret = sof_ipc3_free_widgets_in_list(sdev, true, &dyn_widgets, verify);
-	if (ret < 0)
-		return ret;
-
 	/*
 	 * Tear down all pipelines associated with PCMs that did not get suspended
 	 * and unset the prepare flag so that they can be set up again during resume.
@@ -2493,6 +2488,11 @@ static int sof_ipc3_tear_down_all_pipelines(struct snd_sof_dev *sdev, bool verif
 		}
 	}
 
+	/* free all the scheduler widgets now. This will also power down the secondary cores */
+	ret = sof_ipc3_free_widgets_in_list(sdev, true, &dyn_widgets, verify);
+	if (ret < 0)
+		return ret;
+
 	list_for_each_entry(sroute, &sdev->route_list, list)
 		sroute->setup = false;
 
-- 
2.51.0


