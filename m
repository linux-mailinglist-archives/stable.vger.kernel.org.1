Return-Path: <stable+bounces-211539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNWXAsQwd2lVdAEAu9opvQ
	(envelope-from <stable+bounces-211539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 10:15:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D485E67
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 10:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B14BA30137BA
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF6B3002B3;
	Mon, 26 Jan 2026 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="mjlQTbN4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4061244694
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418769; cv=pass; b=PHLubuxLh57VWObrZ3hZXGulKa8MkcMpXYB8Zk7Emlxo/TGjUbShtVEiKouP1Dr1eJHYEdAa7a9/C1ExmX50TJMh+GPO9WmGCKtX/c/yUsug9bVhPDkPojXY8B9VVe4QKpNSqYTPipblpmPiG32j3A82PpVg2+9htKIf+MI+ZsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418769; c=relaxed/simple;
	bh=vniLXzKHNspJD1FrLmGqcx0OX77epShC8YHjddOyZr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iXWZHJRII0j4P7jbVG77RoJgv0WkgNAdFBUEXX616YeHrx0lJ4WuBhuaQhcf7KlMZ2KaHLwDyjveV8pSYPYMZeEdC0OC5VY8SeWiOIzR2UMNHW9mPS2n9DDoOvTHFURNLFdgULRGcODkdQ0VhqZxfxbSsOlq82KhfpPr+MhMpLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=mjlQTbN4; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64b9cb94ff5so5871154a12.2
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 01:12:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769418766; cv=none;
        d=google.com; s=arc-20240605;
        b=BrjpyMD8SC9JEzBGygL0hMdMpSjjAeuo+wX4LB8MWye0INJtJQdAbL4X2Df3n2X1sY
         GY0VFg1Exg3DD108VvfK5dSt65FrA68qInrbD/ufIKAvyRegfWiDN8WiqfQxXIWx+IXY
         Lloewuqami6ElAEnjnqea9wHafXH7V2Hfgs7fuL997KdTzDrRY6yd45839evnRm8RcPZ
         2gJGHy5bh+/xPBzNADb/yDtJIe5l9gOMxIVTkZuohs8n/I/3qt3Uga/FMpZKucIRmTtw
         DFXCMg3P/qmfCaj/FHv7in0pwApy2itS0Ji/UC7bGF03omWmOrY9L005u7x7Mcrcwhl3
         s/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZ0wRjpBkARHUdg5AXc4jIF+w1YP8Cq41/gPWjBo+gg=;
        fh=Gsigg5PMutP8kOf3Zn5dNEOsaJH5S+XwQCXhuoJu64U=;
        b=CGmlZ36AXVgUZFDwG0qX6E2WmG1olvLTDzAo35bmCgXHlPDjN6VsAnoUtRk8qzHOMm
         MZvoPwhYE26cx41A8oCCmxXCNIlk9w2oWwPZoZ0DGiQjR4O2qUpT0ioZBw9uCkqrGhjN
         3X6uz137SVbQyPKf17aqmEifvd6Ng3oLm8+fwFDzgmKbkd0HChZprzdlvvUmoOO77PBZ
         ZsclVy0Ug71F1N3VlBS7nGmb17EapAgrzjsw2PexULFBuWgfxnYnrImqAefntT7rIwD6
         d7NygI+S0En+C6OJeyTHdoXCUDJcblE2vdf87yyr1og/ltgT68NMl27lEgUjBh77sZej
         IKAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1769418766; x=1770023566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZ0wRjpBkARHUdg5AXc4jIF+w1YP8Cq41/gPWjBo+gg=;
        b=mjlQTbN40meuUe7Qt2JMVdQRsK+Q1McY4Pk1gDmAJ+WYzV97KyhGD+HNG2S5wJ3+ze
         DGoqJtI4sOiZ2Pb/ax1Kyso6sxqoVRhGuBA9vYSEmyNJudhCApzGKVUqzJcJhCiT+U/X
         wG8EluaJZL0gqkUubo9cbQHcK6xBgaqdu717Mr6rd1jzMQ8ifia959ctMieyRAJfNuN/
         9AjElWOD2WzHILJuhX6gB4qnA0lJqUjvC0YwBFkZXepFwpEIgh/x0HrMQhd3BpBqOrbJ
         ZKRacWObla8cWS7Lf3jIBzrIFTOYIZ/Pxf65bzPn+5HGwBSGygFNW6S/2F92j1hfYmdC
         9imw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769418766; x=1770023566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZ0wRjpBkARHUdg5AXc4jIF+w1YP8Cq41/gPWjBo+gg=;
        b=rmS4XMy1bIkbHy+/SkURu4cR+Qr4cjtWEuoTdbdflez6OFszeLj+lMsZC4k+HOuToW
         egz9IcdlWnvq8I4ntMn+0PDitJEPW+CPAebrxCIVQ0Q0rVgXEnG3RQlLeDoorUkY4JAU
         E0kmHf/VTQCi7ZOddzcMssAbYYcH4vS/MpWu/i72hqGQBLoyQNNUQScggHTaNjw9dnNz
         QKgUPtwsuI4dmXORx5BPHLWgLObhMGUqmHUklwyPiAzD8c50qvxQ7d+HzjVbTgLZAzHT
         GIFjdQJGu9SzBteXemERg1lahnOYAB2ikSLGHwGJOkn1XJkcQsWrPvrtxOA0Ka7Vh6HZ
         u5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCWbk1av7G/ZIVFOMVs0DcR52oJ9xIbm6xP7iWM2OLoE/i4EHymSs26i4DfEh7dV3WOAtUY8BNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxwKXeBhwt4qzKG4xHV7Hg43akbwDnQqCD/vnYedvWcNx2nczX
	CnNOyIawa9drrXpDy8A+9Q6IU0t4e2dAHcYTro2KMCrH7mire+R/HO1C3ZjqJmezt1+ZbxdPcNP
	LYx1A11wqI9HH9i/YzMjJPLfjGJU7Nf2vIyo0omc94w==
X-Gm-Gg: AZuq6aLBO9Bk6PQofKrLwkXqVv4h3tisgXkTgGYGEVzcTpNJvruqaVLClk2FKGG2OFd
	9yz4baTaDOgfGCZkNSF63gClcRjEoswkNr75tDu5t8CbyNcA5IAtRIL1jptPO0oUSy9BQN+85J2
	f0djKoccDvVTb+rWtNvmKir5+OKYHn70i7TPJdTcnQsRj6HUObBSixC5kaPTMaZhtA81U/zN12i
	JWBkFNcxoBNrGNB1/JST5OMpjPRDkBlOr8Ktt4IzdstzV6QYNm/kIL/JLQoMnwYLBlFjYsa6Q1L
	TmUbPqwgxLp2knfBz9FXZeZlO+N3miMfFTUHWg8UUQpT+rRADxo=
X-Received: by 2002:a05:6402:4508:b0:64c:fc09:c956 with SMTP id
 4fb4d7f45d1cf-658706d59cfmr1542296a12.29.1769418766039; Mon, 26 Jan 2026
 01:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827-i2c-pxa-fix-i2c-communication-v3-0-052c9b1966a2@gmail.com>
 <20250827-i2c-pxa-fix-i2c-communication-v3-1-052c9b1966a2@gmail.com>
In-Reply-To: <20250827-i2c-pxa-fix-i2c-communication-v3-1-052c9b1966a2@gmail.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 26 Jan 2026 10:12:35 +0100
X-Gm-Features: AZwV_QjHvCNM4XDV7ASy_DsR-MKQkm_PDnKvDdBjq4JrCqpz7uMbU7Pm9e77hpI
Message-ID: <CA+HBbNF6r0eQLS01eTUX0DAZ3mGcQX7N3HTCnTanVPC0num2WQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] i2c: pxa: defer reset on Armada 3700 when recovery
 is used
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Wolfram Sang <wsa@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
	Hanna Hawa <hhhawa@amazon.com>, Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[sartura.hr,reject];
	R_DKIM_ALLOW(-0.20)[sartura.hr:s=sartura];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211539-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robert.marko@sartura.hr,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[sartura.hr:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,renesas,kernel];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 564D485E67
X-Rspamd-Action: no action

On Wed, Aug 27, 2025 at 7:14=E2=80=AFPM Gabor Juhos <j4g8y7@gmail.com> wrot=
e:
>
> The I2C communication is completely broken on the Armada 3700 platform
> since commit 0b01392c18b9 ("i2c: pxa: move to generic GPIO recovery").
>
> For example, on the Methode uDPU board, probing of the two onboard
> temperature sensors fails ...
>
>   [    7.271713] i2c i2c-0: using pinctrl states for GPIO recovery
>   [    7.277503] i2c i2c-0:  PXA I2C adapter
>   [    7.282199] i2c i2c-1: using pinctrl states for GPIO recovery
>   [    7.288241] i2c i2c-1:  PXA I2C adapter
>   [    7.292947] sfp sfp-eth1: Host maximum power 3.0W
>   [    7.299614] sfp sfp-eth0: Host maximum power 3.0W
>   [    7.308178] lm75 1-0048: supply vs not found, using dummy regulator
>   [   32.489631] lm75 1-0048: probe with driver lm75 failed with error -1=
21
>   [   32.496833] lm75 1-0049: supply vs not found, using dummy regulator
>   [   82.890614] lm75 1-0049: probe with driver lm75 failed with error -1=
21
>
> ... and accessing the plugged-in SFP modules also does not work:
>
>   [  511.298537] sfp sfp-eth1: please wait, module slow to respond
>   [  536.488530] sfp sfp-eth0: please wait, module slow to respond
>   ...
>   [ 1065.688536] sfp sfp-eth1: failed to read EEPROM: -EREMOTEIO
>   [ 1090.888532] sfp sfp-eth0: failed to read EEPROM: -EREMOTEIO
>
> After a discussion [1], there was an attempt to fix the problem by
> reverting the offending change by commit 7b211c767121 ("Revert "i2c:
> pxa: move to generic GPIO recovery""), but that only helped to fix
> the issue in the 6.1.y stable tree. The reason behind the partial succes
> is that there was another change in commit 20cb3fce4d60 ("i2c: Set i2c
> pinctrl recovery info from it's device pinctrl") in the 6.3-rc1 cycle
> which broke things further.
>
> The cause of the problem is the same in case of both offending commits
> mentioned above. Namely, the I2C core code changes the pinctrl state to
> GPIO while running the recovery initialization code. Although the PXA
> specific initialization also does this, but the key difference is that
> it happens before the controller is getting enabled in i2c_pxa_reset(),
> whereas in the case of the generic initialization it happens after that.
>
> Change the code to reset the controller only before the first transfer
> instead of before registering the controller. This ensures that the
> controller is not enabled at the time when the generic recovery code
> performs the pinctrl state changes, thus avoids the problem described
> above.
>
> As the result this change restores the original behaviour, which in
> turn makes the I2C communication to work again as it can be seen from
> the following log:
>
>   [    7.363250] i2c i2c-0: using pinctrl states for GPIO recovery
>   [    7.369041] i2c i2c-0:  PXA I2C adapter
>   [    7.373673] i2c i2c-1: using pinctrl states for GPIO recovery
>   [    7.379742] i2c i2c-1:  PXA I2C adapter
>   [    7.384506] sfp sfp-eth1: Host maximum power 3.0W
>   [    7.393013] sfp sfp-eth0: Host maximum power 3.0W
>   [    7.399266] lm75 1-0048: supply vs not found, using dummy regulator
>   [    7.407257] hwmon hwmon0: temp1_input not attached to any thermal zo=
ne
>   [    7.413863] lm75 1-0048: hwmon0: sensor 'tmp75c'
>   [    7.418746] lm75 1-0049: supply vs not found, using dummy regulator
>   [    7.426371] hwmon hwmon1: temp1_input not attached to any thermal zo=
ne
>   [    7.432972] lm75 1-0049: hwmon1: sensor 'tmp75c'
>   [    7.755092] sfp sfp-eth1: module MENTECHOPTO      POS22-LDCC-KR    r=
ev 1.0  sn MNC208U90009     dc 200828
>   [    7.764997] mvneta d0040000.ethernet eth1: unsupported SFP module: n=
o common interface modes
>   [    7.785362] sfp sfp-eth0: module Mikrotik         S-RJ01           r=
ev 1.0  sn 61B103C55C58     dc 201022
>   [    7.803426] hwmon hwmon2: temp1_input not attached to any thermal zo=
ne
>
> Link: https://lore.kernel.org/r/20230926160255.330417-1-robert.marko@sart=
ura.hr #1
>
> Cc: stable@vger.kernel.org # 6.3+
> Fixes: 20cb3fce4d60 ("i2c: Set i2c pinctrl recovery info from it's device=
 pinctrl")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Tested-by: Robert Marko <robert.marko@sartura.hr>

> Changes in v3:
>   - rebase on tip of i2c/for-current
>   - rework the patch and use a different approach which does not requires
>     modification in the I2C core code and update commit description
>     acccordingly
>   - remove Imre's SoB tag, it should have been a Reviewed-by tag, but due
>     to the rework this is an entirely different patch so that does not
>     apply anyway
>   - use Link tag for the URL of the referenced LKML thread
>   - Link to v2: https://lore.kernel.org/r/20250811-i2c-pxa-fix-i2c-commun=
ication-v2-2-ca42ea818dc9@gmail.com
>
> Changes in v2:
>   - rebase and retest on tip of i2c/for-current
>   - Link to v1: https://lore.kernel.org/r/20250511-i2c-pxa-fix-i2c-commun=
ication-v1-2-e9097d09a015@gmail.com
> ---
>  drivers/i2c/busses/i2c-pxa.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index 968a8b8794dac3398a68d827c567aa5bb73ae3d7..70acf33e1d573231f84a1f09c=
ffb376a8277351d 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -268,6 +268,7 @@ struct pxa_i2c {
>         struct pinctrl          *pinctrl;
>         struct pinctrl_state    *pinctrl_default;
>         struct pinctrl_state    *pinctrl_recovery;
> +       bool                    reset_before_xfer;
>  };
>
>  #define _IBMR(i2c)     ((i2c)->reg_ibmr)
> @@ -1144,6 +1145,11 @@ static int i2c_pxa_xfer(struct i2c_adapter *adap,
>  {
>         struct pxa_i2c *i2c =3D adap->algo_data;
>
> +       if (i2c->reset_before_xfer) {
> +               i2c_pxa_reset(i2c);
> +               i2c->reset_before_xfer =3D false;
> +       }
> +
>         return i2c_pxa_internal_xfer(i2c, msgs, num, i2c_pxa_do_xfer);
>  }
>
> @@ -1521,7 +1527,16 @@ static int i2c_pxa_probe(struct platform_device *d=
ev)
>                 }
>         }
>
> -       i2c_pxa_reset(i2c);
> +       /*
> +        * Skip reset on Armada 3700 when recovery is used to avoid
> +        * controller hang due to the pinctrl state changes done by
> +        * the generic recovery initialization code. The reset will
> +        * be performed later, prior to the first transfer.
> +        */
> +       if (i2c_type =3D=3D REGS_A3700 && i2c->adap.bus_recovery_info)
> +               i2c->reset_before_xfer =3D true;
> +       else
> +               i2c_pxa_reset(i2c);
>
>         ret =3D i2c_add_numbered_adapter(&i2c->adap);
>         if (ret < 0)
>
> --
> 2.50.1
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr

