Return-Path: <stable+bounces-202861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6F6CC8812
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADE96301B880
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3A8361DD7;
	Wed, 17 Dec 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjzFnYpi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA9339879;
	Wed, 17 Dec 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982373; cv=none; b=KxKkIg+OO7V3iLNNIaJIHbZ8OAy1hn67vxHH1ElZKdlwZYaH9D3zNcCQrgRuedIRhfdtoBKSoadlXP963saAhHpuCFBDaD3NTEOWS1mTDKR/9vzHvc5gq7yiPKEo7v+Ziy8MKQr6Ighkgx0StL47KhYxsnw1/g34ObSSEpnH6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982373; c=relaxed/simple;
	bh=29PEX+YEsndcCitNNHudVWhum0++a0OjKhYxwHitI04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WS3zzKOvIXmfWxAWX1LJshr2ZDZPMQFvTJPlakAW3rCvjqOeXp8qeSASG4chgxt/nvkqU5n6irsEFIbAnlWMiBmFJeXsYQPvVVYn9ELZ/73xYhZh79A4Ggib4jyxseNDbBXCOH8cYzXGa2ICrdAGiOCaduxLisgHyQMsR++pSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjzFnYpi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982372; x=1797518372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=29PEX+YEsndcCitNNHudVWhum0++a0OjKhYxwHitI04=;
  b=SjzFnYpi2aCjC0KjNcur9l58qSsyF0IGtqhGilatZM4zwjw1na78SQsG
   sPQyEHSu3S9zS+UaSY2veKLt1KVrMozBKj2byFzHYFm4Ir3XufqBmZzdp
   nXTO/2PMRb7ONbL758I/lAKeY9+FJ1s1gJzxW1fQoJW/+BloR2fWHuN/M
   lQe+6Ob32UwMWNQimbbQ+ifOQ/Zl/lk80thE51IKABzs6fXwD1Qe4gqkZ
   6noygBVsfpwSQlGjPKFNgaoqbP2xj0VNU/JNON2rz1xvy+LiflGG/ve5u
   ZzF4ZJuhnhWAEAbVu0PTR96ndKZTh5ft67RNbywzIPWJC9BR/AUZDLD9z
   Q==;
X-CSE-ConnectionGUID: Q0TLijGJTxS6sVFLvPhkug==
X-CSE-MsgGUID: cydXfW+cTjqR/ihvjrNjaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67859843"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67859843"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:32 -0800
X-CSE-ConnectionGUID: eM2jtOarQ2ieMTC2b1DqGg==
X-CSE-MsgGUID: 1z7kHxL7R/SZwUCogb89lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="198084940"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.187])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:39:28 -0800
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
Subject: [PATCH v3 3/8] ASoC: SOF: ipc4-control: Use the correct size for scontrol->ipc_control_data
Date: Wed, 17 Dec 2025 16:39:40 +0200
Message-ID: <20251217143945.2667-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143945.2667-1-peter.ujfalusi@linux.intel.com>
References: <20251217143945.2667-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of the data behind scontrol->ipc_control_data is stored in
scontrol->size, use this when copying data for backup/restore.

Fixes: db38d86d0c54 ("ASoC: sof: Improve sof_ipc4_bytes_ext_put function")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4-control.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 0a05f66ec7d9..80111672c179 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -66,7 +66,7 @@ static int sof_ipc4_set_get_kcontrol_data(struct snd_sof_control *scontrol,
 		 * configuration
 		 */
 		memcpy(scontrol->ipc_control_data, scontrol->old_ipc_control_data,
-		       scontrol->max_size);
+		       scontrol->size);
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
 		/* Send the last known good configuration to firmware */
@@ -567,7 +567,7 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
 	if (!scontrol->old_ipc_control_data) {
 		/* Create a backup of the current, valid bytes control */
 		scontrol->old_ipc_control_data = kmemdup(scontrol->ipc_control_data,
-							 scontrol->max_size, GFP_KERNEL);
+							 scontrol->size, GFP_KERNEL);
 		if (!scontrol->old_ipc_control_data)
 			return -ENOMEM;
 	}
@@ -575,7 +575,7 @@ static int sof_ipc4_bytes_ext_put(struct snd_sof_control *scontrol,
 	/* Copy the whole binary data which includes the ABI header and the payload */
 	if (copy_from_user(data, tlvd->tlv, header.length)) {
 		memcpy(scontrol->ipc_control_data, scontrol->old_ipc_control_data,
-		       scontrol->max_size);
+		       scontrol->size);
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
 		return -EFAULT;
-- 
2.52.0


