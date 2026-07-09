Return-Path: <stable+bounces-273087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PvwqLAUoUGrVuQIAu9opvQ
	(envelope-from <stable+bounces-273087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 01:00:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B847362D6
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 01:00:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=casgykTh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273087-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-273087-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D1033024E33
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 22:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71AB3B27E7;
	Thu,  9 Jul 2026 22:52:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958C3AFD08;
	Thu,  9 Jul 2026 22:52:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637527; cv=none; b=kmXyJAKrihYBT82ouOJCHgRljwcY5yo9gnarNird0PmQavcuKCG84kBkf73uqOy8x+Fd8vYwzPtRzs1mgAvvbphgdtMTSoeFd+QPnScgpRi+KeVyyUUWkDtAvr7TM94akqcOD/9szsdr5XSK9w2B1si+AIDPIYbrV9ws4k+p6Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637527; c=relaxed/simple;
	bh=gBaIPN33LfmDg4hHIaBoNItQlZ83Bm6USbEWS9KyhIY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=i3Z9tKAi7XOwYz4w2dZDmrJnd4ZzdViE8PTL3Y2KKXQJkjkO1F3zmceT03ZlBJOw+o0JszkpLf0M4q18Se/Q+kaiffE27ftMWvDUCOeEQE8FR9VUx04Im6h8m42UViPtL/r4/GDvew+yJsopmhlcOnkTivcr5tjJHWflbP0b0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=casgykTh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791EE1F000E9;
	Thu,  9 Jul 2026 22:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783637524;
	bh=Hw0YEWuasSELzyN3iJrE8ZYwT4ynNuVYIAHj0t2PlKA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=casgykThI4O4unGWnXTN9WG4KF/VKUV9GE6wYwIRge1Tt+l0NfI/WlVJnsZzjY+Dn
	 FPytoxw9GkCKjWGqUuHcEuDMu38yUmPcrSFXSAYAG08vHsPut/iQvlgqLzQeRpqunK
	 SlYYhv7OobZIYv4bhXb/mK9KVFa9Ff/2fMi9UEXHWUSzBlq1xGLr0LpXT5uqy5Ap73
	 WyILKIFInr0hVE29AWhzb1PjGfL0WBJmPtIctAzxitq98MJ/5Cg/lHePzfoxYtyZtI
	 sCf+/tG8zIvS8yNKLqRZ0VImJ4H+4D7g0gp0P2dE6i/524P30v40jS/HNxRPNe2Akd
	 twoEoZCkL4JWA==
Content-Type: multipart/mixed; boundary="===============2104876237906351994=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <de3ebfe684f280473617b560a9dcf501df07833f835a08eb6e75720cd03662b4@mail.kernel.org>
In-Reply-To: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-1-5ac5a2d6797f@linux.intel.com>
References: <20260709-cbpf-jit-spray-hardening-7-1-y-v1-1-5ac5a2d6797f@linux.intel.com>
Subject: Re: [PATCH 7.1.y 1/6] bpf: Support for hardening against JIT spraying
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,stable@vger.kernel.org,gregkh@linuxfoundation.org,sashal@kernel.org
Cc: bpf@vger.kernel.org,linux-arm-kernel@lists.infradead.org,loongarch@lists.linux.dev,linuxppc-dev@lists.ozlabs.org,linux-riscv@lists.infradead.org,x86@kernel.org,ast@kernel.org,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  9 Jul 2026 22:52:04 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-273087-lists,stable=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pawan.kumar.gupta@linux.intel.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:bpf@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-riscv@lists.infradead.org,m:x86@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@kernel.org,m:eddyz87@gmail.com,m:yonghong.song@linux.dev,m:clm@meta.com,m:ihor.solodrai@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B1B847362D6

--===============2104876237906351994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 96cce16e26dd02a8678f1e87f88a4b5cdb63b995 upstream.
> The BPF JIT allocator packs many small programs into larger executable
> allocations and reuses space within those allocations as programs are
> loaded and freed. When fresh code is written into space that a previous
> program occupied, an indirect jump into the new program can reuse a branch
> prediction left behind by the old one.
> Flush the indirect branch predictors before reusing JIT memory so that
> indirect jumps into a newly written program don't reuse predictions from an
> old program that occupied the same space.
> Introduce bpf_arch_pred_flush_enabled static key and bpf_arch_pred_flush
> static call for flushing the branch predictors on JIT memory reuse.
> Architectures that need a flush, can update it to a predictor flush
> function. By default, its a NOP and does not emit any CALL.
> Allocations larger than a pack are not covered by this flush. That is safe
> because cBPF programs (the unprivileged attack surface) are bounded well
> below a pack size. Issue a warning if this assumption is ever violated
> while the flush is active.
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

The reuse path this patch hardens (bpf_prog_pack_alloc() finding a free
area within a pack, and the size > BPF_PROG_PACK_SIZE branch) comes from
the pack allocator that first packed many programs into shared executable
allocations and reused freed space within a pack.

Should this carry a Fixes: tag pointing at that commit?

  Fixes: 57631054fae6 ("bpf: Introduce bpf_prog_pack allocator")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29054648899
--===============2104876237906351994==--

