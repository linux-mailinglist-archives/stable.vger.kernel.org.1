Return-Path: <stable+bounces-183020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C809CBB2BAD
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 09:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DB1167CF5
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055F32BE641;
	Thu,  2 Oct 2025 07:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhWUuS8z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E6E2BE651;
	Thu,  2 Oct 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759391195; cv=none; b=W8Y6cot4cuifJ6ellU7+agLBvlbziDcWJOWBWgfRPmHXCP0SkcTeFMAo7RJMWhCjwT3YdF6iF1TA3xQPtzU9Acy7gsBu450Mt9J/IDE7K7QwXTJdmTmw1veHEaLLm/wZE9OvOKh+6ZVnBNlS8msnqMiTi2KGU/tU7hA19/X65kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759391195; c=relaxed/simple;
	bh=Xda1pQwf/IiD9YxLMYYBubwnjUHglgVnfrE5bfztUWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLtdREFN5vozETS1UclRm2SXy9zvkvoCotPBZVKPAMRuz/id4R2lLgNf1Je9NXySscuOzOiH94Lw1fNJQ/OOCVTg8JoZ2MO2PV6BIGhSEh0qvZfQG9UWpxaMqee5oN88cy0fsAgbx9GetCISRIwEy21n56Jk8OT/pBJyeGyJDzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhWUuS8z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759391194; x=1790927194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xda1pQwf/IiD9YxLMYYBubwnjUHglgVnfrE5bfztUWs=;
  b=IhWUuS8ztQ3ON8wOQ26TrEdMDQyz6SUfPxggtp5nBPPRrBEpkgtsvYGl
   72YV0TId6Yeg+8HGm3QQgW/de3gnd/K8IMJ33oIWAfGNEKsq41gLGG7TZ
   wc6W3h2X6rV0CjUoehRHsheJZjUd7XMiUM+syX46enJLKHcFrp1EIBOFc
   zylDS1GRWvu1CeyroDWeUmRCm1HHYI9/CBxgBTGUgvasO+nPM7KsT7Wg8
   eHVcX5O9x21CRuhbq2xuqprvIypBq9tF3FZmJiDB/S+o5xqCXyqvYPSvc
   lgZiymFU+zSFaRY+dmkjuJny8Wv+sRuASHGrCZk824BmnYpXPldce+Acu
   A==;
X-CSE-ConnectionGUID: PdYbP3XUR1CJQzFCDegdPg==
X-CSE-MsgGUID: p9f2v5/hQ8adhsOte2ApKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61630988"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61630988"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:34 -0700
X-CSE-ConnectionGUID: +KWnTFTdQgm/fDG9TwfwEg==
X-CSE-MsgGUID: gReqgfCvRvm2wtW4MAybrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,308,1751266800"; 
   d="scan'208";a="179760348"
Received: from slindbla-desk.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.8])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 00:46:31 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH 3/5] ASoC: SOF: sof-audio: add dev_dbg_ratelimited wrapper
Date: Thu,  2 Oct 2025 10:47:17 +0300
Message-ID: <20251002074719.2084-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
References: <20251002074719.2084-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dev_dbg_ratelimited() wrapper for snd_sof_pcm specific debug prints
that needs rate limited.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/sof-audio.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index db6973c8eac3..a8b93a2eec9c 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -629,6 +629,11 @@ void snd_sof_pcm_init_elapsed_work(struct work_struct *work);
 		(__spcm)->pcm.pcm_id, (__spcm)->pcm.pcm_name, __dir,		\
 		##__VA_ARGS__)
 
+#define spcm_dbg_ratelimited(__spcm, __dir, __fmt, ...)				\
+	dev_dbg_ratelimited((__spcm)->scomp->dev, "pcm%u (%s), dir %d: " __fmt,	\
+		(__spcm)->pcm.pcm_id, (__spcm)->pcm.pcm_name, __dir,		\
+		##__VA_ARGS__)
+
 #define spcm_err(__spcm, __dir, __fmt, ...)					\
 	dev_err((__spcm)->scomp->dev, "%s: pcm%u (%s), dir %d: " __fmt,		\
 		__func__, (__spcm)->pcm.pcm_id, (__spcm)->pcm.pcm_name, __dir,	\
-- 
2.51.0


