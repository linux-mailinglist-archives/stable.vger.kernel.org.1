Return-Path: <stable+bounces-104046-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BB39F0D1A
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79C2518837BD
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DC41E0492;
	Fri, 13 Dec 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l8nsXrat"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E601DFE33;
	Fri, 13 Dec 2024 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734095595; cv=none; b=QFl8xGIuYJdYeY/ZvcpfeA0F7m46w9dnNPXwfsd10IVReshAPRzNwA7hB6lrApFylTlDkjfereW0nja5FHoBaEdsThWKMbvg2vW/w3qWCKtyWSeqOcSjKIzbUH6bqBQKG4uRFaYk5XR3Me5voHb5vSNhrYPp6jJzy18/w0ys8Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734095595; c=relaxed/simple;
	bh=m9Cc0WXogpmNGL1tPA+MNfKgIy+99qYGf3E9bEfbkms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olMDrD7BCuIDhLG20zmbzSZE9dMi2JSrWHQLxCDd88KWRC5qQyhsgnorIrakGfnf3fQKzMAk3yXptQtmr7aCD+LiEEX00roiXuL0XybXaGD65rWwjVA2C0NI2OEH2NFz7WqoZw254sZeGDJ3HjlhJZuTpWcyc/ht0/eGtxx/XOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l8nsXrat; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734095594; x=1765631594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m9Cc0WXogpmNGL1tPA+MNfKgIy+99qYGf3E9bEfbkms=;
  b=l8nsXrat21KpfZTjmnL9ld8PSsJyO+S6uFiU6eLfeuMUN6MmIJfyWG2C
   ayCtQ6ZElE+FkLwfNm3KirOVNfvMOf6D6ELQqLVqB4qAqnL/JNIsQX4me
   saA78vxXoSs/75uk6OJm86S5w5Y6xzJS9qDho8Jxo0VVhowi3PB+M3SU2
   cHHvTPA/JupK0lD5GWGR8yT/WX56eAESAXSHyfzFavyQ7H5R/EjNVQasq
   6566vgNBm5D+mI1T9xqAnmZQFBSgEQAy+XBZaRrV9H4U5UrV0/fjB9yzY
   jqdPY4ttuwv+QsKjuvY7/1sTG/EnBSZ5NKcb0jRKjNHEgAJ4vRZMFpsRM
   w==;
X-CSE-ConnectionGUID: V5G2oDawRN+WQmZukfGgbg==
X-CSE-MsgGUID: whPllJFCQBSmwsyB69dQXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34782351"
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="34782351"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 05:13:14 -0800
X-CSE-ConnectionGUID: CbxJOuTJS8GVRUnH3upUNA==
X-CSE-MsgGUID: ztBrkSaJS+6uo6Q/SbwM9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97321086"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 05:13:11 -0800
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
Subject: [PATCH 2/2] ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close
Date: Fri, 13 Dec 2024 15:13:18 +0200
Message-ID: <20241213131318.19481-3-peter.ujfalusi@linux.intel.com>
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

The spcm->stream[substream->stream].substream is set during open and was
left untouched. After the first PCM stream it will never be NULL and we
have code which checks for substream NULLity as indication if the stream is
active or not.
For the compressed cstream pointer the same has been done, this change will
correct the handling of PCM streams.

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
 sound/soc/sof/pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 35a7462d8b69..c5c6353f18ce 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -511,6 +511,8 @@ static int sof_pcm_close(struct snd_soc_component *component,
 		 */
 	}
 
+	spcm->stream[substream->stream].substream = NULL;
+
 	return 0;
 }
 
-- 
2.47.1


