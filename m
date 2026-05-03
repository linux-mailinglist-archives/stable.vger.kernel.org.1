Return-Path: <stable+bounces-242643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id q59KGmLZ9mnMZAIAu9opvQ
	(envelope-from <stable+bounces-242643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 07:13:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C684B4798
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 07:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BBA0B3003607
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 05:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D6D34DB77;
	Sun,  3 May 2026 05:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INWgKeJQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A082D8DC3
	for <stable@vger.kernel.org>; Sun,  3 May 2026 05:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777785180; cv=pass; b=N2txtxjop+PfMBgTg65aWSEf0AtE60IyEl5sYIMt7GzmT69ZGPjeNW5s34vV1iDgt2mdik3wk5tn5PwQmZvnNXywXcCBNkga8X0Pp93bzECR+O4K7UlUCRPSJVlLywJOtLGWM5yvAIStDxoEBMTADSIH9oRqX1wdg58XQcyyk+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777785180; c=relaxed/simple;
	bh=VQI5a42Ek+RqQPHOII4Y06s79MSK8X4Zu/WHg2CNknQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGZTSbqy4hMPJEvuBcBbX6zUJe8cW265xQrDJfVGrmKlTvNv2KoP50V74iy12nq4+T4fOr51Bzu5rXczeEPEU1Lb4bS+BlcqksH6RmSrGw2lBNW7MY4jKNhd4ythZ/DPBq0M9BcXqyX0IHi42rfFCUivrFT8cpKy1ox+ZozmrdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INWgKeJQ; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd4c61765dso33957577b3.3
        for <stable@vger.kernel.org>; Sat, 02 May 2026 22:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777785178; cv=none;
        d=google.com; s=arc-20240605;
        b=U+3DXHSLafKJQquxcuDNiO7Gd9fNRkbY/6coQQalmqeNJGeJCjXZhDD7Vw2wXAnP/Q
         DsQI/P4ZAZgm1bI9ApRBkDA8aIhbUFIXR1McpY9L5KIzGKz6K2rx0DDLgRXYZvv+vqrH
         HeXVMHWu+PuPFmkuFFdOrWuj5fctQPXpvJIDPU16rsk+jTNADtyCdqUbEVNpvevwIUHn
         Cv6iuFtb7qg+4Xw7/c9X4loGDH1sT+AO8Zs/fyX6SNZ4QXEm4+pqcgQz6ZmiIppmDCJW
         +YdBu0msGuIeiEn8K5ZI+9FZaHY1KWdpHPxIpPjXdW5iULX5hqVk3Bxn8P3WD753Zs88
         BANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MX6+eljwst5hAwzbMT82717o/7NySMaTnB5zbbXnmlY=;
        fh=G4ogQLmaWhGLJhYHfY8rCCYdDFLgH8coe81/rgW9u/k=;
        b=JkQnRhwH3g6F0niK64bON3TqCecHVVB60wqHv1fSpu3IQxZ3v3J+BBM2n169zOGsvd
         0AHibcaRkJhkZ6yyEHuVy+6NwEbuLQJkh04QkyAa+ZJ5501Ilm/zxNWEOuQZuVsGhjCm
         i8okRs7gC2dT7V/s1JPwruH2cMdAcncjVXO1gTVS8kvTJg41evI3QIaAovAf6XX1XCPq
         3HFKB/yXyhlDbPtkemyT0RqJXkoIlRwxsDtZ+3+64tJdI5zOQ8JSuXnIeAayr+lE36uW
         Lb7/TGjg/xaBJedkmHuWmj1jpDZ9Mv39Gfk/BIc0t+KIhIJ4dyGrr2NKzQDhQn3hjFEK
         HRKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777785178; x=1778389978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MX6+eljwst5hAwzbMT82717o/7NySMaTnB5zbbXnmlY=;
        b=INWgKeJQa6uajOqGq5FW7LT+LcLdcNfXGvLfvrh/JENzSxZzYK2m6exrV5uPvpXrez
         FiV+cfmGh3VpZ5wLeRi4J32FVvcmbJ12sTpWdL8GEZ8VqomH/YLXztadERQPu1eKe2Nv
         tO8f2RBfEnJNYgOOFmLz0qbByozSuBw/DSJA4ibErrUS0pLmgwPOiEci+jEJe0lpkV0r
         kGBjIrqiHg0DgoQ/xxuEDD47OALII9FbNbigfnJlVbmUeJWf/ghDjjRroqLTVyVw+Xgu
         cw9qaiaUBXVJxel7AObLtNf0yhxcmVpBGkyyHN6WrvjAykv4LGeP82QvcoFB9c7qMyqB
         ZCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777785178; x=1778389978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MX6+eljwst5hAwzbMT82717o/7NySMaTnB5zbbXnmlY=;
        b=DU7ei0lQdUZQJN3b3ns3eB2756UBDrU/j6ccM0GpuCrxWPE1+Y2K7FKve8p14j0YnS
         1LH+wxyWOSUvhbOSUC5tFHSj9Jvf4bC25ObgmqQYPoGep04lwgtxo8mC+cCA2naoUEdy
         TQ3JtQXpFf2KIqeJ10GVEOxev7mVLF8qvhDnCrASuzLGwxlpLRqDlsPOgRJPBwgXuEy7
         dLGbQ1W/6avsL6k+0DU5DrLWq9A9KxMmmpc6tZTmSk1fJ+yqoRn/mbUvkb3vnf21B+R2
         5MYEDioynCphMPS9OzjZvMRZ2g8aRgkYQu/1YPj5KXAbT8SDiq+OXivOLhA/Ngu+C+L0
         TIUw==
X-Forwarded-Encrypted: i=1; AFNElJ9qpopj6lBwmQzccquOZwkDuyExHCk9eYCAeoySzY1ch30mynmGG5IKAPJsWRLi8yd3/hSotL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52GwRYedOshGSnvfhb0PNOPeAixiN48bmugo/TQtR5jAC98rJ
	NKxUga58sF8yCZ76TgW08M7RneyxzXk1hZoJAD5inArA3UsvONzx3/9btz+r4A+dv6OyZamhblB
	/Dp2nhYZ8DcE9UokpPakCKq/XOK0RP08=
X-Gm-Gg: AeBDieumWYxs6OZYutNPloQ92OORlCywreL42qo+xx3LJyzQKqy+MkjfW3wembLJiy6
	VTTNSp1P7HfCUZYb51qSlvxJX2D4hw3yb3XJL/wrlclldEsaMFY+7aSpVAxq0hKkrW6FmVx2X9e
	UztfT+tZItZYBb0NoDPySAv8QztbxBiXjqbwBBLtkvCF+LIqhpOwdGSxXizvtLMzDdh3wS3m5Fg
	XOyM802nbhtQWWHZMx3aq1rwoqPpCm2CzDuQ/1x6MUoeg3ZBKl+U161Q/k0H7GpK9qfRgohSwwS
	l8MKNCBD2xqEnQouUbXItoxkr4/vd8v8KxDMWbBECYRIj7SaCe/6ZKCgwDFUsT7Rx9IhHaoJJt7
	unx3i6YI=
X-Received: by 2002:a05:690c:9d:b0:7bd:5af0:3bed with SMTP id
 00721157ae682-7bd77003e53mr52333397b3.21.1777785178050; Sat, 02 May 2026
 22:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324015539.1451660-1-kartikey406@gmail.com>
In-Reply-To: <20260324015539.1451660-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 3 May 2026 10:42:46 +0530
X-Gm-Features: AVHnY4IWh3MZLwFApCupnMNXGyC5GEFz_oe-ppOy2nxNl-bFO3x8fJRsVpn3Anc
Message-ID: <CADhLXY4meyw0JuXjwhTjPEh4saZprqQfdO6GBdYBjANXsGUm+w@mail.gmail.com>
Subject: Re: [PATCH v2] media: ec168: fix slab-out-of-bounds in ec168_i2c_xfer
To: mchehab@kernel.org
Cc: harperchen1110@gmail.com, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 03C684B4798
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242643-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,64485d3659c4c07111b4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,appspotmail.com:email]

On Tue, Mar 24, 2026 at 7:25=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> The WRITE_DEMOD path in ec168_i2c_xfer() checks msg[i].len < 1
> before accessing the buffer, but then reads both buf[0] (register)
> and buf[1] (value). If userspace supplies a 1-byte I2C message,
> the read of buf[1] goes out of bounds, triggering a KASAN
> slab-out-of-bounds error.
>
> Fix by checking msg[i].len < 2 and returning -EOPNOTSUPP if the
> buffer is too short to contain both register and value bytes.
>
> Fixes: a6dcefcc08ec ("media: dvb-usb-v2: ec168: fix null-ptr-deref in ec1=
68_i2c_xfer()")
> Cc: stable@vger.kernel.org
> Reported-by: syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D64485d3659c4c07111b4
> Tested-by: syzbot+64485d3659c4c07111b4@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v2:
>   - Fix author email case (Kartikey406 -> kartikey406)
>   - Add Cc: stable@vger.kernel.org as the Fixes tag points
>     to a commit present in the stable tree
> ---
>  drivers/media/usb/dvb-usb-v2/ec168.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/dvb-usb-v2/ec168.c b/drivers/media/usb/dvb=
-usb-v2/ec168.c
> index 973b32356b17..ebfb02826b20 100644
> --- a/drivers/media/usb/dvb-usb-v2/ec168.c
> +++ b/drivers/media/usb/dvb-usb-v2/ec168.c
> @@ -135,7 +135,7 @@ static int ec168_i2c_xfer(struct i2c_adapter *adap, s=
truct i2c_msg msg[],
>                         }
>                 } else {
>                         if (msg[i].addr =3D=3D ec168_ec100_config.demod_a=
ddress) {
> -                               if (msg[i].len < 1) {
> +                               if (msg[i].len < 2) {
>                                         i =3D -EOPNOTSUPP;
>                                         break;
>                                 }
> --
> 2.43.0
>

Gentle ping on this patch. Please let me know the status of this patch

Thanks

