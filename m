Return-Path: <stable+bounces-192336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE54C2F6FF
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 07:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3F0D34BFC6
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 06:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6425A2BE633;
	Tue,  4 Nov 2025 06:24:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171A1134AB;
	Tue,  4 Nov 2025 06:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237490; cv=none; b=fhoOUaREosvXoZygKE5ryc+hVvQhgk/KUt0xJQWEaYrfvMwAFONFV7iVskqN/qz21B1os/M3xnD0WM/0O+2c89/bfoazdSIdQyT3fQSadiOBaTQN4J1M1+HqWxoF8CCQBZ7EhyXhGJA1Oaj7qWGdDIPXrtWhtdDxHLqjSueKv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237490; c=relaxed/simple;
	bh=tYpzbT/wfMGLJ4os1wVIq0G5gJ6HXjCgb3QHvkwYIbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZyJMnoFm1tTnWeNXUe/YDRSppETTWqn9qofcFFx843ajgrP7J3t7lg/keaHpkGNnu6ejc7r1wD0LRnjs+TL5hvX0fH+4MokLeDp8KOZZKZ8OnqILjbs+F/UIp/BGaeDFtXPrYyyR74qY3gmzOWU83US2H6fv8OhnJg8cTdb6F3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz10t1762237419tde1b639e
X-QQ-Originating-IP: +ovJgyhgyINWp1J5Qt/R08DyncU/TOt9fJW7kiU7MmM=
Received: from w-MS-7E16.trustnetic.com ( [125.120.71.67])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 04 Nov 2025 14:23:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18246504412053202586
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: libwx: fix device bus LAN ID
Date: Tue,  4 Nov 2025 14:23:21 +0800
Message-ID: <B60A670C1F52CB8E+20251104062321.40059-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: N/EN6P+BmEaf/8NNAZVY+Fufyzk+Y2KQmpSYrQVSqJHr+UrSqGXRpzNC
	gbZ98Plz2evUsn3PDsBKGL9OeTFdPgpJ7tTWhGLO1ZzKYUszErO0LT2j1RICuZQ+joL+1aH
	6vCZ5orilEY5Zz+M7aeTfUAqnkwG059I4HJ9u1Zxn22zP0G9j3bhs7LnO7J22CUuq/LX8pT
	zf1bGBXrul851WpHZ+KLoXU+AcqXvZtjec5dM/M5FaNZXj6zEPJKcCErWN5TPgScktieBmO
	LJeJWsBDEistHxkvajyBdP+RTzpeTTXL/vdDqAQ7/ZzCk6St8XFSxyJJ8+VdDjFWZgGkRqN
	oOjQbYk2cIG8l7oDLfXsW1DkZzuDmACXFJUAfx58JYlXVPhVYq6KZ8hxvJxzSuXGwMRDl3X
	OYo2qAW40bl/u+eN6e4RazRi8nMjdANynyS2FfWYTAQ/aYuFQznTIN/vfM8tyhRkmppoUPi
	c+ZPjZbN7pnvt7Y8ZuywmGaE4HuesEMZcf7COBZUgepeW2iJ+DI939LswAn2piyMbV30Xwt
	lgPJm7XzEQju9Tk7dOFvpZRmI/pNaQ9QaxZxDJ2cf/n6jRGCT5bHqG4OEy4HrkF7+3fgC+Q
	vFHVKc3o8ajgBCOLAaLOZ19SVzspErRAXhn+4gJPYpJA1OoLh5JCwWpBEPI0UkvnpI7lXLY
	XR4vC2J6RtNFBM2JOH4rngmENnykYK7uI12oPMs2hP1l0iXcuJUqZe/Ppm6ptX4PUVnUedl
	7qiUg38XQN3tfyN/pEOP7X3UJcazpZAndZj+PqRdQEWneY0vMUBPJxHWl4zqCGAmzGK5TZa
	O3qj43qDhyJmzgj/eZSW8uCDmvX36EojREaEwbAVr7sucT/gyjHfrjN1TjJ1Kxdu0VjE4SH
	ZkqWtdaf/0vlMXws7avcI5Sh3LLVTdWezTKwrqcV+/x34gy5hwHc+QRvEhn1EP6lIheE9kj
	kHvmJHwNi6Ta0xKWqeh3YbuRp1QHy37QLYSPocE83eDNvXsRbIwZQ94+FXQIZ8+1g+dvRIn
	5hB0i4qbXwHvqkDEkLNNvO0JgO5Sn4Cc3fnnFGFg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

The device bus LAN ID was obtained from PCI_FUNC(), but when a PF
port is passthrough to a virtual machine, the function number may not
match the actual port index on the device. This could cause the driver
to perform operations such as LAN reset on the wrong port.

Fix this by reading the LAN ID from port status register.

Fixes: a34b3e6ed8fb ("net: txgbe: Store PCI info")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 3 ++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 814164459707..58b8300e3d2c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -2480,7 +2480,8 @@ int wx_sw_init(struct wx *wx)
 	wx->oem_svid = pdev->subsystem_vendor;
 	wx->oem_ssid = pdev->subsystem_device;
 	wx->bus.device = PCI_SLOT(pdev->devfn);
-	wx->bus.func = PCI_FUNC(pdev->devfn);
+	wx->bus.func = FIELD_GET(WX_CFG_PORT_ST_LANID,
+				 rd32(wx, WX_CFG_PORT_ST));
 
 	if (wx->oem_svid == PCI_VENDOR_ID_WANGXUN ||
 	    pdev->is_virtfn) {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index d0cbcded1dd4..b1a6ef5709a9 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -102,6 +102,8 @@
 #define WX_CFG_PORT_CTL_DRV_LOAD     BIT(3)
 #define WX_CFG_PORT_CTL_QINQ         BIT(2)
 #define WX_CFG_PORT_CTL_D_VLAN       BIT(0) /* double vlan*/
+#define WX_CFG_PORT_ST               0x14404
+#define WX_CFG_PORT_ST_LANID         GENMASK(9, 8)
 #define WX_CFG_TAG_TPID(_i)          (0x14430 + ((_i) * 4))
 #define WX_CFG_PORT_CTL_NUM_VT_MASK  GENMASK(13, 12) /* number of TVs */
 
@@ -564,8 +566,6 @@ enum WX_MSCA_CMD_value {
 #define TXD_USE_COUNT(S)     DIV_ROUND_UP((S), WX_MAX_DATA_PER_TXD)
 #define DESC_NEEDED          (MAX_SKB_FRAGS + 4)
 
-#define WX_CFG_PORT_ST               0x14404
-
 /******************* Receive Descriptor bit definitions **********************/
 #define WX_RXD_STAT_DD               BIT(0) /* Done */
 #define WX_RXD_STAT_EOP              BIT(1) /* End of Packet */
-- 
2.48.1


