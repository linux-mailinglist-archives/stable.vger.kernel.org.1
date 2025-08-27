Return-Path: <stable+bounces-176520-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCEAB3876A
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 18:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9E63B1425
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 16:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B91D139579;
	Wed, 27 Aug 2025 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XBUSXGrU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AA42C2358
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310949; cv=none; b=h5OSpdGYuuOHxlE5yMUwk4V0eOq+GNURr0/+3f7JUkQGQ5R3mu3LmnVtkb9lELlaJ9jaEW10ERFxztAw39UZLI9FYSCngnb6pgF9LZnl6VOC4MHnsEX5M8Rv8ENDuXafEvjKOlwZetqZKNFS4/84m0P9cFInsneBOhK6BI34Vgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310949; c=relaxed/simple;
	bh=wlTH+5UGUT9Xvxi73T4MXazMDiYu+KQldwNPj3NcMc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URoqyrs1NBvP/gKmV5Ax3dJ+VIp5IrGfZ3Xb2gwagLX+SL/6tEnS/0dlxC6DL17aRTwoqzn+G4qLqmb99LCg3ZUvz3kRHWopYYHDFwpkYII33QiMy1kQ9H1aQUpKnS2IScuwAyEeEctB5sOGnroOcz9y6AFlUAPFVtq1irkWhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XBUSXGrU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756310946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aziSJBo5W0zZFPc57AR4Qia1md3fUN9PvjS7bGiGW2g=;
	b=XBUSXGrUBChLdZ4+Tfx2FOQVoP3m57MiKVLagmk7s9+rPN6oljNCkPFSS7Lf1dpGIQJkPj
	7BULTBzB1/0ml19rSohnUeRmnHRIheAxX5l7X6+5/m+IEV4fqYMAE70CbFmSfC8Z4gu/hb
	O87oTUs5p6Oduyi+DV2l7ItcbQKpa2I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-JN6SgstSN8WWE8m5zMOgJQ-1; Wed, 27 Aug 2025 12:09:04 -0400
X-MC-Unique: JN6SgstSN8WWE8m5zMOgJQ-1
X-Mimecast-MFC-AGG-ID: JN6SgstSN8WWE8m5zMOgJQ_1756310944
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3cc3765679fso521690f8f.2
        for <stable@vger.kernel.org>; Wed, 27 Aug 2025 09:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310944; x=1756915744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aziSJBo5W0zZFPc57AR4Qia1md3fUN9PvjS7bGiGW2g=;
        b=ktpBiF5avuuxPTVjd12kkhKR7TZNnvgqxbqFcCjgtZ5sR8O0t8yCNIhXIHPSOtIF56
         xbHS9oy3Gy2EF+e7f2TpqSJ1soe0o5OVW132ZN5c+uoR71vrTwThJ5V43PER3LJOle6o
         3uukb1OL9sHJfKS9g7Rng27O1PFijsgFIruG+7fat7LyPLfxCEaqCWvd3lpWvINfUxKq
         fSiiZt3mhrRAcXvQHHtPYByI37vRnCFEnrXnrQEchiwoZCTEjeemQoHqJGpzRF1ZTxDa
         3No40L8GY5TIPzZBTwyKAn00P353Dp5NbG67WAWXCrID6eCoBuEJ67Qtb2aICZk8X5y2
         qgnw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3LicZqwsR+VD4jdYu85MGV2ZHY9YhU++Lz/bYK5MzMPDT1DDdareLo8tHA/qMzgVhoqoQho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypw4ZjsY2ItbFYpq58kIyBZIBRGM4iFjG9YePxcX/Q1vQhLJHr
	4vWXiJCtP7KwpcWGE0wV49gcFuIImrozUPrbO8MG6EMGJzq7KyxSLKKLuuHpoC0De7qJ7SjQHz5
	rrVu9GX+1uRnt+EcZGyd7ycdwpu08Nyd9KBI/E+fkw9BrobwoCq9RnBriSbmz3czAXGhv3YcAjh
	Tyts4pLD5Db31hFSd8jraGGHGRJqRRMRFU
X-Gm-Gg: ASbGncurArXzh6WFRYkzRAwR07Sllb70QuUBBX3t7w8svM4x5GcCht0OZo64pfKyjys
	JwpD3rRjX79h9wMAqzel+gUJz+V6SRz1DsYc7CHfSHgVlfE+P7okaE6TLe/caY1kqLtFWz9YRu1
	T+AD5tq5ZWqCJsXykvMSfXn3LtwURLs578Nqilm6mhLoHV7uTgJDQSrWKdD16epB+2ze2VbJyL4
	tnmlSgLols2ueFm7BEBRPFv
X-Received: by 2002:a05:6000:4283:b0:3ca:3206:292 with SMTP id ffacd0b85a97d-3ca3206064fmr8023174f8f.48.1756310943653;
        Wed, 27 Aug 2025 09:09:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyzruEFQtE9U3R7B7rCEUd8qatzIadAOnmk2mQCbEKGI0DFr7kcsvt9yS7Q0qnfidsQFJAmgRQ1SijtcNlzA4=
X-Received: by 2002:a05:6000:4283:b0:3ca:3206:292 with SMTP id
 ffacd0b85a97d-3ca3206064fmr8023149f8f.48.1756310943213; Wed, 27 Aug 2025
 09:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827152754.12481-1-lifei.shirley@bytedance.com> <aK8r11trXDjBnRON@google.com>
In-Reply-To: <aK8r11trXDjBnRON@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Aug 2025 18:08:51 +0200
X-Gm-Features: Ac12FXyXHiiKVDGGLGUulr7kfdt9R7TiAvRQk5lVCccDer67HJTPi0VyzHtDREc
Message-ID: <CABgObfYqVTK3uB00pAyZAdX=Vx1Xx_M0MOwUzm+D1C04mrVfig@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Latch INITs only in specific CPU states in KVM_SET_VCPU_EVENTS
To: Sean Christopherson <seanjc@google.com>
Cc: Fei Li <lifei.shirley@bytedance.com>, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, liran.alon@oracle.com, 
	hpa@zytor.com, wanpeng.li@hotmail.com, kvm@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 6:01=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Wed, Aug 27, 2025, Fei Li wrote:
> > Commit ff90afa75573 ("KVM: x86: Evaluate latched_init in
> > KVM_SET_VCPU_EVENTS when vCPU not in SMM") changes KVM_SET_VCPU_EVENTS
> > handler to set pending LAPIC INIT event regardless of if vCPU is in
> > SMM mode or not.
> >
> > However, latch INIT without checking CPU state exists race condition,
> > which causes the loss of INIT event. This is fatal during the VM
> > startup process because it will cause some AP to never switch to
> > non-root mode. Just as commit f4ef19108608 ("KVM: X86: Fix loss of
> > pending INIT due to race") said:
> >       BSP                          AP
> >                      kvm_vcpu_ioctl_x86_get_vcpu_events
> >                        events->smi.latched_init =3D 0
> >
> >                      kvm_vcpu_block
> >                        kvm_vcpu_check_block
> >                          schedule
> >
> > send INIT to AP
> >                      kvm_vcpu_ioctl_x86_set_vcpu_events
> >                      (e.g. `info registers -a` when VM starts/reboots)
> >                        if (events->smi.latched_init =3D=3D 0)
> >                          clear INIT in pending_events
>
> This is a QEMU bug, no?

I think I agree.

> IIUC, it's invoking kvm_vcpu_ioctl_x86_set_vcpu_events()
> with stale data.

More precisely, it's not expecting other vCPUs to change the pending
events asynchronously.

> I'm also a bit confused as to how QEMU is even gaining control
> of the vCPU to emit KVM_SET_VCPU_EVENTS if the vCPU is in
> kvm_vcpu_block().

With a signal. :)

Paolo


