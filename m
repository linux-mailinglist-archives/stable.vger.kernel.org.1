Return-Path: <stable+bounces-200368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3CECAE063
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 19:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3488B3011017
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C16525EFBE;
	Mon,  8 Dec 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dqwf2W6C"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CD1E51E0
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 18:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765219703; cv=none; b=kyZOCbIDJDC7cY3KPJB29jeye0XKW90nCnB/Etk0Iaw6NwxEz5qjNChHZUkUlgxIl+QA1fkA3WMK15ynSwCCMhr1RVGiVsxnFX+GDCGgG+wxFITaNgTMXOtIl0XWfIb4nJlg2hDLNQCqOnT86BGjGnnxeNkOsmuJMxwB0RWaz3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765219703; c=relaxed/simple;
	bh=WUj+EQ1S4EjffPPURPNS1p9dQvNVWFx1tN2y8Z5c34E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g0ahkBP/3zfITTymNHOdq9WA56vpu1cTnC1XjeRMBjvtAmN/dJ4DXwK+BXeXZv4CdB6zgkCqE+4PI2NDoFquheeVDvu+hRPZ49zf/dAdof9r5rEqp44AJ5+Ty5tXqJ5V2MQ7K35QgGyIJDydDYaPZIAM5lE2p2EPTy5suyDFqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dqwf2W6C; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so8037169b3a.3
        for <stable@vger.kernel.org>; Mon, 08 Dec 2025 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765219701; x=1765824501; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s8lc5nA2owqfQtXSGu6yjnczdNe/gDVJABUN6KOgYiA=;
        b=Dqwf2W6C9Ii5rLE2gxPpCgnYKKt+kuj461BWq6xlUQK/YpHIUevx0j9rzDGg3UiCvX
         T0Ux5VR5HqACDMwtc4F0lpMynPAnyLLM4XwoseUgeJ01DG8CBBex+PYgqztmQd8IYc+l
         jOnNlpkKiaFqEk2jqn9DRtD/lw2AfVQb5/hThl8o0QntY4Mt+aJeb5s+yoX/rFSpSkEB
         IHraf6xf0sjy31JRogtSlZx6OJZBi0HBpq8nqG7R4jQ98MGgfiYhUP66PDV6sOC0Fuon
         ROcSknl9xNX/T8DlW9l0ke6I8jJCDJRXh2bmmeUU2+SuG8yAfakbQg9zb2kmxGbOYtz/
         tw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765219701; x=1765824501;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s8lc5nA2owqfQtXSGu6yjnczdNe/gDVJABUN6KOgYiA=;
        b=SwJzGVw2WBvXW/GnZEefN5yUX3Xnl+wUT1qWDlziXZ9iEo1vQa4MEaFMbU2I0Un0ST
         4JvzsyZWy4veoK2KaX8rpHLTgskvxnoDjUMNY+YVZSEQnK7nzTnDwzrGi3rTPARpzsce
         jpkn6tHHJh0U3zcxescihzM3OcOGmv4uFgqwqEGejNx/XWu0u7q59NPT9cZJ4zMhQMB6
         RUxW5wKf1e/3UQJJd41+vrVKcvl7BvNe/6wL0XsFFHzMC++K3bHG7ykdgwwUVHr5w1oO
         TzPffq46CabefmkxH8/xmxHYpy+dvopZgS5Fx6gdznZ1TwZjQPhVLnNWr3r2vh3SXnUm
         DNWA==
X-Gm-Message-State: AOJu0YyAqQEKlRMPKcbwea5YkLlIJoEUUm6vEKRTFA2mvfeTPpZAJcIi
	hK3gWv1zF5n3ZeW4o6W129lhOa4ceV2MB+yPiM4tsh6/vXvg/fK7kN7aTRgSVINaN/4hufcLEI/
	aAfpDaw==
X-Google-Smtp-Source: AGHT+IEqs31w5BiMKMdEDaNcKc2ksUqWc/sg2aXbO9HwYqBX9EdG7NjMUlUFu94bMCOzgMNStt2fjrydzSA=
X-Received: from pfva15.prod.google.com ([2002:a05:6a00:c8f:b0:7dd:8bba:638e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b86:b0:7b8:ac7f:5955
 with SMTP id d2e1a72fcca58-7e8c21f6c7emr7626560b3a.17.1765219700824; Mon, 08
 Dec 2025 10:48:20 -0800 (PST)
Date: Mon, 8 Dec 2025 10:48:19 -0800
In-Reply-To: <20251208061727.249698-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025120802-remedy-glimmer-fc9d@gregkh> <20251208061727.249698-1-sashal@kernel.org>
 <20251208061727.249698-2-sashal@kernel.org>
Message-ID: <aTcdc3Ho9aTrREzL@google.com>
Subject: Re: [PATCH 6.1.y 2/2] KVM: SVM: Don't skip unrelated instruction if
 INT3/INTO is replaced
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 08, 2025, Sasha Levin wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> [ Upstream commit 4da3768e1820cf15cced390242d8789aed34f54d ]
> 
> When re-injecting a soft interrupt from an INT3, INT0, or (select) INTn
> instruction, discard the exception and retry the instruction if the code
> stream is changed (e.g. by a different vCPU) between when the CPU
> executes the instruction and when KVM decodes the instruction to get the
> next RIP.
> 
> As effectively predicted by commit 6ef88d6e36c2 ("KVM: SVM: Re-inject
> INT3/INTO instead of retrying the instruction"), failure to verify that
> the correct INTn instruction was decoded can effectively clobber guest
> state due to decoding the wrong instruction and thus specifying the
> wrong next RIP.
> 
> The bug most often manifests as "Oops: int3" panics on static branch
> checks in Linux guests.  Enabling or disabling a static branch in Linux
> uses the kernel's "text poke" code patching mechanism.  To modify code
> while other CPUs may be executing that code, Linux (temporarily)
> replaces the first byte of the original instruction with an int3 (opcode
> 0xcc), then patches in the new code stream except for the first byte,
> and finally replaces the int3 with the first byte of the new code
> stream.  If a CPU hits the int3, i.e. executes the code while it's being
> modified, then the guest kernel must look up the RIP to determine how to
> handle the #BP, e.g. by emulating the new instruction.  If the RIP is
> incorrect, then this lookup fails and the guest kernel panics.
> 
> The bug reproduces almost instantly by hacking the guest kernel to
> repeatedly check a static branch[1] while running a drgn script[2] on
> the host to constantly swap out the memory containing the guest's TSS.
> 
> [1]: https://gist.github.com/osandov/44d17c51c28c0ac998ea0334edf90b5a
> [2]: https://gist.github.com/osandov/10e45e45afa29b11e0c7209247afc00b
> 
> Fixes: 6ef88d6e36c2 ("KVM: SVM: Re-inject INT3/INTO instead of retrying the instruction")
> Cc: stable@vger.kernel.org
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> Link: https://patch.msgid.link/1cc6dcdf36e3add7ee7c8d90ad58414eeb6c3d34.1762278762.git.osandov@fb.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

