Return-Path: <stable+bounces-245467-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOmAGl8eA2pD0gEAu9opvQ
	(envelope-from <stable+bounces-245467-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:34:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D15520399
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CBE013037892
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DED38D409;
	Tue, 12 May 2026 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DWKZPVYu"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AC91448D5
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589076; cv=none; b=M0WPvWpMSnijXt2Aywn7GBaw495/g+s11CprLejQMujgaShDqQC2NoQQ0KcYXGMDB/ufrlon4ubOPb8jEZowRjYTjOE4bYMeN1bYa6+Olghqma2LVzMflBYaxhSzAiL66JjY+aC0oKjepapXoTA3xKvk+PNUDvoDFWUVDMRem4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589076; c=relaxed/simple;
	bh=PyPstSDPnSS7go2Eeoifto3b0yR6kerSh2wHnfrgQC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEkgy+0AhAUG8aukzqNB/bz6w1pOdPdSrrKOcHfcDt5LcNv0O3D3vXsO1L0UcQUdTtesKo2I3bQ5NeO5gM4i4NtW1Pn13v6UvpS6x2JWKyXwpcE6rH9Fa2KMdDa09I3N5NVmAX4n9rjt8bLRSSOOZ5cKHddVGINWFaoT5VKlBWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DWKZPVYu; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40502e63bso4967670e87.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 05:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778589066; x=1779193866; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tn8yR9axPkcG+PDvfr1W0s/qaLqZqhB6pcQAbzPTKls=;
        b=DWKZPVYuipI5YjoJWvErpuVrVH+RQ3HKWEZlL9o7QygdYY5/0lmuC2NIbFa0yUPuSg
         R9TdzCaeKAodbc5z8Z4KXXZ+OTkSCHNgjw45kLDh2ze19sH+vNmd4M7sY1+S1wUAI7vQ
         9diag2lx/ra+l5UoEApLcJP02XDCDhTzhzkDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778589066; x=1779193866;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tn8yR9axPkcG+PDvfr1W0s/qaLqZqhB6pcQAbzPTKls=;
        b=oHOKZYyEatAgP8dKt4xet2adeUKB03etuU5uDgwtvHKF4eZsbUaapHvdSHD3uCmrER
         gxuAKszXqNGXXLhwH0T/7L+olZ3Xly32j+TK+17UNbS8hgltm8SOBvda6Y944Mr45Q3K
         Dexd/A6PxyqWCskfdlDf/qeRAPrdWEVbnc9Ggle/EYuYZuwI07VzwaT407HtbwLzddnF
         HrEMNvyoHBRMIRWWOYlFd3yaVk4CZXx/6We7oTCN3r7smz+Lj5S8uDEe1um3TLXOXNww
         UAK238zWi41X9+NBJG8L5/FY6DGTo8SH9fW3YMWtmrPS2r75ThBQTZVhSJF+KSZxvpuY
         kYpA==
X-Forwarded-Encrypted: i=1; AFNElJ96fjF/TYTzb6c9NUdhCUGaysaEQFJbrTC0GkE6uN1t6PrBzkPgfGQSagnMSr4hGoUH+d2Qt6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRnN7Sjc4FjNiXAz1TzKIS7B4nQO4YeHxXNvi0qO/m+rMBWnVv
	gDmcv3H/LntEsUqpOAgxTGtWFhGOtgZ4sEq96iLdtpEDZfw2zqhQHuYMteFVgODlGw==
X-Gm-Gg: Acq92OHZcNjuI2r1SThvclIpCKsd5Cf3VQ0RNGajaGU48kqy8q6kT+J2QHdY7IwMTRe
	GVDnvU5PlSEGM/K5yEIVDkBrT/7U4q1vvsF03DnFziywEpyXR0RZQy8B0lWnnuTiL1MMhtv2apd
	BqoLdk0EbLsjHN+WQYIXriagv3P1DyZWi53ekdqyQIDXHMoYSHbkBiFo6TCbz+Qg0oR+yCCH+6D
	gw4NqqzqA1rHdco1M3nrdIjm9WhvJhKzoLpKrt/HcsyExuATrlI6HfKE4/S8JNjoLxfXy8mB+5s
	JHpbotvWocnAhuiIfJxSBwSU5WIiZ3ghsd0MkQ9hZUildH9jb/HG2eHX1N1FqN+GOKgoo+Pd0GQ
	JlgbE9jRde/G1AmRHnfjKFxC19U0cbtxUedKruxw/tOwBSFDBXALlFOHFdVgAeOPT7JSWSFxKql
	GdDA31UwhtuDPmOHGw5xCVkVUSpMnoaU+GNmYrVwMYGzOduAa1gYs4yj9Odx4S1QmW8h8CBrqEN
	g==
X-Received: by 2002:a05:6512:23aa:b0:5a8:9135:128a with SMTP id 2adb3069b0e04-5a891351b9bmr7594663e87.15.1778589065945;
        Tue, 12 May 2026 05:31:05 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8c66facc2sm1861344e87.22.2026.05.12.05.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:31:04 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 12 May 2026 12:30:56 +0000
Subject: [PATCH v2 2/5] media: uvcvideo: Use hw timestaming if the clock
 buffer is full
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-uvc-hwtimestamp-v2-2-3c2905c733bb@chromium.org>
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
X-Rspamd-Queue-Id: 60D15520399
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
	TAGGED_FROM(0.00)[bounces-245467-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Action: no action

In some situations, even with a full clock buffer, it does not contain
250msec of data. This results in the driver jumping back from software
to hardware timestapsing creating a nasty artifact in the video.

If the clock buffer is full, use it to calculate the timestamp instead
of defaulting to software stamps, the reduced accuracy is less visible
than jumping from one timestamping mechanism to the other.

Fixes: 6243c83be6ee8 ("media: uvcvideo: Allow hw clock updates with buffers not full")
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Tested-by: Yunke Cao <yunkec@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index cbf67c17a49a..19a2880e0dc9 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -834,15 +834,22 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 		y2 += 2048 << 16;
 
 	/*
-	 * Have at least 1/4 of a second of timestamps before we
-	 * try to do any calculation. Otherwise we do not have enough
-	 * precision. This value was determined by running Android CTS
-	 * on different devices.
+	 * If the buffer is not full, we want to gather at least 1/4th of
+	 * timestamps before using HW timestamping. We do this to avoid jitter
+	 * on the initial frames.
+	 *
+	 * If the buffer is full we would use it regardless of how much data
+	 * it represents. This could be solved with an infinite big circular
+	 * buffer, but RAM is expensive these days, specially the infinitely
+	 * big.
+	 *
+	 * The value of 1/4th of a second was determined by running Android's
+	 * CTS on different devices.
 	 *
 	 * dev_sof runs at 1KHz, and we have a fixed point precision of
 	 * 16 bits.
 	 */
-	if ((y2 - y1) < ((1000 / 4) << 16))
+	if (clock->size != clock->count && (y2 - y1) < ((1000 / 4) << 16))
 		goto done;
 
 	y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2

-- 
2.54.0.563.g4f69b47b94-goog


