Return-Path: <stable+bounces-235988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDGgFXDR3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:20:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5173E3EB30D
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 13:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23BB6300533F
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F9635C1A9;
	Mon, 13 Apr 2026 11:20:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A96237713
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776079210; cv=none; b=RFxTi7MhjpAjt6ihY0ZEy0MPDBZI6dgOw28JuGxwyUAn54Vv0Hu7K6KzRU2dObzQss4cErBPBeNlh3ufwl38eZyIyM/1lFMd8hhxF/XHV9mcNqCis/9W3R97Od4gCSnPpTrn7/sZQPwaO0MSu4oFWpy58iNEfr7OFHjOSHhvULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776079210; c=relaxed/simple;
	bh=rDqDIcDjUb0VpL3FU/kMhZXqPYmOWlUOOS1/0cEl8S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFkNPY9KKrqYadQqqpiS4vzx2fxfSmK+JWZ9HR8FY3Uo0xGlgnzKsniUMDfhABIz01HOEGoVAN8CqslwyEneMCoooKtUvNr3Db7hPC261LzyQm6BDzNPHGMgBttkv+9GbLT9uRPlHuA9IDSwiTS1i+G/I0XKMo9go4t8+fAQYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-60fbbac2938so252378137.1
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776079208; x=1776684008;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spY+sCtjjyNHa35V5Fv1YWHcDXm5PFGT49jlGmNzKes=;
        b=bPpAGan5Les2vlkkJMzQA+7ZcVCP72GIZUT6Hk5GMtmGV/1Uc6xzVCCMTG50BfXUw0
         9wsEN8dCKHqnDE3Fu3BGPdTaaNrAAU8hwfQffI1jf/NjcGrfIUtZ32fCqmFOEOCsTs0M
         4K7f7BBvvPF9Wn3T7Rp+ijGRr47lMAAa/lM8Hsd9JJVsTtJU2/5LfF4E0NDfM0dePBXg
         L6GvUrK/Iey5NBk6te384U6KRYIgi/4Ld9HmfCG57EVnam9FC0jkDeA9lXwBODfYx8UB
         c6NG96Arqc9NV5dMD717NozJi5YSAG7nGhjwl4uK+HlQpRnbqONiEE2bZ60Ljp9bdzZA
         JoNA==
X-Forwarded-Encrypted: i=1; AFNElJ/IfphsYfXqVXAdNSKY+WRrXWG1QNLkc5Y9biSfqcL/NQ6lCRrfpMJsbULegQNkKRJuTzj9Eac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw44qgLmRpD5dtpFp/D8QO3MQkqjH3E1HM7y4uncxX8IBvM016Y
	qfY7HjQ1VAOvgXW3I6C0uBL11xd7s6UU91ZA4oPdFH7QJdkhu4xbQbOzC8K3iBOm
X-Gm-Gg: AeBDiet1Fne2D/cn+kodcFjpGsDNIsYqDXwJvWYEwmZlTFlmGtl+vbTbZ4ru2hJuY3J
	C86cvrzgKJwwhxX+xab1grfgWe819VMcFkOvhbKnEPjH/EIK+rhHPes/H2zYrOQ9A/zKXLVVYMm
	x+7aT3rr/BZs6WCXoZj+aDJeH4RhiBUFGo+PhcXLkT9fW6TL9/Da1QnIZsyACPFZLQWzwIYcCCz
	IDV1Jjr9rhZ5Xe0QrdA0+f0DtsneC2ZVpbVY5MZKMDu/oUAl3l4fG49WIo3utmqrVpn+8LsmOjC
	Qmc0zVnkrD+VG3PHTLOYgp3uT9OmX3EqlpUodP1opGOUmkFrOIZ1vh63jaPa/mbxgSrD6+aLXf7
	QYUm+x6ALZMQnN186FH+0KVcq6FaGTmbGrFnZQl+U1ip5c4htNZb8FpKLkTV/HBCJAxHmOAhCAg
	LNq72sNw3q0AIbgsaFku3BSlgZU/TiBHla1L+jhpnaaE/O1gZkU1H/lpgZEldOUfvaeq74VF5uc
	bA=
X-Received: by 2002:a05:6102:38cf:b0:610:2912:adcc with SMTP id ada2fe7eead31-6102912e1eamr367840137.30.1776079208032;
        Mon, 13 Apr 2026 04:20:08 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-609dbb1c650sm6000833137.11.2026.04.13.04.20.06
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 04:20:06 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56d958880ecso1349419e0c.2
        for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:20:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+d0dxmTub5t5190qEhaARtK8CRwX03nJYgNTcSuLZvJeG0i8O8Rc4FvEfURWZZJxxEEytwEVw=@vger.kernel.org
X-Received: by 2002:a05:6122:4896:b0:56d:3b69:87d2 with SMTP id
 71dfb90a1353d-56f3bd131bfmr5403354e0c.11.1776079205905; Mon, 13 Apr 2026
 04:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PUZPR03MB71159178A9463AF8E5C1B4709F582@PUZPR03MB7115.apcprd03.prod.outlook.com>
 <87wlyfeks1.wl-kuninori.morimoto.gx@renesas.com> <20260410085604.GD2712636@killaraus.ideasonboard.com>
 <87lder39bh.wl-kuninori.morimoto.gx@renesas.com> <2026041351-skyward-constrain-e6e2@gregkh>
In-Reply-To: <2026041351-skyward-constrain-e6e2@gregkh>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Apr 2026 13:19:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUi9gD_VsKrjiCLpUbb54TjB3ngvLLZQgP58v+-JrZ2Cg@mail.gmail.com>
X-Gm-Features: AQROBzCXS3Rtzm78Yt3IYT8Aw6T2DKFES7o9n_yRdY-kkisN_8hmyngBWofoPa0
Message-ID: <CAMuHMdUi9gD_VsKrjiCLpUbb54TjB3ngvLLZQgP58v+-JrZ2Cg@mail.gmail.com>
Subject: Re: [Renesas Linux Kernel Test Report] DU/Device Tree: Missing pin
 control for DSI-eDP IRQ
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, stable@vger.kernel.org, 
	Peri-Dev <oss-upstream-dev@lm.renesas.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Tong Duc Duy <duy.tong-duc@banvien.com.vn>, 
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, Duy Nguyen <duy.nguyen.rh@renesas.com>, 
	Chu Quoc Khanh <khanh.chu@banvien.com.vn>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235988-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5173E3EB30D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Mon, 13 Apr 2026 at 12:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Mon, Apr 13, 2026 at 02:04:02AM +0000, Kuninori Morimoto wrote:
> > Linux LTS v6.6 / v6.12 backported this commit
> >
> >       9133bc3f0564890218cbba6cc7e81ebc0841a6f1
> >       ("drm/bridge: ti-sn65dsi86: Add support for DisplayPort mode with HPD")
> >
> > Because of that, Renesas needs this commit.
> >
> >       8219a455efd4ba11c1d30c1bbc9ce853466c19bf
> >       ("arm64: dts: renesas: white-hawk-cpu-common:
> >        Add pin control for DSI-eDP IRQ")
> >
> > Could you please backport it too ?
>
> It does not apply properly to 6.6.y or 6.1.y, so can you provide working
> backports there?

Commit 8219a455efd4ba11 ("arm64: dts: renesas: white-hawk-cpu-common:
Add pin control for DSI-eDP IRQ") has a runtime dependency on commit
10544ec1b3436037 ("pinctrl: renesas: r8a779g0: Add INTC-EX pins,
groups, and function") in v6.11, so you cannot just backport it.
Do we really need it on v6.6?

> I've added it to 6.12.y now.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

