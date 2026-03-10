Return-Path: <stable+bounces-223765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCq7G/2/r2kucAIAu9opvQ
	(envelope-from <stable+bounces-223765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:53:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5762246021
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31BBF30234CA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 06:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3973D3D0C;
	Tue, 10 Mar 2026 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VUVIi2Wq"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239983D34B4;
	Tue, 10 Mar 2026 06:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125623; cv=none; b=ZF4SjYdNLZGkCnruvvUJZWw3BerCo9zoElS7eiNQOgzcBYg9zQjrQR165UXgFluYrshvbgup2BODHiSzTUyH2/le4fW3RAd2L6c8LwuobEb5xwr42B7kogTX+lKO3p/Oi87fNDrLZtiXxdH1+qLq7d5IPE7erzK49ldJr/SWsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125623; c=relaxed/simple;
	bh=CyirLh+kiXbAvZQ472tKoe33f8em0dHGAs/ohfbijBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HR+9fmmEDewKWjzQzopckpzyPddiih05RmSTO2XQnqeWFaTdK6NFYgrwL7B6sg9vsFaZkhUNwVqL89FksKsuRU/IB1wma6aKI37NLcI3GGD+I72C3tsSiienIOvTivT8S8OLHmsuMtihzbuu51QVXhFIj4iaPP9g4CM3QBzXA68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VUVIi2Wq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773125621; x=1804661621;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CyirLh+kiXbAvZQ472tKoe33f8em0dHGAs/ohfbijBw=;
  b=VUVIi2WqrA2SRKL/GKZkE8uOxptuldxE+j8nSTrwLWhDzo+6PXz04Q6o
   rEVCq/hhoNSOrCCfsz1acyPRuZwNI1quaLqJb+/z9L54RESqYDUzku3Zs
   eKCYefNyYL56SB2GeJXSfSJE14d1kgPvIzoQ0b9I8yNEErsMexaiV8CY/
   NJgRm6W/i72EF/ZUmX5WNc5mCg4LHeXUuDbbTaCz10imDqtNd+NOTEJTr
   2usEH4dWEklbtKUuXCFAtaIp9BvFrtA9UBws9XU245RMhe5UXYeDiyPWN
   eqBdkRrmAF4kZX00vJiCmxlIJ4gNQSSaOQRU46apsy1ptxgnZ7q89Jv3c
   g==;
X-CSE-ConnectionGUID: Jn5ERYztR4CW1LJNSnAsNw==
X-CSE-MsgGUID: 8CygL1npQ5GRBcf1iE5HpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74241473"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="74241473"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 23:53:40 -0700
X-CSE-ConnectionGUID: P8/1COfsRXW2HfxIXOzzgQ==
X-CSE-MsgGUID: I++thLF8S8KnmuQnBLVZKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="257923289"
Received: from vpanait-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.5])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 23:53:38 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	kuninori.morimoto.gx@renesas.com
Cc: linux-sound@vger.kernel.org,
	ckeepax@opensource.cirrus.com,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: codecs: rt1011: Use component to get the dapm context in spk_mode_put
Date: Tue, 10 Mar 2026 08:53:50 +0200
Message-ID: <20260310065350.18921-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C5762246021
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223765-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,renesas.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[peter.ujfalusi@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Action: no action

The correct helper to use in rt1011_recv_spk_mode_put() to retrieve the
DAPM context is snd_soc_component_to_dapm(), from kcontrol we will
receive NULL pointer.

Closes: https://github.com/thesofproject/linux/issues/5691
Fixes: 5b35bb517f27 ("ASoC: codecs: rt1011: convert to snd_soc_dapm_xxx()")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/codecs/rt1011.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 9f34a6a35487..03f31d9d916e 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1047,7 +1047,7 @@ static int rt1011_recv_spk_mode_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
-	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
 	struct rt1011_priv *rt1011 =
 		snd_soc_component_get_drvdata(component);
 
-- 
2.53.0


