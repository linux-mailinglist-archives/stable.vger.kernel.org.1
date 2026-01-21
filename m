Return-Path: <stable+bounces-210786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJSHFtkQcWlEcgAAu9opvQ
	(envelope-from <stable+bounces-210786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:46:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5905AB8C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 571477C0BE3
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 15:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD4943900C;
	Wed, 21 Jan 2026 15:37:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB20329E64
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 15:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769009832; cv=none; b=PAKf2yzvvW69AT7NL6tbLjBOzjsSbBd4sWTfO45MTlOtX1bng5lDl+uodRRjeeGyU57KwsRHK4srUdPXWOnZ96smgnbcOMx7fV/jNQOpKERiSHnJ9oosT/xAFsV0BQH30ptxO4A4YFOlJ7iBmzdOeXzXuJTp21zHF89z9rWKZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769009832; c=relaxed/simple;
	bh=KW3T0r+XxoYdzNapxqIVa/0+pNnxjuzyXoLXueLYcl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8+ozz43xMisyUHDdfCY5KOPfhRLApHE9WNga63BuXnT/zcE8HLx0gIHZxp5rCdNQB8fS5hEmOKaP69NyPOabc9kgksac9TyPSWJ4RNXOuhM/vqmZc36IPTg642Vy65F66jaMRF2lVXEU34AYPJrYMiao9kjCrw38oMFTFHvP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AD861476;
	Wed, 21 Jan 2026 07:37:02 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9351D3F632;
	Wed, 21 Jan 2026 07:37:07 -0800 (PST)
Date: Wed, 21 Jan 2026 15:37:02 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	david.spickett@arm.com, stable@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1] arm64: poe: fix stale POR_EL0 values for ptrace
Message-ID: <aXDynm0YGuNzi7B3@J2N7QTR9R3>
References: <20260121135639.1835784-1-joey.gouly@arm.com>
 <4f4b9dd9-02ed-4899-b17d-24415e50e5c3@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f4b9dd9-02ed-4899-b17d-24415e50e5c3@arm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-210786-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 1C5905AB8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 03:59:22PM +0100, Kevin Brodsky wrote:
> On 21/01/2026 14:56, Joey Gouly wrote:
> > If a process wrote to POR_EL0 and then crashed before a context switch
> > happened, the coredump would contain an incorrect value for POR_EL0.
> 
> Isn't that also a problem if using ptrace(PTRACE_GETREGSET, REGSET_POE)?

In the case of manipulating a tracee (i.e. target != current), the core
code ensures that the tracee is stopped (has context-switched out, an
hence has saved its registrer contents to memory) before the relevant
regset functions can be called.

> Just like for fpsimd, etc.

Just FYI, The FPSIMD/SVE/SME registers are a special case relative to
all the other regsets.

The FPSIMD/SVE/SME registers eagerly saved to memory (and so when a task
is scheduled out, the value in memory will be up-to-date), but they're
lazily restored (so the value in registers can be transiently stale
while the task is running), and there's a special case when scheduling a
task in where we attempt to spot if the CPU registers happen to be
up-to-date with the task.

The gist of this is that when manipulating the FPSIMD/SVE/SME regsets of
a task:

* For reads, we know that the value in memory is up-to-date unless the
  task is the current task.

* For writes (which can only occur for a tracee which is not the current
  task), we need to update some tracking data to prevent context-switch
  from reusing stale values on a CPU. That's what
  fpsimd_flush_task_state() does.

Pretty much all other regsets don't need the "flush" on writes, since
the value in memory will be loaded when the task is next scheduled in.

Mark.

