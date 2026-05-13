Return-Path: <stable+bounces-246819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC7DA3BlBGq6HgIAu9opvQ
	(envelope-from <stable+bounces-246819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:50:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44A53286A
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C71C30CF9A2
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1893FFAB0;
	Wed, 13 May 2026 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hCK1Rflz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815FB2D73BC
	for <stable@vger.kernel.org>; Wed, 13 May 2026 11:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672970; cv=none; b=o5AaLZ6hCkoAEaws3J74rXvSNTw6/Ibt6vOSNtBxqxnLP+W3kxrqEe0bN26bYBD7JU7GwtXNs1YJfgunveZvIiqZCvLqUcYM1QQ0TSRMyjS85K7nU3ilcN1MhB9JklYUjweD/gaR/UZ5vh2Ots76JkAYGhPlV7EoJ9gvpN0kg6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672970; c=relaxed/simple;
	bh=klHvoOAvLgogJCjXF1p9Lx1AYWJ1Uy7uv4LHsL7Achw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcT/Ylisv6OwB0916eWjLlQ+GeNK06+4TPBo3kTl6CWedC8ssIPvEsmf0Zgucrp1RTz6mP2el1pT8XHLlAU6FpCg7RpxVwL3xKQPMeT6Rm5Lgv2JBXBBEDsGNAox7ACTje/8EFaYpyQGJagtCdsN9h+sw6c/fiBDYi1hI2esx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hCK1Rflz; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39397d63804so77425431fa.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778672967; x=1779277767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3k96l0fVwsw325zvQ7IYk4KSy6vkoaRijnncfaGnQlI=;
        b=hCK1RflzTzY590UlZvqnSVg/uqwsHfC5cBXzmlgJwZ1QlEJjPbqJKnHf3B1kvY3LCJ
         Ugbzuwg/M3wKXODfslU6+cB6ntmitLYZNNKT2jGfDJ0Oe5aWLkfI1FHJuWofFOv9TJ6+
         nmZTREO+0VaHOk/25FpOGfAUWvOUmJYPpaHqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672967; x=1779277767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3k96l0fVwsw325zvQ7IYk4KSy6vkoaRijnncfaGnQlI=;
        b=cCDK5kfLnHt4ZjP+NawUQ+5nS/ryrcuQqVIiAEcu/0xiux5d07yFrc2r5WsPppZir4
         0+5m++712s5kpoEvMSfNcrJqTJd6lKBGB9JiqqqKi5Tdk8GFEQG4B+2kAjj4RtGRm+Wk
         rdtmNlQEcd0YnupRhlu6ZHrSFjsLhWhguVjJ5GV2upUJStOmTLX5CDPteCdiCxBFus6N
         FQAM6fXuS89bm+I1niJj9qUFlu5Y231B1gCkF0Q3qP9JCQM21M3wIedws8CBYdFWC5Aq
         2OqC974DrTFi68NdJitUQfDyU7VjHvBKI4+YN5il8wKxxoasgsf7m1crucUaJXxSykz3
         LkOg==
X-Forwarded-Encrypted: i=1; AFNElJ+0tnpwLF7CI2EsHSY3/q+nBOdsW9pm5ioyo5DlGY/LVMrCjCEcN+4/qilk7JqlYxjqotqbg4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwInzY5J6yL5sKhi0muslp+26S88xVVJPCwelV6BqwBOybVSsVo
	Tim/p0Bd/3Pu0ddu3SG/As3FgWh/eaae561x+NGrJRToBH8WJ4kLHDNcZAT8PlDxEw==
X-Gm-Gg: Acq92OGo3BeMmSo31MCv7HDo9jaYmTSLkxrzste2Gik8prQvEC3rCYey/QKDph/0zYh
	iCKSmTukGlXD2zNzesSkyTC03/OcQZoJsRR4ROSi0DUU/hyt1z/Vo/hWUyL0p4BoSKYxhdgt3Ow
	T+/v3ttgSufLfjX9u7kFt9ugjMDTGz7Q8PjZLdEDRqlyY5MzfeA6q/GQJI/DfQgHX6M6QBrFNdJ
	6YbVO0VvX5k5qaN6pRk84ELoWTwUNBEBcDhsqrflXQcU6nPPHE+1DJp9EAEBlYPwcWVPMdcD4iO
	LlyTEFOK1dHgSDRXP2ahOby0erbzNiWD2qxi9ca3XygSeCO563GVKGzQHQXshFd0yQ5j1N4y2dR
	d+R65Ky+odDv3RIj5bWFvEeNCzgrWAvJrI9Fu5lTix+zQkvjwubigLpGN5k5KhWXxDhYfoEjqdg
	f0RIHJ04+TxvDsEWSfJq4xtYIL29/LS9z2y1zj82E9Ae/vRJYckXq+TCf98/JCdUWww2S1woda2
	g==
X-Received: by 2002:a2e:bd06:0:b0:394:f1a:2706 with SMTP id 38308e7fff4ca-3944b7661b7mr9834031fa.30.1778672966794;
        Wed, 13 May 2026 04:49:26 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4f1sm40971071fa.27.2026.05.13.04.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:49:25 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 13 May 2026 11:49:20 +0000
Subject: [PATCH v3 1/6] media: uvcvideo: Fix dev_sof filtering in hw
 timestamp
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-uvc-hwtimestamp-v3-1-7a64838b0b02@chromium.org>
References: <20260513-uvc-hwtimestamp-v3-0-7a64838b0b02@chromium.org>
In-Reply-To: <20260513-uvc-hwtimestamp-v3-0-7a64838b0b02@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org, Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 6D44A53286A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246819-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email,chromium.org:mid,chromium.org:dkim,qualcomm.com:email]
X-Rspamd-Action: no action

To avoid filling the clock circular buffer with duplicated data we only
add it if the new value sof is different than the last added sof.

The issue is that we compare the unprocess sof with the processed sof.
If there is a sof_offset, or UVC_QUIRK_INVALID_DEVICE_SOF is enabled,
the comparison will not work as expected.

This patch moves the comparison to the right place.

Fixes: 141270bd95d4 ("media: uvcvideo: Refactor clock circular buffer")
Cc: stable@vger.kernel.org
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Tested-by: Yunke Cao <yunkec@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 62db4db4e565..2ad36a1f4948 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -583,16 +583,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	if (!has_scr)
 		return;
 
-	/*
-	 * To limit the amount of data, drop SCRs with an SOF identical to the
-	 * previous one. This filtering is also needed to support UVC 1.5, where
-	 * all the data packets of the same frame contains the same SOF. In that
-	 * case only the first one will match the host_sof.
-	 */
 	sample.dev_sof = get_unaligned_le16(&data[header_size - 2]);
-	if (sample.dev_sof == stream->clock.last_sof)
-		return;
-
 	sample.dev_stc = get_unaligned_le32(&data[header_size - 6]);
 
 	/*
@@ -664,6 +655,16 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	}
 
 	sample.dev_sof = (sample.dev_sof + stream->clock.sof_offset) & 2047;
+
+	/*
+	 * To limit the amount of data, drop SCRs with an SOF identical to the
+	 * previous one. This filtering is also needed to support UVC 1.5, where
+	 * all the data packets of the same frame contains the same SOF. In that
+	 * case only the first one will match the host_sof.
+	 */
+	if (sample.dev_sof == stream->clock.last_sof)
+		return;
+
 	uvc_video_clock_add_sample(&stream->clock, &sample);
 	stream->clock.last_sof = sample.dev_sof;
 }

-- 
2.54.0.563.g4f69b47b94-goog


