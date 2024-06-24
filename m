Return-Path: <stable+bounces-54965-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B771E914026
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 03:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8DD1F234B3
	for <lists+stable@lfdr.de>; Mon, 24 Jun 2024 01:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672374409;
	Mon, 24 Jun 2024 01:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sov6rUfS"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AAEF507;
	Mon, 24 Jun 2024 01:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719193407; cv=none; b=V5fQxFnTbNnSCQtmTzLEv4lK+uBFjvplxGZ9bmxiM1kgT++GtSRpQpWyvIFlqS1/qCBaUonOIBnPtiYxhq/1byyv68kHhjMphYSCG/x9KpwXvoFxoCPWa6CIFpfIA/hBOCB1wjrUWGRwl42MrCuGopudQosSITq61mUDIKI18ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719193407; c=relaxed/simple;
	bh=HZevPcwTlaflkC7j4MO+L4+OhCr0yxD+BbEzZ4my0MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LicPuD0rYEoZR5kX2ofYdcKv9zg7zgyyfEznqZKK9MBcYSYmsVhtL7znM2/xuSwBiTTa1JmX4V//Yfy0Kc5xJyBTdLt0Yxpgh+9zwX8ns40sTaz37D6UjcRMyO57xhUnY0m4DjdI+G2w5Rsyu2k15yvdl8h8MHgGPVytr3VEYK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sov6rUfS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719193406; x=1750729406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZevPcwTlaflkC7j4MO+L4+OhCr0yxD+BbEzZ4my0MI=;
  b=Sov6rUfS65FR4wEH5lc9TLD0kCTSOZkoDB0UP3YUMX0MjryMCx+U+m3K
   pGYtXTWYZdmo1olAIhkBMrXyv5kOR5qLDlhjA2EmySuuVz3l+n+OpQVQb
   7xyeDvZ+BP1/3naOeJI2kSA2rigRtOY9Jx3uTOHJvSDDCp3pvc3oHHvEz
   dwf5cyuoOig1/F0AgdiWbYQ9bzeeqMvWhPLBtpVEr/QlKS8CgWQEKgSHh
   bRfy53PeZgJkoFpC0mNZVdGhhJhpyCzESuZb3KVcpAuKUoS1UbHZMrZTi
   fN36mfk2zJQ+l/+e95MFukieth8yLSh5kIMjO1M9n8FsUrAYkbyG8XMEl
   Q==;
X-CSE-ConnectionGUID: gzrT65HKSb+L58k1C5zufg==
X-CSE-MsgGUID: 2OQ1fRNVRbOVOIIJVnADvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="12202760"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="12202760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 18:43:25 -0700
X-CSE-ConnectionGUID: M0n8ThwGSlmzMBO8Xqi+ug==
X-CSE-MsgGUID: 8fL3OKZBTpedl/nN1I/AJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="43821235"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by orviesa007.jf.intel.com with ESMTP; 23 Jun 2024 18:43:23 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	stable@vger.kernel.org,
	Jason Chen <jason.z.chen@intel.com>
Subject: [PATCH v2 3/5] mei: vsc: Utilize the appropriate byte order swap function
Date: Mon, 24 Jun 2024 09:42:21 +0800
Message-Id: <20240624014223.4171341-4-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624014223.4171341-1-wentong.wu@intel.com>
References: <20240624014223.4171341-1-wentong.wu@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch from cpu_to_be32_array() to be32_to_cpu_array() for the
received rom data.

Fixes: 566f5ca97680 ("mei: Add transport driver for IVSC device")
Cc: stable@vger.kernel.org # for 6.8+
Signed-off-by: Wentong Wu <wentong.wu@intel.com>
Tested-by: Jason Chen <jason.z.chen@intel.com>
---
 drivers/misc/mei/vsc-tp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/vsc-tp.c b/drivers/misc/mei/vsc-tp.c
index fed156919fda..12236599649e 100644
--- a/drivers/misc/mei/vsc-tp.c
+++ b/drivers/misc/mei/vsc-tp.c
@@ -336,7 +336,7 @@ int vsc_tp_rom_xfer(struct vsc_tp *tp, const void *obuf, void *ibuf, size_t len)
 		return ret;
 
 	if (ibuf)
-		cpu_to_be32_array(ibuf, tp->rx_buf, words);
+		be32_to_cpu_array(ibuf, tp->rx_buf, words);
 
 	return ret;
 }
-- 
2.34.1


