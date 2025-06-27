Return-Path: <stable+bounces-158787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D60AEBA12
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 16:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47DE0564094
	for <lists+stable@lfdr.de>; Fri, 27 Jun 2025 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67C2E542C;
	Fri, 27 Jun 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KsGydZeY"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED92E4251;
	Fri, 27 Jun 2025 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035300; cv=none; b=rWjzJlx/XvQZftUNExgNOvlp7YC1ruqZLR7jLlE1a3w6GgV5DBrW388TnEGHwuziCC510Z0R10MSKBwBI5yQ1G8abikCF8oZOd+ffZ+gU/UX7NuoVt9IIFB3FsG1WSdmGQ/0ePdGHOgLGOSeGyCeeDoQGnTrvaUeFRMlmQWi+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035300; c=relaxed/simple;
	bh=K6l+N8ifqM+Flxuijc9b15/P0vfZU5+LDCNITCeiCNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JACHcGIcnqbZAp/V2hH15AMxWCGjNvCikmkofOeMCc6cgGnoBwHSlKaLsF5Z9dfy+T2GQn5FtH2YBK+G00PW9OfegbHy+YsI9IjdO5Huafe2V3bh/VpvlxP+/QoQiQfhWyXN/3dCogHhSaBxO66UTQYpqQ1pofmg19rlfSWsDoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KsGydZeY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751035299; x=1782571299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K6l+N8ifqM+Flxuijc9b15/P0vfZU5+LDCNITCeiCNo=;
  b=KsGydZeYrlILQqM2stVQhsgZlES9fcoepFOsXY0RGOLMyabfN/dKyFMR
   we5D3iPCEg2A4cCkTNvohcTzNneeRiV1nQ6fj+KS83E0CY1TigrBh6Y3z
   KuWm3Bp7MaNX7oVum2H3sWSwabHdB7jNsDS9kQ8RuFpE8y8mZL3Czm2ZM
   gnd+wxLbuN1VBaYypOEZesCeQPjHnpc9MndYLPcvNKp0l6/NPkk5XYpJX
   35KCK/EO5lkMVVOjQ30FOrgPUEaEgLKVfeoXYEPHlSSkxX2TyF9vLhaxr
   FTx3gKTZhyi+owdb2isAgEpimWqBmDM3M7LaqxME2jypG2kujCU9GO5X1
   A==;
X-CSE-ConnectionGUID: 8IrwRDu7THaQlo8agpBYhw==
X-CSE-MsgGUID: jlTkYmNxRcKgmu7klxwHPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53444945"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53444945"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 07:41:38 -0700
X-CSE-ConnectionGUID: drHRAQwaR+qQWeMD++w0Zg==
X-CSE-MsgGUID: GXEimql5RSaXROXp43L/ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="156872932"
Received: from unknown (HELO mnyman-desk.fi.intel.com) ([10.237.72.199])
  by fmviesa003.fm.intel.com with ESMTP; 27 Jun 2025 07:41:37 -0700
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] xhci: dbc: Flush queued requests before stopping dbc
Date: Fri, 27 Jun 2025 17:41:22 +0300
Message-ID: <20250627144127.3889714-5-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627144127.3889714-1-mathias.nyman@linux.intel.com>
References: <20250627144127.3889714-1-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Flush dbc requests when dbc is stopped and transfer rings are freed.
Failure to flush them lead to leaking memory and dbc completing odd
requests after resuming from suspend, leading to error messages such as:

[   95.344392] xhci_hcd 0000:00:0d.0: no matched request

Cc: stable@vger.kernel.org
Fixes: dfba2174dc42 ("usb: xhci: Add DbC support in xHCI driver")
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-dbgcap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/host/xhci-dbgcap.c b/drivers/usb/host/xhci-dbgcap.c
index 0d4ce5734165..06a2edb9e86e 100644
--- a/drivers/usb/host/xhci-dbgcap.c
+++ b/drivers/usb/host/xhci-dbgcap.c
@@ -652,6 +652,10 @@ static void xhci_dbc_stop(struct xhci_dbc *dbc)
 	case DS_DISABLED:
 		return;
 	case DS_CONFIGURED:
+		spin_lock(&dbc->lock);
+		xhci_dbc_flush_requests(dbc);
+		spin_unlock(&dbc->lock);
+
 		if (dbc->driver->disconnect)
 			dbc->driver->disconnect(dbc);
 		break;
-- 
2.43.0


