Return-Path: <stable+bounces-196552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8549EC7B3C7
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 19:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4107D3A1CC3
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 18:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4924C076;
	Fri, 21 Nov 2025 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bCxG49Wc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192F626B760
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748682; cv=none; b=DPfMgW2BsGyRWpTYF5C+WYxXzdGRgTMVN8s/jLjYf2kGv0Xjv7hUuWnl4qpiKY/qfkT74XGQhyQd6MVgfJ6I7Uq0tfIcF7YK9OFwxL5F9VpFwQQ1mRdeGtliC5wJaA/b2VvlHIujg9ASZsKwOKM7Sahfrethiyg62wJoFXbJO5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748682; c=relaxed/simple;
	bh=BwomLA10EK6iEUjqglnJ2PiLV249RI+140gyOy4IGxM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aa1s9BzcLHrxtjKvxg5YEBz/W1iBP1poPQfG5b8+UdtPAboZOIqcaxMiniCQosoTmq4FKfPqgJcglOrx47nPHkchxj9uj1GCwfV5l1V/kkRoRHXM+yFgNeQdA5jXfhrsJYZLcxTMmoJUoolhmK6svWvrf0DCqJQa6CTO1i7MyvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bCxG49Wc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-343daf0f38aso2597781a91.3
        for <stable@vger.kernel.org>; Fri, 21 Nov 2025 10:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763748680; x=1764353480; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yNrny/DxltAFbS+FZGRQHmrXuFVOcMuPRz31LNxOZMI=;
        b=bCxG49WcPSM8/JyfdMMkTKvoVCWiM4gbs4lj0jUiTq1s2bYeA0dSnd3hi3gCiYK1HW
         x4tUc6hZwsh97tFwdLegn84CW5Ni4K8HNQeHKaXdQ362RawzMJvNRkuZJgupKfBIr/jy
         HzWM2HAPtNVOjVe5uAITnazu5tat8iMVIiNRy7zTIhA/sz+0UAj2FvrxYpBMQ2OAWhoz
         67bA7WuqY2rlxENYvOCq08lh2RYrHaUCkkjskzp/3BPHjXplGJPb92JprTo4+8mQasTO
         kVr9363gkWJw9cwkyxKGcC8bRkQJ200mYK0H7nHQaSM4oXT27z9ca2cqKavmub10dp4c
         5zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763748680; x=1764353480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNrny/DxltAFbS+FZGRQHmrXuFVOcMuPRz31LNxOZMI=;
        b=KtqgQhqf2uIBUKryK0OCJpgaUWqhzpyT20Iq76vzj97kwcULwUGnZozW2Zl5VH6vVH
         3PO+CVS7XvxTaFSwZTH3EhW/gpMSkNhagZbBa6Z6SruDThZuxzQ4x3LTYiwgzUe4Dpts
         G9JP8FqveuGD906AoUFCPrBhylOnLExE2CRNNaZP2HjuVBP0wRKEwhABfW7S8Sdx9NRP
         O4Xo5otJNHW7J9wNGZlVdJfQ/Tm0YM+ITw7xEE2xxb4PDO9n3xgjPtdT6Yep8BTicFQg
         pel7JeSqlFkif0e3PaXXhXJspIH0EPKOcZCQzNs6ZfCVPwpatqk2qbArDarlJzS6Xna9
         yNYA==
X-Gm-Message-State: AOJu0YxEy0b9rIhZbSFxoBzo5XcNoENhKqdBFOrcG8yHYuYB1X0Fb/uD
	QvTT/D4aaeaiKhNX03SXKaeXnyvwq0FSNiPE1hiMu0mFwjyo9B0yPn8G4NLRC4TcIYIaGGJrhyA
	TrNTMCg==
X-Google-Smtp-Source: AGHT+IGcLAxt/QA5aNg9tWFORIZKXpCjgRvaBxkI6hajeWn0eoc2jRNpGt4zBkuhAcGy+WViPM8w+dCBHjY=
X-Received: from pjbpt9.prod.google.com ([2002:a17:90b:3d09:b0:340:a5c6:acc3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5450:b0:340:2a18:1536
 with SMTP id 98e67ed59e1d1-34733f2a0c7mr3443352a91.25.1763748680340; Fri, 21
 Nov 2025 10:11:20 -0800 (PST)
Date: Fri, 21 Nov 2025 10:11:18 -0800
In-Reply-To: <20251121055209.66918-1-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121055209.66918-1-Sukrit.Bhatnagar@sony.com>
Message-ID: <aSCrRoe3fcBgLo8W@google.com>
Subject: Re: [PATCH 6.12.y] KVM: VMX: Fix check for valid GVA on an EPT violation
From: Sean Christopherson <seanjc@google.com>
To: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
Cc: stable@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 21, 2025, Sukrit Bhatnagar wrote:
> On an EPT violation, bit 7 of the exit qualification is set if the
> guest linear-address is valid. The derived page fault error code
> should not be checked for this bit.
> 
> Fixes: f3009482512e ("KVM: VMX: Set PFERR_GUEST_{FINAL,PAGE}_MASK if and only if the GVA is valid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Link: https://patch.msgid.link/20251106052853.3071088-1-Sukrit.Bhatnagar@sony.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> (cherry picked from commit d0164c161923ac303bd843e04ebe95cfd03c6e19)
> Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
> ---

No need for the manual "backport", commits that are tagged for stable@ are
automically pulled into LTS kernels so long as they apply cleanly (and obviously
don't cause problems).

