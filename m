Return-Path: <stable+bounces-189092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D05C00933
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 12:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53DA24E4A69
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 10:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF332FDC36;
	Thu, 23 Oct 2025 10:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNQZ+/yO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323D30AACB
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 10:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216704; cv=none; b=EQUxfEcXmivgenIpDm8U+Tj+sx3TUbFzjZgRaIq3Mxs+oI571n5JBsVKOkxju6QVv0bXahkjrF1qy1itd92/CIeC/xwNfYKj6xjhSP9ZK6yAbzVV5/QHFBfbPOgKtCK4r9gopvI59Nxk0gvnLDXgltJEJUY/3C4XbPIfxIInb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216704; c=relaxed/simple;
	bh=9nOGCAjhfRW/rA97w2j13qaEfOW0Utgue9GQrZT+8Kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lx28KnspKBKitqQhARd3p2BQ+9D3xvdmTIm5xPOeLGHSPMOjD6GVBRC+D1gj9Kfg8eJe0ectTypYhD584Gv/K974nxWN/aVP9THa0RBFyzsFrJFgq7ya9UH4MHtWP9ggttARoieXlicNbP9CK2T1AEQLMHuc5cd+KAuyJEPJcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNQZ+/yO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so453026f8f.1
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 03:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761216700; x=1761821500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nOGCAjhfRW/rA97w2j13qaEfOW0Utgue9GQrZT+8Kg=;
        b=HNQZ+/yO7YKkbzyMJSOt/vxKPskV5m1iW3CZ7Pnx2E+q3B36bJqiSf9KpWNpKKvNdF
         SNkubrLefH5sFJHYvz/zRcseYfTYaVNkE5OpSCzNUCV01rdg6ZX0XUXB2BHP3zy4rZcH
         vl3gL/1sl7SGH1FJBKEI25FEHVtefoPf4vD2/xFQ4QR5hSEyY52SbcUJbGQtEzExPr5C
         U8T/wse8NzoTi5P11gSsFY3LzLAem0ZR5vaemqx4Qyf1+KYftNQdb6rvw4nyFZEEizPo
         axrD+XCAOSoxV2hg4qfjyr7WF9JwA7GvDUdsiDzRuWl7hDEmSvSqeJoOP/PQ/jqO753f
         ePIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216700; x=1761821500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9nOGCAjhfRW/rA97w2j13qaEfOW0Utgue9GQrZT+8Kg=;
        b=oblaYc9hNj6cIEcoRNHEPFtNRRp+LEketjQZtj79FeuW67pw7i5SdWHF93vivOtfXe
         tlxmmQuSUKRK/d00wcES2xSyGN3CL3f/T8JBRfq9D4+2fQCmIIsc+yrqZcf7Ig0BK4va
         9lAq53TcsSujNa0Ed6yRiny0JBjwWFwdtyU0TKetWsLva47SUtL9u4tqIwn1e9OAFwzC
         E4sBM3Jt8ONwyerqS57DoAkRhkhgHunAzdJgt9hdwbqR6hp6x+VuWA9GvmFSf4scEU9u
         oHf8P2PNEJxUv0Rsp1wnABIHd9AZWRoS24SqjE7dR2hpfeqbzvriClX4r1p7PkBFppAb
         YaKg==
X-Forwarded-Encrypted: i=1; AJvYcCVKWis2pFGB4q1UkN2IhamWN5DL1UYyROGecKQY7fMjkOb0qHK5pB6wAu6EbAoqT7+sEeDZMJs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0cbLH/AujEfwGqSYALolqvf4neayvBCA39uiUasaVjjGTqyc1
	9En+HnK3O3xSEjQV2WHmY3B+euP5KnZmu0hDuB5QQYXDdeqcXVnVk6KxUC2qFcMzxjlOXtoI45I
	7zbaFUcbCVLBaq/VkTcrR0THixlTKiptLCTh2
X-Gm-Gg: ASbGncsC7EXRvXyrkYfU8bJV50UdTkRkACoxnD4/4hO2VvXKQsgsdzFLbkJB7z8e1Ol
	++1WlGEiC1X9k2NkYze43vB2lfxQB+KDEcs9+y0bIbckWeZgMR34ZUZzlG2bOrn5mAQhX7a2vjo
	PK7KIK/lDMK6pVJxu6xK8z3YZLKMEpjk4Tb6/UZ8SLQ93Mw8x3LJssKx5lgQ9d49ExfJFW8Sk60
	66bm42rdg+mlH18AcAxJZsPN/jtXFiPHAcQwJlZeQgmzB+R2w6gzkgu5Bejlkqf3OVppnVr
X-Google-Smtp-Source: AGHT+IGc8Zr6ZHZk/XnNfwwGlbXUYEVek6pmNdJwArcHATOCBwaP/Zs6qyLU5fsWQ9q90QkFzK1qEyjmZ0EWfb2kxIM=
X-Received: by 2002:a05:6000:4606:b0:427:608:c64d with SMTP id
 ffacd0b85a97d-4270608c806mr14232913f8f.37.1761216700403; Thu, 23 Oct 2025
 03:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251017151830.171062-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251022181303.3dc4f41c@kernel.org>
In-Reply-To: <20251022181303.3dc4f41c@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 23 Oct 2025 11:51:14 +0100
X-Gm-Features: AWmQ_blhVXyZRFlAYOOFzj40YpCvwBsR9vUPd4CfvpYi-qsCy1xcznimtCK82Dw
Message-ID: <CA+V-a8uMpr+-F6gQZ+y6wrSUfV5BXV_xDaZcLVnwdpiw8g5W5A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] net: ravb: Make DBAT entry count configurable per-SoC
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Thank you for the review.

On Thu, Oct 23, 2025 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 Oct 2025 16:18:27 +0100 Prabhakar wrote:
> > The number of CDARq (Current Descriptor Address Register) registers is =
not
> > fixed to 22 across all SoC variants. For example, the GBETH implementat=
ion
> > uses only two entries. Hardcoding the value leads to incorrect resource
> > allocation on such platforms.
>
> What is the user-visible problem? "Incorrect resource allocation" could
> mean anything from slight waste of system memory to the device falling
> over.
>
> If it's the former this is not a fix..
>
Ok, I'll drop the fixes and cc to stable and send it for net-next.

Cheers,
Prabhakar

