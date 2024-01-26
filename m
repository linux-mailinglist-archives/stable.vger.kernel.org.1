Return-Path: <stable+bounces-15910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6283E107
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 19:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0932815CF
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 18:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B4D1F604;
	Fri, 26 Jan 2024 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOv0vyMB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C6125D8
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 18:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706292309; cv=none; b=jZD2ouZ45jfdSywK4qYgWaQ6/3Yhi7AoEWSjTlYUwcv+yVvHITgHY2Ldj8MU9QaC99WFkghFy5Ppwmq6i4MMaHuOU0UrINnHw2Lf8NSCYwkNilUxxD6vfXctFxliRKRVjh0q69oAugnpY7cHLYxiRtWQmz/MXzGFDZigsQRZ0So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706292309; c=relaxed/simple;
	bh=YJMc5fnlCkuUEmLXP6Tl3tYWjT8ss3qsBaZtHkaa+bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CR75blhQAg+EqspisQCfU5sKdv5LL1hoPILIWDgC09+LArnGWAEQu/rYHyo42bpRaureEc2GiSwbUnQoIButd2j6Lxm92fYQv+sfnTYrM2sFzi/BD9YMJQy/jEzchZZQ4J2YrUcvUSRSAzRM91xNZ6I7T16t7v4bdniEgFsMSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOv0vyMB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706292306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJMc5fnlCkuUEmLXP6Tl3tYWjT8ss3qsBaZtHkaa+bw=;
	b=fOv0vyMB8JvZPQPFvDEowWsWkiUhrsP6p20HKUtmZ2csHEHKGqdCjnIhH4xWx8LXomvNHT
	h639BnwYp6dT4tPo3VVBtvcfmt6eUELr01PYfEmHMJgIs91GP03fzxqFfQns44244BNFRS
	tTuA0nNRXW2vvgJoc6QJKwez8tHVhM4=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-GzhyYRzfMmiM3X-NkWG1uA-1; Fri, 26 Jan 2024 13:05:04 -0500
X-MC-Unique: GzhyYRzfMmiM3X-NkWG1uA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6dde8cf78c4so684742a34.1
        for <stable@vger.kernel.org>; Fri, 26 Jan 2024 10:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706292303; x=1706897103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YJMc5fnlCkuUEmLXP6Tl3tYWjT8ss3qsBaZtHkaa+bw=;
        b=wFTCtckiaXzKAoDZ4ZiKz7fVhRPAO73iQ3snIhT1Ia+jKIHAfMJ+sMyc4dX45TUYfh
         roeF5YYGc3N0iU73xNXPq12RAPzcwsyB4NIKbmcjDNmujkSRuBueSd9fVigqNKroBIE0
         mbhvVEEXgNSUkBRIGwQJ+o1hE7DOO39WQgHycjv/7memAsWWax/ZsRVITDlXOWxLE4Mv
         IaRupC+VFQ86kjSBEd5WPVzzRNFgYDsK18mknWADVQ4V8DuXXtbz+IQnl4iJmijLN94w
         NsO9ryAd8m790Ld2Hvpb3QKbG+CD8SZ5hb/pZcFuQ9TzDermgWATBY6q/thKVP+T33n+
         X88Q==
X-Gm-Message-State: AOJu0YwdeY0UzBCFMIB5bGMGUU8IFnJfxqYE0cHiDPnVtxFBaNsArOqL
	YVA+gcEuWkeatZIiD+AjOzTD8Tg9xonnIf+8CwQoQte3Ed7tTHz0aCtedlSX6cNi3pEMHHJjf4V
	JwnH7Jrs48wX+fQ6ef7OPjDbeIcCtKiENHQXM9nDSKPEQHzOLWEeC8qBRYpOsCZBDxCErNwP6iJ
	ofWDIo28rtHqr6+vbBcLT5I5ZCDfJaVCiWaJGF
X-Received: by 2002:a05:6830:440b:b0:6dd:d3e3:2b9e with SMTP id q11-20020a056830440b00b006ddd3e32b9emr131148otv.70.1706292303440;
        Fri, 26 Jan 2024 10:05:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtXjuAwv2C6q/JdTxg0yD2YWrs0bInyXGelzWt8FlU7z0MeM3RgLbKTqYJMTjbLaP2zHDUWScPVEoHZ+p3jUw=
X-Received: by 2002:a05:6830:440b:b0:6dd:d3e3:2b9e with SMTP id
 q11-20020a056830440b00b006ddd3e32b9emr131130otv.70.1706292303229; Fri, 26 Jan
 2024 10:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126095514.2681649-1-oficerovas@altlinux.org>
In-Reply-To: <20240126095514.2681649-1-oficerovas@altlinux.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 26 Jan 2024 19:04:51 +0100
Message-ID: <CABgObfaoremaWjiOCFJey4EPMLt3MKbny+QuU8Gut18MxwVhCg@mail.gmail.com>
Subject: Re: [PATCH 0/2] kvm: fix kmalloc bug in kvm_arch_prepare_memory_region
 on 5.10 stable kernel
To: oficerovas@altlinux.org
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>, kovalev@altlinux.org, 
	nickel@altlinux.org, dutyrok@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 11:01=E2=80=AFAM <oficerovas@altlinux.org> wrote:
>
> From: Alexander Ofitserov <oficerovas@altlinux.org>
>
> Syzkaller hit 'WARNING: kmalloc bug in kvm_arch_prepare_memory_region' bu=
g.
>
> This bug is not a vulnerability and is reproduced only when running with =
root privileges
> for stable 5.10 kernel.
>
> Bug fixed by backported commits in next two patches.
> [PATCH 1/2] mm: vmalloc: introduce array allocation functions
> [PATCH 2/2] KVM: use __vcalloc for very large allocations

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

>
> --
> 2.42.1
>


