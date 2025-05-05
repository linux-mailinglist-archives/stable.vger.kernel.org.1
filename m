Return-Path: <stable+bounces-141616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA8FAAB743
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D0367B12B0
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CDA486E1E;
	Tue,  6 May 2025 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVPTCFIQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24022F3A7E;
	Mon,  5 May 2025 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486886; cv=none; b=sQdikaOPi2CwZX8Qn6shcynRdSzogsqUDQWm7vm+IwE7gCMOYRPcdrfCLpFq4olTsxYOXx/nunhjE7Zu+6kZ09HCdDshH09wFTdhWOrAFImfi3e5zN3fpDaRVZofYcFNHfF6oW4wclzHff6eiIAh0TToAqkAZEmhDoCH9pOylAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486886; c=relaxed/simple;
	bh=AaVyXzjXMB89c+N3cLGs6RLB1uFIyFBHLakI9cGBQ9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qU1WJKRBe6Y5oCrZvPxEOvi/qxAw1Ilivcc7bFk2ybrqxz+WPChILvRwGxPnttx/Xdsx/rRF4kPOrWXiuVbeX6LbAxje7Vz4iGHd/OGxndwWuteb8OOy5Bi5d+F5Z68kAEKfHGlcqN8uwIgAg5kMIBmVIVsOMihqtg1nFNm+QKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVPTCFIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81328C4CEF1;
	Mon,  5 May 2025 23:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486885;
	bh=AaVyXzjXMB89c+N3cLGs6RLB1uFIyFBHLakI9cGBQ9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVPTCFIQrJ2KaeujaUMNIqDB06WwR297YjQeAukSKLIIB0XXHltgVekrrbIuYIkaS
	 Iw7F/hzIPdal+bOqI8rZPFjj1UYtPlXldDRD+YXSkDjzp6JFkKh7yz8XL7unJk8aHg
	 pRJ/IZlwmsw0YjoUGreLdacF5mhZmOp+DibkeU+CR8gwIMruZUliEyuXBUQElcHp6/
	 ndFkvVjUl9Jx67ZsFdXbK5gCebj/pcDDeekzp+9MNtd9BhHiPguw0nG2bJYdynNhAg
	 m7eCONGMSz8nWVe7wmEk/jTmECVtcbjcjhUrft50KCU6wmPul7cPKQT8tXVqkhuh8Q
	 rgIhGy8TAT9tg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frediano Ziglio <frediano.ziglio@cloud.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	sstabellini@kernel.org,
	xen-devel@lists.xenproject.org
Subject: [PATCH AUTOSEL 5.15 043/153] xen: Add support for XenServer 6.1 platform device
Date: Mon,  5 May 2025 19:11:30 -0400
Message-Id: <20250505231320.2695319-43-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

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
index 6ebd819338ecb..2c77cac5594ba 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -26,6 +26,8 @@
 
 #define DRV_NAME    "xen-platform-pci"
 
+#define PCI_DEVICE_ID_XEN_PLATFORM_XS61	0x0002
+
 static unsigned long platform_mmio;
 static unsigned long platform_mmio_alloc;
 static unsigned long platform_mmiolen;
@@ -174,6 +176,8 @@ static int platform_pci_probe(struct pci_dev *pdev,
 static const struct pci_device_id platform_pci_tbl[] = {
 	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_XEN, PCI_DEVICE_ID_XEN_PLATFORM_XS61,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
 	{0,}
 };
 
-- 
2.39.5


