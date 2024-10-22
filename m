Return-Path: <stable+bounces-87732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC9F9AB0DB
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 16:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BCB31C22597
	for <lists+stable@lfdr.de>; Tue, 22 Oct 2024 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C31A00D6;
	Tue, 22 Oct 2024 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Wc6BaGvN";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="Wc6BaGvN"
X-Original-To: stable@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA1193409;
	Tue, 22 Oct 2024 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607423; cv=none; b=QJqaJB/LNiR0kVdcwLXtghCnov9m7RDIUWugLsFbmJMFvhtfeox1RYEdlgVjJVyP7+Bdx2krhXatCXMSmzlhXdwvQxxrX9YDT+w9YpPEXbgxIO3o7kpuGP8T6bhl0Pgguq+mHbzPp4j76M2l3VoennyxlglPzrKINtfEBTAfFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607423; c=relaxed/simple;
	bh=DbP90FxVvhBKxKThPAzJkk4pXIl4TgkL0n/XjlVZekg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DHA/e7OBNRXcJHXIC97lWX/TLFT72mzJdWhWN7zyQ3wCKA77b902gF6qUISQTHH6YpquHJcJ79yet1n9WrTTtr4mlj610rLxlSu5oShrg4uZ67VOZeJId6Zwa5maV9BdCJXwlNqCSNpA1IaeEyt9Z/Edepdif+UmyEdVCfS6VSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Wc6BaGvN; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=Wc6BaGvN; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1729607420;
	bh=DbP90FxVvhBKxKThPAzJkk4pXIl4TgkL0n/XjlVZekg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Wc6BaGvNouFj2aadVuF6qds8MoCDSn/WSrQhuJu/8w8bzq6sAz2EamkUlM0dbuB2E
	 lyfGkuqnp1/7a3J2ApgThqbBK3jYvMKZUTyREzPjSPUKBBif4yRpdvzIfUByNluHuP
	 ahFvHP8fwp9EUmfdq3Fn2jhm3l8RwTnBf8VqFW9I=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9887F1286339;
	Tue, 22 Oct 2024 10:30:20 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id Oh7LZV33Y85V; Tue, 22 Oct 2024 10:30:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1729607420;
	bh=DbP90FxVvhBKxKThPAzJkk4pXIl4TgkL0n/XjlVZekg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=Wc6BaGvNouFj2aadVuF6qds8MoCDSn/WSrQhuJu/8w8bzq6sAz2EamkUlM0dbuB2E
	 lyfGkuqnp1/7a3J2ApgThqbBK3jYvMKZUTyREzPjSPUKBBif4yRpdvzIfUByNluHuP
	 ahFvHP8fwp9EUmfdq3Fn2jhm3l8RwTnBf8VqFW9I=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5C3BD128623B;
	Tue, 22 Oct 2024 10:30:19 -0400 (EDT)
Message-ID: <fae2751f6881bfc402a074e909be6a67ef9467df.camel@HansenPartnership.com>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output
 truncation
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Rasmus Villemoes <ravi@prevas.dk>, Andy Shevchenko
	 <andy.shevchenko@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz
 Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Date: Tue, 22 Oct 2024 10:30:18 -0400
In-Reply-To: <87y12gp7xb.fsf@prevas.dk>
References: <20241021100421.41734-1-brgl@bgdev.pl>
	 <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
	 <CAHp75Ve1WUKYmv6sfGZ6amujs=C7MnxauLM+C2MeW8vxBV1NfQ@mail.gmail.com>
	 <87y12gp7xb.fsf@prevas.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-10-22 at 15:46 +0200, Rasmus Villemoes wrote:
[...]
> -       snprintf(buf, len, "%u%s %s", (u32)size,
> -                tmp, unit);
> +       if (j)
> +               snprintf(buf, len, "%u.%03u %s", (u32)size,
> remainder, unit);
> +       else
> +               snprintf(buf, len, "%u %s", (u32)size, unit);
>  }
>  EXPORT_SYMBOL(string_get_size);

Where are you getting this from?  The current statement you'd be
replacing is

	return snprintf(buf, len, "%u%s%s%s%s", (u32)size, tmp,
			(units & STRING_UNITS_NO_SPACE) ? "" : " ",
			unit,
			(units & STRING_UNITS_NO_BYTES) ? "" : "B");

The use of a tmp buffer prevents that having to be repeated.

If we had a way of specifying "ignore argument" I suppose we could
switch the format string on J and then only have a single statement.

Regards,

James


