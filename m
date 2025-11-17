Return-Path: <stable+bounces-194976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6ECC65058
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 17:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1368B360C92
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 16:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23AD2BE7AA;
	Mon, 17 Nov 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VpB8Qkkl"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BFA2BDC09
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395263; cv=none; b=W+QwAtcaS2FlvqdFkdt+3RKc5ivgB5lO3BAef2d8zpD4tOK1+IZAwXwbforhpM3dviFWcBTQj5b8k9veC8PVCNkbMovECAZpNTtaX/cIzC/OmC9OC3Os65tfsZNm6VoMGM1SUE53c3ShX01m1fmgUujexIpaUfUewpxSOEWBjKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395263; c=relaxed/simple;
	bh=9RSsR5U4W7BTG6LYCPzyJndp7H3oEE0mKDMWjHJa7qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=iZzlCF+CNApWlG2NQQI3L24iKrxYiFnZZh6bvqx+IsXG5AYgZER2JIa1n+YT5AHL27e7h61BshBp0q9528jdMjg5hHpctI000Itgd06vvgSqT0dlaKGcLuAgHkKAQMpCH7qOUIzzXpUwioagGC7OVzxldsCL2jlRnDITh8Hukro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=VpB8Qkkl; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251117160059epoutp02a44f175e961100c3ebb1b514c092f4c0~41qU6RXWb2370823708epoutp02Q
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 16:00:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251117160059epoutp02a44f175e961100c3ebb1b514c092f4c0~41qU6RXWb2370823708epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763395259;
	bh=I67VOD55Qfnuqg41UpFlurJxMf6XJBCy6vb0p2590/c=;
	h=From:To:Cc:Subject:Date:References:From;
	b=VpB8Qkklg7Y5B2IP/Eg3coJvDNgEdKAI7mtdUnWOV6ceQ0jDZ7w8YLxmTEPusAvK1
	 oXkrXZ12mPKDqJBUxNTLhOdmOFUUPMYJN8QoLsoiJtiM0tg32BPCihphDDe4FU/Zu5
	 FU1PwQDkLUQrG4m37wqQRT6+XZJRwRAXKT7uM9G0=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20251117160058epcas5p4719f72c4469d4e16f94ca8356b35d72a~41qUZD3Sp2883528835epcas5p4j;
	Mon, 17 Nov 2025 16:00:58 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.94]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4d9CCF51Ndz6B9m6; Mon, 17 Nov
	2025 16:00:57 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251117160057epcas5p324eddf1866146216495186a50bcd3c01~41qS3iGLm2061120611epcas5p3J;
	Mon, 17 Nov 2025 16:00:57 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251117160055epsmtip1f7d3368895afa49a595ca513148de7b8~41qRBUXrh0499104991epsmtip1K;
	Mon, 17 Nov 2025 16:00:54 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict during
 StartTransfer
Date: Mon, 17 Nov 2025 21:29:13 +0530
Message-ID: <20251117155920.643-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251117160057epcas5p324eddf1866146216495186a50bcd3c01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251117160057epcas5p324eddf1866146216495186a50bcd3c01
References: <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>

The below “No resource for ep” warning appears when a StartTransfer
command is issued for bulk or interrupt endpoints in
`dwc3_gadget_ep_enable` while a previous StartTransfer on the same
endpoint is still in progress. The gadget functions drivers can invoke
`usb_ep_enable` (which triggers a new StartTransfer command) before the
earlier transfer has completed. Because the previous StartTransfer is
still active, `dwc3_gadget_ep_disable` can skip the required
`EndTransfer` due to `DWC3_EP_DELAY_STOP`, leading to  the endpoint
resources are busy for previous StartTransfer and warning ("No resource
for ep") from dwc3 driver.

To resolve this, a check is added to `dwc3_gadget_ep_enable` that
checks the `DWC3_EP_TRANSFER_STARTED` flag before issuing a new
StartTransfer. By preventing a second StartTransfer on an already busy
endpoint, the resource conflict is eliminated, the warning disappears,
and potential kernel panics caused by `panic_on_warn` are avoided.

------------[ cut here ]------------
dwc3 13200000.dwc3: No resource for ep1out
WARNING: CPU: 0 PID: 700 at drivers/usb/dwc3/gadget.c:398 dwc3_send_gadget_ep_cmd+0x2f8/0x76c
Call trace:
 dwc3_send_gadget_ep_cmd+0x2f8/0x76c
 __dwc3_gadget_ep_enable+0x490/0x7c0
 dwc3_gadget_ep_enable+0x6c/0xe4
 usb_ep_enable+0x5c/0x15c
 mp_eth_stop+0xd4/0x11c
 __dev_close_many+0x160/0x1c8
 __dev_change_flags+0xfc/0x220
 dev_change_flags+0x24/0x70
 devinet_ioctl+0x434/0x524
 inet_ioctl+0xa8/0x224
 sock_do_ioctl+0x74/0x128
 sock_ioctl+0x3bc/0x468
 __arm64_sys_ioctl+0xa8/0xe4
 invoke_syscall+0x58/0x10c
 el0_svc_common+0xa8/0xdc
 do_el0_svc+0x1c/0x28
 el0_svc+0x38/0x88
 el0t_64_sync_handler+0x70/0xbc
 el0t_64_sync+0x1a8/0x1ac

Fixes: a97ea994605e ("usb: dwc3: gadget: offset Start Transfer latency for bulk EPs")
Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---

Changes in v2:
- Removed change-id.
- Updated commit message.
Link to v1: https://lore.kernel.org/linux-usb/20251117152812.622-1-selvarasu.g@samsung.com/
---
 drivers/usb/dwc3/gadget.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1f67fb6aead5..8d3caa71ea12 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -963,8 +963,9 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
-			usb_endpoint_xfer_int(desc)) {
+	if ((usb_endpoint_xfer_bulk(desc) ||
+			usb_endpoint_xfer_int(desc)) &&
+			!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
 		dma_addr_t trb_dma;
-- 
2.34.1


