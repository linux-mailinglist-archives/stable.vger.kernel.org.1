Return-Path: <stable+bounces-46306-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A38D0089
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 14:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC50B22BD8
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA31215ECDC;
	Mon, 27 May 2024 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HwsmG6ZF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2771015E5D3;
	Mon, 27 May 2024 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716814586; cv=none; b=B6VA8Ir2lINFZeo0f6xQv3g3zdWauiRyOSI3KMShWCdqyOlcDn0z97TR7/QzIXSeEvmwyCoP0P70YUm9PZvhJU1kUG37TwW+57qWNz6Kf+gTfP5rcFXfBxIYzopyOQsa0Z1DZE4mKJvbI7wYPqyTRX7EFPyST5zbRWrtWRbEw4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716814586; c=relaxed/simple;
	bh=cr1Bk2D+1KO60n1/YoF00oNiELr5V25NCJ8mm0tkYwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xce5lfwxREJYOzyMMgo2MLVmmTK9IZr83ppBP0ViRbOMtCc2xfyyFW5Evc2L5tFwUHSCwgHCRCjBrRlSGbYRrwrEYo/E8HmQJrGmlW3n+13alb/lx9Q88WKgyhkR+lhsWFOYBKDaFchSZs/6wHx6nJGJ6h/n+apQcq+CaHWt6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HwsmG6ZF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716814585; x=1748350585;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cr1Bk2D+1KO60n1/YoF00oNiELr5V25NCJ8mm0tkYwE=;
  b=HwsmG6ZF6/QfsvECXfktBmxpSs92u8hRzyljSEIGNmpm+hafRNhZcxOT
   o29ZcJ/4LmW/zJhNBwJ0iKyoMHRRWbeFWb1AAf59svsrACWje4n/Qik/y
   n20jvZkfqKBI/QFY4cfcAjyY6qVy4xWrMus3J3UVtncHyYzhyc2Bbqwng
   UIgR+cKDgkyJe5cKPbvrDhfzJKArS8d3fpfMvVSkTlX6XRMQ/XJa3k3uc
   nDFCuCsDeXKgGu11fUpiaNWRXEyGBZVluunpc4KEjmnqRQIwxoNAQES00
   rBbLrtagq+VfS8+FPz4e8RNCMEHycHeNAoiN39xLQBKQfcf90nlmsVMVD
   g==;
X-CSE-ConnectionGUID: pVUYMfhSRBGnQ5ckbA/SOA==
X-CSE-MsgGUID: WybSZ65WRf6LXjRmJ2DW2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11084"; a="12983988"
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="12983988"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:56:25 -0700
X-CSE-ConnectionGUID: 6vwMvZTJQ3us7qP2xlAN/Q==
X-CSE-MsgGUID: KA+s6b1AQuCE0VFRzBab5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,192,1712646000"; 
   d="scan'208";a="65975394"
Received: from unknown (HELO localhost) ([10.245.247.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 05:56:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"David E. Box" <david.e.box@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/4] x86/platform/iosf_mbi: Convert PCIBIOS_* return codes to errnos
Date: Mon, 27 May 2024 15:55:38 +0300
Message-Id: <20240527125538.13620-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
References: <20240527125538.13620-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

iosf_mbi_pci_{read,write}_mdr() use pci_{read,write}_config_dword()
that return PCIBIOS_* codes but functions also return -ENODEV which are
not compatible error codes. As neither of the functions are related to
PCI read/write functions, they should return normal errnos.

Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
errno before returning it.

Fixes: 46184415368a ("arch: x86: New MailBox support driver for Intel SOC's")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 arch/x86/platform/intel/iosf_mbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/intel/iosf_mbi.c b/arch/x86/platform/intel/iosf_mbi.c
index fdd49d70b437..c81cea208c2c 100644
--- a/arch/x86/platform/intel/iosf_mbi.c
+++ b/arch/x86/platform/intel/iosf_mbi.c
@@ -62,7 +62,7 @@ static int iosf_mbi_pci_read_mdr(u32 mcrx, u32 mcr, u32 *mdr)
 
 fail_read:
 	dev_err(&mbi_pdev->dev, "PCI config access failed with %d\n", result);
-	return result;
+	return pcibios_err_to_errno(result);
 }
 
 static int iosf_mbi_pci_write_mdr(u32 mcrx, u32 mcr, u32 mdr)
@@ -91,7 +91,7 @@ static int iosf_mbi_pci_write_mdr(u32 mcrx, u32 mcr, u32 mdr)
 
 fail_write:
 	dev_err(&mbi_pdev->dev, "PCI config access failed with %d\n", result);
-	return result;
+	return pcibios_err_to_errno(result);
 }
 
 int iosf_mbi_read(u8 port, u8 opcode, u32 offset, u32 *mdr)
-- 
2.39.2


