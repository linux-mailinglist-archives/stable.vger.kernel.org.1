Return-Path: <stable+bounces-213136-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FN6IUw/gWl6FAMAu9opvQ
	(envelope-from <stable+bounces-213136-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:20:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAA6D2E4E
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 01:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3EF30416E6
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 00:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1393C19992C;
	Tue,  3 Feb 2026 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZABljukX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A133EBF20;
	Tue,  3 Feb 2026 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770077959; cv=none; b=B3MM2AhzhxHLIY79v0ot3UhMG61P8MkDvUiol7OuGB0D0DqWydausRue0ZD/0Iy0spt8ALAywcTA+WQEnXQbSrtB33DpgID14QUro8zJxtB6CYkyHULp+vBmhkJ3yqCtoaShrvFwjSFXeUaZQSHstclaWXaQUeHsw3MXkAEjWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770077959; c=relaxed/simple;
	bh=YMNgpnEGjm+gg7Nz6teuJsSe1HjgDqcT2PQKZKmPfyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qK+n6O93Xt/DOwFCrvvZyyNyX0OAlBJ67m1OXvFTG3FPkxrVtCig4cHSO9nsKzztk3KI14lj2Yp2svVSshwqPXarFVfUI4der8HxJ2dLoce7ZjUz8HgZPLAP3EHyRc8y9xAt/YqqU7qp9YX2fCf8TSw8dk1LP/3S002KD2K6JG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZABljukX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F787C19421;
	Tue,  3 Feb 2026 00:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770077959;
	bh=YMNgpnEGjm+gg7Nz6teuJsSe1HjgDqcT2PQKZKmPfyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZABljukXIonFYNzVstgw96MQtBL1Ly/75a8BPgmqX3JA7Yw1sl/5FGwJygkia39Zp
	 nEsS0gkqlZXnLryeXps8HqV/KEGhI7+BnmOcG2aQpH2/6m8RnAYrhIa+Tj0WzKLe9v
	 lFrtSkqhnllbj8RyWL6WmbJBPPWuxq08YvYJgWWcdlxmv6q71Qwvq3zXQJzJcpCzex
	 G/JgrwFPl35pYyghUrlcLqDUXW87Bq5uEuZpZiL0fB60AO0JVtQrYGgeFgMQC33KoL
	 bqFQ92ZRFyWf5Cpj+/8ru9xClDjjLqxjfyLYis4h9wMZDIiqdmbOFtmpSpQnbJn9n4
	 R3cAcY2Isum2A==
Date: Mon, 2 Feb 2026 16:19:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 linux-omap@vger.kernel.org
Subject: Re: [PATCH net v4] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Message-ID: <20260202161918.54be9315@kernel.org>
In-Reply-To: <aX6pHiB0tk6xvrCX@pek-khao-d3>
References: <20260130-bbb-v4-1-2bd000a15c34@gmail.com>
	<20260131124120.744bd931@kernel.org>
	<aX6pHiB0tk6xvrCX@pek-khao-d3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213136-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DEAA6D2E4E
X-Rspamd-Action: no action

On Sun, 1 Feb 2026 09:15:10 +0800 Kevin Hao wrote:
> > > -		unregister_netdev(cpsw->slaves[i].ndev);
> > > +		priv =3D netdev_priv(ndev);
> > > +		disable_work_sync(&priv->rx_mode_work);
> > > +		unregister_netdev(ndev); =20
> >=20
> > I understand that this is safe but I think that more logical ordering
> > would be to shut things down _after_ object is unregistered. =20
>=20
> I'm a bit confused=E2=80=94are you suggesting that we move disable_work_s=
ync() after
> unregister_netdev()? If that's the case, the scheduled cpsw_ndo_set_rx_mo=
de_work()
> could potentially run after the network device has been unregistered, lea=
ding to
> a use-after-free issue. Or am I misunderstanding something here?

Unregistered device is not freed yet. The netdev is only freed after
.remove routine returns. Passing unregistered netdev to netif_running()
is safe and will return false.

