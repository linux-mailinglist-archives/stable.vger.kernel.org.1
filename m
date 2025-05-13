Return-Path: <stable+bounces-144112-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F963AB4C4D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB003167A08
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 06:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FFA3214;
	Tue, 13 May 2025 06:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoPsh48l"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBBA1624DE
	for <stable@vger.kernel.org>; Tue, 13 May 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747118987; cv=none; b=m77nDVv4RoiDzUgYJieKWelXZ3LHP/sX7c2/M35Ba1NNGeSr96NGu75Qvjy46YR3E71rdLmycmqDr96alVRulDWsVdXdnt/E2FjWoqFEthHMfYZo3yTKSwulD+8Ph96kqXgMb7D2Pou4bK6rZWBZfwWLqJkx0D63ER4gQTw975I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747118987; c=relaxed/simple;
	bh=IZyeVCOSBzvBPmQGRXlxDvr5BZWhX6v4eYH0X28Gdyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AiLIJXqYfeGERLpu3e7DOdfu1THjWAOQjtVg780SgeK00+JTp9X1YKNstrh5R7Kr00LqCxmyNgwqdODfjbaT4yKQC42Xs4Khx7ImOwBaN8za4zBl0YAQkLeMMTJ7LcQRQ8TeJplPs4xb73sqv0ir+hR8nWqk1/1Oc5pJUM8pAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoPsh48l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747118984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RxqOjUCa4LXwuT2LZUpyk3FldmDcuZZ0KDjrObN4958=;
	b=UoPsh48lA/ZvbmdDbhptdxoeJIlS6yRqcvponMHkLaxvWfj1dnmU3P4zQlOhQAJMv/l81J
	TCB8jcgqewJ4vmxhsuOz/g0JcubKfvJH59KpQTxtndzElsUw3T06LbC+HhJsyquWhkHTo7
	T/JlRxJfxR55z5w6BJvwPOcVGfxO2hQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-FfGd00s0O7S70pJ2p3DWhg-1; Tue, 13 May 2025 02:49:42 -0400
X-MC-Unique: FfGd00s0O7S70pJ2p3DWhg-1
X-Mimecast-MFC-AGG-ID: FfGd00s0O7S70pJ2p3DWhg_1747118981
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad22c5408e7so327684166b.3
        for <stable@vger.kernel.org>; Mon, 12 May 2025 23:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747118981; x=1747723781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxqOjUCa4LXwuT2LZUpyk3FldmDcuZZ0KDjrObN4958=;
        b=GCdXHdEx+forRS1HaUidDnKJ9U13lydRDCvNwLc/TlPrh7Z9VCUl1lmgtZqr18uZQU
         lSocNxCiCrviZO935a9WE6pWAyEyu1uq+R9PCyA+XGGCSkiK5P6JqWb3SgURJ1xyuMBQ
         mMCt7H0fhW3fSF+Zs02T/vDjNh7Nbv6t9FSSp1ui/MbXmAhq1reOs0l4aILNEbjNw20w
         PVJrVdnQ+g+bIsI5hkBAFMaAbcd80kvCB/RTp7J3QR3lnlsLubghpW3DKWlmWR7EZO08
         FVWTV7gsxFA52tqv+J72R0lsbZC7RY2Asf5mbDYJICM8RkePBdLRaMh18eYmxWnwRGan
         OQaA==
X-Gm-Message-State: AOJu0Yyd4oS6M4yockhCtOuZK7kF3McWtLvGc+kQ9bdCMEYJ4Y6Qt9hI
	g9jMvrF5L34rFZH/mS/Lgwkt4IjlATq/PlXcJSp4kXdGYelAC3T/9p2/FFIASXNMTc7Hp9VO8CW
	SjG+Uoe+zDPaVGThtzpHNgN3c6aFql2GxNVbiXGO+b+yahJCR3Iz8+ZtRbSd/sQ==
X-Gm-Gg: ASbGncuLM62FGY37VYVW1PUHv1rlxvWFrfkkZiQRRNwuIcf5iVq0+xmwzz+nNZ/8ts8
	DBybBxMtN8WrXlOrV6grjC5Jk0IgnsB7NbjQWk9Et2rM09DNqsOeVdg9mSTQVtMvbFny9sLhjTn
	rIjnix90MIukm28EKZQthDytHK2AVBbVLHjoqzOzphEX4zNJ8jh5rDZ7jkO9AudDNyTHCsVsQ6I
	gi69bMMyIeU7LWUXopAv7/48hEVVpHTREE0/jN1hWWmIvUmurbiRwULkMiU3c0ZsYSlTzUEaz+q
	++YAktMNFbg/rIyLWBYu/x3U54iByoudF88GmtSMJZObT6H0Beb7idM=
X-Received: by 2002:a17:907:94cb:b0:ad2:4787:f1f4 with SMTP id a640c23a62f3a-ad24787f2e0mr947715466b.15.1747118980730;
        Mon, 12 May 2025 23:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo6WVYuVjtPSy7LK4FBL1aRWm0UAWSyLOmCNtbwHL+9J6QTuA3pX8S0ELSxcjIZxg6eiXrbw==
X-Received: by 2002:a17:907:94cb:b0:ad2:4787:f1f4 with SMTP id a640c23a62f3a-ad24787f2e0mr947713966b.15.1747118980328;
        Mon, 12 May 2025 23:49:40 -0700 (PDT)
Received: from [172.16.2.76] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bd364sm725886366b.133.2025.05.12.23.49.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 May 2025 23:49:39 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.4.y] openvswitch: Fix unsafe attribute parsing in
 output_userspace()
Date: Tue, 13 May 2025 08:49:38 +0200
X-Mailer: MailMate (2.0r6255)
Message-ID: <0481676D-8CBC-4381-9F51-17D4F256EFD4@redhat.com>
In-Reply-To: <20250512171051-d0977a979bf65698@stable.kernel.org>
References: <20250512171051-d0977a979bf65698@stable.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 12 May 2025, at 23:52, Sasha Levin wrote:

> [ Sasha's backport helper bot ]
>
> Hi,
>
> Summary of potential issues:
> =E2=9A=A0=EF=B8=8F Found matching upstream commit but patch is missing =
proper reference to it
>
> Found matching upstream commit: 6beb6835c1fbb3f676aebb51a5fee6b77fed930=
8
>
> Status in newer kernel trees:
> 6.14.y | Present (different SHA1: 4d184c1b89b8)
> 6.12.y | Present (different SHA1: 4ae0a4524c47)
> 6.6.y | Present (different SHA1: 46e070d3714b)
> 6.1.y | Present (different SHA1: 68544f9fe709)
> 5.15.y | Present (different SHA1: 99deb2bf2bd1)
> 5.10.y | Present (different SHA1: c081a8228222)
>
> Note: The patch differs from the upstream commit:
> ---
> 1:  6beb6835c1fbb ! 1:  88825867905fa openvswitch: Fix unsafe attribute=
 parsing in output_userspace()
>     @@ Commit message
>          Acked-by: Aaron Conole <aconole@redhat.com>
>          Link: https://patch.msgid.link/0bd65949df61591d9171c0dc13e42ce=
a8941da10.1746541734.git.echaudro@redhat.com
>          Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>     +    (cherry picked from commit 6beb6835c1fbb3f676aebb51a5fee6b77fe=
d9308)

Hi Sasha,

This is my first backport, so can you let me know what the exact tag shou=
ld be, as I just added the =E2=80=98cherry picked=E2=80=99 comment? And d=
o you want a v2?=E2=80=99

>       ## net/openvswitch/actions.c ##
>      @@ net/openvswitch/actions.c: static int output_userspace(struct d=
atapath *dp, struct sk_buff *skb,
>     @@ net/openvswitch/actions.c: static int output_userspace(struct da=
tapath *dp, stru
>       	upcall.mru =3D OVS_CB(skb)->mru;
>
>      -	for (a =3D nla_data(attr), rem =3D nla_len(attr); rem > 0;
>     --	     a =3D nla_next(a, &rem)) {
>     +-		 a =3D nla_next(a, &rem)) {
>      +	nla_for_each_nested(a, attr, rem) {
>       		switch (nla_type(a)) {
>       		case OVS_USERSPACE_ATTR_USERDATA:
> ---
>
> Results of testing on various branches:
>
> | Branch                    | Patch Apply | Build Test |
> |---------------------------|-------------|------------|
> | stable/linux-5.4.y        |  Success    |  Success   |


