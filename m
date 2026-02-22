Return-Path: <stable+bounces-217674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E5/LTs9m2lvwgMAu9opvQ
	(envelope-from <stable+bounces-217674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 18:30:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3606516FEBE
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 18:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 439F7300B870
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 17:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADE4350A3D;
	Sun, 22 Feb 2026 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCjRzzx6"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268192B9BA
	for <stable@vger.kernel.org>; Sun, 22 Feb 2026 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771781429; cv=pass; b=gS4b+JlsKDc/xYgq3lkQFXmHt2mg/Pgu3IUI8dxbAZtLu7XRUvVgrwp9dpjzuTtw12tlyvO+9giWN6/5xdbISP21Aw1L2xMaqilXK4ai4BLtvO0Q77cPVera8dkwECm2/qlfgOzJTFOeLUbYJedCTk+lYOosxvybgc5iSYJ9myA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771781429; c=relaxed/simple;
	bh=WuQdtA91bXirdlbXnxD3/MRjhUKTcOvVKRMaaSclhvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1dgYretxt2PX7oYf9YYLTf89MHLVHCbXju5huYy9wUpctJecbCydq0Eal7oHgqjammgO61EluveiPIT6PJt8Tj+VkFH1u3pOqpddrwfB7Zs+6Ewmq5/AxnO0j11ZjqOIotaqkM50f63D6KnYu054dCLiZyItMms7UYpWyp6pWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCjRzzx6; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794cc7e06f0so1335367b3.2
        for <stable@vger.kernel.org>; Sun, 22 Feb 2026 09:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771781427; cv=none;
        d=google.com; s=arc-20240605;
        b=bQs/FsiBfBNpFa8XeECWAHw7/nLscHl+qRXxF4hSOuK8GOx+/6ewPAQulepoU4bHRH
         ISY3tH5GbFY5EeSH969hXj2LI0IGeFyvt7O6L1DRu84ml0Zlxj7rbdKu04tzBsaNBnr3
         oaM1UQmpZLIzMsvggHgqRXNZbNExOqAPmEixxYJM8b0OKGfx3E7m2uc3r66IP2rWHgCV
         6bLBRo0HV+8AuApA3ATXkl2CuMnSVQq+Yhun+GkrseNIYgD7gwBx5nxyY0PF+zKoBQbz
         poLKfcKTcLB6JsxaNtrZ9GAPakc4Hjv1vkxyUdyNjzUeKLqckbq+1vSx48gbdbOiXHJf
         KQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BnmkLIgWSk18hKSD8wtaKdnDH56mNXzkJ0gXdtf3O2E=;
        fh=pxPwuqQ202qnxPyjQZV0ZVEVT49aCBBrUxhtXNMQuCE=;
        b=UkGxDTI3EKtiMYM2BadsJ1ba1RWlnpSX4u6H8b1s/6rbOZ5ILZfOJQPVljSALV6k7D
         gnnylQd824BO0CG5xaw4mq13fGq4JXXhEYCZsmqyakREPgwWEgkzO3l88zoYTIGN59cr
         Xr0ezsr9hFqJ3cMiTLTq/NjzXshc7d7ad5onPP5OqfNjJDlpl9TYOdyLUIYYncgAntre
         89GXWdldNgoV9UBTqZ9F9QXbpt9e4FH5L6GaI7hwTcbpUHoClo0e9o+kvzknYfdXA060
         ADvFxjOEVf4G3HAapBQ9bNRi2c2oot/OHZ6a4xVugeojS+/e5X5mwkyANGxR5kGos0nw
         3toQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771781427; x=1772386227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnmkLIgWSk18hKSD8wtaKdnDH56mNXzkJ0gXdtf3O2E=;
        b=WCjRzzx6KfSJqqYW83VzdtyLvMYdW8PsT/ow9+r0LzfRGru9LbKcLTrU/2TciFiB8m
         rYNQehnqqVCKN5zafnjuSdNIPlXxusR1AGfr06uY5f8wO2H0vE77fc2XuWODOih+N/8b
         /YKIRGhuyl5+IoLxLicTi0QTEQleXjoIWT+Db35hsYctHSqNdEm+UQe7wE7EE5v+d/yX
         NUPEilzve142qk8qybCt0JmqufMGJDvs74IrsbJYiTrvFayULdcJg0YAeCM3b8ors1K+
         f17gR7/fn/EsHKzt/thiLr94RxqeJDx9jO4SBaYMpwmRB6iFoyNisO3PF/b/yzmDA+6l
         IzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771781427; x=1772386227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BnmkLIgWSk18hKSD8wtaKdnDH56mNXzkJ0gXdtf3O2E=;
        b=IT6w0r/pbeN6yb9htM3IbA7cjes8BOFxsFDSw3aWm0rCIK+w5VwwtVxbVelD7WuY3S
         r/JrkrmimMp9mdpaN0/u8UxcZN+gQNdQ83dihLVmIxbfeQBjwR5irQ8xKc4cap5X8laY
         ystKE1+xsNBBws8y3hrCFlcsAbXjYItqGNI7KqIHGZmV+tt9xs4KyFV49NEnPhdhP0Es
         GPCgUrTmcPgs5l0C0ioQvFyMWzBeshTIYdwHrtui3v1IXm/0CXRIZkJni4Rof4/4YfAO
         5shcbOsn/ciRsP+p0s+rBLaKMtGiZxouK5Yme6b3FF8HL1EOpmOrmem0dtTEfZRe+O3Q
         /kcw==
X-Forwarded-Encrypted: i=1; AJvYcCXai5mBy59gRLHA932UcaX1LoT1YaWKdiZIXhCJyvQ0gkwU0rcZNWhSnibKHi5ptjnLBc2Xz9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMFctfL+yx7bRB3zyAnummNHq8f1PT5BSP/2NyA+l1yMte/F2
	rGS4vRsItqBH8VaGHivuPxQw7vOv2Gg4KCSRkzg8ZHwlyBrLkZJgHf/qvO6Bd06SbHG5crOAy6e
	v9rzxA9g5rIeGfEqg3UFO6RYEaEli04g=
X-Gm-Gg: AZuq6aIG2p6SngQzLVgOwmul+lci9QQKW27A36N4ECNFZQpic5W3ZkGchYZMGW/X0fV
	1jGuAfrv0r1c3tPEIS9izdVP9NPRNj78XBibrgpv3mQKcJPAAZ5XjVbH76fdmPxpazarjXKIP28
	ZpsTpAtSuv/fqVc6j04pnnd0WbVBK+6FRQjsJLqDXnwWEqPCxhkHnU4K1UAhbFoOWmnAPsUk4OV
	WBqQmMusGrmDUj4ZuLnycWTEkdClfOGvsYPaF7W81D/7Pw2LNcj7rQckWgWb/yjfuLUycELo87b
	Z49Y
X-Received: by 2002:a05:690c:93:b0:797:ab72:628f with SMTP id
 00721157ae682-79828fa2ab5mr44574817b3.4.1771781427236; Sun, 22 Feb 2026
 09:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220133135.1122081-2-thorsten.blum@linux.dev>
In-Reply-To: <20260220133135.1122081-2-thorsten.blum@linux.dev>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 22 Feb 2026 18:29:51 +0100
X-Gm-Features: AaiRm50kypTpMDY3ZXdNnlUeMETOr3yH_tAg04sHJcHrEEiY_Yo7xkfaj11LYrM
Message-ID: <CAFXKEHY40ybHVbWLWPjOR_wuv5sV9YYXyum6nTT7LHG+irBpUw@mail.gmail.com>
Subject: Re: [PATCH] crypto: atmel-sha204a - Fix uninitialized data access on
 OTP read error
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	stable@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-217674-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrubusch@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,cmd.data:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3606516FEBE
X-Rspamd-Action: no action

Hi Thorsten! So this one was tested on your hardware?

Wouldn't it make more sense to squash this with the patch before: 'Fix
error codes in OTP reads' (which IMHO actually fixes mainly the bounds
check)? This on it's own I'd consider rather a refac than "Fixes".

On Fri, Feb 20, 2026 at 2:32=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Return early if atmel_i2c_send_receive() fails to avoid checking
> potentially uninitialized data in 'cmd.data'.
>
> Cc: stable@vger.kernel.org
> Fixes: e05ce444e9e5 ("crypto: atmel-sha204a - add reading from otp zone")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/atmel-sha204a.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204=
a.c
> index 0fcf4a39de27..f4a04b297257 100644
> --- a/drivers/crypto/atmel-sha204a.c
> +++ b/drivers/crypto/atmel-sha204a.c
> @@ -103,6 +103,10 @@ static int atmel_sha204a_otp_read(struct i2c_client =
*client, u16 addr, u8 *otp)
>         }
>
>         ret =3D atmel_i2c_send_receive(client, &cmd);
> +       if (ret < 0) {
> +               dev_err(&client->dev, "failed to read otp at %04X\n", add=
r);
> +               return ret;
> +       }
>
>         if (cmd.data[0] =3D=3D 0xff) {
>                 dev_err(&client->dev, "failed, device not ready\n");
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>

