Return-Path: <stable+bounces-144309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C88AB625E
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 07:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633F58632AA
	for <lists+stable@lfdr.de>; Wed, 14 May 2025 05:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6286344;
	Wed, 14 May 2025 05:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b362qHzi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E427D1CAB3
	for <stable@vger.kernel.org>; Wed, 14 May 2025 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747200944; cv=none; b=UiraYdvcCstqq6qDzfhGs6d8JctiQEEcTgSUh06bIWUJlS0wF4oU7cDjL9w1JiaGU1e/iyaXNTO4inN5boG9N40DGQkJD83uxqoJr3fXHjj1sylNXo9/VKkt2P4BnjXmP00cf1yOUPso7K7Rq9WkUUDyYZ3DlfluN0/UUABLJrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747200944; c=relaxed/simple;
	bh=yKMLxpo2aERHQV6Z3LJrdZgn54x4lw5PwBiqkHvfbWo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K0mOWHIAFkn0GrZokn/ue9hMJfZzkavnqLtmIY5aDGO8nCpHrTW+kZVV5Uma5Sk0tsXlbs7C10turxrB3gB79Z5A540SamyaFmOJ6raNs0yqfeo5Lg5mvhsYEgC6LsX+NlbaREv4uj0mRQoUy9JyFM25ajCyYXr1uNeHodDgJkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b362qHzi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747200943; x=1778736943;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yKMLxpo2aERHQV6Z3LJrdZgn54x4lw5PwBiqkHvfbWo=;
  b=b362qHziGsJHQb+XYcqNBxLlWYz3dgEDhQdGJ3p9wE2qdxAoZflrIQaK
   tykzHpCkP2cUe7lj/rx4zTx3udki/JOytO8HS6p4DjjhWDOv3Ukqp9r2A
   R5Om9mDaAcLOBapvahWEHCCxlqMwlhg//3eaVC5aIzk+VOGhiniKopfsT
   R5ysVqp4O5SKeEfYVr/3wzSaaivtosS5JOx8xFHX+WnknghKPrFpjRDoe
   9VVfcoRLIhyx4tKO2/8I4bhqtDQ2JgW6P1JwlEssJEb3JaZzJ4tJlZavw
   VG7bJ61pp6RwOPPyLi6uhDz+POcwaJJ3e7Cin8hoJZ5q8qNKHn79kcQ1+
   g==;
X-CSE-ConnectionGUID: w/aBq/BrRui3yMTT9X7jew==
X-CSE-MsgGUID: BAvccc6mTQKirIV/i9s6bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11432"; a="74479800"
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="74479800"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 22:35:42 -0700
X-CSE-ConnectionGUID: cMKXiMVXQIKmArH//tDTqw==
X-CSE-MsgGUID: BYjRR2b1SySx8ncu7u+VFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,287,1739865600"; 
   d="scan'208";a="161226128"
Received: from kandrew-mobl.amr.corp.intel.com (HELO desk) ([10.125.146.10])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2025 22:35:42 -0700
Date: Tue, 13 May 2025 22:35:40 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH 6.1 0/3] ITS fixes
Message-ID: <20250513-its-fixes-6-1-v1-0-757b4ab02c79@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIALIpJGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDU0Nj3cySYt20zIrUYl0zXUPdFCPD5FQjgySDFMMUJaCegqJUsCRQS7R
 SgGOIswdI1EzPUCm2thYAaXdH8G0AAAA=
X-Change-ID: 20250513-its-fixes-6-1-d21ce20b0d1d
X-Mailer: b4 0.14.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Two of the patches are older rethunk fixes and one is a build fix for
CONFIG_MODULES=n.

---
Borislav Petkov (AMD) (1):
      x86/alternative: Optimize returns patching

Eric Biggers (1):
      x86/its: Fix build errors when CONFIG_MODULES=n

Josh Poimboeuf (1):
      x86/alternatives: Remove faulty optimization

 arch/x86/kernel/alternative.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)
---
change-id: 20250513-its-fixes-6-1-d21ce20b0d1d


