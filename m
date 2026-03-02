Return-Path: <stable+bounces-222693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLpIFi7ppWlLHwAAu9opvQ
	(envelope-from <stable+bounces-222693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 20:46:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B10A31DEEEF
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 20:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B91B3050206
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 19:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDBA31DD97;
	Mon,  2 Mar 2026 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kAoZWXuW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70E03859D8
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480803; cv=none; b=rvaJa9oP/Jah2jL0AEUfIUJRBMNgqbSHB1QflO8fE3ML9dj9UiHRBhIxOEyvX5zg11yET+3TeoVgx57mR69fJZKBMe/tEntO/7pVALzB+y2XEjva+HsVgujOlpx63odP3MJIfq6M2P1k6Py43wD9qU+jviDQb1vZ5IMF6wYraUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480803; c=relaxed/simple;
	bh=C7twzYv5Quov/XdLb3wRfw15MsYrGs7NH/TgyH03EiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1//TJ/snB6537dImK8ImRAk502Ig9Uq9f/cwvMzuERmgY1CMyA+qhXEJgX6eYr9WgaaEUZudsJEkWjUtHgzQaRNtxHaUIHa4rV7Ov2P2jI5Jr1+1VrDlYjUcLO3MPwDkIuUBMA2gSr1dyjKwsjKimfnqQVrKtKCV7eifY1lgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kAoZWXuW; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-389fac627c9so71260821fa.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 11:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772480798; x=1773085598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdoIP+fvkwgNMTD05bNgRbQ1btw/ECOG/Mj2Z1y3ZJY=;
        b=kAoZWXuWKAbB1exhJcwwRGByAKLV4KdCrrPdW64HrgQvrm1B6AeapAcs8JV+bKo2r2
         kh8G+9H64k3CX9te5JNUNkBjp1aPbuom+YY4ZeqsmMXdFiCroz8ZWSSsS/pzAaj4eGth
         hjGteLl+g+4XbWjPORiN5gZLMB91IAuBKcpr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772480798; x=1773085598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CdoIP+fvkwgNMTD05bNgRbQ1btw/ECOG/Mj2Z1y3ZJY=;
        b=AL8w7eow0NrCE+m2sh5zcua6R+5mW71uDFOCtzP0qBzpYuh+/bBfdhtWsFLt/uAwdR
         2NuYZ1TFuIbDOXnJjaZBghV38pMvzbAVK4Dc42AJc4xXQB7txUSySoimiq8tFXpuRc72
         NV5mEpF3njAn5E6+juqhPOVsCQL4mwlHViHDAS1IMiPEYLhG4c+DosxAC9uPy+0gSUrA
         MbZz4luA8oRmOpXdIC0LsxmijKL+nc42pqYeTtU6ptlZoxZcY4Cs9mNopPbRf4pG7FmE
         iI9IBQuUm1NGPqKVrvXgG69yCtxbGJWOjGcQ4ljLArRkg5DFIDHJphLcCMnoXf/FPjsq
         eOog==
X-Gm-Message-State: AOJu0Yx7xdS8Cl02nl68gzYB5YRh8y9hefkQgwaVbAlG3umIcUpZspkz
	oZFebgBrFL8vDfWVKbLww8IgDcn1gOFxnDmhgFMhQl7ZcZ6bhD2gcjFG8e3Vm/ssCjD49urxHiw
	azdoQat2Z
X-Gm-Gg: ATEYQzzbS3G8dEnkU5paE0vndcOqN/QZh+0dcYvfPFD1E4Ymcy6yBjMcT/RUiMyRZjk
	U5plKf88pt2Q/vZu5Mmu9V8mS0GiTOdFRNY+zLb7ojzYBDLXG4zodoBuSik/HA0b6pWV2sci6sw
	4paDXpjxlBEnkAOicIRRgad/UTSTvCVVVUPXQtumIC2RNEXhUwg3xM5EFHmEuTiavbGOdcg/sgY
	X+9yFNmuT5gWhCwdwqnU3qkgnG17GyUUqYnAhzNvYFwYasa3C8mMO0zXyPaafvwIFgif+aOykms
	vo6e2LGOV4dVLjQ+OXUEFKWJXyY4SisnUtmeGqcQ4WiCb3mvFe+DY800Q16bNBMclVgf0xV9/Y9
	aG5KvSWWXuRXitIVMUcCxvMrSKTJzUDv8MA1pAjlAR83slfaWtqFiVCy+IyLenMpEo2shVGsO1g
	GPqaspl4wGbmVqPGwdS5ddeG2RTd7/WcQFqPjaN/iQ+Y17IC/o4zm8iQhkBFN/bKTzWZt6ohbhB
	I+b3JkuZxNpednLOg==
X-Received: by 2002:a05:651c:4413:20b0:37b:a30e:fe1e with SMTP id 38308e7fff4ca-389ff1456c9mr78059601fa.18.1772480798453;
        Mon, 02 Mar 2026 11:46:38 -0800 (PST)
Received: from ribalda.c.googlers.com.com (27.69.88.34.bc.googleusercontent.com. [34.88.69.27])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-389f2f62d18sm26689021fa.12.2026.03.02.11.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:46:36 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
To: stable@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	Neil Sun <neil.sun@lcfuturecenter.com>,
	Naomi Huang <naomi.huang@lcfuturecenter.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: [PATCH 6.12.y] media: dw9714: Fix powerup sequence
Date: Mon,  2 Mar 2026 19:46:26 +0000
Message-ID: <20260302194626.744707-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260301012031.1676096-1-sashal@kernel.org>
References: <20260301012031.1676096-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B10A31DEEEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[ribalda@chromium.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222693-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[chromium.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,qualcomm.com:email]
X-Rspamd-Action: no action

We have experienced seen multiple I2C errors while doing stress test on
the module:

dw9714 i2c-PRP0001:01: dw9714_vcm_resume I2C failure: -5
dw9714 i2c-PRP0001:01: I2C write fail

Inspecting the powerup sequence we found that it does not match the
documentation at:
https://blog.arducam.com/downloads/DW9714A-DONGWOON(Autofocus_motor_manual).pdf

"""
(2) DW9714A requires waiting time of 12ms after power on. During this
waiting time, the offset calibration of internal amplifier is
operating for minimization of output offset current .
"""

This patch increases the powerup delay to follow the documentation.

Fixes: 9d00ccabfbb5 ("media: i2c: dw9714: Fix occasional probe errors")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Tested-by: Neil Sun <neil.sun@lcfuturecenter.com>
Reported-by: Naomi Huang <naomi.huang@lcfuturecenter.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
(cherry picked from commit 401aec35ac7bd04b4018a519257b945abb88e26c)
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/i2c/dw9714.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/dw9714.c b/drivers/media/i2c/dw9714.c
index 2ddd7daa79e2..9dde85a95662 100644
--- a/drivers/media/i2c/dw9714.c
+++ b/drivers/media/i2c/dw9714.c
@@ -157,7 +157,7 @@ static int dw9714_probe(struct i2c_client *client)
 		return rval;
 	}
 
-	usleep_range(1000, 2000);
+	usleep_range(12000, 14000);
 
 	v4l2_i2c_subdev_init(&dw9714_dev->sd, client, &dw9714_ops);
 	dw9714_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
@@ -262,7 +262,7 @@ static int  __maybe_unused dw9714_vcm_resume(struct device *dev)
 		dev_err(dev, "Failed to enable vcc: %d\n", ret);
 		return ret;
 	}
-	usleep_range(1000, 2000);
+	usleep_range(12000, 14000);
 
 	for (val = dw9714_dev->current_val % DW9714_CTRL_STEPS;
 	     val < dw9714_dev->current_val + DW9714_CTRL_STEPS - 1;
-- 
2.53.0.473.g4a7958ca14-goog


