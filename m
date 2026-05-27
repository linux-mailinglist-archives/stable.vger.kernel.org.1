Return-Path: <stable+bounces-254584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDeHGd/1FmrUywcAu9opvQ
	(envelope-from <stable+bounces-254584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:47:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDA65E54CE
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 15:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1001430B148C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 13:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52AA421880;
	Wed, 27 May 2026 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j674Jtbe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F5B40FDB6
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889261; cv=none; b=KXItZpgoPp6vbQbHgOca0kM5ZwZvq+TrywlNWHl99rkOcO7yr02pfeLzWjYmsPhO2qSQ72K1pPgVAOYJO8wrFf6mZSEe8Hdf8j9gHkCq0AyUpO6tp1g58QTgHxFlDGDQ3id1Jz4sYRcZ4HHgFtM/dGP0z8ew4kQnkqDLWe+s594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889261; c=relaxed/simple;
	bh=Pc8tsnlOcy9W6am+Rh8DZ4EPRcArWS82Ndc0OS66y0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnTvTCdEjff7d3ZAbkJ45hXF219UR0Of4i8CEVV7AoTmMzpsfMsZME73LYEiYNyi3qUuji2Pz9rr7BR6JbelT4ngHc0u1IVzCXX+COSqF7LRyi0em7YdbT37eR2TBpcf4rsTUhC1O7VzGi2DuvszPigqgO2mN4CWLKHAq6UEXgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j674Jtbe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0F41F00ACF
	for <stable@vger.kernel.org>; Wed, 27 May 2026 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779889251;
	bh=Wc0BbGUVAv6oHm5mCpjK8eArxnyNaeloAd0RRIDatSw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=j674JtbelWlVuQFetyki75i8vx67jy1hyJBGTzVFhZ4gWIi7j3LYd9UGsmHxEJORm
	 fqXZvWv3caJ2tZ3cIasaxc+WvNyuxnE9pbC5+dAbqUBPqp2SEviBfeibYZcodqSjYm
	 5iByph/AUviC86GDzazSTdJf2cXXqiRScRbn7JY+1syck/WNrZqaLIxEtd/j5amqiO
	 MBnDGe8mIWQwVdzrjXHHnQnk0vps7MDSHoH6UDjXL6t59txT9ttwyrCnP7u3uVNf84
	 ARYyDUvfAGLoc/ubfKIt2VFEwHHtCG9AAsDgyL7SE4eemDVS3xqyghnliMThEMHprC
	 uPj2XgazOh8Ng==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-48543ae6e39so3340309b6e.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 06:40:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9E592KlHgUp54V6lPq0/7s6b2kVF9CIF1xbAjIP5rviRZWoafG3GfmXKSKn0MW0bdyvk9HN7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXx58MdziZGeL6RKdNHgL+0RTJUv2TXdECMat+j8Vst2VTT3k
	OJMHng/x6znJSEM2xBOwmFx9kcBzR9EHkGJVCnxsrK2Z2FZesKRBowCAqxh5QcStjJQfOt9UnH3
	tlj/nlotYkiGRQOXSx3yZwQFsWiHjlBs=
X-Received: by 2002:a05:6808:c172:b0:467:4fb:f225 with SMTP id
 5614622812f47-48549ecfa65mr14148658b6e.9.1779889250644; Wed, 27 May 2026
 06:40:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520024153.1647951-1-xinyuili@126.com> <20260520152236.2308686-1-xinyuili@126.com>
 <20260521124708.177ac09b@jic23-huawei>
In-Reply-To: <20260521124708.177ac09b@jic23-huawei>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 27 May 2026 15:40:31 +0200
X-Gmail-Original-Message-ID: <CAD++jLmK5VRhNePbD=kt0THbH30HLYqDe_ahn3sOPkxTwBaUWg@mail.gmail.com>
X-Gm-Features: AVHnY4LHRa0uEz9hGPJX4PkRgVxY0ZrCUi_4vN4HbCyAwnwrKaAQqY562EzswE8
Message-ID: <CAD++jLmK5VRhNePbD=kt0THbH30HLYqDe_ahn3sOPkxTwBaUWg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: gyro: mpu3050: fix missing iio_trigger_unregister
 and irq cleanup
To: Jonathan Cameron <jic23@kernel.org>
Cc: Li Xinyu <xinyuili@126.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254584-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[126.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BBDA65E54CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 1:47=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> This is interesting. I wonder why we paper over the failed trigger
> registration.   Generally that's an error case that should
> result in the driver not loading.

Right, given that we have an irq, it should either probe
the trigger or fail.

> The mix of devm and non devm in iio_trigger_register() is also
> nasty.

OK that's maybe due to the initial overbelief in devm_*
garbage collection. It should be cleaned up to whatever
is the best.

Yours,
Linus Walleij

