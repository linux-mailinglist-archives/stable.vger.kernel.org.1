Return-Path: <stable+bounces-104045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0372B9F0D18
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDF81885E33
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E8D1E04B4;
	Fri, 13 Dec 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDWcTifu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05391E0492;
	Fri, 13 Dec 2024 13:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095592; cv=none; b=oF5wYKGrC/VYjJ159xx8ZvWLtREbNiM3hCyvHMDx0YMZBEZZ0FGwS6MrJLaYX3QjFgcel+D0Pe7v9k9bivryqywef7H5pOEQnTsfyke3AX5D8Vi4b1AhwFZMEkj0KmsbvqYGW85/ziIaXrTaHZWPxM38UxG8JjwuIiBic/B3dug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095592; c=relaxed/simple;
	bh=KCyfa7hB9jjBgOTp15FAjB5/o5n2N1ypIE4gBPnFqmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHX56GkovUQs5rMpfjQ7vVHrGjZQ+iXS2tzOBBEEZMwD9WHxLpbxC0hT9PVtg/UeuSWmhxl5+3lHBHgTEnjBHlnGGHVauhWFo8LicM27pGfpD1rKnfkE9SY93by18YOM5xv0gmleqt2j/4qiv9z1GWhlrYpRkr5LVxpYOAWx7iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gDWcTifu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734095591; x=1765631591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KCyfa7hB9jjBgOTp15FAjB5/o5n2N1ypIE4gBPnFqmg=;
  b=gDWcTifuZkIm5X/3Oyhqt6DYnV7HTmM8bYjM4++9zQRS456iuA/Fs6fH
   cZTaebjnYl61TaKEYDMIRLrCP0kifi5GYzN6o7YWLBlIjTgLhpTwry/E0
   +FNl0sMt3WN2lTV4k9m2aO9Wi9Co5Thw4M1RIt9xMRWic3Pd+nTVGNHpM
   02S9Ma/YPQLOg9cSRugGQa4ZaHFLx8abfZudxmn8K0naThmb8YZYsqql3
   oAwup5TAK8TN5gLXij70LFftOPFd3ZZkgRJK6PoXM4b2C7QflwkF8vVq4
   trwWhCHzcznjZbcLw3+LKOCEqqOBu0D6t2MTRS4GBrpfohoecRvNcbNRG
   w==;
X-CSE-ConnectionGUID: 30acMqfxTHiu6hiu8ty8wg==
X-CSE-MsgGUID: yjP3+yp1SsenXRqzPevHyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34782344"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="34782344"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 05:13:11 -0800
X-CSE-ConnectionGUID: Q0bVV4uORnKbqGAuBq3C5g==
X-CSE-MsgGUID: w7GIOD5QQ1CbfujSHs3Zng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97321074"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 05:13:08 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	cujomalainey@chromium.org,
	daniel.baluta@nxp.com
Subject: [PATCH 1/2] ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
Date: Fri, 13 Dec 2024 15:13:17 +0200
Message-ID: <20241213131318.19481-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213131318.19481-1-peter.ujfalusi@linux.intel.com>
References: <20241213131318.19481-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nullity of sps->cstream should be checked similarly as it is done in
sof_set_stream_data_offset() function.
Assuming that it is not NULL if sps->stream is NULL is incorrect and can
lead to NULL pointer dereference.

Fixes: ef8ba9f79953 ("ASoC: SOF: Add support for compress API for stream data/offset")
Cc: stable@vger.kernel.org
Reported-by: Curtis Malainey <cujomalainey@chromium.org>
Closes: https://github.com/thesofproject/linux/pull/5214
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>
---
 sound/soc/sof/stream-ipc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/stream-ipc.c b/sound/soc/sof/stream-ipc.c
index 794c7bbccbaf..8262443ac89a 100644
--- a/sound/soc/sof/stream-ipc.c
+++ b/sound/soc/sof/stream-ipc.c
@@ -43,7 +43,7 @@ int sof_ipc_msg_data(struct snd_sof_dev *sdev,
 				return -ESTRPIPE;
 
 			posn_offset = stream->posn_offset;
-		} else {
+		} else if (sps->cstream) {
 
 			struct sof_compr_stream *sstream = sps->cstream->runtime->private_data;
 
@@ -51,6 +51,10 @@ int sof_ipc_msg_data(struct snd_sof_dev *sdev,
 				return -ESTRPIPE;
 
 			posn_offset = sstream->posn_offset;
+
+		} else {
+			dev_err(sdev->dev, "%s: No stream opened\n", __func__);
+			return -EINVAL;
 		}
 
 		snd_sof_dsp_mailbox_read(sdev, posn_offset, p, sz);
-- 
2.47.1


