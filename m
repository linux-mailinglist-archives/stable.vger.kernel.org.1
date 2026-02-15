Return-Path: <stable+bounces-216643-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM8LEzI2kmkWsAEAu9opvQ
	(envelope-from <stable+bounces-216643-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 22:10:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8AC13FBC8
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 22:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 467F63038164
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 21:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD05B30497C;
	Sun, 15 Feb 2026 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDfJiTXr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78823D7FF
	for <stable@vger.kernel.org>; Sun, 15 Feb 2026 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771189800; cv=pass; b=LwZqpckVqSeZZCHtVx/S0ZS5GLiDtpS4E2dzlP2aL/ot21HCAG0QKQdM0z2lgkQdBBbWUBEw1oyQxvcFnbr9T1NhO2EVcK0d5KkQJGlvO/UbnJcjEtMxENQ3DflHFgufsAzZoXfbbOLLv5kKx0mXJiCagguo2uJOlfHppx4GGZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771189800; c=relaxed/simple;
	bh=s+saamuLFlVf/0I9W1RYsvIqOOs2vJ1C7kourgd9C94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2xWZ5QbA0nDc7Ggu4ExVfKi3hjjlE08y0snmLR/MpzuEbqzTjMlno80Oj4L0m2oduYafjhF215fxE/DkSvNKgwaQbihSN8IWoQoixtGSGcap0hKsruGSyecjH5xuJYB9rOdtBm0tOhadjtQ2QhUZZSKa/mAzNRf+HmKMTxm73M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDfJiTXr; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ad9343163so252878d50.3
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 13:09:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771189798; cv=none;
        d=google.com; s=arc-20240605;
        b=lkHkPxu4MrmJeU73HtmQjNlc75WOwI+Ev4ySLqxq/3yGD8PmzgwozMXWYArTsR1MZL
         Km3XY3hhZ9JHV6ZoWw0h4YaAqh3LBdrl6hZySbYmiDHAdr5iYuS6ktOez6/enmROE8d9
         U8i9tOhSOUFItXTMsKTA8hNm6XDBv2prF/XLOerWuv37G+PBLWJnYgjn1lPz03RGBlQu
         h1PYMU5Q8uD8a9UrvGvCWbLgu1be4TJ8uymlpr4yLVHS05RqohNjRbkI9Xs/A6X8eoJJ
         5VSif2GYfZUcWTsUqdrRmOC1xudm+xkPBRDFKWLa2AtnrRLRKngN6zU4puHPuYlY+Nlx
         oYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8/cusOaB1RRkk5o1Oqtx1KMkhaZ63LZzGMA+5vMDafw=;
        fh=r6TbvWV1OaqWBQw/kfxPwfCypjbPbotYKf1a1c03Y7Q=;
        b=ISy/LNCnjXxK04u/AQz3qniLkXlSI5qRhpofl5A2wpa4qHqvR5/xyomCzbbAeZMj0n
         /DQv+IiObJj+owAMb7lF97yd/yN3onO5SFpfJ26Mbj7Upd1X0QwaWYhhYft7CBI40Ylc
         mlm6UrRCvRqlt4smxb7fxsKYeVZhA1ADQnSOiDAoGn4SdgMjQkvGnO3x6w4UUUtykZwz
         3XzQka6joY/Paj9lv0XN0LQYKW8taRuB3bx42qG2F2RsVvvzQcK3NxRiZ+5o5ytztqnB
         lkcMK3+rhMTYQdNMl0NxwgiXNZqTCBVDdv7fQzdiA3z4MPj96us+e5EzTg9Zgz70NBag
         WnSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771189798; x=1771794598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/cusOaB1RRkk5o1Oqtx1KMkhaZ63LZzGMA+5vMDafw=;
        b=QDfJiTXr0/K+A8RSEg0kYymchVMrQf+JEyAZ/2vCeH9nQ+Nd2mMo1i5xkKv0uG+xNR
         7YpKdjy1YouyyVieZQe7B9BDawC11SmJ9732Eg2UIDCnWqQUSw/XX5mI9SArdnL6WHgJ
         DYfJTYwmcLinAXzsKvk3zBjDCk7yGXYIU32SpUXKwe5jcMZKQDzcNx7UZBsbMzBlVT5U
         sm/rZgINZh07eiWfLvCLpX/RPrUP6pLi3NX9R//DVIE025QebXK8CU/q6wcR0mCKF6/I
         n+oXNw+M2MEANKt1KzIw4oZ/o/lKHh6uYuUdag6eMSZUNsvntUbX60ky0p3e7PqNU/3k
         MuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771189798; x=1771794598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8/cusOaB1RRkk5o1Oqtx1KMkhaZ63LZzGMA+5vMDafw=;
        b=iWws207xKUMPXPE0gAKdx2CryAeQyT4MSUBUp38M381g1vTjJVK6O7jdEL9trwGjvI
         79aV+UgdrO8GkjgoF9RQaZLyl2cXhGzlqui0sMpgDPRZkZSxHYRD3opv/s1Eh8zoxxNU
         ZE/W8IzvqehDGj3zCcrjiwk41I5PZDb/cz/SL9MQOJZpV5Vu+Wq9Qy9NC1sptOKW/sZP
         8lT3xya6UMLcP3A8j9LllcvpRZSkzMZic8rsW1N9nVw7jWSEpkuYVLmVLR7oVFFtdGvz
         hGYy/OIScnHfa3/0MKEq6Y0WyqdO4ZOhUlB09TiHOmAnQAmwQGrCudQROrx41q5mbzwf
         nQkw==
X-Forwarded-Encrypted: i=1; AJvYcCUWqVVrC26atTPU16ZbqTgCdadB1AgfNTtSIiq9ii6YJx6p4r89zLTfG/4SDbktw7fLx/AIW8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgluAJo1a8nTXaqbgcIPlMBuPwgGx8VwUhSOqKVXH0WjPq7Y9l
	VzTOjv2SFOT9UYdjqxjRSxIXOln9UEIObAAVV/TAJLFnLMYQQfBceRnCKIUVZ1I8aBB2E+rl5EQ
	VNFTWf6rF1HQWkk1Vg5Q/0cWKszH1fbc=
X-Gm-Gg: AZuq6aKHukiWJb8+P6KKaZaPOKdERVaaeWC0bRbbe3qmGUE646jOy9nOXOBiB26MfJe
	QsEPW5dKBEJMpcjL79nvwCbhMIBVKk71KM2h7NivWYsqCMsy4eJvyZMwQSkk3aSQozOuLuXce9E
	5wzdI/WrMuG3TENNDjzuCu7a9ODaNyF7lFcCNt5EfPIDLRAvbFOCVO/7QVS9+Opdtg3LoxJGqBK
	Qm52RxC0VquGugI+jKJ2M/EN1YawSJXQnNhVWiGsQ47m1jnrL5O383JHS+imkjdz0mbcDt8j4OH
	0c5zi4/Rnq3AHSM=
X-Received: by 2002:a05:690e:130b:b0:64a:e582:1df4 with SMTP id
 956f58d0204a3-64c14a7fd18mr6521389d50.2.1771189797555; Sun, 15 Feb 2026
 13:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260215124125.465162-2-thorsten.blum@linux.dev>
In-Reply-To: <20260215124125.465162-2-thorsten.blum@linux.dev>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 15 Feb 2026 22:09:21 +0100
X-Gm-Features: AZwV_QhxXP3Z3j7FNL3hjVM3mHfb2bVg8Ao95qmXJAI_nCBLpkmUpk6NpESx19A
Message-ID: <CAFXKEHbCrp57ruvCF2TXXcnoJF93Z5bdUd7Nt5WtM9_abtc66w@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-216643-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,dut02:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC8AC13FBC8
X-Rspamd-Action: no action

Hi Thorsten!

I tried to verify your patch on hardware today, unfortunately it did
not work for me.

My setup works with current atsha204a module in the below described way. Wh=
en
trying to dump the OTP zone on exactly the same hardware with a patched mod=
ule,
it only prints '0' and nothing more, see below.

Pls, let me know, if I'm doing something wrong; if my usage is wrong or
if my approach is somehow flaky. Otherwise, could you please have a second
look at it? Note, my patch at the time emerged from a particular
use-case at work, it's
likely that it's not covering all OTP. So, if incomplete, I'd really
appreciate having it fixed.

In the following I provide some details on what I did today.

8<-------------------------------------------------------------->8
My lab DUT hardware:
- RPi 3b+ with an ATSHA204A shield via i2c, 3.3V
- ATSHA204a with a locked config; initialized OTP zone with some values
- Just enough to be readable i.e. verify OTP content

My kernel source base, since on a RPi v6.19 branch, built w/ aarch64.
Note, I'm building the module then out-of-source with a separate .dtsi
(I'm not showing all the boiler-plate stuff here).
$ git remote -v
  origin  https://github.com/raspberrypi/linux (fetch)
  origin  https://github.com/raspberrypi/linux (push)
$ git log --oneline -3
  e150a7a6d683 (HEAD -> rpi-6.19.y, origin/rpi-6.19.y) configs: enable
Si5351 i2c common clock driver
  3c957f9e74de pcie-brcmstb: move the unilateral disable of CLKREQ#
before link-up
  994331c6ea59 drivers: media: pispbe: Add V4L2_PIX_FMT_NV12MT_COL128
format support

From the bootlog
  ...
  [    0.000000][    T0] Kernel command line: coherent_pool=3D1M
8250.nr_uarts=3D1 snd_bcm2835.enable_headphones=3D0 cgroup_disable=3Dmemory
   bcm2708_fb.fbwidth=3D720 bcm2708_fb.fbheight=3D480 bcm2708_fb.fbswap=3D1
vc_mem.mem_base=3D0x3ec00000 vc_mem.mem_size=3D0x40000000  dwc_otg
  .lpm_enable=3D0 console=3DttyAMA0,115200 console=3Dtty1
root=3D/dev/mmcblk0p2 rootfstype=3Dext4 elevator=3Ddeadline fsck.repair=3Dy=
es
rootwait
  [    0.000000][    T0] cgroup: Disabling memory control group subsystem
  [    0.000000][    T0] Kernel parameter elevator=3D does not have any
effect anymore.
  [    0.000000][    T0] Please use sysfs to set IO scheduler for
individual devices.
  [    0.000000][    T0] printk: log buffer data + meta data: 131072 +
458752 =3D 589824 bytes
  ...

...current atmel-sha204a:
root@dut02:~/atsha204a-orig# insmod atmel-i2c.ko
root@dut02:~/atsha204a-orig# insmod atmel-sha204a.ko
root@dut02:~/atsha204a-orig# cat /sys/bus/i2c/devices/1-0064/atsha204a/otp
0001ED86032D0002154C033750FFFFFF20B0F703DB0CFFFFFFFFFFFFFFFFFFFF

reboot...

...atmel-sha204a with patch applied:
root@dut02:~/atsha204a# modprobe i2c-dev
root@dut02:~/atsha204a# insmod ./atmel-i2c.ko
root@dut02:~/atsha204a# insmod ./atmel-sha204a.ko
root@dut02:~/atsha204a# cat /sys/bus/i2c/devices/1-0064/atsha204a/otp
0root@dut02:~/atsha204a#
root@dut02:~/atsha204a# xxd /sys/bus/i2c/devices/1-0064/atsha204a/otp
00000000: 30                                       0
8<-------------------------------------------------------------->8

Best,
L

On Sun, Feb 15, 2026 at 1:42=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Fix otp_show() to read and print all 64 bytes of the OTP zone.
> Previously, the loop only printed half of the OTP (32 bytes), and
> partial output was returned on read errors.
>
> Propagate the actual error from atmel_sha204a_otp_read() instead of
> producing partial output.
>
> Replace sprintf() with sysfs_emit_at(), which is preferred for
> formatting sysfs output because it provides safer bounds checking.
>
> Cc: stable@vger.kernel.org
> Fixes: 13909a0c8897 ("crypto: atmel-sha204a - provide the otp content")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Compile-tested only.
> ---
>  drivers/crypto/atmel-sha204a.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204=
a.c
> index 0fcf4a39de27..793c8d739a0a 100644
> --- a/drivers/crypto/atmel-sha204a.c
> +++ b/drivers/crypto/atmel-sha204a.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
> +#include <linux/sysfs.h>
>  #include <linux/workqueue.h>
>  #include "atmel-i2c.h"
>
> @@ -119,21 +120,21 @@ static ssize_t otp_show(struct device *dev,
>  {
>         u16 addr;
>         u8 otp[OTP_ZONE_SIZE];
> -       char *str =3D buf;
>         struct i2c_client *client =3D to_i2c_client(dev);
> -       int i;
> +       ssize_t len =3D 0;
> +       int i, ret;
>
> -       for (addr =3D 0; addr < OTP_ZONE_SIZE/4; addr++) {
> -               if (atmel_sha204a_otp_read(client, addr, otp + addr * 4) =
< 0) {
> +       for (addr =3D 0; addr < OTP_ZONE_SIZE / 4; addr++) {
> +               ret =3D atmel_sha204a_otp_read(client, addr, otp + addr *=
 4);
> +               if (ret < 0) {
>                         dev_err(dev, "failed to read otp zone\n");
> -                       break;
> +                       return ret;
>                 }
>         }
>
> -       for (i =3D 0; i < addr*2; i++)
> -               str +=3D sprintf(str, "%02X", otp[i]);
> -       str +=3D sprintf(str, "\n");
> -       return str - buf;
> +       for (i =3D 0; i < OTP_ZONE_SIZE; i++)
> +               len +=3D sysfs_emit_at(buf, len, "%02X", otp[i]);
> +       return sysfs_emit_at(buf, len, "\n");
>  }
>  static DEVICE_ATTR_RO(otp);
>
> --
> Thorsten Blum <thorsten.blum@linux.dev>
> GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4
>

