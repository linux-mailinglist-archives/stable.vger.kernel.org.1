Return-Path: <stable+bounces-103986-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B10C69F08F5
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257B318823CF
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CED21ADFF1;
	Fri, 13 Dec 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bXpJ51Iy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D2B18BBAC;
	Fri, 13 Dec 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084099; cv=none; b=IQ76geFjsceEpweP/Q4j4F/bE69C2GvwBqUByrCv9t5yTSk29queVGzXjTR5V/aCW4+wOjI4RhM/IAJlCAO4y/7sfRmwZy35HX4qglP5PktZ8c/qmQLLCF1G41XicOu/uPuzueM/jQgISMCKVf+os/K34mmRm0XCwUFvupTIN7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084099; c=relaxed/simple;
	bh=qw9oW3iPsnh4OzlwvVyc5+L7+eMkhfq/GjLyGWsqTLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DstBUssNbheqAc8riBzMhwUZFZfZeYcx5duLwRZPzCKTYvp2tyko65neS/ybMHfJ30Y7rsxvLDjdHSLo0wxxbYlYO7bCu3C/t+gCEncnPanorGR9eEqcgZFFbs4kzE8Wm85ogbbPTtUu+mZVwD6ZmuCvh0bdOCbgx2rC0l/p4c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bXpJ51Iy; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734084097; x=1765620097;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qw9oW3iPsnh4OzlwvVyc5+L7+eMkhfq/GjLyGWsqTLc=;
  b=bXpJ51IyUI2IierU8W+vFUCmYHqsKZX4RyCoo52c9WHjoj3bzfaSkPmg
   5oaOwU2OrEHYCOjq9d9tAYvE+5nnODxZ0AbGTE5QYw2A/wZKQ3fW3N8TD
   EAlpBbxhR4ogBMTfx8Z0r932kY9ZPazD8A3DPHbvu3CVgVX6KGs244rn6
   c0RFp38jiHoi3QgIg8CE0vDJ3XfWGY1vz/jp7AsvKcW3Lh7pTZ2z/tVZy
   ID9vLHsVFgbhtCGQHi7pzdoEJid3DZ4Nuh/QAnF7gEC4DGtVI7lv1c0zg
   u1UnI8O+ZGxL1F5esj3hEf+WosJC7Wlhhyv6seuQaPWn9clwuY2QJT/S1
   Q==;
X-CSE-ConnectionGUID: jLd5O/wmR7COQ3xussGT1A==
X-CSE-MsgGUID: F+Ady5ypQG6+pVBxoLYI2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="38209505"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="38209505"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 02:01:35 -0800
X-CSE-ConnectionGUID: abSzvcv5Qze85sJWkxnjHw==
X-CSE-MsgGUID: hZi4RbQXQuaQc7ryzXgvsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="101346226"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 02:01:32 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	liam.r.girdwood@intel.com
Subject: [PATCH] ASoC: SOF: ipc4-topology: Harden loops for looking up ALH copiers
Date: Fri, 13 Dec 2024 12:01:46 +0200
Message-ID: <20241213100146.19224-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other, non DAI copier widgets could have the same stream name (sname) as
the ALH copier and in that case the copier->data is NULL, no alh_data is
attached, which could lead to NULL pointer dereference.
We could check for this NULL pointer in sof_ipc4_prepare_copier_module()
and avoid the crash, but a similar loop in sof_ipc4_widget_setup_comp_dai()
will miscalculate the ALH device count, causing broken audio.

The correct fix is to harden the matching logic by making sure that the
1. widget is a DAI widget - so dai = w->private is valid
2. the dai (and thus the copier) is ALH copier

Fixes: 0e357b529053 ("ASoC: SOF: ipc4-topology: add SoundWire/ALH aggregation support")
Cc: stable@vger.kernel.org
Reported-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Link: https://github.com/thesofproject/sof/pull/9652
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index b55eb977e443..70b7bfb080f4 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -765,10 +765,16 @@ static int sof_ipc4_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 		}
 
 		list_for_each_entry(w, &sdev->widget_list, list) {
-			if (w->widget->sname &&
+			struct snd_sof_dai *alh_dai;
+
+			if (!WIDGET_IS_DAI(w->id) || !w->widget->sname ||
 			    strcmp(w->widget->sname, swidget->widget->sname))
 				continue;
 
+			alh_dai = w->private;
+			if (alh_dai->type != SOF_DAI_INTEL_ALH)
+				continue;
+
 			blob->alh_cfg.device_count++;
 		}
 
@@ -2061,11 +2067,13 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 			list_for_each_entry(w, &sdev->widget_list, list) {
 				u32 node_type;
 
-				if (w->widget->sname &&
+				if (!WIDGET_IS_DAI(w->id) || !w->widget->sname ||
 				    strcmp(w->widget->sname, swidget->widget->sname))
 					continue;
 
 				dai = w->private;
+				if (dai->type != SOF_DAI_INTEL_ALH)
+					continue;
 				alh_copier = (struct sof_ipc4_copier *)dai->private;
 				alh_data = &alh_copier->data;
 				node_type = SOF_IPC4_GET_NODE_TYPE(alh_data->gtw_cfg.node_id);
-- 
2.47.1


