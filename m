Return-Path: <stable+bounces-152882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42C1ADD02D
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A69A1896CE0
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D820A5F2;
	Tue, 17 Jun 2025 14:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dr1uiFbg"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D6F201004
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171216; cv=none; b=tuRcQEFbcTz0i3qnAhRDrQKq6q1rjhytgxgNScg7eLR3KKxw87ckOCz5ryQvd5ICWH4pcR5I12KW6V8xFUMvukcBATKxiPEhsPg2MqsWtuW/DOM8dYxg5XearHF8MMPr1yW0CTmSsGNZYOcSkelVLMRBs/CMpeRFUN5QKNJYXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171216; c=relaxed/simple;
	bh=cUXZQqG7DzX0GtxXItOumFyrJm5/2rKRGtM8x5Npnng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebUbb2/ATZasByYRuz3RRczlcQxWCVB03LsV+ZprFmNA0rH/t5nLcrnGMDAsT/Ucl+2Zp+fsXry82sHk20dtq8S+3oagNqe4Z5NHl8fU98nmI0tnuJoISVcGnzx5cp7LmQUN4wCnEAe5LW3DZ2WKyN6/X6h+uRf5fkU94f35VGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dr1uiFbg; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a43d2d5569so72445341cf.0
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 07:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750171213; x=1750776013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C5K9o5kJSAp6iDgSUrLzT/cKuEe6lvhFFGHzOOhMiRY=;
        b=dr1uiFbgCPoPUvJBoM2UMSIEVFYVSHDq+aO1Uw6kTuNV4WfEoVANnpibzj/OnB4xjR
         InB0cjvcPXse6kIna66sdEpuhA4A6g8EWUSJsYu0KuzVy53LnLmnbLNZbtt+OEF57Zna
         h7njyDVqrNt0ACEetbX6v+0j3AIClsmjbmhfFiLIIfeykGNBjOuQp7Ct3ZlEA6Vs87vz
         gsNnncvFHKCOfsWCipRxyKQVPWOQs7PwgIZwjagDOVDc9eJx/KYRCrofiFR3Hrn9RpTU
         lbv0zO5kKbq/1HtTvIyK2UIz3/ohDZtHerX+ZwnOL9pieAW5QdtnCdWMzleD6iUeu+n1
         NzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750171213; x=1750776013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5K9o5kJSAp6iDgSUrLzT/cKuEe6lvhFFGHzOOhMiRY=;
        b=Zo6jjaG8DDENs9yhk+1l2cpLJTaDcYagDe2gl97okV5l1qIEfTLBcnNcJQikGTnmFL
         wQOkTbNW619rRFku/fl8pgKFZi4VBm5N+sDQECy8rmOvgSuDvYTGLDwAwwDZSSxD60cl
         P4tXQhi5KA2EYbH1BvqSqHAt2n7/ojAJiZvhrZg7Q1wu4X0P5znZ9WGVJ5ZjKX/Y3I89
         E7ofY9L651kZFuLURvlHNM/DtFO4Q/GQD+dVUrsD8YgHsc43HHCS32MIy/t6CRQJUl4q
         UPrvscGoqLclp3Vr8XADpEuhUa2TDQbyNOFfYx9pXf58AXcGtX9H8FYN9CuMbtVjsb6/
         nuRA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ2uLNKBmxybL3Nr5dgSniN/+ur109ztYP6omcqNGx7LttLLyc1zGT72fK8+dMB7ZKeHFn+iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHt/0bmUjvuWEZ/SSgpgycmd/yfJoarUYCKSgBFlSCbuEg03H9
	qIEmHmOnSdWkzCdiMSB6N69Abobv6xEjaZg8M7016s6eRsH2Xi7iH5WSHejx6uvliY+aHMBf162
	hdt6w3FCaeHYLu4quW02gwQadSPfZT9hIWOfXojc8
X-Gm-Gg: ASbGncshCg7J3OEhy+nvx5K30tBjgGSthVDEt8lh4BTPbxTRBRTQvXS+EJpYL+R3Nn3
	bFWZPXRr4qt6ewkQVcBhPDgs8FvLxmorV8bcg0sgqUue2cXHC/6BXPKDgelFTcEn9bNPKZo4C6t
	cIrSUxBBmg6La+0INfNfsYU7q2JmlFUExYz6UaYR2x3nzZsq5N2cMBJQ==
X-Google-Smtp-Source: AGHT+IFHv8Z3oFVpowvUAXafkTH6WF9Yixxu8ZXDLBLf/hOMBEUUPB1ZWNHXBla9hqWIPyalMkb3f6PNupNnGc++V9U=
X-Received: by 2002:ac8:57c1:0:b0:4a6:f81a:443f with SMTP id
 d75a77b69052e-4a73c5339ccmr197302721cf.12.1750171212881; Tue, 17 Jun 2025
 07:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522224433.3219290-1-sashal@kernel.org> <CANn89i+jADLAqpg-gOyHFZiFEb0Pks46h=9d8-FiPa1_HEv3YA@mail.gmail.com>
 <aEspV8Ttk7uBM4Gx@lappy> <175e6075-a930-196d-37ce-7f2815141d07@kernel.org> <PAXPR07MB7984096843D96583972BF35BA376A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984096843D96583972BF35BA376A@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Jun 2025 07:40:01 -0700
X-Gm-Features: AX0GCFufhnAB1BpO7_CQEVHFzQus2hBm9r-C6pgCcOSckJBt5Dx2C2be1-BCkII
Message-ID: <CANn89iJ1Fwg8BnYRnnevFQnZia4R4hYUGtKSrwcL2-XjKFLWBg@mail.gmail.com>
Subject: Re: Patch "tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()"
 has been added to the 6.6-stable tree
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ij@kernel.org>, 
	Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 6:55=E2=80=AFAM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
> > -----Original Message-----
> > From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > Sent: Thursday, June 12, 2025 11:17 PM
> > To: Sasha Levin <sashal@kernel.org>; Chia-Yu Chang (Nokia) <chia-yu.cha=
ng@nokia-bell-labs.com>
> > Cc: Eric Dumazet <edumazet@google.com>; stable@vger.kernel.org; stable-=
commits@vger.kernel.org; Neal Cardwell <ncardwell@google.com>; David S. Mil=
ler <davem@davemloft.net>; David Ahern <dsahern@kernel.org>; Jakub Kicinski=
 <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon Horman <horms@ke=
rnel.org>; Kuniyuki Iwashima <kuniyu@google.com>; Willem de Bruijn <willemb=
@google.com>
> > Subject: Re: Patch "tcp: reorganize tcp_in_ack_event() and tcp_count_de=
livered()" has been added to the 6.6-stable tree
> >
> >
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >
> >
> >
> > + Chia-Yu
> >
> >
> > On Thu, 12 Jun 2025, Sasha Levin wrote:
> > > On Thu, Jun 12, 2025 at 01:40:57AM -0700, Eric Dumazet wrote:
> > > > On Thu, May 22, 2025 at 3:44=E2=80=AFPM Sasha Levin <sashal@kernel.=
org> wrote:
> > > > >
> > > > > This is a note to let you know that I've just added the patch
> > > > > titled
> > > > >
> > > > >     tcp: reorganize tcp_in_ack_event() and tcp_count_delivered()
> > > > >
> > > > > to the 6.6-stable tree which can be found at:
> > > > >
> > > > > https://eur03.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%=
2Fw
> > > > > ww.kernel.org%2Fgit%2F%3Fp%3Dlinux%2Fkernel%2Fgit%2Fstable%2Fstab=
l
> > > > > e-queue.git%3Ba%3Dsummary&data=3D05%7C02%7Cchia-yu.chang%40nokia-=
bel
> > > > > l-labs.com%7C449db2278c004aa84d7b08dda9f68c8c%7C5d4717519675428d9=
1
> > > > > 7b70f44f9630b0%7C0%7C0%7C638853598557368335%7CUnknown%7CTWFpbGZsb=
3
> > > > > d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF=
O
> > > > > IjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DZ6AfId4r6Ys1V4s=
Gov
> > > > > 8bdOct72AAUdfVgFTo7NMOibU%3D&reserved=3D0
> > > > >
> > > > > The filename of the patch is:
> > > > >      tcp-reorganize-tcp_in_ack_event-and-tcp_count_delive.patch
> > > > > and it can be found in the queue-6.6 subdirectory.
> > > > >
> > > > > If you, or anyone else, feels it should not be added to the stabl=
e
> > > > > tree, please let <stable@vger.kernel.org> know about it.
> > > > >
> > > > >
> > > >
> > > > May I ask why this patch was backported to stable versions  ?
> >
> > As you see Eric, you got no answer to a very direct question.
> >
> > I've long since stopped caring unless a change really looks dangerous (=
this one didn't) what they take into stable, especially since they tend to =
ignore on-what-grounds questions.
> >
> > > > This is causing a packetdrill test to fail.
> > >
> > > Is this an issue upstream as well? Should we just drop it from stable=
?
> >
> > It's long since I've done anything with packetdrill so it will take som=
e time for me to test. Maybe Chia-Yu can check this faster (but I assume it=
's also problem in mainline as this is reported by Eric).
> >
> > --
> >  i.
>
> Hi Eric,
>
> I've checked the failure case and could reproduce it using the latest pac=
ketdrill.
>
> The root cause is because delaying the tcp_in_ack_event() call does have =
an impact on update_alpha(), which uses the values of the latest delivered =
and delivered_ce updated by tcp_clean_rtx_queue().
> Therefore, tcp_plb_update_state() will use these values to update the sta=
te for TCP PLB.
> While before this patch, update_alpha() is called before tcp_clean_rtx_qu=
eue(), and thus delivered and delivered_ce are not updated yet.
>
> This is also in upstream as well.
> So, one question is why tcp_plb_update_state() uses non-latest delivered =
and delivered_ce before?

This was the prior behavior, and having an LTS change breaking
whatever expectations the code had was unexpected.

The test apparently had a comment "// Flowlabel will change next
round", instead of trying to fix the off-by-one trigger.

Your patch was fine, I have no idea why it landed in stable trees.

