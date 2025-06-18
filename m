Return-Path: <stable+bounces-154616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 948B3ADE038
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 02:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4245A178244
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 00:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C9F208A7;
	Wed, 18 Jun 2025 00:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQcy4aDQ"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046A929A5
	for <stable@vger.kernel.org>; Wed, 18 Jun 2025 00:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207678; cv=none; b=ICmJDS9a4/9y6I/Xq/9xXMcgMTpy22b3hmW56mSvuzSJ6TsnuNGmVhxmnwMxjl4CN45JbOZ7STlNNb1o1zYMB4MYLmhxbgqDLdsS0BOzvJaIFjXtumBTunXA4mtpcAE6+HgKb6nx2yQlqaNRvEGHpo6szPVplM/bXtjA5q8zMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207678; c=relaxed/simple;
	bh=S3D7rm0Y2GsNYXbALVPZardCuP/cThaqj1rSQC1tUVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIbu0AoEbrKEhQAfVYlcNhMWmcU1asfUeMmKyHf/RSXMqYksqMKK87OBP43SytS/Ec9pv0msYaPeC7V/+/fZH9jXABBmU7ZGx7GuAyZ2VpAlIpZup4R3RYc+uBkCpBs9aokdHz1tS5knpwBwR0wkCSxobL9iQcB9WQoEGSoAfH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQcy4aDQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207677; x=1781743677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S3D7rm0Y2GsNYXbALVPZardCuP/cThaqj1rSQC1tUVU=;
  b=JQcy4aDQQqy0NRf3c28Jb/O6u3cJ9iaJsyUJjxOn5OHjTFtSyUj6uSMp
   YY2vC+B59XHaaw+Gob82TephgndAeb3M4nQJ5QGuCY/tEdmBoOPOmqnAN
   Mtj4qAqaWOSvEgVNcs3w3byDb7oIsMWw0S5/h8Hhq5692MihVUFvxhKI0
   zJkXes8mEREr0MVrfp3RwC0IXwMXWofZhsoSmH1G6xbtTxUNxF6d5Cfza
   zl8M6aq+VWhgzibst8YPjIrG3t35JQoq1gyLWEbJVr5cleBY39jRPsEC5
   /jjXtQSLoYU3t5Rqvym2uSDTcCzRLhj+Qp8SH41z47+h8OD+VHFm92v+V
   g==;
X-CSE-ConnectionGUID: roHtidVPSjK8WCQMPLBrkg==
X-CSE-MsgGUID: ZyQFC5vcR3KIcmjBShxTAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52491277"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52491277"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:47:56 -0700
X-CSE-ConnectionGUID: 8Er3hNT5QxCn0vg0MVamkA==
X-CSE-MsgGUID: DVCBl6+fR3mIicYSy1GWog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="154482743"
Received: from guptapa-dev.ostc.intel.com (HELO desk) ([10.54.69.136])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:47:57 -0700
Date: Tue, 17 Jun 2025 17:47:56 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Salvatore Bonaccorso <carnil@debian.org>, Eric Biggers <ebiggers@google.com>, 
	Dave Hansen <dave.hansen@intel.com>, "Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [PATCH 5.10 v2 15/16] x86/its: Fix build errors when CONFIG_MODULES=n
Message-ID: <20250617-its-5-10-v2-15-3e925a1512a1@linux.intel.com>
X-Mailer: b4 0.15-dev-c81fc
References: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617-its-5-10-v2-0-3e925a1512a1@linux.intel.com>

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
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/kernel/alternative.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 33d17fe84182..923b4d1e98db 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -554,6 +554,7 @@ static int emit_indirect(int op, int reg, u8 *bytes)
 
 #ifdef CONFIG_MITIGATION_ITS
 
+#ifdef CONFIG_MODULES
 static struct module *its_mod;
 static void *its_page;
 static unsigned int its_offset;
@@ -674,6 +675,14 @@ static void *its_allocate_thunk(int reg)
 
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
2.43.0



