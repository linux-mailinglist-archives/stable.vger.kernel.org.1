Return-Path: <stable+bounces-152339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DC5AD4319
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 21:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82171733D8
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 19:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42175264A7C;
	Tue, 10 Jun 2025 19:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2Zg0A58"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EBE264A6E
	for <stable@vger.kernel.org>; Tue, 10 Jun 2025 19:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584658; cv=none; b=AciBLyvTBfYjjZR5evvPqdDl1Ni1f56x+iSY4xhZSqGjzF3SbKO7a9OwXoGU2iYiapCDhjeijoCOTwvZ8DR+daIQ5Q5LSfI+zOEPZhXfpVUuLqJkugHUO6dVfH5CHPrNHlu7JC/PEbpM65Q6g1uuLhRXfwNxKJMsDIRr97DZmjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584658; c=relaxed/simple;
	bh=6bqFEr0RxM/9Z3iW/I1uF06PaX+cz+qGRNkIoSrVZ2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVE2hGrOo3cWxHlyvfiZk2suYophCPPE2pUONrbZk1WFEbvgRc+j348BzL595cMD9cCvu0aZEwyATfn1oX8YhawG29SmAn53zYkikkoEo6f2i7tRbGIyTz8gA9k23MBNxEX/tJQJYxNNuv9mMtshi8oQyyUk1ToZzLkQfRYxSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2Zg0A58; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749584656; x=1781120656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6bqFEr0RxM/9Z3iW/I1uF06PaX+cz+qGRNkIoSrVZ2w=;
  b=F2Zg0A58g4Xnonab/YHBPyRBQ4k56nJjYIgc4eZzof2+p/aypQI/kuWv
   0m29+uAXdbk4I9CObAKq0Jr7M2m8PHFQwk0QOSsYvwGM5XnJw3rVLn86m
   ApNjdoAlesq1/kWZIWHZbN8uUUrSmJsuLp3HFFwleh6Yzs279rZ8ppZwa
   AoxoNg3erC7dCZbaiGk8NiKrvMAUy4e+DtGng0d1Sm7WhTbdIx45TEJ5a
   K+BnIKpg1FkvfvF8GSFbUNwEyl4bTgd23mcUgiiLbAiWP8JRnU/f1DNkN
   F4A7hYlReZCH627L3pyT9N++78KY+/PEFjzm+LxA/wfltxLpAn//xjwqm
   g==;
X-CSE-ConnectionGUID: 6LeRf5cqROOPJc592lhTkQ==
X-CSE-MsgGUID: ZLkGu4B4RV26wlxNbPue4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51850643"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51850643"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:44:16 -0700
X-CSE-ConnectionGUID: LvMJZq0/SfaPTClDk67OJA==
X-CSE-MsgGUID: 31IF4PnDSB2+CiQKXJ154A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="151745979"
Received: from bdahal-mobl1.amr.corp.intel.com (HELO desk) ([10.125.146.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 12:44:16 -0700
Date: Tue, 10 Jun 2025 12:44:15 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Eric Biggers <ebiggers@google.com>,
	Dave Hansen <dave.hansen@intel.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: [RFC PATCH 5.10 15/16] x86/its: Fix build errors when
 CONFIG_MODULES=n
Message-ID: <20250610-its-5-10-v1-15-64f0ae98c98d@linux.intel.com>
X-Mailer: b4 0.14.2
References: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-its-5-10-v1-0-64f0ae98c98d@linux.intel.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/alternative.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 33d17fe841828738ee248e3c2dbd2693ffd33672..923b4d1e98dbc378270e254960fcb7ce1bc3e665 100644
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
2.34.1



