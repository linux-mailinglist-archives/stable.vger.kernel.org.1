Return-Path: <stable+bounces-89102-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60449B3753
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 18:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25FE3B24C75
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CB31DF275;
	Mon, 28 Oct 2024 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC3y/4B7"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99AD13AD11;
	Mon, 28 Oct 2024 17:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135209; cv=none; b=c90At8SI/f/xFkTgeMDwfA1yky9xhXV21j5hmSWvCqCJQTnl7tPOcJVDoUmahXWRaOwJTPkH+K2PmzO8i+AWoU2YHQDVCbN40puaT2G6IG/pLRPjs8dsjAELj3vt/xl0eSZNUPauVZ2PAVTwIsc2gFKQkVUKZ1sAPHHt+sTVkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135209; c=relaxed/simple;
	bh=hSFWp27IFs8R/mtXYTZDTyF+KDUDuBjLR3DwK1+aO9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U9twJSH7HpR/pp/hzHXUNFgKcQ01h9R+98wl9fFbbLR0nwr34d9dqEqicX/EtFx/Ov2uouULPr/dlUfBXwdHPoaEzq783Hj+4G1KSmYjSd86zv04ueJTd+TL4UPCw3BQse8EozGSPcjNGQ+2i+0lSMG/c2umGJJ25L3GZT6V8fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UC3y/4B7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4d1b48f3so3378709f8f.1;
        Mon, 28 Oct 2024 10:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135206; x=1730740006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O05QR5jut87q0up8QxTT54jxN1Q5tSHRGwMyYGGlNAQ=;
        b=UC3y/4B7qh0JyQ3JAWgqdcIwB8U0pTWJQDgbXG1ktsIarQkNzx1jjYoANKw+4O20D3
         CMc1c2Ms3sAuzE4tnkre1AI9+N3j3jT9HBmSs+4Nf8kKXfW1srJiRUiaIhfq6lzjJvk4
         hthUwC16MawfJR2VaPUhVRUdVnGOSyZQK7viFihQFiBh+dEWaKYBSEhfVM4p51hOmtAW
         +fjmV07qU4uP0emhSfICQajRUMJ73nB9c5jXFrrNIgA5i/FOcG5oiGkGC6TxC09AyubU
         EUGCzGEOtyhBGFlhBebMIB7LSmwjrWVwtsEDBidcrhsJFhKrh9LqWSwJZhIYJ+KMdZnR
         bcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135206; x=1730740006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O05QR5jut87q0up8QxTT54jxN1Q5tSHRGwMyYGGlNAQ=;
        b=jndsg287MClZlnyydkEv5iffwDVLetHNBhbRPW+GMZf1Vw7JEdAkgnuzEQFnIjFSuN
         bWKf6B+sOpikO9mN/VK2WIv5ovi38nPBXzX3oF8yszxTZrINJZkNMMB92RUK7kkYyVzq
         wEot1KxVffZLiFeJyGo0hue7yunxXM46S4jG0N8Ewf8UMCd1YsuhmTYAJejaqGlftyde
         eRFm02XaZG9FiU/fGYLJtZ8oDcJlcjb/HT6NSek2zozApjrqa1YxXtUPMdolbgQFs5aO
         ACTEtdfYscq5+zR7bj1h9KYyOQoHIG74fAPKZriVds391WTGBTsaS1plPHkKbPh/a7Eo
         tkfw==
X-Forwarded-Encrypted: i=1; AJvYcCWpZPW+4vGPPszw9NqAqVVDp6dwjNMR0VG6TVMlSq6nBZs/Evp3pEB/oUNZognH56tcV4tjjxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLqXhOYSg/vDaRnO9MDnocUanRFVTx4SRsNEv22tsj6rb1fxUL
	t+MHgnICmAhLUQzK4EAnDzTL5GkoxIl1YpU85BqMlJonwLTg/kP29zDIgg==
X-Google-Smtp-Source: AGHT+IGa1uhTEJFoxnQBiuZRd5TCVIlWMs8Q6pstlSN3rogDlsUEsdrtJYdkP1xqZNrNL8psxveD/Q==
X-Received: by 2002:a05:6000:1:b0:37c:cca1:b1e3 with SMTP id ffacd0b85a97d-380611dcb75mr5913150f8f.41.1730135205833;
        Mon, 28 Oct 2024 10:06:45 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b1323bsm10089732f8f.9.2024.10.28.10.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:06:45 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 28 Oct 2024 18:06:42 +0100
Subject: [PATCH v2 1/2] clocksource/drivers/timer-ti-dm: fix child node
 refcount handling
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-timer-ti-dm-systimer-of_node_put-v2-1-e6b9a1b3fe67@gmail.com>
References: <20241028-timer-ti-dm-systimer-of_node_put-v2-0-e6b9a1b3fe67@gmail.com>
In-Reply-To: <20241028-timer-ti-dm-systimer-of_node_put-v2-0-e6b9a1b3fe67@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730135203; l=1295;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=hSFWp27IFs8R/mtXYTZDTyF+KDUDuBjLR3DwK1+aO9E=;
 b=2WgFXXCVveFXjC4UEs/m3Aja//8HRNHEHDCSX8+CqiQIu8rShgEEodvNYiXQCD4s1ZcnTKOJE
 X5jzJDEbodgDXA1SKaJdvVY/FgCUTQt8zFglztTTpDEmcJT9ZwBe0TC
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

of_find_compatible_node() increments the node's refcount, and it must be
decremented again with a call to of_node_put() when the pointer is no
longer required to avoid leaking memory.

Add the missing calls to of_node_put() in dmtimer_percpu_quirck_init()
for the 'arm_timer' device node.

Cc: stable@vger.kernel.org
Fixes: 25de4ce5ed02 ("clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/clocksource/timer-ti-dm-systimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index c2dcd8d68e45..23be1d21ce21 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -691,8 +691,10 @@ static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
 	arm_timer = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 	if (of_device_is_available(arm_timer)) {
 		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
+		of_node_put(arm_timer);
 		return 0;
 	}
+	of_node_put(arm_timer);
 
 	if (pa == 0x4882c000)           /* dra7 dmtimer15 */
 		return dmtimer_percpu_timer_init(np, 0);

-- 
2.43.0


