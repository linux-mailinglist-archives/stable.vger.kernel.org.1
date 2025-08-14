Return-Path: <stable+bounces-169620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605E5B27026
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 22:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4D35E6BBF
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AB425949A;
	Thu, 14 Aug 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3XkcQHYb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDA6246BB0
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203126; cv=none; b=PBbkESQJlwYkxVmsrTlNdIxyZOYok6ltztbkG1xVGW5zVbjxLuOBNTQlzF0rcLrOnPhyI6Vi4Fsay5QLSHN2Aq6bU8FYVJE89CLEDtbR/lZUgvNyvA0rb2D2pxBA+y07z5B19onjM4jhNqkA/CLKm7o+PYf1xM+mWcNswm1OVk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203126; c=relaxed/simple;
	bh=0+2gSXSmKX4ZaV1u4wbmDErHMSVL7/CYkk+bXjFWknU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tz5yWVmxpbqirFX6QzKIw5hqoeQ9uoFdpfYkRqp/Vv98cGQ7NvEvERMEIuhUMS5jgSmSI2FglrwnMpzu+oKo4s/3RH16hyHjIpA0PYAT/L9WEDbVHYh+h0CX7dQ/g0p6zMi0qNGkSM74cArwvhfS7OaOJNh964FSVaJxWJlJAho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3XkcQHYb; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326bed374so1295197a91.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755203121; x=1755807921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c4k9tDgJpZRRrZAUV1x7GsmpSBGKlOm/rY8jLoqojXA=;
        b=3XkcQHYbzO7qewOZ/MuJcfFy0YH5ydkmgE9poUdXMNcGvmq3MN11OQY6znOaYhGCbm
         buCG6mCsQNxRb1K3ALJd8UZEil1eBMWwQuZmw5UOJIFVnWjVZnl8o1pR4mJk0hjz0j+U
         AUksDYNyKCE8U3oreCAF0rb/eKYK3n0y9UayU2WahGlcfoJZBVNWGlnti7Q5bUjQ5yek
         G07IOpCYTZN+CbYIbkMMc1d6XgDpZt33lW6gB6egv8xxCwRxCxBnjG6H1pJFiLh+GUMN
         wiL1B36UdPKo5dIa2qAwnrBeSFBuch0BzDun+digFDCrQQ1k25y5NigDTuPKGrwvfav8
         Ggbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203121; x=1755807921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4k9tDgJpZRRrZAUV1x7GsmpSBGKlOm/rY8jLoqojXA=;
        b=RAP7KawgiqFB0kikt0YwNmIHj2alVTdJkPg/ZbM+W1vFSUUajODu3iKsUXJpUsyizK
         3sGC6HHJ+UV4eZLt/shc3AiJQOR24I+Di3RuSz4QqHOFu2YA1etmfVVEB2w/jFRCnYOT
         4GBiWHAon62det16wT6m1orkkhXMEK+5UGMT8wXIc2RurfXO8xmErnptFokHlrmp5fk/
         SICZa4wDza+dVf/u/uMp7f9QbR2J8JPse/s01x4VoXPd8ie03KevAkahMB0BItS9TH4s
         T1Pv08w3NQ8stlahGgVmzYbPgAkIXQ/7fty9ox6Qn6ZQqF8d7aQnYZPHyDJdmNxzA0x4
         P7bw==
X-Gm-Message-State: AOJu0YzTne+/hPNB34grlJcazG3e16/AlopuvpngwApFhIdEHXzlz1iD
	peAl5ShBRqwj5v8E2UUTLXJVjm4A3/S4sSR4dMl+vy4xiM80CYvoAq/eDtBdTd3sboxiDxFmhAl
	u7zXzhg==
X-Google-Smtp-Source: AGHT+IHucHQJ6np9h82Us90IJNFIrc2AKTERXX6Eu9pUaCFvkTewnURZxPGP+k/VOCXkbMjUhq3hBaLOt2U=
X-Received: from pjd4.prod.google.com ([2002:a17:90b:54c4:b0:311:c197:70a4])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5643:b0:311:ea13:2e63
 with SMTP id 98e67ed59e1d1-323279a6b75mr6665332a91.13.1755203120825; Thu, 14
 Aug 2025 13:25:20 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:25:19 -0700
In-Reply-To: <20250724170725.1404455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025062034-chastise-wrecking-9a12@gregkh> <20250724170725.1404455-1-sashal@kernel.org>
Message-ID: <aJ5GLzyFedl44sO7@google.com>
Subject: Re: [PATCH 6.1.y 1/3] x86/reboot: Harden virtualization hooks for
 emergency reboot
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Jul 24, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 5e408396c60cd0f0b53a43713016b6d6af8d69e0 ]
> 
> Provide dedicated helpers to (un)register virt hooks used during an
> emergency crash/reboot, and WARN if there is an attempt to overwrite
> the registered callback, or an attempt to do an unpaired unregister.
> 
> Opportunsitically use rcu_assign_pointer() instead of RCU_INIT_POINTER(),
> mainly so that the set/unset paths are more symmetrical, but also because
> any performance gains from using RCU_INIT_POINTER() are meaningless for
> this code.
> 
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Link: https://lore.kernel.org/r/20230721201859.2307736-3-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: a0ee1d5faff1 ("KVM: VMX: Flush shadow VMCS on emergency reboot")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

Note, the VMCLEAR dependency patch was already landed in 6.1.y as:

1375d9600c38 ("x86/reboot: VMCLEAR active VMCSes before emergency reboot")

