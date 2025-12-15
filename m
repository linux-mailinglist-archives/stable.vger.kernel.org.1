Return-Path: <stable+bounces-201035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6CCBDB18
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 13:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D31FB3005D29
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 12:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFC32C17B6;
	Mon, 15 Dec 2025 12:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ggwr2x02"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7810223DFB;
	Mon, 15 Dec 2025 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800391; cv=none; b=t3Lb3UYW7hA/YkIETsO87lBko/P5lUMoslcOrorKWQD4BWB/i3g3uThU4sedT1H5HcG4wN5ga+5hdTV3S6eut3//3GQR3cV7Q0ELt6yQBEp6uuDGiNp/bs8QBqYyKBUNY5Fnsza/mM8irBG0FKoaYbAEbsvqtsZ+pRn7odB/KXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800391; c=relaxed/simple;
	bh=OqsQvWnH71Vurs1FIOJkphIS5hZd4oaUD82Xxv9BPWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5pjHc/zzS0a/maBixGx08ldNNFvYzR6NcbatVh+X8n1TAR0jQRNdJp8v/NYCovfvaX9Jk5Mz0poQbBSOk3oc2pY+EfVAYYJFu1Ovr060WkuLvrM9W/wKZVm/DWOm+cUjMBa8p37PeNQm4Ld4y1TNzvOzIlX/UQJKUzfKfifA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ggwr2x02; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765800390; x=1797336390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OqsQvWnH71Vurs1FIOJkphIS5hZd4oaUD82Xxv9BPWY=;
  b=Ggwr2x02WIFSiDCUSLkI5g2NhD3lYTrFkqqduTOytCyt2GgqdeBWprMe
   uRSH82QApQxHd3ayP18RzXCpsK8+pjRi3BaygLEpXF09ccb1TLGjIbej6
   KwkYCxn8FaTecJSFp5ab/rkZZO3pG2mRNxlU+qsP2Px57DcfC161f94Eu
   hc1j05COTQhcovzXGEgpGZ6CWvEUDZhUKbYjoauL/1GMXOLPx/ALph9cG
   IKgIW7ix5vcItSZFF1R0ZS+C/WyEGGDsoM6zpMuTRyBfZ3mijD99fvWJ2
   hqfySqJW6LsQF1mx5smojwgfiPnU9kqmzjPTm/1YrKJqQ/H4sAaJt7m51
   g==;
X-CSE-ConnectionGUID: F9w5Yo93RTOMyDWOImrWuA==
X-CSE-MsgGUID: iVYLJbvBRXWaI0QFyzt+tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90354173"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="90354173"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:06:30 -0800
X-CSE-ConnectionGUID: hmaOun/1QeaduSjUAVz9Cg==
X-CSE-MsgGUID: wtCKRAMYRN2SuchyRI58GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="196788233"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:06:26 -0800
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
Subject: [PATCH 1/2] ASoC: SOF: ipc4-topology: Prefer 32-bit DMIC blobs for 8-bit formats as well
Date: Mon, 15 Dec 2025 14:06:47 +0200
Message-ID: <20251215120648.4827-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215120648.4827-1-peter.ujfalusi@linux.intel.com>
References: <20251215120648.4827-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of 8-bit formats the DMIC blob lookup also needs to
be modified to prefer the 32-bit blob when 8-bit format is used on FE.

At the same time we also need to make sure that in case 8-bit format is
used, but only 16-bit blob is available for DMIC then we will not try to
look for 8-bit blob (which is invalid) as fallback, but for a 16-bit one.

Fixes: c04c2e829649 ("ASoC: SOF: ipc4-topology: Add support for 8-bit formats")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 221e9d4052b8..47959f182f4b 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1752,11 +1752,9 @@ snd_sof_get_nhlt_endpoint_data(struct snd_sof_dev *sdev, struct snd_sof_dai *dai
 		channel_count = params_channels(params);
 		sample_rate = params_rate(params);
 		bit_depth = params_width(params);
-		/*
-		 * Look for 32-bit blob first instead of 16-bit if copier
-		 * supports multiple formats
-		 */
-		if (bit_depth == 16 && !single_bitdepth) {
+
+		/* Prefer 32-bit blob if copier supports multiple formats */
+		if (bit_depth <= 16 && !single_bitdepth) {
 			dev_dbg(sdev->dev, "Looking for 32-bit blob first for DMIC\n");
 			format_change = true;
 			bit_depth = 32;
@@ -1799,10 +1797,18 @@ snd_sof_get_nhlt_endpoint_data(struct snd_sof_dev *sdev, struct snd_sof_dai *dai
 		if (format_change) {
 			/*
 			 * The 32-bit blob was not found in NHLT table, try to
-			 * look for one based on the params
+			 * look for 16-bit for DMIC or based on the params for
+			 * SSP
 			 */
-			bit_depth = params_width(params);
-			format_change = false;
+			if (linktype == SOF_DAI_INTEL_DMIC) {
+				bit_depth = 16;
+				if (params_width(params) == 16)
+					format_change = false;
+			} else {
+				bit_depth = params_width(params);
+				format_change = false;
+			}
+
 			get_new_blob = true;
 		} else if (linktype == SOF_DAI_INTEL_DMIC && !single_bitdepth) {
 			/*
-- 
2.52.0


