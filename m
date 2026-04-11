Return-Path: <stable+bounces-235688-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHIIGckA2mkGxwgAu9opvQ
	(envelope-from <stable+bounces-235688-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:05:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5133DEE12
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 10:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E662E300B063
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 08:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D465B2F6160;
	Sat, 11 Apr 2026 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5P1Rsnn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E742E8B8A
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 08:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894724; cv=none; b=tPmKBNSYThPNs8JR1XnN/frR59FMhpCtWyZ16EKk/IQejXvzPkpgXg5EFAMGEKt1dzBDcBCZaO9WFjC5mQmGux4/453XPBQT1U5QVyZYQXr3WIYVjDMfiv7kRHP/eBeMawEmp8827QN5egmQk/lvXYi8mU7dMPK6CODw1qnGBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894724; c=relaxed/simple;
	bh=BTffGS/gCY2Nhw4JwAa2fMfT8m8fmomn9ZHDLdl05cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ubiJMB5KMk+KLHHAbgKWKteq1zNhqicIaAQC9kVtJD8eKj1x8Brc+edhcvBBTJr2z02Bg+7USKlf0/mx8kQ47xd6p3jwHQPixj5ZADvw/+FA6F6Ck6K5Tdb1ywzI+FhLAaAbgFFRWcCw+KcNMNqkUNrlJTC+/j1VdX7BTxxE3Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5P1Rsnn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f22ec4501so89397b3a.0
        for <stable@vger.kernel.org>; Sat, 11 Apr 2026 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775894723; x=1776499523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KAoYJAvzB2HJXU7lElfXwN21XkOVJNicGBCcf7Ya3j8=;
        b=I5P1RsnnYChFxGNvZVaAw/lS5uJoNNe5v/L9BQ9J2iaH/qggbw+r3ASv8EjyuNMxGD
         F/WeB9EZH7TP1oG9EqsFWm0hmsxmcttgWV4Gf09IF9I4g4Q+jlnOdk5+nH2sLfP6ZQWa
         nyS8HXv7UjzOdJhFgJbdplZMF+INJ8KJXva6+IUIl7tM4dY2aYK3pZT3NDV2zGMGJQp7
         j2gB5RQdP5O5iFiUwUdi2IZvUu37tQVRmJHL4SfdJ9kemrBPFBTnEECleKB4uPMfuqQT
         oHuK8xmZP4vmGkrXBvhOG2l7QeDrxLQCWBsqfKmW9Hw1hIVDEOOdSUVX1LJwysaNDK0c
         F4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775894723; x=1776499523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAoYJAvzB2HJXU7lElfXwN21XkOVJNicGBCcf7Ya3j8=;
        b=H96DtpPoU4344vY6VDpZbG0RxYUuwBzyX2HZWNTaCaSN8X/D8aw9IR4Qs3X4lTv0py
         YvjGZnbKNYk5IyrfaWXwlTcBu+mNCUK4tZa7gRgYQ+NN5DNw1+jQ1++0cozuh8LiWrGl
         /fFqVzgJ0mcJWMP4a8teKsaisqar+5MkcjNx6WeYHrNdmKviWGVlh9DyKtsuvc3ev0o1
         jmi6YGgD1XHCIAtziFoZHQhHJh+/+eSIwf83fzuGClOxRLL2t5M1stofWH6LaWvieunv
         bncD3ds4zEv7xSy6twND+ENsqVP2OaMp4em/GHmYuVcn9s8acAR5i5M6W1jhPWW7E37K
         6HIw==
X-Forwarded-Encrypted: i=1; AJvYcCUi+09WuNtXt9WCT3zpvgpSQZ11EWjoUkyqsCM2AbcVS+P9dYAf85nsjmaUKXp8a++XTgX0k8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS1iu2RF00w8ufnelVHw/oXdhtIPTB2f27RoxxMv0AczYUEkIR
	JARIYgXGAtOW3ytkueTEW/FGCGPcNqZPhXkV/6zqTNuUUFrRikmuTYL/
X-Gm-Gg: AeBDieulQeBQKMGMxTIgkmnyPwcIlu0x5A/wIHpdtwL1CEJJeCZVpMtlNZ4kYm/AeVp
	bgGLc6BEhRoy0SLus9i6sHy5IIlpZg7nDQ+UnJHc4+FGoST3FhDccrTPpRZWpbdhzqfwQwmr3fE
	imKIwMYCeeMnvdye1PRlSI3kO1d4oZeRvnxtGuhP/ILkIwaoddK30bxFwzfiSWKYd1+bdr6Rj0t
	yrNImkp0Cfd4+HtiZdL7CHN5Ur+vgXHjvtzH4Q63LwDNEx7gIWnCBaC0jW4qZlTxpkh3VN+Dhtg
	pYQVW35mCi4cva42TGUoqec8lb+WHk4/MPFU3sP4dSyeJSLrekh2ztWWUcSQxr0BRLEztb7RYSQ
	8nVLQb0f7JR0wdU7r5bLmcG51zJ+kKedzpWUiNnC2nWODRm1BknWeWdIjwBhTq1yC862iI6OJMU
	MZtOPLc3Nd+PZ2WEvU7R0UOg==
X-Received: by 2002:a05:6a00:12c1:b0:82c:e1a3:986f with SMTP id d2e1a72fcca58-82f0c324538mr6784698b3a.43.1775894722730;
        Sat, 11 Apr 2026 01:05:22 -0700 (PDT)
Received: from lgs.. ([112.224.67.108])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b251esm4820466b3a.37.2026.04.11.01.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:05:22 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dan Carpenter <error27@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: trigger: Fix refcount leak in viio_trigger_alloc() error path
Date: Sat, 11 Apr 2026 16:04:35 +0800
Message-ID: <20260411080435.2125626-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-235688-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,analog.com,gmail.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BE5133DEE12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After device_initialize(), the lifetime of the embedded struct device
is expected to be managed through the device core reference counting.

In viio_trigger_alloc(), if irq_alloc_descs() or kvasprintf() fails,
the error path frees trig directly with kfree() rather than releasing
the device reference with put_device(). This bypasses the normal device
lifetime rules and may leave the reference count of the embedded struct
device unbalanced, resulting in a refcount leak and potentially leading
to a use-after-free.

Fix this by using put_device(&trig->dev) in the failure path and let
iio_trig_release() handle the final cleanup. Also update the subirq_base
check in iio_trig_release() to test for >= 0, so that a negative error
code from irq_alloc_descs() is not treated as a valid IRQ descriptor
base during cleanup.

Fixes: 2c99f1a09da3 ("iio: trigger: clean up viio_trigger_alloc()")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..ab544976018f 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -509,7 +509,7 @@ static void iio_trig_release(struct device *device)
 	struct iio_trigger *trig = to_iio_trigger(device);
 	int i;
 
-	if (trig->subirq_base) {
+	if (trig->subirq_base >= 0) {
 		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
 			irq_modify_status(trig->subirq_base + i,
 					  IRQ_NOAUTOEN,
@@ -572,11 +572,11 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 					    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
 					    0);
 	if (trig->subirq_base < 0)
-		goto free_trig;
+		goto err_put;
 
 	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
 	if (trig->name == NULL)
-		goto free_descs;
+		goto err_put;
 
 	INIT_LIST_HEAD(&trig->list);
 
@@ -594,10 +594,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 	return trig;
 
-free_descs:
-	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
-free_trig:
-	kfree(trig);
+err_put:
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.43.0


