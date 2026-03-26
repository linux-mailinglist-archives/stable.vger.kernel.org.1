Return-Path: <stable+bounces-230479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNx/LEFJxWkU8wQAu9opvQ
	(envelope-from <stable+bounces-230479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:57:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 540A2337228
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 15:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 023A33096055
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76F43F8804;
	Thu, 26 Mar 2026 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tiFiBoYO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6671537F740;
	Thu, 26 Mar 2026 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536785; cv=none; b=foYOhnDg2bGwWCgS39sHlH3mFvU6SygOupCjN3DqtGwvVER8inPBiIr9b+ZZ9GKiY4wjBHhRmd1/rT8d6etrcLaqvDLeA9LtADBq3KsGb/4Q6w4Pl8pxN1cjLPH4PNupk+PMjNbPyFV2aht4rvtwAgjhGUBby3pP9tOIlFKPZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536785; c=relaxed/simple;
	bh=BbE3pnLrgm/wPzHHV+H7hYNU7JsNB1SS4D82ehKfwr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RfhH15RMYaqVhA8xA2UwYOR445Rt6mRiogzjP1/TvORMC1db/URQajOAwhleoB01wfzZlkTqLwkHUJ3xVhnQSfdU1zji1kCjidhUjEW3hDaDAIno6Z7iOC8I9qntB7FEchLq7eLW4fryoERnTXbYVE28TeufPlEbafCfALYVovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tiFiBoYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F7AC116C6;
	Thu, 26 Mar 2026 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774536785;
	bh=BbE3pnLrgm/wPzHHV+H7hYNU7JsNB1SS4D82ehKfwr8=;
	h=From:Date:Subject:To:Cc:From;
	b=tiFiBoYOA1nR5g3RTUHeYil1I7WXH6mmyynqWtfKpBjCagxAjws56TVAOlvET6wEp
	 UkJG0pVz1vU//M5X+YEdk0BNCHO6czOoyN+oGXDREL10QK/Rd+78XR4vX1VC9CeOpA
	 Wnr8jXaPurItSYPzuO//V8+LUDCd39NFmJ5stPA/ANEADWV63QjmityyhA+YSMHxGE
	 q2hR8+N9MpN2uDi9hKgAEIXrFSx/JB6/EdvkD4jhhtk7oqQkXkvJkCqqAYI/Xi325V
	 C7Hd/zHKwULGpDQauVptTXTqL7j/iOKFzWx7QQ5JQX45vEtJukymO8NkXfzWQ5DpDa
	 ku8CcD0U5x7hg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 26 Mar 2026 14:52:41 +0000
Subject: [PATCH] ASoC: SOF: Don't allow pointer operations on unconfigured
 streams
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org>
X-B4-Tracking: v=1; b=H4sIADhIxWkC/yXMTQoCMQxA4asMWRuYZrD+XEVcxJpqhE5LU0UY5
 u5WXX7weAuYVBWD47BAlZea5rnDbQYId55vgnrtBhrJjxN5ZMsBQ06lihk2a5wKFq6cDOng47S
 PbktuB/3Qm6jv3/10/tuel4eE9l3Cun4AulSQyX8AAAA=
X-Change-ID: 20260326-asoc-compress-tstamp-params-296f38f15217
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Paul Olaru <paul.olaru@oss.nxp.com>, 
 Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Cc: sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16-dev-ad80c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BbE3pnLrgm/wPzHHV+H7hYNU7JsNB1SS4D82ehKfwr8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpxUhNdRwhXc6y9aG+65srowNcrVX57YRFUDXSp
 QLexIzjmmGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCacVITQAKCRAk1otyXVSH
 0JEqCACCBaRx35mm3EhKMvktkcl9acJ6OBb8bPnXAFUcGm0p6Kp6q+GPFa1nA/W/I8JD2+ZJiE1
 VzHgE35CieKBbnqt8Vbl+ck8a06GDGIX7DRN2CfeA2riCMHZY/n/XBVsi3dmSgj6lXtaji/FVkC
 S03/qjR2W0Wig25pwEWoO5xY3OFhvcG9q4UiM9dNwOftlnTXtckaqA9PTiMkX68lEEbZYwKk+hM
 E0KQtcu/LP4FeXE6j0Y/uWsra2yjf8CoX2waUU5ZmgqFKnjAF71WZ8TEpGRv+/8gwT3034M2bAl
 RUF4QytlVufVz0L40DNJhDy1TaZATLMcwn3MnWMFBsAknWhO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230479-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.intel.com,nxp.com,linux.dev,perex.cz,suse.com,oss.nxp.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 540A2337228
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When reporting the pointer for a compressed stream we report the current
I/O frame position by dividing the position by the number of channels
multiplied by the number of container bytes. These values default to 0 and
are only configured as part of setting the stream parameters so this allows
a divide by zero to be configured. Validate that they are non zero,
returning an error if not

Fixes: c1a731c71359 ("ASoC: SOF: compress: Add support for computing timestamps")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/sof/compress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 96570121aae0..90f056eae1c3 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -379,6 +379,9 @@ static int sof_compr_pointer(struct snd_soc_component *component,
 	if (!spcm)
 		return -EINVAL;
 
+	if (!sstream->channels || !sstream->sample_container_bytes)
+		return -EBUSY;
+
 	tstamp->sampling_rate = sstream->sampling_rate;
 	tstamp->copied_total = sstream->copied_total;
 	tstamp->pcm_io_frames = div_u64(spcm->stream[cstream->direction].posn.dai_posn,

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260326-asoc-compress-tstamp-params-296f38f15217

Best regards,
--  
Mark Brown <broonie@kernel.org>


