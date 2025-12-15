Return-Path: <stable+bounces-201050-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E454DCBE48A
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 15:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9353B301D0C3
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 14:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ABC29BD94;
	Mon, 15 Dec 2025 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fm+GsuG2"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AAA22154F;
	Mon, 15 Dec 2025 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808699; cv=none; b=UZO/imeBZPd4ghLfwLlllooxcq3pnRjztqw1zoanngP4y5MlvW+5+4fuSDVXSMrm/ufvGxufuoNQZLVDHL7MDlEPBVl2XAVBqoqiG9odmuzjZXN6tnSKyOPSgoNsJpMj58QCv9xhT8w2wNEOQx5/J4k2h9gai83FAeq30ADizM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808699; c=relaxed/simple;
	bh=kOY13FM4fHZuGeAXmtW23FFbRnGam9T6ZD5pzo6LR2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIM0JC9yDy9Vvtm38Tm3EXwkiOUhO87Yi3BPmCzs1EJ4yMI92SNcI0cKcWFccHCTOQ/hEhDz0FqOfZsI58q6vcXdLMoxHbjtScsr4HBMZqZNH48eYmHRmzI2P7yTBxmOcCvBBNfWHPh9TToKiHrafamUb/oHUBX8+Dl9TzLrXqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fm+GsuG2; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765808698; x=1797344698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kOY13FM4fHZuGeAXmtW23FFbRnGam9T6ZD5pzo6LR2I=;
  b=fm+GsuG2DeuGQa+oGf2R8WT8HDZqqIYoGHjVh9sMzt1faGvtEzhyFPiX
   JQUHdPM+kKzeLpW1zavMbG4kBr+bzlOQ7NDW8JECB/puJpGZ/1hFWh/SH
   Kq8Z3mGWziX5BLMsRDQJAC4oR85ln+r/DsDG332atfSNxn8TFB4RyN0xO
   /NV51L1rrpiJ1BKOKfzAdnsH4kwLQ4kk0JaDu/aNgv6arVidJeh4dJACK
   dZy1ePwuT+Sdc94/VbTHFC6EbPKKqPNQLf3vpj1oXlxuknXsIpk+zf3oT
   vX8R2mROJ9Obs2tvsUpXDwg8Quu2D55a1lijxC7Z9N6Wef+MSbSZSQ+0R
   A==;
X-CSE-ConnectionGUID: L1QxrZC/QgaJ0om/hXUOYw==
X-CSE-MsgGUID: 0kKSJ8atQsa8xwrLtm329g==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="67866434"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67866434"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:24:58 -0800
X-CSE-ConnectionGUID: UMmVWCfMQrSFRpChnt49Bg==
X-CSE-MsgGUID: cBxtmnbOR7ainleiXYsj/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="197362356"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 06:24:55 -0800
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
Subject: [PATCH v2 1/8] ASoC: SOF: ipc4-control: If there is no data do not send bytes update
Date: Mon, 15 Dec 2025 16:25:09 +0200
Message-ID: <20251215142516.11298-2-peter.ujfalusi@linux.intel.com>
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

When the bytes control have no data (payload) then there is no need to send
an IPC message as there is nothing to send.

Fixes: a062c8899fed ("ASoC: SOF: ipc4-control: Add support for bytes control get and put")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4-control.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index 976a4794d610..0a05f66ec7d9 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -412,8 +412,16 @@ static int sof_ipc4_set_get_bytes_data(struct snd_sof_dev *sdev,
 	int ret = 0;
 
 	/* Send the new data to the firmware only if it is powered up */
-	if (set && !pm_runtime_active(sdev->dev))
-		return 0;
+	if (set) {
+		if (!pm_runtime_active(sdev->dev))
+			return 0;
+
+		if (!data->size) {
+			dev_dbg(sdev->dev, "%s: No data to be sent.\n",
+				scontrol->name);
+			return 0;
+		}
+	}
 
 	msg->extension = SOF_IPC4_MOD_EXT_MSG_PARAM_ID(data->type);
 
-- 
2.52.0


