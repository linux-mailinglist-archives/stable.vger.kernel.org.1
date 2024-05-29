Return-Path: <stable+bounces-47610-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2B58D2ABD
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 04:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8218528376A
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 02:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B146E15ADBD;
	Wed, 29 May 2024 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9BAirMw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5315ADA8;
	Wed, 29 May 2024 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949480; cv=none; b=XuvvwOJlhs99JvciDpiRSeYbsyOzu3vq8C/JBwWChYCgFwhMfIKi5K4yrHnZXAUUDxsfqCSgS6i3yGtRpq0hqdvshAtTTch3BkC5HHr3i0QsGrfjDHAYPLuJOa0vaCbLKhdXYynxjMeyIj3WpfdeNB8npXHmL7y1VnO1lDgzM7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949480; c=relaxed/simple;
	bh=LD/u7PQH0Qz185qWoqI56yH1j1u5QtJq9nIgw/rdnG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q/peIiGMRWBru4SZKibrmgb6spRIQ4U9+qa/LwF6gZBsXiZ0HWx//ThvyAhRXyry1GRjedt78CG+cfgw2gEumUWrOAFLJb8eUxVxaWe++MoFoCS/Tg+DuYtx3RT0yZQaZi6i6G7BCt5SpbaR5eyb8OCtocMip9aggtifikUAUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9BAirMw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2bde4d15867so269327a91.3;
        Tue, 28 May 2024 19:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716949478; x=1717554278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6lxg6L9XPIoxH+sYdGJUuWSOxXCo7mdMoMtsrXkU84=;
        b=M9BAirMwKGPvwibOsc9fJMyFuYYbecjyU035+C7p2V2xn9KVpxxwPDCI1ddZVf3tDK
         Yg803iMluR8IM4rFJlLNl/EYr56Uru1Qo0+rDMnYrCilRYp4uWKrk70QlHQGJLq5db01
         FP1aD0rfptk0Rg01/vUoKwUtGk7WVhQ3e2Rgu5TxTC7XIykqBWhB4dWwumfXTWiJYIA6
         a+aXqvUCknvxzJ0YQkP0FjVXPsg01AWf93LSiucNdWl8Oe+mNcXHE0ORhcozV9uvbODl
         8a620F9Gsh0R3IY5iB/KwWHG1lIDWyaEv7CcxXVWzfLDjKHErnFOQPPLJm/KA+JuzROw
         IKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716949478; x=1717554278;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6lxg6L9XPIoxH+sYdGJUuWSOxXCo7mdMoMtsrXkU84=;
        b=CQlAySSti2SorVyP+KJMXkEIwK8Oo+UH29TXRfOBZ1vspqAArgg7pWCfxHJu1SxGiI
         b8I9FdMZMWU2RZSd82vk3IbqPlA5G1Ked1xrFNby9B9WHvISLJM0wnvPp02qWGoF1VnH
         Fe50+xkS3Vl5BbtD/RzbL8e23Q/3Nk/xJatSVeAFrS8SxHQaCNCIxDADXSRmSPgIE55g
         QNT+Uqs6nAt22PGye1KfJfXmo4LC7f+P/dFqT9B+q8tQn5AAQjnf1MdManFMA8RSpXLw
         KDZXUrKzBKikUisbt+UH9Ywhjt5ggU2ufwvwdGsXvhQ2hGW8yO8klMacTPlzrmwSo9Ou
         VUkw==
X-Forwarded-Encrypted: i=1; AJvYcCXbekYXobV9TyYXmXlw0M2QsrQuYqfVMRiTXmgx2x4p0jrUggqdVZichkr1tpFAAJtwZZwl2V0xY0xmTmI4tThO1EE97ke4VeDg9ct3Dcn4Cv5CzmOx7XawoiYG6FJc+0YiloAX
X-Gm-Message-State: AOJu0Yw9YHZ/MVYe9TS1pCjxoki04bOOwbQP+fSpEDeizURtTrDoDxoe
	eLL9BexEghyxb/uL7NEYLvmMNg7K7sTcK6l9Oc4qxATNgFvXcuCN1Dz7KO5+
X-Google-Smtp-Source: AGHT+IGvFepMkHKmzZJpa/37FHNiBg5wiyNcezQ4F8iraf2aIl03Ti5h7ik3UOYEMGAfJg3TH9Otww==
X-Received: by 2002:a17:903:41d0:b0:1f3:453:2c82 with SMTP id d9443c01a7336-1f4498f40c2mr155926845ad.4.1716949478375;
        Tue, 28 May 2024 19:24:38 -0700 (PDT)
Received: from localhost.localdomain (122-117-151-175.hinet-ip.hinet.net. [122.117.151.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9c6fd1sm89856375ad.278.2024.05.28.19.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 19:24:38 -0700 (PDT)
From: Kuangyi Chiang <ki.chiang65@gmail.com>
To: mathias.nyman@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ki.chiang65@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] xhci: Apply broken streams quirk to Etron EJ188 xHCI host
Date: Wed, 29 May 2024 10:24:19 +0800
Message-Id: <20240529022420.9449-1-ki.chiang65@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in commit 8f873c1ff4ca ("xhci: Blacklist using streams on the
Etron EJ168 controller"), EJ188 have the same issue as EJ168, where Streams
do not work reliable on EJ188. So apply XHCI_BROKEN_STREAMS quirk to EJ188
as well.

Cc: <stable@vger.kernel.org>
Signed-off-by: Kuangyi Chiang <ki.chiang65@gmail.com>
---
Changes in v3:
- Fix coding style

Changes in v2:
- Porting to latest release

 drivers/usb/host/xhci-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dd8256e4e02a..05881153883e 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -397,8 +397,10 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_ETRON &&
-			pdev->device == PCI_DEVICE_ID_EJ188)
+			pdev->device == PCI_DEVICE_ID_EJ188) {
 		xhci->quirks |= XHCI_RESET_ON_RESUME;
+		xhci->quirks |= XHCI_BROKEN_STREAMS;
+	}
 
 	if (pdev->vendor == PCI_VENDOR_ID_RENESAS &&
 	    pdev->device == 0x0014) {
-- 
2.25.1


