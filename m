Return-Path: <stable+bounces-41618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B77DE8B5598
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 12:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DDA1C211E0
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF22941F;
	Mon, 29 Apr 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDaiNV1n"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980A62209F
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387328; cv=none; b=vBxSHVBRQ9rv8/vo9WNeobluSjNOv3MY1t8/1urax6xZ0AMRxkA1Af9hx7qDf1RxMFbJ5zf8/4ejDw7cKEXJFO2nisqVVpQt0B9SVj3hE/3jmr/WszUdb+S3WGRi8hNUdnVzbea/ZzAHkS282XFty+n8c7CcAtS3agkpGOIhUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387328; c=relaxed/simple;
	bh=SPji/tPmFFHL8U+kFt+PeP/ts0wBsLsJIjNj7rxU1N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxoLNr/AIk3r6vd7yXruQpr8+rKlHusCgP3K9Jdu3moDyZQUgjc5anTn8GUFd4xoZYBCUmsF7PL/BmPquv7aaEP85XTAjZ6E1M3OzYi6WMrcdCchGJbj0mZvqcUCbW5w9TmioQQoRXs+MGJQBnySv8i8qpPC9qfX4J8pnCbgRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDaiNV1n; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387327; x=1745923327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SPji/tPmFFHL8U+kFt+PeP/ts0wBsLsJIjNj7rxU1N4=;
  b=CDaiNV1naCSEWQYLlHeAYg9FC9NHDlckxPzznhvtX/2/im42RKwY/rOf
   kRuXIEXbWxwJDkkBJtGIJBHOnP7lgH+xcHF9S+GH1XjOKXiekRAl/m8b3
   alkszwFEe320QkZA6W8J5WSvkQS7eBIP4KRjxbnM0msVFeAEA0uJleVue
   a/E1MZSrcI5sob6Tidl/nB82YyVkbOetnRUSTZgOQNzklBF3b7/vRVt0y
   +eY1gWdViIyaBR57GZq47iTWTQRL8RqgDP6Cgw7dxSfTNTvTDjACG+I6A
   1KSPBFUfFVl7yiwdmq1WVctWMM8TdK8GkseN6aFDxzQuyDF6YaimkfFfI
   A==;
X-CSE-ConnectionGUID: 0s8qtijVQtiliIzLV7AQYA==
X-CSE-MsgGUID: Sit+o6jNS22BHnz7G+yaYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="9901814"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9901814"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:42:06 -0700
X-CSE-ConnectionGUID: GdMRn5SfQ1G1Zf9DrajcIA==
X-CSE-MsgGUID: GPwJqX3SQEaySR3GNopdFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="30754952"
Received: from mehlow-prequal01.jf.intel.com ([10.54.102.156])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:42:05 -0700
From: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
To: dmitry.kuvayskiy@gmail.com
Cc: stable@vger.kernel.org,
	=?UTF-8?q?Marcelina=20Ko=C5=9Bcielnicka?= <mwk@invisiblethingslab.com>,
	Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 1/2] x86/sgx: Resolve EAUG race where losing thread returns SIGBUS
Date: Mon, 29 Apr 2024 03:33:43 -0700
Message-Id: <20240429103344.3553708-2-dmitrii.kuvaiskii@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240429103344.3553708-1-dmitrii.kuvaiskii@intel.com>
References: <20240429103344.3553708-1-dmitrii.kuvaiskii@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
Content-Transfer-Encoding: 8bit

Two enclave threads may try to access the same non-present enclave page
simultaneously (e.g., if the SGX runtime supports lazy allocation). The
threads will end up in sgx_encl_eaug_page(), racing to acquire the
enclave lock. The winning thread will perform EAUG, set up the page
table entry, and insert the page into encl->page_array. The losing
thread will then get -EBUSY on xa_insert(&encl->page_array) and proceed
to error handling path.

This error handling path contains two bugs: (1) SIGBUS is sent to
userspace even though the enclave page is correctly installed by another
thread, and (2) sgx_encl_free_epc_page() is called that performs EREMOVE
even though the enclave page was never intended to be removed. The first
bug is less severe because it impacts only the user space; the second
bug is more severe because it also impacts the OS state by ripping the
page (added by the winning thread) from the enclave.

Fix these two bugs (1) by returning VM_FAULT_NOPAGE to the generic Linux
fault handler so that no signal is sent to userspace, and (2) by
replacing sgx_encl_free_epc_page() with sgx_free_epc_page() so that no
EREMOVE is performed.

Fixes: 5a90d2c3f5ef ("x86/sgx: Support adding of pages to an initialized enclave")
Cc: stable@vger.kernel.org
Reported-by: Marcelina Kościelnicka <mwk@invisiblethingslab.com>
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
---
 arch/x86/kernel/cpu/sgx/encl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..41f14b1a3025 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -382,8 +382,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 	 * If ret == -EBUSY then page was created in another flow while
 	 * running without encl->lock
 	 */
-	if (ret)
+	if (ret) {
+		if (ret == -EBUSY)
+			vmret = VM_FAULT_NOPAGE;
 		goto err_out_shrink;
+	}
 
 	pginfo.secs = (unsigned long)sgx_get_epc_virt_addr(encl->secs.epc_page);
 	pginfo.addr = encl_page->desc & PAGE_MASK;
@@ -419,7 +422,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
 err_out_shrink:
 	sgx_encl_shrink(encl, va_page);
 err_out_epc:
-	sgx_encl_free_epc_page(epc_page);
+	sgx_free_epc_page(epc_page);
 err_out_unlock:
 	mutex_unlock(&encl->lock);
 	kfree(encl_page);
-- 
2.34.1


