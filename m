Return-Path: <stable+bounces-78195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146AD98923C
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 03:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 474AB285AB5
	for <lists+stable@lfdr.de>; Sun, 29 Sep 2024 01:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C14036D;
	Sun, 29 Sep 2024 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xwfki/Mh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF10625
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 01:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727571765; cv=none; b=WKUkbtUFjiJe3qLb3OLlYxsW4bhsNhdMo/5FKQUd7XrLf2KSzkfLOhbZ5fO3JQMVh6YLGP9Ko6j5Yab8H2uUsZwTFFPZXr/95qjVxmSwrB/uRZKPJlAk1hUlLgSZI7XrO5eR5q6jnYet1koSSSKRUwadLUsZel/4rUA8u4SNwpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727571765; c=relaxed/simple;
	bh=Pj0IxshIJH6Bggjnx49qbtJiJxEhuYQSEgzZl4oKhS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=furQ1xj5vwURBvHAdWWHwURrzdBIKqb0DEP5m4m/ytTbx8B8SOapbxDdjmWZ9aBdKHrEeG+IrRHvV5SLO145w805SS2+WCWYxYYKjMC4148bYC9lRUmiGn7xXg+xFi3UYaWI+NtzN4a7QFDi4xmrPJvK8hD74fmizKIPOfip8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xwfki/Mh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8952BC4CECD
	for <stable@vger.kernel.org>; Sun, 29 Sep 2024 01:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727571764;
	bh=Pj0IxshIJH6Bggjnx49qbtJiJxEhuYQSEgzZl4oKhS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xwfki/MhV+NFusCevh6/X8WDjnXeQRxIR+09rWdRW1FrmaGYRtCY/2iASS/4J9ZaO
	 0bdxoMt4Q80YdOU9kv7Drf6hCm7znKfegstHcDL6XcOwKdoJdEaAGlCDvt7lYOqOG/
	 qXTfqs9XJW8dYrR4dUx10D6R/QVSI2T+Ma4hcXjmg4KvkBoBuH3a9WvZFyWKHgByB7
	 wjqvzYSeTsm89f0fgcqkaEnu2C8Ts4fS6zkjUQ73pjDWk+xsllfbYapl214HQ89qmj
	 4VBHfjzYgTBQ89IOG8c7G0S0p6CKhQrKO5TfDRPAY1AuznowBXiF9zv/PIXm78IRHQ
	 9U+ryU9cUntfA==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c876ed9c93so3224904a12.2
        for <stable@vger.kernel.org>; Sat, 28 Sep 2024 18:02:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAnf9VDuyXgE5tfNyYqZ74MB3skrAF840A0egmHK3z75Gwh48jH6EmWPWG8xR2YgST7d621KM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpc5TQUBvbeQuIDpoV3cbjMXHTjcQ8/XJzir4S5XaXXiV0z4Y3
	1QqPAIk9+aQc9aMtruc5qxkUybSoQkGdE2fKzQ+WgrbaV29wHBeJo6LrguV4bL4OUl/VotkqrT6
	7gAfv4Yn2D24gSgHRrzowyZR5irM=
X-Google-Smtp-Source: AGHT+IFulUaiTzbDzWhIekoRSyHL9cv4w5EfjVkBn3/A+jBxIi5vo2uzOBESt2XlGAwVDBeydtr2ZzrttRMogE4v5Oo=
X-Received: by 2002:a17:907:86a5:b0:a7a:b4bd:d0eb with SMTP id
 a640c23a62f3a-a93c492185bmr769522766b.24.1727571763077; Sat, 28 Sep 2024
 18:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72mHQ0eKJoZeRxB5h1eHza8nERA_DtWUMKecyQuivH7SXw@mail.gmail.com>
In-Reply-To: <CANiq72mHQ0eKJoZeRxB5h1eHza8nERA_DtWUMKecyQuivH7SXw@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sun, 29 Sep 2024 09:02:33 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4WLByJ53oqQgEnVjy4bT0pS77fT5BA4NaCp8AOn+cyJw@mail.gmail.com>
Message-ID: <CAAhV-H4WLByJ53oqQgEnVjy4bT0pS77fT5BA4NaCp8AOn+cyJw@mail.gmail.com>
Subject: Re: stable-rc/linux-6.10.y: error: no member named 'st' in 'struct kvm_vcpu_arch'
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Bibo Mao <maobibo@loongson.cn>, 
	Greg KH <gregkh@linuxfoundation.org>, loongarch@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 8:29=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Sasha, LoongArch,
>
> In a stable-rc/linux-6.10.y build-test today, I got:
>
>     arch/loongarch/kvm/vcpu.c:575:15: error: no member named 'st' in
> 'struct kvm_vcpu_arch'
>       575 |                         vcpu->arch.st.guest_addr =3D 0;
>
> which I guess is triggered by missing prerequisites for commit
> 56f7eeae40de ("LoongArch: KVM: Invalidate guest steal time address on
> vCPU reset").
Hmm, please drop the backported patch "LoongArch: KVM: Invalidate
guest steal time address on vCPU reset".

Huacai

>
> HTH!
>
> Cheers,
> Miguel

