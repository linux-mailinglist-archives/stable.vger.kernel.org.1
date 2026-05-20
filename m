Return-Path: <stable+bounces-251471-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJemFNT7DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-251471-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:22:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C85595E95
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC78735986E3
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7D3D5642;
	Wed, 20 May 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DeYqotV8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A8D30BF68;
	Wed, 20 May 2026 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298069; cv=none; b=WjOWO9E7tFgVmhDNxrkERFqbkZIr6iYv8IfWvMGFIA9/f1Kv7UZnS0ZBmfn5Xo8pdFA8MeRRThlvlCqAG6b7/jm5QmqBIsjyc8wZ4N0onzIy9kPU32nrW2yYBQA2BcN6bQnlrD/yIPspmvF1G3HmV0szvO/gsz9LVO/dDNpCNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298069; c=relaxed/simple;
	bh=pOx2HXWMUHwBvENWhqeZjVFlFR77POj3JTeAoKqqBUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kuA9jvjwRVMT+9mGhIt0ARvxSpZxPWEsVj2iNFY5ETyZay9xFyJeNpqE2pNiAE9+O7/4qFvhlVvtGNuMlNLYwzQQFEOlAuWbTN9Q2KGZcZpTZU6VwXbTWgtAL1SWzlWN2z6Y/p2RiQGhUcvLYADMcEfm9gfjSct4ebfN6NJt9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DeYqotV8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3C81F00898;
	Wed, 20 May 2026 17:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298067;
	bh=AJkVM4y7lMsJRitPWw/+iRffwrDMmSQQU/akP9vEKKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DeYqotV8lK9g9mqMsK3v2AM716RGRFtOOPr9TmhcewFl4YkNE/LsqnVI8ODdMe2qK
	 Esk86dU29YKzC+kJy83kY1D55SOh+DI7D/I6PZcDTthrEFx1ccLloqyDDRI0QxTbuk
	 Te3NbU/Rg25IqQ9qZ32FS6UrM1rkW2C3s6xXsXJE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 271/957] ASoC: SOF: Intel: hda: Place check before dereference
Date: Wed, 20 May 2026 18:12:34 +0200
Message-ID: <20260520162140.420791403@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251471-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E4C85595E95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index 9c3b3a9aaf83c..56faafb3dd0e5 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -445,16 +445,20 @@ int hda_dsp_iccmax_stream_hw_params(struct snd_sof_dev *sdev, struct hdac_ext_st
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




