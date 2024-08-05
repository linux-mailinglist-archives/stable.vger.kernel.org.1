Return-Path: <stable+bounces-65364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A16947561
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 08:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 311771F217BF
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 06:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FEF1459EA;
	Mon,  5 Aug 2024 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqQEtJmF"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C64F1422D8;
	Mon,  5 Aug 2024 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839976; cv=none; b=bw7uMAletTFU2TkasBPDH5svjsYLG9YravhSbfoUzqOh1Lae2LueMDlEvnxKVpgKxpM/hOzyRKxWPJZnFZu2ybXdO9nApu1sxUFf3y5hZndoVHPJeY4s8C6+rxXIHsXTt7nwkm0SH1enx9s5s3+WhaCcWyjKAeE6+Sah6oiMqoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839976; c=relaxed/simple;
	bh=Hp+akOIA5r7pKUvBUtgBx9Zv5qT2Ir2O//4P0GbFEq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IF0XD8VcVR22PjkgN7PL/ZsB/1zlkmAx1YJ9ISpYk1f9jUJAFHaGjhmYgrqyzsVFJApBm6r3q5xi+zY5d3vExp2/UZqcBjen4AV0G2QM7lUksH+kZmCRZbvSVwB0B0mZ1VRypp18UIck8+OsI5sjL3pKnGk8yQFE4E0lOTmyOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqQEtJmF; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7a81bd549eso913771866b.3;
        Sun, 04 Aug 2024 23:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722839971; x=1723444771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hp+akOIA5r7pKUvBUtgBx9Zv5qT2Ir2O//4P0GbFEq0=;
        b=cqQEtJmFSRm5LnPbsKT/AIjlDm4j7R8prPb+u9N2nPYpgq9FAl3dHinXrjP/HPxj08
         LuZn20WHDCzyzNXSB4apJAhnvE9K9pNZIRvCflVEKSU5Dl13eW7ageQ1grX/Y0G4RmMc
         CAT/H1oywg8LYgW5h1T714Rj6s14N3/e2QakpGou1iG4mBf/mQRxEloEJvmXT18yx80h
         fZlXA2Yiu8UViqzbyNIGu9DUiCgxy0OcsHruBUeC7eylo1ZC3T3rq1ywgZskF9eHWZgV
         D+lP9auQov1yB3zdU1Zn4Hx2HQwwgon83Va9gwNb9fOwg9hmLJIgqiBBeThtvIHEIuil
         vEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722839971; x=1723444771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hp+akOIA5r7pKUvBUtgBx9Zv5qT2Ir2O//4P0GbFEq0=;
        b=fVZP6PTcKuRsASgkAgwIC8vnpQrUnxIhz4Wbk8A/YJlz9R6R/23Bq6QOF5jzYiEUR6
         +MVryJd4nqiDc1HlzLCXVkw2SCUa9275yl2/Nr4Fm3lLz9cfmNbj+3He48nQgdNHEfJT
         CcoGf3qwu9Yq3E4pBi2QafeKYlLvYCUGkMgwZn7/2UvsC5hChdyc8/fm6YdJM+dO75Y3
         9UohP12f7c99Dv+C85u3w/qfOZJ/wqq0//MM7S/Ha94apD8Yv/cjpvFfHVIiKOdDWrhq
         j97H2F/TVrWzPggRkPv+9j6T///nnbP2SV/FUp6YPlKnl5PCUSLKfcUyYLZnz0whOxwu
         wWFA==
X-Forwarded-Encrypted: i=1; AJvYcCW7N1K3P4E4quQ5LfR82addNMjchGpEYTLdEedkWoEw2HcNSwGRuhC0tvjx8bSldYo5wko6iS2tQKvqdJ8=@vger.kernel.org, AJvYcCWbODC2TUw0TE/3ilzxOvkThc1PNulgDq9wUo3/vHl1qGPq+wFoapbnmEMcdCGfZuMBaEDHWyFC@vger.kernel.org, AJvYcCXZutLzy3lRh5XXszuDWTri81OPqoaKuVghGyR/fsAvcy9YXaSG/X7qYdxnJANyZWSWEoD+SlTv@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUmdPaBKAEIUOgw6jA7VTs5jsNJ4wpWSK/2Q0jnjyQq6hDsii
	tO2DiT18i+IPVxx9AT5Ei+afgUUJb8H2qNVcfF0ko4KeLr8mKYb4GM/cUr+qAVWYtf5GoJ3ehcY
	XipI0uxwpd2sp89JU5qH7jYhiySw=
X-Google-Smtp-Source: AGHT+IHZKPc6hfq2+btXaQ5oS/nApElkaZfbe6yjBvGYeX2+PIMlwiIHY20xhepwtJAtoPF5hDV6P/eLwPk4IsLmXpU=
X-Received: by 2002:a17:907:60cd:b0:a7d:c46b:2241 with SMTP id
 a640c23a62f3a-a7dc4fae424mr899245066b.29.1722839970855; Sun, 04 Aug 2024
 23:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGRfhukVR4V9GFmdV71QfM2OLW3G=BQoOM1U1cK0ENFZvLTLyw@mail.gmail.com>
 <CACGkMEvpB0zP+okrst-_mAxKq2eVwpdxQ5WTA07FBzRrs3uGaA@mail.gmail.com>
In-Reply-To: <CACGkMEvpB0zP+okrst-_mAxKq2eVwpdxQ5WTA07FBzRrs3uGaA@mail.gmail.com>
From: Blake Sperling <breakingspell@gmail.com>
Date: Mon, 5 Aug 2024 01:38:54 -0500
Message-ID: <CAGRfhukK6CWpyViK-O67OCXu9=7SGnOwSg=Lv91jum8dF-RKKg@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH v2] net: missing check virtio
To: Jason Wang <jasowang@redhat.com>
Cc: arefev@swemel.ru, edumazet@google.com, eperezma@redhat.com, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, mst@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, stable@vger.kernel.org, 
	regressions@lists.linux.dev, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jason,

Willem's patch works, right on the mark. Confirmed the guest
performance is back to normal.

Thanks, and sorry for the noise!

On Mon, Aug 5, 2024 at 1:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Mon, Aug 5, 2024 at 2:10=E2=80=AFPM Blake Sperling <breakingspell@gmai=
l.com> wrote:
> >
> > Hello, I noticed a regression from v.6.6.43 to v6.6.44 caused by this c=
ommit.
> >
> > When using virtio NIC with a QEMU/KVM Windows guest, network traffic fr=
om the VM stalls in the outbound (upload) direction.This affects remote acc=
ess and file shares most noticeably, and the inbound (download) direction d=
oes not have the issue.
> >
> > iperf3 will show consistent results, 0 bytes/sec when initiating a test=
 within the guest to a server on LAN, and reverse will be full speed. Nothi=
ng out of the ordinary in host dmesg or guest Event Viewer while the behavi=
or is being displayed.
> >
> > Crucially, this only seems to affect Windows guests, Ubuntu guest with =
the same NIC configuration tests fine both directions.
> > I wonder if NetKVM guest drivers may be related, the current latest ver=
sion of the drivers (v248) did not make a difference, but it is several mon=
ths old.
> >
> > Let me know if there are any further tests or info I can provide, thank=
s!
>
> Does Willem's patch fix the issue?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D89add40066f9ed9abe5f7f886fe5789ff7e0c50e
>
> Thanks
>


--=20

-Blake Sperling

