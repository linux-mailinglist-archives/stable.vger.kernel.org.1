Return-Path: <stable+bounces-248993-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHr7OKRLCGq5iQMAu9opvQ
	(envelope-from <stable+bounces-248993-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:49:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E1E55B349
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 12:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A401D3013AB8
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 10:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BB3C7E15;
	Sat, 16 May 2026 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNYtLhh5"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB51D39937B
	for <stable@vger.kernel.org>; Sat, 16 May 2026 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778928537; cv=pass; b=pOJZl7sKP1ckQvvBJgD2iw7I8iF8MfZHocxYxyJX5S8EDm2tXricTVEbpEW7TxsHvL2dTXklJ2sxziQnNtpr+m9bUwIQ0z8+gUcTS8AfHy7V7tjL7rQHMv0fS4k4BNYh35NlDi3M+iKTK7kpFUbKY9hKMgQVjlIvA80iHUkSwM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778928537; c=relaxed/simple;
	bh=n/AVyKlJGTsYHXsiXwBdHgBJFjZOldWnzK92bPN/bbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSncXXCfZWjDO+OXoZBfdFiX/CHEC9z2llNOfjQ2n1d3Dt/DTntDmstZ4R8wq6Vde+kmnc/nwY6V6kULzsjnHoXjhBGVD3iAGtRT9D0MLJRMDrg/gGQ9MWrki6muY0iVlCX+RVyKjk/rzLNWXp/PRd7QaX/GRURq4lxmrjKFBTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pNYtLhh5; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd87e5d8ffso2568997b3.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 03:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778928535; cv=none;
        d=google.com; s=arc-20240605;
        b=Mn3eHUSkL0RoWYDuNtjwkIJT4cTboqbR4TVUFNinmD+ZvYauRuTp8wyEQN/75l4uER
         z7XNdumBzRXPqQ6UKHSMM3Hi55dDjhCYSS7qberUxaOb8cRIaJcSxQSR4J7JBLieeAWD
         nwzn2pymyE4/E8TRIZ1Hq6SovEMYD7do6DEt1dBmdB75cl/TqKFaa+Jd1YHtpgWXiAl1
         4QrxF3pcmqz05p3MvG/opIR0eX3basgNvs95LwIp2KD+konXzA1+RB6M8WwlqUI+3yvp
         TpDCScsQsEB/kUPhNOBPb8RO/3qiZxlOXWg6hoxAjw6i0kDjz7X0V1E6/lJEykiUKuw2
         C7Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n/AVyKlJGTsYHXsiXwBdHgBJFjZOldWnzK92bPN/bbw=;
        fh=Cz9IXA+eqS0LGDcM02s0veu17np6UKMYQ2MszTAJI5c=;
        b=jODFw11M6FGOI3RaKc1eWNf8YBvzLL+94H8qQ7x3IgutKkdwFe2npIzNG+HwgX8Lq9
         JHEkur1pstFXS1KNdK7FDviU1E2pE34pi9SxyDWnk/DKLCOTY6xAdJABBiFcN1RC+2Gk
         jkfE186djEmE2Hnm4M+FccWzEBlN+whhrlsQ9b0SQ8y7f7r1kx8kCoMdl0B1lMPWxmnE
         WcX8B2ka75mEueF0XlKuYO5lBlfdWI+9ByXsEsTdggAVPKEe981eouvD0ka1t7aTimfp
         NLYsVgYlSwaeUMUI4QbziR5EAMuY5vVUbfcSzBcGe+YMfNTThjHcFmy1b0dZ4tZmexX2
         Bpww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778928535; x=1779533335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/AVyKlJGTsYHXsiXwBdHgBJFjZOldWnzK92bPN/bbw=;
        b=pNYtLhh5Z7Szpf+lmmbK5DyYZo09+EFqC9DuBQrPsp4WWjDm4UOApB/IjtyGCU2Jgg
         s879xPqgRqLMyrnJMxYTEl6FsidKqoJEIcn4lxrtvZFLlqhdtUP53YBaWKFTtHVIY7Kv
         CJWXP+/ph1nPWfZUjE9gRgq7L51vDPXnceo1FYZnQeDo+GeZovYXLPuB1WUT7dxBtojP
         7MhF+wm24KlkZAMocLkOwMwU6DejpPquPiDBkrYZQLdL0iwZSU3L/SRVf4g2260FYSyO
         r4xv9CE4FAzsN2GlsXS88f9+bXBKJAwmNKIx+/GoN1WAB6tQGOuejZoObLYWzuAkPq7M
         13WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778928535; x=1779533335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/AVyKlJGTsYHXsiXwBdHgBJFjZOldWnzK92bPN/bbw=;
        b=OSFyHa1f+QxJqqA1+GLcUWzHrWWB+EL6/ongeBBIhM0TD+Um7sp5XDf01KsqZrfwea
         g2HhspuiYRjdCLsLHQmdGDjTCtUKRRvD1TACNE3eAFqU/EySXqlA552Y0VDgUYeez8E0
         g0Z2PbzuR/ofBx3wgIhhfgUQy4Kh/z0CEb8kxZxkmRHqRAsH3xePOEg3Sk2LPVwGP1EX
         WSvvdjs4mvJh5XpJBaYTB7qlhvJYpl2bbEnpERMD4KHOj8tIbkAoBgHiVzZMsmCm49Kq
         23PJ/slCGIdsk0vEfrd23BhuOncl/sc4/JRo7zHw/c8B0EKiHBCJWg9mrznaYGuvuaVG
         z70Q==
X-Forwarded-Encrypted: i=1; AFNElJ8bEYOKwWvCn5TdtX5uUG5HtH2HiGJjYFT/SEjvIytjkhPWa3vOuMgSTs+au/IBU7Icqhkdc9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGW+80YP69xk3LEVChsESfwkTZmYedZC78+t7LU6iTCNxfRxvE
	t+kjpjFwqta3fvszyJ5lGbBNRt/Z/M9u2iziA9yY8o4oijM8CEN03tGtQ/frk7Q2Tchxgs/oijp
	CtXfuSXLSjauHHBwGZOOsQ/0YFjkFrz4=
X-Gm-Gg: Acq92OHmEg1lqEMxCk6AN1R75JUzlyDhpWAdDGtC8QUknhrcXnE/HG2o1YBpLvWR4vO
	vsTDylNx103j1j5fUMpUWJUd5dD25aBJQ0oq9MPaHhtlHxGyPEWThUPE4dvcPQHIqr4nKpwK65i
	kGf6WZ+GWMOxSwJN3NsEzqBSGgZuzBeCMKflKiY/15pDJ+p4+iQJOVh52Al5ZGinH21b1b2Y0Z8
	6q0G24ZZmHP327EKB1pkZIz/YzhZrm1snUP7otCgurX9JJUn6Ls/kP3tkqkj7Zefea3tEB441xw
	LK/kYuI=
X-Received: by 2002:a05:690c:c36b:b0:7ba:ded4:df69 with SMTP id
 00721157ae682-7c9463a27d4mr60332307b3.1.1778928534930; Sat, 16 May 2026
 03:48:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87se8mytvv.fsf@toke.dk> <20260512144512.9960-1-bernard.f6bvp@gmail.com>
 <20260512163648.7367a640@kernel.org> <CAFAa3YDcBsCnEJ1t+a3iHhzxW65HX+QNkZWPKHvDYp_V+UwZYQ@mail.gmail.com>
 <20260515181411.28af7ffc@kernel.org>
In-Reply-To: <20260515181411.28af7ffc@kernel.org>
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
Date: Sat, 16 May 2026 12:48:43 +0200
X-Gm-Features: AVHnY4IZ0c2IDo5kgo9E787Nd7IrItMcCAVJ5vxd7c8NHwfo2rpdQii2G5jAbXo
Message-ID: <CAFAa3YDf4Zq9bH44FMS43E=FnMrvXF1ry9pdTQqT4ZvrqhzZBw@mail.gmail.com>
Subject: Re: [PATCH net-deletions] net: remove ax25 and amateur radio
 (hamradio) subsystem
To: kuba@kernel.org
Cc: toke@toke.dk, stable@vger.kernel.org, davem@davemloft.net, 
	netdev@vger.kernel.org, pabeni@redhat.com, gregkh@linuxfoundation.org, 
	linux-hams@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 56E1E55B349
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248993-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Fri, 16 May 2026 Jakub Kicinski wrote:
> It's a GitHub repo so PR is probably appropriate there.

Done. I have submitted the five rose fixes as a pull request to the
mod-orphan repository:

https://github.com/linux-netdev/mod-orphan/pull/1

The PR contains six commits:

1. rose: build with hamradio_compat.h on pre-7.0 kernels
(compat shim for struct sockaddr_unsized, required by af_rose.c)
2. rose: fix dev_put() leak in rose_loopback_timer()
3. rose: hold loopback neighbour reference across timer callback
4. rose: fix race between loopback timer and module removal
5. rose: clear neighbour pointer after rose_neigh_put() in state machines
6. rose: guard rose_neigh_put() against NULL in timer expiry

All five fixes have been built and tested successfully against kernel
6.17.0-23-generic (pre-7.0): insmod, functional operation, and rmmod
all completed cleanly with no crash or leak detected.

73 de Bernard Pidoux F6BVP


Le sam. 16 mai 2026 =C3=A0 03:14, Jakub Kicinski <kuba@kernel.org> a =C3=A9=
crit :
>
> On Fri, 15 May 2026 16:52:43 +0200 Bernard Pidoux wrote:
> > I am happy to submit these two fixes as patches to mod-orphan if that
> > is the right approach. Please let me know.
>
> It's a GitHub repo so PR is probably appropriate there.

