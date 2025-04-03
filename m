Return-Path: <stable+bounces-127616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F88A7A6B3
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D71323BAD55
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7984D24CEE5;
	Thu,  3 Apr 2025 15:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OEi2jWjb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33775250C1F;
	Thu,  3 Apr 2025 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743693878; cv=none; b=MVFmziS1/4rpXXI5tonaiTx8THvipylRoW/d9vC5eL0k5LbxTCYXS36IKkKGDa7GIG+FO/BZ5Qs2Jq/v0xsr7xQriNijmGaF4nFI8URCCAMX1BfewoeFI9b01nreBkmuABEEqnBPg1TUsfGAKPnONZIK7XetDECYwiFGvBscmsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743693878; c=relaxed/simple;
	bh=ep0idLE7v0+2Y6ipm+jxfW2Zs9baywQ3RJAMg6FXVxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqNYiRo5F0k/hVb9bEYLQ76CbKJLu6ambKJWr+cJ7ukFT6brhBwjRRw+Kpk26nBTtQyy+fRs40KZEB1+uLJjOTaSp+K2LitAke7e46oaVVCklPbeMyzPvXgLZtlD6F0uoBZ6HN8emgyBGHf99attPDxkTrWh6d75KniAT9YEhlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OEi2jWjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CDEC4CEE3;
	Thu,  3 Apr 2025 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743693877;
	bh=ep0idLE7v0+2Y6ipm+jxfW2Zs9baywQ3RJAMg6FXVxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEi2jWjbhaA8USs0flRxQ2a/v3ehOnGgJAPK6ukq+Qj058pn+GIosuim+nCrzuZmf
	 SgmQTCEvseNtoBMR0T/vZsaT2enMdNNlaKaTmQgdpDAnxKgN8uYiXqbxwrCjrW1+rc
	 8gVG2x5yr4d1fdiWyTi80bXPTgnjJuR4NAbGd3A4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michal Pecio <michal.pecio@gmail.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 6.12 17/22] usb: xhci: Apply the link chain quirk on NEC isoc endpoints
Date: Thu,  3 Apr 2025 16:20:27 +0100
Message-ID: <20250403151622.535877208@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403151622.055059925@linuxfoundation.org>
References: <20250403151622.055059925@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Pecio <michal.pecio@gmail.com>

commit bb0ba4cb1065e87f9cc75db1fa454e56d0894d01 upstream.

Two clearly different specimens of NEC uPD720200 (one with start/stop
bug, one without) were seen to cause IOMMU faults after some Missed
Service Errors. Faulting address is immediately after a transfer ring
segment and patched dynamic debug messages revealed that the MSE was
received when waiting for a TD near the end of that segment:

[ 1.041954] xhci_hcd: Miss service interval error for slot 1 ep 2 expected TD DMA ffa08fe0
[ 1.042120] xhci_hcd: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0005 address=0xffa09000 flags=0x0000]
[ 1.042146] xhci_hcd: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0005 address=0xffa09040 flags=0x0000]

It gets even funnier if the next page is a ring segment accessible to
the HC. Below, it reports MSE in segment at ff1e8000, plows through a
zero-filled page at ff1e9000 and starts reporting events for TRBs in
page at ff1ea000 every microframe, instead of jumping to seg ff1e6000.

[ 7.041671] xhci_hcd: Miss service interval error for slot 1 ep 2 expected TD DMA ff1e8fe0
[ 7.041999] xhci_hcd: Miss service interval error for slot 1 ep 2 expected TD DMA ff1e8fe0
[ 7.042011] xhci_hcd: WARN: buffer overrun event for slot 1 ep 2 on endpoint
[ 7.042028] xhci_hcd: All TDs skipped for slot 1 ep 2. Clear skip flag.
[ 7.042134] xhci_hcd: WARN: buffer overrun event for slot 1 ep 2 on endpoint
[ 7.042138] xhci_hcd: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 2 comp_code 31
[ 7.042144] xhci_hcd: Looking for event-dma 00000000ff1ea040 trb-start 00000000ff1e6820 trb-end 00000000ff1e6820
[ 7.042259] xhci_hcd: WARN: buffer overrun event for slot 1 ep 2 on endpoint
[ 7.042262] xhci_hcd: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 2 comp_code 31
[ 7.042266] xhci_hcd: Looking for event-dma 00000000ff1ea050 trb-start 00000000ff1e6820 trb-end 00000000ff1e6820

At some point completion events change from Isoch Buffer Overrun to
Short Packet and the HC finally finds cycle bit mismatch in ff1ec000.

[ 7.098130] xhci_hcd: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 2 comp_code 13
[ 7.098132] xhci_hcd: Looking for event-dma 00000000ff1ecc50 trb-start 00000000ff1e6820 trb-end 00000000ff1e6820
[ 7.098254] xhci_hcd: ERROR Transfer event TRB DMA ptr not part of current TD ep_index 2 comp_code 13
[ 7.098256] xhci_hcd: Looking for event-dma 00000000ff1ecc60 trb-start 00000000ff1e6820 trb-end 00000000ff1e6820
[ 7.098379] xhci_hcd: Overrun event on slot 1 ep 2

It's possible that data from the isochronous device were written to
random buffers of pending TDs on other endpoints (either IN or OUT),
other devices or even other HCs in the same IOMMU domain.

Lastly, an error from a different USB device on another HC. Was it
caused by the above? I don't know, but it may have been. The disk
was working without any other issues and generated PCIe traffic to
starve the NEC of upstream BW and trigger those MSEs. The two HCs
shared one x1 slot by means of a commercial "PCIe splitter" board.

[ 7.162604] usb 10-2: reset SuperSpeed USB device number 3 using xhci_hcd
[ 7.178990] sd 9:0:0:0: [sdb] tag#0 UNKNOWN(0x2003) Result: hostbyte=0x07 driverbyte=DRIVER_OK cmd_age=0s
[ 7.179001] sd 9:0:0:0: [sdb] tag#0 CDB: opcode=0x28 28 00 04 02 ae 00 00 02 00 00
[ 7.179004] I/O error, dev sdb, sector 67284480 op 0x0:(READ) flags 0x80700 phys_seg 5 prio class 0

Fortunately, it appears that this ridiculous bug is avoided by setting
the chain bit of Link TRBs on isochronous rings. Other ancient HCs are
known which also expect the bit to be set and they ignore Link TRBs if
it's not. Reportedly, 0.95 spec guaranteed that the bit is set.

The bandwidth-starved NEC HC running a 32KB/uframe UVC endpoint reports
tens of MSEs per second and runs into the bug within seconds. Chaining
Link TRBs allows the same workload to run for many minutes, many times.

No negative side effects seen in UVC recording and UAC playback with a
few devices at full speed, high speed and SuperSpeed.

The problem doesn't reproduce on the newer Renesas uPD720201/uPD720202
and on old Etron EJ168 and VIA VL805 (but the VL805 has other bug).

[shorten line length of log snippets in commit messge -Mathias]

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20250306144954.3507700-14-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci.h |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1748,11 +1748,20 @@ static inline void xhci_write_64(struct
 }
 
 
-/* Link TRB chain should always be set on 0.95 hosts, and AMD 0.96 ISOC rings */
+/*
+ * Reportedly, some chapters of v0.95 spec said that Link TRB always has its chain bit set.
+ * Other chapters and later specs say that it should only be set if the link is inside a TD
+ * which continues from the end of one segment to the next segment.
+ *
+ * Some 0.95 hardware was found to misbehave if any link TRB doesn't have the chain bit set.
+ *
+ * 0.96 hardware from AMD and NEC was found to ignore unchained isochronous link TRBs when
+ * "resynchronizing the pipe" after a Missed Service Error.
+ */
 static inline bool xhci_link_chain_quirk(struct xhci_hcd *xhci, enum xhci_ring_type type)
 {
 	return (xhci->quirks & XHCI_LINK_TRB_QUIRK) ||
-	       (type == TYPE_ISOC && (xhci->quirks & XHCI_AMD_0x96_HOST));
+	       (type == TYPE_ISOC && (xhci->quirks & (XHCI_AMD_0x96_HOST | XHCI_NEC_HOST)));
 }
 
 /* xHCI debugging */



