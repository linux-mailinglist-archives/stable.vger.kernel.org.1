Return-Path: <stable+bounces-106768-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2EA019A7
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 14:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDD73A2F90
	for <lists+stable@lfdr.de>; Sun,  5 Jan 2025 13:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721A714A4C1;
	Sun,  5 Jan 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+9gsDVQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C66849C;
	Sun,  5 Jan 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736085173; cv=none; b=SYS7kmdw5DXvVip5pCRRqoLmbMVju447TNqXz9LMHxEFzNiDBVHue9aiiM4C0Sc1PFfWdePbTaXnR3Y7i8yJufk+3w3uPtn8LUdwUNkiUh/wFUJ59PTr3DnkbQiCv+ojHt0feextOzp/KO4CKrqNN0RkMeG3JzLdB0UCfVo6rOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736085173; c=relaxed/simple;
	bh=EqhZQDp+46jnxAY1QEE3mBanMieesPMflQDgul6IYw4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=F/Wk4PZbZA94F8E6SjzjKLSR6CNo1ISHEHtMD5/Nw2RADEoMNg9ZDlgX9grFpyFf5j/JvVyy8G1LT1hFpNSvYqwpBSJJ79fGdX7E+BYLku7yuvgqLCVDkAV4zsXkyPAnaehIuRdMkzaFNSsz9pAJR8C/L4k6UfMbqcQBjcr6Uyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+9gsDVQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2167141dfa1so188691125ad.1;
        Sun, 05 Jan 2025 05:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736085171; x=1736689971; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zg+OCegskbKR9W29XIULpXmP2nGSHp9dG3YHhiOunGg=;
        b=Z+9gsDVQwC3NHg534fB/a/qpE6AekVh1N/zpUCbRAs1TApDL9/bY1tZ0OZkY3C8aSK
         CeJDHKG0H8MeJIS1bs1gk67Jhtj2z1EqUNCWa1no8rCsaN8HVFtVJwyv+CVnNs+4rKFF
         kv55v8jKJle/fuWNev7Vvn4WJn/sylf3/eLy7+88CEtXlw0IajxhfkJg1UZSlhvN6/ZN
         uKGX0XjyxcHrlG40+INyVSJoHUB0ShR/bnCFisrDzmE5AIC+Pnpb6uJd9Zo+7rGrcpuw
         45SBDVn8scmI7E8ZsXQ0GIvQm7aF3RFxj0B0fp26uKcvWFad5lYawGXbCg9gKzIhvBLg
         GK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736085171; x=1736689971;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zg+OCegskbKR9W29XIULpXmP2nGSHp9dG3YHhiOunGg=;
        b=gsmJmyL5OgIh3EtcSfNAmJBFoELHv5FTt1VsXSwiJecurIPFv+jr+d/OZuKqOpwns9
         sAHr5qAI5MS7WaEwh1gSuDt6BwfMSFV45xkGvrc/p6dt33dqVxI2wqBDQc+cDurSU6/r
         H+OxiJd5LTRCpak9rRiM+8LhDQxCBW+1iI/aF4zoKFgpfT9PbpQZbZfTeXTbtEmFjUKx
         Xu1hzL2JsDuDJzpnPuV5b9uEVJ62JrBo2kpEZsUTV3XzGclmi0VRvkhg9+F+pClzpDMR
         d+gxx+Dq5YI2vrmrLg/tU6QjuEINaisPZLF2/u1wrHAElkXmGA589bmg7G+YH+KfNjq4
         acvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUDbcsYkD0Vl9rmLcS9kQPgpWNmk4fF1+WdoIVkfafB59AFWnjFZDViYEfs3av67RGa7jUs4YHuwHpFS4=@vger.kernel.org, AJvYcCWhOzR7c7JUy9NtPSJo6V+8ZDm5+ZAeuCrAeqQTC3nv/ol7I9k3MTuZIeoc++BllEUT61r6hf+b@vger.kernel.org, AJvYcCXrVTUWDUElOUxASdlutpkfzHP8Vodf7IaOGkiZ7Sqb8Jf1pgodWQtCQKi9r3miGyPUgxwfO1UQpPVS@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ4i3Yqmiq+iNq9U0+fDITzoGD3/AIKcNQmBLz/Rk80FN77IMa
	xsvk51h1Q9hlliHkaFgh7avfmSztOz4hW1+kZ8lCeF+ECBJ3jn+f
X-Gm-Gg: ASbGnct3ARrjVKKctA0A9D5X68CvlXvB5hipC2rw9yKo0kaqd+yMvD2jLizXA3Wuf3G
	S6vSAsDxR0R3OmqEYW8pOxLc5MdQ+IOmPxCFxpg4jxl/mXLWXxN/oBr/UCwXAhM8LEhUPNclO3A
	Xq6neM+l3wSh4z9NgH4Jh3m+rpCl2bAhH4YByu8dEPRkgPU+WiW/MOkVGvsaCe15al6KrlOdErY
	5VvYoY7ta38ZfP1Dp/WCXR/XVCde0QQQjT+Cl1ZIy+sKl2hiGUVDuF1GbwTayr1lw==
X-Google-Smtp-Source: AGHT+IF9aa+/n/P1e52WJrm2tDiAs0pfSvtan8BbEc7FRWepP7BA7gWzULCcf08TQec5Uy/RspwZuA==
X-Received: by 2002:a17:903:191:b0:216:6be9:fd48 with SMTP id d9443c01a7336-219da5b9c45mr718262185ad.3.1736085171115;
        Sun, 05 Jan 2025 05:52:51 -0800 (PST)
Received: from localhost ([36.40.184.212])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02955sm276320265ad.266.2025.01.05.05.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Jan 2025 05:52:50 -0800 (PST)
From: joswang <joswang1221@gmail.com>
To: heikki.krogerus@linux.intel.com,
	dmitry.baryshkov@linaro.org
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] usb: typec: tcpm: set SRC_SEND_CAPABILITIES timeout to PD_T_SENDER_RESPONSE
Date: Sun,  5 Jan 2025 21:52:45 +0800
Message-Id: <20250105135245.7493-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Jos Wang <joswang@lenovo.com>

As PD2.0 spec ("8.3.3.2.3 PE_SRC_Send_Capabilities state"), after the
Source receives the GoodCRC Message from the Sink in response to the
Source_Capabilities message, it should start the SenderResponseTimer,
after the timer times out, the state machine transitions to the
HARD_RESET state.

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable@vger.kernel.org
Signed-off-by: Jos Wang <joswang@lenovo.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 460dbde9fe22..57fae1118ac9 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4821,7 +4821,7 @@ static void run_state_machine(struct tcpm_port *port)
 			port->caps_count = 0;
 			port->pd_capable = true;
 			tcpm_set_state_cond(port, SRC_SEND_CAPABILITIES_TIMEOUT,
-					    PD_T_SEND_SOURCE_CAP);
+					    PD_T_SENDER_RESPONSE);
 		}
 		break;
 	case SRC_SEND_CAPABILITIES_TIMEOUT:
-- 
2.17.1


