Return-Path: <stable+bounces-6782-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80255813F9F
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 03:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104F71F22C56
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 02:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC7D7FC;
	Fri, 15 Dec 2023 02:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBsq9JRr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D577E4
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 02:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e302b65cc7so1302177b3.1
        for <stable@vger.kernel.org>; Thu, 14 Dec 2023 18:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702606537; x=1703211337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MfFN7cziiBppeVwwkUo8COprfLlyb4b+F5ysp7Ieuw4=;
        b=uBsq9JRr96FOUiHR0jZIgaks8WVv8EYuqL0DfZWp4a0VpDqBU9p4VSdqB2dh2yKfWd
         LyjldCto4WUGoD/u1jqen1DSk/YPsiJbfo1UmTPwdGZrlBNiNXSuWaQZ5cun/z/JAaiI
         NxyMcyaGnvyg6EpuwT+mNO0lmDk+LfEh8vr+I9Z7QcgofgMvGSTnJV5jxpH/YiuhkWkM
         zQxS8+X+NFsF+hgEIrBCVGTRHC9zmP/yvoVrldJQABYhE/7zKppmZ/UE3bMJ56R0qru6
         x+fwIEeEj3Sc0aFVbc4xtTljJvrLbnQR+czViq+xM1beztoiRqNmWwD3BuAMsd5TmKPR
         9xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702606537; x=1703211337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MfFN7cziiBppeVwwkUo8COprfLlyb4b+F5ysp7Ieuw4=;
        b=btwIK9C1zujeTstGew2M2oloFhOdCiEiEdeZ+2gvrVYmm7CHO4Gk8GvkdC8Y1uF+r6
         RpduH14rozjc7qmE5D+FZq/LguTWStZXvkfozmj9HMaun4iAY9ABY5jhdeDA1OETE1BI
         L0mzG9yb8e3bPCneFBPE93LNSSykXh64Fmi9XmQV/PUgTMafKfn/nVS+JY4WAcKpqW4u
         9gPiNH6aP9KPZiQ9cVMmIczUJMlReeeOI1y1TLsYTWcUo4RTpix0QE0bdXqqp2xoGYkB
         ++sdkH63JJ9Wh3YhsOMuDX/KBAKhefsSoKL9fah9j8dAg2aIvgz9NJDIMR0vM8KT/zTh
         p7AA==
X-Gm-Message-State: AOJu0YxisLx1mwqFIYSe0I/oJN4mzrEQt3OZiu+Tvsv1pJTOAuaYsUWs
	cRyAb2RTQH4AUlVWaQ6l8phG1jf74/+OMBU5VcLUIMTs5bZS6DUdh+u9g7kynxJAe8DizHhAC/O
	3tlgaBliS7hbESECXpXkYR0me95fKGXb8DCh39GIdSb8HgZSGBhkUSeI+cigWjg==
X-Google-Smtp-Source: AGHT+IGJOcD/ozJC/Sx5qUuAG1Sb09fkeutoCvahKlOeAE+R4aRm6wfQJ3xT763pnF6rX9sXrtZKh10yY20=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a05:6902:1812:b0:dbc:cc25:8ab with SMTP id
 cf18-20020a056902181200b00dbccc2508abmr49876ybb.4.1702606536700; Thu, 14 Dec
 2023 18:15:36 -0800 (PST)
Date: Fri, 15 Dec 2023 02:15:07 +0000
In-Reply-To: <2023121132-these-deviation-5ab6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2023121132-these-deviation-5ab6@gregkh>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231215021507.2414202-1-royluo@google.com>
Subject: [PATCH 5.10.y] USB: gadget: core: adjust uevent timing on gadget unbind
From: Roy Luo <royluo@google.com>
To: stable@vger.kernel.org
Cc: Roy Luo <royluo@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

The KOBJ_CHANGE uevent is sent before gadget unbind is actually
executed, resulting in inaccurate uevent emitted at incorrect timing
(the uevent would have USB_UDC_DRIVER variable set while it would
soon be removed).
Move the KOBJ_CHANGE uevent to the end of the unbind function so that
uevent is sent only after the change has been made.

Fixes: 2ccea03a8f7e ("usb: gadget: introduce UDC Class")
Cc: stable@vger.kernel.org
Signed-off-by: Roy Luo <royluo@google.com>
Link: https://lore.kernel.org/r/20231128221756.2591158-1-royluo@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 73ea73affe8622bdf292de898da869d441da6a9d)
---
 drivers/usb/gadget/udc/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index 14d9d1ee16fc..7b3c0787d5a4 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1353,8 +1353,6 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 	dev_dbg(&udc->dev, "unregistering UDC driver [%s]\n",
 			udc->driver->function);
 
-	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
-
 	usb_gadget_disconnect(udc->gadget);
 	if (udc->gadget->irq)
 		synchronize_irq(udc->gadget->irq);
@@ -1363,6 +1361,8 @@ static void usb_gadget_remove_driver(struct usb_udc *udc)
 
 	udc->driver = NULL;
 	udc->gadget->dev.driver = NULL;
+
+	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
 }
 
 /**
-- 
2.43.0.472.g3155946c3a-goog


