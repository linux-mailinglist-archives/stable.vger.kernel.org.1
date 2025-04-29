Return-Path: <stable+bounces-137015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B7AAA0525
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8311A1A86A39
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 08:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADCD270ECB;
	Tue, 29 Apr 2025 08:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I9m6ZqG1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A399A2741A7
	for <stable@vger.kernel.org>; Tue, 29 Apr 2025 08:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913718; cv=none; b=hiVBGg/1OCrJIOIIewtwmPStxD2tccHb8P74h4Zm/l147YzLILheeWnpIokdTWiT43gJNYV81Q9Z8INw+/ycc8gRZ1mtyq6aWwTbKFQqBv8rbd1vn4smyFvklViAtQyoEoqZPJnizQr9FkDMF9IZopawaO2mH7vMQOixp4PXgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913718; c=relaxed/simple;
	bh=i4D2fLb9l39eZwa9cP9BYksEmnH3HGmwJIKkBvUeQRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzrshrwKbD3ZANYHs1LGWlBYEzb3XsTSMED25X2RDBHgARiCXa4mDw7En6fe8LYM+mxQ+IKBVhBgu6ZAk0EZH0GMlD30NMqq8khLc3TfgpKCg5kMhOd7HTI4YhUJXdW4yV3E34zGvbQMaJ1agMTAl5+5En6FMSDme1KOIr2rDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I9m6ZqG1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac25520a289so900609266b.3
        for <stable@vger.kernel.org>; Tue, 29 Apr 2025 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745913714; x=1746518514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYESPz60KPmz/6nGotn0AYzGXhDOZzhH0VjMe+8UrTo=;
        b=I9m6ZqG1HYv77W2/9xHetNy4msOSklF+K2w+hvCmp5bLEAepZfm2YNv/2JkF6dthmZ
         0n0YngiSzqj2HGqBoIV6NGYFaGu8c8YmmgQHc52k3W1HZM8Oy/hX9pzUB2BI4pP33l3Z
         qvZGzXhyuMw0O02f6Z3XSADuh+KCJaY+HJtfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745913714; x=1746518514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYESPz60KPmz/6nGotn0AYzGXhDOZzhH0VjMe+8UrTo=;
        b=qcRcU30DwPThIrECxP3ewIm9Y4bEAxbJvkqzaE5GI24XNcuBzz6aP5dF7pMtO7+LPF
         XhSlTr8OGYw2EnLFw8oVXa7LPrCR/Uupv6bjNKJtvRakeDshlAW9ofiziT4pqzFddQTy
         aH/xgMn+Qv9rRO1d8UCT6PQxuGisf5rh2ewdUVAiDM04+uBPcru8HGSpIA9/u0ndGAzM
         nKu19HUcyqZ3p9Tp2cTN3hTV+REWQEdMMXxXHar08OqSuTS1ZLbJFuxhiVi1EYoh68WF
         R4DUvA0FcOIHOX+xrHvBEAiO6uAVn5dSVtIOvKUfNlkYWjkOTtsBs5w8QLWdLSMwjMjk
         cpyg==
X-Gm-Message-State: AOJu0YwRaFbcrHwrDrGPVj/xiCg0/2mWrhDjGPakmHIxzimbRnJuWqwY
	vD9M6I1Zj1xVhs0bGeS5w4nXzFcnLUaBVVw2usPM34lPX5W56j+gnUdPkC8V0MkK97/YttjLnzq
	iOGJm
X-Gm-Gg: ASbGncuKHjIVOTDHNepgUtNKQeLbPP+5qpP8CTHA35cKyS9RoF49Ic85UKawDwwSNUu
	Ht+7vGaDriGxhYFesiqNKIc9UdubUxLpUCtQBwgBm3cuuk0M7ZtQzp77oXiveG2ZqLC5yCvbKhV
	rOtaM/UOSNdY/ItOySl5EgUVJjRVEPeCijSV2XmrkLETQ9gfGfFfBBvqnU7Dgh2Rc/kmn3BqeIp
	zDzWHm4mNSPOvl7P9oSJavEYmoo8X2zMeFawF/IKRe/h+xP5rpP14ZjBaD8TCmrV28rsRrGT3mu
	4cxJZGZ6p1CJfhudjZE7ZJ2EbWdblfdXNBUX12P38DZJUH8H4YuUESSwRvxscLrNa6wpHrTEJne
	EcsjXb5RadjFz4qWQg3qBaH8P20sLqRuSvGTNidsXkA==
X-Google-Smtp-Source: AGHT+IHNmXou7G//gRoPD3bqqlTbDjGyeEAPq/Xv/t/NO3jcoFSBwduBGHa6CadekxsJ940hNboM0A==
X-Received: by 2002:a17:907:9446:b0:acb:5adb:bd4a with SMTP id a640c23a62f3a-acec4b41c5bmr286518866b.12.1745913714544;
        Tue, 29 Apr 2025 01:01:54 -0700 (PDT)
Received: from akuchynski.c.googlers.com.com (37.247.91.34.bc.googleusercontent.com. [34.91.247.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecf9a47sm746455266b.104.2025.04.29.01.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:01:54 -0700 (PDT)
From: Andrei Kuchynski <akuchynski@chromium.org>
To: stable@vger.kernel.org
Cc: Andrei Kuchynski <akuchynski@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.12.y] usb: typec: class: Invalidate USB device pointers on partner unregistration
Date: Tue, 29 Apr 2025 08:01:50 +0000
Message-ID: <20250429080150.2029822-1-akuchynski@chromium.org>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <2025042838-staple-purr-ea46@gregkh>
References: <2025042838-staple-purr-ea46@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid using invalid USB device pointers after a Type-C partner
disconnects, this patch clears the pointers upon partner unregistration.
This ensures a clean state for future connections.

Cc: stable@vger.kernel.org
Fixes: 59de2a56d127 ("usb: typec: Link enumerated USB devices with Type-C partner")
Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Link: https://lore.kernel.org/r/20250321143728.4092417-3-akuchynski@chromium.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 66e1a887273c6b89f09bc11a40d0a71d5a081a8e)
---
 drivers/usb/typec/class.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index bdccf77260e6..3bdecfd918af 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -966,10 +966,14 @@ void typec_unregister_partner(struct typec_partner *partner)
 	port = to_typec_port(partner->dev.parent);
 
 	mutex_lock(&port->partner_link_lock);
-	if (port->usb2_dev)
+	if (port->usb2_dev) {
 		typec_partner_unlink_device(partner, port->usb2_dev);
-	if (port->usb3_dev)
+		port->usb2_dev = NULL;
+	}
+	if (port->usb3_dev) {
 		typec_partner_unlink_device(partner, port->usb3_dev);
+		port->usb3_dev = NULL;
+	}
 
 	device_unregister(&partner->dev);
 	mutex_unlock(&port->partner_link_lock);
-- 
2.49.0.906.g1f30a19c02-goog


