Return-Path: <stable+bounces-224585-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PHLKw6RsGkukgIAu9opvQ
	(envelope-from <stable+bounces-224585-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:45:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC77258725
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C76E9302795E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161CD3F166B;
	Tue, 10 Mar 2026 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qL/Q/kuh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D9E37D13E
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 21:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773179143; cv=none; b=uphpZJKzbBptwpez2yMvpfzblY9nT5bAF9Sor17rSHgJxV2dAo5Y1GaiP+Us+UHOlEYnXT5uUfr70XEaS+JzloTLP5IySkCE56OOwkqYMP70yr8UesfEFkGu9CoaxDN+svrzbwbmViqiJHjrKySX5uoC9xfkS9QslK9tVvf/fvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773179143; c=relaxed/simple;
	bh=QlaFgsjDaKMlaefpjq5rttwOzm3rAzssFdyiWIgHHA4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jzc3g0SxYrOKN3A58KwFdpOR9fiTRVCCwughe5ckOvz9tkq+cZBA3q2oFOmskRJwv69OpGV937OMVbGn0BLUiBGZ708wgH8pdq8/SNujyGPGaDQGJ4KrA0H9tYaw5WW4Lm7wemHL/1wFCIKQ5S/p2JeRM1vWWX2/uMaLSjkyfFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qL/Q/kuh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-829ba0e63e8so1305524b3a.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 14:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773179141; x=1773783941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QVjoBlNwavndP4dpYczZRuWnT/XlWExgfJCjkiDhl4A=;
        b=qL/Q/kuhlq506ei0w748I3yKAk0vT9Tup4KmvS+twWLqlxsdLVoKLKRf2T4Ob2XD2L
         F7/0c5oYYPlU8ZuYpCyvURE9CbSyLnaalYbJdb9jwJxlIbQiXkyAiMQcuJfvuuz4OEFI
         9Q1w4LCqUd/4RsNMkZpo9mmmXEqwYcIYwiNk4sDjW6rTJV/3skK68/vl6q9sGfGOdZpF
         A6A9zscb2a29yNmYL6Mw+huRy0ptOrYep2057IwDn7rTRzggjESTPCxwkdBFHMfVv7Ut
         5nSqtOsbzf5Wtubz1gICtB4qi922uspDt2Y4zuJg2u4s5clD5L2OdI7PBGqwgSfl+r8X
         0xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773179141; x=1773783941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVjoBlNwavndP4dpYczZRuWnT/XlWExgfJCjkiDhl4A=;
        b=gNYbrO0w8ejUPBAsEwk0yLVlPgaaE5M97IAV8GSzhFPHee3NNrM4yuNVkbv9GiCMiU
         zuCKYd8AGDuE/qcVDdO6xnVm39HWAQNzoESHqKXiVGt9Zkw5MkPsNlyvOGHGZL9x4mw/
         m1Qx46Ao3zXXAWzOicb5r73GcFZy12I6z77EF11+yJPXwBRmJGxNOJ5mUbJlpC3Pz2lv
         tZcesJerM1MkQ5BavNkRMuVWeq+umlQvgeWKsuQjE60WRGPVLFbsQCDJrWwGvcU5pNLp
         AT2wcrymk/KbabzZYSSLc9lQWauuMqIRxP0KsYOSEzjnYS/bxMKpYxdEFVfNtuuXyXaJ
         1ZWA==
X-Forwarded-Encrypted: i=1; AJvYcCXj7ytK07Xf6YuFHIgloaNPdibkshjnRq4fhNxCRDVOI6KGHDYYjwQQwehcrRdCkZIAKIIFkBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvP8hE65q5yH1clRHxLlvDH35yinMzUppiOQyNkvNxWr8yyQp0
	ZaM8sIWnozauzIj4B6/p2YD3CozBFuY2NwYiG7CqssOGcD7Q3gMqKdZLDkQTXaiCAzrMKs6LGxP
	lwCKdZQ==
X-Received: from pfbif9.prod.google.com ([2002:a05:6a00:8b09:b0:829:741b:b07f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1408:b0:7fc:da5:f85c
 with SMTP id d2e1a72fcca58-829f706cf4dmr320645b3a.38.1773179141300; Tue, 10
 Mar 2026 14:45:41 -0700 (PDT)
Date: Tue, 10 Mar 2026 14:45:39 -0700
In-Reply-To: <CAO9r8zOLc030xTsnkYWvp5yUtnzQgVZnXXhvKZWC__1wRSP61A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260310202414.406078-1-pbonzini@redhat.com> <20260310202414.406078-3-pbonzini@redhat.com>
 <CAO9r8zOLc030xTsnkYWvp5yUtnzQgVZnXXhvKZWC__1wRSP61A@mail.gmail.com>
Message-ID: <abCRA_B2kHp6T7Zn@google.com>
Subject: Re: [PATCH 2/5] KVM: SVM: check validity of VMCB when returning from SMM
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	xinyang@anthropic.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Rspamd-Queue-Id: 9AC77258725
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224585-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026, Yosry Ahmed wrote:
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  arch/x86/kvm/svm/nested.c | 12 ++++++++++--
> >  arch/x86/kvm/svm/svm.c    |  4 ++++
> >  arch/x86/kvm/svm/svm.h    |  1 +
> >  3 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 7b61124051a7..de9906adb73b 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -419,6 +419,15 @@ static bool nested_vmcb_check_controls(struct kvm_vcpu *vcpu)
> >         return __nested_vmcb_check_controls(vcpu, ctl);
> >  }
> >
> > +int nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> > +{
> > +       if (!nested_vmcb_check_save(vcpu) ||
> > +           !nested_vmcb_check_controls(vcpu))
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> 
> Nit: if we make this a boolean we could just do:
> 
> bool nested_svm_check_cached_vmcb12(struct kvm_vcpu *vcpu)
> {
>        return nested_vmcb_check_save(vcpu) && nested_vmcb_check_controls(vcpu);

I don't care one way or the other for this particular patch, but once the dust
settles on nSVM (assuming it ever does) I do think we should align the "nested
check" return types across nVMX and nSVM (which is likely why Paolo ended up with
the above; I requested using -EINVAL for the nVMXx) patch.

My fairly strong preference is to use 0/-errno as "return -EINVAL" is more
obviously an error than "return true".  But we can bikeshed later :-)

