Return-Path: <stable+bounces-249140-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB0iImQICmrqwAQAu9opvQ
	(envelope-from <stable+bounces-249140-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:26:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883AC56317F
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 20:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 742643002B4C
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF03CE4A5;
	Sun, 17 May 2026 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9qd9H9S"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE2C331A7E
	for <stable@vger.kernel.org>; Sun, 17 May 2026 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779042396; cv=none; b=CCAEpus6JtosMSgIXa90wf73evGNm8hUvHd59elP3mV/vUesl3DtzX/QerXOP78H4W3mUEomje/CCg+3/5WWP1F1vTDapqYPSYihvUPlh9ZlnSF/PYiFiZFI58h8ivcLIA5D3g+DJ/Z1YGjGVpjcafVEXJADxag6ZbwlmSitRLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779042396; c=relaxed/simple;
	bh=Kr+wRFKCa78PP/xIkl6wWb5vru7OSFdDl39shroWsq0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uv98bjJTKGeIkkZRWHj3nP5OXMg5ky/lAJ6WbrYGV19fH5HQFAdtRowhIWsooAhpU8RHsR7SrgivjxRa94h/a8W/qGo7gSWK/xnWHpGGYWvM3fCGaLQiVicCocUUsYpYUus6nnnW1bqjNuBLLNchOtq8jWH+m4AMs9FRM4FaScY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9qd9H9S; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ac04e13dso1874715e9.1
        for <stable@vger.kernel.org>; Sun, 17 May 2026 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779042388; x=1779647188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdItoqgHnYFyIUQVhKieBd/PQ9Fluw8ZpOdySHOHHGI=;
        b=b9qd9H9SX3BzXQr5ypnz3K8T9WC/BntkKBhCfHvGRbLUGuIC/3l/RQ3oINeMaPPGVQ
         Z8lGvfNgG1qag12KpOukck4H6XYyTg/5RhqkZd4+uTzCpJWlS0JJcWTY6BzepWcWOi+U
         cK+ATQkGCDNlmPqM3bn3IBIqhQZeMgyPFCepqfYo1z/TtNdJ/TwBN9pfu0txg4XVtcsR
         b06Z3zpSV6P21JhwoB/TulhIjLr9ZetoAnl9gaxJ3RxhutXYER4u1JxSFWSQF71PYK04
         9eOeNNd5io5RkHRYza62zbLnCh2wXX8bXPZBO/y2VkG6zfHVY6sgOLQYsNPTN95WIfty
         IIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779042388; x=1779647188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdItoqgHnYFyIUQVhKieBd/PQ9Fluw8ZpOdySHOHHGI=;
        b=gz1ChALf8GMme3adia1lDJIK5Ui3gwoqhjKNGu5eZLB2XM+gtIvO58lFiXmnaxVOwA
         2TCZZwUWUFVwgxNZyvbcN1v+dYiZOTk2yinqz0okCavdFh9hQw6vulpSxSVUv112ziUX
         UCC7dx/u4gTIcJQi2clZB1DphPIkN1Nf40dIDPDny2DaBK32bNLmDvqnFLqHPoApDqCC
         yvBuXz4LGu2hxCnj2CGMA9K+IoKYkuld/B9NadVNUjs47F5fIjNlDvvZOwxl9c/yy00v
         dYg2phoqBvJZPHI7OkULOMEznaaLzvELX6US3hFax/RvnO37WRfgEtdzjwLXCEZpjJ9Q
         1qFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ndTnLdixdBz9D2Evh3gfFuJ01Gp95c94sWJNWW06+/dtS7/M2MyV7Xi6WfV+haBg8ndq/fA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMFcNu3uvw/GOw1OQ8s3QRgUprGiIspESvhPmXoCiXfzYiRPsI
	t3njONJrXxQce0hwuIccfMG7MC0BRnJ1oEhl7ihRIvgMFGXaAkyNu+Bq
X-Gm-Gg: Acq92OESamkrJS1B6dU3aCqn4hm943Dt28YZ1PjrMWoVD3h6lNvTSjDnVmVFgcxsrPH
	Tn12N5rBqYMpi/QxVsdHM6qelaWXljqOcAtv+EEbpH0OPxtoAW2+v4zmlQA5a5GOBbsffqNCmfu
	3u8K+7cDCU1NrLSyavdxMGwqd/uQghP2ZYni3i+g5Fs4/kUOF4sEaXrgwzDyYr6gplPtkytyDsZ
	LdTBGKiWjwJ4cdIUEwOstFSplCzvUP5UUTzGc0A4OM+mzreCJciz1EZOXzZ5cHEqSRirGEg7tcS
	tyvm1efaUIvXcPya46e2epglI9MwqwEsLOJiTaXrIfZUG5bkbcoC7g71EWB9kV7k/5c70+dWGco
	C6omLhnGgJKAg7UXFWumHdjw2uC8fU74ZpBBLvfW9mSgKmJcGpIwlgmg1ifOCeSUonnSWOjFUqB
	bbfRC5KsVMHv8XnNLvfSHsz96A6OOxySJbrTWBJeAMEjs1
X-Received: by 2002:a05:600c:3b07:b0:48e:6db5:76e6 with SMTP id 5b1f17b1804b1-48fe63099c6mr97084715e9.2.1779042388030;
        Sun, 17 May 2026 11:26:28 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe81b2dsm64676625e9.34.2026.05.17.11.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:26:26 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hcazarim@yahoo.com,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: temperature: tmp006: use devm_iio_trigger_register
Date: Sun, 17 May 2026 23:26:13 +0500
Message-Id: <20260517182614.218-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 883AC56317F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-249140-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,analog.com,kernel.org,yahoo.com,linuxfoundation.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sozdayvek@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

tmp006_probe() allocates the DRDY trigger with devm_iio_trigger_alloc()
but registers it with plain iio_trigger_register(). The driver has no
.remove() callback, so on module unload the trigger stays in the global
trigger list while its memory is freed by devm, leaving a dangling
entry.

Switch to devm_iio_trigger_register() so the registration is undone in
the same devm scope as the allocation.

Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
Cc: stable@vger.kernel.org
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/temperature/tmp006.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index d8d8c8936..bf62143fa 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -350,7 +350,7 @@ static int tmp006_probe(struct i2c_client *client)
 
 		data->drdy_trig->ops = &tmp006_trigger_ops;
 		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
-		ret = iio_trigger_register(data->drdy_trig);
+		ret = devm_iio_trigger_register(&client->dev, data->drdy_trig);
 		if (ret)
 			return ret;
 
-- 
2.43.0


