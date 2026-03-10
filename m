Return-Path: <stable+bounces-224506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN5XAronsGnYgQIAu9opvQ
	(envelope-from <stable+bounces-224506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 15:16:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F472519EF
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 15:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 355FC310A71D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434EC38B139;
	Tue, 10 Mar 2026 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="094H314B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A1385528
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150627; cv=none; b=QQEoPrHo7Rhp5Qa9KaNZfOeugoMjOfNiG+j2hxzZ/Pt8RHUngnD2dyKPW8buHlkfH44TyMsKqoZ+E1qDzLA8pyFUfhbYAwg+o8S80MoRbwab+3wg0uuZ/ILVD8Ej+MhyrwA7Gg8XRPMynsnO1CiQPf2YPLrFxctReP2XW327dcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150627; c=relaxed/simple;
	bh=UDAVIYVO8MkFU+qiMQHrkDiQ0TTMA/qUn6QW8DiB+6g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Th7NFPL7xOXL0jYqLaeJ9VB5zLhopsoCIp0xKCOT4BwqyvpXuMNjO2x5p6n54eDntyZ2xU6TPkRhwvycAY5euRAXnkDR4+L+5D2KDQGUdvS9KBBp8YhtE6UsOtxNAcVbs2yu7+shH8N208Y0vlgWaEV7HP7zfWuWhk2y0lxXHYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=094H314B; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829a9d3073bso1500437b3a.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773150624; x=1773755424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HiFH/eYHWvWCG/nFl2Qe5nesg6mZr7zLTC2RPw3wE9Q=;
        b=094H314BcT3nh07ZmNTKbUgkI2U8AGEIIlDfmpG5TGUu1QA+pyYQJ8PoUSwbxOsgT2
         OdBXLD1m1nN4Z4FJ2kQ/asmnh2VqZYQ+GxWBmvqlW33fu/v9+xX9sNxkb6Uo48pnCMMJ
         NFxsJOBTpAzeIxiupMy/n9ZsUvDwZjpWZp/t3HCKGcWvYbd322ytA8gfDhNUAp34hP+E
         a+2425oZEQPKkaDoHdzOlmNmSKqZEd1IkoDLI/IvfeKcGStWIzweAlp8+mwUJznPhs1E
         FRe6PljJHDNu+uVJDjf27zEWhHoG9r8R5nWEbTCNGBAVT9YGA2C0Hn6RiYzedZmnizlN
         za0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773150624; x=1773755424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HiFH/eYHWvWCG/nFl2Qe5nesg6mZr7zLTC2RPw3wE9Q=;
        b=EGToX2RNGC5pPv+m+SZSc7IcqaOUmxfs5EQSOxhTsFOVr0pmGWJz9FH+U9WofEPAEt
         xDcVVmTJ8U/l8KBg1IxOHbG1YrzQODgvaEtU7q5NsfYlE+oS/6/KJvbjkEstBwsfk8m4
         LGYi8fNQXt1ddJfTS6mzH3yOjoU6k8vcNARwng2x3lrPWSYxKUjnRV8ECuTUXUx1cofc
         U0/4qdWVlSx8RGr/r0JhPNJ4BiDcV7OZmCoqJVwHuuM+4PomotXCYwSB2TS/WLpUhG9h
         yMakTDdujoIa5l+/D0nEhZK6HtVo8dAaXK7OnjA1L5Vej89zk6NxB2BKeVr4eKwjFO30
         rzVA==
X-Forwarded-Encrypted: i=1; AJvYcCVclzsDDoNiYo7RJgYjC9XhYdL6VbBiTdFHQsJrx3vGdmJfUh5O5dRo9psAftiQHu/5MH1h0Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7F/xbJgfdoxUvO5isc2F5Niu7aHKWCf+eiN3IdZ71YPd+iZK9
	MZ8/n9XtrN+F4Px5b6PCUGRJ92zHcVGp3lhyiT0GyO4RwddTcKammctDjxGpj2RwFN7pleT13tD
	/9xcNYw==
X-Received: from pfbho6.prod.google.com ([2002:a05:6a00:8806:b0:829:7b09:ceff])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4f87:b0:81f:4f05:4fe6
 with SMTP id d2e1a72fcca58-829a2d98609mr12931026b3a.1.1773150623480; Tue, 10
 Mar 2026 06:50:23 -0700 (PDT)
Date: Tue, 10 Mar 2026 06:50:21 -0700
In-Reply-To: <88b3637c84737136da1fe373cde43801845bd062.camel@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302102226.7459-1-kai.huang@intel.com> <e762ca34d2e3f3555490e158cab82292c6122857.camel@intel.com>
 <88b3637c84737136da1fe373cde43801845bd062.camel@intel.com>
Message-ID: <abAhne3A5WNARgZo@google.com>
Subject: Re: [PATCH] x86/virt/tdx: Fix lockdep assertion failure in cache
 flush for kexec
From: Sean Christopherson <seanjc@google.com>
To: Kai Huang <kai.huang@intel.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "kas@kernel.org" <kas@kernel.org>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, 
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vishal L Verma <vishal.l.verma@intel.com>, 
	"tglx@kernel.org" <tglx@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 70F472519EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224506-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026, Kai Huang wrote:
> On Mon, 2026-03-09 at 16:38 +0000, Edgecombe, Rick P wrote:
> > On Mon, 2026-03-02 at 23:22 +1300, Kai Huang wrote:
> > > Remove the too strong lockdep_assert_preemption_disabled(), and
> > > change this_cpu_{read|write}() to __this_cpu_{read|write}() which
> > > provide the more proper check (when CONFIG_DEBUG_PREEMPT is true),
> > > which checks all conditions that the context cannot be moved to
> > > another CPU to run in the middle.
> > > 
> > > Fixes: 61221d07e815 ("KVM/TDX: Explicitly do WBINVD when no more TDX
> > > SEAMCALLs")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Vishal Verma <vishal.l.verma@intel.com>
> > > Signed-off-by: Kai Huang <kai.huang@intel.com>
> > > Tested-by: Vishal Verma <vishal.l.verma@intel.com>
> > 
> > Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > 
> > But this issue is also solved by:
> > https://lore.kernel.org/kvm/20260307010358.819645-3-rick.p.edgecombe@intel.com/

Even when that series comes along, I would rather have __this_cpu_{read|write}()
instead of the explicit lockdep_assert_preemption_disabled().  Similar to the WARN
about IRQs being disabled that got removed, explicitly requiring that preemption
be disabled feels like a description of the current code, not an actual requirement.

Asserting that preemption is disabled gives the false impression that the current
task must not be scheduled out, between reading and writing cache_state_incoherent.
Which then raises the question of why scheduling out the current task is bad".

> This depends on Sean's series to move VMXON to x86 core, so it's not stable
> friendly.
> 
> > 
> > I guess that these changes are correct in either case. There is no need
> > for the stricter asserts. But depending on the order the log would be
> > confusing in the history when it talks about lockdep warnings. So we'll
> > have to keep an eye on things. If this goes first, then it's fine.
> 
> I see.  Will keep this in mind.
> 
> > 
> > You know, it might have helped to include the splat if you end up with
> > a v2.

+1.  I can read a backtrace about 10x faster than a full sentence describing the
backtrace.

