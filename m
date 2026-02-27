Return-Path: <stable+bounces-219950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI8cIq6KoWnAuAQAu9opvQ
	(envelope-from <stable+bounces-219950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:14:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B201B6FCA
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 13:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF372304E0C5
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 12:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDE63ECBD9;
	Fri, 27 Feb 2026 12:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QaUCd0vR"
X-Original-To: stable@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DE136BCC5
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772194431; cv=none; b=Y8uoqNW87Cw5yBIGPD4TKv4OqdafpNMTNXJi+Fn3fG7Dk8UAwDDQzq3UpUh/cv8woScthkcuJXZLsFhhvdb5cguGuSprSWrWAopiMIdrwdOmJoBnGMbkm72rBXjYbGDL2GzPY39zCLIkmHBESn0KOqz1jD+YPFfF/fkS67tua30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772194431; c=relaxed/simple;
	bh=fuw5TqW0uCYgMUPW4G72GmVyI0XkEmW5jQki0ebvHN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=K0Gj4SNOpsEqcH8L+XTBGOuixzlomQ9m1gPlDnhxxv8VlsTU/tLB7EDNXIwErHJrY/1vVcLMfM4+nQZfTCofFVtafotJAEWdLD+sli/xkIfpdhJhU054TLtKiiWxWUkM1BjhT6Njq4MosNlcRVOaubdQ2p/9Rnoj7ff/34C1sG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QaUCd0vR; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260227121341epoutp014f5ee4a9b6bfeb393dbe2abc1f41d028~YGW-KrGkr1058810588epoutp01_
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 12:13:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260227121341epoutp014f5ee4a9b6bfeb393dbe2abc1f41d028~YGW-KrGkr1058810588epoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772194421;
	bh=GmKOooTu6Yy+DuO6Xz9QOh3O4n8UAd3CYEIsndynAZg=;
	h=From:To:Cc:Subject:Date:References:From;
	b=QaUCd0vRtlDCk4WSwsBxqgjeqvN7ESPr2DOFRF4xuBMWZWcbG19o2iFJlF9liUrLe
	 2rKESwXImUJb/bD2TuLDD5NwzourGu5rW7zBsLvwmRNEF/m+yoqkc/C2TMmUPnOj8g
	 C4LEVDStHGTbP2PGTX2+Haq9Q0k6AS1sWPEV1UOU=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260227121340epcas5p111092699baab5569f97fae5359f8ea41~YGW_EZj6b1088610886epcas5p1V;
	Fri, 27 Feb 2026 12:13:40 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.94]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4fMnKv188tz3hhT3; Fri, 27 Feb
	2026 12:13:39 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260227121338epcas5p4baebb406db37f07223545b2f85751bf2~YGW8kxQ2F0654806548epcas5p41;
	Fri, 27 Feb 2026 12:13:38 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260227121336epsmtip18c4d77b7d34df0d5c550292966be153f~YGW6Wvejz1055710557epsmtip1z;
	Fri, 27 Feb 2026 12:13:36 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, akash.m5@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, h10.kim@samsung.com,
	shijie.cai@samsung.com, alim.akhtar@samsung.com, muhammed.ali@samsung.com,
	thiagu.r@samsung.com, pritam.sutar@samsung.com, Selvarasu Ganesan
	<selvarasu.g@samsung.com>, stable@vger.kernel.org
Subject: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts during
 StartTransfer
Date: Fri, 27 Feb 2026 17:42:33 +0530
Message-ID: <20260227121236.963-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260227121338epcas5p4baebb406db37f07223545b2f85751bf2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260227121338epcas5p4baebb406db37f07223545b2f85751bf2
References: <CGME20260227121338epcas5p4baebb406db37f07223545b2f85751bf2@epcas5p4.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219950-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:mid,samsung.com:dkim,samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvarasu.g@samsung.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E5B201B6FCA
X-Rspamd-Action: no action

The below “No resource for ep” warning appears when a StartTransfer
command is issued for bulk or interrupt endpoints in
`dwc3_gadget_ep_enable` while a previous StartTransfer on the same
endpoint is still in progress. The gadget functions drivers can invoke
`usb_ep_enable` (which triggers a new StartTransfer command) before the
earlier transfer has completed. Because the previous StartTransfer is
still active, `dwc3_gadget_ep_disable` can skip the required
`EndTransfer` due to `DWC3_EP_DELAY_STOP`, leading to the endpoint
resources are busy for previous StartTransfer and warning ("No resource
for ep") from dwc3 driver.

Additionally, a race condition exists between dwc3_gadget_ep_disable()
and dwc3_gadget_ep_queue() when manipulating dep->flags. When
dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(), the dwc->lock is
temporarily released. If dwc3_gadget_ep_queue() runs in that window, it
may set the DWC3_EP_TRANSFER_STARTED flag as part of
dwc3_send_gadget_ep_cmd(). When ep_disable resumes, it unconditionally
clears all flags except those explicitly masked, potentially clearing
DWC3_EP_TRANSFER_STARTED even though a new transfer has started. This
leads to "No resource for ep" warnings on subsequent StartTransfer
attempts.

The underlying framework issue is that usb_ep_disable() is expected to
complete pending requests before returning, but is allowed to be called
from interrupt context where sleeping to wait for completion is not
possible.

As temporary workarounds for this framework limitation:

1. In __dwc3_gadget_ep_enable(), add a check for the
   DWC3_EP_TRANSFER_STARTED flag before issuing a new StartTransfer.
   This prevents a second StartTransfer on an already busy endpoint,
   eliminating the resource conflict.

2. In __dwc3_gadget_ep_disable(), preserve the DWC3_EP_TRANSFER_STARTED
   flag when masking dep->flags if it is actually set, preventing the
   race with dwc3_gadget_ep_queue() from corrupting the flag state.

These changes eliminate the "No resource for ep" warnings and potential
kernel panics caused by panic_on_warn.

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

Cc: stable@vger.kernel.org
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
---

Note: No Fixes tag is added because this is a workaround for the
gadget framework issue where the gadget framework calls usb_ep_disable()
in interrupt context without ensuring endpoint flushing completes.
A proper fix requires refactoring the framework to make sure
usb_ep_disable is invoked in process context.

Changes in v3:
 - Revised the commit message to detail the real gadget framework issue
   pointed out by the reviewer.
 - Merged the two fixes for the same ep wringing into one patch.
Link to v2: https://lore.kernel.org/linux-usb/20251117155920.643-1-selvarasu.g@samsung.com/

Changes in v2:
- Removed change-id.
- Updated commit message.
Link to v1: https://lore.kernel.org/linux-usb/20251117152812.622-1-selvarasu.g@samsung.com/
---
 drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0a688904ce8c5..3af1bbfe3d92b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -971,8 +971,9 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
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
@@ -1096,6 +1097,23 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	 */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
 		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+
+	/*
+	 * When dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(),
+	 * the dwc->lock is temporarily released. If dwc3_gadget_ep_queue()
+	 * runs in that window it may set the DWC3_EP_TRANSFER_STARTED flag as
+	 * part of dwc3_send_gadget_ep_cmd. The original code cleared the flag
+	 * unconditionally in the mask operation, which could overwrite the
+	 * concurrent modification.
+	 *
+	 * As a workaround for the interrupt context constraint where we cannot
+	 * wait for endpoint flushing, preserve the DWC3_EP_TRANSFER_STARTED
+	 * flag if it is set, avoiding resource conflicts until the framework
+	 * is fixed to properly synchronize endpoint lifecycle management.
+	 */
+	if (dep->flags & DWC3_EP_TRANSFER_STARTED)
+		mask |= DWC3_EP_TRANSFER_STARTED;
+
 	dep->flags &= mask;
 
 	/* Clear out the ep descriptors for non-ep0 */
-- 
2.34.1


