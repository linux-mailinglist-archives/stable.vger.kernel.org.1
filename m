Return-Path: <stable+bounces-270038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GHrAEhkhRGofpAoAu9opvQ
	(envelope-from <stable+bounces-270038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:03:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D63E66E7B5B
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 22:03:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AbFdP2Tz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270038-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-270038-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4C733061DF4
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1D53EC2CB;
	Tue, 30 Jun 2026 20:03:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB232FA29
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 20:03:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849804; cv=pass; b=m3vG27oBWoYvcMX8BUOQm6UkWfL91eoVNX0Ageipf573TtEFoXVZLGCUxgfyrSNIvaok7VyUbebyOR0CyoD8qeKGAg52cWtanckQX6FFC4fYkBvrbfK7VALrhSe94n4RjX3xI6Qcl2VKJ4v9zKi26JEzIHzXTlln8cmh2N2N7TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849804; c=relaxed/simple;
	bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1UmARmu0wMMu79I+jeQNkF9OOarQscmdDVXOU+d2b3xrStUKivXpd3BNaSppnBRIMfqxK6mMQ8xc04TUYLF0Ridz5+4iQreUle4kyESnuMfelF/mlBGXKoYAtfYohqyEI2VJaSXDai7NpxFpvuf3fbOsSr3h8E4W91paMk3/dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbFdP2Tz; arc=pass smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c126eb4e228so281351766b.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 13:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849802; cv=none;
        d=google.com; s=arc-20260327;
        b=Ebl1jVSJhhn0FCU3IPth2tPlpFdkiMoAVU5IUd5cLZZc4089mHZ3qCXd47Uex2k7A4
         kqPAZqzb4G6n4tTXRGPqSdR/8krLTGwJXpbJ9mOnjZtIwCvn8sWs88mcVNIyjQhtlx+E
         kjgZvjfYqrKQZxRA1qAEQuuqu87p0F3h+0Xju4Ck2MMr1nWPZa2cOaMI+BczYaorFGR5
         4nkU3E38lL5/bbHXtMkOmPm3xWbzAuEPdnkR+6CCIeId3ml4LEqb6C/0t/ZGrUKi+pjp
         mmEGSpyLDm38njnIkAo+wIuxHCSD0pHi2gE2KtJRZVRbOI3nlXs8YPKRF/C32e39sfh8
         N5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        fh=bo/GYPNt+bzQAnorBgCF6aNe9f4SCE03QQPUo+2XKzU=;
        b=UVtKpm+W/5F/M3L1mg6KR/I6PQ92G5V0exg/tiW8x65hPtrhq9r4MYy76t8WxSakZZ
         9402y99TsXaDp0rydodBkykYIphuFOQTCjCHqg3YdhjWnRIbIvNa1/DIzXRpqwZCYW3S
         9m6/Vy7QFmJ+jDx0p5pQU8wA1GQxyBwUPg5fZikO2uZtgd3wxem10Xm2K2fKNFKVznOQ
         HWn8PDl81AbRkqFIUP9d90Iu1nlHDTMGo7j8NaqetV1l+9o633GAkN3OV36zwo8NLZOP
         s+65mhd13/Ot7MnrZuJeCMkizzkjrORiVd2qno2rtkqDfsCoKURDQSmx/VficewjkF47
         20nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782849802; x=1783454602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        b=AbFdP2TzeJDu6cHqaS9LfUCIwUEOUv3qAoQthciUEyzNb8YVH6B3NR1rGiq8FMsNtn
         OBEBbjLRZ6imyi3BHK+fIHFY+M2epyNLx7p37C2CrqETNpVwxcyWuz9y8AOsV1cLAJic
         pf/ctRjvC3FkKF1BTYxVSAvdhrc0VlGK2pU6BYkTzMvgLwfFXPEVhSRN7wcU9ORNvy5z
         /fnIqzDTrbKYSCfeXhcuIVX0UshrNwefvBu/pje6wRplZP7ChF+Aai11zfxvhy0on2Kn
         9DoC22i+hu7JPnOWrs7JndHP3T847qdjRoHFKFEg3LHKOUFAYUPsfl8Q2SqDmaGbIfvo
         Tl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849802; x=1783454602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        b=Iep2/PJb8vQjfuexfecBu3zNpX91APAjiUuIMIlR1jxtawyCmcFCBl08g9tL4jZT/y
         vOVZLKYHCPZ2Z5igIuMJiLFlwC1NKOkXBgn8DL9QqIPQUL1JoDCkjzbb5w4jGiYG9koh
         ft3uv/+xY7+M6hQ81YtAWWezx7ZwHapG9XujQxpyS3+vk861ZVFtsXEHUR+5xi3AQaTe
         GLYDO7N3ksU85QDCnemtSmQaZjxDH7s7hg1KulFNMmkbbKfhjNITKpUmaY6CS8sMmMeQ
         KRWpbiY39JvtjDMUelbx1m7am9vXs4u66j2bxpfY5te7pSki539fCEJVYnHbaFp49KBo
         mETQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdrGJoxv3H6YgH74snWo/mVMs5xTnndt36cp/Z9hqvUM6rE7R/eE/E0sUFgmYJdTffipiKbl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjOgMUb3wygSPwJPt9qlyXMd2MKnrfTCuPWwrT4CdnBo4fJPGK
	4WoQRoiCWh1wbxmM7BXY7ZaFJTS+AUQcuKuiA4iQN+EupKsOwl9BjKQVPVrmGyCvD4ON3FShZDJ
	R7AF2oYZioOZsVpZ8L3CJWH6tbi3Sh3s=
X-Gm-Gg: AfdE7cm3+Hz7ZlKZHYIVVkrNjJDwzUvcKh6q3DJpY6WYigGS4PryMUypeAVEEZQ5pqk
	QQk3lyqmEHeFrkiRtsqLw7wZeBTUbdy18ryDaFTVpuemF6rUBLVqrKA+SBUpadrZF9BkR3oXXwJ
	PWyJxH9B1Hb/K6ewZxugGabN30GI0sArG/N6zydUPbu75xCKbrKrHhNIskFVtOn4BAkEiG3K0TW
	VsCXsluOlDC9KfNlP5KygJAkboG4QMl7KB8FvvMyC5HqQp/u1xgoiCi4+Ux5SE3XdyzSEU=
X-Received: by 2002:a17:907:720f:b0:c12:3219:ba1e with SMTP id
 a640c23a62f3a-c1297f04180mr105626766b.42.1782849801564; Tue, 30 Jun 2026
 13:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org> <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
In-Reply-To: <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
From: Ujjal Roy <royujjal@gmail.com>
Date: Wed, 1 Jul 2026 01:33:07 +0530
X-Gm-Features: AVVi8CfDECdiCgzhQlx3_wZFTGHCy6ydmcO-9SWK6-jb6Fc7WwdQO42bD5DVouM
Message-ID: <CAE2MWkkON7HuB+Szc1VhaPL8ZTYMAyfzmPM_7FkXvOPnjnF5rQ@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: Sasha Levin <sashal@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>, 
	Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:stable@vger.kernel.org,m:greg@kroah.com,m:gregkh@linuxfoundation.org,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270038-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[royujjal@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D63E66E7B5B

On Thu, Jun 25, 2026 at 8:20=E2=80=AFPM Ujjal Roy <royujjal@gmail.com> wrot=
e:
>
> On Thu, Jun 25, 2026 at 4:12=E2=80=AFPM Sasha Levin <sashal@kernel.org> w=
rote:
> >
> > > Please backport the 5-patch bridge multicast exponential field
> > > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > > e51560f4220a, 529dbe762de0) to the stable kernels.
> >
> > I tried, but it doesn't apply to 7.1. Could you provide a backport plea=
se?
> >
> > --
> > Thanks,
> > Sasha
>
> I will create patches on top of 7.1. But tell me what about all other
> stable releases? I have to create patches to all stables and how to
> share the patches to you? Via this email or any other process? I am a
> fresh on backporting my changes to all stables.

I have prepared the patches for stable releases mentioned in kernel.org.

And I am waiting for your response so that I can send you the patchset.

