Return-Path: <stable+bounces-249632-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIljNiuIDGo1iwUAu9opvQ
	(envelope-from <stable+bounces-249632-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:56:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 83022581D45
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 17:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E84AE30858CD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA5C3546CA;
	Tue, 19 May 2026 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEiXkpkR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832A433B6D0
	for <stable@vger.kernel.org>; Tue, 19 May 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205802; cv=pass; b=kh3xX6k3g+Hb854HWu5wuACAwbI+F0eHbWS6B5hD+Zi0WhYb4gSp9aNZobqDxL/KLvUKR/oZt+RnYRsJGP0T/FE/ksi8ekLdTeYRjAqoKlVKZZ8BTI8VxY2O9MH5NM7Qj5yEFaLmsJsIN51xZydFXqiDdMLl4gynxrYB536XMFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205802; c=relaxed/simple;
	bh=x/7cCwdNDXXJxtXg1SGsgN05u2+rsVMZSWA2qFFjjh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZ9HDUX9OdJDUA/eF2K+WMUjXfVrmWBtGZ2j7p4bzIkgNGR0AntfbfYFBPlTP08mA7UMUST+tjSJAzIWyb2TM71+YJvx3paPXGtIExEC2Risd0ODTU7oNUYZdlyoBGHlm532T1lss+P6aht0WRQ9BrP4Wb+N5ZASXbS0RmRhtas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEiXkpkR; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c477a3278so3957582d50.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 08:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779205798; cv=none;
        d=google.com; s=arc-20240605;
        b=dVM74bRGDsSDQd+/Hlr2YfzqmrTsGf76NMCZgawSK/cyIriE8rMzTVMlbhYCX+NcZV
         SkvvezEnYPhTAF5vRXJ3VQPPapyiQpz7fqKWu8nfqqGV+0CDxAvEpL1ddf48yyWfLkmA
         MUUCmT98cT3imUNmvvt00cR8VMpyQPJ78GIq+wi938qIyZbPcEY0IkGEDqoNOwqQmcUu
         cWDHC43dFbSgv4zV8SaULcaBRoo6MwDj4xJ1d0za0dUglOAjzEqN0TAmcsMNUMhd3KYv
         qUuNQKJRv7HEtVPIZ8lX3EWn1kxGRLfZ9tENthYyqQm/rkX84agZumpR2b/tLJp1YXAO
         o4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=svXaO9Car/cL1x6P0kXNjSbwoRo/ZLSYkrf9JDZDMqE=;
        fh=QO0/2+8tFDIbJbI4XddBcVTsil2EGIcRIPIRQw0tChI=;
        b=IEZc7SBS4w8gCEWA7r1/F5rsI2wCAph0aPU8EUrBN3xvcqJ4XRm+JzVbBuhzg9pmKC
         WiSA7EJ44dtu9Ww8sykd70sQlslw3WFzukfAqoOXFqxRZiE6DzGRQicblHLs7hOArK7t
         cFOC5bomSCBETy9/7JrXkkCVgpL/BEU7Z0LhTUwt5gHtQzSq2+mOxxYUKKg8OIISQ1pj
         V3gq5AnzNqMyXpIYTocZP+hO5+LjEplCP6SY/Jhm1pIxWNe8fRuabcG6wigXuUJ9cC+R
         tGsr/omoED9Z0S/qGtOtEQuKc3zj21yNh+WfRU9LrRbQ/oxrms8ga7QDDtQhnOfD+pWZ
         K8Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205798; x=1779810598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svXaO9Car/cL1x6P0kXNjSbwoRo/ZLSYkrf9JDZDMqE=;
        b=QEiXkpkRj4+tE3U+2AlitOx/CXjgde+D3wyFc+K/ivxh2pXy0UmTqgrtXuqMm68o1V
         jOZkrPoI1ajdVVx6Mlz0Z7jN+VSM8k84LKF0NZAUCLgnZS8eNTSxAXSZZ/QGhTpmjoi2
         cfUrsM7wBc7xOOos/MtU1uyfZqKSkKqhfAImmnQte4ywipgLktjLiuSGOarn2fD35y3G
         lMaa1Z8nt6DZA/18qQaXmFlA7lnM0e4SnMgqAnW53oKmw/q8ZmaJedqbOKSrrhQYw4io
         eUF6rjZIC4zrgXcW5KyaXU9XYjEe8NMJLeNUFq9xf6GJUHYFsfbmTkHPRLlnpSilp7hF
         yw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205798; x=1779810598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=svXaO9Car/cL1x6P0kXNjSbwoRo/ZLSYkrf9JDZDMqE=;
        b=iXkeGvA41OjtizYkcstOlajoLVUxGNsbgmA9Tr9ufOajcNqAC6GrM6BLvrJCl5yw0a
         xbhOrhCl5N6Us3SlUslRY0+3jnnq5Zo3QTTJPGwgANov7/olsLE5kIqtnMYLEITMsIpP
         TMUmsIKeZhs9CuMVs5un8GcOHCrByf5U82797BJsYou9f6I9f5C5BhHsjF1RJeHnQSNQ
         7TD97C7Z/QTe83wzCwRbaIajbkaKb4vms782pzrcUjqOwuBb0WCLVcClHawGZSS0QGcy
         pKNe9dvQUAYWOSnaFhrUYt151xc1P9bI3Zj73b38jDTIrF8MzKK2lq+qgQ4smpScOoFI
         BuPg==
X-Forwarded-Encrypted: i=1; AFNElJ8gLp4WuHKEBSvyS7iFwA7M4cqZeFatxfMs3hFAEMkmFOLdXSgyaqeEY8NIiUZc4MVWxzQpUNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLh3enT6732ZqQpqR4IiAaF8RolbOluQoPAX6GxLxS3QznTgUS
	QyEuIsFt+Ak1WZcJxyUJoBwqo+j/AnG90XR056onYbwl8D6vGLRA0lFdOuEDqdkahlBys6PydUu
	6ire3Nuung1VSPgtrtSz0QGr2znKRLfE=
X-Gm-Gg: Acq92OHMov2oglvi3P4rdTo9Y1HOETTMlMOmcITStsPg45DU0Ig+fQ2Lt1aqNLtond6
	vXVL4WoHKV2gHmaPhPJbnMhPIFwSsVoTAnmvDVtv7d7xIIi/boEPaz/HkdCrPuICc3iFhOpfv62
	VzxDEZSLELFycdB0+zop2fCg5hGXKgEhrRLuQklteFOJ57CwXwQsCfKLH/3cLX99qzTvxeI+FRR
	9CaAmSxMhelMY/E3Mh1x7kvUBBK3X/rLsCeOV8vNYZ4SeoA27ikARpIA8Z6rReN+GDywCgA6KCl
	lReaZf1QKTyw6gc5zIPum4Kz3B9hdMbtPQUB+FQirjpCXH1HNLASNfCkfI41My/DrobiwA==
X-Received: by 2002:a05:690e:12cd:b0:65e:41dc:e8de with SMTP id
 956f58d0204a3-65e41dcecd9mr12441208d50.61.1779205798318; Tue, 19 May 2026
 08:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info> <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh> <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
 <2026051942-uproar-drainpipe-6370@gregkh>
In-Reply-To: <2026051942-uproar-drainpipe-6370@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 11:49:47 -0400
X-Gm-Features: AVHnY4L0X8LYGYt87xzFEQmSQ0jaH-sWR5xnvms9EdsiDiaiEGK8SYnDvpGiMU0
Message-ID: <CABBYNZKzWgL3nmeA=CtN9s80LRyDiJ97aQXgvfSm9vYUBw_SpA@mail.gmail.com>
Subject: Re: [GIT PULL] bluetooth 2026-05-14
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Linux kernel regressions list <regressions@lists.linux.dev>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249632-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linuxfoundation.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 83022581D45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Tue, May 19, 2026 at 11:19=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Tue, May 19, 2026 at 09:44:39AM -0400, Luiz Augusto von Dentz wrote:
> > Hi Greg,
> >
> > On Tue, May 19, 2026 at 8:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wrote:
> > > > On 5/19/26 12:30, Greg KH wrote:
> > > > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote=
:
> > > > >> On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > > > >>> On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > > > >>>
> > > > >>>> The following changes since commit c78bdba7b9666020c0832150a4f=
c4c0aebc7c6ac:
> > > > >>>>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15=
:17:12 +0200)
> > > > >>>>
> > > > >>>> are available in the Git repository at:
> > > > >>>>
> > > > >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/blue=
tooth.git tags/for-net-2026-05-14
> > > > >>>>
> > > > >>>> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6=
275c00282:
> > > > >>>>
> > > > >>>>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026=
-05-14 09:58:08 -0400)
> > > > >>>
> > > > >>> It seems this PR sadly came too late for this week's net PR to =
mainline
> > > > >>> that was merged yesterday.
> > > > >>>
> > > > >>> TWIMC, from my point of view, it would be great if we somehow c=
ould
> > > > >>> still get the changes from this PR or at least the btmtk fix it
> > > > >>> contains[1] to mainline this week before -rc4, as it is fixing =
a
> > > > >>> regression known since 2026-04-24 that at least five people enc=
ountered
> > > > >>> with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btm=
tk:
> > > > >>> validate WMT event SKB length before struct access") [006b9943b=
982 in
> > > > >>> -next].
> > > > >>
> > > > >> Greg, Sasha, that [1] fix I was talking about now reached -next =
as
> > > > >> 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTR=
L
> > > > >> events") and will likely hit mainline on Thursday or so with the=
 weekly
> > > > >> -net PR to -mainline. If that's good enough for you, I'd say it =
would be
> > > > >> good to pick this up for the next round of stable kernels.
> > > > >
> > > > > That "Fixes:" tag is referring to something that is also not in a=
ny
> > > > > tree, but that commit does have a cc: stable in it.  So do we nee=
d both
> > > > > of these:
> > > >
> > > > Valid question, as yes, there is a slight mixup here:
> > > >
> > > > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length be=
fore struct access")
> > > >
> > > > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c08 is t=
he
> > > > -next commit-id for mainline commit-id 634a4408c0615c ("Bluetooth:
> > > > btmtk: validate WMT event SKB length before struct access") -- the =
one
> > > > that is causing the regression that I want to get fixed. So we now =
only
> > > > need:
> > > >
> > > > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL e=
vents")
> > >
> > > Ok, but that "Fixes:" tag pointing to an invalid commit is going to b=
e a
> > > nightmare to track over time, ugh.
> >
> > Hmm, did we get the wrong hash or something? Usually, that would show
> > up in the verify-fixes.sh, but perhaps it didn't capture it this time
> > for some reason, perhaps I'm running an outdated version or something
> > similar.
>
> Something went wrong if we ended up with a patch in the stable trees,
> yet this fix is referring to it as a different git sha.  Don't know
> where the disconnect happend :(

041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before
struct access")

I don't have that in any of our tree either, this is actually
634a4408c061 on all trees in the chain:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/com=
mit/?id=3D634a4408c061
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=
=3D634a4408c061
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D634a4408c061

Or actually that was the hash before it got rebased on bluetooth-next tree:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D041e88fb0c08

But I didn't send the PR from that three so perhaps somebody else sent
it to stable with the wrong fixes tag?

> thanks,
>
> greg k-h



--=20
Luiz Augusto von Dentz

