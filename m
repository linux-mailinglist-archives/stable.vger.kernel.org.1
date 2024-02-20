Return-Path: <stable+bounces-20807-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDBE85BBE8
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 13:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ADC31F22897
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 12:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F7267E83;
	Tue, 20 Feb 2024 12:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDYtDv/L"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755C5B1F9
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708431767; cv=none; b=kqW33buSS44zwlnMJvlYYDLDw/7vCY1BgWusOhouGb5EoQJ1kf0CX0oFWRHXxXCFGmlRhAhE9w9cYTVgYiLRTgl5497eJbISd9I+vttUcYrlB7C0lbphGWr9jfWRav7KYdDNfrwvosgNyOKiIwvPbg+T0P/Jnlq6SQLRzQ/9KoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708431767; c=relaxed/simple;
	bh=1f11NDJPNaBatEI6pO3kjUS1wCUWc9exdxFhhlFAAj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQy0sG0VV83LBb0cLozdIVLv9egG3WmpqBwm/NadyNbu3n6hC9Bf758XRjD+Ra+vds2wdWD7iR4qnkNpjSA2UTaKRMjilaubBb4PcCDcXgBVNb/6kcBl241UX1NU7cE83EhoZX4HiBmVvQ7i5lCB7xppw8nCy9apWptjDbwXkx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDYtDv/L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708431765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nryE0QvpwIF+GBr6vQnaZDO8tVOPi12/n3SsPAdoTf4=;
	b=QDYtDv/LeiRDpgJx4tt0BA4UsHSmM2uQdHag/+jy8dFZf/UTUl/Rcmg+34cBNZWqmXqyTC
	m7eSzg8g24jyD/qQhoI6YaLMsVyx5JdlOfo5bWIq11K6bOGKRQ9pYV7hbQ7MvUtGy2hmxA
	9dXFnkZ9pajMURjLxKaGZl2BEjcwoQc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-f043jcXxOweED2Fsd7gQ-w-1; Tue, 20 Feb 2024 07:22:43 -0500
X-MC-Unique: f043jcXxOweED2Fsd7gQ-w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41225d3b3d1so26400755e9.0
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 04:22:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708431762; x=1709036562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nryE0QvpwIF+GBr6vQnaZDO8tVOPi12/n3SsPAdoTf4=;
        b=A/LIEMz/wbBjwK0aFSDb4Czd4QZAzc9Ym87HLaBnFAG6NNcwPbwPaq2Nqex/HqQbiN
         a6JPj7GJurD0O4XChm6XetUPsCBpteKkaDPDZ+Xa6QO9eAEgq1lmnD1Ad9ppFW3mpZDG
         9iHZoxidUzCC69Ho8lW1KOmfsIfrfKOKTJp4OWisYARDj9/9XBO6O5OXj2NWv6mZKQK0
         e0JGZHTssQnIx6ZsDkQc+0LJyfg/lXh5Pk1Is40cQUsblow+FRicx7mN/Dw1w2z2uVhv
         FWbemUw01eogeUZ7UoK3kfLWrq7ZLSs0ss0ply/quM9aRk4VP96UaKHlOnzbHBuZFr/3
         oLSg==
X-Forwarded-Encrypted: i=1; AJvYcCVkN+UMIP6UHDdzzHqAVa22R3iYVqwZ5/doCr0NngbbLhbgu8nSiiXtT+vntEGm68Z+hwK3+u6KIpF87opRbEQXxqSWINbN
X-Gm-Message-State: AOJu0YxqrXYfNGF2RTCLyQK2UCx6KhWXLwLfkasB1cPHPkSexB0oEz/g
	gldxpoyInw4mE4skNprpFo+tGsS1GiZI0lQbgduZRUO7cRqUW2Jrz9NRJyh89K4sFa6kWkjeZ09
	3pbimIaCerdGs+yJCoemlGE7kP3AqS8LxB5xeuOxNJNxvSf7lBWvdytmCp3yFlvrG5HiHheJ3In
	xcxzHxpXinxAacO2HI59JTLy/7Xvor
X-Received: by 2002:a05:600c:35c4:b0:411:e145:bfad with SMTP id r4-20020a05600c35c400b00411e145bfadmr10448435wmq.40.1708431762459;
        Tue, 20 Feb 2024 04:22:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvnATC39HsxnxsVPrX2vePi3o4k+bGJVrQJVVrIuj4lKaYfDwJip1nNryMKhpbiQwD04oJARcbUxMwnO4L7xA=
X-Received: by 2002:a05:600c:35c4:b0:411:e145:bfad with SMTP id
 r4-20020a05600c35c400b00411e145bfadmr10448417wmq.40.1708431762136; Tue, 20
 Feb 2024 04:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131230902.1867092-1-pbonzini@redhat.com> <2b5e6d68-007e-48bd-be61-9a354be2ccbf@intel.com>
 <CABgObfa_7ZAq1Kb9G=ehkzHfc5if3wnFi-kj3MZLE3oYLrArdQ@mail.gmail.com>
 <CABgObfbetwO=4whrCE+cFfCPJa0nsK=h6sQAaoamJH=UqaJqTg@mail.gmail.com>
 <CABgObfbUcG5NyKhLOnihWKNVM0OZ7zb9R=ADzq7mjbyOCg3tUw@mail.gmail.com> <eefbce80-18c5-42e7-8cde-3a352d5811de@intel.com>
In-Reply-To: <eefbce80-18c5-42e7-8cde-3a352d5811de@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 20 Feb 2024 13:22:29 +0100
Message-ID: <CABgObfY=3msvJ2M-gHMqawcoaW5CDVDVxCO0jWi+6wrcrsEtAw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] x86/cpu: fix invalid MTRR mask values for SEV or TME
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Zixi Chen <zixchen@redhat.com>, Adam Dunlap <acdunlap@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:02=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
> Your patches make things a wee bit worse in the meantime, but they pale
> in comparison to the random spaghetti that we've already got.  Also, we
> probably need the early TME stuff regardless.
>
> I think I'll probably suck it up, apply them, then fix them up along
> with the greater mess.
>
> Anybody have any better ideas?

Ping, in the end are we applying these patches for either 6.8 or 6.9?

Paolo


