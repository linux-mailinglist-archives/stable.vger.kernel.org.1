Return-Path: <stable+bounces-230978-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJZJOTiQyWl3zQUAu9opvQ
	(envelope-from <stable+bounces-230978-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 22:48:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 587C4354106
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 22:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0709301185A
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0370E3876B3;
	Sun, 29 Mar 2026 20:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=marvin24@gmx.de header.b="aCFNwrY8"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49B12DEA61;
	Sun, 29 Mar 2026 20:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774817308; cv=none; b=HrbvfxlmuZts9dEFPxa7Tazoy//FphNbWtX98yTp/V6hiRzCuk7Qw4dfXONg6Djxdtp1Fc0HuDVNXjeLV7v8yP7zOvoJwmoCLfbycQ37LQKj6zl+f3i0/61L0NuTRgs0nxM1tRRVFoQH6VZQn6JLIu8q1GbZUlQ83rdDbhQhg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774817308; c=relaxed/simple;
	bh=FRfIclqbGAMKvlimIjgixptcPvX/DfRkYbvjBjyjlr4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=eYGtf9AdsRSGXmMwGR5QjAnWw2b0R69JGoIqWUyh6eBxvSYnDrhNbDgSme8h/4sAqFl60wPNJmQxAtddOZk8wtHnjhRd0uC7x4nrossvE+FIqiE1SeACfmXxhQXaa0TG3oICX0mBhfVlg2df29F2YHKnz+F/LN9wCtFW0KOrTzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=marvin24@gmx.de header.b=aCFNwrY8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1774817304; x=1775422104; i=marvin24@gmx.de;
	bh=OtNcuLB3T8KYnUkH14k7NMFCJItLMiwi7/E76QEkjKQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aCFNwrY8LXCJ42ZkBOKcpimcPi9vyD0F28U1EXv0Q3VbQlvNqAuRSpBJi250USxz
	 cv4diT6xM4sGN8UEK6LcyasvAYFuV6XEwSqUAE16mX58Li4wJeQswjhS+3mdkNUpS
	 2NPETT2LkfUTPlx5t604ErZdioGpIs3pFKjlphJntpMCIcjSz6grf+UZwfMpS5w2s
	 DXZR4nZCfuqHZRMyHotG0HU0Ykk7FuWlUqdkXhTvmwB8i92RiCf/pCm9nRSQpCoE8
	 giD0lXcZ8C8iw+4pQ99FYGThp9B/Z7dj39KoIu42AJOG0kyaZsT4u4hMk00/pAN7V
	 krV8TCpXCjunmX/9Ow==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1vzdcd30tj-00IwUc; Sun, 29
 Mar 2026 22:48:24 +0200
Date: Sun, 29 Mar 2026 22:48:24 +0200 (CEST)
From: Marc Dietrich <marvin24@gmx.de>
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
cc: ac100@lists.launchpad.net, linux-tegra@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] staging: nvec: validate battery response length before
 memcpy
In-Reply-To: <20260324195041.38343-1-sebasjosue84@gmail.com>
Message-ID: <b23eb8ca-ef38-6288-0891-fe91148e11cd@gmx.de>
References: <20260324195041.38343-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Provags-ID: V03:K1:WKfW4+YMLfLZLHNi/WHZT3MAY3/XWAogRELxput+1HFw+zVNheI
 IJH23CedrMEOVA55G5uYM/Z167aD2oKIwwYupbc4pOYhzT5KyRLFsMDzImQXOwqekBQSkEk
 WKQhOBtmTxJdjxO6gABVqEgBkZemamQkZuBPE6ibMuAIfRse9uVxLt2YQ8Drr2kbA1IxqaV
 yU7ndsD598z5EdU+crayg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TWBZMhMQbsw=;XJIWqFlxuCDgEbE/N3DufyuaTYF
 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
 6HyDvHPi8m6
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.de,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.de:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230978-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marvin24@gmx.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:dkim,gmx.de:email,gmx.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 587C4354106
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Sebastian,

On Tue, 24 Mar 2026, Sebastian Josue Alba Vives wrote:

> In nvec_power_notifier(), the response length from the embedded
> controller is used directly as the size argument to memcpy() when
> copying battery manufacturer, model, and type strings. The
> destination buffers (bat_manu, bat_model, bat_type) are fixed at 30
> bytes, but res->length is a u8 that can be up to 255, allowing a
> heap buffer overflow.
>
> Additionally, if res->length is less than 2, the subtraction
> res->length - 2 wraps around as an unsigned value, resulting in a
> large copy that corrupts kernel heap memory.
>
> Add bounds checks before each memcpy to ensure the copy length does
> not exceed the destination buffer size, and that res->length is at
> least 2 to prevent unsigned integer underflow.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> ---
> drivers/staging/nvec/nvec_power.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
> diff --git a/drivers/staging/nvec/nvec_power.c b/drivers/staging/nvec/nv=
ec_power.c
> index 2faab9fde..29beef0a7 100644
> --- a/drivers/staging/nvec/nvec_power.c
> +++ b/drivers/staging/nvec/nvec_power.c
> @@ -193,14 +193,20 @@ static int nvec_power_bat_notifier(struct notifier=
_block *nb,
> 		power->bat_temperature =3D res->plu - 2732;
> 		break;
> 	case MANUFACTURER:
> +		if (res->length < 2 || res->length - 2 > sizeof(power->bat_manu) - 1)
> +			break;

I think this check is a valid one, even if unlikely to fail. Could be a
bit nicer by replacing sizeof() with a contant and storing res->length-2=
=20
to some variable, but I guess that's a matter of taste.

Tested-by: Marc Dietrich <marvin24@gmx.de>

Thanks,

Marc

> 		memcpy(power->bat_manu, &res->plc, res->length - 2);
> 		power->bat_manu[res->length - 2] =3D '\0';
> 		break;
> 	case MODEL:
> +		if (res->length < 2 || res->length - 2 > sizeof(power->bat_model) - 1=
)
> +			break;
> 		memcpy(power->bat_model, &res->plc, res->length - 2);
> 		power->bat_model[res->length - 2] =3D '\0';
> 		break;
> 	case TYPE:
> +		if (res->length < 2 || res->length - 2 > sizeof(power->bat_type) - 1)
> +			break;
> 		memcpy(power->bat_type, &res->plc, res->length - 2);
> 		power->bat_type[res->length - 2] =3D '\0';
> 		/*
> --=20
> 2.43.0
>
>

