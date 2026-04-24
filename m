Return-Path: <stable+bounces-240562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPdHGhoH62kFHgAAu9opvQ
	(envelope-from <stable+bounces-240562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:00:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 024DF45A21C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D1EA3013D60
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 06:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD6826738D;
	Fri, 24 Apr 2026 06:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VNLGnCOL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D5B17736
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 06:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777010444; cv=pass; b=jYXVjDvrh9U3xCb/KiG+FsjbfVp+PLuW21HCSNqs8MEiMCYQHm+EI80XBb3K/JaxV9gnppC3GJ4ajKfiYfL01istO4AVNMnWt7stCbpnHmL24jZM6ZFOHT5LCohywh4laASTtGipuzeNbedi/Fy8kggS6J2FlCFKwim5R+sTamA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777010444; c=relaxed/simple;
	bh=47+fEWej/SPazFwb2bx6i6bA+YnOTBp01O/lgG5e/4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TI3VUMNnaszp1H9yDh9i+qLgTlkNBSAXItJxNN1FJ3BpsFMv5YdqKChWkSJ3OP9HVDiZJFmowcWk5rn1FVYlclRr5cz/XvdLmDO9BlMKyCYIlCRp7rfyA0BIhlMgm8BI+cX4bZ7sq5bDil47jBwJ91uda2pf8lcBSTrwsUL7SNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VNLGnCOL; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba671a04b71so91730766b.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 23:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777010440; cv=none;
        d=google.com; s=arc-20240605;
        b=JkhuLb3johErruTfzo7HNRfCdZ+vNYbH1QrFZRrAvBayRdOeQVa8fAa1eoasi0NvR5
         SdIBGu+AtJWICTLJ/EYX/KWvlWM4hbQcRruG6UplCPZ2HGGWqdty9umbH/lMGK24Gc/G
         YIhYiPCcvNc4/g6ubPEG8+yC+lcSvJ9LvCZwZwlSc6th+GYdMqTmnAAOrFfuDoYYRVIn
         rkI+VNnx6XtWWoY4bX6EmZXAkGuL68zmL7hx/JZ8pNtLdFPMWmSdX3zc8zVLaRHn9N3D
         WrjQwWm3i5npCDCBMRxsbzDOnbnmY126Em4lfmBrmg/vcyrHOjzhZUwd2Jmxl18BmsBf
         s/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8PshLiRG7065i8PHlCp/QU3acwVHNiiTlweYHpZl1ao=;
        fh=OH1lmX1W1i/Oa26vhteP/Olb3EYmtYPrhjUWc4RRVZ8=;
        b=HFpuWgRYpIovTJM2dqcE7RG5E4fGuj1M1c6ul2tHZeIrOMQh/kz+SDoAvzyPdGXlWh
         EAxYn0xax0/9uNPKsRWgFyketU/BxDuXQ/QmjmIMuAvtSidhCe9woOWyNvbnGlWLUjeU
         aS8ngll+DLmFjrjHPnz4n/ThYfpaoDpHOqRkPeNdmNOSWGo633U7kSRAgvn1q9C87coI
         KVd4Q23Y59g7uRdMTHQZG/d7jqP8nwjU/aR6scn2bTw18szbPjeZu1f3PbmKdTQRsI9L
         +cxwXcj6VOyAX+firGxxd2iiQUsFLgko8nJc9trx90qlBOyaJHJQUqCZUCSo2lCxLn5O
         tMXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1777010440; x=1777615240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PshLiRG7065i8PHlCp/QU3acwVHNiiTlweYHpZl1ao=;
        b=VNLGnCOLsgoyPm02XMvgBoTmFDvKzlEYao3gEZTNLyAqO13l17O8T3LsEQJRV6oZMf
         w2LFqbAzMPYp8x0E2QTVcTcdDpDkV+hfGEQfja85jhdHCg1aEJsrlyCjWh+sT5jujXTV
         Vdq2C6KwuxrivJMm7ShBiOEr83ha3es4yAX50BUcok6iPOR6LA+16e6lisqHi7j4sm6h
         ov68O/LOowJclJpDjcuiTxfskdgu/9M+kLGIReyyji26/csOq9Y67QTSSNXCsUCsA+Op
         bcsoczxeicS8s3hAf4Vlr+PDm/BnVcpM/WY9PyQtwZlvt8rQ5pZqxEir2x1fQfb9Hkyn
         KaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777010440; x=1777615240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8PshLiRG7065i8PHlCp/QU3acwVHNiiTlweYHpZl1ao=;
        b=eKzpKfqXqAklW15FwTlE72cpIqGvXvg+dtWDtUmRoceOflzqOvisOlvMfeLSYxiy12
         KpCBEfBWjWW47YAGfIYtT8PUjHOQlIKZ/K/3Nsx780xfjRoAcceUFkOC9IHjwa0zJ733
         W9kF+l0+uDmxDNsKj6FbfeqsuLSP9vMZEv1ALhL8T9KRlby7u73Nbk61fcR25jzTrT9d
         +rn1wkFGb7/FVuXfNgFeyT4Hf2ts6QTTswuzICfNu6eK0QIfBpxqpMWf6E3Pk5BVFtR7
         sJ70hcWEOcC3o0mPZyMCPDGpCrNpgnYctmhCNc58JLLVNTqR8psH6Q4PINNAYLJM93HL
         Pklg==
X-Forwarded-Encrypted: i=1; AFNElJ8t1NKlRxeTeGGroVqmO/4eukMuyyTBCITHXQshBdAYf2vt8Kv13MK+LSYY8+a2rAzcpT5vdgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaLW2ikOqwh7aCS/Y7erGezuIT2hU+QxsSJnZFmAybvDErvHP5
	Fggo9TL3TPMbIaOxuI56zrtpQdxSWsWLnhVjXGhzKheflgaaM7IfkmonmxsJfZiXDpET4osnQri
	+vZIXoIiqD29xHmq1PVx6iYnL4aWk86bd4AuD27lijQ==
X-Gm-Gg: AeBDietf7ZOrlBjQZa4i6uxRygm95UIUJk76MUe1LCCaUZDcDEb/KrLcYePSxHHTrqf
	WxJGP6htDMRZkTNq7WG4lzR95O9O2QQQUOfxonfFqoVT1PyI4i/KVb4zSZiri5a2mpYigjPs1Qm
	EtYk8ase2BR7l5/SnbhG5b6HVFos/a0ziST8qt+kYirSelN9L0uE+wA3tC9VH8S/BuorzbH+Keg
	dX634CmLro/BZ4Q+Cp2/QuBbyTyaxEgmboOGgKyRaGR4do6Xl9AWoJmEIFxq15knJwwS7EDDjMq
	Cxxzx0tar/j0Si+sojTgQIlxYuUQOpecYqwWVUpgsZu/h4nHzDE=
X-Received: by 2002:a17:907:3e8a:b0:ba2:a0a2:6f8c with SMTP id
 a640c23a62f3a-ba4154d92fdmr703485266b.0.1777010439897; Thu, 23 Apr 2026
 23:00:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421212218.433963-1-sagar.biradar@microchip.com> <66414927-481a-4464-8a3d-d6d77ab1aefb@kernel.org>
In-Reply-To: <66414927-481a-4464-8a3d-d6d77ab1aefb@kernel.org>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Fri, 24 Apr 2026 08:00:27 +0200
X-Gm-Features: AQROBzCqqvZTzC3ZruKyzhYMgsZVz1eDaE7vzpWo1FooqpOWX_GKiWyL7bzvFgE
Message-ID: <CAMGffEmirEUEy75ZULdXFE13WLMnciWLa_YsLQOyF0r6TArzPw@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm8001: add MODULE_AUTHOR entries for new contributors
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Sagar Biradar <sagar.biradar@microchip.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-scsi <linux-scsi@vger.kernel.org>, stable@vger.kernel.org, 
	Don Brace <don.brace@microchip.com>, Raja VS <raja.vs@microchip.com>, 
	Kumar Meiyappan <kumar.meiyappan@microchip.com>, 
	Abhinav Kuchibhotla <abhinav.kuchibhotla@microchip.com>, 
	Uday kumar Bagam <udaykumar.bagam@microchip.com>, Advait Churi <advait.churi@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 024DF45A21C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240562-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jinpu.wang@ionos.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[ionos.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,usish.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,ionos.com:dkim]

On Fri, Apr 24, 2026 at 4:35=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 4/22/26 06:22, Sagar Biradar wrote:
> > Add MODULE_AUTHOR declarations for the developers who have
> > been actively working on the pm8001/pm80xx driver in recent years.
> >
> > This helps properly credit the people involved in the ongoing
> > maintenance and the current upstreaming effort.
> >
> > Signed-off-by: Sagar Biradar <sagar.biradar@microchip.com>
>
> Well, if you go there, then you are really missing *a lot* of people.
> Just run:
>
> git shortlog -n -s -- drivers/scsi/pm8001
>
> and see the ranking by number of commits.
>
> So in the end, I really do not see the point of this patch since git log =
can
> give a full (and correct) list of contributors.
+1
>
> > ---
> >  drivers/scsi/pm8001/pm8001_init.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm=
8001_init.c
> > index e93ea76b565e..487f9bc237ef 100644
> > --- a/drivers/scsi/pm8001/pm8001_init.c
> > +++ b/drivers/scsi/pm8001/pm8001_init.c
> > @@ -1569,6 +1569,9 @@ MODULE_AUTHOR("Jack Wang <jack_wang@usish.com>");
> >  MODULE_AUTHOR("Anand Kumar Santhanam <AnandKumar.Santhanam@pmcs.com>")=
;
> >  MODULE_AUTHOR("Sangeetha Gnanasekaran <Sangeetha.Gnanasekaran@pmcs.com=
>");
> >  MODULE_AUTHOR("Nikith Ganigarakoppal <Nikith.Ganigarakoppal@pmcs.com>"=
);
> > +MODULE_AUTHOR("Abhinav Kuchibhotla <Abhinav.Kuchibhotla@microchip.com>=
");
> > +MODULE_AUTHOR("Kumar Meiyappan <Kumar.Meiyappan@microchip.com>");
> > +MODULE_AUTHOR("Sagar Biradar <Sagar.Biradar@microchip.com>");
> >  MODULE_DESCRIPTION(
> >               "PMC-Sierra PM8001/8006/8081/8088/8089/8074/8076/8077/807=
0/8072 "
> >               "SAS/SATA controller driver");
>
>
> --
> Damien Le Moal
> Western Digital Research

