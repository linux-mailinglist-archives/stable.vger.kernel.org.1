Return-Path: <stable+bounces-197688-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 326ACC95854
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 02:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F236E4E0699
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 01:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35547128816;
	Mon,  1 Dec 2025 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sPEY81Z0"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8616978F4A
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 01:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764553447; cv=none; b=bQ0TU5bHNMXhOmSvtVOqROgPn8R6lIXrCHEV/iqou86IoD8f/WXbvFfsXHOhSfOHuczzsBD6Rut5UkPDROl21zIi4oNPoaTuUJleIpnMZ74OaiU1jNwhV240niLI2JyJv6QkH7F5WIDEkRq8zOpDRKcFDai0wn4ZyaBVD/p4vtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764553447; c=relaxed/simple;
	bh=/xEfN0cZ+82hnwDaNggXw9KbBdy+L2BxUwvF5w+g+RA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=CKlf1zf/osMMlyAegWzbjPlwbO3CUl8IR7IT+zbnHwpZO+kxjxUMvxgaC5lEhp5e6sflX60xYNGbGnhibAceMsL6NgjuftU9AjDJ/zcvZ6R24Qj66nFbm92C4xhbpQZPoJgV4lxEhk6xQtB0Ubj4/kZYYXm74waIilEZz81dM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sPEY81Z0; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764553432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Tw3xs9+7Hum9VxvJMhc9sLUTW+X+dAChyuStSEAZLk=;
	b=sPEY81Z0LBXd2n/RaeWgNNOxmI0Jbh5zxHdDM6/0BOcfEHj7cBAgRvP/ohd1gUgO67v6DM
	mkS+y6s0Qyw7twQ22nCOg+EeQep3KkpuzID/6JyLOMBQ8NCT9KpfJ6HG2fA0/oasb6mLsz
	N9S6moICCxW8EgqJBwEVQO5h+avk3iw=
Date: Mon, 01 Dec 2025 01:43:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <044675704c377d9100c60e2ee30cb66790c0916f@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 6.1.y v1 2/2] net,mptcp: fix proto fallback detection
 with BPF
To: "Matthieu Baerts" <matttbe@kernel.org>, stable@vger.kernel.org,
 mptcp@lists.linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org
Cc: "Jakub Sitnicki" <jakub@cloudflare.com>
In-Reply-To: <f24fccc6-9491-474f-a907-0ea53fbdc5ec@kernel.org>
References: <20251130032303.324510-1-jiayuan.chen@linux.dev>
 <20251130032303.324510-3-jiayuan.chen@linux.dev>
 <f24fccc6-9491-474f-a907-0ea53fbdc5ec@kernel.org>
X-Migadu-Flow: FLOW_OUT

2025/12/1 24:21, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@ker=
nel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote=
:


>=20
>=20Hi Jiayuan,
>=20
>=20On 30/11/2025 04:23, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> The sockmap feature allows bpf syscall from userspace, or based
> >  on bpf sockops, replacing the sk_prot of sockets during protocol sta=
ck
> >  processing with sockmap's custom read/write interfaces.
> >=20
>=20(...)
>=20
>=20>=20
>=20> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >  index 1dbc62537259..13e3510e6c8f 100644
> >  --- a/net/mptcp/protocol.c
> >  +++ b/net/mptcp/protocol.c
> >  @@ -79,8 +79,9 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *=
msk)
> >  static bool mptcp_is_tcpsk(struct sock *sk)
> >  {
> >  struct socket *sock =3D sk->sk_socket;
> >  + unsigned short family =3D READ_ONCE(sk->sk_family);
> >=20=20
>=20>  - if (unlikely(sk->sk_prot =3D=3D &tcp_prot)) {
> >  + if (unlikely(family =3D=3D AF_INET)) {
> >  /* we are being invoked after mptcp_accept() has
> >  * accepted a non-mp-capable flow: sk is a tcp_sk,
> >  * not an mptcp one.
> >  @@ -91,7 +92,7 @@ static bool mptcp_is_tcpsk(struct sock *sk)
> >  sock->ops =3D &inet_stream_ops;
> >  return true;
> >  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> >  - } else if (unlikely(sk->sk_prot =3D=3D &tcpv6_prot)) {
> >  + } else if (unlikely(family =3D=3D AF_INET6)) {
> >=20
>=20These modifications here break MPTCP: this function (mptcp_is_tcpsk) =
is
> there to check if the socket is a "plain" TCP one (return "true") or an
> MPTCP one (return "false"). If it is not an MPTCP one, the sock ops is
> modified.
>=20
>=20Here, you are saying: any IPv4 or IPv6 socket is a "plain" TCP one,
> never an MPTCP socket then.
>=20
>=20I suggest adding ...
>=20
>=20 if (sk->sk_protocol =3D=3D IPPROTO_MPTCP)
>  return false;
>=20
>=20... at the beginning of this function. I'm planning to send a patch
> later on including this check. Once it is sent, do you mind checking it
> with sockmap if you have the setup available, please?

Yes, of course. I can test it once I receive the patch.

> Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>

