Return-Path: <stable+bounces-169611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CACE4B26EA9
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 20:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 352AF1892438
	for <lists+stable@lfdr.de>; Thu, 14 Aug 2025 18:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC50D319862;
	Thu, 14 Aug 2025 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7BcriQ0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B73363B9
	for <stable@vger.kernel.org>; Thu, 14 Aug 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195293; cv=none; b=lVQP15w2wAWI4LyLVKZ/r+T9TdZ/5QNGsjEYE7GfreA5Qv3Zz09ydlKohRi5lJOhYoJOSPWtPxsH6GOyAE+cqfhOwu/M0gKSkSoYsxfJjTDRD5+e+mQ21ANE6jupxOu5mmg9Mmkc9/pUc3dAZQcM6DNLp8s/fOrqRK9k/SJwvrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195293; c=relaxed/simple;
	bh=yZh1rfTRcRCqE5Ewhil9CCTGz1Gh020wuWNwRGI/cgU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V0f0A8byXzzG2VapR7Fl1GtcpBDohw2NuTMcLbRcts1ZRF0aD6L3XucPrZc7iZhuIdNCLgt9jMefDh+j+JeBsH40CS8U+DUHQQUS1TvDfjXh+4DRxvLxglVWdMNqQZJrU6v5YfkZKkPbL6HmNcpEWpHBEzU1QtKE4sB4pC+Y6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7BcriQ0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326bed374so1187930a91.2
        for <stable@vger.kernel.org>; Thu, 14 Aug 2025 11:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755195291; x=1755800091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3JT5WOR4qYq2sDpn24ISFZTk71JptEcxTQQaP7pMrOg=;
        b=u7BcriQ0eLSF3pigvvovL1RhLY4O5YyPPAj8MAIuerGCVm37AlxUuL7/tJsUujrh3u
         A9AIQuiE+MbmOKO6FvKjeJodKJM5A0495bVYhZiINWOxKomfLwO8BpBZTE5IjwLt7Dlz
         ipZIrrtIetjDVzyI5p5C1vxbz5Fxo4Kc63pEjYTXOy9U94ko/TCb1ktq4/n2lBo2ZHou
         m8Diqr5O9038Vr6gnSRGMnq8UNXT0QH/FPz8M7l2XcENuDKhKZN/exia6ruIggzhgnIQ
         7hrOfkRL4wgFgJtfccp2hm1Ex/RbUXpR7/6AYxEsj9UDwUa11bsBK02Bw6jm9eQUuVj/
         sTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755195291; x=1755800091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3JT5WOR4qYq2sDpn24ISFZTk71JptEcxTQQaP7pMrOg=;
        b=qPw5Yk1tRX9XC8lFNvyK71JN9FeG3F03uAIHkV4BiWc17YPt8FPtxB/CyDuWW5hFv+
         Ribf1r6QQXmt/+LQQZUt5EnblxkG2+4tHof0b/lymy+3rASwbOhCpKHajYAb5bhn4KwG
         VuZw8TVS2kka9CPYuhn3NYnDc5UGuJFUQczEVB+9MYTfBgAQGe7OzQy8PfuNPbP/gZgI
         qrow/PtyJ++IjTA512AqlbUYjriePHkc5/jVlDA6wFDb8HkpgVDkrFFpwf+tMKmnsqhv
         wkkS/mD9H5yTeERDTqolHuflDbdpwxYw1igD/2hgb3f+pg33yHACJGtEvlX3H/j8zwRR
         xe4A==
X-Gm-Message-State: AOJu0YwZVMfIl3PNiOdNNY9ZqyCo3xbUTlSjy4DLzTUIsJB1LmHwj17T
	RycmIwC1k29dFJlnTor+37fw0stxU3MWurnDA/6EvB9TMRwC61Bq/A9MnDQ3k9NZnztD6hnYfk2
	pktu/MQ==
X-Google-Smtp-Source: AGHT+IHua3ik6U7K4FijguKFy7h9ia3/edNbs0yzvUnRcEJkCK1qrgc1cpmFSBHYgra/COso5IHXFtGUWq4=
X-Received: from pjee16.prod.google.com ([2002:a17:90b:5790:b0:321:c567:44cf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5630:b0:31f:ca:63cd
 with SMTP id 98e67ed59e1d1-3232795b07fmr6271392a91.2.1755195291578; Thu, 14
 Aug 2025 11:14:51 -0700 (PDT)
Date: Thu, 14 Aug 2025 11:14:50 -0700
In-Reply-To: <20250814161212.2107674-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025081231-vengeful-creasing-d789@gregkh> <20250814161212.2107674-1-sashal@kernel.org>
 <20250814161212.2107674-3-sashal@kernel.org>
Message-ID: <aJ4nms72Kxfqivn3@google.com>
Subject: Re: [PATCH 6.16.y 3/6] KVM: VMX: Extract checking of guest's DEBUGCTL
 into helper
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 14, 2025, Sasha Levin wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> [ Upstream commit 8a4351ac302cd8c19729ba2636acfd0467c22ae8 ]
> 
> Move VMX's logic to check DEBUGCTL values into a standalone helper so that
> the code can be used by nested VM-Enter to apply the same logic to the
> value being loaded from vmcs12.
> 
> KVM needs to explicitly check vmcs12->guest_ia32_debugctl on nested
> VM-Enter, as hardware may support features that KVM does not, i.e. relying
> on hardware to detect invalid guest state will result in false negatives.
> Unfortunately, that means applying KVM's funky suppression of BTF and LBR
> to vmcs12 so as not to break existing guests.
> 
> No functional change intended.
> 
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Link: https://lore.kernel.org/r/20250610232010.162191-6-seanjc@google.com
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Stable-dep-of: 6b1dd26544d0 ("KVM: VMX: Preserve host's DEBUGCTLMSR_FREEZE_IN_SMM while running the guest")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

