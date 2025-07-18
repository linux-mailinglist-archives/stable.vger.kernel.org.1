Return-Path: <stable+bounces-163387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE475B0A8F6
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 18:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9364C3B4145
	for <lists+stable@lfdr.de>; Fri, 18 Jul 2025 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743521C862C;
	Fri, 18 Jul 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9kR2Z0S"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639932E5B1F
	for <stable@vger.kernel.org>; Fri, 18 Jul 2025 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857877; cv=none; b=VRQoOnImVX7ui/W6e/i4/QEWOrYLkb1uDrqyA3ZmCdxr99Ws0qT48l9oQqwZH0FgMSRUnHZsxO+eiJAaRUgrIDAzrPlXJAzd0DNNFW6p7CdDtTdi3T7sbKQHWQwLa9phOGeLoYzwADJDPnVteMefWYFXBSdkeK9Ol3pKgnAr9Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857877; c=relaxed/simple;
	bh=HFE0w/88w1Lyl/K2smHXTTk3UtGuRTe8feXkgJ+2eSc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oExlYwiG98HaqNbwWmDorDjqAPXCl0P/8wzMBCXa/oS/6coU85A1rXK9fykq+jbTo6qjj3ZZnptxprvRBCfm8fj5c7D0IwY3n5JMSf/KYoQl4jO3qSjad8CVoj6NNhc8WjH0qh7T+ZElgRPttQINrTyRQTG6ZK9tcwd5CMypDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9kR2Z0S; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2365ab89b52so21293625ad.2
        for <stable@vger.kernel.org>; Fri, 18 Jul 2025 09:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752857874; x=1753462674; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a8JmAFoZFmFF4VrncsXMPRkgu6iDWk7fhLl780SkJ+c=;
        b=D9kR2Z0SyVzKS4u22m8ZGDVCXqJtGjtcXM9vX0M/KCus153itQsYi5eu3C8c2goFUc
         CFTs7ASFR1YHrGH2UeL/7eZfMPeXqRdUQiW4PtYwF8DACnxeoW3xlbVv7xeap1Nz/z2b
         TXg2FW8SUGjHehI1BWABvt3wrZd0s6sbxPhZxU7rVuPu00ZTxq2xC0Z0lDVglsZmP23s
         +zgQ33eXMPOF2oi6l11vjhTQJC3hufrm1wZ8mLJ0IKoAHTH6CrOM23y6QOTuIFhu9CqT
         Ht+40KpO1sC5kaVe3zdv395qJoEGE8TO0vB9heFueyw82BaNMp1IrTTow2PmTFpovkPK
         cBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857874; x=1753462674;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a8JmAFoZFmFF4VrncsXMPRkgu6iDWk7fhLl780SkJ+c=;
        b=AglyeXCAO/CMWJ2CBN5LvjVL93jQfT/uyyjvSemnha/JL0HlRi22Jid/87HXvcgCje
         YeUIVO7jRUf0Z2yyOJJHYU+ea8iP1/Uc3dlmUZDx0TXTFNLaM+nPWynYqU1yXCeiIOHX
         qy9hgD3jZ2xsIdcUnwlb/BefpWWzxBOhemlo1YCkMPE9EO9CP7BtBbX8BPMkWU36XmFl
         NFB9vj4hXTWiW1O13S92fEDsuwiaZA0Y6mnpHxu7N1+45LSdoEZ2HZ0Ucoe5eU7rOIMX
         FoI4xkDMHS1z/zVIVlHbnwrpiMd6oETxVG64OeCVdJejnkijOLgbVwkfyKc57oqjgXPM
         OaUw==
X-Forwarded-Encrypted: i=1; AJvYcCXnR2qHiSgLYWPzIn9caFaLm3MD13dNqIFKN1b/Y3QeX9Zx/QxqtHxlTPejEo2PGxoYFiWfxnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+YQiw5H/Ikg2RdE109bwBEN64S55elpfSwObiiv9cPfVoCTM+
	omNyuklwhTIMP9aeJ//R1OsD1TnL6qqx2Iob++p77wjlz+ytv0oPeL5dQB/8cZPx10bO18swlL5
	Hctkx1Q==
X-Google-Smtp-Source: AGHT+IF7xn00jpbk8G2lQKjDoF2AXEZJ1VQJGfmVYlK0/PKYwzHv3a1zuyVCPoIwNei98xvSRwV+sSXMHSM=
X-Received: from pjyr8.prod.google.com ([2002:a17:90a:e188:b0:311:4bc2:3093])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:84c:b0:23e:3c33:6be8
 with SMTP id d9443c01a7336-23e3c336f4bmr36340205ad.8.1752857873730; Fri, 18
 Jul 2025 09:57:53 -0700 (PDT)
Date: Fri, 18 Jul 2025 09:57:52 -0700
In-Reply-To: <2d787a83-8440-adb1-acbd-0a68358e817d@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250716055604.2229864-1-nikunj@amd.com> <2d787a83-8440-adb1-acbd-0a68358e817d@amd.com>
Message-ID: <aHp9EGExmlq9Kx9T@google.com>
Subject: Re: [PATCH v2] KVM: SEV: Enforce minimum GHCB version requirement for
 SEV-SNP guests
From: Sean Christopherson <seanjc@google.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Nikunj A Dadhania <nikunj@amd.com>, pbonzini@redhat.com, kvm@vger.kernel.org, 
	santosh.shukla@amd.com, bp@alien8.de, Michael Roth <michael.roth@amd.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 16, 2025, Tom Lendacky wrote:
> On 7/16/25 00:56, Nikunj A Dadhania wrote:
> > ---
> >  arch/x86/kvm/svm/sev.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 95668e84ab86..fdc1309c68cb 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -406,6 +406,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
> >  	struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
> >  	struct sev_platform_init_args init_args = {0};
> >  	bool es_active = vm_type != KVM_X86_SEV_VM;
> > +	bool snp_active = vm_type == KVM_X86_SNP_VM;
> >  	u64 valid_vmsa_features = es_active ? sev_supported_vmsa_features : 0;
> >  	int ret;
> >  
> > @@ -424,6 +425,9 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
> >  	if (unlikely(sev->active))
> >  		return -EINVAL;
> >  
> > +	if (snp_active && data->ghcb_version && data->ghcb_version < 2)
> > +		return -EINVAL;
> > +
> 
> Would it make sense to move this up a little bit so that it follows the
> other ghcb_version check? This way the checks are grouped.

Yes, because there's a lot going on here, and this:

  data->ghcb_version && data->ghcb_version < 2

is an unnecesarily bizarre way of writing

  data->ghcb_version == 1

And *that* is super confusing because it begs the question of why version 0 is
ok, but version 1 is not.  And then further down I see this: 

	/*
	 * Currently KVM supports the full range of mandatory features defined
	 * by version 2 of the GHCB protocol, so default to that for SEV-ES
	 * guests created via KVM_SEV_INIT2.
	 */
	if (sev->es_active && !sev->ghcb_version)
		sev->ghcb_version = GHCB_VERSION_DEFAULT;

Rather than have a funky sequence with odd logic, set data->ghcb_version before
the SNP check.  We should also tweak the comment, because "Currently" implies
that KVM might *drop* support for mandatory features, and that definitely isn't
going to happen.  And because the reader shouldn't have to go look at sev_guest_init()
to understand what's special about KVM_SEV_INIT2.

Lastly, I think we should open code '2' and drop GHCB_VERSION_DEFAULT, because:

 - it's a conditional default
 - is not enumerated to userspace
 - changing GHCB_VERSION_DEFAULT will impact ABI and could break existing setups
 - will result in a stale if GHCB_VERSION_DEFAULT is modified
 - this new check makes me want to assert GHCB_VERSION_DEFAULT > 2

As a result, if we combine all of the above, then we effectively end up with:

	if (es_active && !data->ghcb_version)
		data->ghcb_version = GHCB_VERSION_DEFAULT;

	BUILD_BUG_ON(GHCB_VERSION_DEFAULT != 2);

which is quite silly.

So this?  Completely untested, and should probably be split over 2-3 patches.

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 2fbdebf79fbb..f068cd466ae3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -37,7 +37,6 @@
 #include "trace.h"
 
 #define GHCB_VERSION_MAX       2ULL
-#define GHCB_VERSION_DEFAULT   2ULL
 #define GHCB_VERSION_MIN       1ULL
 
 #define GHCB_HV_FT_SUPPORTED   (GHCB_HV_FT_SNP | GHCB_HV_FT_SNP_AP_CREATION)
@@ -405,6 +404,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
 {
        struct kvm_sev_info *sev = to_kvm_sev_info(kvm);
        struct sev_platform_init_args init_args = {0};
+       bool snp_active = vm_type == KVM_X86_SNP_VM;
        bool es_active = vm_type != KVM_X86_SEV_VM;
        u64 valid_vmsa_features = es_active ? sev_supported_vmsa_features : 0;
        int ret;
@@ -418,7 +418,18 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
        if (data->vmsa_features & ~valid_vmsa_features)
                return -EINVAL;
 
-       if (data->ghcb_version > GHCB_VERSION_MAX || (!es_active && data->ghcb_version))
+       if (!es_active && data->ghcb_version)
+               return -EINVAL;
+
+       /*
+        * KVM supports the full range of mandatory features defined by version
+        * 2 of the GHCB protocol, so default to that for SEV-ES guests created
+        * via KVM_SEV_INIT2 (KVM_SEV_INIT forces version 1).
+        */
+       if (es_active && !data->ghcb_version)
+               data->ghcb_version = 2;
+
+       if (snp_active && data->ghcb_version < 2)
                return -EINVAL;
 
        if (unlikely(sev->active))
@@ -429,15 +440,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
        sev->vmsa_features = data->vmsa_features;
        sev->ghcb_version = data->ghcb_version;
 
-       /*
-        * Currently KVM supports the full range of mandatory features defined
-        * by version 2 of the GHCB protocol, so default to that for SEV-ES
-        * guests created via KVM_SEV_INIT2.
-        */
-       if (sev->es_active && !sev->ghcb_version)
-               sev->ghcb_version = GHCB_VERSION_DEFAULT;
-
-       if (vm_type == KVM_X86_SNP_VM)
+       if (snp_active)
                sev->vmsa_features |= SVM_SEV_FEAT_SNP_ACTIVE;
 
        ret = sev_asid_new(sev);
@@ -455,7 +458,7 @@ static int __sev_guest_init(struct kvm *kvm, struct kvm_sev_cmd *argp,
        }
 
        /* This needs to happen after SEV/SNP firmware initialization. */
-       if (vm_type == KVM_X86_SNP_VM) {
+       if (snp_active) {
                ret = snp_guest_req_init(kvm);
                if (ret)
                        goto e_free;

