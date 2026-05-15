Return-Path: <stable+bounces-247638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O0/Iqj2Bmo4pgIAu9opvQ
	(envelope-from <stable+bounces-247638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:34:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6F854D6B4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C47BC31209BA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946E14418E2;
	Fri, 15 May 2026 10:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHhdvcyn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064AA44102C
	for <stable@vger.kernel.org>; Fri, 15 May 2026 10:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778839901; cv=pass; b=Mcm2i/8PoNPsKG4GaNuGWwGoY19DFA+VCwmZrJfpqESMyBJFt71CbEqeJM4PKoAJKvceOL1b21SV6Guh8lvo2g3ArAU1WA3xlWHNAB5GWC2DpI8FMoRLvYgxER1bzJ1tmRnLmKG6PpzB8cB9Uqa3fD4rtnYkMUiWFFQ6tTMvnug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778839901; c=relaxed/simple;
	bh=utVbCxSx4wQLyjNHnWlnBe8NHEco57qRKSUCWgZQVP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPwIX5ki9Dx8RPJHgbVEiE38n1C3K2DbdMIC2Nlgf1UmVyv/ndvGP6xlROjelMPZ97c+PpmpJZrZvWeiY908pBbnzh1nbKrVC/AMON9beSYbA0jRRr42FxnO4o6Kiq00OYgMy72v2Xct5KLG0S5kpWI/667EcowQzLK+pPNi0cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHhdvcyn; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d734223e4so465466f8f.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 03:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778839898; cv=none;
        d=google.com; s=arc-20240605;
        b=NyVBKvg+fzRYl+1TVIj8ZTm/GyAZn0XbVOvfvx9WZUf2Fc/kAEAFiY0vNYWaYI4xuO
         DtoOp3L7xyb0pQ3WSYaJTcV5on/C0fy19xUnASuCwGbzDwYfbFLhR0kN/dfjs9Ij0+l3
         Lq942LeHdzBRCM7/Ru5gNyo/l5dbFB80qlg4GDSzkVLTR6FQ8jfZDz1RZBLnxkcpJWuc
         9Y0ZMO6Lw5unQ2oeVe2U3JBY11xJjD5gepqP2LiPDKyxn1ErJ9YBKbeTGG8qgVlUU0/w
         GKQcHlCbHbgOZEN7QsM+6A4thK4aOWD8TGLmKnv73EGNPsBjyHAXggW7sa8FS3g4G/e1
         CkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ipsP+ZgFcxWdZfStT+4SJ9Vx6hb0HvDTEGMqivduWAo=;
        fh=wTMHoEN0V1Qwu9UZzaCfqzR1++V/bZe+Ev84IsCAsIk=;
        b=On6PAvTJV4rrMsSMYHM78Vbx5jras9bx5y0/BCjCN9NA7cuscYBiOfshQu9ZrB6Fe9
         jFpK3an5D4TriIuL/jzIO5hLdvn7Bi0raOrcu+Vae9Bkl5PxRkta8iUlfBEsbAuiao13
         TMmCV3X/EGhiBXZrAedxCkSmGnEuNnRORBy5mQR1hahvgJNDhHHDDVXJX7dj8WVuk+JJ
         L+LRs4eHmqklt5rxRtiwYdzpmiJACpEx0We1ifudNy1mDA25/rHl8BlLR/bSL/K0CsV0
         Z/GwToQs+7kbEcV2gkxoHA4YxelESMNhthbhQGo1vpkfqz8BuiQ2iXlz8PDqXyYsFNid
         kguQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778839898; x=1779444698; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ipsP+ZgFcxWdZfStT+4SJ9Vx6hb0HvDTEGMqivduWAo=;
        b=MHhdvcynnl0+otgFbZfpfIFMCqaxRouWqFmcFeUbjOrHX50cCUcy9GKgUIeB2629JM
         hFKihB+SPYVXXxWzZ9bzFmUYxvvjDJvejQA6wByBGLXJYB+Gw2UZPTv/CNhUCoXEhYr+
         SJg34wxqlug24OudrcxOcZXuHy1CtmvYkfkrqKQWykBVE/c/kvuKMantwCZ9oufiGv0+
         nfNxCHvZiVpio3jXokh3M2JlGOZDXWqKHObTSA48oy5f/2jV+vr8nN1fQmbN92gBMHVu
         NDq+26uBBwY7B6fIF5QDz6Y4lu3XMcfuT1gBk3R2p3dRAzsPB9buFMoQ3Z3UdSu89CdV
         sCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778839898; x=1779444698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipsP+ZgFcxWdZfStT+4SJ9Vx6hb0HvDTEGMqivduWAo=;
        b=Yhin4u10BS2xLe/YamH1+SDBeCAwKlH1VrVxy/t1RQUN7eE2mEb0W71doHFNvaQR5h
         7XYClAbRqtcoO7c1jyfo071FbjHCZd7c6QpyHSZWzojsINOz+a86BUhlrRSToeuXk30+
         MwfYuRFZm0inrK4UfvttJRqQm4DP1SpCQfV8QzG/Hy1lnH7nGClJ2P3yohf062lY25SW
         PflP8oo1GO3Nonm8zwz1Z4vRGEZR4I1MaMKWUd0lfMQSrMMrdzgfh/Nv0jXppLrTxb/l
         4Nlc0iU2vH0ALYir6klVvvHG000m3dcGaECgITPgo4UQvvbgv01kJbajJFmc/Ewo0pwE
         zWQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+OC1nc7lJ3zSUM8Oo/JxmZK00pAgiWhJ2iA+Z8zyjhSixNlwFNqUbpUy6QTBnBPvqsEhrIzI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP431z+D2XbKc9x5RE+qNU5ddqgBOGZmKjJhVNqdGwTf1QIzyr
	lK8a1rkBdt2CB22Kaht0dNPK/WI8qCxqvl6e7ac4u+DQqEOQxI3ZDwlxUAIrn5NFlcAXaOBggZn
	/8MiCcfg1eCHdRayfcZjk1PTF0VjkJpw=
X-Gm-Gg: Acq92OHx0UfPjucBI8RVnfKcWbHHNmwDJzKa9Xlux2EinESyHeLBK0zmvtTVbioylkX
	DEY8fYIPYtk8x+USCLrl8tKudOGPlSSAKvsKs2skkzg1LtHKRF87cOE0aa/zL9tPufak9P9XzwL
	rDHnBNvYp0Lynhx7iqK1vCUoViuWKLnJ3eD/KzC6TDiLArE54GGKCWhi9DMcPSCE4KqkXD/N4/D
	KonRhjexm1a+B45ihLlJSrSxVh9LAZ9IVSftf07KafPCIvrqThKxle8j2NzwM2O6t7YcwzEJaQV
	bPM4rc1/gQCLD2iHF1MzyxF1fU6wpOlhr51bOBt0htfQUqbY9EmbKEnjtUP2PSRQ0Pn1Pq38BxB
	+4wxLsyVSeDBPQNszMY1pk1FF1+VNcBETx0MfpLYgm39czh8vMbn72wbY/WwZWprN1saQyjmFiS
	ODrM202AvqFJkalnYR
X-Received: by 2002:a05:6000:2a02:b0:453:dc4d:9265 with SMTP id
 ffacd0b85a97d-45d90d76962mr8672926f8f.10.1778839897695; Fri, 15 May 2026
 03:11:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf@gmail.com>
 <CALoEA-x31YdsdCtubOw7o1GBakCBcc4ha_KvuP=W5URBHyZDtA@mail.gmail.com> <agbskYwLK31PCnhG@ashevche-desk.local>
In-Reply-To: <agbskYwLK31PCnhG@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 15 May 2026 12:11:26 +0200
X-Gm-Features: AVHnY4K85mkiuponRLsT_djJoxDAXdjc0diERy3Mb0F8d-LQP8_KqR7kVtdWyyk
Message-ID: <CALoEA-wRTTZHDFEBBKZ98Vm+5TMnd8TPSKbn7F8W2LsEBuADrw@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8975: fix potential kernel stack
 memory leak
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4A6F854D6B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,analog.com,parrot.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-247638-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuacrofts1@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Action: no action

On Fri, 15 May 2026 at 11:51, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Fri, May 15, 2026 at 11:00:17AM +0200, Joshua Crofts wrote:
> > On Thu, 14 May 2026 at 13:38, Joshua Crofts via B4 Relay
> > <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> ...
>
> > > -       if (ret < 0)
> > > +       if (ret != sizeof(fval)) {
> >
> > Hmm, Sashiko pointed out that I am comparing a signed integer with
> > an unsigned integer, which would result in type promotion and subsequent
> > mangling of any potential negative values... will fix in v2.
> >
> > https://sashiko.dev/#/patchset/20260514-magnetometer-kernel-mem-leak-v1-1-35b48d699faf%40gmail.com
>
> See my response. That how it should be in your v2.

Thanks. Checking the driver again I found 2 additional places where an
I2C read is going
into uninitialized memory that Sashiko missed.

-- 
Kind regards

CJD

