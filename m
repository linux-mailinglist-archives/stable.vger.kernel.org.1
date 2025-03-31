Return-Path: <stable+bounces-127277-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB7A7714D
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 01:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F255C188D887
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 23:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BF01DEFD2;
	Mon, 31 Mar 2025 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1u+yYzi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DF8635B
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743462883; cv=none; b=YF3oM6rXPY9Q08ZdRP0q4pyERLojiBaa0Uqrg6OWH53wdFRcBkus7rzFg2BTudWg2GWi9krppGlMWpN6C1W+V5n1o0pFyS/H1F2xlKwSUXsKT0cr70uuAkfIRCtl5UqKbkuQJjNI5UZIXepPdbKCXFRZT0aqiio6ocJsPOneUJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743462883; c=relaxed/simple;
	bh=Wjc215N7L/d2KvnY1ejcna8mFdIS6Fx7ftRLZSD+jWg=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=b5ddG26VQLzgXxhX39Hw90AiYwdCs2bKouNvcIm7u1uS39oMKnzCJL8J7PP/gDKdEQHUGaZLvSZHF5ecTIR2Zqv1+A77GOwcTcawUYR7YZJH+bobKE57sr6iyA8qxdI3qF4hsbAnacca736hb4KQDkbkmeqG/wcIGYHeVg6qmns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1u+yYzi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743462881; x=1774998881;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wjc215N7L/d2KvnY1ejcna8mFdIS6Fx7ftRLZSD+jWg=;
  b=i1u+yYzijonWCxfQs3rLEZe690VbC2src/kCUzq9mRk6k0UoDYkmWan1
   56QMUI58RNnUhUwahUPktGqjhYZkG7XRdsvE8mFHiD/tLfKmjC54k3raM
   D/PFWKHCCx+ACjC8klWOREFpPAIixxEhpQNWVk7OpgvtElX3dLfEuZiEO
   j8MMt0Ou1+1tpPMrzJbcXd0G8RhW7Q5VKWdSPSYEBtStV0irlGEowoSL3
   0mCUke1rtpC+VCQPrUlSLM5R44XDF7SN0PO5vOIuDPXXVDbRYfkTsLJFX
   DqGMRHqHasTRK6YclO7RQoRgG0msWXUGKYwCmnlOBJr0Tn0j4M4w+/yGQ
   A==;
X-CSE-ConnectionGUID: qF4iL4eCQ3WCxu1NiChqsw==
X-CSE-MsgGUID: Mi2l2jcOTMuwgMFWvf/CTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="44943807"
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="44943807"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 16:14:41 -0700
X-CSE-ConnectionGUID: PSwTP5tgS4+8F89y4VHtaQ==
X-CSE-MsgGUID: ysQyX+inS4WQwVwlgWkpvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,291,1736841600"; 
   d="scan'208";a="157220620"
Received: from puneetse-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.128])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2025 16:14:41 -0700
Subject: [PATCH] x86/ioremap: Maintain consistent IORES_MAP_ENCRYPTED for
 BIOS data
From: Dan Williams <dan.j.williams@intel.com>
To: dave.hansen@linux.intel.com
Cc: x86@kernel.org, Vishal Annapurve <vannapurve@google.com>,
 Kirill Shutemov <kirill.shutemov@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>, Nikolay Borisov <nik.borisov@suse.com>,
 stable@vger.kernel.org, linux-coco@lists.linux.dev
Date: Mon, 31 Mar 2025 16:14:40 -0700
Message-ID: <174346288005.2166708.14425674491111625620.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Nikolay reports [1] that accessing BIOS data (first 1MB of the physical
address space) via /dev/mem results in an SEPT violation.

The cause is ioremap() (via xlate_dev_mem_ptr()) establishing an
unencrypted mapping where the kernel had established an encrypted
mapping previously.

Teach __ioremap_check_other() that this address space shall always be
mapped as encrypted as historically it is memory resident data, not MMIO
with side-effects.

Cc: <x86@kernel.org>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Kirill Shutemov <kirill.shutemov@linux.intel.com>
Reported-by: Nikolay Borisov <nik.borisov@suse.com>
Closes: http://lore.kernel.org/20250318113604.297726-1-nik.borisov@suse.com [1]
Tested-by: Nikolay Borisov <nik.borisov@suse.com>
Fixes: 9aa6ea69852c ("x86/tdx: Make pages shared in ioremap()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 arch/x86/mm/ioremap.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 42c90b420773..9e81286a631e 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -122,6 +122,10 @@ static void __ioremap_check_other(resource_size_t addr, struct ioremap_desc *des
 		return;
 	}
 
+	/* Ensure BIOS data (see devmem_is_allowed()) is consistently mapped */
+	if (PHYS_PFN(addr) < 256)
+		desc->flags |= IORES_MAP_ENCRYPTED;
+
 	if (!IS_ENABLED(CONFIG_EFI))
 		return;
 


