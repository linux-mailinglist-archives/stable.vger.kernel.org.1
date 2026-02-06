Return-Path: <stable+bounces-214581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COvPNwBDhWmA+wMAu9opvQ
	(envelope-from <stable+bounces-214581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 02:25:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64873F8F43
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 02:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 537A7301A163
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 01:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72257231C91;
	Fri,  6 Feb 2026 01:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrfdle7h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202101C84C0
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 01:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770341118; cv=none; b=cQvnQz4Snpf09SJmtKv2PvA0+hiUlK85v3vIsuUAs7HokWkgR1DnG+42YQc6dubcafpiumEmcP1k8wzWr7aSEglBy0KlP60+wpxK4Z95TmgmBsiabWKpmVQTAwWtgPu5W/nW+vTDFMKdeKY6BSfx/GUQwXESI57q7e3WishGnCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770341118; c=relaxed/simple;
	bh=y4reUzXwPFzss/EyunM3xBJJqk2DQfSN4mlbRZVQsVE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fEa2WzZNBDeoHGet51+HcFNvWb+fz5NdH4K/xQ05VtOkOL3h9BHywMCZOsX06jlPDpSew3CwjasKWD9WvLMcyBZUkgw/abNztuJvr/fAgUr1wgaKgdZs7ydH2vhOXpFP61hYI4SnEmztfY/Vv3Xs5aMYUXzCVR/t+StE3OAT4nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrfdle7h; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34cc88eca7eso1376762a91.2
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 17:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770341117; x=1770945917; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bByHMfzn4dhH09NijP3EyDZ/iv4YfYmEuujKD3yNi00=;
        b=vrfdle7hJugO/UPVcDX0PVrMHFh0HBtxJMiPmqqtNje9UcC1QbxWu6IQlf5ySXDJzS
         0TD7UxAtg95NbGifIi5nbSWHaYDABQm9aqu29YI0l65TSOmkdXElKrh283PG3XwJFyRa
         hvEfclNhBZuXgZ7YDsbj2c1koS/2ine0OBE4KR2S8QyEmReQKJ04H0ifiB67fNzcUw6q
         jL6RAKO7HMyKjxn4LIO6E7yGeKFXC2BEMR8Y2dREyDG7osZqPTKHorBSJa00yeGu+U8h
         t7+2Cl7D7xwzOCOejJWzBb3dgcd+Wk98Ubf6+GGqPZxB6P3UYksyVbWEoAroupuHiPIi
         hOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770341117; x=1770945917;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bByHMfzn4dhH09NijP3EyDZ/iv4YfYmEuujKD3yNi00=;
        b=Mnu0yxjza38eGZITpPBiymBk/3UcUK2Sxal0m0rr8ZIGAAFY24qhJwjsBdBs/nPb5l
         UpobIwGijE2/2iMSEcEu+lba5AyL8dHCznNVA7YlF16+QRbrFjAUJTmQe8O/P+B+05Wj
         HQjb/7SNrasgmEhkH+kybwbxUtKBGViZ0mDwyxIaACJfzpa38nn7M9FnafXes71JkatF
         YfZaaRAvu8RYy2OzmVOF3xqhYUjABq4kSdqpdNb30X9EPEL4XkdQSUCzqKU4fPXWgGki
         OCToyOHX7l6HozucPRpimUitrUUWgCMAxo8F82lIW7xdfI27AT12vVSDjI2VZWG44P43
         8PfA==
X-Forwarded-Encrypted: i=1; AJvYcCUpDJQPe3egjz+qlBO/OdhCJnTM4CkAe6CR7gKfFfUSu5WemR0V18K8yjJ/1RoNpCBS6f9X6DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA+hInZ8b051mTEAUnBKI0cEZ5REV+VA5cNNDWW7Xynhb/z99E
	MIP6wwJ/LVYS/ONp242dkgl2YmIyY41wh8c5gvGiHHjrXwIsOZ0iaCL+up2Ri3l9i/m/gvSeyVx
	AHhGrRA==
X-Received: from pjbil4.prod.google.com ([2002:a17:90b:1644:b0:352:d19a:6739])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4d:b0:34a:b4a2:f0bf
 with SMTP id 98e67ed59e1d1-354b3c950b2mr763265a91.16.1770341117476; Thu, 05
 Feb 2026 17:25:17 -0800 (PST)
Date: Thu, 5 Feb 2026 17:25:15 -0800
In-Reply-To: <b92c2a7c7bcdc02d49eb0c0d481f682bf5d10c76@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260115011312.3675857-1-yosry.ahmed@linux.dev>
 <20260115011312.3675857-2-yosry.ahmed@linux.dev> <aYU87QeMg8_kTM-G@google.com>
 <b92c2a7c7bcdc02d49eb0c0d481f682bf5d10c76@linux.dev>
Message-ID: <aYVC-1Pk01kQVJqD@google.com>
Subject: Re: [PATCH v4 01/26] KVM: SVM: Switch svm_copy_lbrs() to a macro
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214581-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64873F8F43
X-Rspamd-Action: no action

On Fri, Feb 06, 2026, Yosry Ahmed wrote:
> February 5, 2026 at 4:59 PM, "Sean Christopherson" <seanjc@google.com> wrote:
> > On Thu, Jan 15, 2026, Yosry Ahmed wrote:
> > > In preparation for using svm_copy_lbrs() with 'struct vmcb_save_area'
> > >  without a containing 'struct vmcb', and later even 'struct
> > >  vmcb_save_area_cached', make it a macro. Pull the call to
> > >  vmcb_mark_dirty() out to the callers.
> > >  
> > >  Macros are generally not preferred compared to functions, mainly due to
> > >  type-safety. However, in this case it seems like having a simple macro
> > >  copying a few fields is better than copy-pasting the same 5 lines of
> > >  code in different places.
> > >  
> > >  On the bright side, pulling vmcb_mark_dirty() calls to the callers makes
> > >  it clear that in one case, vmcb_mark_dirty() was being called on VMCB12.
> > >  It is not architecturally defined for the CPU to clear arbitrary clean
> > >  bits, and it is not needed, so drop that one call.
> > >  
> > >  Technically fixes the non-architectural behavior of setting the dirty
> > >  bit on VMCB12.
> > > 
> > Stop. Bundling. Things. Together.
> > 
> > /shakes fist angrily
> > 
> > I was absolutely not expecting a patch titled "KVM: SVM: Switch svm_copy_lbrs()
> > to a macro" to end with a Fixes tag, and I was *really* not expecting it to also
> > be Cc'd for stable.
> > 
> > At a glance, I genuinely can't tell if you added a Fixes to scope the backport,
> > or because of the dirty vmcb12 bits thing.
> > 
> > First fix the dirty behavior (and probably tag it for stable to avoid creating
> > an unnecessary backport conflict), then in a separate patch macrofy the helper.
> > Yeah, checkpatch will "suggest" that the stable@ patch should have Fixes, but
> > for us humans, that's _useful_ information, because it says "hey you, this is a
> > dependency for an upcoming fix!". As written, I look at this patch and go "huh?".
> > (and then I look at the next patch and it all makes sense).
> 
> I agree, but fixing the dirty behavior on its own requires open-coding the
> function, then the following patch would change it to a macro and use it
> again. I was trying to minimize the noise of moving code back and forth..

I don't follow.  Isn't it just this?

@@ -848,8 +859,6 @@ void svm_copy_lbrs(struct vmcb *to_vmcb, struct vmcb *from_vmcb)
        to_vmcb->save.br_to             = from_vmcb->save.br_to;
        to_vmcb->save.last_excp_from    = from_vmcb->save.last_excp_from;
        to_vmcb->save.last_excp_to      = from_vmcb->save.last_excp_to;
-
-       vmcb_mark_dirty(to_vmcb, VMCB_LBR);
 }
 
 static void __svm_enable_lbrv(struct kvm_vcpu *vcpu)
@@ -877,6 +886,8 @@ void svm_update_lbrv(struct kvm_vcpu *vcpu)
                            (is_guest_mode(vcpu) && guest_cpu_cap_has(vcpu, X86_FEATURE_LBRV) &&
                            (svm->nested.ctl.virt_ext & LBR_CTL_ENABLE_MASK));
 
+       vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
+
        if (enable_lbrv && !current_enable_lbrv)
                __svm_enable_lbrv(vcpu);
        else if (!enable_lbrv && current_enable_lbrv)
@@ -3079,7 +3090,6 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
                        break;
 
                svm->vmcb->save.dbgctl = data;
-               vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
                svm_update_lbrv(vcpu);
                break;
        case MSR_VM_HSAVE_PA:

