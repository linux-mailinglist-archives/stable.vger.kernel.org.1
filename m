Return-Path: <stable+bounces-241160-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JAajJAna7WnIoAAAu9opvQ
	(envelope-from <stable+bounces-241160-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:25:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 180784693F3
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BC8E3003D1A
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 09:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8387D330B29;
	Sun, 26 Apr 2026 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+xgjJRp"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22330FF08
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195524; cv=pass; b=oSfZ2/ytx97yyysU6hDCks9RmSg/A9FdjSgZyDfU1b/n/VEHG1UWYQ+CSiHGA8WoPG+OMRebVqg6rMjWusoXVXXCoxoMsR4qu86EGt5dpgT/lusEvaoawUIQANtU4QLm6NFl8KrUfvNNznxoBJY1e/r4TbXFuAiKMVoumAcxHVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195524; c=relaxed/simple;
	bh=OU9pMu9yMcFKNjEMU9/GR/Rt6m46Naa/m1h3Wyhk0so=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5aNDEGIKndI5jk6bs9gizvi1yATSRcudsqvY7nTwj36i6ykQoX7KNrHw4nNfEbVM8k5v4SeDaDdvyBo6GhcKGXm9gUIJ6ZhIXuOUtU2g5/fQ8oqjdhtkdBA9bpreGA7IypXBUpF2PZuygNNpZd990qXzBkMMJ1rcRNrYhHQIvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+xgjJRp; arc=pass smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-42321c8b8f5so7511610fac.1
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 02:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777195522; cv=none;
        d=google.com; s=arc-20240605;
        b=V548Jh8uuAZDUZu/H1Aa/6WNsHt59h2eTnyCxtOjOkBoVdOI8+CfjsUGwDpVzl0hwd
         WzKB3YP/Vc4c31jFiRWqBEFpjfqUpkc16NFY656kIwNQs5DxtNw2ssM4vjfMsLf3KTU8
         HTkVHITvQEQSmnl20/G2acGSP0yBxCvwSfyQ92bdOxzrQoobMrwdyLrJdycpy8DI4ZaQ
         3gNcWw486l8Z8MS0QfE5StVys5FXFTy3I94OD0oXegB0JHn76zGR2ZMmc9nmHP+YgBML
         BhWxxQOZML/uB1GJqD97L6el1I15Q06rulHsfDz9/00P9Yk+L5aGpX50N5reRrKPc4V6
         GdVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OU9pMu9yMcFKNjEMU9/GR/Rt6m46Naa/m1h3Wyhk0so=;
        fh=9VTjqs07aSYRI0OfFxihPJhaR1Q7mz9oqLM8lDNvsmU=;
        b=YX7c8mj4JKt86EwEFpwKi7bhFPmmV5yUB8VDWjxyPTqOShs07HbO2DIPN8HQYGFwDM
         VzyM6xspSQxCRx8imKFPf9TzSGF4hUQ9HDNWZXCLetiuFb38owkos7vpMYMU8YdA8hlE
         Nfiq1Ub4RIJEI7ivwBZoOqEu0g/wT/w4NesxYc5A9T1vsxjbZCM8H+RABUbqCc0SJHzG
         SmtT2b5FulnkAd8QxhR6BEagjY+vtcTIsGqL9J9y0DN2ZtQxFvB9nz8tgDVl2LXb+0/A
         22C9kNaL+Y73b5o11P6btN5PdhMBVDMOR0k/V7Ou/fqSKPKTYN32xpowZfAABiyLPvGG
         fZJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195522; x=1777800322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU9pMu9yMcFKNjEMU9/GR/Rt6m46Naa/m1h3Wyhk0so=;
        b=j+xgjJRpj03xxkRk/2CDiwYxgGDHImb1SUJf/QQ04oFbIDoX2sc0PgLE3JJz6oGAif
         qTfGNNWXy7YwP+n6WinPF8tzbYT67fAIYMH0xXBsKMukMbBgcn+COi8gnxaX/gjMS2kp
         aHuagDlsll9tqfDG0c03QRgiGOoFZYItFyJ4fBpEgfgll2seVE2CClJBmEem3BWSKFrG
         4Mf2XjlaGhCTA78gryB6JFo2rtt7SBTkUPaTxkowVYsk+ZSqRINj87npiPhNUUJV/fVD
         iktudDiea1/yQaMN/sFcF4qwl2PeSBVdqhyiLESbwmBLSjLyIfIgNs5CUCTuCYCbvqd8
         KQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195522; x=1777800322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OU9pMu9yMcFKNjEMU9/GR/Rt6m46Naa/m1h3Wyhk0so=;
        b=VIenemytGdUOpvKuejk6DDPcNrvjD0pRmh4kA5OrAMN5rDk2u5YYkLB7agShIN2vw1
         QD7R++VEi1p7/9sLOBujtJelRh2oqSlYvqZjN3LNVl8q4X+i1MrWytsS6AltedRK0JoH
         aIY+l4WH2spYA9Am0CwN6L/5fTJXnLw/weDDPC7baeT++FgwHh5XpvrDLHJRo3AXiAnX
         ecjt3La3NuhPvw4K+bl6gTX/qAzjBRpNk8PPdWtU29wxlNn+rV5xOr9qc8MDs/SG2A2J
         /V6TuTOJE/wWNVsxWvhU+W4G1KuCi1yGi/tEEi/O09q4Km0/tzoLlx/bv0T8hyVJqV4e
         NqeA==
X-Forwarded-Encrypted: i=1; AFNElJ9SPwNazNV7IbhHVDEooyOQFfYvnZrYSm26WwpeKnWz7J5gDCZGC1DN9j6/aKQhntcCHpHCVFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw0C3lEl+ghbrvzrIWcsaGb4baKL3xxbXVog9rwuNeU+F5/CH9
	0r/9WmtfiKPU41h4dx62O/D5+kKpywl503L0RmQnlb1hI1yr21oZegwSM5A5neuMa0hDHXddP1D
	FMKReVdDAb4fJH93QM6Mp6YomOgTSVNQ=
X-Gm-Gg: AeBDieuCQItvgFs2srR7u7bUJulvFeYggqim2Au+Tujgha5Cs0GYmc+30sxbG8hfFYw
	LTkmlpkti/EiSvUBubwnUxnrB+lhLlHvulHTYNGeKep6Ho6Jtk9j4Qel0eFKbAjwemMc561SVQN
	oVFGQAykajeotHDOnQF5vYT7Q433rgJbOYkBJcq+9DQJQ05XdSPgwhg5sTAI+1NdE1KxD2mn1Xw
	eiJ4FIttGQDJYInoAo+Q+9qG3JbEvrlXoFtadple55Qx8r9f9hyAGS2taZVjw5hrfC+lQRog33O
	ToPrwconwo8MM5/ArC4=
X-Received: by 2002:a05:6870:c08e:b0:41c:6bae:2307 with SMTP id
 586e51a60fabf-42a99a40fbdmr19580513fac.12.1777195521904; Sun, 26 Apr 2026
 02:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com>
 <20260424120807.25005-1-brite.airgeddon@gmail.com> <4i5nyqdrtpgm575dd3swyp7662wjdxu3hky7ucgwnuwigx5ge4@tc474ip5qxtc>
 <6EC55EE4-4534-4832-9FB2-393182829B22@gmail.com>
In-Reply-To: <6EC55EE4-4534-4832-9FB2-393182829B22@gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Sun, 26 Apr 2026 11:25:11 +0200
X-Gm-Features: AVHnY4KqgaG-hAOLwBLZCuzhJyDZb8Oil6TE5flQ_BooOGSihaJa6kKsVVzSk8A
Message-ID: <CA+bbHrVUjD+rm+Tk-WzroOiTvufp-aHHbDs7M9s4GwV=RnJrtA@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: restore monitor injection when coexisting
 with another VIF
To: Brite <brite.airgeddon@gmail.com>
Cc: Lachlan Hodges <lachlan.hodges@morsemicro.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, fjhhz1997@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 180784693F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241160-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[morsemicro.com,sipsolutions.net,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]

Hello. I've tested as well the johannes v2 patch + the 5ghz fix and it
works very well. I've tested normal DoS, 5ghz DoS and VIF+DoS using a
MediaTek chipset and also a Ralink chipset. Everything worked like a
charm.

I must say this patch is pretty simple... just modifying one file
(tx.c) and it is a minimum change (not done by LLM). I think this is
the best approach. What do you think Johannes?

Regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--

El s=C3=A1b, 25 abr 2026 a las 4:43, Brite (<brite.airgeddon@gmail.com>) es=
cribi=C3=B3:
>
>
>
> On April 25, 2026 1:47:28 PM GMT+12:00, Lachlan Hodges <lachlan.hodges@mo=
rsemicro.com> wrote:
> >Hi,
> >
> >I will leave implementation discussion to Johannes, but I have some
> >generic feedback;
> >
> Thanks for the feedback and now i know why the code was flagged as llm cr=
eated. My approach to finding the vm freeze issue followed by the 5ghz deau=
th not working, was done using debug prints everywhere possible, with added=
 delays between function calls(the delay was added because the vm froze oth=
erwise, without any dmesg logs). Since I didn't have the proper knowledge, =
the fixes i tried initially (spread across 6 or 7 files) led to other issue=
s, intermittent failures etc. Everything was done inside a kali VM with no =
comments, full of messy code, not using git commits to revert etc. i had to=
 start from scratch but then i added comments alongside. Even though the in=
itial patch fixed every issue, being too invasive, I tried to trim down as =
much as I could which landed the sole chandef and then the 5ghz patch. I di=
dn't pay attention to improving the comments when removing code sections. I=
 also had very limited time to spare for this and my intention as I said in=
 the airgeddon discord channel was to send a cleaned up code to the kernel =
devs so that they could get a hint at what the issue is and come up with a =
proper fix. The commit message is what i summed up from doing all my resear=
ch and testing. I didn't know the format to submit a patch, so i used infor=
mation from AI, Google, previous threads/replies etc here to submit an emai=
l. I didn't check if AI changed any comments.
> As I mentioned earlier, a community had been waiting for so long to have =
this issue fixed. My sole intention was to find anything that helps with re=
solving this. I've also packaged 6.18, 6.19 and 7.0 with the patch and uplo=
aded it for the users now but as Oscar said the proper way would be a fix i=
n the upstream and backporting it.
> If v2 patch by Johannes(no need for sole_chandef) + 5ghz patch from me fi=
xes the whole issue(I've tested this today) please look into improving it a=
nd providing a fix.
> Thanks

