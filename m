Return-Path: <stable+bounces-20811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2575985BCFB
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2E31F2375D
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 13:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A2C6A02C;
	Tue, 20 Feb 2024 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="avwD+b+e"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5E06A327
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708434991; cv=none; b=cWrcjzz3zDHGgAl82z0oLKuwoeSegE2RReLPBV5lefxjuD1zY8/+M2hjLQqjJeEWHK3VIKBDfB7h1hRU1/oAtlfiTYR6Mz37viIFQR6Neo32IhCekZDs35xolN8uKyspQfcIKkcsx89GCb0+7OLZDmV3s4xuk0RdBlsnb4F9Uy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708434991; c=relaxed/simple;
	bh=olkWDx9Xv6JhLQ9ib6FSimuMqJFaC9KwLcSGgNHoIDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgXiMawmlb34NXOLSLpypIz6K4RTb95kHy1rXICpVIPI6B3hl90wAx86Poumyguofl4KeTS0ftrJ6zRT6vFeS5GVZTC8g9Qd2SZ1+k+akIbwieBi+wHHskT/X0FAAs6BGMnxsu1RqXDhqz5qV9IQs1bqzQo41sir7fiwwpzSdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=avwD+b+e; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708434989; x=1739970989;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=olkWDx9Xv6JhLQ9ib6FSimuMqJFaC9KwLcSGgNHoIDU=;
  b=avwD+b+eR1Tk5DontTVOEOSyLXHvQE7IQXvSj/zQYmKnxSUGThgA9naf
   b59pqFiwZvwKaooKbpiMQD0if3w/4jd2limAp01SF/wvT59/xVsAm0kIz
   UOd/gBS5g+3iQ83K9hcNEc0bC8QPJaDLFhJRGtQ2wxFKWUJEKWcOqGK48
   9GggTLh705qCVZhPT2bVLxrvY9iEw5YunfN04up6I0H/JZyyEHPUPfZ20
   85SYBjKff0WUROsh+n5xjsLDO82o/Corq+JD6nVEE4JZr2SfkcVVEmnm6
   1PCbg9NfY695Z/hwx2tmlUCW9O6pUQM8R1pNCP6S0e/5406YFXffsJByY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="5490925"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5490925"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:16:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4735430"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:16:26 -0800
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>,
	stable@vger.kernel.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Subject: [PATCH v2] accel/ivpu: Don't enable any tiles by default on VPU40xx
Date: Tue, 20 Feb 2024 14:16:24 +0100
Message-ID: <20240220131624.1447813-1-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220110830.1439719-1-jacek.lawrynowicz@linux.intel.com>
References: <20240220110830.1439719-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>

There is no point in requesting 1 tile on VPU40xx as the FW will
probably need more tiles to run workloads, so it will have to
reconfigure PLL anyway. Don't enable any tiles and allow the FW to
perform initial tile configuration.

This improves NPU boot stability as the tiles are always enabled only
by the FW from the same initial state.

Fixes: 79cdc56c4a54 ("accel/ivpu: Add initial support for VPU 4")
Cc: stable@vger.kernel.org
Signed-off-by: Andrzej Kacprowski <Andrzej.Kacprowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_hw_40xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_40xx.c b/drivers/accel/ivpu/ivpu_hw_40xx.c
index 1c995307c113..a1523d0b1ef3 100644
--- a/drivers/accel/ivpu/ivpu_hw_40xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_40xx.c
@@ -24,7 +24,7 @@
 #define SKU_HW_ID_SHIFT              16u
 #define SKU_HW_ID_MASK               0xffff0000u
 
-#define PLL_CONFIG_DEFAULT           0x1
+#define PLL_CONFIG_DEFAULT           0x0
 #define PLL_CDYN_DEFAULT             0x80
 #define PLL_EPP_DEFAULT              0x80
 #define PLL_REF_CLK_FREQ	     (50 * 1000000)
-- 
2.43.0


