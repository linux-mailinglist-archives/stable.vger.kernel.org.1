Return-Path: <stable+bounces-236182-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLHmBjUU3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236182-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:05:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC023EE4A1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 716AE3023D85
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D63248880;
	Mon, 13 Apr 2026 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W/xEPft7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2851D6DB5;
	Mon, 13 Apr 2026 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096254; cv=none; b=MPkQwhN7yPupBgUqWmtdbATHJoIONpv4jTSToVskQdDiaRl+ejleAQTFB83RiORAKl2HiWTZCr10lpEFf3SQCoZ5SG8xa8/p1cRzmUmsPnGiN17r3G42U7eh+DueMOvc7sN7Q2kVfewrv7kqw4Z5OAoxA/9U5/7lkAjeC8mzFZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096254; c=relaxed/simple;
	bh=+xTny0+pFFlgtaMY46yVNH9pOGvfTC20FB5jVagUZjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y8sNBGD4fKBC2lJLYKn6R8GwjaPxoVLE5RXCTePxInlPCc7XMz/Rh0RaAvxXf9hT05KF51CRP5zx9VXmsiJGgoHRKCDrsZmvF27z3I3e5dfr2L6FSOEQV4/Rb0HuYxdQ43S6FIpjSjmx6GO/b1XxuPbuw9P7QMVSXtR17mjt0aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W/xEPft7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D87C2BCAF;
	Mon, 13 Apr 2026 16:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096253;
	bh=+xTny0+pFFlgtaMY46yVNH9pOGvfTC20FB5jVagUZjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/xEPft7o2yzm0J+J+zqMTju/wy+RbDM9725JPuFo/ITw0MeI1cOnD6rZxBqELkGZ
	 ZJN65yEs+yfkH6ZVLWVtfOm+Jm2+BsS8lVDm/HPZm6ybxkIz7CzsE9QhL+GU+gWNNk
	 /fHBut0kOTr3347boh/LXNdcojU25OhV37/SpvI0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.19 26/86] ASoC: SOF: Intel: hda: modify period size constraints for ACE4
Date: Mon, 13 Apr 2026 17:59:33 +0200
Message-ID: <20260413155732.550118111@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-236182-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 8FC023EE4A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

commit 0f71866057262d669ed6a21246eaac0ad6d04d4e upstream.

Intel ACE4 based products set more strict constraints on HDA BDLE start
address and length alignment. Add a constraint to align period size to
128 bytes.

The commit removes the "minimum as per HDA spec" comment. This comment
was misleading as spec actually does allow a 2 byte BDLE length, and
more importantly, period size also directly impacts how the BDLE start
addresses are aligned, so it is not sufficient just to consider allowed
buffer length.

Fixes: d3df422f66e8 ("ASoC: SOF: Intel: add initial support for NVL-S")
Cc: stable@vger.kernel.org
Reported-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Link: https://patch.msgid.link/20260408084514.24325-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/intel/hda-pcm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-pcm.c b/sound/soc/sof/intel/hda-pcm.c
index da6c1e7263cd..16a364072821 100644
--- a/sound/soc/sof/intel/hda-pcm.c
+++ b/sound/soc/sof/intel/hda-pcm.c
@@ -219,6 +219,7 @@ EXPORT_SYMBOL_NS(hda_dsp_pcm_pointer, "SND_SOC_SOF_INTEL_HDA_COMMON");
 int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 		     struct snd_pcm_substream *substream)
 {
+	const struct sof_intel_dsp_desc *chip_info = get_chip_info(sdev->pdata);
 	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_soc_component *scomp = sdev->component;
@@ -268,8 +269,17 @@ int hda_dsp_pcm_open(struct snd_sof_dev *sdev,
 		return -ENODEV;
 	}
 
-	/* minimum as per HDA spec */
-	snd_pcm_hw_constraint_step(substream->runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 4);
+	/*
+	 * Set period size constraint to ensure BDLE buffer length and
+	 * start address alignment requirements are met. Align to 128
+	 * bytes for newer Intel platforms, with older ones using 4 byte alignment.
+	 */
+	if (chip_info->hw_ip_version >= SOF_INTEL_ACE_4_0)
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 128);
+	else
+		snd_pcm_hw_constraint_step(substream->runtime, 0,
+					   SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 4);
 
 	/* avoid circular buffer wrap in middle of period */
 	snd_pcm_hw_constraint_integer(substream->runtime,
-- 
2.53.0




