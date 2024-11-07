Return-Path: <stable+bounces-91828-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE699C07D1
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF48BB239BD
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 13:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D014A21262E;
	Thu,  7 Nov 2024 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyUa4dII"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D5F212196;
	Thu,  7 Nov 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987001; cv=none; b=Yl+0U/c9nDSDk7X4lmnSyIDcK75KKmA94L8dzErZK8T6V0ytgN0DxPVPzixRkostj4sD2Lmhme3iiEDdF5tv/6gZwZhXisKupdQK+L7UlozH91KC11txYIemrR0hOVAUWLUBewGrEnSUSUXlOjtgG3JtztWt/A4Y7k/uYDE3B+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987001; c=relaxed/simple;
	bh=LqqhwPlxcO2JxdSrcs3Lu3AmePjO62vwDBMdtAmA4fk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quYEa+HZ51VLQOUxyIjSZJHuEMa7juZZTeArNbk5zCtDhhhSjVASjiQjBFY0ardteycsRzp3k6P9jkEepa3Al2o/rJ+HK1I3ViW+3ZQJY3ZMzapHcJJ2GhDSyEWD69yfd4v6hdmLN9YGf7bcYAsJOJz9UaRlnFFGZcEA90/+ppA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyUa4dII; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730987001; x=1762523001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LqqhwPlxcO2JxdSrcs3Lu3AmePjO62vwDBMdtAmA4fk=;
  b=nyUa4dIIDabVton2yGLFDnT3ZJ8n6MT6L8jluaUiMTgm9gD8OmzThjN5
   lWUyFCTF+3DaUb4PDPd/RLyIvgxmu4dFGrUZsMj2hhsGB9GsEMoWbQTw7
   95jcVhpmR02GUS+/vv/lYuQl0+RCbznyxjd7GzPNNngPB6qz4i6JOd5YB
   9GNajKKTC7N1tc0CK5gRs3IdQ8O4eVwgkOIoMRV2jfF1IyfBm0I4BzteB
   kCjaPKHfnJx/dvbO4BoN+v4w+15Nc0nGIiNMmppUDRHBUPTbYEpdOCvSl
   sB4QilYmnswcy6j/W8R7sOoazwFmq5nuSbcI++Zo+Z+EgKsJQtTrPtRHA
   Q==;
X-CSE-ConnectionGUID: UBV6NdNxTVqT7w6R6NWKPw==
X-CSE-MsgGUID: qJ7Ex6jrQFGdFdFo8Oplvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34522549"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34522549"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:43:20 -0800
X-CSE-ConnectionGUID: 58OT36gzQnyQ8h871PZbxw==
X-CSE-MsgGUID: scpyjLQZQf61Efl2Yydb/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="115920708"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.205])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 05:43:17 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	cujomalainey@chromium.org,
	daniel.baluta@nxp.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close
Date: Thu,  7 Nov 2024 15:43:08 +0200
Message-ID: <20241107134308.23844-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241107134308.23844-1-peter.ujfalusi@linux.intel.com>
References: <20241107134308.23844-1-peter.ujfalusi@linux.intel.com>
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
2.47.0


