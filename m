Return-Path: <stable+bounces-210008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7A5D2EA5E
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E04E30341A1
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5A734D396;
	Fri, 16 Jan 2026 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwW+mmyc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854E534B187
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768555235; cv=none; b=C9PouT5LOMJrJtp4UlsAghSdewbM6Jb/3CfnYkMtNJoChbQUw9Sh6CLHSdYeS7iILSU5qQqzZM8jv+5u7itEqfGq8QMobWZfRY1IACnMWTmhzRH2YjmZ7mGBSTrqfkNxnP44yYq29P1O3ByRu7wOi/mqB+hIXnt4poejWDkyaA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768555235; c=relaxed/simple;
	bh=ykRh+caslnsL7rs3PRC0EI48axBYUPyRgjOFudUhuYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7hSr2Cd5oLUBufB5ylJ1DZQwl70dU89i2R7GVsaUqX+TeTPpivva89gJwc/xbO3xB5KRh6rH19/znNOCLYY1wD+FEbkpWspv7/DKtOv+YCEWKybRd/JarDawUEt+9QiTqiy+etbsZsYeemBg5FIC3mkLo8F38nGeowza3h/Ud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwW+mmyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35178C116C6
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 09:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768555235;
	bh=ykRh+caslnsL7rs3PRC0EI48axBYUPyRgjOFudUhuYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pwW+mmycTpxJZI9IEqLurTYErdQ4YW6yt0VzoNAH6d6bFEJSGsltF8G8qrai/CC5r
	 0Q9kSssclk25DUgTSyUvM+PSVHdw9aFNTd2hrMpUw3f2gnbtdOXUamB4Bb0PbL9DH9
	 YVYzxJytEkYdHKyIvvxYPrFkJMHA+ejyCM8JkkrG0QXGZbaRuBJ46XqbDXa9oqH4cI
	 D5wzdJCjXgkkxHlWMsofNYdoHkXcu9DK9tk4k/tg1j1mGHthcLoCpufRgTCgvDvF9p
	 Wv+3/EKfbvq2ILdAt8KxBuaB2CQGW1Ualu2PJOChld7ZhxxdPZ5JlpuuLH24jlxiab
	 I8i0lFM1fktrw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b79f700a1so1730782e87.0
        for <stable@vger.kernel.org>; Fri, 16 Jan 2026 01:20:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXM6SlyicayZ6BjiUc2Ps3q3lo3bzfBvCDSLLzm6dP7p/brUhF0cDJFxRZtkQlwzgWwTTbZKQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6EQ2LKAGkQKPnnylCzQZ6o16eW7u16YrFJ/p63r2iBnDAwLKb
	LOLpt5PIBgBI/vLWt4obj2JafJUWhuezH2f2g/CkGLr/7Z7BZmnKRhCclkeaMNAzinuOJ69rc3l
	JKcxMs30t6bvG7DNSsVNcuwjiaUkHUXcpghxkWsrmlw==
X-Received: by 2002:a05:6512:2c91:b0:59b:9ac4:2afe with SMTP id
 2adb3069b0e04-59ba718ebacmr1882399e87.12.1768555233917; Fri, 16 Jan 2026
 01:20:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107033924.3707495-1-quic_shuaz@quicinc.com>
 <CAMRc=Mce4KU_zWzbmM=gNzHi4XOGQWdA_MTPBRt15GfnSX5Crg@mail.gmail.com> <212ec89d-0acd-4759-a793-3f25a5fbe778@oss.qualcomm.com>
In-Reply-To: <212ec89d-0acd-4759-a793-3f25a5fbe778@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 16 Jan 2026 10:20:21 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdoUvcMrMga6nNYt8d-o8P-r3M_xY_JHznP3ffmZv8vkQ@mail.gmail.com>
X-Gm-Features: AZwV_QimTjzwHL8e3FnSCZ-a4okZnUriTz72sgP41cuJac4rqIKVV5VOYmjNOT8
Message-ID: <CAMRc=MdoUvcMrMga6nNYt8d-o8P-r3M_xY_JHznP3ffmZv8vkQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix SSR unable to wake up bug
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Shuai Zhang <quic_shuaz@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 9:37=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> Hi Bartosz
>
> On 11/7/2025 11:37 PM, Bartosz Golaszewski wrote:
> > On Fri, 7 Nov 2025 04:39:22 +0100, Shuai Zhang <quic_shuaz@quicinc.com>=
 said:
> >> This patch series fixes delayed hw_error handling during SSR.
> >>
> >> Patch 1 adds a wakeup to ensure hw_error is processed promptly after c=
oredump collection.
> >> Patch 2 corrects the timeout unit from jiffies to ms.
> >>
> >> Changes v3:
> >> - patch2 add Fixes tag
> >> - Link to v2
> >>    https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@qui=
cinc.com/
> >>
> >> Changes v2:
> >> - Split timeout conversion into a separate patch.
> >> - Clarified commit messages and added test case description.
> >> - Link to v1
> >>    https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@qui=
cinc.com/
> >>
> >> Shuai Zhang (2):
> >>    Bluetooth: qca: Fix delayed hw_error handling due to missing wakeup
> >>      during SSR
> >>    Bluetooth: hci_qca: Convert timeout from jiffies to ms
> >>
> >>   drivers/bluetooth/hci_qca.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> --
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
>   Just a gentle ping. This patch series has been Acked but I haven=E2=80=
=99t
> seen it picked up by linux-next.
>
> Do you need anything else from me?

I don't pick up bluetooth patches, Luiz or Marcel do.

Thanks,
Bartosz

