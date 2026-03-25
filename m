Return-Path: <stable+bounces-230341-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCRAIjPhw2lvugQAu9opvQ
	(envelope-from <stable+bounces-230341-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:20:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2293C3259BB
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 14:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 343323090856
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 13:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8431C3D6CD3;
	Wed, 25 Mar 2026 13:09:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C63D309DDF
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444158; cv=none; b=pAQsOfZmEgcbHvSYC6F6bBTsYGesROlZ75X+5QvhWA05YKjZIfa1x3SJ9U7Q+mGh5GL4fdwn0UgDcKCi5XTQrQu9hqFp//bpsaxl9HN8UjGy0POROgkQ07KXi6xLT3OquOfdCWWXfPMfsu8MER6nsKj1Vl2SA5DJciFCJUlJs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444158; c=relaxed/simple;
	bh=5iPawtLo15CwqkkJmwsrHLhxOCNnGqzihkAjVkKHqY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NGqc6AioKZ0+jKqGbHhAVnA2a9Y2lbj4+05a3yTXxV63cU7bJsCYW/URrbd/BxUVLli4L4VzcAu6exGzeB4A5G2rCYRgiNg6E/J3AI2IWCTT5hjv4gKEx6rYU1w4MaxEmHiJg/PxI/XggImO2LZxTGDijo5cGpl4y/ounx9hDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-668d4751a3bso7837654a12.2
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 06:09:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774444155; x=1775048955;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckxAXUDke0h5tovTl8PH/LMAmEb34wiiT3UqWY7x06M=;
        b=MPI0ExjElEGtUsHDKBW+xctk+gpofreCEM+QHpH5mxJfapGv5GimYSxiF5HNxsKvGq
         /9svmLLAUn3o9+2Wmoe5fFGjfWfGG8L/epYH1mRNob40J4rJ5uggPabETFuUY+CEN/8d
         cWPcEpZ2ghTuVuMhbBnXqGhzvEDtrFJjhrBZPjpv4yITNoaIDKh7HgiuTgQPXZYEdcHO
         v67kvyrCO6yS8MEzfdcgOjCzk+rsF6r4diEP85O8mUHBgb4rvLmYwiwn4AOR7DsifMC3
         jN+tBmbubwgdXyQyuj35drnpbpHZVCWfQAUFsTs1Q7+wm9OASHe0zCRJnVchWMau9408
         SjZA==
X-Forwarded-Encrypted: i=1; AJvYcCWRLX7VHPtGnyAwWqtEG+bAvUGwzMijofc6H6reytf1ZO0o1Cni+7CLYfadc4rlIcSzYjoowz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUwHOq8qys/u4dG4lVPuUkr5I464f0amyI8+m1++75oo7+lD25
	xRiERknHh0b4MgDhYvb2Hxzn18OPgSqG4doBidSCGEIk8M5HNU7JfgyIiM00eAHfvOM=
X-Gm-Gg: ATEYQzzqW6UPuKyrA1x/4glyPF8JHjwMgVbUZ6XSuqWv58em7hHxs36Mds3b4ZsnK1J
	gsRDEaDIzd5IuBiGN2orxJ0fMSAT3N44pKt4SJtB5af2kVVxRCfZDBAeobCLXR0xze9PczcqI3k
	wmt3hsaCtMjaAeBC9WH9JKCOKwQVO1wez5HYnc2qwE03IIo1+f0Ejqg5I4HZoVYQG9bZfzpPhF3
	v0kg3JvizWeGVgnb+WvbBgsRf2iX6NHeiDUnOJmg2G3Unfu2o4QHshjHkl7dVoi67jPnNmM+DOp
	Qf/9x7IjPKEtpb2lQq4/qdWLs4qvBD42zT3Ex3Lv0AI95Scra8BIW88cdVDa18DmHKoyTcww8Cl
	XC/n7VahzhD5JfKB3WnqwizBWzXG+gUQJbI0FJiGGcBxms33IKoWZ7eneRkU5RLOLQMrcHdxC8Y
	jcjV9S6EgDkuyTPnqj1xbMY/XWTPD5Vb+/G2lva8QEKHmvDblMVurvdZT+dPRx
X-Received: by 2002:a17:907:7b8b:b0:b9b:e5d:719b with SMTP id a640c23a62f3a-b9b0e5d8597mr198760466b.14.1774444155109;
        Wed, 25 Mar 2026 06:09:15 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b98336630d4sm799195066b.46.2026.03.25.06.09.12
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 06:09:14 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66a922a3a05so849060a12.0
        for <stable@vger.kernel.org>; Wed, 25 Mar 2026 06:09:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8gDz4YikMG7oI77lskazgJ6PwVwug8iBHIl2CcQtwNVdWCf2P0K/eknM5EZ8e4fjcUv8505A=@vger.kernel.org
X-Received: by 2002:a05:6402:458d:b0:66a:3390:30bc with SMTP id
 4fb4d7f45d1cf-66a826728a0mr2218507a12.15.1774444152446; Wed, 25 Mar 2026
 06:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324143342.17872-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260324143342.17872-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Mar 2026 14:08:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVv5KUma8=2T+ibnXyH+45xvqVrQaPho0CSzP1_r+j_hQ@mail.gmail.com>
X-Gm-Features: AQROBzDnZXf3SxdSqv07tNfP3QRyp5IV9cnubTU8PQao0RladIsBN2aCe5n6Z3Y
Message-ID: <CAMuHMdVv5KUma8=2T+ibnXyH+45xvqVrQaPho0CSzP1_r+j_hQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: sparrow-hawk: Reserve first 128 MiB
 of DRAM
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,kernel.org,glider.be,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-230341-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_PROHIBIT(0.00)[2.98.90.0:email,35.195.70.0:email];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas,dt];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,glider.be:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailbox.org:email]
X-Rspamd-Queue-Id: 2293C3259BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Marek,

On Tue, 24 Mar 2026 at 15:33, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Mark the first 128 MiB of DRAM as reserved. The first 128 MiB of DRAM
> may optionally be used by TFA and other firmware for its own purposes,
> and in such case, Linux must not use this memory.
>
> On this platform, U-Boot runs in EL3 and starts TFA BL31 and Linux from
> a single combined fitImage. U-Boot has full access to all memory in the
> 0x40000000..0xbfffffff range, as well memory in the memory banks in the
> 64-bit address ranges, and therefore U-Boot patches this full complete
> view of platform memory layout into the DT that is passed to the next
> stage.
>
> The next stage is TFA BL31 and then the Linux kernel. The TFA BL31 does
> not modify the DT passed from U-Boot to TFA BL31 and then to Linux with
> any new reserved-memory {} node to reserve memory areas used by the TFA
> BL31 to prevent the next stage from using those areas, which lets Linux
> to use all of the available DRAM as described in the DT that was passed
> in by U-Boot, including the areas that are newly utilized by TFA BL31.
>
> In case of high DRAM utilization, for example in case of four instances
> of "memtester 3900M" running in parallel, unless the memory used by TFA
> BL31 is properly reserved, Linux may use and corrupt the memory used by
> TFA BL31, which would often lead to system becoming unresponsive.
>
> Until TFA BL31 can properly fill its own reserved-memory node into the
> DT, and to assure older versions of TFA BL31 do not cause problems, add
> explicitly reserved-memory {} node which prevents Linux from using the
> first 128 MiB of DRAM.
>
> Note that TFA BL31 can be adjusted to use different memory areas, this
> newly added reserved-memory {} node follows longer-term practice on the
> R-Car SoCs where the first 128 MiB of DRAM is reserved for firmware use.
> In case user does modify TFA BL31 to use different memory ranges, they
> must either use a future version of TFA BL31 which properly patches a
> reserved-memory {} node into the DT, or they must adjust the address
> ranges of this reserved-memory {} node accordingly.
>
> Fixes: a719915e76f2 ("arm64: dts: renesas: r8a779g3: Add Retronix R-Car V4H Sparrow Hawk board support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> @@ -118,6 +118,17 @@ memory@600000000 {
>                 reg = <0x6 0x00000000 0x1 0x00000000>;
>         };
>
> +       reserved-memory {
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               tfa@40000000 {
> +                       reg = <0x0 0x40000000 0x0 0x8000000>;
> +                       no-map;
> +               };
> +       };

Obviously I don't like this very much, but I agree there is not much
else we can do at this point.  Shall I add a

    /* Temporary workaround for broken TFA BL31 */

comment while applying?

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-fixes for v7.0.

> +
>         /* Page 27 / DSI to Display */
>         dp-con {
>                 compatible = "dp-connector";

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

