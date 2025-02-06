Return-Path: <stable+bounces-114042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07335A2A372
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 09:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40300167686
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 08:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409BB211A0B;
	Thu,  6 Feb 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aptB4uY+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75316163;
	Thu,  6 Feb 2025 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831569; cv=none; b=WNw42oUyPgcbHaYJPN4vMFJ3YTuLQGAADoEIIn5rC3UUr0mM3c/005rrn8sqC9FDc7XDIqtlELKcPjfMhrCBjRLR8ptjkprdr/bHCfz61hqfRs38WsEXz+9ofeTrPWaJ3FdqoNHIa5H8Hr3tfndPFwDEzzBdS9PTnNqQjMN+Sak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831569; c=relaxed/simple;
	bh=spCN6FeE+M+aDIJ3KzHNheShZd2wstdZe7hwA/7tlA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WEGXBqC+LjXp/cTYhFiLFrJOv39fyCHeieiZaFBZi58ltkjCg2GS0FgxmFhwOfg8MKx0OEWq0sAeTmKAesva3+Pn+OCcAWRvz/qUfe6scN3vkorkkVUtEfx8y4BZf/63Nv7fMxWNwRb/J8P0qWS2Pm2bIgXxseFYwcDJ5eai8ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aptB4uY+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738831568; x=1770367568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=spCN6FeE+M+aDIJ3KzHNheShZd2wstdZe7hwA/7tlA0=;
  b=aptB4uY+xsB8JluYOjoaZ2NK6cUSlQgUeclhZS4pWpbiXy3IGlwWcXWW
   o2GrSv7yHTO86e4cxN+fE05xxuWMKj6M383V9r0+/5Pcdj1kbjDWBVNwC
   o4f1lvqNHL4ilcwGL6IcMTviKxbb8plxEpLdvluKIkp5wZQ/KpepYR5Vw
   MoAL6J6nnvWE/oOxliyMBOBsoE5vq8dRsqMKB0nntRHhSiNU5xrZrl9ip
   zt7kZPGt2L12zzurifNNiLubb/Aj1ehkSTIvm//g4I8vett/MyYNLyyAf
   yMn7/Duo9pDeGWml9G8UdIu2s/A6xEJo8nc9udh5QJMJjOyLl/IldXnDp
   g==;
X-CSE-ConnectionGUID: cb9yioxtRBSgGDnH19PNlw==
X-CSE-MsgGUID: BPgW9ShXTJ+X7i2aoZkMPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56971693"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="56971693"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 00:46:07 -0800
X-CSE-ConnectionGUID: Wimc59UpQ1y8idjElWsk6g==
X-CSE-MsgGUID: cj5cGw7BQe24kjrxFWPWig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="116183268"
Received: from dprybysh-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.33])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 00:46:04 -0800
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
Subject: [PATCH v2] ASoC: SOF: ipc4-topology: Harden loops for looking up ALH copiers
Date: Thu,  6 Feb 2025 10:46:42 +0200
Message-ID: <20250206084642.14988-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other, non DAI copier widgets could have the same  stream name (sname) as
the ALH copier and in that case the copier->data is NULL, no alh_data is
attached, which could lead to NULL pointer dereference.
We could check for this NULL pointer in sof_ipc4_prepare_copier_module()
and avoid the crash, but a similar loop in sof_ipc4_widget_setup_comp_dai()
will miscalculate the ALH device count, causing broken audio.

The correct fix is to harden the matching logic by making sure that the
1. widget is a DAI widget - so dai = w->private is valid
2. the dai (and thus the copier) is ALH copier

Fixes: a150345aa758 ("ASoC: SOF: ipc4-topology: add SoundWire/ALH aggregation support")
Reported-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Link: https://github.com/thesofproject/sof/pull/9652
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
Hi,

Changes since v1:
- correct SHA in Fixes tag

Regards,
Peter

 sound/soc/sof/ipc4-topology.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index c04c62478827..6d5cda813e48 100644
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
2.48.1


