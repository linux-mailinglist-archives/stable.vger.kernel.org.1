Return-Path: <stable+bounces-188282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6FBF4559
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 03:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43843465C97
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 01:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B5927381C;
	Tue, 21 Oct 2025 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9GG6EOK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76351264A86
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 01:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011838; cv=none; b=SHdjJgYYrAOzU9HKBh93OH28v/WJU5xsiH56INvmO0qRD3Dek8ENsodJN0K2NqKgPPcjpFRNTRtX5GuePolmYj4c5fvWaxbWaF8q2KOjOqehcbS3f/mwYz+4TAjpjq7bh0wWnyByTUCZQmrc25BQHDrzlLXg8Xb4D/qf2SDUCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011838; c=relaxed/simple;
	bh=qvgDIRLoCo1oWWbngx/kRkqNJeW/9MNb6IK1qpsX25k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaTXuYJOETe6rP07KnVe2cu93uITbcQkTumf2+Du+6JL9Oiz+jCuPuE0+RNr2lZum33wLpT22v/j7lh4TTMJfnD8sD4xWmNrVc97EpixdlekLsJEyQZglIsW4+n3VW1fLaxmP+mlcr3zFkNHtE2CqrHjbOS4Hx24f5oTvDAy/G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9GG6EOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D34DC19422
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 01:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761011838;
	bh=qvgDIRLoCo1oWWbngx/kRkqNJeW/9MNb6IK1qpsX25k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d9GG6EOKaKRiO61CY+6wnhsKYUljF4jkVfcJytWsZudhY7cxEL9ic63cGR6CKIz2P
	 RDHlvCt9qmiifOrRFeL+dVwCvBUiIgzNFP2zFZY3Y7Isw+PAuRgIviZuQTd06IRpCQ
	 G5LlZ+bsnZZMgdqlWu0MeP2pNAijtK14apUBgTcwZg5QuIu4EkergiSjpCh/wJyvAe
	 ehjgKz8IgK7+RBSRfWr27YpofKXVi3EuRsjNxYhNOgtkn+m9ybhdl6Uk6DKylXWIqi
	 Xn4dH45TEpuiNTb2JKzseqo4dHTyGN9E5teM/KL5eKb4bh6LknsQDjoVTGpB89cAnT
	 8r+MNAHwcTW5A==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso8445285a12.0
        for <stable@vger.kernel.org>; Mon, 20 Oct 2025 18:57:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWytenVeQtAOyoTssuQ61MnAEkWzveuvpfEXPJvkDCtrNJAZ1txXVYXGP2nZ52IMBSVeftqZ00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNntzju7b/gSmraWcIKv1NW6N6phDuRAlEDRYuBJQDuIwVPjPo
	XbvvL2/YrwylBhXsPhrLbqmnYKSlJDzmWZcT7HTZ6pCRrSrIMh6Scof9ak92eL1pMvj8BP8I+R6
	FrehUPwFMaLsHh7QVqJ59ib8BL1FU1EY=
X-Google-Smtp-Source: AGHT+IGnHnnOxmt/4yjnjQ8qGLAcIVukTyZe98TJLT6uSG/VZp2nZ7yoAZdsj4kIYRZocpP5dBZI5WdC2pPOdgh+b20=
X-Received: by 2002:a05:6402:13d3:b0:634:b4cb:c892 with SMTP id
 4fb4d7f45d1cf-63c1f6f5e21mr15024301a12.32.1761011836686; Mon, 20 Oct 2025
 18:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172c928c-8f55-410b-a5f9-1e13c57e7908@hauke-m.de>
In-Reply-To: <172c928c-8f55-410b-a5f9-1e13c57e7908@hauke-m.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 21 Oct 2025 10:57:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9WTwUTOzdoaAqeWUETJZbSC+u_cji3Hg+ZXqudu5SbYA@mail.gmail.com>
X-Gm-Features: AS18NWADeZjoawJ2_xcC1mF6L7uGKWUUjXBlnL5eIvcBR0Npo4sers3sEow3sa0
Message-ID: <CAKYAXd9WTwUTOzdoaAqeWUETJZbSC+u_cji3Hg+ZXqudu5SbYA@mail.gmail.com>
Subject: Re: ksmbd: add max ip connections parameter: backport problem 6.6
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Steve French <stfrench@microsoft.com>, stable@vger.kernel.org, 
	linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:48=E2=80=AFAM Hauke Mehrtens <hauke@hauke-m.de> w=
rote:
>
> Hi,
Hi Hauke,
>
> I think the backport of "ksmbd: add max ip connections parameter" to
> kernel 6.6 breaks the ksmbd ABI.
>
> See here:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?=
h=3Dlinux-6.6.y&id=3Dbc718d0bd87e372f7786c0239e340f3577ac94fa
>
> The "struct ksmbd_startup_request" is part of the ABI.
> The user space tool expects there the additional attribute:
>         __s8    bind_interfaces_only;
> See:
> https://github.com/cifsd-team/ksmbd-tools/commit/3b7d4b4c02ddeb81ed3e68b6=
23ac1b62bfe57a43
>
> Which was added in b2d99376c5d6 "ksmbd: browse interfaces list on
> FSCTL_QUERY_INTERFACE_INFO IOCTL".
Okay, I will make a backport patch for 6.1 and 6.6 stable kernels.

Thanks for your report:)
>
> Hauke

