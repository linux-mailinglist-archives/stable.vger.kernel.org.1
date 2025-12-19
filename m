Return-Path: <stable+bounces-203103-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C09D1CD11D1
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 18:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD94F303F5F6
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 17:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74834350D79;
	Fri, 19 Dec 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0gO9Y7l"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94E0350288
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766160575; cv=none; b=aofexIaJ2mUXgsKMAj5DkKy4G/VEZe/t8kOSazXwn1/EM52jpDh9rbCj3m0F7OEFxfxZozSvhnhD2xKJVvmBvuYKs9k2bBiX/USGdrLnGjzGbHuP4E2tAELIKD9Y+NKG4OW8qz8fcSZlKCMvhVzWdNG7KAA7dePSpfnjExPbjxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766160575; c=relaxed/simple;
	bh=zyGZvdow4WsQp8tmO5WglXphtJoWsZLzh35S+zd8XqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GpW87U/n3LMrShK5aPb1FG/gZUfkNY7iII89qSMtkLw+IW9avhMWvVqHgxDXzEA4CrUzq5AI318gTELw5trSxgjnfv9GTkn8lM/DNHasHhI+XOUynzpkVGb6DcVFYiRCOAMjuJx8SecN83QqspUB/R3bDsTozjbMgIgFefNJllM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0gO9Y7l; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34aa1d06456so4334074a91.0
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 08:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766160573; x=1766765373; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvkkN/JVfJ0/HpY6p1MGYv4ARJvfILZSEbErMl1MA/4=;
        b=D0gO9Y7lvW8gJtT2obDsqdLWDwenxQ+coKnamyA1cvoJtRo4+VzsoU4sbPKCbRk/S6
         RDxTi7Iigb9j39aH73WGOviMNJ2oRgE9epK3rGYGrDO92VhAd/a/4UTrmwhod3ICQ0co
         3F/Qyop767/JQ6a6IEneBalbMlA0cH/MU5OaJAJmURrRuiN7SsJX+6v6KSuyqwA9aYd7
         Kag017NOFGtqhj8aJlUeG09FY2xVlNMXUdzoGpd0NfnSeKQ89Kjy1hQ8PeiMSSBPBw4M
         IGkssek0uWCnyd+z0+YzCHFVI5rgGqjQDEi6usL0ERh1L+Y/yb6pjrT9d/VbnM0j1vpv
         MPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766160573; x=1766765373;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WvkkN/JVfJ0/HpY6p1MGYv4ARJvfILZSEbErMl1MA/4=;
        b=ST6Irw0GBfxatjn3YtGU6d7ex/NHlVrvRACcLrkpQk3NlbrsV5QgWZu1QBoBfzpi/z
         K+vHbzgK19Rm6QvtveIYfVUxy/0Vf+er27BsqteFCjlF4W7liHT3hsPBCXfUgOrv9tjO
         svjKRqlLQjYCja+pjDAutXdpWsVZWJrBa2F34u+Joblt8Je35jsy65P5UOWjZdzuipq/
         ElwpsN2WPYJz73stZ0xqVTwfYo7sGCYdNcqDBXlGTKzNyvAC42vFJGTd7VEyFdkMS0y0
         JOE640A4bb8wvqDz6aGXs8yBrMujV3caLGZxcUqrE52sY/n1LO8NzU9CUNnTmgdcY3Nk
         y9tg==
X-Forwarded-Encrypted: i=1; AJvYcCUOndZv5Eo6vWBFQLJRki/gw1Jb6EH0WkpbDfs59/v3V1YrKbDhd88OGZZMsX2gwzPTBlxWcOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuY0yER58bYUi0RYe/qo62pKRwvyOjEyjz+mhHRqBpXpzbi+CR
	OWB3xbnpBYy3gqVe+zX8UMHgGdp0B3NkGr2kYxYZQAX8+Fwxxyz6cEDU1xJg9mAYgNFYISTuw9E
	2Shc9GA==
X-Google-Smtp-Source: AGHT+IFi0EOmNsJLwNWNd+F7YnuERxayE0iVrblPiIXpt/oQKEFPGSZPOu2wHmeTgNma9jT1j9/KpGT8+c8=
X-Received: from pjso12.prod.google.com ([2002:a17:90a:c08c:b0:34c:6892:136f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f90:b0:340:c261:f9f3
 with SMTP id 98e67ed59e1d1-34e92130102mr3375788a91.14.1766160573108; Fri, 19
 Dec 2025 08:09:33 -0800 (PST)
Date: Fri, 19 Dec 2025 08:09:31 -0800
In-Reply-To: <7C6C14C2-ABF8-4A94-B110-7FFBE9D2ED79@alien8.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219010131.12659-1-ariadne@ariadne.space> <7C6C14C2-ABF8-4A94-B110-7FFBE9D2ED79@alien8.de>
Message-ID: <aUV4u0r44V5zHV5f@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: avoid printing reset reasons on Xen domU
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ariadne Conill <ariadne@ariadne.space>, linux-kernel@vger.kernel.org, 
	mario.limonciello@amd.com, darwi@linutronix.de, sandipan.das@amd.com, 
	kai.huang@intel.com, me@mixaill.net, yazen.ghannam@amd.com, riel@surriel.com, 
	peterz@infradead.org, hpa@zytor.com, x86@kernel.org, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, xen-devel@lists.xenproject.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Fri, Dec 19, 2025, Borislav Petkov wrote:
> On December 19, 2025 1:01:31 AM UTC, Ariadne Conill <ariadne@ariadne.space> wrote:
> >Xen domU cannot access the given MMIO address for security reasons,
> >resulting in a failed hypercall in ioremap() due to permissions.

Why does that matter though?  Ah, because set_pte() assumes success, and so
presumably the failed hypercall goes unnoticed and trying to access the MMIO
#PFs due to !PRESENT mapping.

> >Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
> >Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
> >Cc: xen-devel@lists.xenproject.org
> >Cc: stable@vger.kernel.org
> >---
> > arch/x86/kernel/cpu/amd.c | 6 ++++++
> > 1 file changed, 6 insertions(+)
> >
> >diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
> >index a6f88ca1a6b4..99308fba4d7d 100644
> >--- a/arch/x86/kernel/cpu/amd.c
> >+++ b/arch/x86/kernel/cpu/amd.c
> >@@ -29,6 +29,8 @@
> > # include <asm/mmconfig.h>
> > #endif
> > 
> >+#include <xen/xen.h>
> >+
> > #include "cpu.h"
> > 
> > u16 invlpgb_count_max __ro_after_init = 1;
> >@@ -1333,6 +1335,10 @@ static __init int print_s5_reset_status_mmio(void)
> > 	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> > 		return 0;
> > 
> >+	/* Xen PV domU cannot access hardware directly, so bail for domU case */

Heh, Xen on Zen crime.

> >+	if (cpu_feature_enabled(X86_FEATURE_XENPV) && !xen_initial_domain())
> >+		return 0;
> >+
> > 	addr = ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));
> > 	if (!addr)
> > 		return 0;
> 
> Sean, looka here. The other hypervisor wants other checks.
>
> Time to whip out the X86_FEATURE_HYPERVISOR check.

LOL, Ariadne, be honest, how much did Boris pay you?  :-D

Jokes aside, I suppose I'm fine adding a HYPERVISOR check, but at the same time,
how is this not a Xen bug?  Refusing to create a mapping because the VM doesn't
have a device defined at a given GPA is pretty hostile behavior for a hypervisor.

