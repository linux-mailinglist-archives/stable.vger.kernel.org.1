Return-Path: <stable+bounces-252363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEieMmT6DWrh5AUAu9opvQ
	(envelope-from <stable+bounces-252363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:16:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6399D595B01
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0569308B2C3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503393F871A;
	Wed, 20 May 2026 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hnP8Z7pt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C93DCD96;
	Wed, 20 May 2026 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300479; cv=none; b=rsFM30eRwDD+skvvUSOV2G7nP6PVkqLI4rSwCkSblhk9W5bJPvuao3dr2/xjiZdqWyS+pHCkSC3pPPHza1wp1nAcfK69/poLNfqM6yt3aPemP6xNeITsb/bGfysCw1qIhSR9hsL0EK6eXV11d1niB8PQkN48wYG66J2noODQ/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300479; c=relaxed/simple;
	bh=kfqlA85cFlSUhRM2dLeKE+nIv0ZmVabeUvx0puGhkgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fRQxBwYDeyLL7rKRc4sYVQOlIKcM84AztwlhtL4FzliduNgF54WqMq44HL96mzjWDrdXTo4LQlhNZbjjwPWYAJHBxXzgu5fNz+iZzrDcNLq3tVWsXFPerHwhQh/6ORpoU/frS9TkDjJsfDFVtFhjzD8l0wIL34d7EjuXBDyvf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hnP8Z7pt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D2B1F000E9;
	Wed, 20 May 2026 18:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300478;
	bh=hbwwRDZTt8pFwKjngXT+sM9n5A9KjGxHZN3WBnOr6Pc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hnP8Z7ptyfvgbvjV44g9lyF2mhcye8OtEgLXfd/YZWq2JBO4FIFREaufYAgEISq6P
	 +qT8MuVqbPJrzW7GlwGQ8pYb+LYxaHTHYrvNNTf9gm50Va5zJ+gWGqTYo61Hmr0/j0
	 J9j2C13ENPdGebQeZfNSr96BnGHFUXdJ3Zy8ZLgE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 190/666] ASoC: SOF: Intel: hda: Place check before dereference
Date: Wed, 20 May 2026 18:16:41 +0200
Message-ID: <20260520162115.320135280@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252363-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6399D595B01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ethan Tidmore <ethantidmore06@gmail.com>

[ Upstream commit 6cbc8360f51a3df2ea16a786b262b9fe44d4c68c ]

The struct hext_stream is dereferenced before it is checked for NULL.
Although it can never be NULL due to a check prior to
hda_dsp_iccmax_stream_hw_params() being called, this change clears any
confusion regarding hext_stream possibly being NULL.

Check hext_stream for NULL and then assign its members.

Detected by Smatch:
sound/soc/sof/intel/hda-stream.c:488 hda_dsp_iccmax_stream_hw_params() warn:
variable dereferenced before check 'hext_stream' (see line 486)

Fixes: aca961f196e5d ("ASoC: SOF: Intel: hda: Add helper function to program ICCMAX stream")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Link: https://patch.msgid.link/20260324173830.17563-1-ethantidmore06@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-stream.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 2be0d02f9cf9b..d6a0e78b5ce73 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -419,16 +419,20 @@ int hda_dsp_iccmax_stream_hw_params(struct snd_sof_dev *sdev, struct hdac_ext_st
 				    struct snd_dma_buffer *dmab,
 				    struct snd_pcm_hw_params *params)
 {
-	struct hdac_stream *hstream = &hext_stream->hstream;
-	int sd_offset = SOF_STREAM_SD_OFFSET(hstream);
+	struct hdac_stream *hstream;
+	int sd_offset;
 	int ret;
-	u32 mask = 0x1 << hstream->index;
+	u32 mask;
 
 	if (!hext_stream) {
 		dev_err(sdev->dev, "error: no stream available\n");
 		return -ENODEV;
 	}
 
+	hstream = &hext_stream->hstream;
+	sd_offset = SOF_STREAM_SD_OFFSET(hstream);
+	mask = 0x1 << hstream->index;
+
 	if (!dmab) {
 		dev_err(sdev->dev, "error: no dma buffer allocated!\n");
 		return -ENODEV;
-- 
2.53.0




