Return-Path: <stable+bounces-126985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7BBA7528E
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 23:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874CC16F29E
	for <lists+stable@lfdr.de>; Fri, 28 Mar 2025 22:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE6E1F09BB;
	Fri, 28 Mar 2025 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qj32QwJG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568651B87CE;
	Fri, 28 Mar 2025 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743202096; cv=none; b=onQCfdGSisb481csVjR3TXRfoPwk/gUG9/D2KdY/eQxUcjn9uXabpUNFTjf1nkYOEdtEHwFByG72zyfzYo0cVA0+8TG79EzwpTxEHqvLTEiqXaB2t13mXZ6bqd1GinBl1kglzrW/MRNaUSf/K7kSadTeSyEiBLg2VCL8zRdpRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743202096; c=relaxed/simple;
	bh=4sloUG/av0LFvUxwWcnufcvuYCNtxgg7J1iBrGjf6sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPP1DE3GbSJLIwwjtBSb3wFnmOEroxUZRbkVb1PUqqZpSX8B1M5MDLYwflTesJPMgUyAhXRWFg/Xys1Sq1E7QfhNtrMsUuFXJABT7M80oLvixZ9SAmtQiCP2vUknRNmyScZIzUfYVI5pcopb8kqmO77tZS+IG/qxqz708/kmQ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qj32QwJG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743202095; x=1774738095;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4sloUG/av0LFvUxwWcnufcvuYCNtxgg7J1iBrGjf6sk=;
  b=Qj32QwJGv/C1swYCrxu5K80BAAJbe2gF9CroEsegPykXTk0U4tVQK9cD
   hacfTOsTwcvSTe20aiIn7GuU1k6O+O6CQ3305Srliq3ggilPg2h3jl0Yj
   VaSKaPBqKvhajfMLE3cZ0fc8uGuzzJDu8mTfiSBUEhn2ZCeo5VLtvEffK
   B1by9deGKCXQaRsOvlzeTYoZlrJD28RuUCV69xJPQRJ++yc28hwN5Pmng
   PtqN7p+Te0+FRxf0fwMy5D7wFnux6HL5ALkA39II4mjokD9Tyc4xnTYRX
   QJzNrmxTpZ56OLYky2OVHv509MiRFqwXcIGvc+fVHwDfFq+1nxaa/qMHk
   g==;
X-CSE-ConnectionGUID: xe4haXQkTWOZRt+QhE/JVA==
X-CSE-MsgGUID: QpqFaMf3QPG8GRZpuTfeeA==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="55572149"
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="55572149"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 15:48:14 -0700
X-CSE-ConnectionGUID: KnynAXzjRXCkGbx4B1trng==
X-CSE-MsgGUID: vS8d9vI4Qnm6WTOZ1iojmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="130612060"
Received: from spandruv-desk.jf.intel.com ([10.54.75.16])
  by orviesa004.jf.intel.com with ESMTP; 28 Mar 2025 15:48:14 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: ISST: Correct command storage data length
Date: Fri, 28 Mar 2025 15:47:49 -0700
Message-ID: <20250328224749.2691272-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After resume/online turbo limit ratio (TRL) is restored partially if
the admin explicitly changed TRL from user space.

A hash table is used to store SST mail box and MSR settings when modified
to restore those settings after resume or online. This uses a struct
isst_cmd field "data" to store these settings. This is a 64 bit field.
But isst_store_new_cmd() is only assigning as u32. This results in
truncation of 32 bits.

Change the argument to u64 from u32.

Fixes: f607874f35cb ("platform/x86: ISST: Restore state on resume")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index dbcd3087aaa4..31239a93dd71 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -84,7 +84,7 @@ static DECLARE_HASHTABLE(isst_hash, 8);
 static DEFINE_MUTEX(isst_hash_lock);
 
 static int isst_store_new_cmd(int cmd, u32 cpu, int mbox_cmd_type, u32 param,
-			      u32 data)
+			      u64 data)
 {
 	struct isst_cmd *sst_cmd;
 
-- 
2.48.1


