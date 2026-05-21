Return-Path: <stable+bounces-253507-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNq/FiDmDmpvDAYAu9opvQ
	(envelope-from <stable+bounces-253507-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:01:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC7F5A3B6D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 777C030183DC
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 11:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834453BADB5;
	Thu, 21 May 2026 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sRb56IBm"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD153033FF
	for <stable@vger.kernel.org>; Thu, 21 May 2026 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779361299; cv=none; b=PVgK8Oi2ERTV/Y6P0BJ1zcnhZmGwTtAjrucxXHm7Ppz/2LKVdLBAOCkc/ejO6eEC4c0pW+SZDYyZnXfw9A/hzCFjENL/+UfcR6bs1peedsfFVpRn+8EbvU7uBl3w3LyenmsL3hwlirVu0YLPolEPS65KPUACTdYPSXodSXX2lKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779361299; c=relaxed/simple;
	bh=x7eWhfGu3dQUgHL1BW3vucHVFwNpD0MaxyrtevC/hYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=k33CsVy2aQf/mSjJar8u3mPPuMzkgdW5A17Pj6vI767Y2JTlrNmOq3r15xsWZ3BX7CkiAVHIbMg2Yxfg/fFIuM+kfM5//hIkFH6Z9B6msbjW6dPkvb4FMEplHqnwF0D4hOR0bxKhlG3mNkNVtDnz+HwwDuSureywaLhPo8b7S08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sRb56IBm; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso5972704eec.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 04:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779361289; x=1779966089; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cNj+qvFCgT4xwCDwwemkPTkGBsOHauIWtLPl/tY6GBE=;
        b=sRb56IBmZQMCNsIA3QRobLMsdzVIjhDODHBKmtheMI1YkMublUxkvGRIyo4POf87Hq
         GMWpXvO174WHPQ+u+cUpURXuDEjERdlyXh/rJOhxYMTE6UyTKbfPccokPPNZa4W6de8R
         yFvPOHiIEql5XroA712i50WGu8jwvqxSk9b1GNyX46FDZgIoo0F7txohj3YrcF8LEMZX
         DJ6eG+cemxJp7sYO4zv/g1dpysLtFh+SQvLP4Scv7f14HtCBFmXYrAemzEOv7Dhpb/8Q
         H07UoT9i4Cq5IFnX2zD6+50EuvSiko/MS5faptwMOA1pKvWZyZmOouGT9SO+lgCjjLrc
         cMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779361289; x=1779966089;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNj+qvFCgT4xwCDwwemkPTkGBsOHauIWtLPl/tY6GBE=;
        b=eyKCL7ZlPJA2c8rVanAxQifikMZqvoShpoeI4l5JcWb+C8UIeBEAgqHSNgGtCzUNN4
         DyiesKDyMLAC8zG7rL77JuOBWEXL8Um0Mq9D/N+rq38QrlnmUk/DZCMeWjVrNLtL4UhM
         6Tg59QLOJSecVUPvgw32ci0b4/fa16tQOTe9RFs6qsL9xjsRn5h5fMdAuTRLaIFELs0m
         l5EhAassBCGT1qihBTWaM43ieplq4mgeFD7HkNCQzmBicY7L7SLd6uSKb5txtuX+vmLC
         xXSQ3TWdhN4wJpz2mBm4xO3qUfKfHyRpUCTCxsLJGwGlCGA4fWwQBqXgB+47VL5jYjkL
         ysmw==
X-Forwarded-Encrypted: i=1; AFNElJ9N5phJirN4q4ipxWugeEC9/ejxBc5wLtXMUFXxgLwbdsjxICPM4eB/qZRL7VRCaJ8YfsGCJ9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRmaUjTXTsKgO3Kqa3fFowjQpFrorNt7xEG+/POFLPACSWYUV
	d4tHmh6gxWmsmccIo/yw5R/sdbAyo6+FrkIH+faLsoTGntaYJJleuzVqKntjpvCs
X-Gm-Gg: Acq92OGGLT9eQECvjVtgIfXYqQadERlQKy22I5FClDKxdMjBeT7IeLIrAu8SKX/7KVx
	cP9QvOXLNPwrTFgNnEhBCHv9+bqel9k+NOPU8lkGlQqj15Y+EdiCbkEqzSPfaEQOo2aQa478UgA
	sDNmIh6rS/oC9v1Re6/O8g8uQLpefkyZhVU9ILnF2XW6ZXlowwwgpFnMkAGyg/gzzAobwIlJ4vs
	L9os7gYDCCpvGk175+4byau4tKPCChu7/n8VP73LADTjs+QXQB2shLPU7T2hoVMMOOlIz55Bw6o
	wM+DzQsAjC8xI4cL7RAmItywLyZV7N39qFL6K4slDCXR9wfI4OE6munjthWCVxAZY7DFALx3k3H
	EUsh+hJltkhN3wlwg5x6NLSbhQcmO0ABLIQK6AtYzxYOZikax4bLsQRPj/RpW+kR7Cfp1+xOglS
	4yRNnsHyL4etBCvojnJKEPGThlcvCgO3cd+3dmYJeWKsx5yDjs6KQxHT3kZFzvLd3Y0+rcydc9g
	g==
X-Received: by 2002:a05:693c:2c07:b0:2ed:e14:7f5e with SMTP id 5a478bee46e88-3042faca12amr1339898eec.34.1779361289247;
        Thu, 21 May 2026 04:01:29 -0700 (PDT)
Received: from [192.168.1.18] (177-4-162-74.user3p.v-tal.net.br. [177.4.162.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304432dc579sm219449eec.6.2026.05.21.04.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 04:01:28 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 21 May 2026 08:01:23 -0300
Subject: [PATCH] ALSA: firewire-motu: Protect register DSP event queue
 positions
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-alsa-firewire-motu-event-locking-v1-1-708e1c2b5e56@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQ6CMBCF4auQWTtJ24QSvAphUcqAo9iaTkETw
 t2tsniLb/O/HYQSk8C12iHRxsIxFOhLBf7mwkzIYzEYZayqlUa3iMOJE73L8BnzirRRyLhE/+A
 w46jrdmht46zxUDKvRBN//hddf1rW4U4+/7pwHF8pnXkvhAAAAA==
X-Change-ID: 20260501-alsa-firewire-motu-event-locking-d159b967a62c
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 Clemens Ladisch <clemens@ladisch.de>, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2150;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=x7eWhfGu3dQUgHL1BW3vucHVFwNpD0MaxyrtevC/hYw=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFl8z9h+RGfvmK098dEEhcgPPGxMny+5XNIqeJdiHqqwT
 8OR4VZPRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAEykqImR4bP0/Wdvow89iJ32
 eYu8m9T57KKLJZlqX59q6MlMEXy014eR4Uvc537jHOGIbfYveWOuelQXZbgLpwXYruiRE1vd37W
 CAwA=
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253507-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[cassiogabrielcontato.gmail.com:query timed out];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4AC7F5A3B6D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The register DSP event queue is updated under parser->lock, but
snd_motu_register_dsp_message_parser_count_event() reads pull_pos and
push_pos without the lock.
snd_motu_register_dsp_message_parser_copy_event() also reads both queue
positions before taking the lock.

Protect these accesses with parser->lock as well. This keeps the hwdep
poll/read path consistent with the producer side and with the cached
meter/parameter accessors.

Fixes: 634ec0b2906e ("ALSA: firewire-motu: notify event for parameter change in register DSP model")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/firewire/motu/motu-register-dsp-message-parser.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/motu/motu-register-dsp-message-parser.c b/sound/firewire/motu/motu-register-dsp-message-parser.c
index a8053e3ef065..4ec23e6880d9 100644
--- a/sound/firewire/motu/motu-register-dsp-message-parser.c
+++ b/sound/firewire/motu/motu-register-dsp-message-parser.c
@@ -386,6 +386,8 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 {
 	struct msg_parser *parser = motu->message_parser;
 
+	guard(spinlock_irqsave)(&parser->lock);
+
 	if (parser->pull_pos > parser->push_pos)
 		return EVENT_QUEUE_SIZE - parser->pull_pos + parser->push_pos;
 	else
@@ -395,13 +397,14 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 bool snd_motu_register_dsp_message_parser_copy_event(struct snd_motu *motu, u32 *event)
 {
 	struct msg_parser *parser = motu->message_parser;
-	unsigned int pos = parser->pull_pos;
-
-	if (pos == parser->push_pos)
-		return false;
+	unsigned int pos;
 
 	guard(spinlock_irqsave)(&parser->lock);
 
+	if (parser->pull_pos == parser->push_pos)
+		return false;
+
+	pos = parser->pull_pos;
 	*event = parser->event_queue[pos];
 
 	++pos;

---
base-commit: 38c607c673155d6335591cdbd9c785fb2b7550e5
change-id: 20260501-alsa-firewire-motu-event-locking-d159b967a62c

Best regards,
--  
Cássio Gabriel <cassiogabrielcontato@gmail.com>


