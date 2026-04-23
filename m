Return-Path: <stable+bounces-240494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDVvKTEj6mnKuwIAu9opvQ
	(envelope-from <stable+bounces-240494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:48:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 201D2453420
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 15:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D2DA3030571
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056972C324D;
	Thu, 23 Apr 2026 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILRKhLsf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C32C11E4
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951387; cv=pass; b=obNXglT6aI7ssECUU2az70H+/U3VILZa2DmR8WdjLk3CPpeCBlRxUh6dp+eUcCyanTNwripdy3yvtnyKvUGcSdY1SWhsBUtsa+tQKYYmQl8dvnpL+RnpA2yhUFvMaPerjiwSao0xXOveS5A/LTE2hFIh1trHlbK+JpoSTQj/ii8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951387; c=relaxed/simple;
	bh=F/cep53Ywkv6YQpg2IYGnHWs7tOX/EjkwJiVvWu7UnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eV/oRMRbIqGPHmigMn/HbWVnO0VCvCFBy+zsxv0clUfjBqhiNDCLHvgnswmSvyQQZdQDVbLTzj+XBqJ5Pv5s9LuBF1CjcVZJq8SfWhKSU0zE3Xrc9GQtiFj2MdaDVer5hH+2m0Mm6O9odPc4XFfzyKtt4x8JOfJk//QcMeyicg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILRKhLsf; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c7963df6f17so4437698a12.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 06:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776951386; cv=none;
        d=google.com; s=arc-20240605;
        b=E010F19BSUONewj/3vkuA6X3hoVn5G3nE9MftVmQa7RjLyS+Jo+o2QdlwViBgKsxMI
         4fg4sFOUEWNf06JpygMV7goXYBOr5HHsDSaXY2EYPmVQsIUW7PUMIeffXFUgZOFFIZWR
         be30b1gevuEq5UXeCIqUsuHdrzrU7Y4IG0vkMEQSmyDyzZIe5PPUxMG0uSxa7DmGOTvW
         fBfIDObOZpfstywBtWjFraLf9T7GXtTyT/oqZrKqQcZaK+S4qCq58J/j3UAb9zS2f24z
         +dQzXefrW7WhK51eLMHTmxC6yM2hyQt3XctYuVgkqSVB43me/W+WjYMtEcLBfsG+KAoj
         i5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VhuOOby+gqJo2HpDu1be6m2G5DzT3bivgrqq1vW5a5g=;
        fh=si+Uk+ldnz5zyi3hQC6JllhxCv/dYdAihees0/YuzL8=;
        b=KnbE5h7WhXmRJJ6D5QVTzcXYYrlI9kJS5KJtcQUicuFFWlFULFTjTZKQ9wSX5oiEJr
         hDES7/at5IAbHLhuxaN2e9EBQBT5/zDTSIE2UykrLLJHPS1cAJJbUII31WRRW1yxl8Bt
         XkYD65d56CDMY2RjElNuIWbR43bi5UDPh48WS9rogG24BY/HJvVnhex5tadctyQi/EBI
         v08Ig/vKRE05+7kio38DRqoZf6EnCe2rOCarvDakArdPrvtndM3eS0Ycby5gh897SvQK
         2UkQnkpQOh/HmrrHpbeotMd49j9pPwe+BaOjMD2WE8uzlhoxPR8yDG1GdpLoNbIdw38N
         Hydw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776951386; x=1777556186; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VhuOOby+gqJo2HpDu1be6m2G5DzT3bivgrqq1vW5a5g=;
        b=ILRKhLsfYxFOUP+1l8w/YFDDyzUiS7Pt3De07hqJbP467jZLMy/sjphkvyAFXryV2b
         XKwPx1N64YxdBYiHYs5hJclYE2ltHWHdWEbK7HeJH8omidnlgoCTqo16AHr3Ey7BYCfY
         iRB1k1P8JyTFM7ebXIA8HxlmPlu8Ftwln9MNuq2TzgV601V0zMP/xs9A74XIzqGOxm7u
         slL9IRfTuYTNNqiB5YBpFmn54JPK2jKxSRImY+HQZTymwOT4kF/IH9cAlPjpA+hJmoVg
         Co6e3dZwauZXTg5kNGTrv184F3GEDlOrk4bfAJK/QuqEoDS3kNFtMYfUP3uR02B9NFsH
         lSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776951386; x=1777556186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhuOOby+gqJo2HpDu1be6m2G5DzT3bivgrqq1vW5a5g=;
        b=l5ejcd9uGmlz0CsrwFr/Xo6TalxcWBG5KkdQIpBNgiYGXgPCB2EaZl0hAvc1m1n68p
         78L7ggkiXEaZ0ET9V1T4tmXQ6toWvS+jxd06tBhg9qEtldDhZ3AGR+ZFaewzKqIAGduR
         7Z/4MopfFYG17WzI2HQRrh665Njv9T87FUU6UZj2XJ9lRhVWRNuuapHzTAUrUgNN9YNz
         YwipRfw7Fp9d+YJ0d5UqvoEf0/xFU4H+yR0Zp6zL50kU6Wk9xdAMOAbxatkKYQg9aRFZ
         qi04E+RFSXf00EQsJtEh4QU+CMHbYlqkvfWovR1oubEFZkCxK8U9vnhNUFUwGkeFeCcC
         KtHg==
X-Gm-Message-State: AOJu0YxHBeg5lRHIwwpst4ngyVzuhDhqZt/sc2R5C0XoFBXe0W4wD4dN
	K0WEyRD3LtNfOXa4FiOUn36G0D85Xs4eOnPJ702QMLQ4QhdsbQdjsvFQFCspH+dPe8Ml0h/Ubnv
	tVG103TOjRNShk4T3+G2/ls/0hmUW2gw=
X-Gm-Gg: AeBDieuwr5NeQPzYzkxYAX2/xsbsVdzyqEr536mFSvwujG8snDMNVMXQSJIKTB3FL3l
	BLvOP0FPjwfQdH1FPegPsfXb8bXSdk+sqkcc91lAjTMn2wut/mzx7ku3e3Cl1BuA5PVnmln/IYq
	ls/3AdNHFYeksK0ZO9a6y1Ixv9euM5ni+MLB+70DXKuGDvdzNPOZ8xOA1jFcl3snDMH5ec0l9B/
	Ll4O9NAyckAHhzOeOMsF4kHycM+l9dA4x8/Qy82ovWunObaT1DsHYXs+EWbapqcBdiRUBp2keYz
	tE4AE+JX85EeUQ==
X-Received: by 2002:a05:6a20:728c:b0:39b:e789:7d20 with SMTP id
 adf61e73a8af0-3a08d8d9d5bmr32380807637.44.1776951385500; Thu, 23 Apr 2026
 06:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219171310.118170-1-aha310510@gmail.com> <2026042355-blighted-chewing-5e50@gregkh>
In-Reply-To: <2026042355-blighted-chewing-5e50@gregkh>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 23 Apr 2026 22:36:13 +0900
X-Gm-Features: AQROBzAosyDO_yslNQKDZhWDhMLXCShJ7vPs7duQruIbTcEGDHRZq9mj7spWcms
Message-ID: <CAO9qdTE0NhB58hqK8_1=69bD7uG_vF-FfpQXGR8dqcuWV4H2Mw@mail.gmail.com>
Subject: Re: [PATCH 5.10.y 00/15] timers: Provide timer_shutdown[_sync]()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, tglx@linutronix.de, Julia.Lawall@inria.fr, 
	akpm@linux-foundation.org, anna-maria@linutronix.de, arnd@arndb.de, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, luiz.dentz@gmail.com, marcel@holtmann.org, maz@kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, sboyd@kernel.org, 
	viresh.kumar@linaro.org, zouyipeng@huawei.com, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240494-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[vger.kernel.org,linutronix.de,inria.fr,linux-foundation.org,arndb.de,roeck-us.net,gmail.com,holtmann.org,kernel.org,infradead.org,goodmis.org,linaro.org,huawei.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aha310510@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 201D2453420
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 20, 2026 at 02:12:55AM +0900, Jeongjun Park wrote:
> > The "timers: Provide timer_shutdown[_sync]()" patch series implemented a
> > useful feature that addresses various bugs caused by attempts to rearm
> > shutdown timers.
> >
> > https://lore.kernel.org/all/20221123201306.823305113@linutronix.de/
> >
> > However, this patch series was not fully backported to versions prior to
> > 6.2, requiring separate patches for older kernels if these bugs were
> > encountered.
> >
> > The biggest problem with this is that even if these bugs were discovered
> > and patched in the upstream kernel, if the maintainer or author didn't
> > create a separate backport patch for versions prior to 6.2, the bugs would
> > remain untouched in older kernels.
> >
> > Therefore, to reduce the hassle of having to write a separate patch, we
> > should backport the remaining unbackported commits from the
> > "timers: Provide timer_shutdown[_sync]()" patch series to versions prior
> > to 6.2.
> >
> > ---
> >  Documentation/RCU/Design/Requirements/Requirements.rst      |   2 +-
> >  Documentation/core-api/local_ops.rst                        |   2 +-
> >  Documentation/kernel-hacking/locking.rst                    |  17 ++---
> >  Documentation/timers/hrtimers.rst                           |   2 +-
> >  Documentation/translations/it_IT/kernel-hacking/locking.rst |  14 ++---
> >  arch/arm/mach-spear/time.c                                  |   8 +--
> >  drivers/bluetooth/hci_qca.c                                 |  10 ++-
> >  drivers/char/tpm/tpm-dev-common.c                           |   4 +-
> >  drivers/clocksource/arm_arch_timer.c                        |  12 ++--
> >  drivers/clocksource/timer-sp804.c                           |   6 +-
> >  drivers/staging/wlan-ng/hfa384x_usb.c                       |   4 +-
> >  drivers/staging/wlan-ng/prism2usb.c                         |   6 +-
> >  include/linux/timer.h                                       |  17 ++++-
> >  kernel/time/timer.c                                         | 316 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
> >  net/sunrpc/xprt.c                                           |   2 +-
> >  15 files changed, 322 insertions(+), 100 deletions(-)
> >
>
> Ugh, I got the following build error for this series:
> ../drivers/misc/sgi-xp/xpc_partition.c: In function 'xpc_partition_disengaged':
> ../drivers/misc/sgi-xp/xpc_partition.c:294:25: error: implicit declaration of function 'del_singleshot_timer_sync' [-Werror=implicit-function-declaration]
>   294 |                         del_singleshot_timer_sync(&part->disengage_timer);
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>

Oh dear. This issue occurred because commit 997754f114ef ("misc/sgi-xp:
Replace in_interrupt() usage") was merged into version 5.11-rc1 and was
therefore not backported to 5.10.y.

Since this is a simple fix that only requires adding this commit to this
patch series, I will quickly write and send you the v2 patch.

https://lore.kernel.org/all/20201119103151.ppo45mj53ulbxjx4@linutronix.de/

>
> Don't know what happened, but I'll go and drop them all now.
>
> Do you _REALLY_ need these in the 5.10.y kernel?  Who is going to use
> them?
>

You might think it is unnecessary, but I have seen bug patches related to
timer_shutdown[_sync]() being backported after I backported it, and I
believe it is well worth backporting if this feature allows various
bug-fixing patches to be backported smoothly.

> thanks,
>
> greg k-h

Regards,
Jeongjun Park

