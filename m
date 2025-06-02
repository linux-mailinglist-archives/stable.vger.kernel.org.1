Return-Path: <stable+bounces-149714-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA64ACB44D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9BC1BA578E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA66222590;
	Mon,  2 Jun 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zhohkBCr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7824121882B;
	Mon,  2 Jun 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748874805; cv=none; b=VDtos0jqgy9TovuMVZhW+tJWEI8WASTG2+G9yKcbx9K5KAU8U5D4RKwV+IpTw6HcA1zoBSo/eA2DQeDAE0CVhHCboKcRrlbbHuMl9HAh4JGeasymC3i/HqHjooTodkyK99tRsa3v6xG/N2IMHMbf9U+tNZ2YHzY6NAtS5pkGjZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748874805; c=relaxed/simple;
	bh=BP9UqVFgwnkXIBJazKLB6hPRCRD9OJeU0dwLKy6DBYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3ElAAJ9fMMp3ZafnBIOmwosCuuzYvr65Sizfvm7MjD6lagjNX82hk52P0P+MR0Ep8PemEkEoCltN9TrB6IV4XZDxSZjOXS9/Nh8nXtigFy5Dg69USnlP/VJ6m98U4NZhy1em487JrqRkHDUhnLywphd/VSK7GEENvwTaDqdY48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zhohkBCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE386C4CEEB;
	Mon,  2 Jun 2025 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748874805;
	bh=BP9UqVFgwnkXIBJazKLB6hPRCRD9OJeU0dwLKy6DBYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zhohkBCrRQNMnorGdicu3VGqpUCvwBebAZ0xrRE0/Q282XgBwy4kyYqj4s+mxNSMv
	 D4xpUFaj5+lak9TW3PHyq7PHbUgYupjjE1Gc16FRij9HoamXRbGMG1i5V+FWBZyGk7
	 afdyQirpAzZm33b8xZMvlVxW7YHYmiRB4yqfQ3hw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frediano Ziglio <frediano.ziglio@cloud.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 110/204] xen: Add support for XenServer 6.1 platform device
Date: Mon,  2 Jun 2025 15:47:23 +0200
Message-ID: <20250602134259.985275059@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134255.449974357@linuxfoundation.org>
References: <20250602134255.449974357@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frediano Ziglio <frediano.ziglio@cloud.com>

[ Upstream commit 2356f15caefc0cc63d9cc5122641754f76ef9b25 ]

On XenServer on Windows machine a platform device with ID 2 instead of
1 is used.

This device is mainly identical to device 1 but due to some Windows
update behaviour it was decided to use a device with a different ID.

This causes compatibility issues with Linux which expects, if Xen
is detected, to find a Xen platform device (5853:0001) otherwise code
will crash due to some missing initialization (specifically grant
tables). Specifically from dmesg

    RIP: 0010:gnttab_expand+0x29/0x210
    Code: 90 0f 1f 44 00 00 55 31 d2 48 89 e5 41 57 41 56 41 55 41 89 fd
          41 54 53 48 83 ec 10 48 8b 05 7e 9a 49 02 44 8b 35 a7 9a 49 02
          <8b> 48 04 8d 44 39 ff f7 f1 45 8d 24 06 89 c3 e8 43 fe ff ff
          44 39
    RSP: 0000:ffffba34c01fbc88 EFLAGS: 00010086
    ...

The device 2 is presented by Xapi adding device specification to
Qemu command line.

Signed-off-by: Frediano Ziglio <frediano.ziglio@cloud.com>
Acked-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250227145016.25350-1-frediano.ziglio@cloud.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/platform-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index e1cb277a9e16f..69bceab71c3f7 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -26,6 +26,8 @@
 
 #define DRV_NAME    "xen-platform-pci"
 
+#define PCI_DEVICE_ID_XEN_PLATFORM_XS61	0x0002
+
 static unsigned long platform_mmio;
 static unsigned long platform_mmio_alloc;
 static unsigned long platform_mmiolen;
@@ -167,6 +169,8 @@ static int platform_pci_probe(struct pci_dev *pdev,
 static const struct pci_device_id platform_pci_tbl[] = {
 	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM_XS61,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
 
-- 
2.39.5




