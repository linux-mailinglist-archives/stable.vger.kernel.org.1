Return-Path: <stable+bounces-88262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53AC9B2351
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 03:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3FD281EC2
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 02:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B359F189BA2;
	Mon, 28 Oct 2024 02:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWj7mImb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F701885BE;
	Mon, 28 Oct 2024 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730084084; cv=none; b=CK0YxpNTKmpbWm1fkRUpEU9thFSUxdTN+FxFmZMBWg1ax8WLytsa8P94Mhy7LnxeOZjZnEQu7hV8boebjphQWT8JxBX+m2JCSk1ZNVl515PnAYjrXO9q3WVRLsXeHfvd30FnWwnukJojzjxwMBRhadJRoU3ZPbgLJmBsjozOyFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730084084; c=relaxed/simple;
	bh=4bVMTJO1yGoBazKUkcY3SKAuFa2zfFXwwrJaUJPJrOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J5W5xMi+oR8lUfm4TgnakZs/QJYE28guBRpIET8todfFAFn4Wfwi8QcYqQgd5GhqR7Maa02CLAD1ALTtLHmU5TLGMVZ+82K/rmzFOKBnfjjRPMFjXrr4jwFzU1dZNxMHjZC6L2B/QB0OPBqkCPn37AcXq4/TuthgczgBhZowq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWj7mImb; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so2714719a91.2;
        Sun, 27 Oct 2024 19:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730084082; x=1730688882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad7qNqPRwzi69bvd1QX3RJsedo6Iqsq69Lx8P2N8p58=;
        b=OWj7mImbS+57MGJdVeixMyunQDZipDPnmjACX4I59bfzXLCKK/ymNAX+pJG3vsN6Xf
         EStxmoW9ZsQZdfwYFlfRTXnb0/HoR7+D6nv3bkWAa6PzP1c5PTT+Hle1HbZSs6sOWysX
         VkOvjaxEZHuzu76b4Ya/fdm9oKbOBrrOzN2HUXilYurqKftfRSRQcQ8PhCUX5dWSiYJg
         LDZo5d8BUxM8wFwR0cHu2/d80VzV3+xliMhJXQgwTZuIB+WTD2MdXFpK5I2Gl9WARZ3z
         iuGEDrUFIIS1KqeoDJsDeL4T2oq5lNmMxPwk7VXbwU4jYPSfmNGsnYCEiXtoUNHfGB7n
         uMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730084082; x=1730688882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad7qNqPRwzi69bvd1QX3RJsedo6Iqsq69Lx8P2N8p58=;
        b=L9GqqneQIZLAI0uT++KBmAcp6b0VyHr1nvH2W1zOTmCbmTdQEmqe8nKsy9UHNe5JQe
         dYc0+QkdHESIV7mKb6p2upzL/63sJEM6ix1C+LrHiCkiRCHOTHtLbXCSjfPE1Bn5iQc4
         cjImL+u27HAqOQUOYVLnEAMdt+7H2wqK803+Sm7sr7Mf18QnSH2ZFx8qoSEeIgsu5FX+
         4/2JZZZ/5lrCmjiq7LBuTgmeG37AAjyMrO+ppH4LCc9OPv0lh1q2E4wm/j3O2BRNdKu4
         2eQgrlVv5I6dOPHJ6nzxPesZrh19w1vsI7nWJHWMd/tkEWiUL4v5WHfauyewTXgv1BIz
         XDjg==
X-Forwarded-Encrypted: i=1; AJvYcCX8iWpJWYZY1myQ+74hmi2oPK++vbme7p2gEFp40NCTvsu0ZecSw+kdegygdJ3G+qGJVh2yvT9q1JXwLAY=@vger.kernel.org, AJvYcCXlVRTMIlsWqkGMRJ5NxSQKJFrl4/amgSbNCi3rKFsN1veyls44GXEtSkVIZ2VcQq1GICS6qJud@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+vfOKhXJfGMGQuw7xbqRXdvB2NSTzSjk3UKuZbI5ioYBkY0UZ
	nutb3U32tOZbCrjXoPDU3+U9z6KMGeGS18DgC4LnRx5DWZMtUefD
X-Google-Smtp-Source: AGHT+IHJHR4KTwPQNs9iH7vI16zhLaBn6np4PZGNBpaLV3Am8NktDzUH/HuIEMx0pZxcly3R7IfPGw==
X-Received: by 2002:a17:90a:68c9:b0:2d8:a672:1869 with SMTP id 98e67ed59e1d1-2e8f11a82bcmr8393426a91.32.1730084081791;
        Sun, 27 Oct 2024 19:54:41 -0700 (PDT)
Received: from kic-machine.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e4ca3fcsm8062236a91.13.2024.10.27.19.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 19:54:41 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 3/5] xhci: Fix control transfer error on Etron xHCI host
Date: Mon, 28 Oct 2024 10:53:35 +0800
Message-Id: <20241028025337.6372-4-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241028025337.6372-1-ki.chiang65@gmail.com>
References: <20241028025337.6372-1-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Performing a stability stress test on a USB3.0 2.5G ethernet adapter
results in errors like this:

[   91.441469] r8152 2-3:1.0 eth3: get_registers -71
[   91.458659] r8152 2-3:1.0 eth3: get_registers -71
[   91.475911] r8152 2-3:1.0 eth3: get_registers -71
[   91.493203] r8152 2-3:1.0 eth3: get_registers -71
[   91.510421] r8152 2-3:1.0 eth3: get_registers -71

The r8152 driver will periodically issue lots of control-IN requests
to access the status of ethernet adapter hardware registers during
the test.

This happens when the xHCI driver enqueue a control TD (which cross
over the Link TRB between two ring segments, as shown) in the endpoint
zero's transfer ring. Seems the Etron xHCI host can not perform this
TD correctly, causing the USB transfer error occurred, maybe the upper
driver retry that control-IN request can solve problem, but not all
drivers do this.

|     |
-------
| TRB | Setup Stage
-------
| TRB | Link
-------
-------
| TRB | Data Stage
-------
| TRB | Status Stage
-------
|     |

To work around this, the xHCI driver should enqueue a No Op TRB if
next available TRB is the Link TRB in the ring segment, this can
prevent the Setup and Data Stage TRB to be breaked by the Link TRB.

Check if the XHCI_ETRON_HOST quirk flag is set before invoking the
workaround in xhci_queue_ctrl_tx().

Fixes: d0e96f5a71a0 ("USB: xhci: Control transfer support.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b6eb928e260f..9e132b08bfde 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3727,6 +3727,20 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t mem_flags,
 	if (!urb->setup_packet)
 		return -EINVAL;
 
+	if ((xhci->quirks & XHCI_ETRON_HOST) &&
+	    urb->dev->speed >= USB_SPEED_SUPER) {
+		/*
+		 * If next available TRB is the Link TRB in the ring segment then
+		 * enqueue a No Op TRB, this can prevent the Setup and Data Stage
+		 * TRB to be breaked by the Link TRB.
+		 */
+		if (trb_is_link(ep_ring->enqueue + 1)) {
+			field = TRB_TYPE(TRB_TR_NOOP) | ep_ring->cycle_state;
+			queue_trb(xhci, ep_ring, false, 0, 0,
+					TRB_INTR_TARGET(0), field);
+		}
+	}
+
 	/* 1 TRB for setup, 1 for status */
 	num_trbs = 2;
 	/*
-- 
2.25.1


