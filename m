Return-Path: <stable+bounces-172349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CE0B31449
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 11:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14389AE6D3F
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 09:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9822F0C6C;
	Fri, 22 Aug 2025 09:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XE4I2pyu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC01393DE3
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855661; cv=none; b=q3PO8eDGdmqoDy1vNTfDx/WV+c/UZ+TnX4QrMnMkajSmDKDhRud8fvIWBe77cD48/JzEndbNraUVbT9YOlEqiLNzbf+hU1WKmjlzfjZ2XHSgI68EVcPITnMCr3fuvu++u2J3Cxe7BUfOMpESCSv7rJJ4qiF0UHlIHArSlkkfltg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855661; c=relaxed/simple;
	bh=TdXVlHSta29BAiotJU/TYSTb59dwzDCEECq6ekRRk2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRSfMGH0Ty++cl96Gzn3pGmqQrVyY4sDv/c/tFwhVdA3SKuS6PnrRU9OU63ftAA3H2ZGZzXHXiY/FYVNNgWm7aA6L/7Hp07NX/RVRQ/yAxRZbrwiNX+fXTBR1i90Dm8jnQMQsTJ3vvaDVmQaensOOgC/ztd8paloizY84wgozO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XE4I2pyu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755855660; x=1787391660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TdXVlHSta29BAiotJU/TYSTb59dwzDCEECq6ekRRk2k=;
  b=XE4I2pyuTG7Ade2EthxWcRrmN+nW/3y6yzQWnDhYyGIZMlum/aksk3Dh
   c6vagykCmmfSGLeT9xqroJE1DKbMogVrtZ9K0NlAdSEGHHSqrbVtC5F/z
   MEkoJLT+YW+Oeq4gs9zmTjEgeqFJr0h52yc0L5JSXaHykexXCz/b0vYf0
   cA1nyamzXZk4Ih68P1+E3GwJJC3IKwCvzjSa35zmedjwdG14uMfn2Xpvw
   kt32bPX/kR/xhBTS0/HkKv2XWoc6dC4MTrm163rSqXjY36DyPZzXVnWOf
   gTDkZieB5VgcuBm1ycW195CE5Ac0S1So1FQ7a73IZ+KH2Kg/ytbeTIstF
   Q==;
X-CSE-ConnectionGUID: i/ofSe2tSTuRAcH5Gqt0Dg==
X-CSE-MsgGUID: iZITi7I0TUaykNJ++OwLuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="80760600"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="80760600"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:40:59 -0700
X-CSE-ConnectionGUID: HN1I34FnTDqeA2fF85gSKA==
X-CSE-MsgGUID: bLtWT/HxSPCJVM+gUcN11A==
X-ExtLoop1: 1
Received: from ncintean-mobl1.ger.corp.intel.com (HELO fedora) ([10.245.244.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 02:40:56 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Brian Welty <brian.welty@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	stable@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>
Subject: [PATCH v2 03/16] drm/xe/vm: Clear the scratch_pt pointer on error
Date: Fri, 22 Aug 2025 11:40:17 +0200
Message-ID: <20250822094030.3499-4-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822094030.3499-1-thomas.hellstrom@linux.intel.com>
References: <20250822094030.3499-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid triggering a dereference of an error pointer on cleanup in
xe_vm_free_scratch() by clearing any scratch_pt error pointer.

Fixes: 06951c2ee72d ("drm/xe: Use NULL PTEs as scratch PTEs")
Cc: Brian Welty <brian.welty@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_vm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index f35d69c0b4c6..529b6767caac 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -1635,8 +1635,12 @@ static int xe_vm_create_scratch(struct xe_device *xe, struct xe_tile *tile,
 
 	for (i = MAX_HUGEPTE_LEVEL; i < vm->pt_root[id]->level; i++) {
 		vm->scratch_pt[id][i] = xe_pt_create(vm, tile, i);
-		if (IS_ERR(vm->scratch_pt[id][i]))
-			return PTR_ERR(vm->scratch_pt[id][i]);
+		if (IS_ERR(vm->scratch_pt[id][i])) {
+			int err = PTR_ERR(vm->scratch_pt[id][i]);
+
+			vm->scratch_pt[id][i] = NULL;
+			return err;
+		}
 
 		xe_pt_populate_empty(tile, vm, vm->scratch_pt[id][i]);
 	}
-- 
2.50.1


