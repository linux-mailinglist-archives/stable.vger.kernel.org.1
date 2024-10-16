Return-Path: <stable+bounces-86501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E65C9A0C08
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF440286694
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BA620C00E;
	Wed, 16 Oct 2024 13:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QU/GlYuJ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5235209F29;
	Wed, 16 Oct 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087081; cv=none; b=tSWz4PBlePjh6k1BJJ6oWYnAHyM889dcSXL7AyV8tgU7tHI62vbHoHKonP/2aL0XDPkCIESJD02CX7BMdjMkbL7RDHS0U9R+bTMn+ABg9wiHuFHvXOx+o5KaN4rDe9ZngmYlsB9haDrXzFC416Xqr/Wk4+FwFkrwoHhAYjT2fFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087081; c=relaxed/simple;
	bh=n1n94pBrX90e8RweJy1ueHuQ21nejD4b5AoXSQNpog4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rhIfEExQEoZXszfmIRXQbS8nSQNhbubCqu6EIvaUM9CPYf8HQW6C5Fa2a610fNzumq5tKq/8JQuFpJeKxVZOqIsMzfFQs2zWaazBIyvyqZ8d+iT1zYUqUyppWwrx86Q4TM2QEbAHdvJsmQ7hszRI11eOSKoYLdYmqs4Xrp11wHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QU/GlYuJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729087080; x=1760623080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n1n94pBrX90e8RweJy1ueHuQ21nejD4b5AoXSQNpog4=;
  b=QU/GlYuJ+8BgamiIw1WpsqmDn2JpH7ewwTT4Vmk8k2vjNFdlkeAk6xdI
   Z+bYPAOFMHPpEQVqZNriWgcCo/e0g7asgQhN6jTtrgiBArffYeBHH1dvh
   ZjplJt5vyCp9vnu6EruOUoKdp2xyfvmHyLXurmpCE67aKKHxcSXD3Qa5/
   sCs2NS/Qjkp2KWaQE8tKhTo9GHSEVsxuH5Et89+ZuX5oxlnAtdv/FWoDe
   ealPafQ9vYLWUxkdmePbi0Psr8wviB8gKleG4BmZn/RCDJrlzPQErvBmb
   yQ6tiGc8UwBJB3PwGrpX6ZC4N0deno2dkM+54qonw0KWPrOQq4kdRoQLJ
   A==;
X-CSE-ConnectionGUID: 70aVMG2lQxCvGECIjdHN0A==
X-CSE-MsgGUID: +v7HcHs3RN+HLuBaoOM5VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="28664019"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="28664019"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:57:59 -0700
X-CSE-ConnectionGUID: yCcYBNNeRZmWj7G8nKLbrg==
X-CSE-MsgGUID: 0Uoz+i7dTAKQfxmDghbbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82776216"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa005.fm.intel.com with ESMTP; 16 Oct 2024 06:57:58 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] xhci: Fix incorrect stream context type macro
Date: Wed, 16 Oct 2024 16:59:57 +0300
Message-Id: <20241016140000.783905-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016140000.783905-1-mathias.nyman@linux.intel.com>
References: <20241016140000.783905-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The stream contex type (SCT) bitfield is used both in the stream context
data structure,  and in the 'Set TR Dequeue pointer' command TRB.
In both cases it uses bits 3:1

The SCT_FOR_TRB(p) macro used to set the stream context type (SCT) field
for the 'Set TR Dequeue pointer' command TRB incorrectly shifts the value
1 bit left before masking the three bits.

Fix this by first masking and rshifting, just like the similar
SCT_FOR_CTX(p) macro does

This issue has not been visibile as the lost bit 3 is only used with
secondary stream arrays (SSA). Xhci driver currently only supports using
a primary stream array with Linear stream addressing.

Fixes: 95241dbdf828 ("xhci: Set SCT field for Set TR dequeue on streams")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 620502de971a..f0fb696d5619 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1001,7 +1001,7 @@ enum xhci_setup_dev {
 /* Set TR Dequeue Pointer command TRB fields, 6.4.3.9 */
 #define TRB_TO_STREAM_ID(p)		((((p) & (0xffff << 16)) >> 16))
 #define STREAM_ID_FOR_TRB(p)		((((p)) & 0xffff) << 16)
-#define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
+#define SCT_FOR_TRB(p)			(((p) & 0x7) << 1)
 
 /* Link TRB specific fields */
 #define TRB_TC			(1<<1)
-- 
2.25.1


