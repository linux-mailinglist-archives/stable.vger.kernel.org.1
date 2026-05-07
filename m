Return-Path: <stable+bounces-244489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDhkHCUK/GnvKAAAu9opvQ
	(envelope-from <stable+bounces-244489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:42:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D91694E2B38
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7470303A263
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 03:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C222E62B5;
	Thu,  7 May 2026 03:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckc78MDN"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34F2EA73D
	for <stable@vger.kernel.org>; Thu,  7 May 2026 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778125271; cv=none; b=m5kOOdH6Ie6CqRdBxvnAqh2nctdHjwsmk83N6e4WsB6XVrw9AWwXS1yhSLcxhXfMKq8jsS63kDQRv0eU1T8PIjU0ChOVCnT3Um/JRBdeOM/dA6kGKbkqKw22R3n9NbVBg2pr155lsx5pa7KYHymVa+vrgq7/BpuhB99lTxgyGEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778125271; c=relaxed/simple;
	bh=5ZxZyVybouA1Mduqbo3hKVa/J06PZ5yuIW+r71ae+mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSBqbwJj4X9Koy2x2H3FiH1j/G39SzNe7xpKp/zHmJWtKar3ru4RZ192dSzBMBXFBGSoLqBTMNm67OKVWMU66UOVBn4ryGYVA6SeFvQ8SQ+PB/bp3JDvU5ozZsgeMdJVSI+VnP/v2AvLbbQc+LbYpRkYQ77jBLoY/7PAdSmv+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ckc78MDN; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-130c653cce4so1169127c88.1
        for <stable@vger.kernel.org>; Wed, 06 May 2026 20:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778125267; x=1778730067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nleLAQUlrvdfXv9QhDg66/S/1PB+xB3gu8412xW8j5s=;
        b=Ckc78MDNLJRna3a8udTpjqtPB7GgSb1Lfr1P23wEVvk41m7O4hLedsnRb2qsi86Yiu
         qAvh/24esl/egLk4+HMw2W76QZDiYVc9qTAS4lwIqutjYvkOudK/xM8ub5DDI892rQ0E
         hQD6x2xgbCiiwUTrBU4vk9WHY5UvzbyWn4p0cN3Gt4VxqV6zg2nk3qyY5EWROXfvyhv0
         E3C604/vyZPVWxoAsKb9aFk8FJwd8mqGAOIsxS/2DsAtO0hKxXlVmzZdUdygb9SvVbz/
         AhGQRhTvM9Gc8h0iM2Fue3g2l3+Wz+j7+wGAP3PlWbFpT/s1LjrKzEOkLn9cKQLAG3Q5
         7rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778125267; x=1778730067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nleLAQUlrvdfXv9QhDg66/S/1PB+xB3gu8412xW8j5s=;
        b=SrMxA1InEEAE21cqg/qHMivyp6SxOwXq/ZmpevDHmcqWHpU/NOCF8OYE591bZlDm9M
         Lqsnzj+OQzBRyU/JnK/Hmw97SDvkFqiQe0IjyWO7y0spuELVWSbysj/awhYnmnIy+up2
         EEWxNLowBIqKR+ByAIYDL75mQSs8sJuB7FzCclhTj9y9G5ZCGRnyvy706QuL65wv+xUR
         7AoUjQgrd8xBwI6J08f3ZIbyzw96F28rZJCkAnJz1d3B7GYM/EeV5/4+UE+uKAjqCy01
         ZIBYE7xBCf1I7asA9Wc+8SZjtCkDD9kbkCqEQ+pb74ixpVs9ymcrrUQDbY4CcGHho95D
         +9cg==
X-Forwarded-Encrypted: i=1; AFNElJ+JPcDRFS16BEeJdwPYdFD+465pXT4ozklyDAFdgLsUHCVDFKNJHaAWNfeq/36/uK1XHZOLg0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV55qvfCUCv42aLhxSxdeL3PeEGp3bv0aO4oVXYJ4j8EH+cRCm
	XnuUGBbB4vrQqi6r5MyOtz6CXf4nPP4XStnNWl2V685LEeNfmOkZNFqH
X-Gm-Gg: AeBDiesNZvragEUJJ5vdCOk0h3RwZrgx68i0UWIo4cGacH96lSICEuqhOCTXiwmqtPs
	75942iAnoE1T93+j4J4/+AZnBeJWfSI9r9N4VrYCLwSfZc8WSDimDCdw3Lehc0MEX1ODFNXIV3t
	+OYFglJ6n4XldqpM0R5aFX5CqrPYwe34eKZGrqFze8QteDwRu76ih6v8LxBkZUSaJL26QFbZRG0
	5uOn864NRBMvUEeqMcDBjCP960uqa9/xvDr5l+W5tG43X8E5WZ0w7rbufRuBq0MKQybJOxQLNn4
	3Dk5ONmxZeNIkmITIDdNvfj/Z9B2+ybVy/PtIlHu0WEr/eu1/WxMUHTxEfrmdCGLgpgV73OnrSd
	xZRy60ZqtXA1ROldxtvfNkQBfYcXxTE1lA171Ndt021i5HdnHqBg5jpWz4iDWH14MMX1k56eivU
	//MZovfivXVT5lfo7K5PMREafyYylKnH9lGgduiJyzxf+D3hG0X5FcgRYWqdGRGKQOx4wVyilHl
	vh/eQT4tPlA
X-Received: by 2002:a05:7022:61a:b0:12d:de3f:d847 with SMTP id a92af1059eb24-1319cf558acmr3091983c88.42.1778125266546;
        Wed, 06 May 2026 20:41:06 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f570384e46sm6882677eec.26.2026.05.06.20.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 20:41:06 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 07 May 2026 00:40:52 -0300
Subject: [PATCH 2/2] ALSA: usb-audio: Bound MIDI 2.0 endpoint descriptor
 scans
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260507-usb-midi-endpoint-scan-bounds-v1-2-329d7348160e@gmail.com>
References: <20260507-usb-midi-endpoint-scan-bounds-v1-0-329d7348160e@gmail.com>
In-Reply-To: <20260507-usb-midi-endpoint-scan-bounds-v1-0-329d7348160e@gmail.com>
To: Takashi Iwai <tiwai@suse.com>, Andreas Steinmetz <ast@domdv.de>, 
 Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1495;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=5ZxZyVybouA1Mduqbo3hKVa/J06PZ5yuIW+r71ae+mc=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJl/OE9d/lZ7Veedv5TJ87eHvH3Tz4mtsXwY3DxPYZ1t0
 MkgpcPtHaUsDGJcDLJiiiyrkxZZ7ul6cLU+boUHzBxWJpAhDFycAjAR22CG/+7Kj/U3ygWn/ZAJ
 CX+5+8S12x8sVnKpyqh4yd+YtWfexA0M/xQ41nlzGR9nTzx+5uTzNSmii1p2tjfIGUxf/XBb/I/
 vPlwA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: D91694E2B38
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-244489-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassiogabrielcontato@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The USB MIDI 2.0 endpoint parser has the same descriptor walking
pattern as the legacy MIDI parser. It validates bLength against
bNumGrpTrmBlock before reading baAssoGrpTrmBlkID[], but not against the
remaining bytes in the endpoint-extra scan.

A malformed device can therefore make later baAssoGrpTrmBlkID[] reads
consume bytes past the walked descriptor.

Reject zero-length and overlong descriptors while walking endpoint
extras.

Fixes: ff49d1df79ae ("ALSA: usb-audio: USB MIDI 2.0 UMP support")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/midi2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/usb/midi2.c b/sound/usb/midi2.c
index 2785600d2312..04aeb9052f13 100644
--- a/sound/usb/midi2.c
+++ b/sound/usb/midi2.c
@@ -496,15 +496,17 @@ static void *find_usb_ms_endpoint_descriptor(struct usb_host_endpoint *hostep,
 	while (extralen > 3) {
 		struct usb_ms_endpoint_descriptor *ms_ep =
 			(struct usb_ms_endpoint_descriptor *)extra;
+		int length = ms_ep->bLength;
 
-		if (ms_ep->bLength > 3 &&
+		if (!length || length > extralen)
+			break;
+
+		if (length > 3 &&
 		    ms_ep->bDescriptorType == USB_DT_CS_ENDPOINT &&
 		    ms_ep->bDescriptorSubtype == subtype)
 			return ms_ep;
-		if (!extra[0])
-			break;
-		extralen -= extra[0];
-		extra += extra[0];
+		extralen -= length;
+		extra += length;
 	}
 	return NULL;
 }

-- 
2.54.0


