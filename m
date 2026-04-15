Return-Path: <stable+bounces-238006-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGC/HGry3mmIMwAAu9opvQ
	(envelope-from <stable+bounces-238006-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:05:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C59613FFAB5
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F7D8303DACD
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E0128B7EA;
	Wed, 15 Apr 2026 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeudH/En"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41A812D1F1
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776218717; cv=pass; b=EpFt7U9pXuz8jq1VZCk+UMXy/Io/02UnjN9kODrxWHSvun7VrduzoF6C4X7Kdr46ggrqwdBlPXXN+aym9PPDGQ8M2lNvqYA/Jdx7K6x0QE3JJ1a6/FrARsQNmgGgd0mkzFhfcUPtnwPgCF956p0MxMkuvoi6YC8bw3ASPAa7aLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776218717; c=relaxed/simple;
	bh=//BODY+zI/RuPgA6LIbKfU/QsiOSH1O9Jbam+W9iapk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZiL6qeUZiBcSp5XmhzJxOVirsSOVUzIr80wSUfl46xBp1i7sTAscOjjfU4IqSYxKA14DiGdvl7DK/xNvnEyZzkB3AQcoIi6PAeKJqTTsQ5XSFwMVA1Fq9RHH2XjEuXaRW0Lx3gbGriHXnNyLgjjbO9XqAuj8oo2mOfkO6x7yhqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LeudH/En; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651c5d525f6so2980152d50.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 19:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776218716; cv=none;
        d=google.com; s=arc-20240605;
        b=K7bD1wMG6x0F49D6a/TFz1fIphhRkOjckw59ebPLGxHqxRvlcvoyRNlD6weLuefCXR
         Aefd0b4Ln+YUAdXI1DjckaWp4d9rw9Uq/I1LgbQD4ok9C3HubR6uLRiRUSYoxQsjB6Yz
         HiSG9FTEZgC0qp2CceVK3RVFtXH0FppBRxwaXbY0vs/zmSe6nsXQKzFhOZEaFRj8iCrz
         iy2JNhcppht0GtIT05Ojw57yaW3XwytPxxLWBHaTYJ3AIh/iRsGKqKRoM/hJJ8+aXpXt
         j6oXnsTwDzBL3l+SqRAxaveOeHBTd2n2SlfNrCh0cMZf6ptH/K4cJ3CDJFNMwPC14V9l
         jzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=//BODY+zI/RuPgA6LIbKfU/QsiOSH1O9Jbam+W9iapk=;
        fh=No6G50bEdAPvzzsgpkUsm7dtcMMlgG9Rb7xB4l8Ycgw=;
        b=DV840O5ZettPkKNt6T5SR01ONIuceStoId3thLYsqpHJt9ju61qjH/D27T3JvPeTcg
         UDTmUqjOP6yqUHDYE6HG+orcN+SqrKLDpQmdASNvXi8lapNp/fv6DwDOhYsXWOBsnkQe
         akVrBS6r9VXq8kraWb+eoj3lCwi1QAZl2o2e46MG5X38CLmlonMq52ID0UifTLo9VVf9
         977ABduGI3HAGy9/tzRaStPASgWrt20z6oQk1CyhJvNA1P+3LSFZzi3GA8X6MJqoQ98u
         VKbXCs6MNFP9joaLlJagZG0JuJNqTw7tMtraySqOdmU6mngtK2xsbFY5lWY5mV7Hn2ZK
         kl0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776218716; x=1776823516; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=//BODY+zI/RuPgA6LIbKfU/QsiOSH1O9Jbam+W9iapk=;
        b=LeudH/En9+As1V8Hx7RY3pG2I0LHB7yY0Pnw9StHuISLqdgelNQw5CJ6NWxW/6TPEh
         9rXDcK/v7xkKKfzyj1lR+wSN+MUG8pdQtRIO7cK72k2GGIja+sh5nF7CSRMdcdQ8UKcV
         T+xl/5Uo6vMT5bJBKDfx6MEtROC71oPCm0nDCqt59zUwoejJmS+3NziNlAxzSp+722rs
         4rvPhsFygGcnnzTFYRccY99ML71ugvtsMmU+Kxzlt4CDzHlJJjFx1+jQQ274IcR4OC4I
         PZK/XpAUYseT8AU6pFOixyBF5lazGYPminbGL8ck4UK26zFNql08Io6qMPAYG4pwRUWZ
         dWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776218716; x=1776823516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//BODY+zI/RuPgA6LIbKfU/QsiOSH1O9Jbam+W9iapk=;
        b=KKHDawXUWTAgM8laPGanNnIspaC3g+4VwOOqOd+M7YJ0icxKAmhWqLO76ukD+cMjI6
         dIgA2q4ffXN685YDHSH3+vVoKG2wOiD7hezeXYiErVEMZnJ3a2xQukV6lbjVpYkNzoyb
         GYKLoX1mHlqEUU8XPn7tkJVbunjjkjRT2QXQIn1G1n+z8gcXPcQtSnerbl+OBfP3HzEu
         cwdnLzHdfbWO28tMIyatB/uXFucW+300txlAikBUeHQ2txTF5uWzkYau++vdLSENdUcg
         1Npfg2tb93KTyIIBzEMXSK8tCzLj2qlIqWLF0XCIu3NvXDrW2GipKxhwkfYoOAPLEvAJ
         gRRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/enuBA/1RjUH5tuZPwXIUm3yaRDHVOg1AfvKh/u0WswnOleKLgF7MKx510tZA1RbpioyMC9Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsFuOI8ix91Wdb/7riqoqOw5MvXnZa1D9TDax2Hni2mHyjZat
	yswAB994H8AHF+rrrKHku1l09iy68wbKbdhsWB3JkMm1oQlfe5iHc66Ja5ZTSyEDit4IHU2Ntwz
	JERAejUNWYnQ8fPbEP/xEedus3uhDRYs=
X-Gm-Gg: AeBDieuwSwLKPtgiBUI77gdG15ZMZk7lVnnORQ6bvuwb1+9KozH48sLs523LLW8wNV0
	5tb8c3S1UK6rMSonKgPbjysCm3uScREUetT2FS+oK63aNPtpUX6w0vH7LYZvjTP/UxkfdoC54L/
	vV3uAgmkRM1ZJEBcvypU1wioTHAvdtvHHwdtnzqkx06IoSxCKogBjcbOoH0dEdlVm2BZf8nPS4k
	9r8w49pk45hkVyYSAtIK+Wd3fiGd4JzpzfxIvAVUUVj4tTKFvbUF1ury9NEjjBlEmRRcE8pBF4n
	6xIqEjHiNiAdl3YaI3kR
X-Received: by 2002:a05:690e:1488:b0:651:be70:8661 with SMTP id
 956f58d0204a3-651be708b12mr11714648d50.67.1776218715884; Tue, 14 Apr 2026
 19:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414121024.3142118-1-lgs201920130244@gmail.com> <4b7a0492-6ebb-e0a9-ca48-f2da6002d3e9@amd.com>
In-Reply-To: <4b7a0492-6ebb-e0a9-ca48-f2da6002d3e9@amd.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 15 Apr 2026 10:05:03 +0800
X-Gm-Features: AQROBzCYi4c4CkfhIjGAtD67f3EUwjXInr63HBlRDkKe5deoHv9cic-8YRXWHUg
Message-ID: <CANUHTR8ZBK8FVgc329=027FfyvbOVSN3+coZx+7B3x834dGY3w@mail.gmail.com>
Subject: Re: [PATCH] accel/amdxdna: fix IRQ vector leak in aie2_init()
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Min Ma <mamin506@gmail.com>, Oded Gabbay <ogabbay@kernel.org>, 
	Jeff Hugo <jeff.hugo@oss.qualcomm.com>, George Yang <George.Yang@amd.com>, 
	Narendra Gutta <VenkataNarendraKumar.Gutta@amd.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238006-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,oss.qualcomm.com,amd.com,lists.freedesktop.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C59613FFAB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Thanks for reviewing.

On Wed, 15 Apr 2026 at 00:06, Lizhi Hou <lizhi.hou@amd.com> wrote:
>
>

>
> aie2_init enables device via pcim_enable_device(), which sets managed
> device. Thus the vectors are automatically cleanup. So NAK.
>
>
> Lizhi
>

Sorry, I missed that pcim_enable_device() already makes the device
managed, so the IRQ vectors are cleaned up automatically. Thanks for
pointing it out.

Best regards,
Guangshuo

