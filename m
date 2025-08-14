Return-Path: <stable+bounces-169587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D03B26BB7
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0F516934F
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87E123A99E;
	Thu, 14 Aug 2025 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JZXdoo7H"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7121D3F1
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 15:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186880; cv=none; b=CUSYC79EqkBnTPBFqfj9xSRkhQNzjO2p7GLYao7Chg/4LJN4AhHblErsIHctclgQs9EsGyE1kknHwth7iAihadCEj4W6L2S6ZbtUmY8CV9zVgwNVN0tJMMWeFwOP7Pw80Kj+udTUxeQEUmGRj1DzsAm8r0XjpcC20SfqN/HO3GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186880; c=relaxed/simple;
	bh=Zh9hWfY+hyJBKoXxzojuom8s+bib0CBiG/xFvxrht7Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bGAaJ2UD3PF6fQgzO4UM3itVxjlHYc1rFv7CzVE6f8+9ntk34e6Az1DdH7a8ccn0IfaNME8nkt7PPXSHwFZLkOJAsBMaDTgwW1485qeeFD/ZEwugFh69g+BcPzg4XzJUDgf7ukye2vn1f90BqTjgY3gPGHv+k0SRbLvtHV4+OSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JZXdoo7H; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e017eeso1141158a91.3
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755186878; x=1755791678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqmv+93nQJr22F61BVAnBMpJFak3Lt2U0MCMBde+Y1o=;
        b=JZXdoo7HHy3NTuSED9HO8Nc53jwdRpwCO8R64HAFoUXuwM1Yq4VJIWf27lMamI/m81
         YYuKoTIb2m7yrpgrWw6r/u36xOXQFaFqIaFUHFjxLyeUV/nLcYV/ucDEPaHZ7G0uRcf+
         xauZdf1boGRRbvZUOVEQK0I88FlGgQJuD5OQL2bBC+LWS+6ntJz+EM0KoB7YCB4r8ekp
         DeUHV85COtwmAhh7nTdkty6Tmv0UYDIuThYv/LyPzVSVLPWOQqbPfWqwz7L7KozODNvQ
         8FiRDleoamc6ezVAtQ3WZu9v3yDNxX9hlLS4n3HsV93J2BjyeJyBE7er/8jFy3TkTndQ
         9ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755186878; x=1755791678;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lqmv+93nQJr22F61BVAnBMpJFak3Lt2U0MCMBde+Y1o=;
        b=LhHxnPhLI7vAnxgnKF1qDpyf121HusQkz+sCLvhtgZdu3WBVyKBs5Sbkr5Pr6xYof3
         h7sjkcn5lQxm1Pi/prtGtq0u/sG3/MD/lnsNIHTDOnEzaqO41ykQWjtDHiIgRl6+CBM0
         tdiuWR4Fc1pw3z+/78vwj3uy5pNpA5UQYMWTYLlhsq7K5M/safcAZYEuIoz0/UY+/bPb
         g0RZMy8cDiFkLF7At67pqrR95QK3F/ZIYzemtYTw2UuQCHjGYtKwEobmBsJzz5DIn8Jo
         4osWxyukqmpu0DSVlbsc6T6GOqoxZ5NbJbfPVDZWftoYrtivtRCHQNDZTfz2Kc+gSAML
         cQ/Q==
X-Gm-Message-State: AOJu0YyGG9DCZJ7ddrhF/nYYIf0V9SXbdL8E96u4GNBgYZEUm/kvg54a
	xE08JD7wayjRWRnGOl27ciQvtNaDkTgPy54mP1j34stmge6nlccRFX3chUL9YRHmz4xrdnJp5MF
	kKlee+Q==
X-Google-Smtp-Source: AGHT+IHpuCyJHlIdivTocrDoZFg4RsP10HPRjTdUh4lj1LGKOKZDZdcgRrKjVzKyZ1uiDBlLYUlA6m1jwe8=
X-Received: from pjyp16.prod.google.com ([2002:a17:90a:e710:b0:31c:160d:e3be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e88:b0:313:1c7b:fc62
 with SMTP id 98e67ed59e1d1-3232b2c606amr4094346a91.22.1755186878190; Thu, 14
 Aug 2025 08:54:38 -0700 (PDT)
Date: Thu, 14 Aug 2025 08:54:36 -0700
In-Reply-To: <20250814125201.2090009-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081208-petition-barcode-1e2a@gregkh> <20250814125201.2090009-1-sashal@kernel.org>
 <20250814125201.2090009-2-sashal@kernel.org>
Message-ID: <aJ4GvBwTe86dg-yl@google.com>
Subject: Re: [PATCH 6.15.y 2/3] KVM: nVMX: Check vmcs12->guest_ia32_debugctl
 on nested VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit 095686e6fcb4150f0a55b1a25987fad3d8af58d6 ]
> 
> Add a consistency check for L2's guest_ia32_debugctl, as KVM only supports
> a subset of hardware functionality, i.e. KVM can't rely on hardware to
> detect illegal/unsupported values.  Failure to check the vmcs12 value
> would allow the guest to load any harware-supported value while running L2.
> 
> Take care to exempt BTF and LBR from the validity check in order to match
> KVM's behavior for writes via WRMSR, but without clobbering vmcs12.  Even
> if VM_EXIT_SAVE_DEBUG_CONTROLS is set in vmcs12, L1 can reasonably expect
> that vmcs12->guest_ia32_debugctl will not be modified if writes to the MSR
> are being intercepted.
> 
> Arguably, KVM _should_ update vmcs12 if VM_EXIT_SAVE_DEBUG_CONTROLS is set
> *and* writes to MSR_IA32_DEBUGCTLMSR are not being intercepted by L1, but
> that would incur non-trivial complexity and wouldn't change the fact that
> KVM's handling of DEBUGCTL is blatantly broken.  I.e. the extra complexity
> is not worth carrying.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/r/20250610232010.162191-7-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

Please just make sure this lands after the DEBUGCTL.RTM_DEBUG change[*].  That's
already in the queue so I assume it will happen naturally, just want to make sure
the functional dependency is captured.

Thanks!

[*] https://lore.kernel.org/all/20250812174416.530544704@linuxfoundation.org

