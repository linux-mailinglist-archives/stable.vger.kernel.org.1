Return-Path: <stable+bounces-216658-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD93HPW1kmkLwwEAu9opvQ
	(envelope-from <stable+bounces-216658-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:15:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D63FF141153
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 07:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12DA300C01B
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFB32248B3;
	Mon, 16 Feb 2026 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPbAfU9f"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEE32D6401
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771222511; cv=pass; b=Q4M8rNUn7jV7UnJR07VBhm/kCBwjUa7fMZ/Vqvo48alVhyfmCHUXoGMe45uT9Pmvd4FH16bUvBzt81Azu8RLTRwuG+qj8Eb5XtvkSghszC8/8/KMIoddY+5rXNrpIhWS16i8Oe1qKAJyWiCJFzz4Yu3sFlMY/c6FvUb1bPl9EjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771222511; c=relaxed/simple;
	bh=HaSzBXUNN04aYNe53ChzspTUmhSMQPEgxnlRMM8HFwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q84IPVY4MkC6zntaBFRpxomLdatnIHBML6gF32A7Q9TNKwyeNlv+pnBjiTjHIoxgQj9ZwU+h8pmBLXAQsMw8nkLbwnQgPRejRo+WG9meX71ltmZwBf2HDVPFhbblbMqZfzjfWsyU1hULx5EPhotZc0W4LmQyJevROQX4UqkSM14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPbAfU9f; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6497b819b07so285476d50.3
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 22:15:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771222509; cv=none;
        d=google.com; s=arc-20240605;
        b=GtR/t7XsBnoIz/FZmKvozsv7fGszWxvlwgz916euuQSUXKkd4IkMixyJU5/qez6wOj
         Gb4Imx6RrfiNup19ulEoOVNJ8/EZ9wl2rgORkOYVJRHIFlZTXmUxYtorKcANybk2Z5XA
         ZDvZxQdXbyJJJjY/JVKpC9gKQZ6/klIXBXn8dml5kMXroprgIAxgxpz1Ym/fJpWiJu5Q
         91FOIC4z1OJeEB8usJC+E2NCjW0g8VTEf3bN+LxnRMoqqEG38ohoDvL1DKgbb9fPdaLW
         IRgntkPSk0ix7qdHc/8lkVWJlSBwpD/jNtwkyQBIUHU5u47ub4Fp0WIrH/1MAynCZiXt
         qogg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7OLaxPGmMOUlM+H5QGZLEwi3fIBF1FV98gq1aRG1ib4=;
        fh=IUMOx1z9QMNU5Hwyhdf/yjv77uIk5x25Z+rRCaZ/QyI=;
        b=OH+aae/fZx0kM1Uzc5xAEa5+oot3YvsvPFYt00nJCdCTLr2hHt2C730rKbB3eipd2A
         XIVJ4Uuoeb0ODvn7UQqIsjnXGqP5Mh294HbqYf0WfTm6TLoNzW1InsYdTW9jDmbMFk45
         mjfxwGf5g/746oQXGk6SvrqmTprgrgl4NurzA6r+A4a0WpYr14YlkaoN3722iw9dH1cs
         Cs6KXzYZsfrnzKMJENi5F7EdHydmKkGdLjMJcIdNhn//Ljvpkl963AJr+pKn6YGwLT+7
         gm+Ozf1n974eYdEUymr/gfVEvZGmfdB97A5i2mRtMGnHYOzaB9fdkrJbdUyAlUsDf6I4
         FzqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771222509; x=1771827309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OLaxPGmMOUlM+H5QGZLEwi3fIBF1FV98gq1aRG1ib4=;
        b=jPbAfU9fpOvTdNAOFKKMwY8S93s5YCtH+Ea7FyM5/d3WpyAg5b7pAQQ6i3xu+Woo2C
         tndQrbO2jbts6slbUm1/pwb+recmUQXIV31abg2yztPyQnhuBAl3toY8KGf2eOKcyaO+
         54UFzqNU3HuMa7KELjTrl4Lh4Th7HzikqK4km+BNzq6zdXsLnZZ4+LhaN0J+cgPMm4A7
         jLTK7WGufzDQEFdE+DK8qj6Ci0w7vIKjeex51FXEBrC9SjVyEZnfiO9R0O3sWvSX3jJb
         h/sGdyxChBCO8hO78FZONwz6F4iU574OXUka8zM4+kYrhkXY0LpINIRQdtZ9ZlumbILe
         ldqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771222509; x=1771827309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7OLaxPGmMOUlM+H5QGZLEwi3fIBF1FV98gq1aRG1ib4=;
        b=Xyx5V7RiYZ6WttT4sWWQZDZRhokdn4LoNtd9wUZ9g9v0cgiUoCAcXFiGbxCtbi/5pp
         nMMYdMuHvsa7pXiJQwBoVB0EOtwH0xPoYSNwJAqiUKPuo72p3sw+gMSf4UbA1I59xLUq
         ATOJE2LUqEVIWaT+DAyi01g5kkIz9ElQ1n6fc63IyZV+9poaFtWToIzPc6Cuu6JVEDXf
         FwLgMCjUFDs7l2sz0AU6hYd49tlo91K7qrEOCcUIehKpmDVu9eTL+Wqk498FU+eAdTe8
         uBIHdJL1H0mjPCN7ZCiIn8S1NFDnoEWo0RSzBNbLJQwWRCF54ckJ7pnyDj0IPmbixchU
         UPBw==
X-Forwarded-Encrypted: i=1; AJvYcCWkmjVoRKBJrgX6ChQFYQ8Go9nM1/9TS/74BxSWMlZ4Dmi749+lh37Pe4lYy11TwPfXSOJEI1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj6ngn6NrE63sKnu1UKeGhDaS5Wz9R1dfO0+FUUbL4/wws0J1n
	Me7sZYOZL6Vplr+15FUfsbMQ1YzDe9m3ghVafBrU/NseazJcDlHfx7XWnevPEZXR7tawP5sxgtu
	WFDPP1sR2fTmbOytz7MONCV2vVoxaeXs=
X-Gm-Gg: AZuq6aLOeQ5chBGPiuCfzOs/OZGjgSwrbuFskgqo869BfgvJ4ewYet9kkj/HPtXoauU
	aFgbagIx4LGanBNmxIalDdPftiprOZAF1N+8TJR0SrlUlmoBseSrIOatkx2K6AKqW3XT5nuf/0R
	wWGFkMpzSmsw17SDY3U9V/OcdJS8JW8NcFoId5BRux5i4Efb7kPZnRerqGL/4cv91mcOlzb9CZH
	a7b/CJ/6MUZG8B1s5gT70ke8favl6egXrK/wjzl/Q7AxXeYRGSmOiaCRc5+thkCQHmEgR7wgPre
	2Gy7
X-Received: by 2002:a05:690e:688:b0:649:af59:a1c4 with SMTP id
 956f58d0204a3-64c14b2f43cmr5633576d50.2.1771222509351; Sun, 15 Feb 2026
 22:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215124125.465162-2-thorsten.blum@linux.dev>
 <CAFXKEHbCrp57ruvCF2TXXcnoJF93Z5bdUd7Nt5WtM9_abtc66w@mail.gmail.com> <2E9C85C9-AD05-4BB3-A945-5ADECCB5C7E4@linux.dev>
In-Reply-To: <2E9C85C9-AD05-4BB3-A945-5ADECCB5C7E4@linux.dev>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Mon, 16 Feb 2026 07:14:33 +0100
X-Gm-Features: AZwV_QhV-rE-2L6EhZdu8wVKACqD128xWZDEOzyJLFfwFvFndTo9tJvFuP2QOSc
Message-ID: <CAFXKEHb+D__WYugjdbqUSSnubfsOeibfH-Q33eJGjG3kvfndwg@mail.gmail.com>
Subject: Re: [PATCH] crypto: atmel-sha204a - Fix OTP sysfs read and error handling
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216658-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrubusch@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: D63FF141153
X-Rspamd-Action: no action

Hi Thorsten,

On Sun, Feb 15, 2026 at 10:48=E2=80=AFPM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> On 15. Feb 2026, at 22:09, Lothar Rubusch wrote:
> > I tried to verify your patch on hardware today, unfortunately it did
> > not work for me.
> >
> > My setup works with current atsha204a module in the below described way=
. When
> > trying to dump the OTP zone on exactly the same hardware with a patched=
 module,
> > it only prints '0' and nothing more, see below.
> >
> > [...]
>
> Hi Lothar,
>
> thank you for your feedback. I made a small mistake in the return value
> where I forgot to add the previous length 'len'. Sorry about that!
>
> Unfortunately, I don't have the hardware right now to test this - could
> you try if it works with the following change?
>
> Thanks,
> Thorsten
>
>
> diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204=
a.c
> index 793c8d739a0a..431672517dba 100644
> --- a/drivers/crypto/atmel-sha204a.c
> +++ b/drivers/crypto/atmel-sha204a.c
> @@ -134,7 +134,7 @@ static ssize_t otp_show(struct device *dev,
>
>         for (i =3D 0; i < OTP_ZONE_SIZE; i++)
>                 len +=3D sysfs_emit_at(buf, len, "%02X", otp[i]);
> -       return sysfs_emit_at(buf, len, "\n");
> +       return len + sysfs_emit_at(buf, len, "\n");
> }
> static DEVICE_ATTR_RO(otp);
>

This would work. I'd squash this fixup together with the proposed
patch and resubmit
a fixed version.

8<-------------------------------------------------------------->8
root@dut02:~/atsha204a-modif# insmod atmel-i2c.ko
root@dut02:~/atsha204a-modif# insmod atmel-sha204a.ko
root@dut02:~/atsha204a-modif# cat /sys/bus/i2c/devices/1-0064/atsha204a/otp
0001ED86032D0002154C033750FFFFFF20B0F703DB0CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF=
FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
8<-------------------------------------------------------------->8

Best,
L

