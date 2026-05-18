Return-Path: <stable+bounces-249245-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GU9ATDhCmrU8wQAu9opvQ
	(envelope-from <stable+bounces-249245-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:51:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA5356A160
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 11:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2460B3050A60
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7260D3E716D;
	Mon, 18 May 2026 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzdeWvv3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138B3E3DB2
	for <stable@vger.kernel.org>; Mon, 18 May 2026 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097412; cv=none; b=uLk1K+4NvygGvBSTAMj4wc8SnjhAw0QqoCEBdm3In3yJqtVVPyEVwzzEZzXuwXkuQbPukOX+ottSrZ1FSvWPsPUrXCK5BN6GnAJ3VGccU6tdxKb7bx2IOcH6O1sff+UM18Abq+fsi9BMj3YiQrKEuAnlqjArBoUqmmeZ6m21olk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097412; c=relaxed/simple;
	bh=mCWaicM7yQ277dT759ekQHkrAGXRlx+Heqr7EifxGXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rWXNW8rm5EE4ReVy9xOnXJRreA74kxLpn/QnmvxaJ1CI9HtmwTB/s0PG+6NV7Tyx1+xjyRqkAaatIlM+vhTyAxgg7OL8jb0CG6+uhP11M4LWi7jjCglGwxSNOmwUSemKcxSq01jz/CYGBUZdXzL3ThX+AE+CwE8oAh6HMrN1azE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzdeWvv3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7670826bso80525f8f.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779097408; x=1779702208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vze5/vjAlQ577aFItS65iPZiAe9QKZObGH0nwUk9xXQ=;
        b=bzdeWvv3CD9hIEi8bffWs156OgqWDX/6LNGYoJCVurdSDgre26BVRpS9X2hjiGtmpl
         b3ZkMBtgqy3Nt97v4bq688xqQru7OGLTdRqR/4++uzjqzAumG0UquavmHtczvKH4yajH
         3Y1NWnLH90ajl/fGNXkc0hPMMFc16SJ42fhG1FWtSgDuCuxqV/u4fD/JJxjOmS6HFkmm
         NKeEJ9MyD221E14f+q79XSbY8jh1o11L8hEcOFkk+hlTe2KMC5Md3uT9QOD4pGSaSOlF
         Ynw34HrZuqnCx0ZuBYbxtzjFLDVQeKEXGcfsSMp89ZDbPMFv1QfeiCOPx4w917sFoeBi
         jKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097408; x=1779702208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vze5/vjAlQ577aFItS65iPZiAe9QKZObGH0nwUk9xXQ=;
        b=Qc4Il1ZQt2pFyOCz5YYOg0SXSLOyuQrMH9QYfSng4Ejc8an6D9GK6O8gk9cBniveNn
         qZXx83j8Mfl7S0Tf+vA1qGijZpwAKr0aeKMgM59i2alF8N7nvbAOIAb+U9U/JMIx0qo1
         f5whW7gFJkPP0hYhLUsHrwn2dh0vuwh6oTZupCjhzp7ackUvDeczB5p3L0ayp9hZya0w
         ExC609ZTxoyKFLFrO3RYOUhJVWWn0P3dD9PGdS8GBMwsVfCYYxLhM3jDYMZcZBfs5qLn
         r3UYeA+Gs4Ya0cDbIkdVINSx9qEsU25pLQSYYzopqxgKZZwRNwHUKQyXMzqxswpNz2v8
         BB5A==
X-Forwarded-Encrypted: i=1; AFNElJ+Dtzqcr/E7GHJn73YeW9Is1mGzOABebg3hsqzdZtVSyndn/49TSXe06zksGaycoXSrw5ET6qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+jO5nHj13qvxbWQO3f0b8fd4Jknkq3eVljQqxIZU9nl5ZAvG
	3AxX6ygmOKHawrA2d+Bfwm0iHKrkoGZubAqPkecUokgIKOr0d0YdTrDo
X-Gm-Gg: Acq92OHfIfyYWmBAolsYSw/7gLjB3TYLTRC3EGnutyx92MeHFqQ9AKgWD751zUYnnP2
	P8q2zZUdBMqAQgOpOIQm0wa7om0cgtUeN4izGtAEgH+jwKw5+8MYIT/hLJupS5rJiBSlqDibYy7
	MtXAOtGryYY4AeyLmwbjYDlpXD3w4KjXbuFnEWKIgrN1Imi1rqlPE1d75F3mNOsBwbR0MfsjKLw
	f5Btm/Q+CMJl89mOoMNvYtKMnAzT2OY08MMfCQZ9kyYiOt2Foip8TliGm4llHkvtXYYCUBSw9wp
	zliklOZ1lUQwKsUMDjivKjILx+psG8neHwSPORJrkhMPIaSC5wUCPVb3kG/zKbcC6gh6u86aiFN
	OOdkenoYSSLPKFOvebGmgv12cz/BcpIvYeGuLciKlX07Q/g3DVSXYO/+fiB7ewc23BKM4WUhNhq
	4V8mjwZEvUCaTyNcvInGDx1mbD/HnxiagKgbSiJC/aNUza
X-Received: by 2002:a05:600c:4513:b0:48a:5501:799a with SMTP id 5b1f17b1804b1-48fe664c27cmr106648685e9.5.1779097407982;
        Mon, 18 May 2026 02:43:27 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe7e442sm75446435e9.33.2026.05.18.02.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 02:43:27 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	joshua.crofts1@gmail.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] iio: light: tsl2591: return actual error from probe IRQ failure
Date: Mon, 18 May 2026 14:43:11 +0500
Message-Id: <20260518094311.2000-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260517181042.668-1-sozdayvek@gmail.com>
References: <20260517181042.668-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6FA5356A160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249245-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,yahoo.com,gmail.com,linuxfoundation.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When devm_request_threaded_irq() fails, probe logs the error and
then returns -EINVAL, dropping the real error code and breaking the
deferred-probe flow for -EPROBE_DEFER.

Return ret directly; the IRQ subsystem already prints on failure.

Fixes: 2335f0d7c790 ("iio: light: Added AMS tsl2591 driver implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Drop dev_err_probe(); just return ret (Andy)
- Add Cc: stable@ as suggested by Joshua

v1: https://lore.kernel.org/all/20260517181042.668-1-sozdayvek@gmail.com/

 drivers/iio/light/tsl2591.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index c5557867e..c5ccd833d 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -1137,10 +1137,8 @@ static int tsl2591_probe(struct i2c_client *client)
 						NULL, tsl2591_event_handler,
 						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 						"tsl2591_irq", indio_dev);
-		if (ret) {
-			dev_err_probe(&client->dev, ret, "IRQ request error\n");
-			return -EINVAL;
-		}
+		if (ret)
+			return ret;
 		indio_dev->info = &tsl2591_info;
 	} else {
 		indio_dev->info = &tsl2591_info_no_irq;
-- 
2.43.0


