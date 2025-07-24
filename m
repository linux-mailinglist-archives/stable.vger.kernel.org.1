Return-Path: <stable+bounces-164631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B62B10ED8
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04B0E5A4AF3
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE74C285CA6;
	Thu, 24 Jul 2025 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JG3hcjuy"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BAF279917
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371477; cv=none; b=Uci7sEAfi2+G0avC5zyUqrEcM4ykRYwaKgGnSRtqMtDmwqkTL4dxhps0QXcBRK3yEjAWq1OGhULME13mANVEalQk6LDAfTPCqidyykIhUuMQkOyXiUjUYShkeWxvWip2mcq9vDe+rf9KeOMAX4ZmTUQhjuKsw18M5GaJkafQ9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371477; c=relaxed/simple;
	bh=7HcuPnofmyOdGZoJCYqOROTNIVaAEHDNBWwPI9g0tAI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XY6kEw7YRpVOJUkeq+Y4XrncdfT2cnAAC1TSM2xtk/qox8UDOn1BEI48cXANMe05E8kpQ6r5KRuS8KYrMqdWL0rfzF3ocRvsYyl9wMmTF7JsuPqfYXVM1jwdKXp1hTUvux9UxwPa1POi4V/o8Y4q2o2O/PPfYUxBP2UD0B9ilBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JG3hcjuy; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso1318999a91.1
        for <stable@vger.kernel.org>; Thu, 24 Jul 2025 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753371475; x=1753976275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2x9weT2Ofy2cHSIYoV/wAxXtbPr+zV2I/AWAgFhLlqU=;
        b=JG3hcjuyzIIkeLRoshtOtolDYh5SCeW2rsICbVBQ431hQ5pOKvywZRIWmzqk1MgyN+
         BtS4yL8X6oSXwdrFYUDh7bvhRec5ysOKvDEfcMUa1+xo7DbRL4Cg/EwpqJfRNm7ihWu8
         M2REaa4hx0Akvb8IYYD+jX4GeCZ5s6ya1/srGH2XSpAKqLLiZvwIXvO1sA0mNyPTI+S4
         mBpVnyjPjbZOEpvd/IxRVT1LZhzjCDV67kAZVyp8bm2wPiGQikcq0JXQT77Oax51bB7d
         eknRbGzbcGZpqtIo1pH7JpaX3V38BLi37fe00VjGoPd+tTElIte6zLg9w/81AmzEPgFM
         vr0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371475; x=1753976275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2x9weT2Ofy2cHSIYoV/wAxXtbPr+zV2I/AWAgFhLlqU=;
        b=JZLjvgYm8UMS1bsCuIqKNLGZEoLvneEtajnPfDSkSRji7vhAUz5v82ygCN/tVmEu84
         pvpU85yjEtlNlHSFV3/DbRllWGrOeGQR7I9QnW8kg7+O45w/xEnxzWYyY05xbFTpxn9t
         R5lXN4uArR2ti0cs4xTA3AW7pqggjtqNwtYIldTXAYVee9lb4/YZPy8Gryd++ElyErnb
         NHwW52ZJuegWLwe5uOTV81gJ9uTqnWLD4mTATtapNj9Z+08DWh7zH+LHFutsc3zx6Fgc
         XsmjhzD2Jl0RYs91Y5btFeAUNyivgTK9YxDIIoklK+9VZnmU8e7Htz6jVbBjqzqAXiKV
         njCw==
X-Gm-Message-State: AOJu0YybxRceKyzRi9nbxtE87QKBXR0adNfY8aJVbvYnMHBerin7sZz0
	vFT2KTq6XIsW/zTyxmAaPtuWMcyYhJF+S8k5zOCsDvhHB69NQyfijng8SP2AmNONNwX+XNamiel
	xgWM8mg==
X-Google-Smtp-Source: AGHT+IHtRpyRD4ulZw5Z4NVt1v+GrTpkztoaNA97XcQVLeTQTYEcHiuNGYn6roiWd4AIqC91v/6dz9lIvXo=
X-Received: from pjbsf1.prod.google.com ([2002:a17:90b:51c1:b0:2e0:915d:d594])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5483:b0:312:daf3:bac9
 with SMTP id 98e67ed59e1d1-31e507fff7fmr9603163a91.34.1753371475514; Thu, 24
 Jul 2025 08:37:55 -0700 (PDT)
Date: Thu, 24 Jul 2025 08:37:53 -0700
In-Reply-To: <20250723151416.1092631-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025071240-phoney-deniable-545a@gregkh> <20250723151416.1092631-1-sashal@kernel.org>
Message-ID: <aIJTUStrXNA807bs@google.com>
Subject: Re: [PATCH 6.12.y 1/5] KVM: x86: drop x86.h include from cpuid.h
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 23, 2025, Sasha Levin wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> [ Upstream commit e52ad1ddd0a3b07777141ec9406d5dc2c9a0de17 ]
> 
> Drop x86.h include from cpuid.h to allow the x86.h to include the cpuid.h
> instead.
> 
> Also fix various places where x86.h was implicitly included via cpuid.h
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Link: https://lore.kernel.org/r/20240906221824.491834-2-mlevitsk@redhat.com
> [sean: fixup a missed include in mtrr.c]
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: fa787ac07b3c ("KVM: x86/hyper-v: Skip non-canonical addresses during PV TLB flush")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

