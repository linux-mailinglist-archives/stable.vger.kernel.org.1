Return-Path: <stable+bounces-86502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9FF9A0C0A
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 15:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB7F2865A4
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 13:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A500420C01B;
	Wed, 16 Oct 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FWL1oUAA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D59207206;
	Wed, 16 Oct 2024 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087082; cv=none; b=ls/ZPUHyLE4nwp7sMXTPT1GwV0pMro23cHcflRH3AhvlGkP7YawB8GWBOpDu32ybConcULhoGgUnSvRwjArsfpMsQTURUBx0AupXtEhA+j/ZvsLrgrTtoP6Hu8leGq79MDHehrxegMl7z1t3YAdAKTrPIFbIR1+l/nr0dwhzXeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087082; c=relaxed/simple;
	bh=lu1/EiX2eFn2V18PLdd/sCqnm3qRuo9tYRRBCnxq8vY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUIuk6Oep+Wcbb/8INqV7A8+ANuEtYlZHPyCUOa+bRuKcLdI02cTS/juMnTwuSt49HBFk9JY7QzZwNJu95hxAyPdjsRaB64z8hqkI46SuvvSl/lwqBbW70uNbKdPAXAAmyduUuzvHwbycqoJX9UV8tHo07qFXngGXK9hhZsGpLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FWL1oUAA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729087081; x=1760623081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lu1/EiX2eFn2V18PLdd/sCqnm3qRuo9tYRRBCnxq8vY=;
  b=FWL1oUAA9Y6BIevY2ANxZawtJ1v1AHbx+UbnpcVUqLcyp2MVIeZUEM2U
   2A7Xex1iCCWAu8+Rk5CAlQGU2mo2s6r3yDXcKEWVH0N0KeExMNgJbrJsb
   nZFq4L3KDiTRB5Sj9UQMkL2Mgj41SqJ0+vxniRuClbH+hEI91cPkQkz3i
   54FUXj0w97fuu8ZpHUtgc2OzVkrjaXIrvqq6sdsrM8Rl2lI7r7nBVhIG3
   7Yej7qcXrmrLWhYyhr+TqA9PxhaPbZ8yF9a+/hX81nePhqXOOrUbSDiWQ
   D/ztiJ5qQWSdaO3YEJ2cnM2fHhC7E74NvmZ9fJ3JUJuEuKYisn7T03KVx
   w==;
X-CSE-ConnectionGUID: MNGT44DrQTKm+xJNve/eGA==
X-CSE-MsgGUID: vmTu3H/ITPyncVZMrgh/Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="28664023"
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="28664023"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 06:58:01 -0700
X-CSE-ConnectionGUID: BkwzXJvVTiKVDy8DCQwRTA==
X-CSE-MsgGUID: PqvBrWqHSe+0RRzwnDMltA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,208,1725346800"; 
   d="scan'208";a="82776218"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by fmviesa005.fm.intel.com with ESMTP; 16 Oct 2024 06:57:59 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] xhci: Mitigate failed set dequeue pointer commands
Date: Wed, 16 Oct 2024 16:59:58 +0300
Message-Id: <20241016140000.783905-3-mathias.nyman@linux.intel.com>
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

Avoid xHC host from processing a cancelled URB by always turning
cancelled URB TDs into no-op TRBs before queuing a 'Set TR Deq' command.

If the command fails then xHC will start processing the cancelled TD
instead of skipping it once endpoint is restarted, causing issues like
Babble error.

This is not a complete solution as a failed 'Set TR Deq' command does not
guarantee xHC TRB caches are cleared.

Fixes: 4db356924a50 ("xhci: turn cancelled td cleanup to its own function")
Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4d664ba53fe9..7dedf31bbddd 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1023,7 +1023,7 @@ static int xhci_invalidate_cancelled_tds(struct xhci_virt_ep *ep)
 					td_to_noop(xhci, ring, cached_td, false);
 					cached_td->cancel_status = TD_CLEARED;
 				}
-
+				td_to_noop(xhci, ring, td, false);
 				td->cancel_status = TD_CLEARING_CACHE;
 				cached_td = td;
 				break;
-- 
2.25.1


