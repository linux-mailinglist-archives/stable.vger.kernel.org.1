Return-Path: <stable+bounces-169624-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F299B2702C
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 22:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DD95E6DEC
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65A0258CF7;
	Thu, 14 Aug 2025 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4rFNfBy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE391FF60A
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 20:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203365; cv=none; b=AtxzqywgoJul5ls3KwywA+j8P2NVPw5p3enDln8ZFYAgvxyO8xcMFmUdohA2rbaK705Zq2swv6Gggv+neRm/OzhinGiQKsHzycan1bdO2IvFMJaWgg5HGtQED+8ImMmb/EgcjOTBqmTXhmRjx3Gzak+QH7zt6n00u3AteY4QuMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203365; c=relaxed/simple;
	bh=Rb5HEF1c4hxpcjUasGuNPpT+fsYhV/goRvJQDJD38yM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PgKmoTVfXpNWZMb3GoSS+po8vTk2nYWwuIlY5EceAhEi3wTPhBouUek7EtphTf8eNZs2c5QeK0lvkr4z/Mm56FQNQLLFYOsMR9vVJw1j3zpBFABbOm5fOlHb/4xKAqOYrqGvk5cRLWHvlHQRRvus0ss7470hTJHuy8p1pBxGqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4rFNfBy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326779c67so1334405a91.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755203363; x=1755808163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3ICGLRbOZvgQyZKospR4VEvox3M/Ah+gg6C/IZwY8c=;
        b=I4rFNfByUMm/PPaR683b9vXU51jmU30t5dXM+p3gdw9546szdE0crodV8Gim6pNE6j
         zqVtd1oH6gSh+0IRwL/B2xIpJurNQOyGKMKBRVL7eE0FzjGE4YAj7CQAa5eJ+ja/pbma
         xfTSP8PQvjnM0O6K3pwcmptSJXDGrZ72vcbdtY0swjxmFvCRGdGBzL+UasA52Mgbc17O
         US74InjV9YihpzS2J8iczuVE4tQCwnMyxWoSj41yQHYlmMYecYSWXPdgYDGrE0/itQg1
         Dunfx+qiyjqL7vO/WCsfJhh8qtmiKQ1NIBLJXojFoqTefYElIqJf3wEgDugUgnBWhinL
         eheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203363; x=1755808163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3ICGLRbOZvgQyZKospR4VEvox3M/Ah+gg6C/IZwY8c=;
        b=Tf65XOD6rFIWvWBfotljpbDfqzy0ya0YDUC1QqymrFE54OsBSSOvIvowH0YvR8it0k
         YNr5Db5vAAX2nXcoLWNfhXZ0I6Ci2UkV5IrngMHjWZENOaVxnObreT+06ynlhOFRKas1
         ffrr3BBKLfBZXDERQVPPbJ0YVQAZDJtrmPEglk7T5GDGGgrSiCsUqGkgedTUyZ0IH/X3
         f5KmbRV51KmWIRIs4Z2cQFU3I5nkGGvfrLzJm/XbdBjkVpQdIOQBnCLYyX8lv/um1aHL
         w1mCz9DwBytiZrdwuYip9G7iZT1qgQCJqmY0wWauSlItKpMFicOR7eWIHiycO5Rl3wxy
         nspw==
X-Gm-Message-State: AOJu0YxrhNqlbVXJ1+3p6HOBtY/7kzO4SLTtMPt4ewGvQaxxsHPCiC2o
	FN7K/v45kJpxlk0dbi/dq7w10v5Wpao8IUxZYZhZkrBExJwUhpiXXN9/oJfJAlUxhHJHDOhNCbk
	qRveBvQ==
X-Google-Smtp-Source: AGHT+IHjBwmn7UuAnuqR8D19zPZi87HJekBPDgVtj0ATmBd6nkl8e9bIql6pw5enrPPzP+COBBfR5wyNWXk=
X-Received: from pjx3.prod.google.com ([2002:a17:90b:5683:b0:313:551:ac2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1dcd:b0:31e:a0a9:753e
 with SMTP id 98e67ed59e1d1-3232b4c6a32mr5727676a91.25.1755203363424; Thu, 14
 Aug 2025 13:29:23 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:29:21 -0700
In-Reply-To: <20250814132434.2096873-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081215-variable-implicit-aa4c@gregkh> <20250814132434.2096873-1-sashal@kernel.org>
Message-ID: <aJ5HIUpc5eSGcchS@google.com>
Subject: Re: [PATCH 6.1.y 1/4] KVM: x86/pmu: Gate all "unimplemented MSR"
 prints on report_ignored_msrs
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Aaron Lewis <aaronlewis@google.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit e76ae52747a82a548742107b4100e90da41a624d ]
> 
> Add helpers to print unimplemented MSR accesses and condition all such
> prints on report_ignored_msrs, i.e. honor userspace's request to not
> print unimplemented MSRs.  Even though vcpu_unimpl() is ratelimited,
> printing can still be problematic, e.g. if a print gets stalled when host
> userspace is writing MSRs during live migration, an effective stall can
> result in very noticeable disruption in the guest.
> 
> E.g. the profile below was taken while calling KVM_SET_MSRS on the PMU
> counters while the PMU was disabled in KVM.
> 
>   -   99.75%     0.00%  [.] __ioctl
>    - __ioctl
>       - 99.74% entry_SYSCALL_64_after_hwframe
>            do_syscall_64
>            sys_ioctl
>          - do_vfs_ioctl
>             - 92.48% kvm_vcpu_ioctl
>                - kvm_arch_vcpu_ioctl
>                   - 85.12% kvm_set_msr_ignored_check
>                        svm_set_msr
>                        kvm_set_msr_common
>                        printk
>                        vprintk_func
>                        vprintk_default
>                        vprintk_emit
>                        console_unlock
>                        call_console_drivers
>                        univ8250_console_write
>                        serial8250_console_write
>                        uart_console_write
> 
> Reported-by: Aaron Lewis <aaronlewis@google.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Link: https://lore.kernel.org/r/20230124234905.3774678-3-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

