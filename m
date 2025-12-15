Return-Path: <stable+bounces-201056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B16DCBE439
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EC8D30133D8
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C22230DEC0;
	Mon, 15 Dec 2025 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I9/XbZhn"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989A33F372;
	Mon, 15 Dec 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808717; cv=none; b=PT+2KiBHgEw0fzUS9gG4st+tZ5hMfh3lhLc+pgcGBmWoBGBHTOBu+J5zMvdPiM1PkGgwTnTNcYq6yG43fTnGIWAlBU7fo3buFg+vsNa85Ft0htvDYMO8Ab838tBItQUEfajqM/ZdoIZ4QCJBUWmr2wvH3+AKoAquyaqZ1oVtrrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808717; c=relaxed/simple;
	bh=1Ua+Er1bQjQlLZtsb6Fc0xd2WdDFGcd6pWBBQjpxee0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/qnX8I0iwhEpmltE12n5egCKauIfd7GA7TvLh2hFnYhdLhGV2tnJq/ZPa2E/5eFwEC9+/koy6egd5ga8+2kw0zarwbO5XuPu/qzoNNR7JoQB/SUBw+XvcT5U6XCLb+US8ntM781myjG/vQf3uMx7nC62pDw2I5Q5tigoaE0HQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I9/XbZhn; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765808716; x=1797344716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Ua+Er1bQjQlLZtsb6Fc0xd2WdDFGcd6pWBBQjpxee0=;
  b=I9/XbZhnKbMvh+XL8VOdaoYLJfuuZ8EbkyQh74vm8gQADknWQmbJWwNd
   aAwO0bgD6svwO/1ihKTDHwVfNqJ0D4McRjrDNAbgMqElcjFMVrqxnfSsP
   132svPlbozHkZHHHVpZ7H6WtRfrP09BoQ5itN+S+vxwPaA5OVYCtoZKam
   GBjVIqx3OAlJ8IkEwi6cMEieXTD8V1UhdA5g76TkZ/1Clvm8oaih11pEf
   QipSKkmkkp75IwGa78gtDlZNLaC9I+MAJjqILIFADaYcBigVIq+dyYdFM
   EBktKVvWO4fRCCpQkz7dHKj4H1LYYgUtGmn5k0E7gDcNb8HfgPhjtrwo/
   g==;
X-CSE-ConnectionGUID: Ehiyp8ZtSHWI76vSUuZ4fg==
X-CSE-MsgGUID: ZeQVId+gTmCo2b/8sCeudg==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67866473"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67866473"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:15 -0800
X-CSE-ConnectionGUID: Fwt1Exv/SGiG1peXCfkN9g==
X-CSE-MsgGUID: sOAOa+J2RV+4BvPZYlLmXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197362515"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:25:13 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	seppo.ingalsuo@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2 7/8] ASoC: SOF: ipc4: Add definition for generic bytes control
Date: Mon, 15 Dec 2025 16:25:15 +0200
Message-ID: <20251215142516.11298-8-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
References: <20251215142516.11298-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently IPC4 only supports module specific custom bytes controls, where
each control's param_id is module specific.
These bytes controls cannot be handled in a generic way, there is no clean
way to support for example notifications from firmware when their data
has been changed.

Add definition for generic bytes control which should be handled in a
similar way as the enum/switch controls.

The generic param id for BYTES is selected to be 202

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.h | 9 +++++++--
 sound/soc/sof/ipc4.c          | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.h b/sound/soc/sof/ipc4-topology.h
index 191b51d97993..9a028a59c553 100644
--- a/sound/soc/sof/ipc4-topology.h
+++ b/sound/soc/sof/ipc4-topology.h
@@ -368,19 +368,24 @@ struct sof_ipc4_control_data {
 
 #define SOF_IPC4_SWITCH_CONTROL_PARAM_ID	200
 #define SOF_IPC4_ENUM_CONTROL_PARAM_ID		201
+#define SOF_IPC4_BYTES_CONTROL_PARAM_ID		202
 
 /**
  * struct sof_ipc4_control_msg_payload - IPC payload for kcontrol parameters
  * @id: unique id of the control
- * @num_elems: Number of elements in the chanv array
+ * @num_elems: Number of elements in the chanv array or number of bytes in data
  * @reserved: reserved for future use, must be set to 0
  * @chanv: channel ID and value array
+ * @data: binary payload
  */
 struct sof_ipc4_control_msg_payload {
 	uint16_t id;
 	uint16_t num_elems;
 	uint32_t reserved[4];
-	DECLARE_FLEX_ARRAY(struct sof_ipc4_ctrl_value_chan, chanv);
+	union {
+		DECLARE_FLEX_ARRAY(struct sof_ipc4_ctrl_value_chan, chanv);
+		DECLARE_FLEX_ARRAY(uint8_t, data);
+	};
 } __packed;
 
 /**
diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index 20d723f48fff..2be8d8ce487a 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -445,6 +445,7 @@ static bool sof_ipc4_tx_payload_for_get_data(struct sof_ipc4_msg *tx)
 	switch (tx->extension & SOF_IPC4_MOD_EXT_MSG_PARAM_ID_MASK) {
 	case SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_SWITCH_CONTROL_PARAM_ID):
 	case SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_ENUM_CONTROL_PARAM_ID):
+	case SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_BYTES_CONTROL_PARAM_ID):
 		return true;
 	default:
 		return false;
-- 
2.52.0


