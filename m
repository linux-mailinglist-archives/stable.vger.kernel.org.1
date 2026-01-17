Return-Path: <stable+bounces-210131-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAE3D38CC2
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 06:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94642302510F
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 05:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE1B329C70;
	Sat, 17 Jan 2026 05:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFyQOzPo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2B2271457
	for <stable@vger.kernel.org>; Sat, 17 Jan 2026 05:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768629282; cv=none; b=WD7LILdI1ND6vo3tkwmVJt7Y5vBE9jxmoqsb6tURa6Q6BitLtlHw6tnPGZl8zYT4EwdO7OAscN1ztzp4XRzd0BN41ADZz+8XLqwk5CWiMfNUgR6edkEr7ICvzAFioQeyvzo59jUp0+ctahMD1Jy3a8hSVpqv+8ZtLhbS2l9++gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768629282; c=relaxed/simple;
	bh=X28oz4Hqu8C9OrNAoigAJocOtIUCqP9c5jKWoshxS8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F9Gj5SNdGHSGeQx+As1Q4aGz1CmLh1wBwsTapHsCWrKWBv+lb59qHbEQIPALithBU6KG2yiiSaCMC/+Q2Ej8wiR9ziyHlNI0gBYRKtRrz5MIz+eDc7k6ZzNk8O3f7SG7zbM96Rf4C46L1FbtAWmImcJKV5piwQdPQ8u6Dl9wj9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFyQOzPo; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c2dd0c24e5cso1025366a12.3
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 21:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768629280; x=1769234080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/3Y2YH3nM767IcqTvERX11GvwkdtC120hdoDxqBZKew=;
        b=LFyQOzPorXJunsHZVvd2JKEQoxTrPZMc2PXAORIkJIDwazBca9x1UeW614FnKUk46W
         5sqXe+fvZHnWnQAiQXX7k0Ybia7YVROUnPSkmFc1ALQM3ELPbY8RAeJLwJESRcneJpbz
         Bv3KTE4w4NAlYbam0PBu11ncJtSyoxKSdnN31DbNopNArBFKoWOrMOYoNLAgSQG3FkAm
         2sNFTA234aqrLLZqpvAu4GfRRwUDI3/RSZcl+c28v/BxzRa+BOhaUQ7DK1liqlU3/ivV
         qzZB+h6/abccnfQVku07xcqOhIoS2AOdebWkn1ubF9oCUeeK4pr/c0+yDSY+iufZcasw
         GzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768629280; x=1769234080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3Y2YH3nM767IcqTvERX11GvwkdtC120hdoDxqBZKew=;
        b=Jv6N8I2bagfdvzL8pesn7zbUowD2xhINAGgme7oH1HZ6ExLz7bgENSRbyMwPccaTWY
         /tTuKJ4/knpOItyqtr9A13SjZKq4Js3/LLl9VmhOn4yMzVL2rHbS7J6q3Y7dMEyTi2JB
         vBNy9hchfdhfEt2+AXE9Zb5+Imu0KWxxb3o10Fc9UeMNf+7LqyS1g3TUzBECHazcnEzG
         l/C3IW9AYnXc4LNpz/diozb5DEG/D/CrHGSFtKnAaU6lWrpNvQs298YIIg0YsZ8O44kD
         MvpiUUm58bDizOYFWTAOXOEqq+w7tfs3Psc/K4IjjiqfyYEGA+JeIb2HI2HJ92EiIlj+
         lCGg==
X-Forwarded-Encrypted: i=1; AJvYcCVsSd5e7UkTPWIB2lkdab8b1b58OkRLKa4zjpKcO9tuYEsPKmgHFRpLujGqYNG7HRCGyi34LmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcdClOe2grhmIuL7P+wUuqZhPx9xo6paflhW8VzW46/klgmnan
	xT5SgAD5BGmChr4dJ+At9SjsVKheg6KHfZGNmkgk2cW/3PxbIJ7jV51a
X-Gm-Gg: AY/fxX4XdZXUPV2NYqgn4CS5AOkw3mpp0manlfwJKnpUota4SGVdjjTatGjNodfqFej
	IIXgFCa7SGEEbw1q5FioL6ZU0B1XSDZJoJtqgcICTVW6Xdgt/NCnNgUXuU6eqKf2/anbGGG2jCy
	Z2oZiTu8eH5ujo7dqebMVVqqb9CbkAGxV0HHP6yFVj2A4adVCaJYjFMGilSk0atE8zwGzSawD9S
	Ww84t4cWmR4WzOPqIpxUWfoPLC0i6/VP/j0BKQdQ6BACxaBfMUVe6HOPmJxl8TigTUERX/GKBab
	55hHmBuJovOanrF9EpBZJ8TLZPZ1qMEb68ghAJ/wsm34/eQGSeW9xskUcyJPlTK9YPa9eFO8Ras
	UG54Lwwg9xsOfCMW3PLmbubRbngujKAkri30n2obH6Jj+JisX/1Zdj0jt2UykqAmTmW2tE0gwtW
	Ktro/WfQcH3LRe2MBVs40e9XbZ8saBejjgcdbSMBFu2VQDpOnGSCoWX6WN269ja9l5XggLOVxXa
	ya+Xuff+vmswmLJ0f933Akg30iBOz7MWMueOw0TaEqopVg=
X-Received: by 2002:a05:6a20:5499:b0:38d:f0f3:b96f with SMTP id adf61e73a8af0-38dfe7b8b24mr5870030637.64.1768629280156;
        Fri, 16 Jan 2026 21:54:40 -0800 (PST)
Received: from c8971f1abf06.ap-southeast-2.compute.internal (ec2-54-252-206-51.ap-southeast-2.compute.amazonaws.com. [54.252.206.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d175sm3413091a12.23.2026.01.16.21.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 21:54:39 -0800 (PST)
From: Weigang He <geoffreyhe2@gmail.com>
To: tony@atomide.com,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info,
	khilman@baylibre.com,
	rogerq@kernel.org
Cc: linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Weigang He <geoffreyhe2@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] bus: ti-sysc: fix reference count leak in sysc_init_stdout_path()
Date: Sat, 17 Jan 2026 05:54:33 +0000
Message-Id: <20260117055433.416027-1-geoffreyhe2@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_find_node_by_path() returns a device_node with refcount incremented.
When of_get_property() is called to get the stdout-path property, the
reference to the "/chosen" node stored in np is either leaked if the
property lookup fails, or overwritten when np is reassigned to the uart
node path without releasing the "/chosen" reference first.

Add of_node_put(np) after of_get_property() to properly release the
"/chosen" node reference before either going to the error path or
acquiring a new reference for the uart path.

Fixes: 3bb37c8e6e6a ("bus: ti-sysc: Handle stdout-path for debug console")
Cc: stable@vger.kernel.org
Signed-off-by: Weigang He <geoffreyhe2@gmail.com>
---
 drivers/bus/ti-sysc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 610354ce7f8f0..091cdad2f2cc6 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -696,6 +696,7 @@ static void sysc_init_stdout_path(struct sysc *ddata)
 		goto err;
 
 	uart = of_get_property(np, "stdout-path", NULL);
+	of_node_put(np);
 	if (!uart)
 		goto err;
 
-- 
2.34.1


