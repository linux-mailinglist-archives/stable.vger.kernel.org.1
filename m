Return-Path: <stable+bounces-112441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78261A28CB7
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D61D73A470D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA911494DF;
	Wed,  5 Feb 2025 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SqaOP7Z0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67109142E86;
	Wed,  5 Feb 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763579; cv=none; b=XO5FBjqeHc2Gocu4DaBh4Y9V2ndqSH2K4Ni0Na6vl8K0WOWFC+XBM2GRl9LpBwstWWYDzGwWayAIII3ScHjk6ulXQ+DTDllcStku6XkATe1JlDTZN2Kb7GuQkFVo1zX3tbMNWVlOcOrwCDaSqfgPQY8cZ9Rvxj2gA7sprm6X7oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763579; c=relaxed/simple;
	bh=A8ZP+rNHEV4o32r8+XEvFWX3IZj7U1dxkNfg1CdtaQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4IVRykNzwe1VyGv603NeGyKY3rjt2dUnLCUbKeL7pFO6+ZR+LNZQ4vl0oxrLITcruLH7JO9gVF0ATbk2Dkvi0n4n2IB8Xo0izL7r+HHpacKq8Sp0Ifcx/KiPWDEXrer/4haq/4bsRQw2jUcaeUTHfxzWiYFZKucCpESSCA0pZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SqaOP7Z0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738763578; x=1770299578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8ZP+rNHEV4o32r8+XEvFWX3IZj7U1dxkNfg1CdtaQE=;
  b=SqaOP7Z0o6Vgnk37vXKTl50aPO/ZhpKpKQBaadlvyGTwaaEeNPj1uYSg
   avqIzi1sekn6W9FYmPqN6aj3cpLGRXjB2pyB9lRSkbboQWACBUUqZITrc
   0tKcYTWcqOuY3ZUYRzW0Gixb4zKGvJEeObwhzPjiuuzfHtwHAQAw7JExZ
   eR9TEf/gY9iVPlg9y1b+H0jjS7DBWFo9hF3WiCOre8brOXwHOtNrxNfM9
   cCBq8iclyCujkjjOPJAiakiLaZuEgWWCEAS+GFN6bq/zw0sPI33/ED/GV
   0j3IGeN2XnowtSFmwhwC/1Y1XwWZ/9+lp9GWsrE5gY32sPkvVK0YScIm4
   Q==;
X-CSE-ConnectionGUID: LxYQT1w+QQaZe6CkoW2RFw==
X-CSE-MsgGUID: vFkXEYyRTMyU6UpZwhfaag==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26931899"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="26931899"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 05:52:04 -0800
X-CSE-ConnectionGUID: zh2bbxETQL+JW5As7IQoMQ==
X-CSE-MsgGUID: NSTv1GFLRk6Nztzg5585Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="141768376"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 05:52:01 -0800
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
Subject: [PATCH v2 2/2] ASoC: SOF: pcm: Clear the susbstream pointer to NULL on close
Date: Wed,  5 Feb 2025 15:52:32 +0200
Message-ID: <20250205135232.19762-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205135232.19762-1-peter.ujfalusi@linux.intel.com>
References: <20250205135232.19762-1-peter.ujfalusi@linux.intel.com>
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

Fixes: 090349a9feba ("ASoC: SOF: Add support for compress API for stream data/offset")
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
2.48.1


