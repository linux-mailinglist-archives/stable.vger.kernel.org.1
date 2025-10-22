Return-Path: <stable+bounces-189043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5509BFE807
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 01:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6779C355BAF
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 23:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A78030ACF9;
	Wed, 22 Oct 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWnmU19m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D55307AFC
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 23:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761174827; cv=none; b=kLttTlmHxI3hFROtcQmOz360ehA+vzBHeENgJWkFoSgJujccvUZSsvmuUNEoRU1zYvQ7OwFqJNxPugfsrVWZY7drKgqSKtY4VUjocn7D2u7FCkGRSB3SKcgiBwj9yikF6JFWWY83CBiE51PNZtBBWN8u8wdQAM+tMidTfcx3ZVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761174827; c=relaxed/simple;
	bh=TGQodGtXgknIsWY7/3w2xJfTuc724moitZcuwddpmY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCB37BPHGkR16TcZE0538J5qtRQVZuoffEN3FNvxVEJov6ZDb+LCUA/3TulOxhBG2P+wr+WLlP7Z2LFcVlK0xT/DeNUItq10IZqmv/Bq6FsfNYeKQm1j1qOsHwAVGWDTGAiE5gfrUgMeSQq5GB9Cw8WicIYx15IFNw62kPfXH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWnmU19m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBA7C4AF0C
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 23:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761174827;
	bh=TGQodGtXgknIsWY7/3w2xJfTuc724moitZcuwddpmY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dWnmU19mOcQIiyBuF8JpGmdU3+wwiT2XOiniqiJR54sonlLROu40d6sFubKCNoTvr
	 FVNlaRE66w0aUBDH77G8JMCfeLN1KLMort8YxIs1A40tFOc2L+q7ciXDSgQB7YqEAe
	 8jgOg6isnFvZEROs4ilXe3TmoPT/sLcw5wboQmExEe/3A8K9AKXrZ7Q+Gwgzzj/6dY
	 amXto+DNg0sV4ke2fRtYe/TApAS2gQOyDHbqYykwwAPf8LqJSVjHE23i6b3dm5OO8r
	 Je5qIWBv5UfbrWwIBZV2nexSEy8gs2DKgnn0x/FlEcIg+rfBL6j0rgUr5+viKkYc2F
	 svj1niu9+Pq+w==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so229108a12.3
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 16:13:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXc7HgjomiD8diOmhzerMWH+16mRKVB+uNVYkDHG0cF5fC4cRsrfbNegp8ikR9b/qvjxT2RQ8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsIoORqjgk/QTSjAWEB9ogHaOPhPNS+bnB2ReEsGP3r+rw+MQ
	PmH/zdp6artD8wnJn3/dMDeMJtAqRD+8UwOqidElj8YtMGWB4uY0dpiIf17HMIyPKqNEXrBa0Xe
	08ixUUp8i5BNdScHunHH9bNdYUkIw7fE=
X-Google-Smtp-Source: AGHT+IHa5nyuANlWVI4EYphccWVc09Zo1B8uBJqUhFVxvUaS+9LYu1uwl3f9ymu6svhKRlY1hkMC5RHo/C+TtCFRprE=
X-Received: by 2002:a05:6402:2551:b0:63c:295a:d516 with SMTP id
 4fb4d7f45d1cf-63c295ad6f1mr23462978a12.27.1761174825930; Wed, 22 Oct 2025
 16:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025102125-petted-gristle-43a0@gregkh> <20251021145449.473932-1-pioooooooooip@gmail.com>
 <CAKYAXd-JFuBptqzEbgggUhaF2bEfWMRXCSK9N_spiBxvi1v0Wg@mail.gmail.com> <CAFgAp7g52dJDvJyEoV7Ms-YofG6a2=G=N16ARNrBOiCSkLVLTw@mail.gmail.com>
In-Reply-To: <CAFgAp7g52dJDvJyEoV7Ms-YofG6a2=G=N16ARNrBOiCSkLVLTw@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 23 Oct 2025 08:13:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-v9r0kKU9wO1ZZAtFju4H+OsG8RA3iYd15=eR6d5VEaQ@mail.gmail.com>
X-Gm-Features: AS18NWA9NqkARBQUm-jcxNp4I7v8U9iK-F28MdBbsUrCH4ZQBHXD6jTrQSJ5QII
Message-ID: <CAKYAXd-v9r0kKU9wO1ZZAtFju4H+OsG8RA3iYd15=eR6d5VEaQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: transport_ipc: validate payload size before
 reading handle
To: =?UTF-8?B?44GP44GV44GC44GV?= <pioooooooooip@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 7:45=E2=80=AFPM =E3=81=8F=E3=81=95=E3=81=82=E3=81=
=95 <pioooooooooip@gmail.com> wrote:
>
> Hi Namjae, Steve,
Hi,
>
> Thanks for updating the patch. I=E2=80=99ve reviewed the changes and they=
 look good to me.
Okay.
>
> Minor impact note: this patch prevents a 4-byte out-of-bounds read in ksm=
bd=E2=80=99s handle_response() when the declared Generic Netlink payload si=
ze is < 4.
> If a remote client can influence ksmbd.mountd to emit a truncated payload=
, this could be remotely triggerable (info-leak/DoS potential).
I don't understand how this is possible. Could you please explain it
to me via private email?
> If you consider this security-impacting, I=E2=80=99m happy to request a C=
VE via the kernel.org CNA.
>
> Thanks!!
> Qianchang Zhao

