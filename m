Return-Path: <stable+bounces-191527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C4EC16388
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 18:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C63F1C26FC5
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D248B34B1A7;
	Tue, 28 Oct 2025 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tRf0bAvU"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D73259CA9
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673076; cv=none; b=YPau5C3U3HojZt59i8UlKh4PugcTifp+FxUu8/dNQQXLA0JhwP6t0U35af/qdE5cx3bHqNmAhAAF0GNUllixj5ZIn4ocEX2vgP5RLRm1Lfixc7ivzrohv9PTODBAR1XQdQ/D1xrZP0kSSvt9Ns42llg6WR/yEcRLN53Oy+VSI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673076; c=relaxed/simple;
	bh=WCMg7UUnl6IMP5RsK5bXZua1oQz6K1bVCjhQkkqx5ms=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C2Jh6e7KdOrqJToRJMk1U8owUXMjRu1eoWzxUwjMLg0YDTztI9yj4QLYV2F8q106+6aGGft6jUHlvn7aD0xjKWZmcIgTj2uZkYH33s//3uIAjlTupFd+zm03L0TaaXotW8GyPHK4IbZYzHMZvM93EgyvzPgWVwaZwvI7tn2cky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tRf0bAvU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290d860acbcso133169755ad.1
        for <stable@vger.kernel.org>; Tue, 28 Oct 2025 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761673074; x=1762277874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8T4o8duS8kLdi84UueGHzy38mnS8VEpOnZiB5sHhaeI=;
        b=tRf0bAvUAUTSp33Yt3tFnqg5tTnMoOcrM+iA1gfhIIAUknLfs/3w/AEMKzaqifFkRy
         GxzIM8x7gBENFZliOQvIBf5epa5qQ5xxJ2x8qYVxWux4P9aSKxHSWUdOUaMlvGhpmfeu
         gPZe5US1VyE7AQZiWrgaNiyYAw7FsbfuqmZK7I13+uL0HXpJrOUcoPP0MpFuFu+HPR4P
         Iy3Mgv60UelSQhZzE+z/HKCzEIN5L0keOAXpB+zxUgQB5A3v5+7wHY2hGwaDqGLoUA5A
         PyviehO+MT6kslaopuRZPENzj1E16IgkPQPjw3bVtfISjJ7sEMgQNudwnVpIAteQcl3S
         gGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673074; x=1762277874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8T4o8duS8kLdi84UueGHzy38mnS8VEpOnZiB5sHhaeI=;
        b=uBCbpXm24Nc5g2q+n+LWMAEi0YrKno0zaV2LfbuDiEBBaMHuKegqXPw30tVg4MevW+
         H1zYi/QZbDZ4utaHdb6jigX5lRLU665UBybSMapm7Y6QidGXimph19Bn/9FPXwK/rMX/
         15I1LZ/JWZaOZCHCU5KHrGA9VcYeR9zKf+hcDNYaUc9Tw+R17/QiMWMDXxM5NPBrREvT
         VdPpr9es/HGXroHc4iNHxiQQpgOMjhukXTMMNSXeVTVZ5AFMLBIcAbym1V2BlvDcHtbt
         jtHkNCef3yXcTlHxzHdJKSj9U/SN1r8RXj0ZtJjxusKXTFd8YfupnITT1/WKtpz2gBxr
         SpfA==
X-Forwarded-Encrypted: i=1; AJvYcCXK0aMnMG7f8p8Za88MD3+uicWogG3ez/qmajgiAdRazyYyKX9bOl5HN3UqCF8xxHyvrBNgZow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNK3RoQUDjdyEMhVs0ZJpzD/bCX5VminV4HsvHUEd4DFBxQGBl
	G7bCaIuIxF3QHQVanb6I88+i9Kgvr9iluzj4YF933MHE42ab7ts8UzYbzz8kFMTxbVqicUw4x5R
	NHrfMkA==
X-Google-Smtp-Source: AGHT+IFos7dmlHc5zgyuKwSvkzMGrICMFJHNR7QI6Hf+TJ3vKWf9u68Fb2sJjv7IaagPEHKeX48Q/hD6mEQ=
X-Received: from plpp9.prod.google.com ([2002:a17:902:c709:b0:292:4a9c:44cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:246:b0:27e:e1f3:f853
 with SMTP id d9443c01a7336-294dedd4181mr189615ad.8.1761673074418; Tue, 28 Oct
 2025 10:37:54 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:37:53 -0700
In-Reply-To: <aEeAl9Hp7sSizrl8@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250610001700.4097-1-chang.seok.bae@intel.com> <aEeAl9Hp7sSizrl8@intel.com>
Message-ID: <aQD_cZzqml1vindY@google.com>
Subject: Re: [PATCH] x86/fpu: Ensure XFD state on signal delivery
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, mingo@redhat.com, 
	linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, 
	bp@alien8.de, dave.hansen@linux.intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 10, 2025, Chao Gao wrote:
> On Mon, Jun 09, 2025 at 05:16:59PM -0700, Chang S. Bae wrote:
> >Sean reported [1] the following splat when running KVM tests:
> >
> >   WARNING: CPU: 232 PID: 15391 at xfd_validate_state+0x65/0x70
> >   Call Trace:
> >    <TASK>
> >    fpu__clear_user_states+0x9c/0x100
> >    arch_do_signal_or_restart+0x142/0x210
> >    exit_to_user_mode_loop+0x55/0x100
> >    do_syscall_64+0x205/0x2c0
> >    entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >
> >Chao further identified [2] a reproducible scenarios involving signal
> >delivery: a non-AMX task is preempted by an AMX-enabled task which
> >modifies the XFD MSR.
> >
> >When the non-AMX task resumes and reloads XSTATE with init values,
> >a warning is triggered due to a mismatch between fpstate::xfd and the
> >CPU's current XFD state. fpu__clear_user_states() does not currently
> >re-synchronize the XFD state after such preemption.
> >
> >Invoke xfd_update_state() which detects and corrects the mismatch if the
> >dynamic feature is enabled.
> >
> >This also benefits the sigreturn path, as fpu__restore_sig() may call
> >fpu__clear_user_states() when the sigframe is inaccessible.
> >
> >Fixes: 672365477ae8a ("x86/fpu: Update XFD state where required")
> >Reported-by: Sean Christopherson <seanjc@google.com>
> >Closes: https://lore.kernel.org/lkml/aDCo_SczQOUaB2rS@google.com [1]
> >Tested-by: Chao Gao <chao.gao@intel.com>
> >Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> >Cc: stable@vger.kernel.org
> >Link: https://lore.kernel.org/all/aDWbctO%2FRfTGiCg3@intel.com [2]
> 
> Reviewed-by: Chao Gao <chao.gao@intel.com>
> 
> Thanks for looking into this issue.

Ping.  I _think_ this is still needed?  AFAICT, it just fell through the cracks.

