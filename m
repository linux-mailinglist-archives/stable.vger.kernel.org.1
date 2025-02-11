Return-Path: <stable+bounces-114962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D166A317D0
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 22:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D633A0F67
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 21:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DCB26A1A5;
	Tue, 11 Feb 2025 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yt2jK6fM"
X-Original-To: Stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8C2268FE8
	for <Stable@vger.kernel.org>; Tue, 11 Feb 2025 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739309525; cv=none; b=D3298yvofhoGm91GskN51JQKZW0B2IWGibp3Lx9kxU7M48I5u6zmsIYeK44gVR0Vlf+m6UG8QZOPc8kRYdzDbM8vhdcLajU4WlRZeRGK2noLEsI9CVfXkYPIeZLCtlcwsnyU2L5GEjZHEBgnx7y1x6kSH/ufoCLZQM4/4TufPfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739309525; c=relaxed/simple;
	bh=+LUKvtaq5+tVeSV8nn8P/esQQflfMiqhA8o10k5cyOo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n0QOeNbeJiMJc+f3ZcIUdOe33zfeLCWsoXfMNTgRrFflJcpKRm8NU8bjyS9FESzcEqTBARQ0ACus0htQRLHZKIUUVaPFfDl29/LcUMZsWhN/iYWUyfpMIFyfFHMhWh2KSdlQJxFdEplA2KpeP7BLItkKKk3CwuH/o06EV2WCd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yt2jK6fM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21f6a47d5d7so107320005ad.0
        for <Stable@vger.kernel.org>; Tue, 11 Feb 2025 13:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739309516; x=1739914316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VkaRbODbKGzYYO3d8B5U658Dnrd7njXNzj1iv9zbjaI=;
        b=Yt2jK6fMaUwYFu0R9BfXwO83HnbAB3nmoxfLcm+fATbbAFSn9X7ilBa+qr+46Ak5wv
         iBBTLZEDyCzyyvBIAQuRe4nFLpU4yySP/Byy2S1Z5yPhuPYoBbjLcFWX4YFBMcHFWhcP
         5Yst1KkcHP+8EKveA5hY8hkId7TjWtpZok0ywaEQVAdRz4aado8DP+BptaqpMn7P6kFI
         gPK1GUc0CdwBK25lpYhSAFb7aC1gR4Cv6u4MKpJJQz3Q/E7J0zACyDAj1wd01JZRspu0
         KX2yG4lTy7WjQjNhjO6+A/aKApo3DiTLZxx+0v8eO6FqzvqBsGIuSsbbEdbtEatj3BtJ
         Kt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739309516; x=1739914316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkaRbODbKGzYYO3d8B5U658Dnrd7njXNzj1iv9zbjaI=;
        b=Ay2hEbLQVNY9j+g8vqg6eB4q43wN5OK6d1qlSbntyB9NgOeWeodTtBTMTJs9J+vcMC
         FHBA1+kPJoPt+N0b5OxesBRYu8kNsN9I578mH7k48qUaZDPspD+vh1xcVIKyxjaxdJ8u
         aF3FPLRKq63Co/qHi543t7PCBNy250Lkm0JS6nuzm3ezCzXPcgV0hctGuB43XL075x0p
         amcNaYaVP7x9HnamdLo6YEH/YU29ClSp3YqHihauxkYzCSHYRAqct1BgJgGtsDGMA9wC
         qZ3fnGkmn5wm/uxpNLRuTuXpvqzxwAWHORPX/9VBhrfI/NsBaD8soRbBFSN3mcbxD8dd
         2wOw==
X-Forwarded-Encrypted: i=1; AJvYcCXTqcZOC3n9Vy85FaqQjE4nvO1zw6PZZM57imEpitHoL9DQRfBIE7eszB6zLSH95kWQXO0KmD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8VuFrzJAfRORkDaCyoXignxQGUkZoGnO3nRNYoywJYbCwIAHA
	r21NMUukkaIWP97ifsbLveouXmT7L2a8fjJo6NjoXZSkKfeMv36zgntHpMEDGNT5wIo/OZStMeu
	f2g==
X-Google-Smtp-Source: AGHT+IF0fRIVtQzGjHRyYmnEnH/8CimtcIxuPGCWLPNdmuUYuFVbVgvZHz2rDvO254ixr09jUnGGcU4Rzps=
X-Received: from pfblb14.prod.google.com ([2002:a05:6a00:4f0e:b0:730:8a7b:24e0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d06:b0:1e4:8fdd:8c77
 with SMTP id adf61e73a8af0-1ee5c733c61mr1455053637.8.1739309515854; Tue, 11
 Feb 2025 13:31:55 -0800 (PST)
Date: Tue, 11 Feb 2025 13:31:54 -0800
In-Reply-To: <cover.1739226950.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1739226950.git.ashish.kalra@amd.com>
Message-ID: <Z6vByjY9t8X901hQ@google.com>
Subject: Re: [PATCH v4 0/3] Fix broken SNP support with KVM module built-in
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	thomas.lendacky@amd.com, john.allen@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	will@kernel.org, robin.murphy@arm.com, michael.roth@amd.com, 
	dionnaglaze@google.com, nikunj@amd.com, ardb@kernel.org, 
	kevinloughlin@google.com, Neeraj.Upadhyay@amd.com, vasant.hegde@amd.com, 
	Stable@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 10, 2025, Ashish Kalra wrote:
> Ashish Kalra (1):
>   x86/sev: Fix broken SNP support with KVM module built-in
> 
> Sean Christopherson (2):
>   crypto: ccp: Add external API interface for PSP module initialization
>   KVM: SVM: Ensure PSP module is initialized if KVM module is built-in

Unless I've overlooked a dependency, patch 3 (IOMMU vs. RMP) is entirely
independent of patches 1 and 2 (PSP vs. KVM).  If no one objects, I'll take the
first two patches through the kvm-x86 tree, and let the tip/iommu maintainers
sort out the last patch.

>  arch/x86/include/asm/sev.h  |  2 ++
>  arch/x86/kvm/svm/sev.c      | 10 ++++++++++
>  arch/x86/virt/svm/sev.c     | 23 +++++++----------------
>  drivers/crypto/ccp/sp-dev.c | 14 ++++++++++++++
>  drivers/iommu/amd/init.c    | 34 ++++++++++++++++++++++++++++++----
>  include/linux/psp-sev.h     |  9 +++++++++
>  6 files changed, 72 insertions(+), 20 deletions(-)
> 
> -- 
> 2.34.1
> 

