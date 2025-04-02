Return-Path: <stable+bounces-127400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5B6A78A73
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 10:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4D3E7A33C9
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 08:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC2F23535D;
	Wed,  2 Apr 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts9DatLm"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE4C1514F6;
	Wed,  2 Apr 2025 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743584359; cv=none; b=iK88nYM535IHQTc5NlX/Bel9Wc2ib/RqhTErFcLyTX76NggY8wZSmyspxqXjfcOaqmdEBIIhkkC27J0QKyDH2eX1SujLii4/AyXOq37fV+YMUXoqV6lTXOiYePTR9FY/Sozakk48WeBfWku+2Sa2tW/5FXuQ8SNMy3pqN0CqIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743584359; c=relaxed/simple;
	bh=zvhBFDJD/NQkSOSdd1xN85qPAdYMy5AaqSXyRKKDQho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hc+ZU9sEyU9TuPvEIhlBVErbpJc6amGjVSGXQn6/ooQd/PORXxtLMCi7I8uyK9HQ4B/64oqi7Eu8pRAak2NeVapzkUD45StbxkfOpcTNcNLKdhZWecxIJYRtnbSVZwZo1wZx3y2MrvKErV13JMZBLofXdLo7nrBGbTYv+WZuJv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts9DatLm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22438c356c8so124605365ad.1;
        Wed, 02 Apr 2025 01:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743584354; x=1744189154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJPesJ9u7hxBIZyJ3YQPpH4TNpyDS3MW5BiB4rLe8ZA=;
        b=Ts9DatLmavymJS8Z01KF8PmqVHVMjt8/GNMsFRjBb7q0Vx7AuCFFGaNiCaeNuj2Lnp
         fd5C+Xc9hRILAUJoPpnRAwIzYmmeZvqDYMC+fdzEKrotr3Wzp1pjh6t9RXnhrcoh+ymG
         YnlQPm0fEHDvVEvLQkTWlk0SPuMmfCzs3zeYyAQKQfRaJx95yd0n1iZM6Rps2g5kJaVi
         s110KAffD2tPZA4SzffL2cSqooIX89TuUNl46u+MHMSuGS9QfasAYi8At8ib0HO+P1ct
         nclhV+hNjg2mqK1tU+wq82Dpw3RlWlPTb+7uKR6FiHuh8n1d3F6iBJEP5CvbCs3JalM5
         P5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743584354; x=1744189154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJPesJ9u7hxBIZyJ3YQPpH4TNpyDS3MW5BiB4rLe8ZA=;
        b=haturW3xJUSO4z/WTIlZt4C5qS9bd6fJCFIk32nJrdSIeOUjetmSCl2xWsT2UdKOfB
         Wufp14R7sNFYUfq/MuoAveqPa+t1qZYuUwgSFSwEQDsM/1maVFB/tNQePQxr3Ushie81
         7jLCOksd0VvtsU8yeNz1bDDejwcVjz2AXqVq83nvnQH+pOD7NgivQHvZW3+jMgcXbeYA
         xFS99s3OuQtOjl0QzmYlkPO+C5WXsZHOiuM1SRePEHX3pT4HFZziMhxL2QZxoC4j7wRi
         xfsWPKfoVOs00r/v3fizDxvX67E5TvRlKTQ35MRwiNR5RmoFd0kP8KHmGEEt09kkacpR
         0Wog==
X-Forwarded-Encrypted: i=1; AJvYcCUyALxS9/HPX7O3ox2EPqqy9WzizEaSdPpnB6dg6RQwiN+GOmDrxOpyJ2nDTM70aJ4reO99Mp2mLHGF@vger.kernel.org, AJvYcCWjzqhmGT41iY6xXjTPpV2aB0qsSkULfMfRoLTPvixSiMJTg/+NzVuz7zGiuUarq8b/XiNXVpnv@vger.kernel.org, AJvYcCXTU2SYnnfmeW6ya3Jlltkm3XRpO+GEcKh5op5Kvx2igVIbJPxxmorCuK3DZ+CXH0erL3KfGRRLLaVIS6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo27FVoHLs2L+kI5T9IlpPzcygwmkQ0DuiGPkgALLwrR4ZGUlP
	XWS3WMD11K32tbXfSwGYAJt2BPtlGOGeUy6vZUHCk3EUq2YV3XNx
X-Gm-Gg: ASbGnctiVadqanNxlhPsCTVPW918fDdCXgHYUrNdJP9uGoREjRD5+Nn/tFU+zeRLK+C
	c7E3C7j6apnuIPb4I8nFHRW1XNa+APGtOwjthjunbJdDhwfggPmfEnjqSwOyxzJqQUPAESjlSkz
	nOOGelwCcHHckEKVLpPoP+NSxfV3LayK+7fmQva8qoVPu0x/LFWv+dEWugQaYoOhUG/XiTPOkeY
	gNQNGCoB6t1zalKNeF14KQlDd+oP/3EJgQMekrhmIrEG7Hzva5h3lL+yQWm5HxuJFpCaUbZK1MA
	aRjP24MdjjUms5lHINkyJIx49LOZNUATl0h8z57CeAN5aNXvCwOLBXlVo99IDZhqmGLA
X-Google-Smtp-Source: AGHT+IG0QOR/eegQ5jpsDzvfXIfWd3tr80odWWEuLDBHoglnXdXs+WCgec4VqfDfOBL7wHXaoEYSGQ==
X-Received: by 2002:a17:902:e549:b0:223:fbc7:25f4 with SMTP id d9443c01a7336-2292f95d954mr223072675ad.14.1743584354350;
        Wed, 02 Apr 2025 01:59:14 -0700 (PDT)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf6dcsm102249465ad.113.2025.04.02.01.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 01:59:14 -0700 (PDT)
From: Ying Lu <luying526@gmail.com>
To: oneukum@suse.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Ying Lu <luying1@xiaomi.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/1] usbnet:fix NPE during rx_complete
Date: Wed,  2 Apr 2025 16:58:59 +0800
Message-ID: <4c9ef2efaa07eb7f9a5042b74348a67e5a3a7aea.1743584159.git.luying1@xiaomi.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743584159.git.luying1@xiaomi.com>
References: <cover.1743584159.git.luying1@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ying Lu <luying1@xiaomi.com>

Missing usbnet_going_away Check in Critical Path.
The usb_submit_urb function lacks a usbnet_going_away
validation, whereas __usbnet_queue_skb includes this check.

This inconsistency creates a race condition where:
A URB request may succeed, but the corresponding SKB data
fails to be queued.

Subsequent processes:
(e.g., rx_complete → defer_bh → __skb_unlink(skb, list))
attempt to access skb->next, triggering a NULL pointer
dereference (Kernel Panic).

Fixes: 04e906839a05 ("usbnet: fix cyclical race on disconnect with work queue")
Cc: stable@vger.kernel.org
Signed-off-by: Ying Lu <luying1@xiaomi.com>
---
 drivers/net/usb/usbnet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 44179f4e807f..5161bb5d824b 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -519,7 +519,8 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 	    netif_device_present (dev->net) &&
 	    test_bit(EVENT_DEV_OPEN, &dev->flags) &&
 	    !test_bit (EVENT_RX_HALT, &dev->flags) &&
-	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags)) {
+	    !test_bit (EVENT_DEV_ASLEEP, &dev->flags) &&
+	    !usbnet_going_away(dev)) {
 		switch (retval = usb_submit_urb (urb, GFP_ATOMIC)) {
 		case -EPIPE:
 			usbnet_defer_kevent (dev, EVENT_RX_HALT);
@@ -540,8 +541,7 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
 			tasklet_schedule (&dev->bh);
 			break;
 		case 0:
-			if (!usbnet_going_away(dev))
-				__usbnet_queue_skb(&dev->rxq, skb, rx_start);
+			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
 		}
 	} else {
 		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
-- 
2.49.0


