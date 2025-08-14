Return-Path: <stable+bounces-169615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76A0B26F75
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D9F5C23A6
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 19:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6492165F3;
	Thu, 14 Aug 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w2hZku9D"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469131E7C1C
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 19:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198241; cv=none; b=aaZoegdmHZOuBJH2PbqH7BrocX32cysaANxGDLkC50A4ORuytUmcUo97yTMUwdUylvMBMmAU4wRpM77rAJpC7lah1/fmoGXaJc/13m4FDuDkbEabIR0x01tKR6IPWEPx55eX8euMSP2LrjD0MJoOv0lKiyH0HoW/7ZpAxTO0J9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198241; c=relaxed/simple;
	bh=PIkxCqLY99Z9QZ34WrV6EmwyRphFe2z7Dqe0lOpG3w4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=slnNsgxE/AvE23UlA/D3hBsdg7Fx01abb+JMMyLjtuw9EZu1mAM0BY9+hrwIS6uWV0n2mAE7qw5Bwyj6WdsYO+HRsT8hNc5m0I3ATvHt2u+wT35QfG8kg/4M8RuXW0ZJ3lNTlM5rrJ6enUgWJSkJZxuMWxU8IxgkSIEfiEQtEkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w2hZku9D; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-323266d8396so1299685a91.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755198239; x=1755803039; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y25eFDm6KdNoKeaxSijPA3LY8aynQUifCUSSU1Vzx4Y=;
        b=w2hZku9DmNi886BHO3n6eCJpfU+hKKLohpnVhPGUecgGYMGKN+vMk1BpNzMdzluz6H
         7f7By+SIThZf8VjpymYojcD71mxjR4jFC5974b4GVletJz/C23teqlmAzpZs+KeVzXwS
         TfeIi8JlZJZc9GtpCNXOK12RBc0yrHxcW2m+JHyoeAFf//p7hojoCCWZj9VaIv4qTpgm
         Z/DkTbwKLYV/UfX0+o6g9guQ8gxKTeptL89UbBkE1whkajYvZLKkLK4JB9GhAuy4vWGA
         waHckGZX3eKX1Q+UM2ASVpPRYN+QOyYCz5K4Qad88c944f+/ApKvr2dwE6UkEeMQUCKm
         QdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198239; x=1755803039;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y25eFDm6KdNoKeaxSijPA3LY8aynQUifCUSSU1Vzx4Y=;
        b=YumfRsPlmzd31PwZ3LP99j4kJENyjSO1T7+zStJdG538oTdtQmhMz8I3l3ApeGhGP6
         EDklfaX+hQQzBH3Si3fVAW2IfX0yJVDRLq88u6Ak16wVnYk2GFJtZJ6Flx5umfIQJLV9
         66TkQpTQnRDXvG+Z5gfK4rNZRTtvyaPsUZJboojv1c0t5DpIdtcaICiXGrI7T2Vg7u8P
         FJrbRgD4eJJ5v7X4lEVEUt4ksPTsn+R+uiTwXxJTCPdjzACXWXLwJPCGOPK0sHgSqegi
         N3ah9CL4bx6AZkVClXOln/s1KZtzmVJO2l8Al/pQObrHwAXK6i8vT4e9syvx29Av1dZ5
         RHNQ==
X-Gm-Message-State: AOJu0YxqADsCrQ2FgG7dKv9+1BW1DRTgvyWR2ZNWTXEvHPbF78j7i3bS
	tewyq4TnzfuYXIu4Os24e1XOwIDg4+Sde97DK7EwzyUksL1DaI2vKxt+VRoey4PwDC4JtZDfsUT
	f/izcSw==
X-Google-Smtp-Source: AGHT+IFPiLHpK9x9JKWROjpXBUYSfTFT9ESwkKatQAgwhBrUWN019RLNSh1swKnBMsEwS5wfr0XLvdYeMWI=
X-Received: from plbml5.prod.google.com ([2002:a17:903:34c5:b0:242:abac:216c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1aac:b0:240:3e72:efb3
 with SMTP id d9443c01a7336-2446a3f4a89mr453905ad.43.1755198239591; Thu, 14
 Aug 2025 12:03:59 -0700 (PDT)
Date: Thu, 14 Aug 2025 12:03:57 -0700
In-Reply-To: <20250813183728.2070321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081209-porcupine-shut-1d95@gregkh> <20250813183728.2070321-1-sashal@kernel.org>
Message-ID: <aJ4zHbB57ePyIyBI@google.com>
Subject: Re: [PATCH 6.6.y] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if
 RTM is supported
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Aug 13, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 17ec2f965344ee3fd6620bef7ef68792f4ac3af0 ]
> 
> Let the guest set DEBUGCTL.RTM_DEBUG if RTM is supported according to the
> guest CPUID model, as debug support is supposed to be available if RTM is
> supported, and there are no known downsides to letting the guest debug RTM
> aborts.
> 
> Note, there are no known bug reports related to RTM_DEBUG, the primary
> motivation is to reduce the probability of breaking existing guests when a
> future change adds a missing consistency check on vmcs12.GUEST_DEBUGCTL
> (KVM currently lets L2 run with whatever hardware supports; whoops).
> 
> Note #2, KVM already emulates DR6.RTM, and doesn't restrict access to
> DR7.RTM.
> 
> Fixes: 83c529151ab0 ("KVM: x86: expose Intel cpu new features (HLE, RTM) to guest")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/20250610232010.162191-5-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ Changed guest_cpu_cap_has to guest_cpuid_has ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

