Return-Path: <stable+bounces-245468-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJK7NGQeA2r10gEAu9opvQ
	(envelope-from <stable+bounces-245468-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:34:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F37A5203A7
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF1F53031856
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F8F4D98F4;
	Tue, 12 May 2026 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYZht6Es"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BA4C0433
	for <stable@vger.kernel.org>; Tue, 12 May 2026 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778589077; cv=none; b=efwtmDLvCi4+Disb34OKUp9Eyil8OQul2KhnsIz3jY7y7vlKGKa5CCns4cRHOHO8R0/yVzusQAfSZjRDRW43qWJhBJxYCq/MIGkH9M/ph8tPsxNZTKnvF5+OjzYNJ2QI3xAoJcJV30mGvMi1YOAMfIzWFxFwtYKYKJL5O4jfhl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778589077; c=relaxed/simple;
	bh=QXZqxLkq5iFv9Y5EXJVO+rFjPbN/6N4mmA5gawFFR8Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxolQk9krBXRyPPzkDZn+a6C1yB0tpiI8zgdarFqY5a7Y+glOyzd1RYP6Q/hcByTh5D+u3iKb7QiDIqf7y7TcKtH7+FJpIHZyd/pz1m5dUJcUfDwGEwyqedCoqOp5CJEQSf4BvkIWIb/Dt8Y32KEUGlqrMiIyGVb77/jH6brsrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dYZht6Es; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38e7c3a2deaso46890621fa.2
        for <stable@vger.kernel.org>; Tue, 12 May 2026 05:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778589067; x=1779193867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m9zYGesGzTkd0DsUCizsvVcECB6Unr6npXv+sKC4A5I=;
        b=dYZht6Es1vqFhALhcGKBJWB+hACU06x1HdhjWN91c+4Nr974wzyacmwo+qewTfkvbv
         4GN6ie77hgwwQ3VdBpPtzVOkAtHqkYHfJPCP2Y/NwlNe9Tmj3EUgnqr1QnT2kPHbpLCC
         TIldZNzg/cxqvRn9XymdM/nplaBQBQUyqTWb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778589067; x=1779193867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m9zYGesGzTkd0DsUCizsvVcECB6Unr6npXv+sKC4A5I=;
        b=EdSsefmwofZtWMsZ5RcP22ze9Vub7w8wCmdwPStITNpXgeyMzSQdCxHeYtzLVRTJ17
         kLYFte5gOiqAXI9IVozZ4A8cAeJLI85lgsUj4htOTYvlz3O7KBX1Hm3I/sclpaypgkxA
         Ff6XjzDTV3rCYgbp+goOa/Ulhvnp2Wv1q648w4TMa94I6Z+yHCQr/NQCQz5o8F6+53hN
         nN2GhBIeqsatTHmEy5lER3r/mYdqx8KXXsxn6FqAKCeo4b0CfvSs674XiFeM587IMZno
         nldpVw6055LFI/BireU4CNzHMvQDLIBjtEIlHndYyzgVebh3tP1tDpzYVXMBVC1Ou1qv
         55YQ==
X-Forwarded-Encrypted: i=1; AFNElJ/N+W6qBXpt1ZoFHbXVmZCdBD98sipK1+0AusvL0vk6tO7Tuywyco+q6bLjmmHj2Tmhlv+OXf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA1sM7B9Yt1NbXvPoYQT1PWTKoUuFos9yh3gDsbSNkEiDnl6As
	MPwpFdcosy2HNeRLSmLgtal1RDJJFwIZFUJ7lTjf73cRJuwrF24vxfSLiBpLmD6/uA==
X-Gm-Gg: Acq92OGJuNxfMQZFVL84vlqTjZOG7xEMdhbDsZOWvwu+IN444yg7xXz8tYOw69bZopf
	rPG4LJPlnYo/ztBrvpQYex2C/FnRZTbHWNunKjlk418m2zgHIfd1cK3b4CrJCqyOa32ZVlou5EV
	a2i/hiwMlzFhTtIjes1wszS/BmLauI0CCfwYsWW9gFwUclgNVvGosj+k9l/s2Qn3LIsiP9O7M8J
	2yPJsOWhfer8jByWfug9Mgec1rzS0vUhf38xOjyTw6zKHBBTyZOs1EGbn2EaoQ9WefC0wmng5iE
	vp4+WKDO8BI2QyKxX0o/tgIbCoogr9/gSwfIwFLmyivmSisy7dz48eHNop/63YiwM4IJIFtgmJo
	XEO6lJNtOBuLjHOAaf+ljHgCKSJ+1u7O21NgScHL+WCgM8MEbfcbwr1ik30Rx2eynzPNJsgvbvV
	EMXpV6+Xs/vrqQR6jEI0ytQ8EUc3MXDJp8vWTAVhKeEC6x343nu8cCRYMXOY5dSqhYZGdPoy1sx
	g==
X-Received: by 2002:a05:6512:124c:b0:5a8:8db6:b1f with SMTP id 2adb3069b0e04-5a8e31e0f56mr917863e87.24.1778589067182;
        Tue, 12 May 2026 05:31:07 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8c66facc2sm1861344e87.22.2026.05.12.05.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 05:31:06 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 12 May 2026 12:30:57 +0000
Subject: [PATCH v2 3/5] media: uvcvideo: Relax the constrains for
 interpolating the hw clock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-uvc-hwtimestamp-v2-3-3c2905c733bb@chromium.org>
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
X-Rspamd-Queue-Id: 1F37A5203A7
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
	TAGGED_FROM(0.00)[bounces-245468-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In the initial version we set the min value to 250msec. Looks like
100msec can also provide a good value.

Now that we are at it, add a macro to make it cleaner.

Fixes: 6243c83be6ee8 ("media: uvcvideo: Allow hw clock updates with buffers not full")
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Tested-by: Yunke Cao <yunkec@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 19a2880e0dc9..093186308eac 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -494,6 +494,13 @@ static int uvc_commit_video(struct uvc_streaming *stream,
  * Clocks and timestamps
  */
 
+/*
+ * The accuracy of the hardware timestamping depends on having enough data to
+ * interpolate between the different clock domains. This value is sof cycles,
+ * this is, milliseconds.
+ */
+#define UVC_MIN_HW_TIMESTAMP_DIFF 100
+
 static inline ktime_t uvc_video_get_time(void)
 {
 	if (uvc_clock_param == CLOCK_MONOTONIC)
@@ -843,13 +850,13 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
 	 * buffer, but RAM is expensive these days, specially the infinitely
 	 * big.
 	 *
-	 * The value of 1/4th of a second was determined by running Android's
-	 * CTS on different devices.
+	 * The value of UVC_MIN_HW_TIMESTAMP_DIFF was determined by running
+	 * Android's CTS on different devices.
 	 *
-	 * dev_sof runs at 1KHz, and we have a fixed point precision of
-	 * 16 bits.
+	 * y1 and y2 are dev_sof with a fixed point precision of 16 bits.
 	 */
-	if (clock->size != clock->count && (y2 - y1) < ((1000 / 4) << 16))
+	if (clock->size != clock->count &&
+	    (y2 - y1) < (UVC_MIN_HW_TIMESTAMP_DIFF << 16))
 		goto done;
 
 	y = (u64)(y2 - y1) * (1ULL << 31) + (u64)y1 * (u64)x2

-- 
2.54.0.563.g4f69b47b94-goog


