Return-Path: <stable+bounces-240345-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI4ID6/n6GkHRQIAu9opvQ
	(envelope-from <stable+bounces-240345-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:22:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DAE447D72
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B63730730AD
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC0E331203;
	Wed, 22 Apr 2026 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRJjCFnm"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381F132470F
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776870948; cv=pass; b=CCwgp73ToxSN3XpiTDtC51WbukaIHUZ4Pknma0sQulu2D+VLy2wfqDQlJ8UuugxgdMjJvJbnR2Z33dDdnIFP+EGP6gX5J6BCldwXKmxQxJqNHvFMg6unwDcyRz+UZZt0gZoHOeQ3tmwuE8UQbXkS3ubPEL241uTa06Ps7nDqEIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776870948; c=relaxed/simple;
	bh=Z/UXy/HQejHivz0qFPdoyrhBsrpSw7dRhbRuXv6gPgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fK9EK6fI3lU7DNFMHXist7pbboMS2BGkBG6ji5IeKHpiln8h60bWnMhosLN4BD/1gi4OZxWxhio58Wa4VYSC8BrFcJ1cCcDOaYSrMjzAwBL6R8aJheXGyozsCHHnTN6FGJNq9GRAFjFrZysOtTK+gwLoh8ehKhOt/Iqnmom5/9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRJjCFnm; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64eaf8aa893so4558057d50.3
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 08:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776870945; cv=none;
        d=google.com; s=arc-20240605;
        b=cMwABnE5hT3zuFssLA2eKjtLdUe7t37tQO06UiJaMpAu+xCqJUEvhZrGgfLwh85cpf
         PSiIcPebiuOe0XZqKUTcKtz9t9A/Qj6dHVzhsaouo+h+/sMVVu2a+mTAQl+wHN7cm+vW
         kOj3QIpRp5S5XzCx2HO1FpM6XX843T99ztk2ZDxrH6q+GYLR6ieFf73blIn1SdSbpwiG
         2C4wtq/aZ7ikUbbYoysMaLnDqwBnTfcuX5BJBRljaHuqPJu3RANVOvNBTuRVqSj06FtM
         L7DDtT9ROyqzdvSgnVazvUZbtz6L+0ZfBjlBSj6NQ7DlwQlYAGoGbI59U7L9Ld7tpw3d
         f7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1PoAh/J3nj3CDSZmBmeHpN698NbI2/7cl+VxqRpHq6o=;
        fh=qZe4LIxEzicz8/fy5HCKRbCSnFCGz424A3+M+Tnj694=;
        b=dCAfew+u6EJsF+FdejbgzUC8XBKMMpA29HQ3DQ4EvOr8tvVFS+3llmg/BEq+GqvG7P
         CY4EzXGXOd2vaCLLwHLxJj7B9sdclTJlfHDvQAj7COnc/8LdMkF7Vs9G5ziqhWwg/Vhp
         OmzVkHqGQa5JUKPS+zIOB9q0XB4BEeojY9HZc6NUtBYLa16lVkhBsb2Z9RJttWo29Pio
         uNCRLnbmt12K5mEOMrIvLO77iUeHNXhhZ4HMJehyXekmSFW8W/Udn8V7FjmC5fMXNgDN
         8CddScqla09WXhi6kQ0K+6F6nmk1vS9DyXdhUQK3pWMM3fDENabo6ILdjlLni99tejie
         fdHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776870945; x=1777475745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PoAh/J3nj3CDSZmBmeHpN698NbI2/7cl+VxqRpHq6o=;
        b=YRJjCFnmAl7tdC2bp8YBe547o0qy/eN4b3e06jSOUXurz2mryxUFz7/iXAF5DYsaKo
         fZGtBM7eynaGNLijPi2uDW+fCHjt0y05jlqBikaMu9rXrqFOyuhYSDTkGdtHAWiV7OAm
         FjABHp3BcoghRDGRxfTIOM1mUMNkugc+mr7ghY6C4tjKHjPp9bXYFb5NWtYdsXGDR2LB
         ndAjCBDj0NedVq8dYIBAiPz20zH3xE+iH30qWyZN8M7V1yI+YagI0KojRs9oeO36GvAU
         2d9YmyuFd+vSkcKDwxo6hdGuZSoPeqruMBSTeIGyrPhg47e+lclOZk9UrqeXT1N4PjfG
         f0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776870945; x=1777475745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1PoAh/J3nj3CDSZmBmeHpN698NbI2/7cl+VxqRpHq6o=;
        b=s6Wyxh1krBZjCbIP19jLLHbDgr5Yw2HI74e7PHVVOvOEZ0slfAVKTPs7xJxfVIdeMC
         Y4mqEPWiOKEDIdHiCdTa4OVRSJPTYi3TXZVDEisApbFxm6ZQIOtPaeHMvbIpG+SfAapi
         NtrDeJG1EckY53eI+hq8eP6dcgD8YJ6HLQKPfbnJYVdVZdNAJLcSLxmHzQifJ1FteWxD
         1y6Jgw5etoUo0byebd2zvO+52l0WxvcTucgpwGE3OPD7DEl9Jto2vDMeE/qChJh7hjBR
         FUFtAU/jhHKasXH6koX8PtfRRk2QOqvijI1fRus4+hmAVZcYDbX/n5pXfeZ2azRM+k1O
         NkNw==
X-Forwarded-Encrypted: i=1; AFNElJ+uzwIVBlKKvxSLd0E8MTH59ykDoFS9G57l1EEygeJmDsqlxJfaWd6ZQTKGJGq+xelrDSAZnRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvG4R0iu10A8Ju/r9Cg53TB11ppbTl77v1k8N7HXbHsW1R3qH5
	ajljAX4iiEtv3ycFF+Q5FMnvBjuU7VgMVyDGakSiiKh9p8eiO2kk95Ie+CZJTojtCaCCml6ubql
	LiIzTVNdi0lYo/twlcPHzDjqkpQ9SQGU=
X-Gm-Gg: AeBDieu98fkoKxX0JEkIzLTz9OFEbX0HWbhvG6Vi1hL0GtT5TYNuMB5+yUrKtT68WhI
	uH0Ch2EVXq2xNC97ZMyr6asv5QgTENqzWgt9xbXvASXdx824Tp9DeLMASC6vkis2Ey3FhkxK7Iq
	IUEoNdUWebRfOAz4wl6miuGHej2348DbewjSYFNi73mZk4K2p+R31i7oqGg/ZlQERFIuWWUoOWL
	rsHnQu6sXqAcjxbxDAK04gHXvO0eM9qEaPNUs9IkYABZMCH276SeKwxmavZefDIz76m+eDW8PUn
	lmH6xcG//zacNR8m7h38ajKyjFjKIvhb6icxl2xlF7tWFRgly7uT0stam+USsUagyl60QkgTwjf
	jMKo8
X-Received: by 2002:a05:690e:4802:b0:651:ba23:12 with SMTP id
 956f58d0204a3-65310b44a57mr14929239d50.53.1776870944393; Wed, 22 Apr 2026
 08:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417073446.95494-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260417073446.95494-1-pengpeng@iscas.ac.cn>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 22 Apr 2026 11:15:31 -0400
X-Gm-Features: AQROBzDEtLlLfuCjZiQcVuH0JEejW4K3jnT80IzUIwg18PITEP0TJQc8uuWiE6w
Message-ID: <CABBYNZLBGVon-4R=eW6NwuhGqfQ0E37BC+054rVhoeaiMP0sbw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: require a credit byte before consuming it
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Marcel Holtmann <marcel@holtmann.org>, Kees Cook <kees@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Bastien Nocera <hadess@hadess.net>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240345-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 98DAE447D72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Pengpeng,

On Fri, Apr 17, 2026 at 3:35=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> rfcomm_recv_data() treats the first payload byte as a credit field when
> the UIH frame carries PF and credit-based flow control is enabled.
>
> After the header has been stripped, the code does not re-check that the
> frame still has at least one payload byte before dereferencing skb->data.
> A malformed short frame can therefore trigger an out-of-bounds read.
>
> Drop the frame if the optional credit byte is not present.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  net/bluetooth/rfcomm/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index 611a9a94151e..964a78d473cc 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1715,6 +1715,9 @@ static int rfcomm_recv_data(struct rfcomm_session *=
s, u8 dlci, int pf, struct sk
>         }
>
>         if (pf && d->cfc) {
> +               if (!skb->len)
> +                       goto drop;

We can probably use skb_pull_data below, which checks skb->len.

>                 u8 credits =3D *(u8 *) skb->data; skb_pull(skb, 1);
>
>                 d->tx_credits +=3D credits;
> --
> 2.50.1 (Apple Git-155)
>


--=20
Luiz Augusto von Dentz

