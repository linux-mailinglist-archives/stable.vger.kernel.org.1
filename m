Return-Path: <stable+bounces-135147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45AFA971BF
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 17:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4E0189F841
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429AE28FFD9;
	Tue, 22 Apr 2025 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iM+/yj03"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2419ABB6
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337475; cv=none; b=mixfx6iDsIFSnWaVJeHqDhbafm7rWt7i2E39612cYJXYdWZ2QEryDyr7aB4JtQutL3IZh49ea65kN8Icq717k7FMbJn0AIODLD7v7HCSbUxFOPF5VeBT7aVwFkwRsclHpgoiblv9Tp+DGi3L8K/t24hdwb2FBsYbmuTf+K0R40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337475; c=relaxed/simple;
	bh=8/zBck3XMVJ/brA8VDf4fnRJ6A2zhRbXKNuUbNqTb4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eGNb7U7+XFiJ97Vj+nJ3doZce8RU31DQFB9gkcnlfSZvhWf/enBMHFCp8C5JAYTKDupSrim7u7QEzI/KBFYnXc+vtn+Ho04M81qAXYeSBiDTkfipEJJRr33YvVm+iTuZa0tbJR4CbIMjPPSRna3S4UrXl/2QB3XMG5iyv8RQ8Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iM+/yj03; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso6047041a91.1
        for <stable@vger.kernel.org>; Tue, 22 Apr 2025 08:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745337473; x=1745942273; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ew+SimIvTyVM+kBKpoUq30pg7X9qAemyQRkxqIiaVf8=;
        b=iM+/yj03OaxLuccQ2MijaAx7dIlymW9uRkqVBdYwNqu6igIve0xO1LP5/+ymIjh/2N
         9HTsp5v731m4Pl/ymJLS49ECqHWjcL8G/fAbjfV6nb/+bJq3S5CYjhmODC61edrmpe8f
         lrcDJiprevmHV/a+y1GKDIljFPGSdgq6ggJqwqG9J66YTmqDBfKSj5EaZAiJBsePvREM
         A/fqygme10FfKhSTXYF0m0AbIxZEAha7geuO4OuU9NpkWL+SkKxx3i5atGQ18dww+1D5
         nmmkJVds5U4RciNENGoh+Yqk1E0STuAyzQvMARqvLIasEP8HRhPZHh5+Vt2Y9MaDbvAi
         hFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745337473; x=1745942273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ew+SimIvTyVM+kBKpoUq30pg7X9qAemyQRkxqIiaVf8=;
        b=w5yCZzWH+dqEKz+kaxECQfYhlC7UT5TnlNRbYq7tgQ7FRoI8kSw2bz01V9BqA8W4fE
         yJvTPqR1TmhkBMJjnrs5iAmmb2EgHzW7FA0/UTdFheqz2PAlkmBw6lO+v5buyGNivZ0G
         nqjFAS/SEyUGJAyC+V53YtxC+5n6szSR3IuGnG51TNZFXM10Y3npES5IuYGsbkv/LIKF
         FN5BbTvKjJZBCNUECVta+OX/bR7oTh04kvGUKizydPB++sScIqUpn+RFUm7+COOqzKpJ
         4iYQqqGh1nqJrN3OZF6WAL1sRh8PCCNuLGHA4YybTCUHxl8iOrftPXUHaZPY4arr+aCJ
         +LlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC6P0J0pvGFZmBdXHgyc7Y2BuIyMLSTaL7qXHCt8K3SWBMraheHc+Xavds7qjCpCAGYn0uoIo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Xej0ciqwfp9UkhAJP0+ZH05l47BFRbHgippA9RnU1jyu+PDq
	I9A0wxaAQY+ZR1GhqBY0CtZqpLCffDkNmfQS1FmKlNnwO3sbdtmxjD+J4kY+uo/Yn3kALsXQDcK
	TQw==
X-Google-Smtp-Source: AGHT+IFU7stDfoX2W5KxZaCrxeanvFzK2UyWnQ16k7Jct5UzbXCHtj5RJ+732U9Fk5TXxcd0fnD60brAp2o=
X-Received: from pjh12.prod.google.com ([2002:a17:90b:3f8c:b0:308:87dc:aa52])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2751:b0:2ee:db1a:2e3c
 with SMTP id 98e67ed59e1d1-3087bb3e939mr21496185a91.1.1745337472866; Tue, 22
 Apr 2025 08:57:52 -0700 (PDT)
Date: Tue, 22 Apr 2025 08:57:51 -0700
In-Reply-To: <ht7jaoxtqi2njlb3blzgztmqukjbadkpt4cy2qxzgnqc26nbj2@2ja6ubtzaiip>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <j7wxayzatx6fwwavjhhvymg3wj5xpfy7xe7ewz3c2ij664w475@53i6qdqqgypy>
 <2025042207-bladder-preset-f0e8@gregkh> <ht7jaoxtqi2njlb3blzgztmqukjbadkpt4cy2qxzgnqc26nbj2@2ja6ubtzaiip>
Message-ID: <aAe8fypVeKa4vLMr@google.com>
Subject: Re: Please apply commit d81cadbe1642 to 6.12 stable tree
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	stable@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Santosh Shukla <santosh.shukla@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 22, 2025, Naveen N Rao wrote:
> On Tue, Apr 22, 2025 at 09:40:22AM +0200, Greg KH wrote:
> > On Mon, Apr 21, 2025 at 11:00:39PM +0530, Naveen N Rao wrote:
> > > Please apply commit d81cadbe1642 ("KVM: SVM: Disable AVIC on SNP-enabled 
> > > system without HvInUseWrAllowed feature") to the stable v6.12 tree. This 
> > > patch prevents a kernel BUG by disabling AVIC on systems without 
> > > suitable support for AVIC to work when SEV-SNP support is enabled in the 
> > > host.
> > 
> > We need an ack from the KVM maintainers before we can take this.
> 
> Sure. Adding Sean and Paolo.

AIUI, there's no sane alternative, so:

Acked-by: Sean Christopherson <seanjc@google.com>

