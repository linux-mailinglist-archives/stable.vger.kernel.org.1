Return-Path: <stable+bounces-204151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 067B3CE8562
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 00:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5DC63014BD4
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 23:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8351FAC34;
	Mon, 29 Dec 2025 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/6p9tRd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArcTywgi"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E028371
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767051133; cv=none; b=rXmsflAPnPgAsKCUlUIJRXkmJG5UbhMfeCBs57SqdfF+klsntmCUthdNIyCzS4ZRuL+UuAhyKL3BIoPRvf99s1BuYHc7BsLEdEVRUR2ZwqEEubl9qAG6ckBmT+sEMpBCXP2yfqjIwkGUDutLAZveryuHV/M5QkmZTUwL8aeomGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767051133; c=relaxed/simple;
	bh=VaUTBJSvsXqOdyELu5IE+MD12W5UGzmSoNASfvZi/Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSOx6Sm7ATqFA3AZwy7adzxAlio1548tx3xDSRlpwN9iS5QlF957p0SnxLHYava5l+PKPLdt8bwy2k5/zxTtYS/GCCLB5+mc5VqFlrvE8WDGWOLMF3naLqch/hnVx1mqdY3hwaDskHEUHQ31AWvTAmNQoZdSmvUEalKJ0Dg1aZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/6p9tRd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArcTywgi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767051130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v7kyRsrVIZk1FR1ZrY3E5P3tsJBemoVaSOEZHvIsuco=;
	b=W/6p9tRdC+emIKwnwNSq2QjUH9VyxUUpznDV23LIl0fnkidJGEACa+h9N+gl8egsi9Gzwy
	O6zTsCXz5m9QJCFR1HebDtM3gmAsxt9u6CTUnLY8Trd2I5WTofikkORUlOUMMBNbD2xaD/
	1rX3iqOBPB2a4/upEYY8/dwGzYW5jTo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-PmjB_vhRMU6VeFPVBQXP0g-1; Mon, 29 Dec 2025 18:32:09 -0500
X-MC-Unique: PmjB_vhRMU6VeFPVBQXP0g-1
X-Mimecast-MFC-AGG-ID: PmjB_vhRMU6VeFPVBQXP0g_1767051128
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430fdaba167so5058018f8f.3
        for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767051128; x=1767655928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7kyRsrVIZk1FR1ZrY3E5P3tsJBemoVaSOEZHvIsuco=;
        b=ArcTywgi+CJobT2sNHJBgCjvuqysv5rlATM0usOuA0v4lQ4uUaADb5hH3kw/bzMHJk
         7r6HY/OKxyzWwP+ifWK8mDXNHYxlvF6nP6/mAG+ikngUhF8Lx22pSoatc4ai4S7/YrAC
         flbYQRGHuSCJtQHq54QLXYF2wuVzo2CUj8KMLQk3WagE5N8H4ecjVLb8LSW8PjARh4l7
         A+yvHzOZeFob7ZqeV6EcVr+IDMZ4cJRNQpfvHcbqKMFzMA0xdQS6igOpEXrr0+a02wvU
         +l/F9LYdhe3hTsnxJCX3iuxiF7Zwu29i/AfmpYPR53GAw3xEs7pBRX3jj4t+I506N0QZ
         IMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767051128; x=1767655928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v7kyRsrVIZk1FR1ZrY3E5P3tsJBemoVaSOEZHvIsuco=;
        b=oIdhW9Rv4hj4KKTe94O+HM9otTo0NRhPlNtClvspA00rzHVBIZ+Gym+Jil2nmGzcij
         xVMq4SJS3W9MSGr69UY1PvQt50+s4XZpLSmSuNdy6pBq0igTX82sjddSJDB869O+TY96
         OGCi/2K2UTS7M7xi9jq1MKRlgN60AUakEKokT4oPxr8KPkwexDHiTUoQVugjLzR1b36Y
         uknJAiefc1tEegkZjxJYtN90UvIFsBPnReS0YHTu9xWagt8LMVE+W/dL4pLYkpy3K2wI
         zSanooaO0NGWaJ+okQv9ZtkXGuQ/mxRPmDc5lwZk2D4VkrAYXNzS66FpR4nThp/S6Z4K
         I3Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUNvCQ4gmJrApfk68TeLuX11Ied7al0VzjOUo1t7hZ2UOBoGixena4yRzOtNgqLQGpArF5/VnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxBf38jTQpa/Bjwe+E3WdSTSeBl5icLi3nuPxUDYrHDnIiii1
	kopjf3a9JgybWU+lOOQldlUe8T28q5om5EkqIrK3iYaLgPCUInL93SjORzgzffbpPyL9sli7du8
	p4JGCzlgtt94eSZIErHVuejRzEmDGYGcEMq6wOSBp6SNh4f7yht0T3yxq9Gl5BrhF59gyEJvx3j
	Knp3CDGxsOn15xnTMiBjwo0TTccH1WKT4c
X-Gm-Gg: AY/fxX66vyA0tDKsrIGpNH/6NI7EvJmDygNQshISs1ruu/MbDU5+QP2aSC6aqHhET/i
	Z8kw6bSbeiLulSsZS0IvHPR/+Z1yDr+iWv5l8LOdFpt5/iMiMZPOzOFX7bpBB9pCH/JDMkFHmxy
	hcroG+aGXV5xJOaSEWp9zY2zNQGeGWgYgjrJgwl42IqGmJsVMz1Ie60TRRJbGrBRUtVk3+FnOgQ
	feduyKE7ge61ArMHvfdwl9pYcapqL8KWrmlLXiIwJ1lylPvPmC2iUZJyFIe8vcJBhNU8A==
X-Received: by 2002:a05:6000:400d:b0:432:8585:6830 with SMTP id ffacd0b85a97d-43285856833mr13154972f8f.45.1767051127755;
        Mon, 29 Dec 2025 15:32:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGIxhgixRHcBcMAdNd0UXINlOW3YIfsEpQQ/A6lIz0y288uMkc+e8ZfLSmkvr/4xmOuW9yyMRjTyfAUVWwGL7c=
X-Received: by 2002:a05:6000:400d:b0:432:8585:6830 with SMTP id
 ffacd0b85a97d-43285856833mr13154948f8f.45.1767051126747; Mon, 29 Dec 2025
 15:32:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224001249.1041934-1-pbonzini@redhat.com> <20251224001249.1041934-3-pbonzini@redhat.com>
 <aVMEcaZD_SzKzRvr@google.com>
In-Reply-To: <aVMEcaZD_SzKzRvr@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Dec 2025 00:31:55 +0100
X-Gm-Features: AQt7F2qTvZTEwMu-0IfQDRQ5ZbN8LxATYy1O8M2J6J0jA7it_Bo-SKmklPWdgEU
Message-ID: <CABgObfa5ViBjb_BnmKqf0+7M6rZ5-M+yOw_7tVK_Ek6tp21Z=w@mail.gmail.com>
Subject: Re: [PATCH 2/5] x86, fpu: separate fpstate->xfd and guest XFD
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 11:45=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> The fix works only because the userspace XFD[18] must be '0' since the ke=
rnel
> never re-disables XFD features after they are enabled.

Yes, this is why I considered XFD[18]=3D1 to be a bug.

> Which is probably fine
> in practice since re-disabling a component for a guest task would need to=
 force
> the guest FPU back into an init state as well, but I don't love the compl=
exity.
>
> This also creates a nasty, subtle asymmetry in KVM's ABI.

I find this second argument more convincing; I preferred the
complexity of an extra field to track guest xfd, to having to patch
xstate_bv.

(Initially I was worried also about mismatches between xstate_bv and
xcomp_bv but those are find; When the compacted format is in use
xcomp_bv[62:0] is simply EDX:EAX & XCR0).

> Lastly, the fix is effectively papering over another bug, which I'm prett=
y sure
> is the underlying issue that was originally encountered.

Yes, I agree this is the most likely scenario. Whether it's papering
over it or otherwise, it depends on what you consider the invariants
to be.

> So, given that KVM's effective ABI is to record XSTATE_BV[i]=3D0 if XFD[i=
]=3D=3D1, I
> vote to fix this by emulating that behavior when stuffing XFD in
> fpu_update_guest_xfd(), and then manually closing the hole Paolo found in
> fpu_copy_uabi_to_guest_fpstate().

I disagree with changing the argument from const void* to void*.
Let's instead treat it as a KVM backwards-compatibility quirk:

    union fpregs_state *xstate =3D
        (union fpregs_state *)guest_xsave->region;
    xstate->xsave.header.xfeatures &=3D
        ~vcpu->arch.guest_fpu.fpstate->xfd;

It keeps the kernel/ API const as expected and if anything I'd
consider adding a WARN to fpu_copy_uabi_to_guest_fpstate(), basically
asserting that there would be no #NM on the subsequent restore.

> @@ -319,10 +319,25 @@ EXPORT_SYMBOL_FOR_KVM(fpu_enable_guest_xfd_features=
);
>  #ifdef CONFIG_X86_64
>  void fpu_update_guest_xfd(struct fpu_guest *guest_fpu, u64 xfd)
>  {
> +       struct fpstate *fpstate =3D guest_fpu->fpstate;
> +
>         fpregs_lock();
> -       guest_fpu->fpstate->xfd =3D xfd;
> -       if (guest_fpu->fpstate->in_use)
> -               xfd_update_state(guest_fpu->fpstate);
> +       fpstate->xfd =3D xfd;
> +       if (fpstate->in_use)
> +               xfd_update_state(fpstate);
> +
> +       /*
> +        * If the guest's FPU state is NOT resident in hardware, clear di=
sabled
> +        * components in XSTATE_BV as attempting to load disabled compone=
nts
> +        * will generate #NM _in the host_, and KVM's ABI is that saving =
guest
> +        * XSAVE state should see XSTATE_BV[i]=3D0 if XFD[i]=3D1.
> +        *
> +        * If the guest's FPU state is in hardware, simply do nothing as =
XSAVE
> +        * itself saves XSTATE_BV[i] as 0 if XFD[i]=3D1.

s/saves/(from fpu_swap_kvm_fpstate) will save/

> +        */
> +       if (xfd && test_thread_flag(TIF_NEED_FPU_LOAD))
> +               fpstate->regs.xsave.header.xfeatures &=3D ~xfd;

No objections to this part.  I'll play with this to adjust the
selftests either tomorrow or, more likely, on January 2nd, and send a
v2 that also includes the change from preemption_disabled to
irqs_disabled.

I take it that you don't have any qualms with the new
fpu_load_guest_fpstate function, but let me know if you prefer to have
it in a separate submission destined to 6.20 only.

Paolo


