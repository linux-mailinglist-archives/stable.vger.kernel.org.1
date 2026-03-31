Return-Path: <stable+bounces-232558-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMieM3gSzGkvOAYAu9opvQ
	(envelope-from <stable+bounces-232558-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:29:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 333CC36FF55
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 20:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 706B5308C5ED
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CF7377542;
	Tue, 31 Mar 2026 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rfKzOPa/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A068331A78
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774981043; cv=none; b=fFgurjQ2IIqLhIA5aeqOyDs7o/q0ncFcZxMVjeMqIYY6S4QwTY88D7RrMelEjcFt8v/TugAFvhcePeWgGJOWZ11GAbE3W0iQcm0nnoOcFeHFlpcdL/NZQopX9uCgSnkohmrC59rXXobf31DGN9F66KglEhVJ4PbN30tSLqxDX00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774981043; c=relaxed/simple;
	bh=Ly67QODbGgBIWZqgOO/FYMst4z4v/VNIbOUN1sgHf5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XkQFxocTZ9kuZ7IYoKjVEQWgL35QC5bUUGtp8tapGasHzjqIdblA3hDby4mcLHH8Qv9puWKAnC28golNIVSXHKvZH8qzETjSjz/sf0rYzn+3ClKzy0l9EI248ZT96bxUXPvpbgek7SWRh0ZXbPr0EpBVYEF32GGntYAG6z+45cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rfKzOPa/; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c646e980bso4062554b3a.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774981042; x=1775585842; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WXUZURrZS3Jc82G6mEnvbSujfdYAVx/0v5wtIwtfir4=;
        b=rfKzOPa/4HsAdWevstTm7L9Ykaw/mVuVPJDN1MdhF3NvKQ9Q9fk7OLtJW2oB7ftFNM
         AtMAkQ15yyLCfSkst3EtiYE8naqfWOF/6gHnRi2809XR3koFARcbfWRhXTuRoERqn7RX
         0aSwJNL86L9KiHnIcraSLWlPTdY83xfnp4JobTVtGYW9FPngFwwprDyJl3zWMSb7Ha58
         I1wmWIMIm3rrVhWUsgiMd0xT4OIprAELmLjLPoA4F6dS4DcKbP5LVFZ56IipOa0frrMr
         RZJQa2BajpD6b45uBpa7iiQbX2TQSA7hwRuC8tZTipysEvpsDVscwA3ylayA/M2dkC6N
         WVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774981042; x=1775585842;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXUZURrZS3Jc82G6mEnvbSujfdYAVx/0v5wtIwtfir4=;
        b=o/+NI8vieqUCT67kqMxAZD3RISHoP9/2q89oM+Ye88FIdTf7TkESSWliulTqazMv3c
         kNjHn6nt8xfS07PFijKvOL0OGaCEU93855JyPEZNkVk+f3vzFlKR63aUiDQAvlm0eLsn
         UgtEQ5ftSfFEITcdLz6JAvejy/orGxqb17U+rE90YB0f85u5Zu96+pwQPw7otpZoL5uw
         pSnW087NxW/lxPeBgEX1Cku+EEy/LDZOFrXMpcEmd5pfOHTcJAS4n0PoY26W/SZRB47I
         Fjqu1mqoXd5rdkSh1+1Oyi1FiQb/hsV9LiYqecpo9yalk7GCYfN/qDwqDwTo449vMfrY
         jbwg==
X-Forwarded-Encrypted: i=1; AJvYcCWPScIFLWtfzTIgfxwT8c9xFsrtd+j11QSuB0H8WOHiMHSq0hlyq91131OL6girjfOicQyT0mI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDg/4JXBpngAG13jqz4/RmeYhwyLv8MWsbD6I8u8vN0aJnkAn
	shmHtCmCRVT0hyOOa2aXgsUKdj2l3IO62OqD8Ji5lcHSf+8NdpGPxgp86dkBBoRK3kLixoQwng3
	XnIbImA==
X-Received: from pfbfa42.prod.google.com ([2002:a05:6a00:2d2a:b0:82a:60b4:e9e9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:448d:b0:82c:70a8:faec
 with SMTP id d2e1a72fcca58-82ce8960f03mr651000b3a.21.1774981041480; Tue, 31
 Mar 2026 11:17:21 -0700 (PDT)
Date: Tue, 31 Mar 2026 11:17:19 -0700
In-Reply-To: <20260323064248.1660757-1-sonam.sanju@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260323053353.805336-1-sonam.sanju@intel.com> <20260323064248.1660757-1-sonam.sanju@intel.com>
Message-ID: <acwPr_Aic9xd95_R@google.com>
Subject: Re: [PATCH v2] KVM: irqfd: fix deadlock by moving synchronize_srcu
 out of resampler_lock
From: Sean Christopherson <seanjc@google.com>
To: Sonam Sanju <sonam.sanju@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Josh Triplett <josh@joshtriplett.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Vineeth Pillai <vineeth@bitbyteword.org>, 
	Dmitry Maluka <dmaluka@chromium.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232558-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,kernel.org,gmail.com,joshtriplett.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 333CC36FF55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+srcu folks

Please don't post subsequent versions In-Reply-To previous versions, it tends to
muck up tooling.

On Mon, Mar 23, 2026, Sonam Sanju wrote:
> irqfd_resampler_shutdown() and kvm_irqfd_assign() both call
> synchronize_srcu_expedited() while holding kvm->irqfds.resampler_lock.
> This can deadlock when multiple irqfd workers run concurrently on the
> kvm-irqfd-cleanup workqueue during VM teardown or when VMs are rapidly
> created and destroyed:
> 
>   CPU A (mutex holder)               CPU B/C/D (mutex waiters)
>   irqfd_shutdown()                   irqfd_shutdown() / kvm_irqfd_assign()
>    irqfd_resampler_shutdown()         irqfd_resampler_shutdown()
>     mutex_lock(resampler_lock)  <---- mutex_lock(resampler_lock) //BLOCKED
>     list_del_rcu(...)                     ...blocked...
>     synchronize_srcu_expedited()      // Waiters block workqueue,
>       // waits for SRCU grace            preventing SRCU grace
>       // period which requires            period from completing
>       // workqueue progress          --- DEADLOCK ---
> 
> In irqfd_resampler_shutdown(), the synchronize_srcu_expedited() in
> the else branch is called directly within the mutex.  In the if-last
> branch, kvm_unregister_irq_ack_notifier() also calls
> synchronize_srcu_expedited() internally.  In kvm_irqfd_assign(),
> synchronize_srcu_expedited() is called after list_add_rcu() but
> before mutex_unlock().  All paths can block indefinitely because:
> 
>   1. synchronize_srcu_expedited() waits for an SRCU grace period
>   2. SRCU grace period completion needs workqueue workers to run
>   3. The blocked mutex waiters occupy workqueue slots preventing progress

Unless I'm misunderstanding the bug, "fixing" in this in KVM is papering over an
underlying flaw.  Essentially, this would be establishing a rule that
synchronize_srcu_expedited() can *never* be called while holding a mutex.  That's
not viable.

>   4. The mutex holder never releases the lock -> deadlock

