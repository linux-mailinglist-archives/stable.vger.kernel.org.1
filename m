Return-Path: <stable+bounces-196957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74ACDC883E6
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6E83AC5CC
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 06:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B53164A9;
	Wed, 26 Nov 2025 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIUOQC/v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="swFWGOBn"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1BF2877FC
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137927; cv=none; b=h/7Uz8NQUirnRoM46I5EuyCWx4meVqs5v/4JnLRTrGgnDnskIICMsRHNuILqzK1ZejJp746enUgg5wDrhiTvgfQrgML8vtS+9BxOhCjrsCX4bcU8aDYiEpvi6cLkoD17bCb0YFqRP2BN/qiCxx1v/DSRp/0rG8fILyW5PSn+35Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137927; c=relaxed/simple;
	bh=9IyvSK4NGPHO4fuFRUIAoekh2Pyy3yq0MdSh3GgP3u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXvVtbVi8nIAjfsVrpQmvClK1hYHxFzMbeHiMdsriYRoJr0l17RRxDNKCjLqTDWCEUxyxz6IDnAJmNNk4o6LgxnjLtgPo9/c6u9KaU4U8JNWc3ZZA9FBQsA/j7bXhBOfySp59zjyc3j2Gbjm0+nDm1lGn1y6ninEbi++nlhGnjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIUOQC/v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=swFWGOBn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764137925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4EAaBQUbKXStRQ2aorpN5sb6DcjtPj0E0lOttGJD0E=;
	b=WIUOQC/vFB47807mSy+X1o+vZeqDW3+aXpBhmw7YGixPEIxFrNoc4oP1sGoXSWwzy/fVYn
	UKxsikl0HEA9RwEVv6DtMR5R08cH2SfcKdVWjpse4i5kLLmCjJ2PilvX3+vG/1ZjNgwIPE
	8VNRbMNf2fqvLt/tJyvQQ3qXWvNVkh8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-B8WKozpFPmO5mU4HvRBnEQ-1; Wed, 26 Nov 2025 01:18:40 -0500
X-MC-Unique: B8WKozpFPmO5mU4HvRBnEQ-1
X-Mimecast-MFC-AGG-ID: B8WKozpFPmO5mU4HvRBnEQ_1764137919
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-343daf0f488so6464781a91.1
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 22:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764137919; x=1764742719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4EAaBQUbKXStRQ2aorpN5sb6DcjtPj0E0lOttGJD0E=;
        b=swFWGOBn3vVHCYFwL35fL63bcPfobOWfrFQUJOpORH8m+T09XEy87gHcD4eiN5C+0j
         qf2ouvR56rldegVgXkc28VVQmPX7k1i74DXw3U8HhOjzWmRnrfYfjiRolKPvPjgIm1O5
         KRwcOo57HxgA2W4ZKSRCrUh1GJOC5IJM7vd/IyUOn4z2hiBFbloOqXVon94yBg2qgefR
         eFwns6zD+vbxwzwhYXyf/POCVrytjKyZxllaRvdJqw8o50aFTIouCPcZ0SXDY9epn0zy
         dK617O4bOk+wfgn8FcMp7YD1C/RZLZWS+Sq9Q6YVVCvI9uVCpfpxIwwyMtTKfu6NnV4c
         ztZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764137919; x=1764742719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k4EAaBQUbKXStRQ2aorpN5sb6DcjtPj0E0lOttGJD0E=;
        b=ifcUrCuMg2qNbnPAtEcHHJ5CFaYKIhzCuEnwTMmNi4q7Ld3G/mJQ/YC5xUfhZhm6I6
         w3MyHa9oPc8dmM13SFDcfTR/qkz4D2dTra6euuD8UTtcyVpHrPLTw8e67/DJfssWQMQ+
         XwtTQ76P8vwebgy0UuKG471oy26xu6BmiXhgMRaLnN3mH/33kNcEvB7JXE3FM5JQZhlk
         AZoxLcCUKZNX1ysG0sQcVuSXkuBVDpsZiZvLfKH6I6Fz9VkWJ3QgsHaQHNR1GIP2mX0z
         KbQ7NviIu561eYD49otyE7z42utlBTVh6BcNsv7Rwm3EGCyLZAoHekbTyfNfMS3F2CnR
         YAdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVP7DMf7lRHbQl7wftY77eNmrzWPo8P2fkfH023I1a6tFG/VbzsX6MVlzNWyI0OyTTnIz+db7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTPm8Xn9revfwZeuXwwlJYCReiWVWDFQmbR9WooJaWAAb6gLz1
	jl/mtb/XZGGJEcKtpxHRhcVrWyURVVGIeyAWK8iFkpFRpiIfiy6yBKSGG5wKUJuSBFMZ5maXC2r
	/4A+ah5Y4VHTchliE+d4JmTTosXgXYqZJPPpWCSjSZ+rDEaGJgxRYmEeKGM0ooDK/dwQUUOYpgO
	tXuGs48V8SlxCSZ0DqGK8mBXWEDZr41lGC
X-Gm-Gg: ASbGnculrjG4EQE1PZNu3sMb0fAU8g983OWhRq3cqOsqBOCCX7SBlloa/oh1PjOEH6j
	75oJ2/YVBpcepuMSwNe7nbDktcKdkj3q9i5ALWxp8WA64+1l3rT7FC1Go5zW1Wj3kQEbfe41owg
	MlSAHRuw0/nAEOQ+xBmirEeoqaM53nv+bJ1Dbn/DBzXb5UT1vUNTcLP0U4WMXnx3mKRkY=
X-Received: by 2002:a17:90b:280d:b0:32e:3829:a71c with SMTP id 98e67ed59e1d1-3475ec0f397mr5733498a91.16.1764137919251;
        Tue, 25 Nov 2025 22:18:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhRJldpd1OviU1vEEpkzZI2Tkr6ToasHRbqSGmjMSAi+R/5zZDXEphzASNpDnCWhFCs+nIjE+SnB6J4DOjgAg=
X-Received: by 2002:a17:90b:280d:b0:32e:3829:a71c with SMTP id
 98e67ed59e1d1-3475ec0f397mr5733479a91.16.1764137918886; Tue, 25 Nov 2025
 22:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120022950.10117-1-jasowang@redhat.com> <20251125194202.49e0eec7@kernel.org>
In-Reply-To: <20251125194202.49e0eec7@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Nov 2025 14:18:25 +0800
X-Gm-Features: AWmQ_bn5sM2oyO_hdA7aO1WikB4cbE8JxiHO9Gu_Ovx5iCRUVPSo0zJRLtZg_zg
Message-ID: <CACGkMEuCgSVpshsdfeTwvRnMiY8WMEt8pT=gJ2A_=oiV188X0Q@mail.gmail.com>
Subject: Re: [PATCH net V2] vhost: rewind next_avail_head while discarding descriptors
To: Jakub Kicinski <kuba@kernel.org>
Cc: mst@redhat.com, eperezma@redhat.com, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 11:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 20 Nov 2025 10:29:50 +0800 Jason Wang wrote:
> > Subject: [PATCH net V2] vhost: rewind next_avail_head while discarding =
descriptors
>
> >  drivers/vhost/net.c   | 53 ++++++++++++++++++------------
> >  drivers/vhost/vhost.c | 76 +++++++++++++++++++++++++++++++++++--------
> >  drivers/vhost/vhost.h | 10 +++++-
>
> Hm, is this targeting net because Michael is not planning any more PRs
> for the 6.18 season?

Basically because it touches vhost-net. I need inputs for which tree
we should go for this and future modifications that touch both vhost
core and vhost-net.

Thanks

>


