Return-Path: <stable+bounces-237797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBqWLsge3mk1ngkAu9opvQ
	(envelope-from <stable+bounces-237797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:02:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3934B3F913D
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A3D50301A50C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9A03D646A;
	Tue, 14 Apr 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fsk/88ip"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B73939A4
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776164516; cv=none; b=JGi6rTIV15/uJeJ3gg8iKV4hSFMQFgKGqNz8DIJ/Epy9qdD71jWqvZLtGWiuuTyh2PtteSVM4zX83Ov6JmFDDejA9OkdzB4rPhesUNsJKNXtceG6rpnFBPUeFxq/pnxy857dtJwBcW87DNXv5rMjpwwy8ssfPryzUAuY/BUreaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776164516; c=relaxed/simple;
	bh=ev3wB14Q4uCalMGQjQkAPFGk9xIkjP6c1t5VM1fAs54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzUPyJP0dsFQMi4TVchZnfdUH4V/XFLlTqY5omzJ72b4vgYW7fy03L7mtG4ImvWs9BUF7VzQS3azk+7CT7AbboMQacKlk3yx1UhfP0DcFxEpH7l61Z8zPsYcdJVaBcCZ8negigCQU0nr86bITPrCD8j8V6lm352owWBXKvpTrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fsk/88ip; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38e7bd07656so15665161fa.1
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1776164512; x=1776769312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayvNAStYCw6+oE4lA2sn5i1gEt6Ll+Z8bF4kMpq/BUM=;
        b=Fsk/88ipOB24pA9n3UQ/WgkPQk91RNSLoGU0AecKo3CjTD8Hf/gerDTlda4oBdYp15
         JIypeLc7bsf7l1pCy+ogXB/08fmeeZxpaDA3mrnrMfHpilxFInYprwh3dVwRJhrzTeKO
         LVV+5tzdPo+FLNVy6JHUjXSkn/G3AUVrIwI2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776164512; x=1776769312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ayvNAStYCw6+oE4lA2sn5i1gEt6Ll+Z8bF4kMpq/BUM=;
        b=mNijPBALLEE0Y2XmPIkPl7gLzclZrkoaU9Inqnfb1tmKVQZKBqTccqS6wkSut4Do2e
         n5jf7rycuOdhh2Qx8CsAmLN2gK0yM7qPLmrYCAj8eeN+06NCsvU0aRjZ+Rn2vaxwksJ7
         aiS21uKFaoi5XUhBaAKasXXJ7c5rFEjD0KgIphaNdb6/N6FPafvBM/vlkYioBL9gAbh8
         7NvSPZ+lToqOfZP/r52xrwEGnRcypfu2vnCXsogSMLyJCgnyfEr2Wi1uIFdkkylwKMv9
         P8WP9QERspmyK3N9dCitdnQIb1cWI1iD772su9lopFa2Ndh82o+P0ZgpdQuzWofIPTj7
         rnog==
X-Gm-Message-State: AOJu0Yw7fbwWR2VuSBQRZViTAZLgJYzAmcMVEkW+f0JtWTG8QI+wmBMA
	RnGN3sa2rifbTPTuMZaJL0/ae5WuwRIYaMZSNDuWrWhaexn1eT0s64YzfsgFXvTmYRgqgHLQ7Ma
	rP8bupM49o1g=
X-Gm-Gg: AeBDieust+L7MDsoDHNL4helhdF4LjaLDxVXHstV2sqj0QkxfgMWucbtvTSznjPfmnb
	TxsnESAlSWJKfVhvVDxrRr/+Ea+pEV22Yok22tSUJQ6F9dB3rIxQ+XtAY3/oS93xVCoVSqBZdh4
	oMS9EQJof0Htuah+HVrXxwWwc8+/3Ay2lrfhNS3hADd04ZRBIkmlhOb2slB953z73opvECkPYg9
	48PMMKIypHpsIgQGWcsVg0/6nPgzPEzbWzReiJ6V1eANRYT564Cf2sYVnunPu/MMDSzjmlES5vO
	UssPh+R0c02T/wwQjavkA07g3O/TBAPX2KMIsur6zG2bbQr5pfuJ6hkiFBW/8kiEHcTo2wGQ6TO
	uYfYXvYd5Oq4sc6yyOlx8/0UWWF1nixKDrfWC8Yxj702G17TIFkXj43DEti1ZGPuAYiASPMTz/N
	ORYUNsqTF82uY0ei8TY2bj5QrmMYY0KOwxNAsKs1EKPtnbKwqzW13BiyvNAaktEYS+HRyjIpP/P
	3DCElj81QmlI4VvA1xXtf0=
X-Received: by 2002:a05:651c:4188:b0:38b:e464:f047 with SMTP id 38308e7fff4ca-38e4be29293mr47817681fa.12.1776164512447;
        Tue, 14 Apr 2026 04:01:52 -0700 (PDT)
Received: from ribalda.c.googlers.com.com (52.163.228.35.bc.googleusercontent.com. [35.228.163.52])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495ae96fsm28055261fa.39.2026.04.14.04.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 04:01:51 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Angel4005 <ooara1337@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 5.10.y 3/3] media: uvcvideo: Use heuristic to find stream entity
Date: Tue, 14 Apr 2026 11:01:13 +0000
Message-ID: <20260414110113.319219-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
In-Reply-To: <20260414110113.319219-1-ribalda@chromium.org>
References: <20260413223308.3760836-1-sashal@kernel.org>
 <20260414110113.319219-1-ribalda@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[decadent.org.uk,linuxfoundation.org,chromium.org,gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237797-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:dkim,chromium.org:email,chromium.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3934B3F913D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 758dbc756aad429da11c569c0d067f7fd032bcf7 ]

Some devices, like the Grandstream GUV3100 webcam, have an invalid UVC
descriptor where multiple entities share the same ID, this is invalid
and makes it impossible to make a proper entity tree without heuristics.

We have recently introduced a change in the way that we handle invalid
entities that has caused a regression on broken devices.

Implement a new heuristic to handle these devices properly.

Reported-by: Angel4005 <ooara1337@gmail.com>
Closes: https://lore.kernel.org/linux-media/CAOzBiVuS7ygUjjhCbyWg-KiNx+HFTYnqH5+GJhd6cYsNLT=DaA@mail.gmail.com/
Fixes: 0e2ee70291e6 ("media: uvcvideo: Mark invalid entities with id UVC_INVALID_ENTITY_ID")
Cc: stable@vger.kernel.org
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/usb/uvc/uvc_driver.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 34e3f04340a2..20a18caf7717 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -442,13 +442,26 @@ static struct uvc_entity *uvc_entity_by_reference(struct uvc_device *dev,
 
 static struct uvc_streaming *uvc_stream_by_id(struct uvc_device *dev, int id)
 {
-	struct uvc_streaming *stream;
+	struct uvc_streaming *stream, *last_stream;
+	unsigned int count = 0;
 
 	list_for_each_entry(stream, &dev->streams, list) {
+		count += 1;
+		last_stream = stream;
 		if (stream->header.bTerminalLink == id)
 			return stream;
 	}
 
+	/*
+	 * If the streaming entity is referenced by an invalid ID, notify the
+	 * user and use heuristics to guess the correct entity.
+	 */
+	if (count == 1 && id == UVC_INVALID_ENTITY_ID) {
+		dev_warn(&dev->intf->dev,
+			 "UVC non compliance: Invalid USB header. The streaming entity has an invalid ID, guessing the correct one.");
+		return last_stream;
+	}
+
 	return NULL;
 }
 
-- 
2.54.0.rc0.605.g598a273b03-goog


