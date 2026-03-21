Return-Path: <stable+bounces-227731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHIVGQdMvmkRMAMAu9opvQ
	(envelope-from <stable+bounces-227731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:43:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 582EE2E4022
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 08:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6433A30185E1
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D2333F58F;
	Sat, 21 Mar 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9sJq04d"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38569319617
	for <stable@vger.kernel.org>; Sat, 21 Mar 2026 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774078977; cv=none; b=Gvz7U6nPA3bXVZarU0XVSMnjH4m0rCrGa+GNbOt8R8blV6a7p/caVEYkor4gQk+lHCRhf9sSJSWTMJpPWMC4ALrLWPvJwUbSwlVNrmnykDTi6JymM9s0hrujLw3DftyIiMm7Ws/RM/Nyt3MAB/5NuZDuhPlWYJ3J8GpsK9uxOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774078977; c=relaxed/simple;
	bh=/fcUHnLNge6SFLxWrM+8HK1LoLEPvUarIqtfQwLEGr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qTPJSGwA1ofSNsq5bX+xP89XOQvrf3R10J7PWTicbE8/RnCOY28ePdqUhVnLBC8IzRskSQmAlsI1F6D0SEcDeexo/xKgFZoF/+l6Z05WU4WPKpOOiPDIUQCdlGml+cyryzoM87DW1cE7Y8aQBBtUzpnw7I+eth4wMTNK60WrSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9sJq04d; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824c9da9928so2705718b3a.3
        for <stable@vger.kernel.org>; Sat, 21 Mar 2026 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774078975; x=1774683775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+aCGxNHjQ3qWf5BFAN3CZ7YhrlhC9KiBN8YYYpfvlgw=;
        b=P9sJq04dZxfWtXbIKWXrakom2/SlFtQKQ4nujOlYU4AZi7AY8+sPGLTekXMccqFrlF
         yMPtK7bRXbRdwmWnGIzGU+FGg8ZmtKJxLgO1C2+S1jbpTYx6J5/G3A2VmDV5+FuizOcN
         H8AJv0K4uZErU9ruIl4TRojh+6Sr1inWgSlnb6UhB5i2kc0hNVnIp6dwPVxt9aHMO1Qn
         aeeJ5w3Us0fQTtCyk/3hM9HikyMTG44PMkgESrRQPXsRdiktjyXRwBgb4SlU1S8hd+KS
         ejAcCsP+r84F/DxlXoLnRpYROwgsJrmRdxefFRLG3xPOPU1eONjkkB0/19FhbdCUhBFa
         eLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774078975; x=1774683775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aCGxNHjQ3qWf5BFAN3CZ7YhrlhC9KiBN8YYYpfvlgw=;
        b=L3WDXpYFUdcBbNcIQmfJYC/4xh3SjBUUlU1ozGuUTvdj77EinRpoFph9wyKGzCfyET
         k4IiJlPKRIMiC/rjW3fzv5GbJ515hHY/GUBWPTWl/czmTQUShfTFhXrGFtgl9PQCs+mB
         pj24sjphPpzI0fmvRMIRwvTU5OuS59Ni7M8tX4gmuGcfhmUDxOlVo82on4+o/iy7dyE8
         GQbcytpsWL03Z8qHmFw9KVlnx81c8EOJ/xUvLWRDeKbmayjhB6PQlby+vrWdlyZ/JOpz
         nxlxB9RdvSELUH9mfcSR4nk1/WYGgUxILuaF3EP68xolYHY0i/tcVsaN3yLkFl8AKdUG
         Ze9A==
X-Forwarded-Encrypted: i=1; AJvYcCV8xtqnLj5mUdRyBJOUAW4ii5I4e1ekN64mP47xIbH07MSYODj6AB//xoeVn6qqGABRFzslMyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdTIJzYNWzrq/h9/HYH2NhxtSM4QV7Aelf8OGIqE0/lBMYnND
	gkoLpzeiV/09iJpxeB0eeLiTmI6+G344kjk/egUcGvALAz/aBCECz9r4
X-Gm-Gg: ATEYQzzDmFFSeM8kcO2GV85zrsqMMye7MYynqjyf2TrK5X3tugUbMQhs0d8YTGRiFOk
	6bZCyt8wdT1CIiqHRJgOjBp7cOgGV8c+4lJYsgLvGIA4RGGsIAJS1211B0VIOEP/qdsI7/PQOXd
	Hq5xPNj8I9MqKudPDHZiIVzUF+c3AyxfduqA1zebJTL05pmCEqiqbkRHDmxsV02jV9hUV/V3Sfr
	H1iNAnNwyoojqXPjMKhUdbgdY9hxuYQOckTKnRIaiD0vLAQKpFeM6qt6NU2uwz10u579KM5tAa2
	1l5rAmFHPFTWpGHI8Ug4zi5WB1ffwz6u82jOw78PUuaTf9gAQNUSZZcmNF8wTpantIe4CcGB05X
	hwo+vOV3Q6vJpLroy5GdcTI5gr2JgPGSdq34eb5+Tk/5VGA5byuxFPHR5fa60vQRKDNekmZhX7f
	IorzHLj7TadSp81aU=
X-Received: by 2002:aa7:9e41:0:b0:82b:4a85:3e2f with SMTP id d2e1a72fcca58-82b4a854131mr2881784b3a.41.1774078975582;
        Sat, 21 Mar 2026 00:42:55 -0700 (PDT)
Received: from lgs.. ([199.182.234.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c212ac8a2sm3503489b3a.17.2026.03.21.00.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 00:42:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] reset: gpio: fix double free in reset_add_gpio_aux_device() error path
Date: Sat, 21 Mar 2026 15:42:40 +0800
Message-ID: <20260321074240.796922-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-227731-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 582EE2E4022
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When __auxiliary_device_add() fails, reset_add_gpio_aux_device()
calls auxiliary_device_uninit(adev).

The device release callback reset_gpio_aux_device_release() frees
adev, but the current error path then calls kfree(adev) again,
causing a double free.

Keep kfree(adev) for the auxiliary_device_init() failure path, but
avoid freeing adev after auxiliary_device_uninit().

Fixes: 5fc4e4cf7a22 ("reset: gpio: use software nodes to setup the GPIO lookup")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/reset/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 0135dd0ae204..58ecde760b6e 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -856,7 +856,6 @@ static int reset_add_gpio_aux_device(struct device *parent,
 	ret = __auxiliary_device_add(adev, "reset");
 	if (ret) {
 		auxiliary_device_uninit(adev);
-		kfree(adev);
 		return ret;
 	}
 
-- 
2.43.0


