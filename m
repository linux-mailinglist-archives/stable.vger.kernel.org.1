Return-Path: <stable+bounces-202803-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A916ACC77CA
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 13:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 581533026ABA
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECAC30FF32;
	Wed, 17 Dec 2025 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4rVsl0x"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4420CC13B;
	Wed, 17 Dec 2025 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765973167; cv=none; b=tmPqMcpugR5atlN0qiYBezB4nuce0Md+BvF/cjPE7sgStehEIKRWdGaO1qCUiwVenC+7FuLy8yyjSFiu7EhQWQ+gRznKgE8O10po56hRtwBGxxjT9itKY0p+MqwVP/MI1knHfTFwthUOrt8kPBzWIomkWhXEH/jPoI9ysHqwwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765973167; c=relaxed/simple;
	bh=LNOUSeymbpIrtqL77fDDUJTq9B6cDoawAjKxHL8YJjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQlcPaOfflwqJJsVtWXVrtIxump0LSBRH5be5JL7uihlZC0Xp3qGcNOhZBsvmDaWFOcEJLydDh8zev+TryxQb4vKPZ+JlWSREiGmqqlo9Ll7GLgB4qfvFr1Z40eLDA10McIHD4Klb4bfGUfrmoWhGT45YZoKVNDejQjjoyDGJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4rVsl0x; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765973161; x=1797509161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LNOUSeymbpIrtqL77fDDUJTq9B6cDoawAjKxHL8YJjo=;
  b=A4rVsl0xOVEuyNh1AV8qrNU7O+7XtjqdV9D3iFSi2D72t9icGGpr6WuB
   0BeBgIKDddoKfnQNFEUwfhriegxYDxlKyNvWyNb1fpU4NMPV0PoXlFBWT
   OFgyWF/V7OCHBoOd2wKPzxoETs/UnvR3pRCZjmVQECjVoAhGIT3mc71Cd
   xYvq3/Auz0H5fmJMm2eejxnF4dGy0NxZ0W9qUp8xyTp3tkN93h77ZvKWM
   X+n7Dyg1uKcCgYP5TdppcHZOvxeLkQwQrPQTDcToPrLuzsxsBCBy+mxiP
   1lALmit9V87XNajCYPgTsCduHjYQn+1D5fgFXGD1n3967QnrCS8w51UAk
   A==;
X-CSE-ConnectionGUID: Cba3v5KXT+GgNlI96XLNbA==
X-CSE-MsgGUID: 8w8DuN0aQsOzwZ+s0HWC9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="93382705"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="93382705"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:06:01 -0800
X-CSE-ConnectionGUID: YnOtEbllSAWfGaNCsRMung==
X-CSE-MsgGUID: szy87TyMRTCVbNrbkMz0Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="202795080"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.187])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 04:05:57 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	seppo.ingalsuo@linux.intel.com,
	stable@vger.kernel.org,
	niranjan.hy@ti.com,
	ckeepax@opensource.cirrus.com
Subject: [PATCH] ASoC: soc-ops: Correct the max value for clamp in soc_mixer_reg_to_ctl()
Date: Wed, 17 Dec 2025 14:06:23 +0200
Message-ID: <20251217120623.16620-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'normal' controls the mc->min is the minimum value the register can
have, the mc->max is the maximum (the steps between are max - min).

SX types are defined differently: mc->min is the minimum value and the
mc->max is the steps.

The max parameter of soc_mixer_reg_to_ctl() is the number of steps in
either type.

To have correct register value range in clamp the maximum value that needs
to be used is mc->min + max, which will be equal to mc->max for 'normal'
controls and mc->min + mc->max for SX ones.

The original clamp broke SX controls and rendered some of them impossible
to even set, like the cs42l43's Headphone Digital Volume, where the
min is smaller than the max (min=283, max=229 - 229 steps starting from
val 283).

The soc_mixer_ctl_to_reg() correctly uses the max parameter instead of
mc->max, so storing the value was correct.

Fixes: a0ce874cfaaa ("ASoC: ops: improve snd_soc_get_volsw")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index ce86978c158d..6a18c56a9746 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -148,7 +148,7 @@ static int soc_mixer_reg_to_ctl(struct soc_mixer_control *mc, unsigned int reg_v
 	if (mc->sign_bit)
 		val = sign_extend32(val, mc->sign_bit);
 
-	val = clamp(val, mc->min, mc->max);
+	val = clamp(val, mc->min, mc->min + max);
 	val -= mc->min;
 
 	if (mc->invert)
-- 
2.52.0


