Return-Path: <stable+bounces-104467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F809F48BA
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 11:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787D8188DBA9
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 10:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1621E5708;
	Tue, 17 Dec 2024 10:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtEZIcP+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8018B14600F;
	Tue, 17 Dec 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430745; cv=none; b=ewrkXeHX5ahf9JvAmL4YNh9nuRxiJucmgJvDvmgUTEt8HDzY7+Lk7rmYIYJYNn6MWkC232c0BiWjuUNjqUdyB5KdqEIPGyxMnNdLrOkSrTVjYGj/gFOI+2t3A5aBYAlI1L1NSdEZWn8QI+Ae++D1JlN4A/zN9wMV8CjIUO0wiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430745; c=relaxed/simple;
	bh=fHl+kamM7IjINNoBRd9ryZ9U1hUBjEjhaqNSFRkE0gE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=krCAGsZBO/Ws1jIW6fYesXFTUN9atSMaoV4hKmkrYkIQbrYkLxFvjMWOeL/xHaGqoDG09gze8lXlfavSV6VkoO/pUhVmzPkHeji6nMxNr7sV49KYnDtUr/rYWQ+L6HFIaIiOizkySzISU71CbEJG801BVP4USc4101kJGlS3ofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtEZIcP+; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734430744; x=1765966744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHl+kamM7IjINNoBRd9ryZ9U1hUBjEjhaqNSFRkE0gE=;
  b=dtEZIcP+tb6XsIQkW1FAahQdQKZWWyot2rVSED55WKFJznLOsYPyuPVB
   JKSFpF8bwF72oSZB6nDhb4qM4HB+TWZ9tuvGc45PMiS4fYNygfhz6aaVk
   8mYwr1MWDsPTNJQpAeX6DOmWndcFstLheqXMSAYLYLDlMnFeLZ3WfwEST
   SJZ29NVuqJyV9PwxjFh27X06jMnWJqGL8/g1r1hAh9QmKHnGLnl2/DK0R
   DPfcx+Oe7e+mVBf/rIoPsnlvfUCTERQGvvUiJaQdzqma6qylsmjzIeTO2
   G5xBeoQDfsvhvFuH9VjBuLG03GbSdlcKKnmS5UdCRmD8BQx3slNsEaWXb
   Q==;
X-CSE-ConnectionGUID: OFxjnW/xTMiwJG6HoJ1Dgw==
X-CSE-MsgGUID: ++Y+S0drTxywrVaT62xr5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="60236810"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="60236810"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 02:19:03 -0800
X-CSE-ConnectionGUID: oE/p5hrbQ0iC4QDeXr23dA==
X-CSE-MsgGUID: MOKugVZPSbSnm2gaZfKBhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97335958"
Received: from mattu-haswell.fi.intel.com ([10.237.72.199])
  by orviesa010.jf.intel.com with ESMTP; 17 Dec 2024 02:19:01 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] xhci: Turn NEC specific quirk for handling Stop Endpoint errors generic
Date: Tue, 17 Dec 2024 12:21:21 +0200
Message-Id: <20241217102122.2316814-2-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241217102122.2316814-1-mathias.nyman@linux.intel.com>
References: <20241217102122.2316814-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xHC hosts from several vendors have the same issue where endpoints start
so slowly that a later queued 'Stop Endpoint' command may complete before
endpoint is up and running.

The 'Stop Endpoint' command fails with context state error as the endpoint
still appears as  stopped.

See commit 42b758137601 ("usb: xhci: Limit Stop Endpoint retries") for
details

CC: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-ring.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4cf5363875c7..09b05a62375e 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1199,8 +1199,6 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Keep retrying until the EP starts and stops again, on
 			 * chips where this is known to help. Wait for 100ms.
 			 */
-			if (!(xhci->quirks & XHCI_NEC_HOST))
-				break;
 			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
 				break;
 			fallthrough;
-- 
2.25.1


