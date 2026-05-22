Return-Path: <stable+bounces-253770-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJokBaFLEGq5VwYAu9opvQ
	(envelope-from <stable+bounces-253770-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:27:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B08565B3EB4
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 14:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA7CD3035915
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8ED36EABE;
	Fri, 22 May 2026 12:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9o6Cr3q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E137880B
	for <stable@vger.kernel.org>; Fri, 22 May 2026 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452304; cv=none; b=Abd5OfcA/IO0mYBu/qScbflE/igFYhjAMsvQvgx0bRej9BuSsH3+PdEMxzsIfM7wexHhjSjgtHuYw9fROINV8MSc7e46f+5zwZCso5a4J8eS1dc+73t9PxmhVFI9epwphPmB28VvAEGEBvZeBd/9OtbhHzS5H+JudomMgRBJNjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452304; c=relaxed/simple;
	bh=sq4J5IGKA4bqp64BzpIOHpzuHNrtcjtX90R6oU3nEp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ezq3Vt3OjuTRfwd6y9y6Kj/orKXMfyWS7hi/p1UdAFEMASWywG8MM2ab8mGdogTgQkgpOqWZea0wUjq4TyoQ/0hQ+kEJZT176jhlpvi0pAgkDMaxovrwc9Fb3zD/7RfOqJTQKSQsLunY/1I5T6gp6hw5qjO/XIeaOXpq/1Zy+M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9o6Cr3q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71041F00A3D
	for <stable@vger.kernel.org>; Fri, 22 May 2026 12:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452302;
	bh=iqUQRkajnlNkU9+5FETYuNBrBBEwPzS8xammCQjMaBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=l9o6Cr3q5XPAMsji7vOyKMlwMDapTyHPzQW45b3QVTLwqr+SgLy+SVmZhSwkj/K4Y
	 2U2637ZYccm8silZo2TVh7L/TOGTAUZJxQNGJoG8MiZAHEoK0OGKYEXxAdTMkFoNpc
	 E6waPvvKc7oD8L1wPnJrdK6KQSSLX2VkdFjyj59doGS5fesjkn1p7GniUVHmuC1mnt
	 2O1MdAPbmrrvbS+kAQ6X/fObfuPhQCPs4avZoMUSApFv8XNOjqBgcoiYtZ2x2saU3J
	 yn82x4fM49rxtvkAypgx2xFEdeeIvOg9kw5gK3gJZNMe9vaq6GKD2IiBZrnPKaYr6C
	 yJaRXQo7VSxTQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39380e79936so77074861fa.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 05:18:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ90/KHW3rYz0iymYfMRK+Kk3QruHOolf1kOel34/D7F9Y1BmyhG/LLMP5jaqycnz9lOomjknXI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1R7jt2LswG3KLvRMHzDLOiMhLbfPQNMuNqrVOpZu24xMbWeZ
	A3Shp9C4SL+UvI7NvU+kGmvGlhR6O6eweL9FgV1wYuwmrJwG4yZO374pBJddPDOqNem6J39exFU
	/6uyx1DvkGERjzwxCsbdpWtWdk/ZkTHIXsOCP9XVfrQ==
X-Received: by 2002:a05:651c:1991:b0:395:a23c:9238 with SMTP id
 38308e7fff4ca-395d8e07a6fmr11241901fa.31.1779452301705; Fri, 22 May 2026
 05:18:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-gpio-shared-deadlock-v1-0-76bca088f8c0@oss.qualcomm.com>
In-Reply-To: <20260522-gpio-shared-deadlock-v1-0-76bca088f8c0@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 22 May 2026 14:18:09 +0200
X-Gmail-Original-Message-ID: <CAMRc=MeESukotQ_3-cd49sLEOafKJktxrB_w5eia8V79T0nhKQ@mail.gmail.com>
X-Gm-Features: AVHnY4LENUwNX7TvJcxIa-C_EulbF0iwGMn63tDxwuET1YjOtOOdcL9KBGVoQPY
Message-ID: <CAMRc=MeESukotQ_3-cd49sLEOafKJktxrB_w5eia8V79T0nhKQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] gpio: shared: fix locking issues in remove path
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253770-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: B08565B3EB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:12=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> This fixes two issues observed with shared GPIO management enabled.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Bartosz Golaszewski (2):
>       gpio: shared: fix deadlock on shared proxy's parent removal
>       gpio: shared: fix lockdep false positive by removing unneeded lock
>
>  drivers/gpio/gpiolib-shared.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> ---
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
> change-id: 20260521-gpio-shared-deadlock-c9b7697c0030
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>

For the record: it seems to me that sashiko reports under this series
are incorrect. The model seems to confuse the GPIO shared proxy
devices (managing access to the real shared GPIOs) and the GPIO
controller devices exposing shared pins that are the parents of the
former. We never enter the same code paths for both when setting up or
tearing down shared proxies and lookups for them.

Bart

