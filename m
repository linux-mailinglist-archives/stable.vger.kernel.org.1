Return-Path: <stable+bounces-227982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KGxNgY+wWk9RwQAu9opvQ
	(envelope-from <stable+bounces-227982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:20:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 503BD2F2B8C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB21304CCDC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD3E3AC0EB;
	Mon, 23 Mar 2026 13:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W4FNoOAJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70D03AB291
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271446; cv=none; b=Kz6B0FNaaHRFPt4xXB3Zd1eTybdTImul2SdSZcUWsMCOUuXIXkuNR+zttCXhFjavjyICSfjeTmW4Fs19h94CaNtcG7/8vrP3N0FFYqRqG2auO+pN9HX42vp4t2Te5OKvZVg2wbh5geZrCziTE+zrxA1FCPOysUG+rXvvHF72p/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271446; c=relaxed/simple;
	bh=F309xMOsoYAt3en3fSULuoIwejw2mSILjG/RfAGmen4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jAWa/FbFIo5cdyAZYkyeDgzUsfmiYpP2/wZNQOBh98aAZPmTo2WDGWqKhKFmF/+4ewTDEKo/n7ca7+36Mznbv7T6I5khN5XQScpPgD2zhhc0BDWCjxz21Gf2itQLfm+n9QGX6KPxRFUFSgnjrx8swDUcBZX5zFRiMVYB9nZ+kDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=W4FNoOAJ; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a1307438ddso2913964e87.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774271443; x=1774876243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HU1BwRIgJwIonvocfX7YrDLQqPhrL3H19ZNgFff0aO0=;
        b=W4FNoOAJ/P0Lqq2IBz7ZOYmRaw0OnlX+2bnVbZuT/rz/SQJcXnvcfGUD8juIyFrFk/
         pyB+TI2yaLKYEuSzlpaNnIixlGchvsF/Dk2S5JCfPAtKQ25ZE0qDsuaXBfuuCvjdu9VI
         THwN41llnsIXDmr42wpnsjWFSPKkC9XhFyFsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271443; x=1774876243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HU1BwRIgJwIonvocfX7YrDLQqPhrL3H19ZNgFff0aO0=;
        b=fRwjyb2vxV4zc6lO5sR6ieCLisuenRgrzPv+BpwT30Gd7DpGt7z0xz5HvuhmMZt3Ka
         wz75rjaUZ5y1Hz3CuFfhAoQfnfNuN4Q4HkkcajFIl3ZmlwUDxLN9F5gXnaM+8reurYqm
         7gjuGO1SrE7aRCt9YrpTIFOap/Qk5Apa8tGenYk128MUbhTslZrQpBhfnmv8ABxUcDr4
         mwM35d1gtGuvjt5BWqMKDQNdlbDgAwKRn5AY24SNJGnmkpglnSth6DNAJHKCCrtBasv+
         4dRWAIVWQcCzUQnHdFp19x2Fe3rSNA1rjp60AqSglpMfDaLRTDUc2NOZRyIOrEcxEGCK
         eLoA==
X-Forwarded-Encrypted: i=1; AJvYcCXc8vIptbQggyHBkqDf2qZTHmqmskeoogr5eTQ7VZSd8Ngyn9jWlR41MTWlm+w3bt5GbjuXA+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxci23HJCBPs8q+fI1pxzolcK3ySJO8yfPhS/0f8OMcT8OIkv2Q
	MmQC37gvvO3TxjyEzQX9lrrCQCTE7u0KNF8q/fxe81LMEAaFpacApoxYimvpI/CtEg==
X-Gm-Gg: ATEYQzxB29F3dHF/B097hHEcuAwMlKwVhKKl2lbjHXqzIg42WIGCktA1/cALqvyvoQl
	DulQvDkFxLB0jcOLuhnTH+tukgI29lhkhyC+x1b2J2VZSuXBQef/+rjWEARf9Zh11lpOxlNYCOg
	gXmHoWzOnGrrDVzyFZeDSnDQ7mAn/hOJpjQ+luttHhxATHQKJoeJg/ShWXNn1J2G9HGsqN5u5fL
	wTLTD2/bRLpHAxldbzTX3wUiWIkZEcbZ5gnQhNKhyO3aGX8CUnVgqPMJOXJKn9LthIf2xFQzMqJ
	6Q8OLSyJhWGrEVTgJvbHHlG5XC3d+ppqMbwWucaSLEDDVgFKCdDhH4o/xz8GlTCvKYU1xe+JKOR
	llQpehR2eHef/ogVdENLyXfyAL/U2caUhwhjZBfzwGblTb02uNyoZ6uc7W+W2qWMyYa0N5G1mhf
	34U3OTjxxpHszuKpGL5QQElPdK4/GFdByhlZdVThayC0UAY7v0GdFDWf/bMVbdiFDE3SOkyNap1
	YB0S1w=
X-Received: by 2002:a05:6512:3781:20b0:5a2:8637:8189 with SMTP id 2adb3069b0e04-5a2863781a0mr2777613e87.23.1774271443002;
        Mon, 23 Mar 2026 06:10:43 -0700 (PDT)
Received: from ribalda.c.googlers.com (252.116.88.34.bc.googleusercontent.com. [34.88.116.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285305e07sm2515904e87.66.2026.03.23.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 06:10:42 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 23 Mar 2026 13:10:31 +0000
Subject: [PATCH 4/4] media: uvcvideo: Do not add clock samples with small
 sof delta
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-uvc-hwtimestamp-v1-4-aa42e3865204@chromium.org>
References: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
In-Reply-To: <20260323-uvc-hwtimestamp-v1-0-aa42e3865204@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Tomasz Figa <tfiga@chromium.org>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Yunke Cao <yunkec@google.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227982-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:dkim,chromium.org:email,chromium.org:mid]
X-Rspamd-Queue-Id: 503BD2F2B8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index dcbc0941ffe6..e1a4e84d6841 100644
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
+	    (MIN_HW_TIMESTAMP_DIFF / stream->clock.size))
 		return;
 
 	uvc_video_clock_add_sample(&stream->clock, &sample);

-- 
2.53.0.959.g497ff81fa9-goog


