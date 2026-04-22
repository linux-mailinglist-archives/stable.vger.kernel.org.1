Return-Path: <stable+bounces-240395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDIFNc1O6WlWXgIAu9opvQ
	(envelope-from <stable+bounces-240395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 00:42:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0E644B4E5
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 00:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59DF63069FFC
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 22:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79F536E473;
	Wed, 22 Apr 2026 22:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="op0PZ47n"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080CA2F0C48
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776897726; cv=none; b=PyQEpXHwYtYDke/t84g5pk6Qq/aOuDIxP5I//vJkLOvbbo+QdgGrafhLx4oB3sWlXMRdr6uhXLeLCcKQazQ2+2txdui5zWd21mOeNtP6t0XDC+efsIfDxOwnHffIsy2zWpkDBXqMaX7mzAa/e1hIEusiD6IYRtBmMhiF2QafMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776897726; c=relaxed/simple;
	bh=bgCsvL7f5aJzYJc5+W+nNRwso8wLu2KlHbO2ZFM+rVU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PBiWPTqEUNv7Kt1FuBo4xCdULqo3Ny270pHanz8aR2yK8m8sSpCr5Ek/VT9HvSrAhTKeeHQ4mp9nY1uqlUv21Sb8mtmeLxo0x2C45HtSNg7QqXqsfeYKb8BE5+cQozhUri8vJRCCQNJ5YcM2417rNc8B7SrxI5m77BBar4hRRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=op0PZ47n; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7AD363FEB1
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 22:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776897721;
	bh=W1xzzRlJ8xgOU4M+Kcr2oZKhnhQvcX7vIzo1PxDipgw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=op0PZ47n0FGMKE7/is2ik+DhpiY4U+vVjCKrtwByTA2vwVvdBkWjH3A2ythJUfbwm
	 WWzmRfZzx/Y9xTxJ7aZFrq0a+19CLvEgpdzuH/joqXR5Qa7kZNX67Kk6vZQncvHGOk
	 AQ4kG1uhbO4y3+gD6t2Spv7AGI/p7xRyBfr4h/mAdqm5dOnOOIJgPhX6YbXf6F5KFQ
	 BLhxuHtl0HUSvXU80FO0PP2MAZi8TcEKP54RRlyIZT2OdS1dkm/02j0EH/zU/KKQIp
	 b4a6o8GM5GamF9b/2UjNa5yymmlXorqtc36OiCRbseEnz6q9Q+HK4qYu/NIDt7qf/4
	 8d15XsQyQ//0LfmLDp/1IgA9C6lRUE8KDlct6fhiQ6yG3zTg4nIXiFzaEFAbwTiFo7
	 qsDQDDgmERraIXJnZXAYPJUdvPyviGko4fOHUmFRcRNck36WvL8xZQ4QTotA/vsHGB
	 LaSL0UOLQyfwNdQBJ5IhR0vFddbUkZWt0qTXkhM4V0SjoD7gGmdPezmiy6qh+iUntQ
	 s7LQ2gmyiCId0qUyT/lAL/UPqoy7v4eLHfL3BnnCUJm116eOfrS63046PxFIFoPis0
	 1buOm5EQ0mrAij3Z4LX/9DHVXLqcpybGT0o3LhtBvh9r2N9uq4cAy4lDZZmo59tpQf
	 rXjl4Jj0zsylMpTT0kgtq4yU=
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-612ef4e6c54so10323029137.2
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 15:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776897720; x=1777502520;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1xzzRlJ8xgOU4M+Kcr2oZKhnhQvcX7vIzo1PxDipgw=;
        b=VaEn9Wyx+/0Mul0EXVr5fOxUYpya+rZziDotrdLGHxkWLQOlynqoM/j14WFrJBYxW0
         MF6TA2WtE08v42Q3/Vv1jOAdZXXwcJ0RLyvvnFzcKYj5DHugQEgR21J2gOXDyWI76sAg
         TLHzCDK7a++sqDeTONiFq3wBqwB4xUyKNL9D79hAYXKsd3isUFdMPaikDMGpebMhuFF3
         ZDhhWAdkoWdY69eYJHhHh3ypzLtFC4JsGqEEi+Z5c4u4r5rw33TJweugNPzT2Hcyuc1K
         IBcKkrNJnwIkj3NfffYdWCQUNmbFFnxp2Irx5lezkKnT/JojoA6QU/CkUmTLUEza8Zo3
         ODoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8f0nw4HnEz63rS8kbaUf27HF1KQ2fqLEzcbaUULWIiiajQudiw7LKk7k/+rd9CRihoI7SSNH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdyPg7wHqwu8rqYSO3VgWtHOsjmsUN4xbovcFLuKhZwXEY5W1n
	6+oZ2tb5hYLLZFPe6/4YEHWnSZGLm0Sshi1/V4BjcdtSbYebcEOUSsti5IzLARwTzVkDBHRK+IJ
	9JqbslViaTWLYnp6pwLFdCRzaYgIBi1tRCRZwtAIRShEb26bK3G4RAQ15arVsh9owz8kWcqPaFw
	==
X-Gm-Gg: AeBDietNcywBhMcRq0BVPkGPIagKQTSOw9PxY0284oxEBKkldlkY/eqiZsbmFLgPqIz
	5Hgo3z+ZQHcQZTql4wW5tMU0truZAtmZ0C0uOBR3fT/QTu1l2UGnXiv130M5ssTjYN421F0/Iat
	ClCQ3TO/aPUALc61i1UTTMUkBYGMBRaAEK6OqmOaxzF+toLc1rSJrBrPy+oWhr2yZdJj8Gq7y4k
	j9GFIP5hoDIYjyNAU32oSIxhGl3Y9fBl11oelNuSoqlAMSbQgg3yoqfNjpiWij6VcQIsUtS9R8J
	BVQu0kMzY+yh6Z1eZxye676lAE8YjR4U8DaorB0RsU+GM1rWMeNMq0ZDkxoxvKwZ5Bd7hfo5q2g
	YRa54GHxg/WxLu9/4+sR6G3ZRUv23UepSIdbuW1fQRqJsBqhZHMk5fmRV4F7c6cCPZTmSXlJO/I
	jTpeNV
X-Received: by 2002:a05:6102:d93:b0:5ff:c64d:2283 with SMTP id ada2fe7eead31-616f7c5d67amr13534274137.30.1776897720239;
        Wed, 22 Apr 2026 15:42:00 -0700 (PDT)
X-Received: by 2002:a05:6102:d93:b0:5ff:c64d:2283 with SMTP id ada2fe7eead31-616f7c5d67amr13534257137.30.1776897719832;
        Wed, 22 Apr 2026 15:41:59 -0700 (PDT)
Received: from [192.168.0.106] ([187.95.109.208])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9589097ec5csm8575275241.4.2026.04.22.15.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:41:59 -0700 (PDT)
Message-ID: <86c56735a80e98c23dd0e4f894d424f83d457026.camel@canonical.com>
Subject: Re: [apparmor] [PATCH RESEND] apparmor: Fix string overrun due to
 missing termination
From: Georgia Garcia <georgia.garcia@canonical.com>
To: Daniel J Blueman <daniel@quora.org>, John Johansen
 <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Thorsten
 Blum <thorsten.blum@linux.dev>, apparmor@lists.ubuntu.com, 
 linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Wed, 22 Apr 2026 19:41:42 -0300
In-Reply-To: <20260327115833.7572-1-daniel@quora.org>
References: <20260327115833.7572-1-daniel@quora.org>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_FROM(0.00)[bounces-240395-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[georgia.garcia@canonical.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,canonical.com:dkim,canonical.com:mid]
X-Rspamd-Queue-Id: 4B0E644B4E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Fri, 2026-03-27 at 19:58 +0800, Daniel J Blueman wrote:
> This was introduced by previous incorrect conversion from strcpy(). Fix i=
t
> by adding the missing terminator.
>=20

Looks good to me,

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel J Blueman <daniel@quora.org>
> Fixes: 93d4dbdc8da0 ("apparmor: Replace deprecated strcpy in d_namespace_=
path")
> ---
> =C2=A0security/apparmor/path.c | 8 +++++---
> =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/security/apparmor/path.c b/security/apparmor/path.c
> index 65a0ca5cc1bd..2494e8101538 100644
> --- a/security/apparmor/path.c
> +++ b/security/apparmor/path.c
> @@ -164,14 +164,16 @@ static int d_namespace_path(const struct path *path=
, char *buf, char **name,
> =C2=A0	}
> =C2=A0
> =C2=A0out:
> -	/* Append "/" to directory paths, except for root "/" which
> -	 * already ends in a slash.
> +	/* Append "/" to directory paths and reterminate string, except for
> +	 * root "/" which already ends in a slash.
> =C2=A0	 */
> =C2=A0	if (!error && isdir) {
> =C2=A0		bool is_root =3D (*name)[0] =3D=3D '/' && (*name)[1] =3D=3D '\0';
> =C2=A0
> -		if (!is_root)
> +		if (!is_root) {
> =C2=A0			buf[aa_g_path_max - 2] =3D '/';
> +			buf[aa_g_path_max - 1] =3D '\0';
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	return error;
> --
> 2.53.0


