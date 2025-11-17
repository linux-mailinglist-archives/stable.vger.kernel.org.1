Return-Path: <stable+bounces-194971-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CAFC64DFA
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 16:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71A2B4E022F
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 15:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749B032ED46;
	Mon, 17 Nov 2025 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ceTBpUQr"
X-Original-To: stable@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799CD31D75C
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393372; cv=none; b=tdio/FnsOPNcHquJ6K1c+TlC2DlDzxrM7quSXpTYezn/ebsB1KTaQt+JL4b0brO1tVNDJUHrbwlFQog0IQ35dmHS4aKqytGN/yidcwCwSvtNQBfkEfatLKsJiz2CQbW36n3et32+lwHdBaJm+QP5JAgRXJ6dHzZPiWf6wjZ2BY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393372; c=relaxed/simple;
	bh=i+nmoWgsaVuYuG8wFv0ebxdBrhIc8t/vnIEhP9P9cHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=JZ+/wc9G7Z/7IpB2mSf7JzDd9XNZ9u0vVDm3vl2n4eZt+bMpkSJI5GDZqq2Qz4sNzLjeHEVrzlNJJ6nPtz9D69lMVICBSzRHSIqBvuYSiIvr8vDQB5LcaAaRHtWqr/5NmjlEsbt5Fo0Py0NILkIYtseztdF5CX3zPW5beWeZ4zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ceTBpUQr; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20251117152927epoutp026fc028126adb25a7c194ccd4e9351c28~41OyvELDa2954429544epoutp02J
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 15:29:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20251117152927epoutp026fc028126adb25a7c194ccd4e9351c28~41OyvELDa2954429544epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1763393367;
	bh=/jf/D4qje85S4KTVFC0gtmhMr3p/woT8WaV5hzvpclA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ceTBpUQrEMNpvBAcm4lTFtx3H2/AbK66j6HCj4Ml6r2GxE2vzl3uOMnG+JEh0IQT6
	 izmzR547teYZ35rPRB8SRUEIbi/otzjvsqIUwr0BaOlCfFO9LrwOJ5jDrgfy8S/vqS
	 BQzww5O1jPs1ZvTp3h2lfc76ajteJFwz9Dapx2Qc=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251117152926epcas5p17806e0ef42124603ab2be7213b3f8fb8~41OyLmlFl3219232192epcas5p1f;
	Mon, 17 Nov 2025 15:29:26 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4d9BVs5ybtz2SSKX; Mon, 17 Nov
	2025 15:29:25 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251117152924epcas5p3463725d014582467d6f3c100fa21eb8c~41OwMiVUL2269822698epcas5p3t;
	Mon, 17 Nov 2025 15:29:24 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251117152914epsmtip291ff8a398f7b70f631318625c65f7c9a~41OnKR6Td2369423694epsmtip2L;
	Mon, 17 Nov 2025 15:29:13 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, naushad@samsung.com,
	akash.m5@samsung.com, h10.kim@samsung.com, eomji.oh@samsung.com,
	alim.akhtar@samsung.com, thiagu.r@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH] usb: dwc3: gadget: Prevent EPs resource conflict during
 StartTransfer
Date: Mon, 17 Nov 2025 20:58:05 +0530
Message-ID: <20251117152812.622-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251117152924epcas5p3463725d014582467d6f3c100fa21eb8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251117152924epcas5p3463725d014582467d6f3c100fa21eb8c
References: <CGME20251117152924epcas5p3463725d014582467d6f3c100fa21eb8c@epcas5p3.samsung.com>

This commit fixes the below warning that occurs when a StartTransfer
command is issued for bulk or interrupt endpoints in
`dwc3_gadget_ep_enable` while a previous transfer on the same endpoint
is still in progress. The gadget functions drivers can invoke
usb_ep_enable (which triggers a new StartTransfer command) before the
earlier transfer has completed. Because the previous StartTransfer is
still active, `dwc3_gadget_ep_disable` can skip the required
`EndTransfer` due to `DWC3_EP_DELAY_STOP`, leading to  the endpoint
resources are busy for previous StartTransfer and warning ("No resource
for ep") from gadget driver.

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

Change-Id: Id292265a34448e566ef1ea882e313856423342dc
Fixes: a97ea994605e ("usb: dwc3: gadget: offset Start Transfer latency for bulk EPs")
Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---
 drivers/usb/dwc3/gadget.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index f95d1369bbc6..23e5c111da7c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -951,8 +951,9 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
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


