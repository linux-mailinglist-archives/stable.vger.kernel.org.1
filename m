Return-Path: <stable+bounces-121252-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC34A54E36
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 15:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3688C16A3AD
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06A41A238D;
	Thu,  6 Mar 2025 14:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSULzDA5"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E5F188736;
	Thu,  6 Mar 2025 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272589; cv=none; b=rgH0YdKYLEcPun692XDHWoawYTuN4MaYG9pY4ZrCx/7+XQxzueJqePbpMM+5w6dT/3dbXPfywpNtLqaTUqeqM4r2NWHdyrHkKiG1Pj2fewM9vfZ/VC+IFgAGlTYg45Rx5uI7jb487JdA+IzSBVwN+ezApfmn1O0Kbt42gsCidyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272589; c=relaxed/simple;
	bh=npN7YT+FCGZDJdKq2GDB5Y0sUZvaHfkB+s20EmA/Lko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSqvQZK7j3OoqmWSCLNDFTB1HnBAXgc7by39gF1TJrNCzbaTew6gBC0nj85ENnb+D6BzZrNeqKhyq6MuzIiCOt0CM7VT8IJiLExhs/QlNIiCURXBGVXz9gfYxXfXDQWkyfQeOU9Ad+fiNF8p2SvSfypwHbT3vRM3lBcJ58fjVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSULzDA5; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741272588; x=1772808588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=npN7YT+FCGZDJdKq2GDB5Y0sUZvaHfkB+s20EmA/Lko=;
  b=VSULzDA5PQsTmLoxPnbH/6R5kskL3nhDgnjzo2dRlFlxAh5ZFyJZ4LyD
   KhaFh65KOG4ZSR6uqtJNFvTgmqRGSqjQZBTt+JI0Z4Vu76KW/Sm4OoRZM
   ZR5L5ciLIXMMFvECItMXUELHVyvidbl7lnaFLE8bpcnpJoKRpqHfaYuas
   KgjlR9Li4RsLzbg31q8BxSFklOlJGi3iICoTXbvn3uNhh6h4cIKJbGXGQ
   xl6KYbVh1JxpRxDL6ICJqYOomJSqHi1Av4R53fP2d3vISqLez1hrbnfNW
   vETeshcxK9nOlGNw8H8EuOFoaBC1zxtsRwptFV8RfSt5VfbdTovy5c1A7
   g==;
X-CSE-ConnectionGUID: 5HG65KBmTYmXVzQd/ya/Xg==
X-CSE-MsgGUID: 25cMcOz8T/GipWR4Pxyj2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="67657135"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="67657135"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 06:49:47 -0800
X-CSE-ConnectionGUID: ON07u6UFRgiOG38Jq9Zv6Q==
X-CSE-MsgGUID: tZ1x9r6NQdqCwf6YynPCZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119954865"
Received: from unknown (HELO mattu-haswell.fi.intel.com) ([10.237.72.199])
  by orviesa008.jf.intel.com with ESMTP; 06 Mar 2025 06:49:45 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Michal Pecio <michal.pecio@gmail.com>,
	stable@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 13/15] usb: xhci: Apply the link chain quirk on NEC isoc endpoints
Date: Thu,  6 Mar 2025 16:49:52 +0200
Message-ID: <20250306144954.3507700-14-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306144954.3507700-1-mathias.nyman@linux.intel.com>
References: <20250306144954.3507700-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Pecio <michal.pecio@gmail.com>

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
---
 drivers/usb/host/xhci.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 4ee14f651d36..d9d7cd1906f3 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1760,11 +1760,20 @@ static inline void xhci_write_64(struct xhci_hcd *xhci,
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
-- 
2.43.0


