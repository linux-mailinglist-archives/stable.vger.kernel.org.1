Return-Path: <stable+bounces-201036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDACCBDB84
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 13:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 695C23046143
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B251D2E62A4;
	Mon, 15 Dec 2025 12:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="naJGFOsk"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42BB31576C;
	Mon, 15 Dec 2025 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765800394; cv=none; b=pV4ps26CZ1l00zVYCBxnXL2/ZzDrLzW76aB16h6jFN3LzwhUH/K/Vs70Hs+sO+lNi8G6Ewqj0xZqZ6rwirSTZjayqvQ6WAA7rPwstre25JUXQHcCvE1KUorcBWSfoeeIlJb13Yx+Vco/WAPkdLf3AdLfwPEmkuhC4igAox3bzl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765800394; c=relaxed/simple;
	bh=3w195lTeA427JhBVpY9W0LlvTXY7Sd19E50zKAalcOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAjYkeKJ+brzs/EQxw9m4diniGfEgwtb1XpXvyvmFExqm7zIDD/u7UU3mF7FmSTMqWZtBHgD1wBTpFihsLFUrz+FRaEcAXCSbsKOi0UaomwhGqlojqhXdEsnDsrJ4lo2qtGJr31n/ff976+KtmRRsBFUZR9djJAsU7xHashE38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=naJGFOsk; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765800393; x=1797336393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3w195lTeA427JhBVpY9W0LlvTXY7Sd19E50zKAalcOg=;
  b=naJGFOskMhn1i47yDwHnqcCJANa2mW96tQK8eArlQ3aaA2/pFUHEeLQf
   Gq9YOTlaN/0DsqC7Irv9hudnZhfzsOw9mtcG4g2/GMwqHjYglb7ced+tp
   mRrZ9+KzBC4c92RwZAkWSOFM+dwS4TwBJdz5aNfTHtv8LYx/fJsGZ4vZ7
   3s8Gi8oP7Kl4m/dxDOFojQ1zEgVAQYFTHWSavqIpgMWWEsFQLKhpO82ph
   m6KiK7nIqejbdpPM8qY96VEIr+j0wgRqXZCaW6EcFzYzFi8gUq7uZzuQ9
   cU3zoZ0CcjnU1x7I/8i4eyRoMA16bN5zwv8PWbtWzz9o6eOLuPzXOm++l
   g==;
X-CSE-ConnectionGUID: HdcFOOqQRnm3u/K9bXz3zw==
X-CSE-MsgGUID: 8DBMCx8wSmi8KfpC8pTGrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="90354182"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="90354182"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:06:33 -0800
X-CSE-ConnectionGUID: gFw3qecsT66oSbPx/5aYmQ==
X-CSE-MsgGUID: IEyrhzdLTt6wKdH39UEX8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="196788260"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.95])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 04:06:29 -0800
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
Subject: [PATCH 2/2] ASoC: SOF: ipc4-topology: Convert FLOAT to S32 during blob selection
Date: Mon, 15 Dec 2025 14:06:48 +0200
Message-ID: <20251215120648.4827-3-peter.ujfalusi@linux.intel.com>
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

SSP/DMIC blobs have no support for FLOAT type, they are using S32 on data
bus.

Convert the format from FLOAT_LE to S32_LE to make sure that the correct
format is used within the path.

FLOAT conversion will be done on the host side (or within the path).

Fixes: f7c41911ad74 ("ASoC: SOF: ipc4-topology: Add support for float sample type")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Seppo Ingalsuo <seppo.ingalsuo@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 47959f182f4b..32b628e2fe29 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1843,7 +1843,7 @@ snd_sof_get_nhlt_endpoint_data(struct snd_sof_dev *sdev, struct snd_sof_dai *dai
 	*len = cfg->size >> 2;
 	*dst = (u32 *)cfg->caps;
 
-	if (format_change) {
+	if (format_change || params_format(params) == SNDRV_PCM_FORMAT_FLOAT_LE) {
 		/*
 		 * Update the params to reflect that different blob was loaded
 		 * instead of the requested bit depth (16 -> 32 or 32 -> 16).
-- 
2.52.0


