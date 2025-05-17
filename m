Return-Path: <stable+bounces-144658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A13EEABA6E3
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 02:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA191BC7EE9
	for <lists+stable@lfdr.de>; Sat, 17 May 2025 00:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB2610F9;
	Sat, 17 May 2025 00:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j4x5104D"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A322F43
	for <stable@vger.kernel.org>; Sat, 17 May 2025 00:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440204; cv=none; b=bNoW5aqnLmDz/qcvm78/QF7MPjULS73YwPV8r7DCc0FPAXw0YDM1FhZFfVjvbRMomf07AMxadNsRpEiKXOzp0cZo9tgF6eefYv0uG8FRpY1xgLcJYx1EgzPyHq3oY1gLKX/MQbbzkaRNOZmyIk2iD8zc+0LIyi51IVmXNKmXcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440204; c=relaxed/simple;
	bh=vZ/f3i5ZJN8hyVyKtriPd60sziWi6MwhGnABrfmnyeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imbbKOJU3YS0rmPJ+tsaz8KPsnWlZKsF3pFzDKpQa3opTXDLMPO0FfB5RhJ8gjcrlSHO/XkBVwJwKIbUrWuwWPS1tIWr9c01UljCsTvJduEm6bcCn0IKTMLx2tV4MXEMlJbQSmZqEy4uwOauJzRy9FjJCcY82IfnTNIb7xkzy+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j4x5104D; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747440203; x=1778976203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vZ/f3i5ZJN8hyVyKtriPd60sziWi6MwhGnABrfmnyeg=;
  b=j4x5104DFtNcOfr1zAfk/AGwnHdmLlCuTiJivKhIQGeAmcmSbn0PxfpS
   2o6hSAuQGkc/AglKhIUzDWsNCVRb7KnArQgxVSPaL7osFhDX8lbIaaQ8u
   P+mjvkGmWLRp+unsJnG22rd9+OvYMR4fG9CP/9eT4pUFllpvwbDoz9jOL
   JrYOF7spGEAvTRcp/AmmLh+A7xWAZx4lU/CfgEGDuOiPYmalWXyzBsDnJ
   pcH4MdSWq0b9P4ocI+Nd9CltHFpPUW0TYPRcugeFd/95b9aYKbhTF7Xzg
   kUOLpd+zutP4s90N9Z0HCPsojw4p4M/cAXaELnqwIsQuY3cPulOsIWokp
   g==;
X-CSE-ConnectionGUID: EHhtmQdySFaEwz4znz23og==
X-CSE-MsgGUID: SRxfFT2xSp2BOGE/M7DG5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="37043751"
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="37043751"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:03:22 -0700
X-CSE-ConnectionGUID: TY77PI2FTfqDaGh/Jrw9OA==
X-CSE-MsgGUID: isAdk9ghRN2E5d3GA+cs8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,295,1739865600"; 
   d="scan'208";a="138677968"
Received: from yzhou16-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.16])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 17:03:22 -0700
Date: Fri, 16 May 2025 17:03:22 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.15 v3 15/16] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <20250516-its-5-15-v3-15-16fcdaaea544@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>

From: Eric Biggers <ebiggers@google.com>

commit 9f35e33144ae5377d6a8de86dd3bd4d995c6ac65 upstream.

Fix several build errors when CONFIG_MODULES=n, including the following:

../arch/x86/kernel/alternative.c:195:25: error: incomplete definition of type 'struct module'
  195 |         for (int i = 0; i < mod->its_num_pages; i++) {

  [ pawan: backport: Bring ITS dynamic thunk code under CONFIG_MODULES ]

Fixes: 872df34d7c51 ("x86/its: Use dynamic thunks for indirect branches")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7f5bed8753d658393278a7e28fc9217f2036cf3a..3c08f0e25df7601d121c52310cb157e7bdcf7782 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -399,6 +399,7 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 
 #ifdef CONFIG_MITIGATION_ITS
 
+#ifdef CONFIG_MODULES
 static struct module *its_mod;
 static void *its_page;
 static unsigned int its_offset;
@@ -519,6 +520,14 @@ static void *its_allocate_thunk(int reg)
 
 	return thunk;
 }
+#else /* CONFIG_MODULES */
+
+static void *its_allocate_thunk(int reg)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_MODULES */
 
 static int __emit_trampoline(void *addr, struct insn *insn, u8 *bytes,
 			     void *call_dest, void *jmp_dest)

-- 
2.34.1



