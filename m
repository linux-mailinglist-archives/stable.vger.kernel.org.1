Return-Path: <stable+bounces-126591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C70A7A707BD
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 18:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D07A52AD
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443BD25FA27;
	Tue, 25 Mar 2025 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ercp4n63"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B442E339B
	for <stable@vger.kernel.org>; Tue, 25 Mar 2025 17:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742922522; cv=none; b=sXWAV5uQSsXth2ikdDhefjFDrQs787yiKQ6YcIabyhiaxz9HotzvB1ioiaCYC8xdfa+Z6HcRzVknNnjrOqnYUUg5qNDw+PjF9SCbq5NZjrwmZedseBNa/bi45mi32PB99ifD1JvVKZTjFYj+nkzwaLf3LfzPIDCjZ/EKWzgy9yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742922522; c=relaxed/simple;
	bh=cbFmzm+2OrbXVtRx4gt1gAeuAB+ibGjA5byGKoxpE7c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=WejF/BQrhImoWSXztjPqO1xcm3DmkczDMi7iDRHQXtLgOWgD1zXfRLxCj6XFCQs+8g1edJXzEC5BLtxN3xQ3ntBbYItDQrx+Gw9vAiigOz1N5FHsQV8AAQQI0w3tbgW9fegkiqOZe8mLuzarA6NgDKSrB6fT1eRyE0JOBaG1y6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ercp4n63; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ab85402c9so236766f8f.2
        for <stable@vger.kernel.org>; Tue, 25 Mar 2025 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1742922518; x=1743527318; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWc3lERK8x5oB4BFSb37YbyfunqsGk6BA1tSYrjGs9I=;
        b=ercp4n63lhRm2+iti3kjPA+FqKSOWweuII0zeMS5QVwwBZMD7DpetNdi08WRVz7d/W
         2k9GZo96B3KRNwMPLf4Kjl/LrCyfaBTNN36YTQMDpPEpFDIW9ofUi2/IBeeNat0EbZPB
         8uE6IrV8GJQLG+d+SeBSerJhFMOl+JFDuzobY7UnyUw1j5NCFqF3Ow4mFnA6Lv6P6nxY
         pNC2wwuIbLc09767FfM/XcKPtL9cMl7tKxd5ak4Whk/KRSGGrgS+7G95vVkHjuW8KkGI
         IJvBQijjekzGfi0t3WGryYiibNSHkzhSFtmuOGVgro3SFU/YaRfxT9oVZbRwjGTQ3+NN
         353Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742922518; x=1743527318;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DWc3lERK8x5oB4BFSb37YbyfunqsGk6BA1tSYrjGs9I=;
        b=tvns1lTjuVDn10w2Egutc8kkTX5ZjfMPgyXUP6PAQWd+/Vmc0rwaHMqMdGuAL7cov4
         igYa6u3f/Ecd/hvM2yN6LH4PX7m9HLku75DzoJ4DJvECjv6kstKq9eV6O02zde6MUs7a
         Wq9zxs70xm57ntbc+ZOqaPjxI2y6Q7Aj7lCjHup1O23k6OL28963mpfObbWiKbQ0sIp4
         y5FnPXmb7rs4CFFfPKSmGwD/4IYfVYxIATHO3La92S4ZMQZV9Og99LlyGiQlHc4wFpu0
         d9bk2stQFch0fXf4HECdbUOOr30sIqwix77OBPXY+ZGy3FL/Q/xKK7AiugSLgf2mJFfF
         mExA==
X-Forwarded-Encrypted: i=1; AJvYcCVKiUhPYNWfmbWR4ndMcvyluu1UR+X3ZbFXzPJDIOY1e7YBnhTevosaPtRCDqT9tr3oaU16KT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxftwWaLdyfZhS8UuJ61OUbdym0QWSszo63mEn0O+oK1T8/jDpX
	o+FQAsbhs7B4gBCt8/iQ8R7zQLOfJ54Fo3pPnqYiCWtbOcoC6eyjWDZX2lLImautNo0M47DwnaC
	U
X-Gm-Gg: ASbGncuNF9/rfRw66zlli78IuZ1ekPRmRlKadNgmosJ/y5rJJ7W6wwPh0b1ag8V7hn4
	vSNWSF/xsd6oP7E8fAnMT/C3mGAqMs9yiH5i0/isDm1f+SyhpXDDFKrbaMPipx57jSXC+lbSoMO
	sVUBHwDkkbKxwrR7etCrW6nNXFqIX7tUYJFPcLG4H5v4I/IqKQQeR3jQYrF6U4ydXb5KD4dW1af
	t37vgkZcAwmTrK37yYNqRkhzaunawO6rcWeG6LHvnpQ/eF7nZr7YXzjM5SkozJ3irH+OvBevKiT
	gbhuU45qiYAnqW9H1bLdjaPdbGCz/4Y9QXCWh8LiiJ7oX70rh+89
X-Google-Smtp-Source: AGHT+IEXGxAFFcjjSGkBgGP/l6W8ujAzLnKetpMQQsy2kHqIf5tqu6BrFMeMIZUyW9LZ9pOUTnjPGg==
X-Received: by 2002:a5d:47a5:0:b0:391:3110:dff5 with SMTP id ffacd0b85a97d-3997f903a65mr6037407f8f.5.1742922518387;
        Tue, 25 Mar 2025 10:08:38 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:f097:1b00:1a61:887a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e6539sm14301338f8f.77.2025.03.25.10.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 10:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Mar 2025 18:08:37 +0100
Message-Id: <D8PIGUPV6622.4Z9G0C5FRLRK@ventanamicro.com>
Subject: Re: [PATCH] KVM: RISC-V: reset smstateen CSRs
Cc: <ventana-sw-patches@ventanamicro.com>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Andrew Jones" <ajones@ventanamicro.com>,
 <stable@vger.kernel.org>
To: "Anup Patel" <apatel@ventanamicro.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250324182626.540964-5-rkrcmar@ventanamicro.com>
 <CAK9=C2WFQxKYnKeteeS94CqfwWkOgMWG69y5WWiun8129z6wsg@mail.gmail.com>
 <CAK9=C2V90_GX6u_M2hOh62J1xxVx-ioenSqz316BNWPt3Lr0dw@mail.gmail.com>
In-Reply-To: <CAK9=C2V90_GX6u_M2hOh62J1xxVx-ioenSqz316BNWPt3Lr0dw@mail.gmail.com>

2025-03-25T22:27:41+05:30, Anup Patel <apatel@ventanamicro.com>:
> On Tue, Mar 25, 2025 at 8:58=E2=80=AFPM Anup Patel <apatel@ventanamicro.c=
om> wrote:
>>
>> On Tue, Mar 25, 2025 at 12:01=E2=80=AFAM Radim Kr=C4=8Dm=C3=A1=C5=99 <rk=
rcmar@ventanamicro.com> wrote:
>> >
>> > Hi, I'm sending this early to ventana-sw as we hit the issue in today'=
s
>> > slack discussion.  I only compile-tested it so far and it will take me=
 a
>> > while to trigger a bug and verify the solution.
>> >
>> > ---8<--
>> > The smstateen CSRs control which stateful features are enabled in
>> > VU-mode.  SU-mode must properly context switch the state of all enable=
d
>> > features.
>> >
>> > Reset the smstateen CSRs, because SU-mode might not know that it must
>> > context switch the state.  Reset unconditionally as it is shorter and
>> > safer, and not that much slower.
>> >
>> > Fixes: 81f0f314fec9 ("RISCV: KVM: Add sstateen0 context save/restore")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>
>>
>> How about moving "struct kvm_vcpu_smstateen_csr smstateen" from
>> "struct kvm_vcpu_arch" to "struct kvm_vcpu_csr". This way we will not
>> need an extra "struct kvm_vcpu_smstateen_csr reset_smstateen_csr"
>> in "struct kvm_vcpu_csr".

It is tricky, because kvm_riscv_vcpu_general_set_csr calculates the
amount of registers accessible to userspace based the on size of
kvm_vcpu_csr.

We'd have to make changes to logic before expanding kvm_vcpu_csr with
kvm_vcpu_smstateen_csr.  At that point, I think it be much easier to
just put all csrs to kvm_vcpu_csr directly, which would also simplify
future extensions.

> Other than my comment, this looks good for upstreaming.

I think the current version is more appropriate for stable, and we can
implement your suggestion afterwards.

Thanks.

