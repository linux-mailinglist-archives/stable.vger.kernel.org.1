Return-Path: <stable+bounces-183021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C76CBB2BB0
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1153C4BBE
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A872D0275;
	Thu,  2 Oct 2025 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bPmL3IUU"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35BE2BE651;
	Thu,  2 Oct 2025 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391198; cv=none; b=EQojsh12qR3LFDZRum7l/erZFJnAEFsCzrYDBub8S7IxpI5r4abyp1xMCWgkK88oV/y2q+a4Byb/+O9PiyTSnPCFiTusPjSwErToKf2whDyLU0Wi88pKDv9x3p8/zn/cx0D9m8S5IlmeIjQ8JnOhCGPPJkbWqE2GP+///nYEvTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391198; c=relaxed/simple;
	bh=bXCdBskQOijZZS2j2grssCbV/wBMa3Q5ZfeDjRydjcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PaaA1wSUvBhE+RBPaYwbyTAj1Qw310OMlAE3SCl0M9oMG4DFF/s2Klb7rJEpI8PJYcpdpf1htOFykC2dtDTrWkXv2rAD7tTqQi5IkeualnantEc6QR5Iee/lMW9hWoOSX35DkeUhk+GtruDkWlsOrnA6uHOTJEZGHme36LG2oIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bPmL3IUU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759391197; x=1790927197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bXCdBskQOijZZS2j2grssCbV/wBMa3Q5ZfeDjRydjcU=;
  b=bPmL3IUU3LAt8XwFjwjRRK3DItYbVYX+q642eRlMrLVqxTM9AVkgsABa
   Ylkj2WUcRvrk8FZuCGCl7mzGMgbxNw7DEIfAjdXsrMet0HeIlAEryYZm+
   sgCHSCfF6VjZfo9Mfxb3189NNOcl0pF+AqAE+dmXeSj31aYj8FK6SLWla
   rgA21DYzbPw9Ol3yyjL3HmfBY001Ykx7qxGv2iikQlzq7huWNiioGOqLx
   nk7G+SsJCPfVVfrD74cc5DFeG38DnfH1DyDTJBGbdRcMRM2k/WxF+mU5/
   3XI+dDjssTbUEwZnjyBjbTnu+z/SOnekFvoOE3vQSdQ5va4K3OL3WhAN8
   w==;
X-CSE-ConnectionGUID: BOWeJqvjRAmgETqiz1N7YQ==
X-CSE-MsgGUID: OGWss8VwQBKjCEHcWehmiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61630995"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61630995"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:37 -0700
X-CSE-ConnectionGUID: 7Jha8FDsQXu6/5/6KPCa2A==
X-CSE-MsgGUID: EtP80lIXQ2WBGIQh5PkOXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="179760350"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:34 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 4/5] ASoC: SOF: ipc4-pcm: do not report invalid delay values
Date: Thu,  2 Oct 2025 10:47:18 +0300
Message-ID: <20251002074719.2084-5-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
References: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Add a sanity check for the calculated delay value before reporting it to
the application. If the value is clearly invalid, emit a rate limited
warning to kernel log and return a zero delay. This can occur e.g if the
host or link DMA hits a buffer over/underrun condition.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc4-pcm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 9542c428daa4..6d81969e181c 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -59,6 +59,8 @@ struct sof_ipc4_pcm_stream_priv {
  */
 #define DELAY_BOUNDARY		U32_MAX
 
+#define DELAY_MAX		(DELAY_BOUNDARY >> 1)
+
 static inline struct sof_ipc4_timestamp_info *
 sof_ipc4_sps_to_time_info(struct snd_sof_pcm_stream *sps)
 {
@@ -1266,6 +1268,13 @@ static int sof_ipc4_pcm_pointer(struct snd_soc_component *component,
 	else
 		time_info->delay = head_cnt - tail_cnt;
 
+	if (time_info->delay > DELAY_MAX) {
+		spcm_dbg_ratelimited(spcm, substream->stream,
+				     "inaccurate delay, host %llu dai_cnt %llu",
+				     host_cnt, dai_cnt);
+		time_info->delay = 0;
+	}
+
 	/*
 	 * Convert the host byte counter to PCM pointer which wraps in buffer
 	 * and it is in frames
-- 
2.51.0


