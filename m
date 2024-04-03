Return-Path: <stable+bounces-35743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87A38975F0
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 19:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D071C26A25
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 17:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C098152DF6;
	Wed,  3 Apr 2024 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="icAdKWSy"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE2152506
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164052; cv=none; b=IOuw8o452rNgrlvsWj4Mlr4CfPUgwExElzVFP3oRl9qBdc1ng/HlvDapbRNDi07xzayL4NAF9B6d+5BHgMoMs0ueJ2lksWmsuF83iWzsO+PuRpA0ajArppdfTcRdao5UMwJXEApJycde+1noUGrTvfhluxfIJ05TMlJRkqjcUcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164052; c=relaxed/simple;
	bh=gX73Fd71Hr9LdsAlOuJUtvzibpHcNhprefVg3paVgDQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eJ1iyiuqrwqLiy4mz0QsKD3U4nMhkR6r5guZnP/oOYs1qvFyt4womiQO8PVBkKm9QowW/nSgMZ2moIxeCU68DQYrOe2CBh1S4GEMeaa3K7FUDlVov7UjSbMODSelpMGnDyD5hqrfXOATxnxkyrNVp8MKo0X2oJLxLvCkUe5ZGcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=icAdKWSy; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61517841a2eso1014167b3.2
        for <stable@vger.kernel.org>; Wed, 03 Apr 2024 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712164048; x=1712768848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XE+PG9zC5omixfQJghjjzCZLVaoeIvGmD0Or6PABHlQ=;
        b=icAdKWSyvRSCf9tjeMZICzYfOPKdz7214hlszOGzL3yil1XhYOI6qzpm+L5C/GlbgU
         HxmMQ5p2emVaMg8FcbzMm6pP7bW78qD+Fq2q7Hz8wV46dD82aR3fxYUMHwPdB8pndLtv
         mC6NW/gk6qcTmiY42o303NuW8am9UoAB6C7b5PSMS/J/NqMXzC2gDiORn3YKbzpc0A1g
         nMmj5abcLp0OPXyK/6TXRpk4juXZl8ITDpsqTdWMHxFiKqZ4A3jzPV8l4a/Y7L1t3vdh
         Ev2jE1BXQzb9+0PXKyzuiMhzEoW6qj496yA8Va49UXaAq2MjZPFEgO2rrqfQbZpb1MjD
         EMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712164048; x=1712768848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE+PG9zC5omixfQJghjjzCZLVaoeIvGmD0Or6PABHlQ=;
        b=Ohc9Oqgtx9gwlOV/+CRYHf1wnpu5iqaF9HfK4PVy1YvKafvFEi6Nyo6X/jR6M8zZu+
         WMEH+xvX/kcRwrHmyWgPubeUsPqq24PcAdhXO7XJjOrORgI31MRQVVIVh1vRv05q6Czx
         YfX269BmUFsSx6CIq16R2NNtqTcX3aYZGg0XnHYhPAS1CBr/8EAQY/aFSTH7WLZ9hdBh
         XEIRay8Ub3oDu899A79+Fd2zYUFvkO45EfNtO7sqwW0A2JZEnsfYrzY46YEl3Jg9JUEp
         nmxhLXT4Xjqf0Si1UVIvo+LiUIdS8aoTikzdef1C7l56Abzk5zluJZc6oBWwV0r0E2xd
         LNeA==
X-Forwarded-Encrypted: i=1; AJvYcCWFLe7UvgtQXDmalfGq0y7MRbgJ9I52o2Hs9E4SZI+Ie4r43QraeG5g7OLlytsOMaUIRPfhzPfZiwizVoD2aeou/tOLlsIY
X-Gm-Message-State: AOJu0YwLw8IjuEZiCXy/bp2qEPb6v+GbP/1OC9oF+Ocvk5QpPXO8lpNN
	tq7A24qlk5qwxi3qFc025hSA4POXPnR9spwO57AKPixEeXbOeICIACEia6nFN21mIf+WfljV7BR
	wUA==
X-Google-Smtp-Source: AGHT+IGJ6fjY3qPzfcuQ+Uj01adGJDcVM5deoqEJfvQ1/h41CQ3qzBzMvVGNTIzpPWuDCJzxpn4gGWghwiI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1005:b0:dc7:48ce:d17f with SMTP id
 w5-20020a056902100500b00dc748ced17fmr10456ybt.10.1712164048738; Wed, 03 Apr
 2024 10:07:28 -0700 (PDT)
Date: Wed, 3 Apr 2024 10:07:27 -0700
In-Reply-To: <20240403164230.1722018-1-rananta@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403164230.1722018-1-rananta@google.com>
Message-ID: <Zg2Mz5ZcF6cO9Ipr@google.com>
Subject: Re: [PATCH v2] KVM: selftests: Fix build error due to assert in dirty_log_test
From: Sean Christopherson <seanjc@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Sasha Levin <sashal@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 03, 2024, Raghavendra Rao Ananta wrote:
> The commit e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in
> the dirty ring logging test") backported the fix from v6.8 to stable
> v6.1. However, since the patch uses 'TEST_ASSERT_EQ()', which doesn't
> exist on v6.1, the following build error is seen:
> 
> dirty_log_test.c:775:2: error: call to undeclared function
> 'TEST_ASSERT_EQ'; ISO C99 and later do not support implicit function
> declarations [-Wimplicit-function-declaration]
>         TEST_ASSERT_EQ(sem_val, 0);
>         ^
> 1 error generated.
> 
> Replace the macro with its equivalent, 'ASSERT_EQ()' to fix the issue.
> 
> Fixes: e5ed6c922537 ("KVM: selftests: Fix a semaphore imbalance in the dirty ring logging test")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>

Just to be super explicit, this is specifically for 6.1.y.

Acked-by: Sean Christopherson <seanjc@google.com>

> ---
>  tools/testing/selftests/kvm/dirty_log_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
> index ec40a33c29fd..711b9e4d86aa 100644
> --- a/tools/testing/selftests/kvm/dirty_log_test.c
> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
> @@ -772,9 +772,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	 * verification of all iterations.
>  	 */
>  	sem_getvalue(&sem_vcpu_stop, &sem_val);
> -	TEST_ASSERT_EQ(sem_val, 0);
> +	ASSERT_EQ(sem_val, 0);
>  	sem_getvalue(&sem_vcpu_cont, &sem_val);
> -	TEST_ASSERT_EQ(sem_val, 0);
> +	ASSERT_EQ(sem_val, 0);
>  
>  	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
>  
> 
> base-commit: e5cd595e23c1a075359a337c0e5c3a4f2dc28dd1
> -- 
> 2.44.0.478.gd926399ef9-goog
> 

