Return-Path: <stable+bounces-155333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0124AE3B08
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 11:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE1E18878BB
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 09:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F9235368;
	Mon, 23 Jun 2025 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSNnE7jT"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8CF22D4F1;
	Mon, 23 Jun 2025 09:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750672130; cv=none; b=Y1XSNQgW50eJ8lu/tRhYZZ28YmoahdTxV6qjLxRwGatJXZQAnWOYvxVcRdIZq86EDhsnlR+sEyS5neiZnDyOuX7Xm3pGmnrI7R84g00CeTUc7lC50BIRMmzqwfQnh/+m8lKbR7BFKqu4Fan2DipnYBpFZi0tuV31Hh7T1l/XHAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750672130; c=relaxed/simple;
	bh=aUq4zXmIfT1e6bZRpOF6LY6i6KXZIGnWXnsDEBudn7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BqcMfwvGkuM5Y5wSAjs4qRzK4jfvtGDybd4FpeQjJue3WqlKOuCoEtyPQeExJ3K9xnOse90ZquV2LDig8UjrsxCFuM8YIIhXbIpE1XSVcJO90XuDQeWDUIv7Mm252uf912N1PomNSGnfCxQITu/xmxV4Txha1lTBnL943fAHTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSNnE7jT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b31d0dcfea3so2696140a12.3;
        Mon, 23 Jun 2025 02:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750672128; x=1751276928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tys4sKkthmM9VQfU4rkGBYcXKHxzYmmZaSeoa+GQ4+8=;
        b=bSNnE7jTVYGG7UAlLYkWgAT7e/MRCmJsUy4DEhET3LjtCeDycVzu9BG8ddR/lJMoDo
         iCSX5eU4L1X6OIDh2ymgLqFcB8uaAI33FeDtjHx8YmVrF8QM6JSo8QlMGgMatnb/n9KH
         L+G812fns4EoRNN7/RRAt7u9fAmc+LMaJ5wlcU5X/O5JFJjSw7sV7xdDnTvekHFJeaDk
         m9hDzRJg0k2e/A1lVUfRdiC5/6cosgYrFg5OnPTfojwchn4Rlfp6F+2kFdgOU6E6rYNl
         jC5vPIOgi6Al1mBxWtxmnKK6Pk8/6bn8rv5XBNUfg+j+/9dcyo88w4Ayj4OohfsVTcd1
         zWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750672128; x=1751276928;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tys4sKkthmM9VQfU4rkGBYcXKHxzYmmZaSeoa+GQ4+8=;
        b=aefV5cN3SWdq1UDwa0jhhFdtY25gYTnXY8xfFSBDks3D9nJCHI4J0x+GED9tcdAjTm
         J8nuDRGRkwSh0Gf5VZW0uxqBVhs1XWfg/Eip1bx2hNvcxFhnr4jd4dTKeTsUhKSs9JxP
         KMVBzkQje8H2tlVRH8yWoWKymYD8ZRvltKnIkbTspvdnVERamX8n223peLEfd/AuE1jE
         /wpob5RaFe9qwQ6UEX5hSWovu/3F1UtW+65Jr0mJce0M11OZUrCXOq7HaWOvdJ7DSjsL
         N3BRg0/A0fBtHyS0C3aOQF5TFPuxYyK+9/xNtwXOkPQUu4PUxCzQTB8ujxAazq1rWA9P
         JOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2PrO6GypUR/PnYP4gopESyBzGOt0IX7tXQRD3I1851mFr2kX05dfYQsnuhJ9BvJkh3kfO1sk3@vger.kernel.org, AJvYcCVdxMBUfQkXbjseDLiQ6pDWoK1cajlpFvVs50Unmcm64YSFJAlehsb21wpiEG3PxYchV5eV2x1XGevknZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWafSFvdlIRsb4VEYagHk1YV5arbaOrFsxTBhqwHJupQnPZAlZ
	/MEY6mwNuyDeZEC3H3rJ8kQos3wg+UnGV0H3ZRlNtxQze/j8RLhZ+DgK
X-Gm-Gg: ASbGncv9sTkMnk3LzqAiYWJwH4JbjHHHQ1d7xgg1SuQGriqhAdunQ4VW7maXRQ0n+VM
	aMfKz5CE2e44Lvs2E9LvStP40TZn233iGs2j3t+eh49NVsGWa2N/t28cQxpvPsVkeJCQIT6IZYn
	FB2JBNOVZPjFLT6E3gxVr9Yut9VLtLLilQw/gtwS/4OWoXr4UdkrThf5z0ehsS6kNqi3o93wAsC
	ab20CwvYXaXgGXR7F9IXV0BYhOGSRWvzOvQoJB4Ep3AerGPsHRWMSSqFcZV1PExJj/tOXdhG6ka
	Op/BU+TY8eWnVVzKFLHNg++snkd9r7yRVdXV7JeVbu1cERkKleiwib/ptkBFXEc/FSwoLDr5gT1
	ksPGc0w==
X-Google-Smtp-Source: AGHT+IEPOyDRWeDPtjDIfkfimnRaHRtHdwNKxsarnW6qGtp9KVkp8z8toA9yz6I0u9v+5sAJOynMRQ==
X-Received: by 2002:a17:90b:5350:b0:312:959:dc3e with SMTP id 98e67ed59e1d1-3159d648203mr19515423a91.10.1750672128203;
        Mon, 23 Jun 2025 02:48:48 -0700 (PDT)
Received: from localhost (144.34.206.47.16clouds.com. [144.34.206.47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e07d027sm7652608a91.43.2025.06.23.02.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 02:48:47 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] USB: gadget: f_hid: Fix memory leak in hidg_bind error path
Date: Mon, 23 Jun 2025 17:48:44 +0800
Message-ID: <20250623094844.244977-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hidg_bind(), if alloc_workqueue() fails after usb_assign_descriptors()
has successfully allocated the USB descriptors, the current error handling
does not call usb_free_all_descriptors() to free the allocated descriptors,
resulting in a memory leak.

Restructure the error handling by adding proper cleanup labels:
- fail_free_all: cleans up workqueue and descriptors
- fail_free_descs: cleans up descriptors only
- fail: original cleanup for earlier failures

This ensures that allocated resources are properly freed in reverse order
of their allocation, preventing the memory leak when alloc_workqueue() fails.

Fixes: a139c98f760ef ("USB: gadget: f_hid: Add GET_REPORT via userspace IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 drivers/usb/gadget/function/f_hid.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 97a62b926415..8e1d1e884050 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1278,18 +1278,19 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 
 	if (!hidg->workqueue) {
 		status = -ENOMEM;
-		goto fail;
+		goto fail_free_descs;
 	}
 
 	/* create char device */
 	cdev_init(&hidg->cdev, &f_hidg_fops);
 	status = cdev_device_add(&hidg->cdev, &hidg->dev);
 	if (status)
-		goto fail_free_descs;
+		goto fail_free_all;
 
 	return 0;
-fail_free_descs:
+fail_free_all:
 	destroy_workqueue(hidg->workqueue);
+fail_free_descs:
 	usb_free_all_descriptors(f);
 fail:
 	ERROR(f->config->cdev, "hidg_bind FAILED\n");
-- 
2.43.0


