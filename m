Return-Path: <stable+bounces-195008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0C4C65BE3
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 19:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9C774E5299
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 18:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4607C314B95;
	Mon, 17 Nov 2025 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mdmy6gHR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hE+NW2jR"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B12FFF99
	for <stable@vger.kernel.org>; Mon, 17 Nov 2025 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404708; cv=none; b=qFd1fJAf4MiWOgdCB927gVmE27Gj1sFUxIfa8f+bpoj46UJFTj9fBvYx99hhTx53fzlxldnjUmjUZAUoSjXugsVIptD7DYvm/AB5MskE+SI75Gu9YvTEIN1v/RyLEyuHmdfHLVfOixjURUnUW+rYq3UafNX2iuApZx6h07Soywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404708; c=relaxed/simple;
	bh=qt8pI/XUyJPmOWFJ8OtyNeKVh5q3V2jICBQ1DQqA8Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1KK30HRH6z3tlhfw60Tc3tieviC4X0f1Hjfe2N+iBahJGTBgFuE7lvqtHzj9i8SJxqx3Z5/lmxAGIJOUHVk3dxDPW5ny7PE+SOt6rYFv132MEb4wnRTbZzyHd2cuk9iIdWoYiDdSqXWxVdS8+N80bd54Sf/qPUSqmSovkXxI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mdmy6gHR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hE+NW2jR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763404705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qt8pI/XUyJPmOWFJ8OtyNeKVh5q3V2jICBQ1DQqA8Tk=;
	b=Mdmy6gHReQBr5KcVMYvrtcr6QIhIf88JT7YXHIo+lzbawJ8WpouXUC0FpEIF+sJCz8+eKz
	OJJqk+ne8S7wOk3zP+27McXAwWx/+zU66AWe7lKzfOwGghxeNHaocDMAn0xtjb+WmatQ4q
	Bpe0ZWgowQranAdPfnWPR44YuTZhltM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-9ArxPe5YM0ujFVqQk6LCeQ-1; Mon, 17 Nov 2025 13:38:23 -0500
X-MC-Unique: 9ArxPe5YM0ujFVqQk6LCeQ-1
X-Mimecast-MFC-AGG-ID: 9ArxPe5YM0ujFVqQk6LCeQ_1763404702
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b3c965ce5so3205686f8f.2
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 10:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763404702; x=1764009502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qt8pI/XUyJPmOWFJ8OtyNeKVh5q3V2jICBQ1DQqA8Tk=;
        b=hE+NW2jR+vWdAOnHjMn5wW6IztLhlVExY/8hvU3iYbXZlJWNE0L0TPsRmU4d+sO1Uq
         DqsEKok8GDugdUvO93Xi7dmHiVNfE6hd1UtDcIYbnhSQS6U9/DucZcpLOYGZUQ42K5Oi
         +Q4lvdLB7bpufgVJ6I5oUkz6OjVvkCVsQRxi1LOaQ+edGyb/KeQNYc+6K3Eh/mcCKLZ2
         dyMesBeG6XsVuc4HSm/3tIwnrfc44yYaIN+0nvl/rRqHQM2b1ekMZy4kdiAPPGdPGi3R
         5SANdh8dcugdePW//srYQmSv3/JOySjRBqlatOgZGe5HEEsVOwFjBrxu8pHbU3SL6EzD
         OWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763404702; x=1764009502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qt8pI/XUyJPmOWFJ8OtyNeKVh5q3V2jICBQ1DQqA8Tk=;
        b=l370Gag0ZvtKLOezEkqHFuByn6Q7vRVgIdvK0l/4j4TL0iRO14SLnWCJPMW8LgIIXr
         YglCo8jCkK0c9PPM9tSX8NsV6j9qqR8Sz4GIL7wPlt9TOQs60LqJrxIi+HGosubcmIj1
         eN8/wRgf1OIb8GvbOe+YsV5z4+pli4zYcMsoZOzFZ7tpbSzLhhgTfA4D/AYcfn7CJ0vj
         Zsyzt62TB1+u5GXcBbHnHwfo1UoIg4XzaKu6WmLwHbd0kYOns9coBGzDHrTIGiL6u2eI
         b+ZDcCeHYTrB7XAtREHwG4Y+qZUeGcNPl22nXQ1H1TWQIPV+f8D1yBpTpoAu0n+FzTAp
         zzGw==
X-Forwarded-Encrypted: i=1; AJvYcCUHZCQJF/pOQ/vOoFSkbg1dNPiFVmQhIrd2tT8gmPyA0/wXrY0B/A9Qthz7RKFgPaS+nZClwgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlBp0f6BxaC14NMuUrfGvxXlKcEScLNZyMHu51ysK4MyX5vbyv
	AU8GBsNI6iKbNH9p5tgbBSExehRGGfmqippzwLbJB3rdaaAI5NVlhFLa3iDaS7yfM/QGti48NTN
	yFIrBcqE08H7JEpZiuqXVI4Csunk2d0dkhfY8FNkma3chPIrUka5b06eK0vp8dq9p2ceyVwcTbI
	27fCs2LURVS+H0mAeouAkYSWsE78YsFSJZ
X-Gm-Gg: ASbGnctnQujxs/JhKljRKaFEKR9bcQlY0jozCRBjIFP5R88NCHelGSGyWWopmjUFZsn
	Lxjn6AsTc3zgSgHiGJs1NsN0uGAa186zbPg0TkFhWJ0JjqICr0gKJXwV//PFnghQ26OhzWncTfu
	PRlLPPyjYqCZMSXix65zL/z6wCjejuc8+0v/zw9WMQan8YOSJv2N3oqG4FhBYIA/ngiZ8iyrWkk
	wkF2CHyl7/Vi7pPVYMkfwEcUyaj6JYpzXsxg7mvyyz/kH7v+K1Cpx/V4NfJM5uue4e/Bkk=
X-Received: by 2002:a5d:5f50:0:b0:42b:300f:7d8d with SMTP id ffacd0b85a97d-42b593869c6mr13166812f8f.34.1763404702321;
        Mon, 17 Nov 2025 10:38:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnEaD/rV3lWOiO5rreNhHE1lGuzFUaOfW3HAQS5wjJ4b9AS2smFRbUlViMrFrMV9q3Tzd8rnKyclt9DgLWMQs=
X-Received: by 2002:a5d:5f50:0:b0:42b:300f:7d8d with SMTP id
 ffacd0b85a97d-42b593869c6mr13166788f8f.34.1763404701936; Mon, 17 Nov 2025
 10:38:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112013017.1836863-1-yosry.ahmed@linux.dev>
 <aRdaLrnQ8Xt77S8Y@google.com> <ei6cdmnvhzyavfobamjkcq2ghdrxcv7ruxhcbzzycqlvaty7zr@5cjkfczxiqom>
In-Reply-To: <ei6cdmnvhzyavfobamjkcq2ghdrxcv7ruxhcbzzycqlvaty7zr@5cjkfczxiqom>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Nov 2025 19:38:09 +0100
X-Gm-Features: AWmQ_bnIlZmixuOYfjEcsFi-_x45fU5TrndzUaisTYGr1jqd8XVwM4JZZyjUEKc
Message-ID: <CABgObfa8O9m+jFBMMnJn63PSnK8rQWixKH4WkcjKAh9F4UtzwQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Fix redundant updates of LBR MSR intercepts
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:52=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Fri, Nov 14, 2025 at 08:34:54AM -0800, Sean Christopherson wrote:
> > On Wed, Nov 12, 2025, Yosry Ahmed wrote:
> > > svm_update_lbrv() always updates LBR MSRs intercepts, even when they =
are
> > > already set correctly. This results in force_msr_bitmap_recalc always
> > > being set to true on every nested transition,
> >
> > Nit, it's only on VMRUN, not on every transition (i.e. not on nested #V=
MEXIT).
>
> How so? svm_update_lbrv() will also be called in nested_svm_vmexit(),
> and it will eventually lead to force_msr_bitmap_recalc being set to
> true.
>
> I guess what you meant is the "undoing the Hyper-V optimization" part.
> That is indeed only affected by the svm_update_lbrv() call in the nested
> VMRUN path.

Yes, I'll make sure that's clear in the changelog.

> Paolo, do you prefer a updated patch with the updated changelog, or
> fixing it up when you apply it?

I'll take care of it, thanks!

Paolo


