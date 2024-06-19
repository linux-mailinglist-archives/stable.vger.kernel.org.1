Return-Path: <stable+bounces-53686-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507EC90E2DE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 07:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6517DB23703
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 05:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7991657C9F;
	Wed, 19 Jun 2024 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwwvRfkb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB63D48788;
	Wed, 19 Jun 2024 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718776119; cv=none; b=YKUCoFznILvncVgtmKp4VaSNE7YAg2DxKXXeegg6DfgHffcwpD2rj2POc8d+jRAdVanRFqL25RzLUHurCv8loK+FjAaYe2LW8B/01GF3Rf6yiteFotqMWV2V1oS9DlJhXySwbb568bOZmHq4Vhz92BIi5uxwvjT37dMUD3rqUec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718776119; c=relaxed/simple;
	bh=HG2uYDQDA5LUfb3Rj3XK64Qm99gLTPvf8sYWfoqAnhk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tdae1bIwmsKkirhwN5e/FSmDpwdUafKrJyPXjxKOKRlC+ad+ye1a4nveosn4PdNS6k7nmvsex89POt87wahKZwaxhwpXQNJlBqjqlcdOt6xgLFmDoVXPelQ62IeWPkZhVpAFJ0kjWSIkrBA3hux59Yn3rfWHKC5khfJEFvCnfhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwwvRfkb; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5b3356fd4f3so576328eaf.1;
        Tue, 18 Jun 2024 22:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718776117; x=1719380917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=txDixZDYkb0sMcFIHxT8WMusXak2eLUjpnDzHabgDBE=;
        b=OwwvRfkbl+idmWMEpAhToSW4seW4Zi6+XkfGPocLn8pf8UDGvzS8N3UvbSRVbQ3WEw
         XNo1sgbU5S0lNxsvsT7BZlhE5AQg4AJjKPZvbvCrxGUydhlzMzSWPw1hdc5C6ZVDDTAF
         lNVluyMQTuX6/QT87yBtK0jaXsjJuKwRI3xsRlfzXW1KlU/AeK1/wYfxKffAI+SKqo7F
         lFt0pRkD7jpc6XwNrLnw0HHs+S4P1JQ0X1o3J6J44Fx3S4arvLSQGIwKvWd2aKUxC3Rs
         qCUvh7zxIJsUqsrX+FqJ92lTeugmjzmg6QhQ8gxiL55yyqPsQeOp94vcYELbxIJBIjWY
         iP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718776117; x=1719380917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txDixZDYkb0sMcFIHxT8WMusXak2eLUjpnDzHabgDBE=;
        b=EXSL+A9+UOWF3qWlFq/P/5XGxxnUteG4kphXXQpTCL8LvR2dp/TyRfX5M2LiWjydh1
         4pqoXs3vVAgYFTubtMMCI4ZvBJ1rXAcKrlz7ctOlPock9sERNHuDsAJySHJsnfI/DWeN
         WNZAJ0adJ1xN0l25eRpqQMetGaeQtznApS3hieH9FPhoJuwhl4wpSY7C+2tKUoJ3yHCZ
         9eaB8hJY0I+9vxeX1QJHjl0exdHOezO3Y+SUwEkBcYdirRmXZ71KnbNB0T+6B587U7Ol
         mSGogQDFDW75qfmcw1T3sow8BraT+hPqmtCZ3EvKbe1dsJKkZnraXKujTpN500AXOKiu
         O2aw==
X-Forwarded-Encrypted: i=1; AJvYcCXw1PuzVy5Z/QDbuhsCEI3D6p6K1KcUtjJzC2UYecH5RAOAmYv+6idmRkcASGBLtO5+XQO/e9VjNI/rL/O9agemmZl5EnTy9zuMUu9bXOfngpWy3JP9Sczh3CCjqAyBgE3vaM7s
X-Gm-Message-State: AOJu0YxRXplVmPOjRdaQYsEM6+GxD6zc48JISV5YxjMFLJFxkbM3TW5l
	o2i3zPBTQGTdLyk2BzhdY7o4PSYqIIjFYaifPg7h0k9EY+W7e/2K
X-Google-Smtp-Source: AGHT+IH2DZYYM+p02l6YA7ePfYsYNMkqQxWcnBW5NDw6XLpWlhn6DQE7a0VfVAeGIfezzOozyXcFbQ==
X-Received: by 2002:a05:6870:148d:b0:258:4dcb:7d48 with SMTP id 586e51a60fabf-25c943e5c01mr2108991fac.0.1718776116791;
        Tue, 18 Jun 2024 22:48:36 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d1f8sm9886592b3a.113.2024.06.18.22.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 22:48:36 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] xhci: Don't issue Reset Device command to Etron xHCI host
Date: Wed, 19 Jun 2024 13:48:08 +0800
Message-Id: <20240619054808.12861-1-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes the hub driver does not recognize the USB device connected
to the external USB2.0 hub when the system resumes from S4.

This happens when the xHCI driver issue the Reset Device command to
inform the Etron xHCI host that the USB device has been reset.

Seems that the Etron xHCI host can not perform this command correctly,
affecting the USB device.

Instead, to avoid this, disabling slot ID and then enabling slot ID
is a workable solution to replace the Reset Device command.

An easy way to issue these commands in sequence is to call
xhci_free_dev() and then xhci_alloc_dev().

Applying this patch then the issue is gone.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
Changes in v2:
- Change commit log
- Add a comment for the workaround
- Revert "global xhci_free_dev()"
- Remove XHCI_ETRON_HOST quirk bit

 drivers/usb/host/xhci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 37eb37b0affa..c892750a89c5 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -3682,6 +3682,8 @@ void xhci_free_device_endpoint_resources(struct xhci_hcd *xhci,
 				xhci->num_active_eps);
 }
 
+static void xhci_free_dev(struct usb_hcd *hcd, struct usb_device *udev);
+
 /*
  * This submits a Reset Device Command, which will set the device state to 0,
  * set the device address to 0, and disable all the endpoints except the default
@@ -3752,6 +3754,20 @@ static int xhci_discover_or_reset_device(struct usb_hcd *hcd,
 						SLOT_STATE_DISABLED)
 		return 0;
 
+	if (dev_is_pci(hcd->self.controller) &&
+		to_pci_dev(hcd->self.controller)->vendor == 0x1b6f) {
+		/*
+		 * Disabling and then enabling device slot ID to inform xHCI
+		 * host that the USB device has been reset.
+		 */
+		xhci_free_dev(hcd, udev);
+		ret = xhci_alloc_dev(hcd, udev);
+		if (ret == 1)
+			return 0;
+		else
+			return -EINVAL;
+	}
+
 	trace_xhci_discover_or_reset_device(slot_ctx);
 
 	xhci_dbg(xhci, "Resetting device with slot ID %u\n", slot_id);
-- 
2.25.1


