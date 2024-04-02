Return-Path: <stable+bounces-35589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1F8950D8
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 12:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A55B25430
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB537604DD;
	Tue,  2 Apr 2024 10:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azvptlde"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B165F873
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055020; cv=none; b=hiUKmQGl+nejVFfu7vqr/hpGCdNuqqoL0hK97+XwopZP20wreQPi30OYF+iz9+ZPNlB+wXj+hsn/Cwu7ZD6zCvktWwaG8mrG3/1OxzKwsckiqCDIe7sHyGuXqMSSSKn0kqXfu7gzCzKC9mPsNllq+FYVnzBHM/mFDclbzivLH0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055020; c=relaxed/simple;
	bh=63oC4L6ipoRBRt+/3CeJ2uY/xkqUp+6LHT6UbPigB/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQn0lzsBCEl1LtzzxA/ryVnE5XTZL1Uppww+8mFb/Cne5jNUjQ21O/dPK7aFSaUoyu/acj4no1IFTOdGqIRE6KgVMmufnXhW/TxcSP59dADB/i/9rmup2GBN1d6SDs4A43zVptHNElYetgDKeo7/G/ok1SE/OU+HA0iye7Yrwu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azvptlde; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712055019; x=1743591019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=63oC4L6ipoRBRt+/3CeJ2uY/xkqUp+6LHT6UbPigB/A=;
  b=azvptldez4MItLj/6Os/TspAXgNqPQHz4+AE9/Sbw/PxPWRoSzJVv+bF
   qpHSrP0Se0pX7Ds2BwAkQxGPNszw7J3IPW1EaQENm005d4YGQfPucxV1+
   0kJfcRqlLSHK7fxDGABMm7XMYcOcJ+kNj+GsT/td57xbqhPPALIA3+ChA
   9WsZwa3KdSN+Zd44YWqzQ2QOynEfUuwHMwb1Olu4ve7LGsK+XeJ/W/64u
   35tYA/m8tB48zV6EGJSfHAD1qnVeP77uWahadY+ZZrDNoFy3huihGXb4j
   0vMPPES9OST47X0goKSHK9aMn5/IpiKB5cbOxzXeh0xIAPDb4IHRnx83x
   Q==;
X-CSE-ConnectionGUID: 0CXf8D32SWSPkYSvJOmgdg==
X-CSE-MsgGUID: X0tqE0Y3RMGR0NE/NIf+xw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="17944467"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="17944467"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:50:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; 
   d="scan'208";a="18002551"
Received: from jlawryno.igk.intel.com ([10.91.220.59])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 03:50:18 -0700
From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com,
	quic_jhugo@quicinc.com,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 8/8] accel/ivpu: Fix deadlock in context_xa
Date: Tue,  2 Apr 2024 12:49:29 +0200
Message-ID: <20240402104929.941186-9-jacek.lawrynowicz@linux.intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
References: <20240402104929.941186-1-jacek.lawrynowicz@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ivpu_device->context_xa is locked both in kernel thread and IRQ context.
It requires XA_FLAGS_LOCK_IRQ flag to be passed during initialization
otherwise the lock could be acquired from a thread and interrupted by
an IRQ that locks it for the second time causing the deadlock.

This deadlock was reported by lockdep and observed in internal tests.

Fixes: 35b137630f08 ("accel/ivpu: Introduce a new DRM driver for Intel VPU")
Cc: <stable@vger.kernel.org> # v6.3+
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 77283daaedd1..51d3f1a55d02 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -517,7 +517,7 @@ static int ivpu_dev_init(struct ivpu_device *vdev)
 	vdev->context_xa_limit.min = IVPU_USER_CONTEXT_MIN_SSID;
 	vdev->context_xa_limit.max = IVPU_USER_CONTEXT_MAX_SSID;
 	atomic64_set(&vdev->unique_id_counter, 0);
-	xa_init_flags(&vdev->context_xa, XA_FLAGS_ALLOC);
+	xa_init_flags(&vdev->context_xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 	xa_init_flags(&vdev->submitted_jobs_xa, XA_FLAGS_ALLOC1);
 	xa_init_flags(&vdev->db_xa, XA_FLAGS_ALLOC1);
 	lockdep_set_class(&vdev->submitted_jobs_xa.xa_lock, &submitted_jobs_xa_lock_class_key);
-- 
2.43.2


