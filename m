Return-Path: <stable+bounces-114165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A454A2B17F
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 19:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174E2169143
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 18:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E221F19E98D;
	Thu,  6 Feb 2025 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIETVlC3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1323957D;
	Thu,  6 Feb 2025 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867443; cv=none; b=fbj4+5L6gGS6YnGOKZ3hBRU+6mWrVT634MQdwWrWR1WTOiv3j0rUIpXMTMX1gzPFmp9S2Ys5scHjJzF63RYKDWP67Vs+CQ3nZ0gB4uwVZ9Pm6r2epVQw78aBkt0KNc/ODwNxQ5oIFK6V2Jxd8BzGk4guHT/SGjIhwxKuvFlV2BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867443; c=relaxed/simple;
	bh=xz1tEtY86+TooAY9vMCckEfm9RGbvbb8rBoa923Tt94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dmbp+aDJdnUoOrHm7VF8NrTBesrQpJdvadswDDTHg5d3s6L6CleXdY91Viwz97GW9AZGbQE86KqAWL7391WeIIWmHJrJ1/MGeYej+pvXDE5RlnXKCyXVMbRDtrXoyE0d6aR3ubxZaO/rDvglaFIJvspcGwaaOHTtjSe/iL5et80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIETVlC3; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53e3a37ae07so1423608e87.3;
        Thu, 06 Feb 2025 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738867440; x=1739472240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubNgv5xJx77x0BfBwAeUhTxXDIQLYEY0jUlTQLiDf7g=;
        b=JIETVlC3MSU9QAnJ57ajkYFf7tVzdXmOdkOC0aerojdU2ySqmPfoN/T3eZYIk+15+D
         NsztDpKX92mfgVQn7EE2wGfU9cVUjXrO7367XYt9ohbtDjqH2PZ6p8twc6Vybr+IhorE
         oUXA7nJqELfHggLdJM2mWNzTeUyhgx3Dl1YLd4CFkdQHGLJsp1W4YNGBW7el2464RKrE
         CO6IjKjggSg4TSLptij0AJ+8BZAPIfIHVi3NHB7jdGjuiv0jkQPlAaNpH5NhzRWg6D+J
         QBvhWBGlJ6zob0d9vxsCynpywgb1z6BkG6iWLCqKPR1GDoGWteBGIwfuFBedY+nLHGoj
         gpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867440; x=1739472240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ubNgv5xJx77x0BfBwAeUhTxXDIQLYEY0jUlTQLiDf7g=;
        b=k4zCGlrzvi9Zka4bjet1JV62EbpCUzQEPPhFUsBlsl/9yZYxDLXwriBtuvpZNKd/+S
         mKl5Q1vcvz2FQOAXl13MaQ+d6SGElhb34dh04mRJAyRCKOWpgDAjml/tYFrtxHW1QeMX
         Q2kF5KfQwNbFCA9CvqLzyy9Wm2qaMV8kq4R/L+qyLmBTdP0CrwYjySKZC8MDKZjW790O
         tE0wscuFSxL8X4HYU0YQeDSlscymTF/JuwoDf2ChHtCznzk44/eF86dhQKxvTGU27g5d
         Vv4Qgwh/+QlRjsahjAb4ZOoKseK4CBwZPrZEeSOvfJBiGZ843xMaBKqc8PnzPK62HxlV
         rZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCUXjd86T7Ivm06s8ziBbC0b3gmWTQz5/BtfXvfe28BCcut6LfpAI4MHGVZwEp2cMmB0ZoYv1uUYLd3mT2g=@vger.kernel.org, AJvYcCV2wRoKHjBq7Blq4E9kPB/oegtjOE6QUcx6KGZXerJ0KcOtyWM8pt80f9YOXjiiNG1T8wZ8ItRY@vger.kernel.org, AJvYcCXmRHk9N3ek0PwMiW55MG6wdR9uIoX85mmJRiSnUAGIfEyXZ7FEpL350WYC9etUmYpKPDZNUSV6Xzcv@vger.kernel.org
X-Gm-Message-State: AOJu0YxT6fPjiLOi+Zi5GRkqLChtK0Gp3v+XJ1rdUdxcE43QjuFmxZ2p
	fQeJT8i9FRdF8omDw1/G+qrn2DH6uHj1SypiuF3++F4wyRFjCOX7
X-Gm-Gg: ASbGncv/UZw0bnxnm26mMKocFeGityNLgq0zZMHp7hdem/EHxC91ZaS7/xbjks6xuMA
	dPFAxghtjQ8+ef5QgiG5HE1WVx+74bzL+RnQfPyST+uQuvvO6DDjG7J59GFjtRHu0F9FHArB9vY
	ewTQfpMDsGtDolPUzuP7fgqyAKDG1jnTJFp8XeRCPRXvZHhWeKKCzV5KKM0iny8OcfPt1OF3Emn
	Mw7kPirpf9i4ptNWNZWF9qBsdC0Uzw6gDFMlG+sDsjknSzOZbgrsl7qs2LVVSJmQTEP5RLoJr2r
	vNp2+7E65jsBJsDvqceeP5Ds40rNCmNlretMWIiH0VzY1FGhVUusVQ==
X-Google-Smtp-Source: AGHT+IES3r/As76MP/jAg5BKRkKqnMOlqh1cUV5rjIxya8ZzRLZmaPNz3gzcvknoZd6s5LdCgdPZkQ==
X-Received: by 2002:a05:6512:36c7:b0:542:297f:4f68 with SMTP id 2adb3069b0e04-54414a3d97amr6781e87.0.1738867439763;
        Thu, 06 Feb 2025 10:43:59 -0800 (PST)
Received: from fedora.. (broadband-5-228-116-177.ip.moscow.rt.ru. [5.228.116.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-544105f31b8sm198394e87.204.2025.02.06.10.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:43:59 -0800 (PST)
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Christian A. Ehrhardt" <lk@c--e.de>
Cc: Fedor Pchelkin <boddah8794@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Pearson <mpearson@squebb.ca>,
	stable@vger.kernel.org
Subject: [PATCH RFC 2/2] usb: typec: ucsi: increase timeout for PPM reset operations
Date: Thu,  6 Feb 2025 21:43:15 +0300
Message-ID: <20250206184327.16308-3-boddah8794@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206184327.16308-1-boddah8794@gmail.com>
References: <20250206184327.16308-1-boddah8794@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is observed that on some systems an initial PPM reset during the boot
phase can trigger a timeout:

[    6.482546] ucsi_acpi USBC000:00: failed to reset PPM!
[    6.482551] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed

Still, increasing the timeout value, albeit being the most straightforward
solution, eliminates the problem: the initial PPM reset may take up to
~8000-10000ms on some Lenovo laptops. When it is reset after the above
period of time (or even if ucsi_reset_ppm() is not called overall), UCSI
works as expected.

Moreover, if the ucsi_acpi module is loaded/unloaded manually after the
system has booted, reading the CCI values and resetting the PPM works
perfectly, without any timeout. Thus it's only a boot-time issue.

The reason for this behavior is not clear but it may be the consequence
of some tricks that the firmware performs or be an actual firmware bug.
As a workaround, increase the timeout to avoid failing the UCSI
initialization prematurely.

Fixes: b1b59e16075f ("usb: typec: ucsi: Increase command completion timeout value")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <boddah8794@gmail.com>
---
 drivers/usb/typec/ucsi/ucsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 0fe1476f4c29..7a56d3f840d7 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -25,7 +25,7 @@
  * difficult to estimate the time it takes for the system to process the command
  * before it is actually passed to the PPM.
  */
-#define UCSI_TIMEOUT_MS		5000
+#define UCSI_TIMEOUT_MS		10000
 
 /*
  * UCSI_SWAP_TIMEOUT_MS - Timeout for role swap requests
-- 
2.48.1


