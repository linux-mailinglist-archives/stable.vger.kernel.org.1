Return-Path: <stable+bounces-212735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IwxESL/emmnAQIAu9opvQ
	(envelope-from <stable+bounces-212735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:33:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0221AC3F2
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 07:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB9DE3019F0C
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 06:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDFA378815;
	Thu, 29 Jan 2026 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3TyB+L8"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BE2D640D
	for <stable@vger.kernel.org>; Thu, 29 Jan 2026 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769668377; cv=none; b=dyS+pvSgr0N7q0vLhuRMQKxQw0RoBAUcfU6iUYLj//M0fw2q4HWTjMdJ1odzj/dIblygxsQ32wXCGKaiTWFKhV7MQk9Ft9SDPOYX5fdivcqSyst6bq/MlYTNW/zoXZYR0w5LPMXFwXTZS56CsdUaF43FctKQsmsswPDHOeqSmeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769668377; c=relaxed/simple;
	bh=RsIslKyhpSjxmdr4itF3eXtAKvRSlKn0Fu9krmPg2aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyvQgL0FjdPyJIeIZRiE7xh0SLjbyOLZ82JXaZv5c6+zPMlqUboXHZ4sNsYntWKJ+MKn0sxZ95iBZNK8lS3g0Y4s/TptE9vrow+Wr9to977LEB77eAQtNP/qOcQcmcIjLFqR4QOBo8lFy65J5R8LfTSYtSuFOqC94UdMMf/FIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3TyB+L8; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5032e951106so5905801cf.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 22:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769668375; x=1770273175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RsIslKyhpSjxmdr4itF3eXtAKvRSlKn0Fu9krmPg2aE=;
        b=a3TyB+L8FFn8Z/vqcnQrlVoFRY60o9KUNvbChUMhrFZONlqNGrLL9Ey/l6b/s/e0KG
         XTG6nZBuDafUnZFaDn9yieLlLDrXDTXXH+XA/LOH+8zJhIadmfvDDJ71Ok07sj2Pf4Nj
         xIFb4Fo1WWN1Yga+IEvJdVJ9bXTtYtq0qGKrjUg1XYRL/8qQCHr0ftPVGgMVJ9tqf6II
         +27zo+O13cLZMZ4c3RDy50hbtoKMRynfP4MNx25zuIDu5hlz9aGWhowqzyU8tw8GJIWV
         hLvmdHi1Q12K01O/O6shMpBPFHdPRga99wX8yt/IqFP9DE0LG/RkGvsYeakkvaC4ybPV
         GlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769668375; x=1770273175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RsIslKyhpSjxmdr4itF3eXtAKvRSlKn0Fu9krmPg2aE=;
        b=dUSY4Y+BsQEmN2KZaAzRS9hEE40Hj7KqHLve40Q+dfn9u2U1HlGVK3t0bW+V6pXefE
         4tmIBNed1iGijqDqQB2GnL2dLbGf+tbb0UTxltPgVuv4pGLg6OrXOA9IBZlZ3YEpXQul
         Ry1Cx3EMiTZ2IxRAvrTR0DPnoii1A/notjrLRXmH35A9dit/WsEImRKYYNGgGGwBhgFF
         MSzUTZimacWhl2TsHOmufAeLJrlSPiKY/PDSHttJ73s60H0tDWz0xANLO6BnauVDhgUy
         T+8euzyzpZ562LGG35xkln7kp43AZweoj13cwYUHttBWqd9rlvfcstOgOKIFD0hDCKFM
         2EkA==
X-Forwarded-Encrypted: i=1; AJvYcCXj6zgMIh072i0yC+Mda5UaR8ecuptnKJ8RkmLaDQ/8DJvEfgrtOXgvmwVpUdHTPldWyiCaJrM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza8Fx2uSv9E37OKl3k/5gaPOgd25bhxkNNJw8XuFZ9yIV3YYLB
	1dmj/RaIVtQPXYeg9LbLoI7tG4biSqazN00amNDOFTgwRoHW46V3cLSq83hLBg==
X-Gm-Gg: AZuq6aJTDRZlhHmJKuD/TFFilkQXwK2RNkY4c4hPdOKwTpaI8d3E/fC1B/WoZJW41O8
	nOYBx5N9GULRK54khIWzD4OcKJct6UDG/KdIeC/OuTCAD5m5LXEo6su6evfJ3Dsoc2RhbCDh7+Q
	OtZyQkB1vQnj+q/p1NGiClUYeX66NaQpBgmeTH41q77XoR4U1QHQrRzi6bj3ORUSSppwc3jSPry
	DwkOsPQIjam2bsu+wra9loIi32KVhGwRXayph7C70dClIgGT4gENGWGHSLiyO7AggLJm5Jk0BeG
	1ldRn8CHEUPLB0EVskc9mh2TRGvQq4HrFlRlTMZxEiGXfZsHWcCVvvivgYKX5sAoOHxCgLGCrQy
	jLUVAg/j82Sllz9QmVxj3/7Hexqmg36VUTVrzYR2+r3gSf4ZTAxixYmEKO8Wp+j3NI371nAOK4f
	HXE+8pwZ6JQogCCwR+RQ==
X-Received: by 2002:ac8:5e14:0:b0:501:3df2:fd60 with SMTP id d75a77b69052e-5032f7704c8mr95104321cf.12.1769668374785;
        Wed, 28 Jan 2026 22:32:54 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033745c4f0sm35829361cf.1.2026.01.28.22.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 22:32:54 -0800 (PST)
Date: Thu, 29 Jan 2026 14:32:44 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH net v3] net: cpsw_new: Execute ndo_set_rx_mode callback
 in a work queue
Message-ID: <aXr_DNapxeHpuWt1@pek-khao-d3>
References: <20260127-bbb-v3-1-5e71f340c1e9@gmail.com>
 <20260127190836.6a420768@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UH1uIraS6vl8AKuT"
Content-Disposition: inline
In-Reply-To: <20260127190836.6a420768@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212735-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0221AC3F2
X-Rspamd-Action: no action


--UH1uIraS6vl8AKuT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 07:08:36PM -0800, Jakub Kicinski wrote:
> On Tue, 27 Jan 2026 16:02:07 +0800 Kevin Hao wrote:
> > To resolve this issue, we opt to execute the actual processing within
> > a work queue, following the approach used by the icssg-prueth driver.
>=20
> Code looks good now, but why are you creating a workqueue for this one
> work? Can't you use the system wq and just cancel it sync where you had
> the wq destroy?

This implementation was adapted from the icssg-prueth driver. After reviewi=
ng
the git history, I found no explicit rationale for using a dedicated workqu=
eue.
In my opinion, if we were to use the system wq and rely on cancel_work_sync=
()
before unregister_netdev(), a race condition could arise between these two =
calls.
Specifically, cpsw_ndo_set_rx_mode_work() might be scheduled during this in=
terval
and run after the net device is unregistered, leading to a use-after-free b=
ug.

While reviewing the code, I noticed that in the current implementation, we =
may
need to move the destroy_workqueue() call after unregister_netdev(). Otherw=
ise,
there is a risk of encountering a use-after-free bug related to the dedicat=
ed workqueue.

>=20
> BTW you're fixing drivers/net/ethernet/ti/cpsw_new.c I think
> drivers/net/ethernet/ti/cpsw.c has an identical bug, no?

Yes, as noted in the patch comment area, I plan to address the same issue in
drivers/net/ethernet/ti/cpsw.c once this patch is approved.

Thanks,
Kevin

--UH1uIraS6vl8AKuT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAml6/wsACgkQk1jtMN6u
sXGeSwgApr6OFmEUX234PpjrEIQIlnM3m7PzdD7CUzcQ03K8vr+EeScd9bBSUt3W
s/Ap+TOHLKbv9AcOnWn3jZLNWNYb5xJpzM4+iU+Hl2IkVayaOPwYTGCevMiSnlfH
3RKxR9yh2TuFhYlnPZpeD2bdKXX1P1DPZV464MD6etTY6xJxqLpMVLw2CLxHEQFn
L/dKEngjlRvvKtULu0fVUQ5t4+sjne8nthMmuagnzqzzoXq1Vg5v7w8sqG3WXYN/
dwz5qjBJUGgn0+u/vBOZ0/dUFsxci2/sAlUUjsyRfqexotFyXtt3276QkwgpGLJ6
b/CVzZXLQAk9YoAGRyrZsTThYFpELA==
=gJCM
-----END PGP SIGNATURE-----

--UH1uIraS6vl8AKuT--

