Return-Path: <stable+bounces-246063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJO0Dd9rA2of5wEAu9opvQ
	(envelope-from <stable+bounces-246063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3198C526B54
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5C0130AAC00
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BA03C09FE;
	Tue, 12 May 2026 17:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c61C12Oa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34763C09F9;
	Tue, 12 May 2026 17:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608263; cv=none; b=USB+9YcoDXsMWIwCsAX64S1meXzRxwfAvP+sGU5qlC2geLUupgGjtvC4L92K5OddpyGsr4p1t3deQBQkmqD4HrkdRJFg1mr6SKWlxD65Vk6nRb3ieVmvxIVulHu6h/wArmDMlju4eDyDGAWQislm9l9na8zoEe/B5RKNHPdwg0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608263; c=relaxed/simple;
	bh=8apsZ7SP2gNusPyjY19YkcSsF3BfoYYXW9FOtG9g6JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikG35r9HekOvFihU8AIhtVtn/0Z7bj4Za/iKaXtt5FTi1V7C4kDEYeyvRO3iSMbGrOHtx2Yu6/Jy2VvH3rZw1ayEHbhwo6Zuj57SjUW1nh0RjqNLb+HPw6JMkHIrQF2RFwqCMpDONnmqrhII2jwnY+RfB/VDNQQl7MnWJ1Brd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c61C12Oa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A75DC2BCF5;
	Tue, 12 May 2026 17:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608262;
	bh=8apsZ7SP2gNusPyjY19YkcSsF3BfoYYXW9FOtG9g6JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c61C12OapXJBKjWi8C81gfqRPGUeOiNen9myt4+crwYStS1BcA+uSFadHT6APoBn3
	 l652wvdHBmi7q9DS5fPhg9CyMTlyfRyBud4Qf+uf/8BclsLemjpBFoWhs7/QqlvfuF
	 ZSv9FS6W+YLOcF3WVVwncSmZrattiLncmoNQwxrA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.18 012/270] ASoC: SOF: Dont allow pointer operations on unconfigured streams
Date: Tue, 12 May 2026 19:36:53 +0200
Message-ID: <20260512173938.713822530@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 3198C526B54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246063-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Brown <broonie@kernel.org>

commit c5b6285aae050ff1c3ea824ca3d88ac4be1e69c8 upstream.

When reporting the pointer for a compressed stream we report the current
I/O frame position by dividing the position by the number of channels
multiplied by the number of container bytes. These values default to 0 and
are only configured as part of setting the stream parameters so this allows
a divide by zero to be configured. Validate that they are non zero,
returning an error if not

Fixes: c1a731c71359 ("ASoC: SOF: compress: Add support for computing timestamps")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260326-asoc-compress-tstamp-params-v1-1-3dc735b3d599@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/sof/compress.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -371,6 +371,9 @@ static int sof_compr_pointer(struct snd_
 	if (!spcm)
 		return -EINVAL;
 
+	if (!sstream->channels || !sstream->sample_container_bytes)
+		return -EBUSY;
+
 	tstamp->sampling_rate = sstream->sampling_rate;
 	tstamp->copied_total = sstream->copied_total;
 	tstamp->pcm_io_frames = div_u64(spcm->stream[cstream->direction].posn.dai_posn,



