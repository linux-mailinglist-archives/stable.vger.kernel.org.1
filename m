Return-Path: <stable+bounces-144663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C45ABA829
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 06:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 444471B67CF6
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 04:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9BB18DF62;
	Sat, 17 May 2025 04:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xHjLVUzc"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f202.google.com (mail-vk1-f202.google.com [209.85.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E33165F1A
	for <stable@vger.kernel.org>; Sat, 17 May 2025 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747456788; cv=none; b=J1MYUxeDsBUSRJDb6L+WdcIVrQhXn42ZDGxOSLgLijANZ5zEnbDCxl3WmVs83jDFvgLgMBi9ZhnOJ7ksNXOSLpp6FKZla2D/SEF7zWB6JBms4bUeU6vdLzOo7eoGPQGEaunSZ1nP2MM5a1AcAt4WS5IAbVPZsg1Tx+ztx1/oURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747456788; c=relaxed/simple;
	bh=bV10WWBmI6/GvHHmPVKI6hqSpJH3IZm8rYMRw/50izc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hokUYqCaG3O+eQzLnUQL5Sny/RbJQeFNJVBeVi9P3x0fCfxSrOJ7fvielMyZTZlShlEKJO8YfciLZY/wovQpvRs2G67M5W0XkHI5SRn7q2TW+frxfV+y7uIG712X5UCtNmMs+bM5lha57crFAZeyCgl0nZ4D7CGxX5v0zAcWe4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xHjLVUzc; arc=none smtp.client-ip=209.85.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--royluo.bounces.google.com
Received: by mail-vk1-f202.google.com with SMTP id 71dfb90a1353d-52c463ada00so604849e0c.0
        for <stable@vger.kernel.org>; Fri, 16 May 2025 21:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747456785; x=1748061585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=df+2MVHU2IheOPhJFRx50s9JL707knXFHue2W25vjls=;
        b=xHjLVUzc4+0dVaw7+EYvRnXWssB/G+IPko4BD5t6KLOHxCZp7H+rhnmGqf/NVtl2GM
         oWO3XAVJUuFqLwcx+8HDmpXinp13S1WJKXhT/1MPz/tnSDR9e9tVflt3TlhADTnjqpKa
         Fd7bgoiW5WUaHIaVm+S7vGFslUBLfKe2hVx8k7Oa2MKCDi0B+VezuNxQNQpv5RYRSxRt
         v8mMKDbvHaWUNLVDsUcgQAIj8X0zIBRagT1+NryixTS17dXXwnAIiZF0x7Xc6trBrCy3
         jOktwAY1Ehc6CFz7FFK6NQFwSZFzpiSWRjtWqa5ygOZlYZ0o+93KquZUCBQnt6dDBTF9
         On6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747456785; x=1748061585;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=df+2MVHU2IheOPhJFRx50s9JL707knXFHue2W25vjls=;
        b=S9+fggcq+4QyNoApADP8Vz9TKzNpKKuC/qZnI20UUT2W7DoM1I5fp+s2QDacBkjXQt
         iQGy1mHxo5jOnTQbnHzSgSqPY/VMhsw9865G+8hXWxKW8M8U+t5DNkEt9EGINlQ2hK0P
         Ig/un6d+zuujJ+vBmRXdmVblxg1fiVw7v9ftim7bbMy47FMvcwgRc9b+f4lSrq6GwItT
         RvFrfw3mwCvZDr68TJ+b5IGR5cjfND+vDyG5NWZHYpiX31w2vL1UUgIqNtRZjXo8DdgI
         vz3t5/e9jgFA2Ir1iuANCDs3Cc45cWAq5S6fdg925OT/r0Ea74JNRIuktrDVmHXnF0j1
         yQaQ==
X-Gm-Message-State: AOJu0YxpdN+yrmzZKCfxcSVXxVcYHQoIfxNkifEWFSppk38sYYOJtdjj
	owWY7XRxA5KYiVEwC7nfMUK8kDkw36aP8MR0tuzRRSa/NjgK88KmYl5RpTatOwZKNssa/OHH+/z
	bMtXI3g==
X-Google-Smtp-Source: AGHT+IFJJhMHDx2YvBOXrapFLM23km4Ve+Mci7qAhkgArB07QzKzmSsPp66S41eAP5Bi3qICWISqKLLAlwQ=
X-Received: from vsvo44.prod.google.com ([2002:a05:6102:3fac:b0:4be:5bab:2af2])
 (user=royluo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:1628:b0:4de:81a:7d3e
 with SMTP id ada2fe7eead31-4dfa6ae1b05mr7939270137.2.1747456785343; Fri, 16
 May 2025 21:39:45 -0700 (PDT)
Date: Sat, 17 May 2025 04:39:42 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1112.g889b7c5bd8-goog
Message-ID: <20250517043942.372315-1-royluo@google.com>
Subject: [PATCH v1] Revert "usb: xhci: Implement xhci_handshake_check_state() helper"
From: Roy Luo <royluo@google.com>
To: royluo@google.com, mathias.nyman@intel.com, quic_ugoswami@quicinc.com, 
	Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, michal.pecio@gmail.com, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 6ccb83d6c4972ebe6ae49de5eba051de3638362c.

Commit 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state()
helper") was introduced to workaround watchdog timeout issues on some
platforms, allowing xhci_reset() to bail out early without waiting
for the reset to complete.

Skipping the xhci handshake during a reset is a dangerous move. The
xhci specification explicitly states that certain registers cannot
be accessed during reset in section 5.4.1 USB Command Register (USBCMD),
Host Controller Reset (HCRST) field:
"This bit is cleared to '0' by the Host Controller when the reset
process is complete. Software cannot terminate the reset process
early by writinga '0' to this bit and shall not write any xHC
Operational or Runtime registers until while HCRST is '1'."

This behavior causes a regression on SNPS DWC3 USB controller with
dual-role capability. When the DWC3 controller exits host mode and
removes xhci while a reset is still in progress, and then tries to
configure its hardware for device mode, the ongoing reset leads to
register access issues; specifically, all register reads returns 0.
These issues extend beyond the xhci register space (which is expected
during a reset) and affect the entire DWC3 IP block, causing the DWC3
device mode to malfunction.

Cc: stable@vger.kernel.org
Fixes: 6ccb83d6c497 ("usb: xhci: Implement xhci_handshake_check_state() helper")
Signed-off-by: Roy Luo <royluo@google.com>
---
Changes in v1:
- Link to previous patchset: https://lore.kernel.org/r/20250515185227.1507363-1-royluo@google.com/ 
---
 drivers/usb/host/xhci-ring.c |  5 ++---
 drivers/usb/host/xhci.c      | 26 +-------------------------
 drivers/usb/host/xhci.h      |  2 --
 3 files changed, 3 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 423bf3649570..b720e04ce7d8 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -518,9 +518,8 @@ static int xhci_abort_cmd_ring(struct xhci_hcd *xhci, unsigned long flags)
 	 * In the future we should distinguish between -ENODEV and -ETIMEDOUT
 	 * and try to recover a -ETIMEDOUT with a host controller reset.
 	 */
-	ret = xhci_handshake_check_state(xhci, &xhci->op_regs->cmd_ring,
-			CMD_RING_RUNNING, 0, 5 * 1000 * 1000,
-			XHCI_STATE_REMOVING);
+	ret = xhci_handshake(&xhci->op_regs->cmd_ring,
+			CMD_RING_RUNNING, 0, 5 * 1000 * 1000);
 	if (ret < 0) {
 		xhci_err(xhci, "Abort failed to stop command ring: %d\n", ret);
 		xhci_halt(xhci);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 90eb491267b5..472c4b6ae59e 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -83,29 +83,6 @@ int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, u64 timeout_us)
 	return ret;
 }
 
-/*
- * xhci_handshake_check_state - same as xhci_handshake but takes an additional
- * exit_state parameter, and bails out with an error immediately when xhc_state
- * has exit_state flag set.
- */
-int xhci_handshake_check_state(struct xhci_hcd *xhci, void __iomem *ptr,
-		u32 mask, u32 done, int usec, unsigned int exit_state)
-{
-	u32	result;
-	int	ret;
-
-	ret = readl_poll_timeout_atomic(ptr, result,
-				(result & mask) == done ||
-				result == U32_MAX ||
-				xhci->xhc_state & exit_state,
-				1, usec);
-
-	if (result == U32_MAX || xhci->xhc_state & exit_state)
-		return -ENODEV;
-
-	return ret;
-}
-
 /*
  * Disable interrupts and begin the xHCI halting process.
  */
@@ -226,8 +203,7 @@ int xhci_reset(struct xhci_hcd *xhci, u64 timeout_us)
 	if (xhci->quirks & XHCI_INTEL_HOST)
 		udelay(1000);
 
-	ret = xhci_handshake_check_state(xhci, &xhci->op_regs->command,
-				CMD_RESET, 0, timeout_us, XHCI_STATE_REMOVING);
+	ret = xhci_handshake(&xhci->op_regs->command, CMD_RESET, 0, timeout_us);
 	if (ret)
 		return ret;
 
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 242ab9fbc8ae..5e698561b96d 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1855,8 +1855,6 @@ void xhci_remove_secondary_interrupter(struct usb_hcd
 /* xHCI host controller glue */
 typedef void (*xhci_get_quirks_t)(struct device *, struct xhci_hcd *);
 int xhci_handshake(void __iomem *ptr, u32 mask, u32 done, u64 timeout_us);
-int xhci_handshake_check_state(struct xhci_hcd *xhci, void __iomem *ptr,
-		u32 mask, u32 done, int usec, unsigned int exit_state);
 void xhci_quiesce(struct xhci_hcd *xhci);
 int xhci_halt(struct xhci_hcd *xhci);
 int xhci_start(struct xhci_hcd *xhci);

base-commit: 172a9d94339cea832d89630b89d314e41d622bd8
-- 
2.49.0.1112.g889b7c5bd8-goog


