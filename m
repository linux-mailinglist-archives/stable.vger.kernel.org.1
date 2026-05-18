Return-Path: <stable+bounces-249244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DzlEU/fCmqR8wQAu9opvQ
	(envelope-from <stable+bounces-249244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:43:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00761569F4A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 977DC3029893
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2852A3E7BA6;
	Mon, 18 May 2026 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHtVjKr1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06B03E7176
	for <stable@vger.kernel.org>; Mon, 18 May 2026 09:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097376; cv=none; b=JfBKHCiL4BoqA3tusfWMQJKpfE5YkRojrueK4RZT5xxFiScQukXX3GcvXGKIxKM/7N1wA8WbmQEainZiqzHG36S5F0vQZshnC6ddXLVdAL+xY1GcoU1xcfZ97vLI47kU9g7B9cz0yVBa/9Ns9pRD1TnUojbJduxuaPCv4hGVvWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097376; c=relaxed/simple;
	bh=oJj8hUTaYVHpAd+ywEzMzj7LcqrMBR3b27Pw+5sLAdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCITKXIbOYAHV2smkB6HueHslFT7sBtWakleXuvArhKjQErsce6h0M29efpUxLF31hIJeC7OQMolqiY7rm0qNBdxlPqInCLqF5lXGgCJEoQjtw7NN9xW1tBVG6ACp7NbR56iab/HVo5z6xknpZhK5CZ3bczvixDuIUrlUkDbXS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHtVjKr1; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so3581185e9.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 02:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779097373; x=1779702173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgADJOxU9OGwFQpUQDyXunQW5uJtIZQoGTi296Hj+c4=;
        b=NHtVjKr117f8Olu674L3Ak8y4wcAd5X/VidUCPa4t2HVg32XIoErf7ubej10xht+4I
         7EEIO5n6umbkO9xnv6w/egVc+8S0VayGVKMLF3UqZsYk+rOE69/M743Iecivqz41G5cW
         SYX9zP8onv076+d0kZp1aM70qJ7BPJmuhHaA5Dig6uoWsfELtK690dh+XUU8ttI83038
         JWOTSsDUZy4yVLPCn0mDwxK9tkKpLMxqhAlpejLW2Y8q9tn3sQyTQHVU17pwSY1QOjUP
         jdm5KIfQ/52Z2kfo/BsfojVD2zp0r8H/1TFg9727KR0uZrqqRWDCnIL8/laMkbpMMlS9
         Hfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097373; x=1779702173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgADJOxU9OGwFQpUQDyXunQW5uJtIZQoGTi296Hj+c4=;
        b=rcTNAzBtktraNij2BOPvE5QU84DDe2A9M3W+5hnzxncXt4Kbi7CRT7VRO+ymT/A7H4
         FP873PfC97xpahHwvItoSH4vAQ0bJs5HpbeGC/ENwq7X3QEYqY1eDE5UwtCWbc01EfSq
         OkHYCKXCpMYxagnk4u2jlX5Dt1RQQ59SxjzplKt2IGFV0UuBclRixFE/QOWSQ/i4UVdw
         eNduVnkgzrAU3KqFMy/p6vE9VVGQXVycCQiqcQ5C/gwZd4gh0Jv1g4ZrCsA6aZTEJ2k0
         cgf3khO2Wuqxp+BDOMaDBp9On/RVS1hl4gujweaX1Uj0EEX8EDEawjaqE58XRjm7E96w
         UHpg==
X-Forwarded-Encrypted: i=1; AFNElJ9sW91iQs9svMGSPQXsyLBkgonIP2ljQAop99Tz3S5aHDa6yLtNDhn27pgN9WLIlEVBzrQJTQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxGbrhbNwaQgD9UFVhX7c+tzKIy36V63OWroTUklcOYUVevZ0t
	R/RYydx4Bdzrqby+nB25VOmgx2apyFFSEomrbhVpxRrnu4s00bR4qYS/
X-Gm-Gg: Acq92OFLrUGQLk6vTzoJqP6aNEcTwUvtu1A4vEfaxgM4O6scrJkPhsFFKdVzAS8Z3oT
	Pj8Z4lD58U1EdeD4sxu2i0197JvCtstUmcxoCIJsyChhvXgtkYRj6zBvwmJXVSmwd7mAQATR2e3
	c62fET9VYjup0ecLT1DTUJ2+PNMA5i52te2S2RIdE2ZyfnCqkde7oJhKXB8j+521JlM5jeUCJVW
	fH2GVf7M4TYUCmhkGCmT6oSP/Oyo+5HqEkUOHLChIwHbmgls6KC8cRReNVI++up9AX2YAJe74mB
	AwMFtYgC/RHvHlxQx0S8ZYlYI40XvSZ+sQegBlnBKH4kyUGoiGxI/Nx/Kaco1eSV+zo/S3hiuSQ
	kmfG89pTkMDrnsi5rI8+ctiWZaQ8Xi7XYBhv1TkZe0+OvpBk5PjoZlYOfWtK3Udt9+LVLwieW3j
	z2YLvuqgOvdgu+MEDI/7aoeAcSTDicVK8v8xBbPtestwNI
X-Received: by 2002:a05:600c:4588:b0:489:1c1f:35e5 with SMTP id 5b1f17b1804b1-48fe664be2amr98337705e9.6.1779097372785;
        Mon, 18 May 2026 02:42:52 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm37460225f8f.32.2026.05.18.02.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:42:52 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: mazziesaccount@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: pressure: rohm-bm1390: notify trigger on all error paths
Date: Mon, 18 May 2026 14:42:38 +0500
Message-Id: <20260518094238.1986-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260517160801.269-1-sozdayvek@gmail.com>
References: <20260517160801.269-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00761569F4A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249244-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,baylibre.com,analog.com,kernel.org,vger.kernel.org];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

bm1390_trigger_handler() returns from three error paths without
calling iio_trigger_notify_done(). The success path at the end
does, so on a single transient regmap or read failure the trigger
use_count is never decremented, and the !atomic_read(&trig->use_count)
guard in iio_trigger_poll_chained() drops every subsequent dispatch.
The buffered-data flow stays wedged until the trigger is detached.

Funnel all returns through a single done label that calls
iio_trigger_notify_done() and reports the outcome via IRQ_RETVAL().

Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Use a bool and IRQ_RETVAL() instead of irqreturn_t (Andy)

v1: https://lore.kernel.org/all/20260517160801.269-1-sozdayvek@gmail.com/

 drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 08146ca0f..81368e578 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *idev = pf->indio_dev;
 	struct bm1390_data *data = iio_priv(idev);
+	bool handled = true;
 	int ret, status;
 
 	/* DRDY is acked by reading status reg */
 	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
-	if (ret || !status)
-		return IRQ_NONE;
+	if (ret || !status) {
+		handled = false;
+		goto done;
+	}
 
 	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
 
@@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 		ret = bm1390_pressure_read(data, &data->buf.pressure);
 		if (ret) {
 			dev_warn(data->dev, "sample read failed %d\n", ret);
-			return IRQ_NONE;
+			handled = false;
+			goto done;
 		}
 	}
 
@@ -648,15 +652,16 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 				       &data->buf.temp, sizeof(data->buf.temp));
 		if (ret) {
 			dev_warn(data->dev, "temp read failed %d\n", ret);
-			return IRQ_HANDLED;
+			goto done;
 		}
 	}
 
 	iio_push_to_buffers_with_ts(idev, &data->buf, sizeof(data->buf),
 				    data->timestamp);
+done:
 	iio_trigger_notify_done(idev->trig);
 
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(handled);
 }
 
 /* Get timestamps and wake the thread if we need to read data */
-- 
2.43.0


