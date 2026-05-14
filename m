Return-Path: <stable+bounces-247077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAI/KBMfBWopSwIAu9opvQ
	(envelope-from <stable+bounces-247077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:02:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9D953C844
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7BBF303CE0E
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40122FD69A;
	Thu, 14 May 2026 01:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nE8kAGLE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A02D23A6
	for <stable@vger.kernel.org>; Thu, 14 May 2026 01:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720491; cv=none; b=XDQmgg3G2i0aNgPH0OA+NEGJJa+s+nHZs6v1i/AtLEGMI+hx4Hrt1TsGT3uh/3qLOp9UG/m7b++QqEaBcTgXKgfCOT54+VQwKqFD+oXrJz98vMaDwgeVLN3/fWKbojS2haGWKetaSbcQgauxlB6ZWnv1U5SbPm94cl/yRIMvSws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720491; c=relaxed/simple;
	bh=DpZqDpgWFdqDiUupU3hy+hp66wdYNBtQrPd1t+nKiRM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rz3yGY7yqPI99kdbQgpyVE3rQz2YbQulD+JoAPkJlJObFtBabG8y+Ql4KGrhWtG8QA5BBlfE3vszIL19bFVd/GQesXwvIaStgDGvw9WGceIJKJyXBTLrU7zJn0CQhuOJoJaLTVl1WzvOykVJPEyNh9ub67ykp5srXOTgRaXyGoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nE8kAGLE; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so3118867a12.0
        for <stable@vger.kernel.org>; Wed, 13 May 2026 18:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778720490; x=1779325290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P/TJCCyg3GNNF+cgc4ppW8pNVQF/2kpZ5OGVnmEUE2Y=;
        b=nE8kAGLEOnpAiwsOx7rhu/Ae7K6KKRSzvz0GHMEVYNMyFMjOFhy6pyJckphG4RAK6z
         WIqDffZ6sUAS/UAcvoo58JZ5qWT6gsFuQ8JxBzfUqt4oWtmWSheOkZPU+tZne3CQOuBt
         eb5bCZA8VCywwpV3VfuHmdnCZ7LCgrAn6HanNt80uFLRAPVVhMud6uCKiH4ddQOuBeb4
         1uwLq3M5Y3HjJuG1jv85f5AtvyN/lbhcHuiTjgrCK8Nvp1Mzs5680Ds4Lm40TDQ4zWRo
         3NCpDzn5FCSBWKx2vsJdUiVYi3knc0HJEB9Wm+j3OOxvA7Bno3R8NGiCrEihniwUfVTr
         7sZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778720490; x=1779325290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P/TJCCyg3GNNF+cgc4ppW8pNVQF/2kpZ5OGVnmEUE2Y=;
        b=PiIg4YgeROfUqCAdVk320or1S7T4bCaKNkRL2nfBBpJgfw5wJNBGNhmWd4D3Bqsuhg
         fHMmj8Fi2wMRXbnDpsUOH82xbJ8hQjs3FwS+vWul06mk8//pWYIXErHxcnZn1XGdBQuC
         Ge+Ga4DqBRkczLuq0fYlWBMehDfQvyNbAxCgugKa7awB70ym3OnbJwJ2kb9TVm8gJ6jZ
         KpGmxkcvV7DJ/NjWrvtUVQD1juq4KkJPqhXtCeme3aPQVIClUkfGXjrLVqamy+9ERLD1
         GVqDgCUp1n6/diFNyxQgjtSpfKIE9DkhrmYIoniHUUZ9C6PSPNrCHXkITTqjqxqPQesz
         RLeg==
X-Forwarded-Encrypted: i=1; AFNElJ+Xhq+PcNaalqv0pF7J/3YKnQl/bcrtv4SPmxATPEhSoSycS12bcYoe+li0RZlVqHv25TFldaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wvubQxWm1mHLR6dgcH/LmWJz7naAR9xHFP4wEAb4c93Zh4Fw
	djPRmfhmdvvKAuU69PwebRqqVVWYKHY8AubrHlXwiRpCYirgiYl+W8P5
X-Gm-Gg: Acq92OHRLPDx+e2CMKip8NUb10CvyAjQvAZ+LviU+TfVnkMPGvd+DjHQL4tUNekAr2q
	cox287UHeFS1dzcs2yTRrvIoyvXt1rItqNn3f3ZtZEtUmInwLweUiM/Q11w1JfqTLX9x3o2FBoZ
	sTgL4BNKA99OKc0N5UycFBSA7rrjPAPVqjt52JJZteAmkOJDsAuCwLLBPWAp7cYsBtptbJz6ByE
	3l1UK+KYYFiCYm6wVKxkyjPPJmcc8OwqdcFdtBd3nqWYtMhZaAQvUXqDn7ieR0/OK7c0Zz4C9KL
	Yw+nlODJTrijwoYgP+d/XeeC8y8NbaC6PwohTA8e9IsOk4NUWmAlYGSuC0KuXRG5VsL3baIcV9e
	TipxgyRARUHoey6YhfQmeIePDfPmEEPFfkKCBL1osm9Q0cAp5JoetWiSD8hR/34rEh91WM6gxYL
	DpqbWwNT0fQ/ZaCcZIBmazQKVJpVCh7zfjn45+
X-Received: by 2002:a17:903:bc2:b0:2b0:c45a:bc2 with SMTP id d9443c01a7336-2bd27139901mr47310305ad.16.1778720489578;
        Wed, 13 May 2026 18:01:29 -0700 (PDT)
Received: from [127.0.1.1] ([203.99.159.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fbc05sm4645895ad.57.2026.05.13.18.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 18:01:29 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 14 May 2026 14:01:11 +1300
Subject: [PATCH v2 1/2] iio: light: veml6030: fix channel type when pushing
 events
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-veml6030-fixes-v2-1-abdd5837be50@gmail.com>
References: <20260514-veml6030-fixes-v2-0-abdd5837be50@gmail.com>
In-Reply-To: <20260514-veml6030-fixes-v2-0-abdd5837be50@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778720474; l=1127;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=DpZqDpgWFdqDiUupU3hy+hp66wdYNBtQrPd1t+nKiRM=;
 b=OrFqgirHI7m+cM4ZxxgUcUAQM1us2yF8oTs0fAFVY6/ocWNtSozbqMaHSve1Ak/YMHkAT7vNQ
 zldFm4QZ10pC8uirk0rCYe9S9qWdG1/XtG2wmY8jMPFlLrvsbw27Pxb
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=
X-Rspamd-Queue-Id: 4E9D953C844
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-247077-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,analog.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javiercarrascocruz@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The events are registered for IIO_LIGHT and not for IIO_INTENSITY.
Use the correct channel type.

When at it, fix minor checkpatch code style warning (alignment).

Cc: stable@vger.kernel.org
Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 6bcacae3863c..da8c32cabfd6 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -875,9 +875,11 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
 	else
 		evtdir = IIO_EV_DIR_FALLING;
 
-	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
-					0, IIO_EV_TYPE_THRESH, evtdir),
-					iio_get_time_ns(indio_dev));
+	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_LIGHT,
+						       0,
+						       IIO_EV_TYPE_THRESH,
+						       evtdir),
+		       iio_get_time_ns(indio_dev));
 
 	return IRQ_HANDLED;
 }

-- 
2.43.0


