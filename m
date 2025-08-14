Return-Path: <stable+bounces-169623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4619DB2702B
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 22:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A271BC1963
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924C025A633;
	Thu, 14 Aug 2025 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVV1wGaW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F025949A
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755203244; cv=none; b=aghUBRSY3GA6zpaeRIR92JI4wmvIBxjEYtqoYHKQVBhZI31DGesBCEtbnd2Z+g/Ntc5bauLV+n16/4To3ycmSiXcFjbGeMRud+vjWk+AcUPibWg/I86Lz61u9Juq61b5zG4ijSMra4TUhtawq9ORalwisN2mAfCwpl+6tQX1dUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755203244; c=relaxed/simple;
	bh=PIkxCqLY99Z9QZ34WrV6EmwyRphFe2z7Dqe0lOpG3w4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SyGDEF59Sn9xHExiYSo4QBT3K/9ZC3LCH2O2+5CGWcrJEl+p0iqUeaXHrK/XOkSObH8B3u2djcxIol27No65XII1B9K2e2ZDhcVRYnc4pAlqiNKw9YopF1SWanqTQpVq4knUS22xpzfYUPXCklXLxSRumqiOuEStOhhpIZrPTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nVV1wGaW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b471737e673so1832349a12.1
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 13:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755203238; x=1755808038; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y25eFDm6KdNoKeaxSijPA3LY8aynQUifCUSSU1Vzx4Y=;
        b=nVV1wGaW02Ew0DqMxncGS62oPfToV9DBiTK0g4k2NmLn68ezJQK47IhZQvIxA9op/q
         rMgU6BXzr+hYYv0sqyG3ypogYOee+uIMAs0kpU2LCSIH8Js+3Trzn3XFbavmz7Ct3xKg
         PKa51B0WbQks3g86pkLrHNnTMSgXxsxd06Jfl2Sx5yWXO0yqIyWS+UizxlBFffh/An98
         AO1TgxwgKttJJblzRmpWkOa2nhRCrTg1po3i6MwQZxq/4utbLN8BqWH/cjdm5zaQ0CYH
         QEsiTfJ2AbPG3xFvLhXb7506l7rXIxxac6hFm/r/fzpftajINkioIISOO92TdsGPwmFp
         W2TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755203238; x=1755808038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y25eFDm6KdNoKeaxSijPA3LY8aynQUifCUSSU1Vzx4Y=;
        b=oGgf90l+I/MdsJ2KQzhvdf0rKhLJGMLGLAmqHRv3gQKJn5rQX/IrqLP4i1mw9Kt/HU
         r1+NVCGKoQ+ZPeXbW5E4GXMv4YNpy3klYUkxlozPxlnbxgEbEPwkJvx0SCCLzrFuGp+y
         lz7cZqjZJ543+2TSC8+fSBKYX7G6LHGXZDcTwdx97q1he9aluu0WT1FbtC/7Qwg3Jxmn
         n3i6Kq740nxFZ26JEOWvgksmlH9GubBRdnF1tDJAJrc49Igvu/HNkQbfrH8+TBvMQFbB
         wjcG83O5ZP26/ETgt7zK+hu+w4/o41FGZrylfLYiefcOLwpdahSplYhD7fnMpzqMRHtY
         M3kQ==
X-Gm-Message-State: AOJu0YwVrHLBfbiGCKxKWrRV6FEptN+Zz4Qzne+O/2vO4yDpt6qHaDpR
	1qrft9DZy8x4T5R0Ih5ZsT4MvMbHFMHDs/kOD74cB0D7nPAcARQxE9mqe72rmHvGD8OAaGLEvU2
	U/zMVHQ==
X-Google-Smtp-Source: AGHT+IEYs9+PMnmFnP/ow0YRjuRUTftGfcsgnTt7f0INyBwEtb7S1WOu2Peajy/jm/kgwt5zNNLGOCqEFwY=
X-Received: from pgbfq16.prod.google.com ([2002:a05:6a02:2990:b0:b2e:beba:356])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8d:b0:23d:e370:ccda
 with SMTP id adf61e73a8af0-240bcfbba57mr6282328637.5.1755203238657; Thu, 14
 Aug 2025 13:27:18 -0700 (PDT)
Date: Thu, 14 Aug 2025 13:27:16 -0700
In-Reply-To: <20250813184918.2071296-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081208-commerce-sports-ea01@gregkh> <20250813184918.2071296-1-sashal@kernel.org>
Message-ID: <aJ5GpKnTqS4Qp2uw@google.com>
Subject: Re: [PATCH 6.1.y] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if
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

