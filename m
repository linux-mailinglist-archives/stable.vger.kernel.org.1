Return-Path: <stable+bounces-273061-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w671GQ0gUGqItgIAu9opvQ
	(envelope-from <stable+bounces-273061-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:26:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B65A7736049
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:26:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=RGKl2dGd;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273061-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273061-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E53E302BDE7
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 22:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6C3E1209;
	Thu,  9 Jul 2026 22:22:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D1C3AEF3E;
	Thu,  9 Jul 2026 22:22:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783635777; cv=none; b=FWhAZYsfdaRGnxV2rphf39SAvGnqrdKzLDb3xuO071o/kN/ip7/tV6tfif4YvRKO4dcjiS6Q/ntuuuZYWCJtJ/uBxFv/KMdoD5gY218RS8STm+JrKxIGkGaWbitmTAAjrw01P+rvTT4eymGDWk8YP5cIDcpPbWgOJ7PEjv0H4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783635777; c=relaxed/simple;
	bh=x97uFTIjXkGA6Az31J4eQq5SV3sdoZkgFYZLe5sZj3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IMo/l18PbE4yCJUu2lt/UQDZL+jdgw3LqEzEgEnmRzZ7MPQZ/MBRuMZxWk15CVDXPS+pOzzBGvgpu5BfngbLyuAYJEfpxs+um8WZzGCaSFPR0dGxtIlaZhRfiso5fRoB7qBOtT7PLHdQe0LhOinl4G6RmZBDyfoqPSWsbOy3crk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RGKl2dGd; arc=none smtp.client-ip=192.198.163.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783635776; x=1815171776;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=x97uFTIjXkGA6Az31J4eQq5SV3sdoZkgFYZLe5sZj3o=;
  b=RGKl2dGdyr3REkNeEOIXabHBTZWt5cYg8vG+L/xfyE01v8sGtPGa6eEI
   qlw0ofUyZvPPQUd/TMw/0Izs2NAzPdzr14AAfjxVoYeJBz9lfTth+o3Ih
   fqh65RGPlJh/YP/DngxfvNGpd7b7qHlea7z/g2+UcwCtZ1gZh3qzvws/Z
   YrRVsnJeEG4uT97+6qbYAjqaxrqL5eIdSYacsWnytZE0n8K31kwu45KH1
   7wrFf8WnfzLh3XWeEUmWO54S7MXG4U6VSDT5i4Z+CElb57AEbe6CW2sfW
   PxBiN1uwohhwsFLI9Wr4niUwTl2igPaNonuY1iPtIX4jNNoS4/jO/cVJ+
   w==;
X-CSE-ConnectionGUID: 6zK3tL4xTEiT2hydJBov9Q==
X-CSE-MsgGUID: +JtAOfYIQsSHqZWPVqzuZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="109881425"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="109881425"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:22:55 -0700
X-CSE-ConnectionGUID: wvvVwSEEQaq78hYluA9Epg==
X-CSE-MsgGUID: iOtP4/thR++qD9bVJxDDWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256638305"
Received: from guptapa-desk.jf.intel.com (HELO desk) ([10.165.239.46])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:22:55 -0700
Date: Thu, 9 Jul 2026 15:22:54 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: stable@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 7.1.y 0/6] cBPF JIT spray hardening
Message-ID: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-0-5ac5a2d6797f@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIADQeUGoC/yWNsQ6CMBRFf4W82Udaaqy4ERdHBzfj0JZXeAyVt
 GgkhH+36HjuTc5ZIFFkSnAqFoj05sTPkEHuCnC9CR0ht5mhEtVBaFGjs6PHgSdMYzQz9ia2FDh
 0qFHijFYpu1de1pqOkCVjJM+fX+AO1+Z2vmyrLmU5w+P/p5cdyE1bBdb1CwOyz3GSAAAA
X-Change-ID: 20260709-cbpf-jit-spray-hardening-7-1-y-b33b43f197e8
X-Mailer: b4 0.16-dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-riscv@lists.infradead.org,m:x86@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:dave.hansen@linux.intel.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pawan.kumar.gupta@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-273061-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawan.kumar.gupta@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.intel.com:mid,linux.intel.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B65A7736049

Hi,

These backports harden BPF JIT against spectre-v2 class of attacks. Without
a predictor flush, execution of new BPF program may use stale prediction
left behind by the freed one.

To avoid this, issue an IBPB flush on all CPUs on JIT program allocation.
The flush is conditional to spectre-v2 mitigation applied.

Patch 1-2: Adds the predictor flush hook and enables it on x86 via IBPB.

	  bpf: Support for hardening against JIT spraying
	  x86/bugs: Enable IBPB flush on BPF JIT allocation

Patch 3-6: Narrow the flush to only unprivileged JIT allocations
	   to avoid redundant flushes. Also adds pack-selection changes
	   that minimizes flushes.

	  bpf: Restrict JIT predictor flush to cBPF
	  bpf: Skip redundant IBPB in pack allocator
	  bpf: Prefer packs that won't trigger an IBPB flush on allocation
	  bpf: Prefer dirty packs for eBPF allocations

Note: Patches were only build tested on x86 (they applied smoothly without
any conflict).

Thanks,
Pawan

---
Pawan Gupta (6):
      bpf: Support for hardening against JIT spraying
      x86/bugs: Enable IBPB flush on BPF JIT allocation
      bpf: Restrict JIT predictor flush to cBPF
      bpf: Skip redundant IBPB in pack allocator
      bpf: Prefer packs that won't trigger an IBPB flush on allocation
      bpf: Prefer dirty packs for eBPF allocations

 arch/arm64/net/bpf_jit_comp.c        |  4 +--
 arch/loongarch/net/bpf_jit.c         |  5 +--
 arch/powerpc/net/bpf_jit_comp.c      |  4 +--
 arch/riscv/net/bpf_jit_comp64.c      |  2 +-
 arch/riscv/net/bpf_jit_core.c        |  3 +-
 arch/x86/include/asm/nospec-branch.h |  4 +++
 arch/x86/kernel/cpu/bugs.c           | 50 +++++++++++++++++++++++---
 arch/x86/net/bpf_jit_comp.c          |  5 +--
 include/linux/filter.h               | 15 ++++++--
 kernel/bpf/core.c                    | 68 ++++++++++++++++++++++++++++++++----
 kernel/bpf/dispatcher.c              |  2 +-
 11 files changed, 138 insertions(+), 24 deletions(-)
---
base-commit: 199c9959d3a9b53f346c221757fc7ac507fbac50
change-id: 20260709-cbpf-jit-spray-hardening-7-1-y-b33b43f197e8

Best regards,
--  
Thanks,
Pawan



