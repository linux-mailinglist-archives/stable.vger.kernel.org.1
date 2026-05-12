Return-Path: <stable+bounces-245469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wP31LZYeA2r10gEAu9opvQ
	(envelope-from <stable+bounces-245469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:35:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB6D520402
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B6ED3018A38
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D046548C8DE;
	Tue, 12 May 2026 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eKgZh4P7"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC0388895
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589080; cv=none; b=BnSr8VhZsVmZJXjUNF6uJqwEbBgHSwBwR60qLQcWepoN5CIcDug7mGFsT3OXvE34adP2ph29f7tOJq/ltvg4Ytrd0JTCIeq+lxy4AfNdX90eD2tF0l5B8lcdMnn7Jis1uSRLOd1t+S0mBSZVUmRdoiWzI2nTEnozVbYvrM6Mmk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589080; c=relaxed/simple;
	bh=Da2xgNXyPA++qo4a3AVVh/CrbIYpXjUjeW3H+9Mq4SY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LpvgEDuOSsNE4+snv7ro+WEooPi/MQe9/MfMkJRSuSaIALjCTxdjdTiRVhbA0MAfilqRbuTycczEuYyadQMMrsSd1JcE6B3osoAiJKkdbpnqYZ8e0IJLoLInT41Kn5puLE0qSG3Ua5tdFguqyb7q1XKPtm4bVv9jhjPmvCLzk0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eKgZh4P7; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8c6fc5fd3so2273947e87.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 05:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778589069; x=1779193869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cY1eLcRD4F4XK6/iq2cI2ENR4Yo5ocParDIUGJvyGEM=;
        b=eKgZh4P7Z+MDhnHyvFEO4ehSw6xxQlbOpOUNc/YWGaYdm4oAj4j315jKtL89LQ2Kw5
         kywprRPerNBpR2oFX6RjDSX3pNmdOHEdQiytXWvX8X3dFCQo/5VG6L/iKqbGXsi6emKD
         LbwXw4gA9EMV6plh9vIRnPT50k6Dr1MLR5hnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778589069; x=1779193869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cY1eLcRD4F4XK6/iq2cI2ENR4Yo5ocParDIUGJvyGEM=;
        b=jZXwpUbeW0g5Je/FKP7cjaqEwHgIjViaUlatU8Bmk/7I7KYLIzD22HFtQBwbRtD5OA
         8Mu08y2oo9WLRkvNpoAQj4hlI2Is8sZoaRZKvTyIvgdIuEpWjNXr0HZr9c88tMDnHryW
         Op9lOJXxEVxmpmuXMOMvi7mfh7VAuI8rGfzRkPLDwp6HDwVj9XPStGjvDDUTM64DUcuv
         qSIVBv/5QwFx8q/tlKaS1PrW5zfELM7wGoC/mFq3wnwOYdh3dNf+pEXtQuFHZS3FeUbl
         54vf3xQHUVC3YDxKYFl5stdt55h29jJRtA9H9MuLtDlef1LMlndQtK8UunHMn1NEKXWg
         9a+w==
X-Forwarded-Encrypted: i=1; AFNElJ96xn1umkGfcQMPvBboAr/RiSr0yzAvMnkWG2DwgaIfLXBB4Mpr3oPu8L6x4uH8Jir9LQtCJTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAz68O0E0SndUUf+kGDcfHE4MkViRxo5cP2H+fxo03BQxSnQtL
	r1z/Cd+g7H2pGBEw6rYaIWy+ubb+wfZGYBDP4jeImBF+9isZXXwsjbq29OxK1oxQurp6Stq34yd
	rhqr660Uhi2U=
X-Gm-Gg: Acq92OE0zu8oHQqHhcUqYzuuhAVmurE/nGCmwhxC7lcHAw03r0sQhasThRQ4+1Xbzsz
	t+s44IGWgqmdkEhAnc/1/Wc4xMa6qSXKRQH4HR5l8Ampi1+2qv6UfPhxZf9mOiERQ3EEBuPFYNQ
	YE0hZK8NqmRlanQl9MCGpuuVrsodtcUe5lj9kO7HDViZzEWOQcCYlj6BMB/ZafXdKfGuzHUTI0Y
	mu88NkdLSgZIFbR3NS5kfpdmtwDBXwhNjAPvPUYM8AjHUphPNT9orgZY63oH+PW+qo1bO8rV7Jx
	C64jhfw4aTMDJig+9EK8lvlTtHwNIcmyDOcFSipeuTruBFK3No+rj+pLrBKluKuVH4Y9UWk4eNz
	Yb+tb41N8WNd2RbNp4hO5ebaNlYApMibhJ1XT3wp7Pv3EDbkPQv28iSQy580d74+gYNXnEaEMMR
	wBRDzgyny4toDN0Ir52kJBtx2upPNPJEBvUvBTCSUR+AaQZFOe7swGZsIM7tAzwFWSVjP3G/7hG
	MeJwtiw44q1
X-Received: by 2002:a05:6512:22d5:b0:5a8:e129:af6f with SMTP id 2adb3069b0e04-5a8e129b003mr931546e87.23.1778589068566;
        Tue, 12 May 2026 05:31:08 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8c66facc2sm1861344e87.22.2026.05.12.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:31:07 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 12 May 2026 12:30:58 +0000
Subject: [PATCH v2 4/5] media: uvcvideo: Do not add clock samples with
 small sof delta
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-uvc-hwtimestamp-v2-4-3c2905c733bb@chromium.org>
References: <20260512-uvc-hwtimestamp-v2-0-3c2905c733bb@chromium.org>
In-Reply-To: <20260512-uvc-hwtimestamp-v2-0-3c2905c733bb@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: BFB6D520402
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245469-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,chromium.org:email,chromium.org:mid,chromium.org:dkim,qualcomm.com:email]
X-Rspamd-Action: no action

Some UVC 1.1 cameras running in fast isochronous mode tend to spam the
USB host with a lot of empty packets. These packets contain clock
information and are added to the clock buffer but do not add any
accuracy to the calculation. In fact, it is quite the opposite, in our
calculations, only the first and the last timestamp is used, and we only
have 32 slots.

Ignore the samples that will produce less than MIN_HW_TIMESTAMP_DIFF
data.

Fixes: 141270bd95d4 ("media: uvcvideo: Refactor clock circular buffer")
Cc: stable@vger.kernel.org
Tested-by: Yunke Cao <yunkec@google.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 093186308eac..8d0fd7003c62 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -544,6 +544,19 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
 	spin_unlock_irqrestore(&clock->lock, flags);
 }
 
+static inline u16 sof_diff(u16 a, u16 b)
+{
+	u32 aux;
+
+	a &= 2047;
+	b &= 2047;
+	if (a >= b)
+		return a - b;
+
+	aux = a + 2048;
+	return (u16)(aux - b);
+}
+
 static void
 uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 		       const u8 *data, int len)
@@ -664,12 +677,13 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	sample.dev_sof = (sample.dev_sof + stream->clock.sof_offset) & 2047;
 
 	/*
-	 * To limit the amount of data, drop SCRs with an SOF identical to the
+	 * To limit the amount of data, drop SCRs with an SOF similar to the
 	 * previous one. This filtering is also needed to support UVC 1.5, where
 	 * all the data packets of the same frame contains the same SOF. In that
 	 * case only the first one will match the host_sof.
 	 */
-	if (sample.dev_sof == stream->clock.last_sof)
+	if (sof_diff(sample.dev_sof, stream->clock.last_sof) <=
+	    (UVC_MIN_HW_TIMESTAMP_DIFF / stream->clock.size))
 		return;
 
 	uvc_video_clock_add_sample(&stream->clock, &sample);

-- 
2.54.0.563.g4f69b47b94-goog


