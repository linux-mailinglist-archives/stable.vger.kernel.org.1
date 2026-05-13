Return-Path: <stable+bounces-246821-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDO1EshlBGq6HgIAu9opvQ
	(envelope-from <stable+bounces-246821-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:51:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A17345328CE
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BA7030FCBA9
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964BD3FFACB;
	Wed, 13 May 2026 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GuxwttD6"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A59A3FF8BE
	for <stable@vger.kernel.org>; Wed, 13 May 2026 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778672973; cv=none; b=cibe01ukT2JzES0n7qSoLywUeTiC/7uEkB60lWqfpt0vmp5ejNvLHQ6aATAKPK/ynd73pL/gFTGn6hugT7s+oMGrwCTfhx6PlOpKrrICnPPH4GaUwAeC0wH4EI9A3jXk7/CrW2K9A1BP807a+ttkYBOg7dUVaG///lhD0T3uQFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778672973; c=relaxed/simple;
	bh=JUaMHkC5DDmGPxOxMX018PdMdBjM0VT9k/OIdCbMX/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IQW5iCnT74T1ukeQ1/GH7iQIt+mZiEDSOokUmJg4DONpQrdoGGk3dm2i/BKw3ulFDLEKLeMZNHZX/lCpZE4hivmMUg+xZtBz04H6hR3Zi94vijakFh4HL7Cp9fXJUmmpgnhjclyZ6JlGhOe8GvEiezPLMFOX5DXZebVP5ALRR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GuxwttD6; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-392445f11c5so68342631fa.1
        for <stable@vger.kernel.org>; Wed, 13 May 2026 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778672969; x=1779277769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bmtb+ICKBQ1P69XGsTJCXIGwUDaGvqHA8PV94ag1Rbs=;
        b=GuxwttD67/612PrCpbW3r5nKyITrCcIr26pX5oQirvgkobSFARzoagLuvrO0edYYyw
         7lp7kWSV1eM6EYnkrbR5HlGQhGhkygNNkXPnFsCozSNEWiy2yxOk3m/II0wNnJxHyMT7
         ezYsv/AAbskZWz2cqDJrdII8F4ZK6bqNXNEWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778672969; x=1779277769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bmtb+ICKBQ1P69XGsTJCXIGwUDaGvqHA8PV94ag1Rbs=;
        b=Ywje1Rr/Mg2XolQ0Mf7Vfjc5OPUPlOIu+SI40mFLyst6EctMfg9rSsgptBXq0zPBg/
         Qpx6jg5x1aSLKgMKhp2dDcpgwUxlXfi0WiCVlmt9LjurqSVtkHfAPvReCRoGfR1M3/pl
         jrI0/h5LjWIGnoIitYS5ueCW3LVrsmt3+GaOR5dKnS7KrAUArI7YszHlCxaxGbyDpOaV
         +yyi5mHr4EODXn+A8985uU4hjOfa2Yo4mrSms8L+J6i+Zx7GUQlHkwNrKu1md7Huot6K
         j3K3ozPtkxjHxUC0uuOjvys93qiblDqSwLNxTRs1vdSp9i9TMN9P71Q/IVxPE7ftvR0G
         dVDg==
X-Forwarded-Encrypted: i=1; AFNElJ82wgyW2lu2f5n0QR3wYr+AAUBwsSAg/BHM0ee3E/iIuTE7e5JRMDfjIAYTV96ItwgsH+hqKOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4RZMotStFpFIIXyjLrEPQTD5Z+sqLlzhx10PdhAwsbW71VPbg
	DjDbyhKQqos465zfeGHszt3SjfcS5d5f13E7GNNc4iJB+5ox8KEE21lxo35FNBzpTQ==
X-Gm-Gg: Acq92OGnVITB/mqvXoj4Rq2Bg02QzykeBngSTLNwqdVjK1gwShBUP+rqNllZJKlgVhn
	R7txs9CCkzTJyRBf3Ux8w9tFRmO974gkzh6t888zy8omPiSyG4+VB6yOi+9OglNqQreqSPSwzcr
	NmEMoyynNq0F2PaDOtPV3tl5+750N989wuErJa7BK1kYkFp93lZ7ZehB8Ssy6lJPLUicJ1ddr4/
	MOwbDhYV3fBxJh475zVownEnUd/qW3PnWSQmh9YDi0J5nt/Eqj9G0MsDZIcdpngTAI3lqTX2MoI
	0iUZtTf9z57yHM85lnxcdwGWl765M0WfyfgGRToB/chG9se6MgZZJSH6aDfHzrRg3BCWZQmhpnv
	+c5BxDe71YrSa0E+NdskzIGULYa1pHpgjDIr1g0kiftTQ4dcOYSYWUQb3baV5xh9TO75sFFCj9K
	91AXHuKiqxX6jJsZivr0YX87LH8dDlQb/QcAGc02YW1DFqg3tCKMair5uBkQjQIfLgfRQ/fBvCv
	A==
X-Received: by 2002:a05:651c:41d8:b0:394:8fc:8c3d with SMTP id 38308e7fff4ca-3944af67cbdmr9578691fa.4.1778672968626;
        Wed, 13 May 2026 04:49:28 -0700 (PDT)
Received: from ribalda.c.googlers.com (11.36.88.34.bc.googleusercontent.com. [34.88.36.11])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4f1sm40971071fa.27.2026.05.13.04.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 04:49:27 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 13 May 2026 11:49:22 +0000
Subject: [PATCH v3 3/6] media: uvcvideo: Relax the constrains for
 interpolating the hw clock
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-uvc-hwtimestamp-v3-3-7a64838b0b02@chromium.org>
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
X-Rspamd-Queue-Id: A17345328CE
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
	TAGGED_FROM(0.00)[bounces-246821-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email,chromium.org:mid,chromium.org:dkim]
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
index 01dcb81d96fd..355b9bfb799e 100644
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


