Return-Path: <stable+bounces-159156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BBAEFE8D
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 17:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CE83AC847
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E927A46F;
	Tue,  1 Jul 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="Beb2niim"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEF8A926
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384496; cv=none; b=Y058SO2NClMauzfHMywIlwNR3Qn3RSGHfXeKsm82ZJoEFknp9t1pbjt/zEK/gDe/DSWTE4nYNpb2weFPx8EY+YB1KXVrID+Dv7POLJztCbHlq6lXxTNGYBRJy7fK0sLWZP0SvxGa1JK5UczL6bntWkx0SyQEWKgTz46ms7JdtbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384496; c=relaxed/simple;
	bh=vssQDmpqsqtEsVZ+J0Rxu/Bc2+tTBwvSxd1dgCxlXZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rv/+R0kYU6e4HJ3KMRnJ0BcMs9infFyiyV08N9gULrUvNiBfaVK970Yo+nuJ6Za5GD+D5xbhingMSRwHHEUvxLYPj2c7i0kdsTjw9HwgEB5fsWYgNVWJ7D6Al277NBFCpIhz22SvjdPMQ34/CQDqX+5Lvgcy5eqVMKGhPKJlUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=Beb2niim; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748f5a4a423so2164717b3a.1
        for <stable@vger.kernel.org>; Tue, 01 Jul 2025 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1751384493; x=1751989293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59de6pmFOQy/rScsXfRhVQYqTrbVpesPpP5fOBkEBh8=;
        b=Beb2niimVluHZ09GrFiQXJ99dprdGuW82OxY4ID53EcM4S4SkLtL8Y/kafSu1WjAir
         sTttOBlxOW9i4Re8i8k0bgdm1OELc8LFMrOQVBjj+H+hFNgNmxuIXSBp35pDLNSUzOjz
         sHe5WOzapa5jGF7zJJgWGqJE5SCoHB2MGPkIr/bCwEZ4bbug8FrXrB/RZ8ndsiWN4TXz
         W3JoGOhkbg/37W2mDGUFfZCCgh1DT9PQQwW2+QvTwSDlUa3VI/Fqj4OTXuvKOTYmejyU
         K1xdsqH75/Wu2JQP//d/iv7BR8oKHbqXJyZa/5CjoDJRygf9Bvl1iX58qYVPs0XVz5nv
         Za6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751384493; x=1751989293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59de6pmFOQy/rScsXfRhVQYqTrbVpesPpP5fOBkEBh8=;
        b=g22voEfvB45C/tWxDPVslI+skJm3mzj/U3eLYu6sFOLdD2r5iKUG/3haPtAgKJ2YYn
         w5wnRunxrzxedlfxfASxIrrH0dfN03dTWl+4IlaBQLs8kL4l1jnL2efdkIKiEzK6G/Sa
         ZXQ7e9jOV0tZIrIScc8LjkKMZb5JdIWs4Y8EhoXTUECxsv2qdTzMkSfS4CyA8bR+fKks
         xCg2fXxo+qG/ELowLU12UHX0PvRLpZJYE9SniEmGJTu4t/QLCNt9tcCnWrW5pGYhBAVN
         BbNhhwnJPlFY91Sdh/LMI29LNiQ3dVqmnG/MeSgHXbdd753uQM+ornnuPBg/FIWffT8o
         9luA==
X-Forwarded-Encrypted: i=1; AJvYcCWFDRrsvdXf1cCCVDK7PZSk+Q5wDYhRU9r5ZUWahmeTYnRFe7hECgsdGS56Po+sWRS/BqjXJ7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2IizPzhnED3c2jmy/NH2PbexZguh2SurgadFCA5wgLVN2/o+
	vP1yZabHh3k/vjlz0r7aA869wnns+A0ZpsV4CGSsmQx6jYzFKtuBfR+mIiVCD3jv4w==
X-Gm-Gg: ASbGncvswz5pdtzb5GZiqw+DGSuk/NX5Dc0A4CUe/2wvCFqqZvOOSCMqDoUYX9GQxXu
	0IzezhqloHhRC+XEAAzQ7pu+v6lTX1BB2uk8r0TjAyKfcdlg+TNNiL1liuMMnA6dsy0xKxPu38l
	tDmmLtkFuSkjmJiqaz00YN2TUzEVWQxS9utXBPi+FLJVQ7H5l2Jd6IOx12vPi/HtJXT2SwTuAIx
	zSLHSQjr0sn6Rsgsh9yNBYxjQ04LCxMSDutpn+AtbAgX7HuES/OQn3dyFRIY3o2QCyHQ7o401h2
	GvLUNX6g8CFh30q3C9A9OAi5PbiJyBvUKob9wtaH9YnoMocUJ+cnUXqweefWkliUeKouCfUe5bZ
	DHD+2P8OvvpVFZSw+FNE65hy+91YffCNx7PZWZuLc4fr9ljT7CIVLevwBPbEYlt+UN1mTepg=
X-Google-Smtp-Source: AGHT+IEclQh5sNqNxGCJ9QcJrals8daG9Os0Vgw+JP1Dhlzs2OqOepPslgK8FbWpG+V5py//MrkbPw==
X-Received: by 2002:a05:6a00:2447:b0:742:a0cf:7753 with SMTP id d2e1a72fcca58-74af6e892d6mr27354642b3a.3.1751384493356;
        Tue, 01 Jul 2025 08:41:33 -0700 (PDT)
Received: from system.mynetworksettings.com (pool-71-126-161-43.washdc.fios.verizon.net. [71.126.161.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5806b52sm12574910b3a.169.2025.07.01.08.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:41:32 -0700 (PDT)
From: Drew Hamilton <drew.hamilton@zetier.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bin Liu <b-liu@ti.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drew Hamilton <drew.hamilton@zetier.com>,
	stable@vger.kernel.org,
	Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Subject: [PATCH v2] usb: musb: fix gadget state on disconnect
Date: Tue,  1 Jul 2025 11:41:26 -0400
Message-Id: <20250701154126.8543-1-drew.hamilton@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When unplugging the USB cable or disconnecting a gadget in usb peripheral mode with
echo "" > /sys/kernel/config/usb_gadget/<your_gadget>/UDC,
/sys/class/udc/musb-hdrc.0/state does not change from USB_STATE_CONFIGURED.

Testing on dwc2/3 shows they both update the state to USB_STATE_NOTATTACHED.

Add calls to usb_gadget_set_state in musb_g_disconnect and musb_gadget_stop
to fix both cases.

Fixes: 49401f4169c0 ("usb: gadget: introduce gadget state tracking")
Cc: stable@vger.kernel.org
Co-authored-by: Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Signed-off-by: Yehowshua Immanuel <yehowshua.immanuel@twosixtech.com>
Signed-off-by: Drew Hamilton <drew.hamilton@zetier.com>
---
Changes in v2:
- Cleaned up changelog and added Fixes and Cc tags
---
 drivers/usb/musb/musb_gadget.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 6869c58367f2..caf4d4cd4b75 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1913,6 +1913,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 * gadget driver here and have everything work;
 	 * that currently misbehaves.
 	 */
+	usb_gadget_set_state(g, USB_STATE_NOTATTACHED);
 
 	/* Force check of devctl register for PM runtime */
 	pm_runtime_mark_last_busy(musb->controller);
@@ -2019,6 +2020,7 @@ void musb_g_disconnect(struct musb *musb)
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
 		musb_set_state(musb, OTG_STATE_B_IDLE);
+		usb_gadget_set_state(&musb->g, USB_STATE_NOTATTACHED);
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;
-- 
2.34.1


