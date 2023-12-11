Return-Path: <stable+bounces-5496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936D280CE33
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 15:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324DAB20E31
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5391B487A8;
	Mon, 11 Dec 2023 14:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd9GCuSv"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD94B2119
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:20:41 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-42589694492so36113601cf.1
        for <stable@vger.kernel.org>; Mon, 11 Dec 2023 06:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702304441; x=1702909241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3I6cPTRKEBckLzS6mTa93tZdFjE9SWaMkbdX9OqNe4=;
        b=Rd9GCuSvqWP4nBMQBM82sdb0Uf9aZwI/LJyDVCqrk3g1RmkaNsIUlQJ4Ao7Sm77YlI
         BH57xd3oyFwOAWQsJEwoSy9lRoXXnaHmtNlm18vfWT2YCrlPw0mx//nznVNePmQYUwOD
         AxcEOad6fd4cmuIZQUkWRx/xBJuVMyDXphrweIpZtN+dDunLzp1r66vjSWxe2auDBdfP
         8mVWWLnL6sWLLRXHnDUbXuzhTcW0ZKr7t66RRD5EZN9iOTL5e2rdWHqcZ/ZObMVs4M2B
         XTtjmqIOQdnWoiScQ9kkJQXiGxP4VJIshzWFOm6YfssCXtrCpBf12ifw+GCw9QJri4qF
         4KDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702304441; x=1702909241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3I6cPTRKEBckLzS6mTa93tZdFjE9SWaMkbdX9OqNe4=;
        b=Qg9syGh4EK4mQgE9h/nwUKbkRkLIuf0c5nufjRAEsdLEEV22Sx5rzhN/Pb1r4rLdXz
         zutN294tEgvslVTxqBLTlX+WU48JxwIXDgD5keT1KHBPw8jR6U1+NSsme/Ahij+rEuD/
         pQsTwpQvc0h9PdgA4Aa5o8px9gj7SFVkk9KaZlQBQofcKh10x/pRM6z5818Ic5Ozgqd2
         PRO9Fd5M8bTodoGmZEVI/02lQcL9/2CVbr+anXfjsruYebNasxDuigW8huvCpZCC8KUG
         m5seQINc4dp22mZg6kH1e4GhPj6b7MZvhcbcuKtrO2olpGfHGiywbveocb6LPFcgO/0i
         +BcQ==
X-Gm-Message-State: AOJu0YyhFubkbRCMnDU1Jqxc6E6loNtRRj4WzQy7VZ+sLc5kN23eCupD
	diU80iisVHlVEq+hgngrCHgemh1BVKZxTmES2zOOhJYcLpVjtw==
X-Google-Smtp-Source: AGHT+IFfehgEX1FxRZShfIaQW0njVcZGe3XlSwh8ahjC8fDC5CdrelT7t/hTaOnLXLIl1IYUwkns+o6F+YEdwPM76rk=
X-Received: by 2002:ad4:4a07:0:b0:67a:a721:d796 with SMTP id
 m7-20020ad44a07000000b0067aa721d796mr5323783qvz.124.1702304440776; Mon, 11
 Dec 2023 06:20:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACW2H-4FpZAizkp+U1aS94V_ODn8NUd1ta27BAz_zh0wo63_rQ@mail.gmail.com>
 <CAGxU2F6C8oUY4B38y17Ti9u9QdYqQKamM+S2nofjYe5b9L1tBQ@mail.gmail.com>
In-Reply-To: <CAGxU2F6C8oUY4B38y17Ti9u9QdYqQKamM+S2nofjYe5b9L1tBQ@mail.gmail.com>
From: Simon Kaegi <simon.kaegi@gmail.com>
Date: Mon, 11 Dec 2023 09:20:29 -0500
Message-ID: <CACW2H-7xr8-kDWJ9xqzx7c1Ud3QhqL2w+BGYpjOEdnkj9_Kzhg@mail.gmail.com>
Subject: Re: [REGRESSION] vsocket timeout with kata containers agent 3.2.0 and
 kernel 6.1.63
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "David S. Miller" <davem@davemloft.net>, 
	Sasha Levin <sashal@kernel.org>, jpiotrowski@linux.microsoft.com, 
	Michael Tsirkin <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Greg, Stefano,

tldr; withdrawing the regression -- rust-vmm vsock mistake
--

We're not strictly tied to the 6.1.x tree but generally stick with the
long term releases because we patch every week or so and want less to
change if possible.

I think you're exactly right re: rust-vmm's vsock. We're using cloud
hypervisor and just tried updating to a fixed version and everything
is working as expected.
https://github.com/rust-vmm/vm-virtio/issues/204 (thanks Stefano)

Thanks all... nothing to see.
- Simon

On Mon, Dec 11, 2023 at 3:39=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Mon, Dec 11, 2023 at 5:05=E2=80=AFAM Simon Kaegi <simon.kaegi@gmail.co=
m> wrote:
> >
> > #regzbot introduced v6.1.62..v6.1.63
> > #regzbot introduced: baddcc2c71572968cdaeee1c4ab3dc0ad90fa765
> >
> > We hit this regression when updating our guest vm kernel from 6.1.62 to
> > 6.1.63 -- bisecting, this problem was introduced
> > in baddcc2c71572968cdaeee1c4ab3dc0ad90fa765 -- virtio/vsock: replace
> > virtio_vsock_pkt with sk_buff --
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/?h=3Dv6.1.63&id=3Dbaddcc2c71572968cdaeee1c4ab3dc0ad90fa765
> >
> > We're getting a timeout when trying to connect to the vsocket in the
> > guest VM when launching a kata containers 3.2.0 agent. We haven't done
> > much more to understand the problem at this point.
>
> It looks like the same issue described here:
> https://github.com/rust-vmm/vm-virtio/issues/204
>
> In summary that patch also contains a performance improvement, because
> by switching to sk_buffs, we can use only one descriptor for the whole
> packet (header + payload), whereas before we used two for each packet.
> Some devices (e.g. rust-vmm's vsock) mistakenly always expect 2
> descriptors, but this is a violation of the VIRTIO specification.
>
> Which device are you using?
>
> Can you confirm that your device conforms to the specification?
>
> Stefano
>
> >
> > We can reproduce 100% of the time but don't currently have a simple
> > reproducer as the problem was found in our build service which uses
> > kata-containers (with cloud-hypervisor).
> >
> > We have not checked the mainline as we currently are tied to 6.1.x.
> >
> > -Simon
> >
>

