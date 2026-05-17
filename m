Return-Path: <stable+bounces-249115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kN59DvbnCWqduwQAu9opvQ
	(envelope-from <stable+bounces-249115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:08:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98356235B
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21ADC300B856
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 16:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BB13BADB2;
	Sun, 17 May 2026 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smgWc+P2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B2A3A6B8D
	for <stable@vger.kernel.org>; Sun, 17 May 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779034098; cv=none; b=sWBdi7Lxg1d6bcYCJ0Rgm5AKrYa6fM5HJQu07PViZeICTDellhQG+iv6wombHvGn9RF2qTvpzg9158/+yTbQYvfKR6JUTCrgZWM6GvRG1pridsRgj7sAC7z0ct1ZiZNuG4QJZQcjLV+xqAnGxkm2PcfeZQ3YBZwRaOSToZbV8zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779034098; c=relaxed/simple;
	bh=hQ/rVVhIPkk7pPHac/pDnIhXRjBlYPw7rVFREviEY6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PBAVBWQYebOTYBiIsAGfOd/ogZ/GsWfOfHv3pmxxJW1Qne0rbjHP8CzngbVf0l1IuRONKf7w/tbGF6bWzzs0mtM8esUouLZmX6zpNx5JvGSVgK71+UcpC7Jb1Vd1n0DbneZeKjxgk78SrKphXZEErjIYmCZGrCYvaAKU/X5XCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smgWc+P2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so2424115e9.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 09:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779034095; x=1779638895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MmA31C4zCBuHUyR5/JDkmFyRbtrkEf1aMpi+puaLur8=;
        b=smgWc+P2ttkEBAsankScA8k+PHZxnAl82fMmb7Sfw3ym/ofEDp/BNlZ99cAO1nkgHK
         TNofGlESuR6+T3xz6aalee6mYA/h4fnDQDD2QkUMPeRfFl7mR9e9EYLdqYGsS33kWd5k
         vlPxBblI5jeIkLjlxIsBtWDJ8/9EzlVqHghOSm8apBbq++aQlIuaMPLC0wAxQBXBXBta
         IXCZdk13ImXokuNBPr04a70g1DhBWDAaIIP+KXZPMhNvlf71+OpTRyskpJ/qBFnAMtUS
         Pe8r7/rZ4HRY/i5ut+FCovz/aImCDlLIiU94MMdibHj3V48WZY7CCL8ZqPICTtga2p9p
         fIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779034095; x=1779638895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MmA31C4zCBuHUyR5/JDkmFyRbtrkEf1aMpi+puaLur8=;
        b=NKUQ86q9vNFoDI53AF1QsgdJd+h5SG0Stzc54jbLU25A3WWcXUWwjdKa5bLYZ70IP/
         0bnqeGjrn2FhOsUi4xi1W9HzF5nYyEoqfZFEFYWgJVTkzU7r/oHF8MyRuDkUnRn6e7JH
         gYHIqNg5pJoQ3MHXr398Syv1NGYm09bh98tDKgFv5c9xn8fDjbjqUQkJr0DxRFHFThE5
         oKDBwkza/RgsNI/aWOP2vdwXyTQiRrsbLXA35ILEZzlf9YxdzGtAbWJqocWorC6jk58H
         SGoLrtWxIssPxPHBoAATT/oAzEwdt+ToQQNjCD521dQwhDeAChU1+5u3pfKPtQiLJUgu
         vSXA==
X-Forwarded-Encrypted: i=1; AFNElJ+laLDTKfpGsGb/ArcWp6aRr9IT8k0UyLR0z2qil54IApyuzHwAAWusIskcydAGYifDJRA/KRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwetRwe5Vj7309ErzbUqdsVzrqa03SajO+7ZswWMNJ90aYBGJ0e
	BGkLRZJQDHxUfXHZyX/jmFS0B+5e5EzMVnjvU70jeaX6Z2kL0GeAapbT
X-Gm-Gg: Acq92OHykuGkxmjxp8GQChhOsd1Kb10/EsOkZa/zKRee7x6AJQpwLzHYCVX5wm/pxNL
	3HWdp6oQXUER1Yl5LrvuyN2pBi75ORXbhMpmOxQVYxiSQe3oC4LdMcwMrX15WnCZYeDQ4b8gBOA
	qlbZhBI29ZQrLKFaXbdZDeQ6uP8u7En6OyfgWNVHzQZ4Tur/PCS97MdV7ZeeN1d/SoaW3T4MGda
	9GD3qjXsMX2t+T99AnO8i6krIa234d6PlyxxyQmC03yyUjCkqBa6W3SR808m2xSM8VNeBib0aLs
	VVRyeaFJNyjs/7AvdPsp/zFotH3N5uz75ZyCTidWbQXcNAEod5Zjz9oPztq5rQ5s80r7tQw6YJV
	42CrSe+Yiz1//zdaexse5Zx0B8pxLjAQIgF/MWf/ZO6DGSSkO80DLG1z6sxwHxwmmwBIsvVRLo+
	ngqXLnf8UgUlaZMytZ3KXGZOx99QuUv5X1GONMEuJJk9Ti
X-Received: by 2002:a05:600c:4704:b0:489:1ca4:c999 with SMTP id 5b1f17b1804b1-48fe66550aamr78753665e9.8.1779034095426;
        Sun, 17 May 2026 09:08:15 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febf81970sm83892645e9.8.2026.05.17.09.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 09:08:14 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: mazziesaccount@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error paths
Date: Sun, 17 May 2026 21:08:01 +0500
Message-Id: <20260517160801.269-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA98356235B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249115-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

bm1390_trigger_handler() has three error returns:

	if (ret || !status)
		return IRQ_NONE;          /* status read failed */
	...
	if (ret) {
		dev_warn(...);
		return IRQ_NONE;          /* pressure read failed */
	}
	...
	if (ret) {
		dev_warn(...);
		return IRQ_HANDLED;       /* temp read failed */
	}

None of them call iio_trigger_notify_done(). The success path at the
end does, so on a single transient regmap or pressure-read error the
trigger never sees its use_count decremented, and the
!atomic_read(&trig->use_count) guard in iio_trigger_poll_chained()
drops every subsequent dispatch for that trigger. The buffered-data
flow stays wedged until the trigger is detached.

The IRQ_HANDLED return on the temperature path additionally leaves
the temp branch's last partial state in &data->buf.temp without
pushing the sample, which is the existing intended behaviour; only
the missing notify_done() needs fixing.

Funnel all returns through a single 'done' label that calls
iio_trigger_notify_done() before returning the saved irqreturn_t.

Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/pressure/rohm-bm1390.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 08146ca0f..c18352399 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -626,12 +626,15 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *idev = pf->indio_dev;
 	struct bm1390_data *data = iio_priv(idev);
+	irqreturn_t result = IRQ_HANDLED;
 	int ret, status;
 
 	/* DRDY is acked by reading status reg */
 	ret = regmap_read(data->regmap, BM1390_REG_STATUS, &status);
-	if (ret || !status)
-		return IRQ_NONE;
+	if (ret || !status) {
+		result = IRQ_NONE;
+		goto done;
+	}
 
 	dev_dbg(data->dev, "DRDY trig status 0x%x\n", status);
 
@@ -639,7 +642,8 @@ static irqreturn_t bm1390_trigger_handler(int irq, void *p)
 		ret = bm1390_pressure_read(data, &data->buf.pressure);
 		if (ret) {
 			dev_warn(data->dev, "sample read failed %d\n", ret);
-			return IRQ_NONE;
+			result = IRQ_NONE;
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
+	return result;
 }
 
 /* Get timestamps and wake the thread if we need to read data */
-- 
2.43.0


