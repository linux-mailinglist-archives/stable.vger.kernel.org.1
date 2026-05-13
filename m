Return-Path: <stable+bounces-246842-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMMfAlB3BGqpKAIAu9opvQ
	(envelope-from <stable+bounces-246842-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:06:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD053395C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 419EB3154F62
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADA7425CCD;
	Wed, 13 May 2026 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mnej4WuZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBC542317A
	for <stable@vger.kernel.org>; Wed, 13 May 2026 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778676510; cv=none; b=vGNLubyIkBpCiicS2oL/b/lUYBpImFMDuf6j0fMYQXpfwGzJZkRXJa51FwQwmu5F0HKow027jUz80C+bHkOS85iiQp69v1xR1VvLKQH1FSbAu68RFnHf9unw+2npVVcF0hqAzVM3r2GlMIG390cXCBhmGsnn8elwzWVZ6UJdZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778676510; c=relaxed/simple;
	bh=+GsX+CdK0ydxnGXslSMT5BS3MNBH9LFYKOpievZvUwc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IZhR6SPzzwyrtd2ld0VZWvOOQXHF7CYrhhTQ9xxk+oSlXGHA7/qOcanJBj9BqvPdyCvw1pE+i9WnnElygU/WcCpqZuQ6MAzRgR5MzDKlv845B072ViFCx/DZ6J+brjojrB3aLRjvitZC2PFASvZIQLz9zPNU6NBTuPagVlIul0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mnej4WuZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-83544d05c5aso3674045b3a.2
        for <stable@vger.kernel.org>; Wed, 13 May 2026 05:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778676508; x=1779281308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+5eHMVfb/Er3xuFGOIw7f+q4SdOyV+C6CS8hVi39b+g=;
        b=mnej4WuZcLYu2spTIG5qsYwOGpRrFVWUh1G6pwOf2Mx5QM6vOMiV6D30zRyvyQEdfq
         PmxYTNYJRFI5MvXCCvaQ4eQx1ZYsdyPJW2Y/X1NN/Jzf5q0SLrhvqB2sgUAoBAVoVIr8
         fBx9mmJ/FdusAKWtzQmEWYCb9txBI9RwHIO8TMLJCHfzBCj1ffWFXKqM4Z613nojbOl1
         V1NbzgsMF8zmpmkph2/+n+uQGeicHvVjPt24LoGDs0URNtZrRasEtNLbm0Ul+yDxJqH/
         lc7yY4iIL1Ru0STc+UcnNdS3NukWypz3OdoHdRzBNkmDYUIz2P9UYbDZNeyM9celjfnV
         RwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778676508; x=1779281308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5eHMVfb/Er3xuFGOIw7f+q4SdOyV+C6CS8hVi39b+g=;
        b=aFKVturmgkZHoLPrNdaJyCbcdaRoBn/483AL/rTsyE4EHwKKmLg9Jf4kOn0+hC4je8
         WRz6e84r09lwPbtkJnhpFL5wXef0f/t+DJwDx4sgNTCBBqsS/Fr+/H7GyI2gtAsBEAkK
         KrUE7DBaq0R0fbED1Mu1o8fjSfbEsAf2WlWYPZTEmw6vYt4kFJ9bY1KgDAGKG9nrxSHS
         XgKSiQN4vX8QAOoaFwnh/+5tRNeOYTVLeW+l9S9V01CCJFTuMQxwV+0iFKU4kkxuyGVR
         0CMmSugF550sBWJ+Jz76cD76UvI8o9UZrmuR5bxeDoCB6w3N90YxBUQyxDHU7cwDIF0c
         1r+A==
X-Forwarded-Encrypted: i=1; AFNElJ9FpDTExGZUtSoBCHbyLspFPkA+HKtgYZaC4Z1Hn1IPr/Hoj07LtMO8QC6LFwIg0EG78ncjD54=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAHpWoez0j5Ov6hKJMFtbjs1POLG6illcqOH3lsbKgiLCTP4CO
	CIS0IIgmMsCNkLK7cFCHLFjy41Z9HRd+PC17ehOhOTusHm8bM+vVCBc6ZqbPrK0s6J3ttFFlUp8
	XnFIbfg==
X-Received: from pfnn24.prod.google.com ([2002:a05:6a00:2b98:b0:835:4568:a5a0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8887:0:b0:837:b5b6:1b97
 with SMTP id d2e1a72fcca58-83f03fcc53amr3291170b3a.12.1778676507889; Wed, 13
 May 2026 05:48:27 -0700 (PDT)
Date: Wed, 13 May 2026 05:48:27 -0700
In-Reply-To: <B8D6B43E-4C3D-4E1F-BD07-5632E1BBECEA@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428125632.129770-1-kas@kernel.org> <20260428125632.129770-3-kas@kernel.org>
 <bf92ebbf-8d70-406a-aea1-c11ca576de90@intel.com> <B8D6B43E-4C3D-4E1F-BD07-5632E1BBECEA@zytor.com>
Message-ID: <agRzBsoQG2C0sHxe@google.com>
Subject: Re: [PATCH v2 2/2] x86/tdx: Fix zero-extension for 32-bit port I/O
From: Sean Christopherson <seanjc@google.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Kai Huang <kai.huang@intel.com>, Borys Tsyrulnikov <tsyrulnikov.borys@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, kvm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: B9FD053395C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246842-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,redhat.com,alien8.de,linux.intel.com,gmail.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 12, 2026, H. Peter Anvin wrote:
> On May 12, 2026 6:14:13 PM PDT, Dave Hansen <dave.hansen@intel.com> wrote:
> >On 4/28/26 05:56, Kiryl Shutsemau (Meta) wrote:
> >> +	if (size == 4)
> >> +		regs->ax = 0;
> >> +	else
> >> +		regs->ax &= ~mask;
> >
> >I haven't thought about this _that_ much, but this feels wrong. Why is
> >is 4 so special cased?
> >
> >Also, what _are_ the limits on the registers that 'in' can be used on?
> >
> >RAX - n/a, no 64-bit I/O
> >EAX - size=4
> >AX  - size=2
> >AH  - n/a no encoding for inb
> >AL  - size=1
> >
> >I'd find this much easier to grasp if there was a nice table of what the
> >registers, sizes, and masks ended up being usable. As usual, x86 is
> >"fun" here.
> 
> Because zero extension only applies to dwords.
> 
> x86-64 has three subregisters per GPR:

Aren't there four?  The fourth being 31:0, which is the one that is zero-extended
and so "clobbers" 63:32.

> Bits 7-0
> Bits 15-8
> Bits 63-16

I assume you mean 15:0?  63:16 isn't addressable.  And these are the ones that
aren't zero-extended, i.e. don't "clobber" other bits.

