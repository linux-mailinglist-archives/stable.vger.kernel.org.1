Return-Path: <stable+bounces-223257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIvaHqe6qWnNDQEAu9opvQ
	(envelope-from <stable+bounces-223257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 18:17:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6796F21605D
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 18:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB448308E8D0
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04583E716A;
	Thu,  5 Mar 2026 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q4ioHUhl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E873E5ECD
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 17:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730756; cv=none; b=GXI2ggjJ+qYsNKYo8AJ5xEhIEnHsiUr0TumR2BLihEJlhBlUWXgU273R8n44AKUUFUxLW4Qi5URNHETOKjfU0e2zF1jn4A7d/SwpwYeve1U1Wrf9IkOlRCugXp7+Xr3WX+L6Qx+cqMWlJmRwiEP8ze45ydV+SM8trRraaceepPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730756; c=relaxed/simple;
	bh=dns5h0qR2KZ4FdzLbrUrUvVJWrBlR2/7jhXyY3CqByM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n3Kehvt/lZGUmr4uccnwcjIQx8rj7qTxWxpJZ80UQMfQuS40LGM0KBjEbZvHu1lzJ/XlvO/z5JnPIWPzxrIrtYeHoM1I/vkiAe5BnjA3G6WAghCKx8HRq7cirY/Z1kwP6ZEjRddJhCArI2SEct2I0bvdBTI1yK+oQb95JwyDPXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q4ioHUhl; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso7660859a91.0
        for <stable@vger.kernel.org>; Thu, 05 Mar 2026 09:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730754; x=1773335554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V8qFCWJ5evls0w2NVX0f3a/m73/uGRK6Z8I0hTOz8KU=;
        b=q4ioHUhlWhY1kW65PuKNBZ6MFuCifKJS4tMrkcDicOre6qh/PkOHbgETjC+xKTaSfq
         CVFF/gTd9eukWGd0t/NbcO4VW7dcidd8jd8rTuaas97BkgAuevs1C8SOsedbs1hCQnb4
         0ts/vqfYG7fsfeW8/JQmAZnEz1PLI03nQLK6ja8vcckiH7F0mCcSuq9zf++yiywfKDAk
         SPuuXtlNfWR8zXOkb9kYyEVekWZTiHT7lEFI+j/dazLJJhvAHtKaeLnOWPWZajCK9w1U
         0JNfBXbw2AhCFZ1UvlBH8m5RD4KxbVtkACA5e02a4pjJsX+Q19Z0er3Z/w+ovXe3fb0m
         P3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730754; x=1773335554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V8qFCWJ5evls0w2NVX0f3a/m73/uGRK6Z8I0hTOz8KU=;
        b=BYs5yG7a9IKZpuXkKLssucYnoyxkWGBiAdqWH1aUHEsREdkLdiArCqJdmWQ+cGncMu
         9ZUW9xIndBfYG8Bn9L4yFuCnh434bSveQlV0BR2BFCviSQKihPKc3oCrZf1K59sehuLW
         CfBlt4Zsd0hmUdTN7aZt/5AMDFFftKhx+YaD6F3VlgXAetFkuY/PBde8Xuc8Z6IusnKZ
         qag/KHwnW8CprnNrsCAA2qoUES5x+gRy16EUeKcdBXasTWdXekwJpQAuBX7YAo8Tjg2j
         9OuWVh3f0FPib4TglbOCUNzZDQ16gSIusIW8N2rW1Sqrmx4S2KkD1x/eS0bN8HAAd4Gk
         PZUA==
X-Forwarded-Encrypted: i=1; AJvYcCW1VparbBFNeoTAzs7pnnT2FGaMdGqkUPPpQdFd+SHMNo/fncY+Hfdzr3fFKlmUbdSuCfC3NOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALA+rDCZd7zf2tMeNYfV3+AzQJX42OCr3iO/1M2UDR4eJJ2rI
	Ck6Zy0J5+yOk7CV76IA7ZHCiHCCQKB2/wBxGTXNm6Lsmh6jtBtxQlS866uqj+3/P1JBjOlvhxYc
	NQnC/xw==
X-Received: from pjsv10.prod.google.com ([2002:a17:90a:634a:b0:359:803b:2e2b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3c4f:b0:359:9b45:7754
 with SMTP id 98e67ed59e1d1-359bb40455cmr225426a91.32.1772730753957; Thu, 05
 Mar 2026 09:12:33 -0800 (PST)
Date: Thu,  5 Mar 2026 09:08:19 -0800
In-Reply-To: <20260203201010.1871056-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203201010.1871056-1-yosry.ahmed@linux.dev>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <177273034728.1571417.14215404445053164555.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on
 nested #VMEXIT
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Queue-Id: 6796F21605D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223257-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 03 Feb 2026 20:10:10 +0000, Yosry Ahmed wrote:
> KVM currently uses the value of CR2 from vmcb02 to update vmcb12 on
> nested #VMEXIT. This value is incorrect in some cases, causing L1 to run
> L2 with a corrupted CR2. This could lead to segfaults or data corruption
> if L2 is in the middle of handling a #PF and reads a corrupted CR2. Use
> the correct value in vcpu->arch.cr2 instead.
> 
> The value in vcpu->arch.cr2 is sync'd to vmcb02 shortly before a VMRUN
> of L2, and sync'd back to vcpu->arch.cr2 shortly after. The value are
> only out-of-sync in two cases: after save+restore, and after a #PF is
> injected into L2. In either case, if a #VMEXIT to L1 is synthesized
> before L2 runs, using the value in vmcb02 would be incorrect.
> 
> [...]

Applied to kvm-x86 nested, thanks!

[1/1] KVM: nSVM: Use vcpu->arch.cr2 when updating vmcb12 on nested #VMEXIT
      https://github.com/kvm-x86/linux/commit/5c247d08bc81

--
https://github.com/kvm-x86/linux/tree/next

