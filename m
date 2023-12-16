Return-Path: <stable+bounces-6857-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFAA81571E
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 04:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5421F25A5C
	for <lists+stable@lfdr.de>; Sat, 16 Dec 2023 03:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B1D101FD;
	Sat, 16 Dec 2023 03:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eceb7rIs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B76FD8
	for <stable@vger.kernel.org>; Sat, 16 Dec 2023 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5c627dd2accso710042a12.0
        for <stable@vger.kernel.org>; Fri, 15 Dec 2023 19:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702698222; x=1703303022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ejamfelkmThXdmiMH7xDujYdMZ8xHKUQpSO5wh3pdx0=;
        b=Eceb7rIs8bM69TfukcjBZoKCRWgojJkHk2deH7sbI/fLDd6VdOVB0R3oTceh1flGK/
         jgLqX5cXX58F1nZzb5BSg0YbtJjIpG4y3sg56fzFjqBGGPN+/uEQkQSvCIp4peFvqV53
         ih4mR3X9Tq51oVOdHQIU2XIvHI2m7wHVApqKR1SgnWtqJKOGp6W4U8H89Y2Y0qHPxtXM
         0EZpTnDlVeDFnVff1QpawbslBDVXrqjDPXrdfYlbd2iRntQiad71Ni06xMSpTBNFix6o
         1lXj3bd7PLLDuIjELtk/tMz/si98zwkIwpR0tzAHz76jYLORJz9WSjSP6YZ9pHJPJNL9
         L6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702698222; x=1703303022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ejamfelkmThXdmiMH7xDujYdMZ8xHKUQpSO5wh3pdx0=;
        b=QHigNu2iOzAWVfYfnMRk+MD7dL8mGKYIyvd2LKRx6LIck9S8sxLLo4PvFG7jULAQVv
         EM1QgkL2yAmpxCDMCDLwC0I4Jp4F4RypdrYDVK82SqHKMVi13r5lkNduNoA4HAMD7tWh
         dm1RALRdY4oQ7ZIzBJ6DLOyigs85NAq6iUbao8ED+ECAX9t+PhxDZD6A5rVg/zjw+NcH
         9Jt6JZSTXsnj2X+PiuMV6tIyDKe04CPGcv2EbbhcL3uySvl51zFyu7CExyy+fjla5AoJ
         N0Eb1Rlnh53I3IKCjulmMbpSpdZT0QEyhO0A1MN8H3ynhKM85Z/mmUkCXyBkABJpw3In
         vxbQ==
X-Gm-Message-State: AOJu0YzcFIbzZUHjUUYi4ZK74S65Skn2beAmbZAi0iFqwYkpHM6jQ49N
	1v7Za2qJhOZ0sKwr3oZM/LeFlANTFDs=
X-Google-Smtp-Source: AGHT+IHvf6FdvhAGUR9XlI2m3PSKlU4ejWDkmN1KgedPAk8CoZavhLVTEuPUZFZbjBjTicRhD+1I2abmoFA=
X-Received: from badhri.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6442])
 (user=badhri job=sendgmr) by 2002:a63:5c07:0:b0:5ca:4440:234c with SMTP id
 q7-20020a635c07000000b005ca4440234cmr738217pgb.12.1702698222327; Fri, 15 Dec
 2023 19:43:42 -0800 (PST)
Date: Sat, 16 Dec 2023 03:43:35 +0000
In-Reply-To: <20231216034335.242168-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231216034335.242168-1-badhri@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231216034335.242168-2-badhri@google.com>
Subject: [PATCH v1 2/2] usb: gadget: Retry populating usb-psy when null
From: Badhri Jagan Sridharan <badhri@google.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, raychi@google.com, 
	royluo@google.com
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Badhri Jagan Sridharan <badhri@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch allows populating usb-psy where usb-psy comes up
after dwc3 is probed. Retry populating usb-psy when dwc->usb_psy
is null while dwc3_gadget_vbus_draw() is executed.

Cc: stable@vger.kernel.org
Fixes: 99288de36020 ("usb: dwc3: add an alternate path in vbus_draw callback")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/dwc3/gadget.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 858fe4c299b7..b3470a5e5e26 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3049,8 +3049,11 @@ static int dwc3_gadget_vbus_draw(struct usb_gadget *g, unsigned int mA)
 	if (dwc->usb2_phy)
 		return usb_phy_set_power(dwc->usb2_phy, mA);
 
-	if (!dwc->usb_psy)
-		return -EOPNOTSUPP;
+	if (!dwc->usb_psy) {
+		dwc3_populate_usb_psy(dwc);
+		if (!dwc->usb_psy)
+			return -EOPNOTSUPP;
+	}
 
 	val.intval = 1000 * mA;
 	ret = power_supply_set_property(dwc->usb_psy, POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT, &val);
-- 
2.43.0.472.g3155946c3a-goog


