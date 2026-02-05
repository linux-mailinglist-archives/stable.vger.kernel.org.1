Return-Path: <stable+bounces-214425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMOfG8RVhGlb2gMAu9opvQ
	(envelope-from <stable+bounces-214425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:33:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1ABAEFEB7
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A979F300EC89
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDDA346E47;
	Thu,  5 Feb 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="HjcjDghD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E6D3446CA
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770280383; cv=pass; b=dvAzHkwahHY7BWN+Ugji5JXSc4AfUULshubT7nwco9byNhZBWL2eHl71OzcB9eCAeRNLtEpFBf40zdw6Jc/mMdX8vE+6gZY3f7swhHVQRk5CFTM4Cn1J6NvRMaGFWAvRFMjq+hYxgv35zsjj6moAxwJmTJ/F5vhhrHuOC8JcuAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770280383; c=relaxed/simple;
	bh=4nRf6SHJsVhZfYah+s5gm1QOcWTJwdFxjn6FWyPfPpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iL6VO1WZ1G8nwR3Ii3eg3XVMxCi6HFhCMugyMg1gUkzFCQ91Ev8X/sr+820KC1Z0o16TtE8N85apv+rq4na1RW7UTi21J38U8nQxnMlZPh2qBAipLT3PTxWH68aQbSk5IuCOBFveTmUdSAgyfn9CYmwc0Po6uf49hH/1UZutPMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=HjcjDghD; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6582e8831aeso1101856a12.1
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 00:33:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770280382; cv=none;
        d=google.com; s=arc-20240605;
        b=XD+vXzOKEBcgq1FZGg7GkLSJKEmjUIlES7kvgbdOrj+G9+DnO0Jt92Yv+XM+H9wsvW
         JjGB/626ZTdDi4WFJX4frzwoSRAW/9GYyujiIG/88IODO2wJSTUrODGOZdQMc7+dmAny
         t2HbeRwfN9xtv5OX1ztObPrcKrX1LMFRuDYM1on/yq/K5Eba1eEHAPaM28LIYn9tDzKT
         h9RCV/LwBp+G+pROJ1JwSQqDkEtOTQpqFGRTcZGAVTdzEqVJZVIdoxzQw7x6rJqd31gZ
         XoOf2uC5ElwwU3Wi/4jTyAF1FVyPcXbiI6YYsvrjygWO1eipHwDm7m/UJFfSWaVKEOwM
         fnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4nRf6SHJsVhZfYah+s5gm1QOcWTJwdFxjn6FWyPfPpI=;
        fh=NI+QTnbAEwL7bgaZu801E0qdOkm7FBJzOMCVYjR9yCE=;
        b=UhMY+cnF15vuaTF8xat44iqVzyXZNGJ42k5dfIKCSkha01eQ3O8oFQtUUDKoz8aVv2
         OxPHxScqpZncWJupH/ebNJhvrDTpcLPyyikbqlrNhqWm6vdvfvuiRQ6xsqdWKdUocwGE
         Czt1QaJC4R2x6hg+LxgzBr+nf+hpJqGe7PUW/Y1M95CE+ofuOfCkopQop4dzGT0Ebaeq
         hsyvESWnx/bjSg/BVj/WPlsAqvFBi+EMVlkULEZ6avbZmmnCcBAqyBJpN2YM9H4K/kCM
         0coxDvK3x84FXkStcVvIIWRFr6ztwMdYD8YT/yhReKjLkumkDYXYdAqAhNN3BcRhAN4C
         4zlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1770280382; x=1770885182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nRf6SHJsVhZfYah+s5gm1QOcWTJwdFxjn6FWyPfPpI=;
        b=HjcjDghDS/90cGDiNRVffTvIvz0gqHw2tenTaaodvNszai2MyVomSf+bHa73gQdxBg
         doZEZZ+RFD1NqfNhAIWk2ZXiSu+5422TIROD/L3lcaZFi0LJkLStltJgBLHCo7Z7TIN+
         Qx14E0+EHu0G+bXlr47C0hn0yRGBWpVpg49hpRvHZ5AB1nzvOo9xwCN3qyD6X0wipujk
         1SMuYmgAQ4BOtlgTEjWpoOoAsK0xChsMwp5/5sVpenSig/T0/TiCziPf5kPWnpSvN5Hv
         oz1KNNoYCKc+xK4d3bl4lSF9Ht9REYLObBeDaDPHGS1souRnzKY++t/Nae1J0Td1trec
         eDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770280382; x=1770885182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4nRf6SHJsVhZfYah+s5gm1QOcWTJwdFxjn6FWyPfPpI=;
        b=fglDHdLTafeqHZEUxhqA2uYGLoc784qIy5UaSphyCH4XEalKTZDIv/s5kKXOp6aKGv
         saOlkVXQDT2s9DL4XJb9xbrd9L9hJUHZzPBKhXIoIxMO6ZcFlbw/RFrKBEigFuorVK3D
         CT2shhVauoOZgrry31rWK2kiBsw3F9OShb6TrEdxSZnDJxUYXaY059hiqLAJCXcZeohN
         xwXWpc7Kvf/16/eZB29XvK1DaR8l1g9bzn5ACWE9HvrYcacLvz1RBKkzD9Dcw7INaoOO
         bahviDYWypj1M0CnWm91fRQos8IzVh9T2yEv258slPI1A5YVhO47vhhgJ5Q9vP4j0Zkq
         VDgw==
X-Forwarded-Encrypted: i=1; AJvYcCU9ZnKUQsLZDBOjpp2K8mKsHmmAHE5ZXUt81W/I2G1b9TgktM0gQuc++aqNdymU67jzxTkElTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcO5F8GcbmrqousW7diNE/TjRm29/fhz2/A6OgsO4xGWOfLwC
	+syJSdJ5e+gFTXdtWzwOhoIMnRjpCWuAA30aw804SwsnPJ6tOYw5f2XRLhtym7mKI9CAjhh8QlP
	RXPtpvhzruW85hBXoAlCIGyRLNUl3FFWodwzM46SumA==
X-Gm-Gg: AZuq6aL15PsagSv90ZrhQFa7xjC6eb3fbklBCMAQdAouJkeubnCBg4pIQd1+26ZktF7
	QJA96lTcGzWH7ici9kO4qVaKUyY+f1QS57OF033Emy+wAWF/o2GfPtTWUWE8sD+XIbCSQ4Zm3Qt
	fGbZW4LfGPRy13cOvnAfSJ3mLTenag4/EM7BLvubSl/KaG5wfFQR7Y10v0Aw+e9VGw8bOOc893E
	hn6JF+jPVddafjw+p1tU4vOB0wi8a5TsJGhpxwPgpIGOPL0XLjn+ISb7Xzs7Ty6rtVWa6VHR8BD
	GioNtGnZIbFDVUGlbP4YXhUDJYam
X-Received: by 2002:a17:906:8f8a:b0:b88:637d:aa75 with SMTP id
 a640c23a62f3a-b8e9f3c9e3emr429179066b.30.1770280381624; Thu, 05 Feb 2026
 00:33:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129-ufs-rpmb-v1-1-691534ab723f@flipper.net>
 <8149b8cb5a7b36a1543ca05666f33a6373674e0e.camel@gmail.com>
 <CAKTNdwG=He3iJ8cPo4fFbcEwQQRrt_SGzoviMhi2a3kMXAO8hA@mail.gmail.com>
 <ad7e2d0e5b219b4b2ef2aa7ab342513a2c66171f.camel@gmail.com>
 <CAKTNdwG_RycHp++Z++D5HzcybSyQwvKbb++AhtXhNgE6sOoThQ@mail.gmail.com> <a729a7d1b63d0b7e78806bfec238d8db2705c693.camel@gmail.com>
In-Reply-To: <a729a7d1b63d0b7e78806bfec238d8db2705c693.camel@gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 5 Feb 2026 12:32:51 +0400
X-Gm-Features: AZwV_QiABBd14DLM48ZE4ziYazv0fNb_LhoTNM5ingrU5uicHByC4S43axTn9GU
Message-ID: <CAKTNdwGE5oR-axDGYfBCsmG_p=G1oeKCDZ6GmYoRHMN1PXcJSg@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix RPMB region size detection for UFS 2.2
To: Bean Huo <huobean@gmail.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Bean Huo <beanhuo@micron.com>, 
	Can Guo <can.guo@oss.qualcomm.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[flipper.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[flipper.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214425-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[flipper.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alchark@flipper.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D1ABAEFEB7
X-Rspamd-Action: no action

Hi Bean,

On Wed, Feb 4, 2026 at 12:37=E2=80=AFPM Bean Huo <huobean@gmail.com> wrote:
>
> On Fri, 2026-01-30 at 18:49 +0400, Alexey Charkov wrote:
> > > > The spec says it can only be up to 16MB maximum (see section 12.4.3=
.1
> > > > RPMB Resources), so it should always fit. Happy to add a comment ab=
out
> > > > that.
> > > >
> > > > Best regards,
> > > > Alexey
> > >
> > > Hi Alexey,
> > >
> > > Thanks for the clarification on the 16MB RPMB limit - that addresses =
the
> > > overflow concern.
> > >
> > >
> > > In your above operation, why not use SZ_128K to avoid the magic numbe=
r?
> > > BTW, please update your comment.
> >
> > Good point, thanks Bean! Will amend in v2.
> >
> > Best regards,
> > Alexey
>
> Alexey,
>
> did you send your new version patch?

Just sent it out, thanks for your help!

Best regards,
Alexey

