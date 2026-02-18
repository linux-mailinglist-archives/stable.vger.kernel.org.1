Return-Path: <stable+bounces-217200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFzXE2IIlWk2KQIAu9opvQ
	(envelope-from <stable+bounces-217200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 01:31:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C0615248B
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 01:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F03D300B8EC
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 00:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E5926F2A7;
	Wed, 18 Feb 2026 00:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7EHxQCQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910F6200110
	for <stable@vger.kernel.org>; Wed, 18 Feb 2026 00:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771374672; cv=none; b=jQvJNRP3tmWo9KrYb/X9hZJPgCPwZZN8WWj1v033jb38nPj499HbRkJdIxQBJ5zsboeZgY4itOD6fBASnZ0qXIC88i+m0SjrZfzVubZQ1z3ysnukC9fYPS4/DSU38dUImO6lr0D7KaREBfH3RQuBXu9jo1FP5nAg4Ip4B+wpXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771374672; c=relaxed/simple;
	bh=Y2Fa0g/eiWnBGtl7TW6Y8Fxqa981wFYoJqnEQ9J5DTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIRG/E+HU9vi9N1M3ie3ldhnaENKDn9XcclstYNtErCaxzIn+FyiA+v2paXZXt+zM+0rsmJMiG9ARWnRUm0502qMXC4j92ZAHieTsTzUSD5KGBTDOZy06bUv758xf0mTGfDdTKTFYxK9PgxNdmGbH1EhT/SxB17PBOfMv5jZZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7EHxQCQ; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1273349c56bso6168972c88.0
        for <stable@vger.kernel.org>; Tue, 17 Feb 2026 16:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771374669; x=1771979469; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg0v5gzcAHvCWeUv8SrWGgkElA1mA5SgiIxc3XoTrGs=;
        b=H7EHxQCQzO0WfhvoxtJjCdHi3nZgfw6X0lMl76bjBN+ISxt8UIMRJXOgOclTRkvAiS
         KIjaFFBIwXZQXJsdC+C0/Ir7YEatWth1NPmPVvFZMw1kBq8tVrL4On0Lyjb9zuXM9ASu
         WstOqUzxXOfgibQuEO+7WZDykWdDJJNpb7XSvzvIqQOiObLPRGBhiO17cseYCgWdGE8B
         KHVQL8yKMYH5SPtMymKssb2Y4drPGU/s9ipDzOH/kwfB2XR9OU/4baSn7yhmTzNWaahc
         S+bhmQDXzgixCo31wkGk7PRQLg6hWjqHtsMMZT9z2wLc6wOBRSuwe6gKZWT+uqIg70I4
         KrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771374669; x=1771979469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sg0v5gzcAHvCWeUv8SrWGgkElA1mA5SgiIxc3XoTrGs=;
        b=e4+ACMcpZg5mj+RIuay5Mm7XIZPlZlbpgQ6qjT+ynLMWtDAf0H3JdVtzFLBIzxsf6I
         su1qR5qU9N0mnnm1G07a64LboBWIHa2LAyw+N1AxXpWRzrmOjnUVbuItrYtgAD1dEPdo
         qcIypaAkECAUvel1mpMW6QOZtm1fMwACSkwyqzCig1SnN4TayCBYq9BWS3gTR9yfgbPy
         TOn6fCyZ6Sw5siLlCLoGYnrpCttv6JvlkBnbsSIjIwyd0Uu+xzV6Rdn3J295Ly+XTDBC
         A91F3MxapQHlmLly0v70EpxOq120rVGCk9eKzJN2nVtnOV/mNDy688OxkaLy83Zx586v
         zB1A==
X-Forwarded-Encrypted: i=1; AJvYcCVjHa0G3iUngSODAXvV0Wb5fQ5zk0vMy9T96QKNtrbccnnloaU0zF8qY2JSm+rqwNaqOS51hp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCLC0s3sAjXyXafgiyHsd+xGoHqQjgryl0f/Pxg2Wej82jm7MU
	6Tmvztt7w8uRouFufAtfqvZchv9/HmoudhhsXnAez07cRGH+74P8JXWN
X-Gm-Gg: AZuq6aJzT138E5UPJgKrpB4AlLQdivDesWHoOb7LbfUB40+OYZ7grzU0ya4DTxDOfQy
	S6Z7NibveJrLa/PzIOzyOQB+8Uu3tUXkUTtSYrMVoG0TTkVMWwahFuMebkjhvFNDDAbdBTTG2om
	M68ohkWdlYYvdZAYrx/Neby0mi/rni8PKXOgpbxdWBof4S0T0y/xjjMWfL09cVWRxVvxdCXiif+
	o7gQfei3DFq+M/3vDQoaESRIoqnPFiTj6X/OsD7Vmggq7jocpcHL0IiZjfbqSyUQhN/r1alq/24
	SIVnvIs8NA/qKu6hQGJwLqcE3fAkPkl8sozd4JD1vp6hdSi3uvoLdnBfEtsKuTVFh558RYl3dZ0
	dxwYlaMS4ASzeVOYxj4+TPAnMYbvUgywimpungW0yJGNqfFhNLOEn5QQaM5A2Rf0SStRynX36Bs
	9WuqzqcZ9E6ghKtU1+SsgR1EJXmfUiM/tIg6B5OyD9Es/8mZZwwsdVpXbow4VCavSD
X-Received: by 2002:a05:7022:2393:b0:127:369e:5d54 with SMTP id a92af1059eb24-12741b71059mr5293643c88.13.1771374668482;
        Tue, 17 Feb 2026 16:31:08 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:968c:f102:3683:408a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb66bd17sm17035569eec.28.2026.02.17.16.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 16:31:08 -0800 (PST)
Date: Tue, 17 Feb 2026 16:31:05 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@kernel.org>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: swnode: restore the
 swnode-name-against-chip-label matching
Message-ID: <aZUIFiOYt6GOlDQx@google.com>
References: <20260211085313.16792-1-bartosz.golaszewski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211085313.16792-1-bartosz.golaszewski@oss.qualcomm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217200-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 81C0615248B
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 09:53:13AM +0100, Bartosz Golaszewski wrote:
> Using the remote firmware node for software node lookup is the right
> thing to do. The GPIO controller we want to resolve should have the
> software node we scooped out of the reference attached to it. However,
> there are existing users who abuse the software node API by creating
> dummy swnodes whose name is set to the expected label string of the GPIO
> controller whose pins they want to control and use them in their local
> swnode references as GPIO properties.
> 
> This used to work when we compared the software node's name to the
> chip's label. When we switched to using a real fwnode lookup, these
> users broke down because the firmware nodes in question were never
> attached to the controllers they were looking for.
> 
> Restore the label matching as a fallback to fix the broken users but add
> a big FIXME urging for a better solution.
> 
> Cc: stable@vger.kernel.org # v6.18, v6.19
> Fixes: 216c12047571 ("gpio: swnode: allow referencing GPIO chips by firmware nodes")
> Link: https://lore.kernel.org/all/aYkdKfP5fg6iywgr@jekhomev/
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Changes in v2:
> - check if gdev_node and gdev_node->name are not NULL before trying to
>   match the label (Hans & Dan)
> - use the right link
> - collect tags
> 
>  drivers/gpio/gpiolib-swnode.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
> index 21478b45c127d..0d7f3f09a0b4b 100644
> --- a/drivers/gpio/gpiolib-swnode.c
> +++ b/drivers/gpio/gpiolib-swnode.c
> @@ -42,6 +42,25 @@ static struct gpio_device *swnode_get_gpio_device(struct fwnode_handle *fwnode)
>  
>  fwnode_lookup:
>  	gdev = gpio_device_find_by_fwnode(fwnode);

By the way, should we extend gpio_device_find_by_fwnode() to use both
primary and secondary nodes?

Thanks.

-- 
Dmitry

