Return-Path: <stable+bounces-249592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMWOC8FqDGo8hQUAu9opvQ
	(envelope-from <stable+bounces-249592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:50:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E01B580037
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 15:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D933080FBF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 13:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F223E3BCD17;
	Tue, 19 May 2026 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5DffAy5"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECAC34041F
	for <stable@vger.kernel.org>; Tue, 19 May 2026 13:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198293; cv=pass; b=PP2Td9iq6aY7REmOoUYfBVcnVg8ymazyE8zokHb2mDm0Viu6sZnoMxN+PqOGZT8Mg2JPm1BnC3MYQKvomYO10RqE9x3OyerPMyVwYWAAR6xNKuJ+Eb62LHr0MXzDUdWFvkau7NnQzwSSJAUH7l8jjm6lzXobRi6WuEZOyz9he8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198293; c=relaxed/simple;
	bh=TPvCxuHJtKVGhQ/GlHUaH8cPjA9QMgDJQzp3fZRPCXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jw0R02chdlU48CS0Ay18ei8Bqn1bayrlPl/sZJqzAHXFux+z89MEr6nOovt3tlsSrInfmLA2/ClqsuOLP4WTz18Zo6KQed6rFWDSyZn2ZGmwRiZh8VVCYISY8PYJAO4DJ9G3QhzEOwWwbMU/SlxWy9zlRTQgnuCqBR64snd0JZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5DffAy5; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65890a6ca20so3956626d50.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 06:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779198291; cv=none;
        d=google.com; s=arc-20240605;
        b=IK6tfeBmwZp2OFZcvq3cg+FWJe6v6HI+RJ3YxRJIbannBRVE5nSKVUkUVVvyYhsii4
         OcJ3S+ZZysQmy2OhcFyYsdDW/fWMHZkFpOd9qLidC0L8JaFmg1r9nq97EbPhhvHGvFfV
         WPjbpz8yrJ/2RLrrpH7UtGrT92TFjEdwxcpYHL+tF1XPQ8KFOvUic1kTsHzudrPan49H
         DrQ9Z5ZJmSMwRctDn8/thYxlhA61vn1fskxJdF989i1V35pKZWzYXxj0bYTE4UFg3a+O
         rIoQN89No9ASdJNZz1VyNCcv1v/qtlsb6OcrQL2adyYYHtXeL67sXGmf7HA2gTya3KZU
         9aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8vQ2huze1xO1NqJdBFnf6nbs9kGsrUpnagEQxYLNrLw=;
        fh=kHrJoIcCMl6kMH7opqfcpCz32TIstN1ioteCEuSbbp4=;
        b=CHPYuMJx0gVxCWyTRPNI/GqxKn36uXELShECwf+53FjehfTRv5q/Qd730YGK+XJrF9
         DBSmqcVwswCUxZZnAp+J1qCbdyyjh5fn/5jEBPhGbh0NuE1NusOOOKkK14ZNx/ELqpxj
         oSRfs/IXUD3WtqhS2sbiimAFJa5sRV+fWPgd8oxrW3mAlRemPuE3XuNKGaEA7MPAtZTQ
         xdLPfKmcjRGvzlpM+4cVOEFy7s2yM7wktd4ToMIcoJcminhCJjx+WSYJ3WFqwCx66xtx
         hdVSlfrhF1KytAlqMLYpAhnIN5CJ6xH7e6enPoWdWW4Mdm0QuobkqawkDTYKSXRO2UZj
         iTbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779198291; x=1779803091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8vQ2huze1xO1NqJdBFnf6nbs9kGsrUpnagEQxYLNrLw=;
        b=e5DffAy5YmQTHnCkxba0f59RXxKgLjRM56xRjEt56UTVgdcmoyLfLbbjjl751b45Bg
         9IYFIbiyqN5DdOlpywDf6Ssb4Gg2oNZgX/6WpKBPV43CR7a/rfAeFZAlqW+pN73WLFGr
         ptdzW7ne1l2Rhrwp802akVViUwo/JK6MhvgDMM2ZJw1m6AX0tkOKSnd4/MBLWbFKuKHN
         zBMGyDcmKRLKyasmpq3ClzUbpl34hd7+Vf8IZqlps2gyT1/4rwklVtPsriByd/f3IrV+
         pt4Eg/4c34h0swJ7rX9wFoU2Ya/Ij8sibcssFB5SL4YQ1aoLSvv5eIE/LgRApxqPCzph
         DxHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198291; x=1779803091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8vQ2huze1xO1NqJdBFnf6nbs9kGsrUpnagEQxYLNrLw=;
        b=QM9p4zjrGB9adUabFAwm8OAaK6yUaO2G/FmvrY5TD+xTIBR+Oz7SrUCg/mriUnMO4e
         lricfSZsQfr0pEg/SNWJuxIBH7xZRREPXCzq54pwHtuyW2LRlwfxHySmNL4FmcuA88gh
         gwn7ZTIuQIRMq3c2Epy1Xa2fktVyiWDzLgJdYjpcJg8Ut9MO0NYeS5LSfW0pdW2d1DnN
         omWEB72AUwv1QendwVFLzV6vOjq4wP5hmrv1iEoCymn5Jdvg373k6f7Y5IIyQ0iGqbDf
         qXyjQkhyIYX8HpWzKBAscRLdzxVxEVXXjMtdpFt7wH4iwD4S3Iq4rrz4GP9lxSJ3j/jt
         zlqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KFuxhuB1GMZ+rGtw/bcz4wcmbhQ0igdrUUAh4ncnVtIRmNQTWhn0w8YEjIss52fbigS3IuRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Boc8ZQqdAat6LNo0vYpHy3cUN3HNVBLXsoAxwhIu+E1WQfMM
	Z3jHQmVSN2aaCr5KTh5M9wRt4/zRKLLgiZC+WK6fZysJ0/1wFIC30YuoAPMqFr3KElEYW3YFKDr
	q7wh0frScS729OJM1R2B73Q9YmBDpxIk=
X-Gm-Gg: Acq92OEFPYBemf+xnElzwqoQb31QPOJPiYfuMRD2Cz6su7hOL/NNUzR85tWI+yf0PRn
	swXeNgn+cPKi25mc56bTRdAi8besYpmP7B+zptz9CTsJEzPr5d0TH0Oue9ztygtuR/3eXdwYV8H
	dhLpi7wkjPMLEqozS0jXwBmk/UvYy38/uMTYyayYLslrBQgueCjZzrvfHY2LkNb8U4BQi6TAGLx
	dbrU3VKP10AioGLm195fxjoO19POCMdxlc6/e14/12VHD4fKBnaIDbW1TMBfEDB2JWaMRFg8Lxe
	87MHpOWeimvTy6ebU6O+zCBHtqdLsJGLkZeOEtvqjFRZ2r0jm+QVFIr2e4TlPSRw7k82tQ==
X-Received: by 2002:a05:690e:1586:10b0:65c:17fe:6d49 with SMTP id
 956f58d0204a3-65e2287ddbamr15415688d50.61.1779198291234; Tue, 19 May 2026
 06:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514172340.1515042-1-luiz.dentz@gmail.com>
 <f5cf1c30-48a4-4102-ae00-b74cf02e639e@leemhuis.info> <4946f5f3-b7e2-4949-89f7-6427015027c6@leemhuis.info>
 <2026051954-revision-sierra-6bb4@gregkh> <eb5301f9-3133-4fe3-b358-61f14d1ffa5b@leemhuis.info>
 <2026051909-impurity-nemesis-2f65@gregkh>
In-Reply-To: <2026051909-impurity-nemesis-2f65@gregkh>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 09:44:39 -0400
X-Gm-Features: AVHnY4J8lmhWqH_MENNxHDU5i3eOmFVjrJt3J47QyY0UJsMFJDc4Qg43-D2Njck
Message-ID: <CABBYNZKKbTXc-okp9P2OncMYXHX9C1XC+pRC7XWOhv-8nPNZ5A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249592-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,verify-fixes.sh:url]
X-Rspamd-Queue-Id: 8E01B580037
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Tue, May 19, 2026 at 8:07=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Tue, May 19, 2026 at 12:53:49PM +0200, Thorsten Leemhuis wrote:
> > On 5/19/26 12:30, Greg KH wrote:
> > > On Tue, May 19, 2026 at 09:04:38AM +0200, Thorsten Leemhuis wrote:
> > >> On 5/15/26 17:10, Thorsten Leemhuis wrote:
> > >>> On 5/14/26 19:23, Luiz Augusto von Dentz wrote:
> > >>>
> > >>>> The following changes since commit c78bdba7b9666020c0832150a4fc4c0=
aebc7c6ac:
> > >>>>   net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:=
12 +0200)
> > >>>>
> > >>>> are available in the Git repository at:
> > >>>>
> > >>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoot=
h.git tags/for-net-2026-05-14
> > >>>>
> > >>>> for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c=
00282:
> > >>>>
> > >>>>   Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-=
14 09:58:08 -0400)
> > >>>
> > >>> It seems this PR sadly came too late for this week's net PR to main=
line
> > >>> that was merged yesterday.
> > >>>
> > >>> TWIMC, from my point of view, it would be great if we somehow could
> > >>> still get the changes from this PR or at least the btmtk fix it
> > >>> contains[1] to mainline this week before -rc4, as it is fixing a
> > >>> regression known since 2026-04-24 that at least five people encount=
ered
> > >>> with mainline since -rc3 due to 634a4408c0615c ("Bluetooth: btmtk:
> > >>> validate WMT event SKB length before struct access") [006b9943b982 =
in
> > >>> -next].
> > >>
> > >> Greg, Sasha, that [1] fix I was talking about now reached -next as
> > >> 162b1adeb057d2 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL
> > >> events") and will likely hit mainline on Thursday or so with the wee=
kly
> > >> -net PR to -mainline. If that's good enough for you, I'd say it woul=
d be
> > >> good to pick this up for the next round of stable kernels.
> > >
> > > That "Fixes:" tag is referring to something that is also not in any
> > > tree, but that commit does have a cc: stable in it.  So do we need bo=
th
> > > of these:
> >
> > Valid question, as yes, there is a slight mixup here:
> >
> > > 041e88fb0c08 ("Bluetooth: btmtk: validate WMT event SKB length before=
 struct access")
> >
> > That is already in v7.0.7, v6.18.30, v6.12.88, as 041e88fb0c08 is the
> > -next commit-id for mainline commit-id 634a4408c0615c ("Bluetooth:
> > btmtk: validate WMT event SKB length before struct access") -- the one
> > that is causing the regression that I want to get fixed. So we now only
> > need:
> >
> > > 162b1adeb057 ("Bluetooth: btmtk: accept too short WMT FUNC_CTRL event=
s")
>
> Ok, but that "Fixes:" tag pointing to an invalid commit is going to be a
> nightmare to track over time, ugh.

Hmm, did we get the wrong hash or something? Usually, that would show
up in the verify-fixes.sh, but perhaps it didn't capture it this time
for some reason, perhaps I'm running an outdated version or something
similar.

I will try making the Bluetooth CI run the verify-fixes.sh to detect
this sort of issue early on.

> I'll go queue this up now, thanks.
>
> greg k-h



--=20
Luiz Augusto von Dentz

