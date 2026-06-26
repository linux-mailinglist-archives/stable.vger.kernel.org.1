Return-Path: <stable+bounces-268714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HfjFKQfrPWqX8QgAu9opvQ
	(envelope-from <stable+bounces-268714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:59:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B436C9E19
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 04:59:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=jqK1RYPY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268714-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268714-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBB573022B6C
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 02:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3276B39E178;
	Fri, 26 Jun 2026 02:59:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04F639DBC0
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 02:59:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782442755; cv=none; b=Ln6tAUgnfxmEaTEL1c7JE92sRQ9GYDtpyTS4T2C2Hnaa7rGqwgJwI8UDcu+9jZDaT3UAiF7KptGQRZ+WJO6EX/23LIxEKkEx4MgM6hmH7CSZFJ/Z26aXJ3fb7RlZp4P5rBvETuHRhPwO8O1np5P8Fgd/efNCSRc8mx4z4Nu8jGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782442755; c=relaxed/simple;
	bh=54Z8Cw8L0KFu3D/Cv1efbP6u76H/GbdlhPOW5yAC0bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfuEEBLclWE9OV8JWVq/HYssZFkarLhhYxYbzs13w6oy3XJk93PHCO4vIFgq5uIcAFOpyJG8EpD9+f2soWOr+/PKUNJoFCCuD02FrbwsvFYhxfgvEUrzg0oLcaqLO45PJ3V7qcAw+EQSqB5VqBAmsR2jAwcKcMEXkjEFuWMXk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqK1RYPY; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c6bdb8a8bdso3637845ad.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 19:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782442753; x=1783047553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvC4gX1oHDIM5j6whwgmhqEecsHukjk3hp3brUU36ME=;
        b=jqK1RYPYmyh0xTG851ApT5aJo4r0yDPYrl2XyL1Ygd0vzhJMzJExTbCwmtwpnDQ+vV
         AK7HVHyOzDAC0hrqUhR84opc0o74/p8Qk8lU0kx26aLdJTg/aUSeylHtnRpSqXuEZDTI
         lHVHSz+nV76ZayUWPqD4kEiEXE1uZEwAniTocgRZtny8pMjg2BFBZYlJErUacZ7JXDC5
         dBvyS6O7aemMD069iOX3RYlmpUy+tCJXUnsNynfdK4Rr/KfeySboOSb/qyoWKrkCn4hf
         16OuKW6HREso9FnLEYQj2/rDG9+JWC+DFEqQrwILg0kn2OM7G43TLvCbhZ55JX4/iQNy
         /mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782442753; x=1783047553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IvC4gX1oHDIM5j6whwgmhqEecsHukjk3hp3brUU36ME=;
        b=chQtM29EktScbx/ICISF0+1ZthD7TSU7SYPQHskGE9KCpuXOOB61yV5P417c3DtPqp
         BXvc/bjGE4oVT8vYKism+76PoTUQCQdcprxUy3moOVNFndeVYPWiK/H2poqqWt1mtSrS
         JqFrsyYPpzLjeqHHJFibjQwfU6LMSBXy3PvZ94gpiBb3GykZX3tHvZnKwUaw/E2JK6xv
         av/p34OZkJh6JHi7zQ50nHnUhIsH3DqnJ0EIkffFV1cK9ZtJXWMJNOCyINUndLSy+7Qp
         345ya4pgUATOjaaCi8fnWatMYh5YiIWLVuDVhLojGtWGssEbhefedZ5IVeluJgEaQ1hs
         tvzA==
X-Forwarded-Encrypted: i=1; AHgh+RrYljYsq2q/BGsyhXItBhD3Ov70Vnk+aFvKl/MW3TpLnk1mVytxfjbUuDJk5bealv8Ut7Ev5/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/yU9qt4G9+qJyVggr5xfP12ewyXyg4cUvD2XyiIryGPJtwxqH
	WQtEi610tZeoWuI0jOUl2tdDGMIF780ZKTAKxeXzx1J2vzkjSdl9+6iy
X-Gm-Gg: AfdE7cnfc32frNmdKhTuKmL1eMqRTgl0wT97K8gDfUP/bwow+0lMpLf8z05/aBn8AVr
	v3kOWPG+/gW7aQ6oyC+UurNZRYA7UCqFa6eG5zZJ5yZFdi2n1AKH8VwKDcHAULfrajZfSceBhWG
	wOieTMSTBHRXs/lEI173rhj4YCAdkriJ8v9NkcjTonhWzcoz/2r2HXLWtiVHi7ajpy4Q17WENGz
	YklDtnJv22PV+D0MGFnsu7tBhSD+NKNXlZrQige+xH0aaAasRWVSFZQ9XAcjhEVh/BajUyhEhec
	T2t+UKJsF8x+v7kAvQai0AeUWLmyvSPuoab6Bt38ljIhs6w4QASWw00rFsgh6TDrF7/sX/tbOZ1
	XZNHM7f+Qs4B5lHpHHE+2yj+dKIflQyjD25PZrZeYugNHDQTIh969c7MhhbHWW8xWJ5LltEbvCQ
	giAQiasrEAiUg=
X-Received: by 2002:a17:903:1acb:b0:2c8:1f58:55dd with SMTP id d9443c01a7336-2c81f58569bmr423295ad.9.1782442753216;
        Thu, 25 Jun 2026 19:59:13 -0700 (PDT)
Received: from archermind.. ([182.150.55.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afb1e0sm31252535ad.29.2026.06.25.19.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 19:59:12 -0700 (PDT)
From: Liem <liem16213@gmail.com>
To: frank.li@oss.nxp.com
Cc: Frank.Li@nxp.com,
	andi.shyti@kernel.org,
	biwen.li@nxp.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	liem16213@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	s.hauer@pengutronix.de,
	stable@vger.kernel.org,
	wsa@kernel.org
Subject: [PATCH v3 1/2] i2c: imx: Clear slave pointer on registration error
Date: Fri, 26 Jun 2026 10:58:45 +0800
Message-Id: <20260626025846.106157-2-liem16213@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626025846.106157-1-liem16213@gmail.com>
References: <aj1UR5ddawsdMbZC@SMW015318>
 <20260626025846.106157-1-liem16213@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:frank.li@oss.nxp.com,m:Frank.Li@nxp.com,m:andi.shyti@kernel.org,m:biwen.li@nxp.com,m:festevam@gmail.com,m:imx@lists.linux.dev,m:kernel@pengutronix.de,m:liem16213@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-i2c@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:o.rempel@pengutronix.de,m:s.hauer@pengutronix.de,m:stable@vger.kernel.org,m:wsa@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[nxp.com,kernel.org,gmail.com,lists.linux.dev,pengutronix.de,lists.infradead.org,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268714-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liem16213@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 53B436C9E19

In i2c_imx_reg_slave(), i2c_imx->slave is checked at the beginning
and the function returns -EBUSY if it is non-NULL.  If
pm_runtime_resume_and_get() fails later, the error path returns
without clearing i2c_imx->slave, leaving it non-NULL.  Subsequent
attempts to register a slave will then immediately fail with
-EBUSY, making it impossible to register the slave again.

Fix by setting i2c_imx->slave = NULL on the error path.

Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
Cc: stable@vger.kernel.org
Signed-off-by: Liem <liem16213@gmail.com>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 28313d0fad37..17defb470776 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -936,6 +936,7 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
 	/* Resume */
 	ret = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
 	if (ret < 0) {
+		i2c_imx->slave = NULL;
 		dev_err(&i2c_imx->adapter.dev, "failed to resume i2c controller");
 		return ret;
 	}
-- 
2.34.1


