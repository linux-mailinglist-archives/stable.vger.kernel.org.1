Return-Path: <stable+bounces-105572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53749FACD7
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 10:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073211882F29
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 09:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DC0199920;
	Mon, 23 Dec 2024 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlPIQ+D0"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432F199FBB
	for <stable@vger.kernel.org>; Mon, 23 Dec 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947219; cv=none; b=j38hiXkKD4eKxzJBfxSCkl+z8LJBUzj0qocGYziFFFp21GA16GjYTySP4FqKOUlMOGTDQ2UzAF/qmKP20JvEhOURE93X+bs7eKIEHp02niLFOP9+inCftPpJqoq4rfDlKDPy5LmTQAbwEZtG/tIDlnDh8QNdS0z+JYO5MGciQeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947219; c=relaxed/simple;
	bh=mu4qagGJN6FxX6LV8CsL3UN+YeIhrQ3BOxn2WE6b2Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/pyixdkCoNSeevhTWhPT9U5JSPpkFSevFonCQcroR3amzj2Cq5yNwIlGnwrsb/WO3iuhm0Fbucy2Hh+a6a2rvMGUjGZNg591tcQzpxFVrD/uusHnXgQRlsqfX+01p/K2KVub0veUp/7Eq3N6Ab1txlFXpa8sy/pfPrig42U6TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlPIQ+D0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so6327263a12.1
        for <stable@vger.kernel.org>; Mon, 23 Dec 2024 01:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734947214; x=1735552014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu4qagGJN6FxX6LV8CsL3UN+YeIhrQ3BOxn2WE6b2Ps=;
        b=wlPIQ+D0y8yd6boNIbkKkvxdpw0gLadrUD0l8zhqGDVdc/z5Vj8cvd5JDIo7sWGdPA
         5j9AzOkwg8Ydg3tWgpnbP3l1kpmscUE9z0+igrRT79FZuXDuNzb+aa2E8TMoIDJyBnrs
         6E2X8rQrNzDSpA6Dv021/QSllnKpw+O+/XQoNgopJ7Ahr5f+sSkdDE6ntES/ZfY4g/Tu
         dsDVPohAbFghalvlWNE9OJ7M1U+NzbDroDSNT3HiVnEHdLDXX1+7wNhEcQG4iPt3dLF/
         sRrltdo/NkWbmLfnahUiDkD6jUjhMOAxmahfVwE5h/+PHbKgnqsBIzMfdOQeWo41zmOX
         jWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947214; x=1735552014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mu4qagGJN6FxX6LV8CsL3UN+YeIhrQ3BOxn2WE6b2Ps=;
        b=j6CC1tyZvGLCk9wIWksZF2us0Upq25GTtF/QXUprRMRz0lCiePnPF1itBOOTPwlsDX
         zb2tdHe2MF8Z7dhsH2dCrhqlhOwPwjnzUyL/35kxnlpfW/T+Me8gYKDDLgOZx+EMiJau
         DVGIGNgCyMWf6OUbIzk5gFRxc70ZcJg6De1Lji4cGim24OcLUwiSTXqMyfNpWPK1s+1b
         A/bCQZ8pgJvQgN3tZ40T9HStTeGQGC8eW953sDOZEQ6GJgxWqZFsrv6mIDD20OjeF/Py
         zcnKlC8oSnAOq92xCkdRstykKcVbLH8/us4XVpboAxoQrgHykAWZ0CJFmXmlhctUr7fq
         uGcw==
X-Forwarded-Encrypted: i=1; AJvYcCVFTJKvWMGTahZSm4rj279M9fJ2Xsya79RtAG3xtAnLm62sqYsdZBZBz35bzI4mNBgK91SjvgU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxkmmttb6VrXdaCgQgUqWhLQpPbiRWtuiQSuaBOY+UyoSN8gMs
	UOpuiEdKe/TLIul2I7BYbOR9oOete0y90Eb4WcfrnewDzrnNTOaxbCVYbglKSA+7jTh0upARy+7
	kImLAcleOsMHBtuJpd/OaqDywLbf+ixCbHe7ny4vUNpJcmwH4kFvp
X-Gm-Gg: ASbGnctQ3EiOUW3alBS5cF0FyqGmlx8W+kK5uifcEd8eaEMCTEVnCbbVBr2Qkhvs/Cj
	CoyYcwPWu5046rMpcNauENnjvnv6RknG0ymkVWJU=
X-Google-Smtp-Source: AGHT+IH3+egfWLTE78YKlmwPqtWef5YTuB2kERtTaCX1dCwBHcNtCa+1pJDYxvd4T1CwOvzn7Bqjqihb96SfUcymHm0=
X-Received: by 2002:a05:6402:270d:b0:5d0:bcdd:ffa8 with SMTP id
 4fb4d7f45d1cf-5d81dd83b92mr9613064a12.1.1734947214306; Mon, 23 Dec 2024
 01:46:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <025d9df8cde3c9a557befc47e9bc08fbbe3476e5.1734771049.git.pabeni@redhat.com>
 <047cb3ef-f0c0-43e4-82e9-dc0073c8b953@kernel.org>
In-Reply-To: <047cb3ef-f0c0-43e4-82e9-dc0073c8b953@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Dec 2024 10:46:43 +0100
Message-ID: <CANn89iKU8TwoiZHPwdEAy2w=RhmbDci3n6Wux=oM1YzrkfdzpQ@mail.gmail.com>
Subject: Re: [PATCH net] mptcp: fix TCP options overflow.
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	mptcp@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024 at 11:28=E2=80=AFAM Matthieu Baerts <matttbe@kernel.or=
g> wrote:
>
> Hi Paolo,
>
> On 21/12/2024 09:51, Paolo Abeni wrote:
> > Syzbot reported the following splat:
>
> (...)
>
> > Eric noted a probable shinfo->nr_frags corruption, which indeed
> > occurs.
> >
> > The root cause is a buggy MPTCP option len computation in some
> > circumstances: the ADD_ADDR option should be mutually exclusive
> > with DSS since the blamed commit.
> >
> > Still, mptcp_established_options_add_addr() tries to set the
> > relevant info in mptcp_out_options, if the remaining space is
> > large enough even when DSS is present.
> >
> > Since the ADD_ADDR infos and the DSS share the same union
> > fields, adding first corrupts the latter. In the worst-case
> > scenario, such corruption increases the DSS binary layout,
> > exceeding the computed length and possibly overwriting the
> > skb shared info.
> >
> > Address the issue by enforcing mutual exclusion in
> > mptcp_established_options_add_addr(), too.
>
> Thank you for the investigation and the fix, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> > Reported-by: syzbot+38a095a81f30d82884c1@syzkaller.appspotmail.com
>
> If you don't mind, can you please add these two tags when applying the
> patches to help to track the backports?
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/538
> Cc: stable@vger.kernel.org
>

Thanks for the fix !

Reviewed-by: Eric Dumazet <edumazet@google.com>

