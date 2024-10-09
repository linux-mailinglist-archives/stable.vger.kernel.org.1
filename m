Return-Path: <stable+bounces-83270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180EB9975B9
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 21:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5411F23BD2
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 19:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57DA199FB4;
	Wed,  9 Oct 2024 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCUL1AQt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA2840849
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 19:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728502596; cv=none; b=Bwc933QMnhvo//BHzlUqG1puDHrRo+yzJnxO29bXIljoBHVAaVzcfaOVqYQBt+nE+1UWf2Hn0HSgLsySJq+sptzaRFqcKNEbIfBkWwCRBb27uJY5Oy7DafQaR4QviALwOfQGcSFVlD6Xz/iL2x35f/nbFTJwXBZLCCcvW4rkqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728502596; c=relaxed/simple;
	bh=tNX0yHtSx+2bxwChEjYCuylXCXHmQGQooGsI3FLrVUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=erUZAjUBJHyf+SLI8eoH8YgcZfhap/K8Z0+uiTTpvxNQMPHzudpLNblX16exwB0mlBxAG9Pt8qSc4yjPEL0R+9+QKBveda/CyhR8IDB87k4W2SHSXWK9sJx6JvXUw07tqfUb1bdqR35K6u7k+OnZc4vQPGM4zWMupw9hZopU6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCUL1AQt; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7c6b192a39bso165342a12.2
        for <stable@vger.kernel.org>; Wed, 09 Oct 2024 12:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728502594; x=1729107394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=knTcmc30pJl7doPnC19XGWX1FZIh862B8t2b0uPBIZw=;
        b=bCUL1AQt4hqIuq95cAraFWxBVqA3mSBn2ije9MNSMMmJk+7df0pBLxfIztztbOZ9cb
         WwOohlcZ51E4MAQ2Ye7lYsOHcWBL5TrnvFNU/f4MMxi/khBtzufV7iPJhGSaK1mGDHi0
         W9tKqePuzsln66AOBugwLnl7EB62UZyjvgcrj4QD2KG6HVzrQfX7y/wsTCdXYVzBk1GP
         U/cvQIFRHwRREceM+BSg/5aPieN+jAT2QUPDFPcJMhqDrFPKzKVpOed7tMTBi7gcZVJX
         v1cq2CL44OHw6qbYgiafYdEwmNmBuojUkgvmQrz4bi70IlKmU9jEI5EBkpnCHfvRwtOh
         ii3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728502594; x=1729107394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=knTcmc30pJl7doPnC19XGWX1FZIh862B8t2b0uPBIZw=;
        b=uIAGusj7LqFRiNspuc+f5qcuBnGFkWoINS/zbN/bwMFwWYbFZEvYNK21nLXHJZhayQ
         hGKr7sOSBio9rGcyFgbrCCgGMH3ohEcFhcyIjbzHw4KZhpBUhBBeZxRgwLtKOLMhDR6g
         qdXVPQBlx6nxcTEdwlgflFUHzyQYFnUd3RW3qjdLAvZhMqIGemigth3oONzc4HQ8dHCG
         o+jjeytMHtOmF66Zc3VJkSza/6d6H2VCnnz3HWMbU1M5xCkcF0kVmuhsh4eL4oJHhnA0
         vG/4shneQaNpT+hwC9RVaYlCZSFP94ed3SAhWSjnH6qH1C0gSjnRJPwSJSUdNTJtz0HN
         B4eA==
X-Forwarded-Encrypted: i=1; AJvYcCVdQ3JTOWkc1cYebV5n6OMCzJCueXsNsqEXBAzew0KauRkTof2e6sAmFMb7BVl+Nt99kOHw7tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXbGgRfc+WtILvw74OeuC3OicclgXEsihfAAZqaMPsKWWtJN7W
	9ExTmVgc/3lmeX+e2m3MDO0119Hta8hMnnlILlfvBt5WWvmV8+s3EqToHC4grDSY+myAdvpE7I0
	ZPQ==
X-Google-Smtp-Source: AGHT+IE6qbOZPjiPveauyRffk0TGKVOavv6JppsyQWCFko9+4i4AfWEW7C4di+OyANJtEcVOmeGbBoaiQLU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a63:5a46:0:b0:7db:539:893c with SMTP id
 41be03b00d2f7-7ea320ea266mr3439a12.9.1728502594375; Wed, 09 Oct 2024 12:36:34
 -0700 (PDT)
Date: Wed, 9 Oct 2024 12:36:32 -0700
In-Reply-To: <ZwbYvHJdOqePYjDf@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241009183603.3221824-1-maz@kernel.org> <ZwbYvHJdOqePYjDf@linux.dev>
Message-ID: <ZwbbQGpZpGQXaNYK@google.com>
Subject: Re: [PATCH] KVM: arm64: Don't eagerly teardown the vgic on init error
From: Sean Christopherson <seanjc@google.com>
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Oct 09, 2024, Oliver Upton wrote:
> On Wed, Oct 09, 2024 at 07:36:03PM +0100, Marc Zyngier wrote:
> > As there is very little ordering in the KVM API, userspace can
> > instanciate a half-baked GIC (missing its memory map, for example)
> > at almost any time.
> > 
> > This means that, with the right timing, a thread running vcpu-0
> > can enter the kernel without a GIC configured and get a GIC created
> > behind its back by another thread. Amusingly, it will pick up
> > that GIC and start messing with the data structures without the
> > GIC having been fully initialised.
> 
> Huh, I'm definitely missing something. Could you remind me where we open
> up this race between KVM_RUN && kvm_vgic_create()?
> 
> I'd thought the fact that the latter takes all the vCPU mutexes and
> checks if any vCPU in the VM has run would be enough to guard against
> such a race, but clearly not...

Any chance that fixing bugs where vCPU0 can be accessed (and run!) before its
fully online help?  E.g. if that closes the vCPU0 hole, maybe the vCPU1 case can
be handled a bit more gracefully?

[*] https://lore.kernel.org/all/20241009150455.1057573-1-seanjc@google.com

> > Similarly, a thread running vcpu-1 can enter the kernel, and try
> > to init the GIC that was previously created. Since this GIC isn't
> > properly configured (no memory map), it fails to correctly initialise.
> > 
> > And that's the point where we decide to teardown the GIC, freeing all
> > its resources. Behind vcpu-0's back. Things stop pretty abruptly,
> > with a variety of symptoms.  Clearly, this isn't good, we should be
> > a bit more careful about this.
> > 
> > It is obvious that this guest is not viable, as it is missing some
> > important part of its configuration. So instead of trying to tear
> > bits of it down, let's just mark it as *dead*. It means that any
> > further interaction from userspace will result in -EIO. The memory
> > will be released on the "normal" path, when userspace gives up.

