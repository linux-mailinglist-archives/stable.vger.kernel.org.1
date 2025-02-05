Return-Path: <stable+bounces-112439-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5AA28CB5
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4943A2AA6
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DABB149C64;
	Wed,  5 Feb 2025 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RmgNiQX4"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A411487DC;
	Wed,  5 Feb 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763575; cv=none; b=NNa1ndg5xfSVBqheyvJZVChwOSFmT4lU/nEFn5oQUbg3ky/SC0i8E5s1AcOzWHQKSj3PMfW6eZLbKxK5+PY9vcz98yoyS9DuzrxPQX2fTtTb2l9++X2n52F33c0znYQOGiZTHt8WOiM/S+VjfP6bgN/s67Sz8ywanMJt5i0MgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763575; c=relaxed/simple;
	bh=5zcxSUzsxVEXfqGzoMgTquDjRPwgXXlZ+0R8gWN8qzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdoKXHTs56bPVjdxCNahVVzC9CqkCPw0t2MorL3r3bhIY/7GDbJ8FSJFaclNHwCwk3TLv0fi5ZgRmxjejF6qaSe3qC6Umpd1QismA/+3LUn27t+RNTEgLw7Bwc67KF4ddIdNaU8/rlCvZET2qT/jaL31bh+SnlSBG6luPfzla14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RmgNiQX4; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738763573; x=1770299573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5zcxSUzsxVEXfqGzoMgTquDjRPwgXXlZ+0R8gWN8qzo=;
  b=RmgNiQX4fd6KZUS4V+g8Dg4AO5r6mSc8ObmjQfMeiczr+i8vH6+01zw1
   hiwfWKzyw0OQq0TnQTRPPGckieJcsOYvXmsXfOGJHkZfIvGc5aNwCpB/u
   T9ZVjPbRsGqvZcLHQM6RP0KSLArSxOceIf08TYLiMUkqHodiTR0j5Vkst
   1/4hVfG4ORECHc5cw3Z7D879L1www6ZEG88XSUb/pcVcGPx3tmu1nFXwz
   CO3oGyR+3E9L5WUYuzEJ8c/FDDm1xYChM+Skizyt98MYEH1Snsjyh6kU/
   H0/XFcGYuPM2K+4sF83MvcRW70nNTHBAcYoX5/K5Tdiwlk9luLUyFxVew
   Q==;
X-CSE-ConnectionGUID: 276eCnv+Qe6xGPsRRJ83MA==
X-CSE-MsgGUID: UzcqfPGJSturbtQRcGYO8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="26931877"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="26931877"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 05:52:00 -0800
X-CSE-ConnectionGUID: 3i4L3qJ9Sr6PRvWRqcrjFA==
X-CSE-MsgGUID: CfN8nxRKTH6USkj2Ww5CZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="141768368"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.196])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 05:51:57 -0800
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
Subject: [PATCH v2 1/2] ASoC: SOF: stream-ipc: Check for cstream nullity in sof_ipc_msg_data()
Date: Wed,  5 Feb 2025 15:52:31 +0200
Message-ID: <20250205135232.19762-2-peter.ujfalusi@linux.intel.com>
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

The nullity of sps->cstream should be checked similarly as it is done in
sof_set_stream_data_offset() function.
Assuming that it is not NULL if sps->stream is NULL is incorrect and can
lead to NULL pointer dereference.

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
2.48.1


