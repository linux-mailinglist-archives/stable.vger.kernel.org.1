Return-Path: <stable+bounces-244488-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VWJlJgIK/GkAKQAAu9opvQ
	(envelope-from <stable+bounces-244488-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:41:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0911E4E2B23
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D0843018291
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 03:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F732EAD0D;
	Thu,  7 May 2026 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jetE1igu"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B422E9EC7
	for <stable@vger.kernel.org>; Thu,  7 May 2026 03:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778125267; cv=none; b=ImtTqbucQt3Z08Lbdhukz0PTJQYNe+VBdyqLVH9hBqLo3m8QQY/p6LxcDYLQ2doOvYafnb1QDmRUaK/hQvQC7HPQSSar5NPrfh4crhSxn07GkVYYN4zwI1tB6SUsXZQe905VNeZk5lLArZb8SKTJ/Or1UU2MoTQZ6bS3kJGyB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778125267; c=relaxed/simple;
	bh=R13vLbMiQobZCeft4wigQy1eZvd+q8ciWDUl2RXDnSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DISpyXI9xjgkRxeI6Igz03TA8Nbde2xhDFOnfJR22NbuVb3CdWwiAc4BpdRUItbAPEYVAOdFl21Rw0CRTu094WEBtWfnGlB8q/bvuh74RAxvTrksrLqHn/hgr5ZxTVClhJOvSjeWRom5JiKMtvjgEgS89aVdwYuHATU9xvv0Jq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jetE1igu; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba895adfeaso423586eec.0
        for <stable@vger.kernel.org>; Wed, 06 May 2026 20:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778125264; x=1778730064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kzYvobmwTuDLJkkrhcaqeyyYJZesImpA5sRmM1ajfQ=;
        b=jetE1igu4yRztwEosAB0RUUM9CUct286nfoXid8c0JXdLvfmxzY+wzRpa4+gn1vOkV
         WSKLPcX3oDMwSoBVOdc0vl8/59kMvsQijFkfJ0v759cSWgPn8jR4dbiNckj/bki7u1k5
         siuq3dvUmjQ6Iw4Chk1istYkrvjVsfLGgYYqgcDe4lzSUW5Lkge6sSQDRIWIMjsKlUNL
         v0LXpuCEKKdPM6lpWHTEDBOMBKk2Flud2ByJz6F5SIi+crnGmsRjATw15uxrgpr19/Nq
         /A+fvyvJfnffacpG/lDYUna2E8Zrqg2UT6zZVmULSm8+NHF0nJh0m9OFTmKelqfyWm3X
         eWEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778125264; x=1778730064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6kzYvobmwTuDLJkkrhcaqeyyYJZesImpA5sRmM1ajfQ=;
        b=nVbaOL9DpXx6tlDpe05lzXkTCDG3bo9qAvMSjPbKOo63W0aIu8khFSbsD8tEdMiymD
         QW2w9X7bCJWS/Ki25m6FdjCiQj+u0JV9LqhhpOt3/VHh1yOEk74f8d0rNiRc+flEoSWd
         CNTHVsTJlLuze2HlbGKn+gEf+cDPqn4UMGxr0FX8apieusyP1jJ2cX9hu6XH24PEL6AB
         Tcinvm7qBkg132hPITe2QzAlWeHR+OUXhd9g2htsOlW7PunjKtc3nouygLgAYYrI/rf1
         +9XOtZz5w4PFv8pTMX7sWuNjlnv0uxAQAPmWWdkeQVkhW6zxrBcTXsz/kRgFzYjDm9WP
         sEHA==
X-Forwarded-Encrypted: i=1; AFNElJ9BwYBjVqeyiAYxWpUr+OLZUrkTqgCRjHsJTkAR3XBk1S3B+GaMNDNLQ8r7neDMF79g8zWLuJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTK3XTTbH37w83I/vU1Lr0GGezqLUWofJM35svOc26PQyRtI9k
	IhCHrE/uQ9YO7QuhRQPTAfnXMwUaMTyG6K+EYLnZlQPnbMOpZYPUSH0x
X-Gm-Gg: AeBDievNVZIlKZN94V1uUjAxb6sFPdTc2QI30cK/gZdrQcVjgrehcoLaPwJtGY+y1ym
	Yog6G/B19YtIYhOkm+Rp0F13mUFpX6yF83U61w3BVeEcvx6RHKP80r773J55ycDD8mf6iOUrYEU
	HvNSQ1EIKeb4JGrhJBin0pPjfUdS578FzOf7Chiy69vMefUsgpHIjmXiCNmCZssECR2O0o9d0d1
	pc8K6FPI6vlWcUPMEUhY1N3/kAi2M4hrqjePrDRQ4iTQs/k98hJLhZz+MY79LTI5kjs/OWm6yLq
	mT7FryKgRHZv5lEW7dUUkEMbczjv2pK1bAerHxGDidXAnvQjnLPJJiXLYtKJtf7Tn1LEzyVBVnB
	q+j2GiFSFHAwqA3QZA0EHKonVISNS9hlnXgsujKkhJPSjhwimRWD1eCdggVcYo/8A6RrFX75wNX
	j9iVaykGF2mBPwY4VUrKqaMazmPN+aqCx80RyCkk3kVDl+X5Qxo8frjzZgmMrZqF+7e3SioCp9F
	ga2ae4MDAZT
X-Received: by 2002:a05:7300:2387:b0:2c1:558c:16e1 with SMTP id 5a478bee46e88-2f54b897efemr3072912eec.4.1778125263705;
        Wed, 06 May 2026 20:41:03 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-87.user3p.v-tal.net.br. [177.4.161.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f570384e46sm6882677eec.26.2026.05.06.20.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 20:41:03 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Thu, 07 May 2026 00:40:51 -0300
Subject: [PATCH 1/2] ALSA: usb-audio: Bound MIDI endpoint descriptor scans
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260507-usb-midi-endpoint-scan-bounds-v1-1-329d7348160e@gmail.com>
References: <20260507-usb-midi-endpoint-scan-bounds-v1-0-329d7348160e@gmail.com>
In-Reply-To: <20260507-usb-midi-endpoint-scan-bounds-v1-0-329d7348160e@gmail.com>
To: Takashi Iwai <tiwai@suse.com>, Andreas Steinmetz <ast@domdv.de>, 
 Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=R13vLbMiQobZCeft4wigQy1eZvd+q8ciWDUl2RXDnSA=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDJl/OE9qTbT50svyzOzVDX8/K6npH0/P27nuqP6qRUl1G
 zb79+eXdpSyMIhxMciKKbKsTlpkuafrwdX6uBUeMHNYmUCGMHBxCsBENnEz/DNRrj+19xDbxWuV
 bPeSph/obn1z1qivzHyBpMavjzf5Sr8xMrwMKrnks/Tb6/jl4aZvbc2EGISq24tbDs4r09HPLHN
 J4gQA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83
X-Rspamd-Queue-Id: 0911E4E2B23
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
	TAGGED_FROM(0.00)[bounces-244488-lists,stable=lfdr.de];
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

snd_usbmidi_get_ms_info() validates the internal MIDIStreaming endpoint
descriptor size before using baAssocJackID[], but the descriptor walker can
still return a class-specific endpoint descriptor whose bLength exceeds the
remaining bytes in the endpoint-extra scan.

That leaves later flexible-array reads bounded by bLength, but not by the
remaining bytes in the endpoint-extra scan.

Stop walking when bLength is zero or
extends past the remaining endpoint-extra scan.

Fixes: 5c6cd7021a05 ("ALSA: usb-audio: Fix case when USB MIDI interface has more than one extra endpoint descriptor")
Cc: stable@vger.kernel.org
Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/usb/midi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index 0a5b8941ebda..d87e3f357cf7 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1951,15 +1951,17 @@ static struct usb_ms_endpoint_descriptor *find_usb_ms_endpoint_descriptor(
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
 		    ms_ep->bDescriptorSubtype == UAC_MS_GENERAL)
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


