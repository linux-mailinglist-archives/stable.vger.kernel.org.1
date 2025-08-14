Return-Path: <stable+bounces-169597-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56859B26C60
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF4E168459
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 16:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ECE1DD889;
	Thu, 14 Aug 2025 16:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pI1HTz//"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A5C199FD0
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188193; cv=none; b=Y0ftIEAdz6C47yvtpznNW7XQVUoB/KFoD8hFa+lYB9zQcMnsTmCZU0GOPq7qVNpC+H+hmtHNK/ly1vKadO3VjhqH+WhfgszNdyhF9+R/j7CXUxEWIuHkYhPEo/G2ZkIU0OaZtWweyHQhrrQHQQj50/PuPmJsrzRq12njq8r8VhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188193; c=relaxed/simple;
	bh=PIkxCqLY99Z9QZ34WrV6EmwyRphFe2z7Dqe0lOpG3w4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=up33qPx7ympPOruPz6RK9mGA7Nea0uOED6LcO42KPwO6Kn3EgVtcBrWBKWo01QpEGLn6QsPCw2ghUmS2KjXB8qv4AFCPv7HUzAF0Kb+OCstb4E6WzVL32244YFVoFxdKtQTakl3oP/FZ5iFk4Bntk2U/dWzBJXyqWuLDtYKLGAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pI1HTz//; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e62284dso1974634b3a.0
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755188191; x=1755792991; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y25eFDm6KdNoKeaxSijPA3LY8aynQUifCUSSU1Vzx4Y=;
        b=pI1HTz//2GMUkQSigOIyqF0RuxI7oEyxhiY2UrG+0xi0UdAwWRvWlF98tFKBvL/NJ9
         zo2FvwTwCMuZO/W8gPO+lN+enW7ESP3Je6yg6DIXgwip+k4B4pOxKx97+3ogU17G3F65
         NFGA8Bx//ek9hbGIBUx4S22lOyQx7Jb8WARk0ewCLP3pkXpEWhHdY9SPVpjxryofYqzL
         8uVfWHsIwaSj76YZmVy5bnJvCkDJX+yNLeOU1/B8nk1UF1fwlz6RkvAYV2m1CTEjKjHd
         KO7jtdJOQDuVWPCAv5W9Ts6dTwNNX4Lk4FfaUZ3/x7b0dFSEo66kh1fHDztJV7dumekM
         +gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755188191; x=1755792991;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y25eFDm6KdNoKeaxSijPA3LY8aynQUifCUSSU1Vzx4Y=;
        b=VDSm2CJWORKWCjRiewP8lDeqaQrBTYSyyZ2/mslbKr87POrOUbYkNAqJueeO0ck8Fo
         rudKMjT4sdt45wWcVbZwazU0H1mUXThgBbcON3Zffl4oG7Nz3APu3bhNARudWCXm9JCs
         K7eXaLWkFpeeXVSGjmkczjXUDbRMDF/XXKovjsdZk4icQ59ZPDgsEJm//P/FErXS/BW5
         rmEzTYA/d/PRDaPOL9LcCUBBtu5+/Bjp3OKhmxxPCskVorPGKkct60N1Jp3TQVy589Aq
         OP2wP9KnGGYpIcoMSZiVh8krzIDD6iDZVPGazIjP/T21LDVgHdmjYqsEj7qMXbWLaOY3
         DnqQ==
X-Gm-Message-State: AOJu0Yx4Fsi2jaCH4At25Lxx83MXMANGUCxWs9hDWCZt2pMgVDcxCHkX
	bLdxD63NWycnseG2oe5wwfVVKsqi7HaPePtldRyKQGHIRv30ewZWJlejY9Kub4p7U9uqpNA1puX
	rwSixww==
X-Google-Smtp-Source: AGHT+IFcf3wSh2XWszZve2zbX6NpJ+XM5KakdOJdbK0EjFz3ZXCeJlO6przQPSLvfKb7g2y5SiWcOgSwAcw=
X-Received: from pfbdr4.prod.google.com ([2002:a05:6a00:4a84:b0:76b:d868:8052])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:99a8:b0:232:22a4:bd2b
 with SMTP id adf61e73a8af0-240bd286034mr6502838637.33.1755188191164; Thu, 14
 Aug 2025 09:16:31 -0700 (PDT)
Date: Thu, 14 Aug 2025 09:16:29 -0700
In-Reply-To: <20250813182455.2068642-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081210-overhand-panhandle-a07f@gregkh> <20250813182455.2068642-1-sashal@kernel.org>
Message-ID: <aJ4L3UsGA8M_QO3C@google.com>
Subject: Re: [PATCH 6.12.y] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if
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

