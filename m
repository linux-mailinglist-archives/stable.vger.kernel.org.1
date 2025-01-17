Return-Path: <stable+bounces-109409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD87A157AC
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 19:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602AD161AF3
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 18:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768A11A23B7;
	Fri, 17 Jan 2025 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkAav3jw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347B119B3EC
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737140129; cv=none; b=ggpMBnetAHR+5nrrkroxyKezsnySGrJYm6X8idnR1VMGtZxcP/YN2F/IvYByJZn2TYBgwDtDbaqVL+Ng60miLDUxbw2yS0LCAU4CGrHTXc6gsUHdV8A86oqNhPpg69LvpuckHhm1NVaxERfwypTxKtVRKtQXeRGtQxCVgtru0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737140129; c=relaxed/simple;
	bh=4ZNeMXc8bXUQH5lZVCibPgDSRPPMJdPNPkyl3sOP3Fs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8ZB+xKNRbj+t/iK/v0iZUC5hCIQK0sara9M1kuHIiJZHhqvecbY0OWVzlirk0HXJvC8Idiv1fUf/oEvgP8OI+MStBL8/JT+7MBgWg4gIL3DUhGUBgFhSQFXwQ0hVXeMm6sPT0YgT+X8Rn7b60Lu4L1E2uUiPIR6pGBeXLqXagY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkAav3jw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-216266cc0acso57729315ad.0
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 10:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737140126; x=1737744926; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7tYVzLVUp0HCs5m0H/hnGBktgCUu9xEce2kHKxeFjrw=;
        b=GkAav3jwsgGH6bDVINy2zCrfDsTs+4MPCfmNL+KTWutITLigAs9qt8dqnlfXGI9AtO
         XIeh1VNDhGaxwm9w5IqXBin1BcOYwXbk3lPHBCzbIM3YxrjciztvYAphM6Dd+g59lntG
         W6NaZWyNWFP31r0nH+8wHS9AOcc1hWqxfVHk2rMzW29xNRWJe3RqhpIPEsYESPHkY6Dv
         pZYLntHULofffarN2QeHBe3AUwKgTIGacQl7R0dnlE97q/GfcFfOEEgL07SiVJSveUXn
         spLQ2iBn0uSY96JFNk3TG76oYAUQs32k2tkMeLqpnYtAQCW16DvfHvfrq65a4ApUCGXO
         hyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737140126; x=1737744926;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7tYVzLVUp0HCs5m0H/hnGBktgCUu9xEce2kHKxeFjrw=;
        b=CdiQq/SDzHfoqQW4LuHdFi0zPE6354YQZr3gjo/kRyHyb1njmPIuCqH29+BMYbzxwy
         6PcaUfQ4Xj3hktf9R5K2l4ZiVuQw1+7L5CRY7gYg/Cs03v4TUYfSMoqMTPytROLN7MjC
         TW9dB4fE3UMXfQPkg+G+MPz+UqV427vS0Dh8Vy/XsGMuc1CcxcaCzqxSVbSRCtY5B/WS
         nVcNfpKFvo8F8rr1LgY3jyXBsync4tdaf6PIwjS4KAbs+tTbnJiOLtdXsKfBqzpyPuGH
         0XCI/XD8moMV/ysww0T/KuZExwX6aMtMawP2zoU+XC5+2Xb/EK1Lagy4vGDtgOIXIh8B
         ZoRw==
X-Forwarded-Encrypted: i=1; AJvYcCVa+SJRWbw6WiZjQ06iSO+pIl6dHrsuYppyGtkuEJt9CHtLZkJaEX9yWiWy+hhjUHScpOS6yiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbjBeDa/JbiYqFfW5dA/uhwwmfjqcjtEhHFoDoxOmY/E7FD5Q
	88sRvL/U3kEO7P545UT4V41YUjwvAdHLksMbQbmMzGc0NEH7OFGLRWFaLa0LcM2Td/1mWZxp3Py
	0VA==
X-Google-Smtp-Source: AGHT+IGXPAimC+Ce2xkspg/B1RjSodIgpaFL41aSTo/tticGhxczap+Lz1AMKHlJ13hJlwHcVNWYppG2cCk=
X-Received: from pfx20.prod.google.com ([2002:a05:6a00:a454:b0:726:d6e6:a38])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:918d:b0:1e1:9e9f:ae4
 with SMTP id adf61e73a8af0-1eb21719f66mr5647320637.13.1737140126530; Fri, 17
 Jan 2025 10:55:26 -0800 (PST)
Date: Fri, 17 Jan 2025 10:55:25 -0800
In-Reply-To: <8bfc2790-a159-795f-6e4d-38b10227d726@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241226033847.760293-1-gavinguo@igalia.com> <Z3AWJjUDmfCnD99S@lappy>
 <Z3w8wPRvjNyDXSQS@google.com> <8bfc2790-a159-795f-6e4d-38b10227d726@igalia.com>
Message-ID: <Z4qnnb4CsqVvZVzO@google.com>
Subject: Re: [PATCH 6.6] KVM: x86: Make x2APIC ID 100% readonly
From: Sean Christopherson <seanjc@google.com>
To: Gavin Guo <gavinguo@igalia.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, mhal@rbox.co, 
	haoyuwu254@gmail.com, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 09, 2025, Gavin Guo wrote:
> 
> On 1/7/25 04:27, Sean Christopherson wrote:
> > On Sat, Dec 28, 2024, Sasha Levin wrote:
> > > On Thu, Dec 26, 2024 at 11:38:47AM +0800, Gavin Guo wrote:
> > > > From: Sean Christopherson <seanjc@google.com>
> > > > 
> > > > [ Upstream commit 4b7c3f6d04bd53f2e5b228b6821fb8f5d1ba3071 ]
> > > > 
> > > > Ignore the userspace provided x2APIC ID when fixing up APIC state for
> > > > KVM_SET_LAPIC, i.e. make the x2APIC fully readonly in KVM.  Commit
> > > > a92e2543d6a8 ("KVM: x86: use hardware-compatible format for APIC ID
> > > > register"), which added the fixup, didn't intend to allow userspace to
> > > > modify the x2APIC ID.  In fact, that commit is when KVM first started
> > > > treating the x2APIC ID as readonly, apparently to fix some race:

...

> > > > Reported-by: Michal Luczaj <mhal@rbox.co>
> > > > Closes: https://lore.kernel.org/all/814baa0c-1eaa-4503-129f-059917365e80@rbox.co
> > > > Reported-by: Haoyu Wu <haoyuwu254@gmail.com>
> > > > Closes: https://lore.kernel.org/all/20240126161633.62529-1-haoyuwu254@gmail.com
> > > > Reported-by: syzbot+545f1326f405db4e1c3e@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/all/000000000000c2a6b9061cbca3c3@google.com
> > > > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > > > Message-ID: <20240802202941.344889-2-seanjc@google.com>
> > > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > > Signed-off-by: Gavin Guo <gavinguo@igalia.com>
> > > As this one isn't tagged for stable, the KVM maintainers should ack the
> > > backport before we take it.
> > What's the motivation for applying this to 6.6?  AFAIK, there's no real world use
> > case that benefits from the patch, the fix is purely to plug a hole where fuzzers,
> > e.g. syzkaller, can trip a WARN.
> > 
> > That said, this is essentially a prerequisite for "KVM: x86: Re-split x2APIC ICR
> > into ICR+ICR2 for AMD (x2AVIC)"[*], and it's relatively low risk, so I'm not
> > opposed to landing it in 6.6.
> > 
> > [*] https://lore.kernel.org/all/2024100123-unreached-enrage-2cb1@gregkh
>
> Thank you for reviewing the backporting. This backporting aims to address the
> syzkaller warning message and ensure that the stable kernel is consistent
> with the upstream version.

IMO, that's not sufficient justification for backporting to stable kernels.  This
does not fix a problem that any real VMM will ever encounter, there's no security
implications, and outside of kernels that are running with panic_on_warn=1, which
seems insane outside of explicit test environments, there is zero risk to the host.

This is a bit of a bad example because I do expect this commit to land in 6.6 at
some point because it's a preqreq.  But I don't want to set the precedent that
every commit that addresses a fuzzer-induced WARN is stable material.

Sanity check WARNs in KVM are tricky because userspace can shove arbitrary guest
state into KVM, i.e. avoiding what are effectively false positives requires quite
a bit of thought, and practically speaking such false positives will happen from
time to time.  While I definitely want to keep KVM warning-free, I also don't want
to discourage sanity checks in KVM, i.e. I view intermittent false positives in
KVM as a cost of doing business.

If we start treating what are effectively false positives as stable material, then
it changes the math, i.e. each false positive becomes more costly because there
are backporting implications, and we'll naturally be more conservative in adding
sanity checks, which I don't want to happen.

