Return-Path: <stable+bounces-225535-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKbyNmb8t2mXXwEAu9opvQ
	(envelope-from <stable+bounces-225535-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:49:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 371FE299A93
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 13:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7961E302C779
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8414381B16;
	Mon, 16 Mar 2026 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nHq1ZzZ3"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B6F21C173;
	Mon, 16 Mar 2026 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773665352; cv=none; b=W/XiiTFrWAxy7cG1hmvjxrFxS6Yfc/SOf9CgMUeOoW1O9pAiwAU5tPuut0GGNL7Mg+lCZoYUPvdN3RPI1iT6qPCUGUFKqAP7067ToYO0eOQHmOV/hPCZdMFmvBpQSkYrT8Upu2RgXsmNlBpqnyI4Cc35sROM/0QVj5fC5R2QdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773665352; c=relaxed/simple;
	bh=+fKnMOAy4txozyuTQa186zP47LQj68e8yWqSt0ZdZiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hwd1+x9/Rop5zdzrMSruPLiQ2Jr2JuQpPOMehIfEUrqV4du+emChLkmjG1b4kbJlZ6gFgN9mDVO5uGm/uGybOdbZziOrDAkXGy6JV6TlSLRAP4xIh4yRXktrQNhqPR8jtPPdPcSwLD7GB8sCHsXFnADZLiUrTT0/cgeGUDUDO7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nHq1ZzZ3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773665351; x=1805201351;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+fKnMOAy4txozyuTQa186zP47LQj68e8yWqSt0ZdZiE=;
  b=nHq1ZzZ3urO+lek5hQrppKmsOE84kJvwKvxKB/Pt2ZpBxXqZRLBHYGM1
   jBElZzIYRIbnEKXKlTbU5AHDbPF+R+gnGaN7n5V8Nofd+Uni/ul4Q4z3Y
   ofQ0fb0UYAZ8beJi+opR5/a31eJGEHql+rLB6J/xI1RnZON231NAjUld0
   I5SOH80gcsFfzTULSRc0p+VYcMzD+bnoYNUBB6WVJM9HTYcCXkFmhHbSi
   bTI29nbQhclDN4oIDNPWRXjpnLNv48T3i55lLrOfGtbUd9DOUC805myeF
   3SuelA8KndQXEs1fSjtMRoJKR/tXrYnY0aBNL7FTCk05T7aXrDgDj2IgN
   g==;
X-CSE-ConnectionGUID: nYA0v7IuSaqbL0waDjmCaA==
X-CSE-MsgGUID: Cqa5yglgRe+qETmwApbP4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74382108"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74382108"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 05:49:10 -0700
X-CSE-ConnectionGUID: EjlCi3DxRQatj9fKZHTReg==
X-CSE-MsgGUID: K9Hc76poRwCC4Cy9XMcoEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="221146562"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.184])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 05:49:08 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	ckeepax@opensource.cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: cs42l43-jack: Remove manual pm_runtime get/put from tip_sense_work
Date: Mon, 16 Mar 2026 14:49:24 +0200
Message-ID: <20260316124924.31047-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-225535-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,opensource.cirrus.com,cirrus.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 371FE299A93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a jack is inserted the forced pm_runtime_get() will keep the codec,
soundwire bus and it's parent active as long as the jack is connected.
This makes for example the DSP and firmware booted up on Intel platforms.

If the module is removed while the jack is connected we will also have
unbalanced runtime PM state.

Without the manual get/put, the button detection still works correctly and
the system can reach lower power state while the jack is connected like
in the case when there is no jack connected.

Fixes: fc918cbe874e ("ASoC: cs42l43: Add support for the cs42l43")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/cs42l43-jack.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
index 3e04e6897b14..d90a13a55845 100644
--- a/sound/soc/codecs/cs42l43-jack.c
+++ b/sound/soc/codecs/cs42l43-jack.c
@@ -756,10 +756,8 @@ void cs42l43_tip_sense_work(struct work_struct *work)
 	ring = (sts >> CS42L43_RINGSENSE_PLUG_DB_STS_SHIFT) & CS42L43_JACK_PRESENT;
 
 	if (tip == CS42L43_JACK_PRESENT) {
-		if (cs42l43->sdw && !priv->jack_present) {
+		if (cs42l43->sdw && !priv->jack_present)
 			priv->jack_present = true;
-			pm_runtime_get(priv->dev);
-		}
 
 		if (priv->use_ring_sense && ring == CS42L43_JACK_ABSENT) {
 			report = CS42L43_JACK_OPTICAL;
@@ -779,10 +777,8 @@ void cs42l43_tip_sense_work(struct work_struct *work)
 
 		snd_soc_jack_report(priv->jack_hp, 0, 0xFFFF);
 
-		if (cs42l43->sdw && priv->jack_present) {
-			pm_runtime_put(priv->dev);
+		if (cs42l43->sdw && priv->jack_present)
 			priv->jack_present = false;
-		}
 	}
 
 error:
-- 
2.53.0


