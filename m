Return-Path: <stable+bounces-46317-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE878D018E
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 15:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A96CB289AE
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 13:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D822515EFA1;
	Mon, 27 May 2024 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYgC0e2C"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E9E15E5CC;
	Mon, 27 May 2024 13:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816474; cv=none; b=p2AvV/3n17kDrC+q8fSTY5j78utEa4g+n40uU+EYtBywUC3QlE34wEqOgyf7Zse08psOpS39c9wAOpz3y7+rt06aTT6nWiv6eZy7Dt1c1HNo4JbaxHhuvFl451gSSVasel5Gn4RpEMAQA094W7sXiQ5HoyFE9ijl0a4pwXk1zoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816474; c=relaxed/simple;
	bh=Ho5shzf7jamCIgddhQVHwR/5KZK8nILhb4/3nb1oQ14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oc5w6cVNLgr7tA0Cjht699iuSRitGhKlWrmFf6wm6PCRrfME52TcUKVPpDw2g/jmPyFI407/jxgksgxiyJ34cYODJqsLjpHqrLaRiFlS+j+OmIIUfD0ZmgceBYxY2Yp9Q3yAAHJj7mnD2s6r9/tWlJMbsZgQGojUQQzhNZKvC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYgC0e2C; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716816473; x=1748352473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ho5shzf7jamCIgddhQVHwR/5KZK8nILhb4/3nb1oQ14=;
  b=RYgC0e2CRTyQBKgyA3Svs8bOaeBA3DlDRFGRlf8lYYnefwBXgeeThyG/
   Ygk6CkwUSKmTF9fiU8AOSKpbxix75YQXoJ8OuQlADJNqX+JOc4C5HEj3C
   KF+ATMdmfAPpeXXDOBaVWhVKkB9FIKQqllVhio1EwvUgvLjZQk3nGITg7
   g7dV4sabBCXtJD/vnarfcSCRzoP/OX0UffW4Rd2CyPK1eyZUosYyclWGt
   ucT5FPZJYx9lahOXT84BbeonQ87dHm6+Ob6d6h3TGcnZ4ybZBhVVyfMqq
   nExIrUVVxdkLiqSlnJlcbsxtUb1hHwfWzpN2M/iO7lx12iXj+WnBNZKAq
   Q==;
X-CSE-ConnectionGUID: FQOC3GARSruoHi4aKd5jHg==
X-CSE-MsgGUID: FUDVGFEMQOiogjeu+G7T3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12915461"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="12915461"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:27:52 -0700
X-CSE-ConnectionGUID: GXTp4ahSSLO1w9Kk1uMldg==
X-CSE-MsgGUID: XI2EP/mmT1miEeEtqX2WVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="34651079"
Received: from unknown (HELO localhost) ([10.245.247.140])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 06:27:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] intel_th: pci: Convert PCIBIOS_* return codes to errnos
Date: Mon, 27 May 2024 16:27:43 +0300
Message-Id: <20240527132743.14309-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

intel_th_pci_activate() uses pci_{read,write}_config_dword() that
return PCIBIOS_* codes. The value is returned as is to the caller. The
non-errno return value is returned all the way to active_store() which
then returns the value like it is an error. PCIBIOS_* return codes,
however, are positive (0x8X) so the return value of the store function
is treated as the length consumed from the write buffer which can
confuse the userspace writer.

Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
errno before returning it from intel_th_pci_activate().

Fixes: a0e7df335afd ("intel_th: Perform time resync on capture start")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/hwtracing/intel_th/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/pci.c b/drivers/hwtracing/intel_th/pci.c
index 147d338c191e..40e2c922fbe7 100644
--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -46,7 +46,7 @@ static int intel_th_pci_activate(struct intel_th *th)
 	if (err)
 		dev_err(&pdev->dev, "failed to read NPKDSC register\n");
 
-	return err;
+	return pcibios_err_to_errno(err);
 }
 
 static void intel_th_pci_deactivate(struct intel_th *th)
-- 
2.39.2


