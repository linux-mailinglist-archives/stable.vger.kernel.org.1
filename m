Return-Path: <stable+bounces-225655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDncIndLuGlTbgEAu9opvQ
	(envelope-from <stable+bounces-225655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:27:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F9E29F056
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 19:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D013047E7C
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 18:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934D3DC4AA;
	Mon, 16 Mar 2026 18:26:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A943DBD5D
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685592; cv=none; b=WYgiUGJ/xL9s6aNUxt8C7L0zzZ6borcscCW8iXBg6AE7/dvDV4s6EytPt33bQfbAxZfqe9f/pL+BgbUhYmYtk3/e/uj9ood/iPkENw+eqzvpCJEvHxY7GSGYmgIkEIqOgeixJZOzX61X7igkDTxhiy99JHyTd3iyBsP7yNzrtzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685592; c=relaxed/simple;
	bh=eLT608Iu65e75yFDY2ephL+DnmrFksL+EdNUoRvOM1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3sjyuKMma6/38Y7rReOrWwMz1BIoIkzvjymsraMx3p6WKxOo3MDhZTra+0pSrNQ9jdyUrCjzEoY9CPUw4My1kqB63YsWhok3OazHqjV2v6NdyHLwWJDnj1Lv525LE7b/pklKqBdZ6PsU7/1VwdootKvLi16m98gCD8VtoVZZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56b679e72d9so1270881e0c.3
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 11:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773685585; x=1774290385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpQ1JDIESkHS70bwkrVznor7mYifAlL8o6+MvzPijrw=;
        b=OKop7GX5QV3gmc+iISVQQp4y4kJM3H72zIS3wlJsFmnOFrKzbbqjtgP5m9/SvH6vrN
         AEBjpXg7WYjzglUHnOqRhogdSF3kw2eCpZ4TUloVPS3DPS4Zg43eFfHsbsY7eZMXKGBf
         vRlDWYzcaXreuyUse4FQ8CAQSLhYZZwkuaoNZE+7veEDdqlK1MyiFTuWBVHZ8BTHJB3V
         gDR2b204CCSgUr42/0GhHlLZ4JeYVAHYvujelacy7sqEVgojDN5/UeFPXBbus/ZKa15S
         6D/7LtjvHA9XtIknb6tNHivJC64WMr61kuYx7/IQAC2li+q56oVRk+QcHkU5KOYrPXJO
         dIvg==
X-Forwarded-Encrypted: i=1; AJvYcCV4z9Xb194b6ob7TxrcdQiAUYDBxjyMZK6giI3bdMPlYviOnlxGNS2OEqo7/mhh9zc74+7CTj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwysFAqdaxMhz81zFGkB1ujeod1TGsousUw+RjuIhsnOpBCsEKe
	d4mtaMcpoSnljCM4x5U0fWVpfzBhuhhqLSF7YbgHqH94DqFMk/vwrNWGIIDkygFs
X-Gm-Gg: ATEYQzyzkp9z5OmOmATkcVeI86eYdY+Xbfz56ivqXuS32uZAqXNUdkvj0kJFBn0b+uD
	AYgn4fNmTOg7OKUt0aoAtfVnpUKecY0uxXtzk/nrxyyd81BoPQF5gaaKPs+P4sGleN+G+UUNbR3
	Wr+RhaqjGtLAjOrV8OgxhINQ09dJNCwRjmiIbTCYyGWgLj31Nedyw9V8Bdd9EHA0TV9fC+GB1oB
	pIAbin5bRftdr5fn2FJzGfgu5d1HF2OFDDUtcvu3gZ0Vh6qXkzVelq/EkQLi8Tr3Z8A0wd7Pyii
	cxaXsvKf/tBSy8S2G8VLVSSZivuq+2TAPsNdz6OtsS2cZdzt/yNofO8f+qX0Wz7JP2g7tHwyWwP
	JeOt/DSspD1FBOl/Al3pkRmIuHZe0EI9hSyq2kkWFsPAngR3et1oMY6w9fBhUqobKhUVU0Vp8ch
	CZDkLzm77uRbgHDgday6y+D/xrcGMOyd0lbr4vkhSIs44SGhzmx/7AfuZaQIZImbGE
X-Received: by 2002:a05:6122:4581:b0:563:80e6:3b76 with SMTP id 71dfb90a1353d-56b628488a1mr5137577e0c.7.1773685585129;
        Mon, 16 Mar 2026 11:26:25 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94ecff69249sm6181773241.12.2026.03.16.11.26.24
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 11:26:24 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-56b679e72d9so1270868e0c.3
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 11:26:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuRSuJF8Eqy9PZS+Uwlk8T2f45vr8Dlg6TqqUr1NrxoEnr9xeGOSO/RnAfNFR27ZMy5vfAS2g=@vger.kernel.org
X-Received: by 2002:a05:6122:6286:b0:566:2711:d8ab with SMTP id
 71dfb90a1353d-56b628474b4mr4749468e0c.6.1773685583889; Mon, 16 Mar 2026
 11:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros> <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
In-Reply-To: <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Mar 2026 19:26:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com>
X-Gm-Features: AaiRm52-cBzLFzQh3BVzaTMxkTLnHu9mSUGosGUtI9IHFak7XQqS486mq62zz2g
Message-ID: <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd channel
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-225655-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.871];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,renesas.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04F9E29F056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Cosmin,

On Mon, 16 Mar 2026 at 16:52, Cosmin-Gabriel Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)

Unused sibling_hwpwm?

> {
>         if (!rz_mtu3_hwpwm_is_primary(hwpwm))
>                 return hwpwm - 1;
>
>         if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
>                 return -EINVAL;
>
>         return hwpwm + 1;
> }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

