Return-Path: <stable+bounces-224505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JnkC5oosGn/ggIAu9opvQ
	(envelope-from <stable+bounces-224505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 15:20:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D313C251C0F
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 15:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29B833EA176
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40540DFD6;
	Tue, 10 Mar 2026 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hitZNBiL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2B640DFB7
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150232; cv=none; b=Ut9e9Mgi5l3OGu/dDIc3ty0gDHxuOWoSbESaHfd5Wwb/E4PywwRhmtqkQ1MJM8cC4TSaxTMpDanpA2YSAPvWJ+LypYtQDT5sZHO8q2wKPvP/9xz8P8COmaDjX3rWbDpFhvqQrKk1qd0K7Ch+xntHIWp4k1wIjLB/+mCJSEWdyAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150232; c=relaxed/simple;
	bh=E+RwkapHSz9lM+BBecuOvJwlLoYN8H2Y3nfHJE6eidM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oK2p8GazPAtAy0TMpLmuKOGgkCjX0JLyQaKEMSOTnlAXIaegk2gKlj09+JywTSMEaE0h8pvqf1E+kC31Ooy9UxfSWQrL5BMJPM7fXW/UCNhDgtWB7ue6l3EdZt5F10p9TRpOB9mzRPrAwzm7Sl9lk3BnBkRJUQR8nIkMOSu7+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hitZNBiL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-829a6463afeso2244722b3a.3
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773150231; x=1773755031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BlFXAC6NpFjc8ppHZ0xc1jeIVSmvB7USqRZB0vsWL/A=;
        b=hitZNBiLdrcGKIsai/0OS723lb4IufcaDhjbR2liIB7MylmtUheeRwAGV9WgFg41N+
         rTZiTPlFXJpmXQf9FQE47lYOSNpV43m7h+d6T9y7j2lkqr6FMvu/oNxt1IDjvNmAa+3c
         J0STqlMJ0sOPhPuA6IkqpCxN1u7UAjgVJII63bqXQPnm3zV7kW+ez+fKPRYsHb2jGSTp
         lRLBjsAsYBGAJ/jI8zRC64WSDrpLRFEWa60Le7xRzx5HX2WNBBoaTYGVkpd6HLlj+hSA
         Y/hAwCJfWTEUTSKUUHXWRuyfcQEhftbpUdj0Riihs+z8r0VnOQX/Zw+gr9xbi/nrf+QY
         O7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773150231; x=1773755031;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BlFXAC6NpFjc8ppHZ0xc1jeIVSmvB7USqRZB0vsWL/A=;
        b=Iy9NxxHnGEtwfA3/LFVEHwFMXis8ldWaX/0IENiMyH0ceIp9Bj4V1c7PJWRTJtgqCk
         YaxJ0UFOctwYzYxYqaKIkhESibzGv+wy12ER+OxiE7gTiY3u7axNxyu1HyrEIxduQZuD
         u4yMjjVZzaC13qOyAIs4O72E9yY+YpuAMUOaenw9NTZEqWEqtUJAOEKB7qU8IMFFnRgN
         AcmSw4qZiOI82lnb7gFX4zj0Ffw3OYrQooH1H9jtPe8+3y6hUMQRpUSvZAUG3oFqMTcm
         JA0nKSjsdlOHY5Uurwkk042MXYePBfMwVi1Db36uZMDsTQATpPV31ydxg7OFccHQkAdu
         3xvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmoGc4vvCqNujuLQK+EpC34H13BHmXeFHVaMBJAch7bMAYI5ae7RR/pQp7gF4jAyquQ0Gf1+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWTVD50EmHc9+nSS35wAXqeqBbiJts0yvMyimo03AFdy1UiYQn
	cWyyXWGogN6EbBCr+nXCY0CJxk7TIHQzjdo+knJFPxcJLBVc2USZFwIvvGzFRCp2G8SFXCfG4uS
	LNzFEEw==
X-Received: from pfbhd10.prod.google.com ([2002:a05:6a00:658a:b0:829:7e81:95a8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1815:b0:821:8492:7f66
 with SMTP id d2e1a72fcca58-829a2ded871mr13241391b3a.22.1773150230824; Tue, 10
 Mar 2026 06:43:50 -0700 (PDT)
Date: Tue, 10 Mar 2026 06:43:49 -0700
In-Reply-To: <20260302102226.7459-2-kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302102226.7459-1-kai.huang@intel.com> <20260302102226.7459-2-kai.huang@intel.com>
Message-ID: <abAgFQVKhyig0oDj@google.com>
Subject: Re: [PATCH v2] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: dave.hansen@linux.intel.com, pbonzini@redhat.com, kas@kernel.org, 
	rick.p.edgecombe@intel.com, tglx@kernel.org, bp@alien8.de, mingo@redhat.com, 
	x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D313C251C0F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224505-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026, Kai Huang wrote:
> TDX can leave the cache in an incoherent state for the memory it uses.
> During kexec the kernel does a WBINVD for each CPU before memory gets
> reused in the second kernel.
>=20
> There were two considerations for where this WBINVD should happen.  In
> order to handle cases where the cache might get into an incoherent state
> while the kexec is in the initial stages, it is needed to do this later
> in the kexec path, when the kexecing CPU stops all remote CPUs.  However,
> the later kexec process is sensitive to existing races.  So to avoid
> perturbing that operation, it is better to do it earlier.
>=20
> The existing solution is to track the need for the kexec time WBINVD
> generically (i.e., not just for TDX) in a per-cpu var.  The late
> invocation only happens if the earlier TDX specific logic in
> tdx_cpu_flush_cache_for_kexec() didn=E2=80=99t take care of the work.  Th=
is
> earlier WBINVD logic was built into KVM=E2=80=99s existing syscore ops sh=
utdown()
> handler, which is called earlier in the kexec path.
>=20
> However, this accidentally added it to KVM=E2=80=99s unload path as well =
(also
> the "error path" when bringing up TDX during KVM module load), which
> uses the same internal functions.  This makes some sense too, though,
> because if KVM is getting unloaded, TDX cache affecting operations will
> likely cease.  So it is a good point to do the work before KVM is
> unloaded and won't have a chance to handle the shutdown operation in the
> future.
>=20
> Unfortunately this KVM unload invocation triggers a lockdep warning in
> tdx_cpu_flush_cache_for_kexec().  Since tdx_cpu_flush_cache_for_kexec()
> is doing WBINVD on a specific CPU, it has an assert for preemption being
> disabled.  This works fine for the kexec time invocation, but the KVM
> unload path calls this as part of a CPUHP callback for which, despite
> always executing on the target CPU, preemption is not disabled.
>=20
> It might be better to add the earlier invocation logic to a dedicated
> arch/x86 TDX syscore shutdown() handler, but to make the fix more
> backport friendly just adjust the lockdep assert in the
> tdx_cpu_flush_cache_for_kexec().
>=20
> The real requirement is tdx_cpu_flush_cache_for_kexec() must be done on
> the same CPU.  It's OK that it can be preempted in the middle as long as
> it won't be rescheduled to another CPU.
>=20
> Remove the too strong lockdep_assert_preemption_disabled(), and change
> this_cpu_{read|write}() to __this_cpu_{read|write}() which provide the mo=
re
> proper check (when CONFIG_DEBUG_PREEMPT is true), which checks all
> conditions that the context cannot be moved to another CPU to run in the
> middle.
>=20
> Fixes: 61221d07e815 ("KVM/TDX: Explicitly do WBINVD when no more TDX SEAM=
CALLs")
> Cc: stable@vger.kernel.org
> Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Kai Huang <kai.huang@intel.com>
> Tested-by: Vishal Verma <vishal.l.verma@intel.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

