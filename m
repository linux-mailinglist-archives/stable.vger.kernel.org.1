Return-Path: <stable+bounces-233218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPjKJonrz2lF1wYAu9opvQ
	(envelope-from <stable+bounces-233218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:32:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4D3966EB
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 18:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A993B3049529
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4811F3CD8AD;
	Fri,  3 Apr 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E2Rg3Hzs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF74A3B4EA9
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775233640; cv=none; b=aXxAT6rbFEJYalZeM0iemjChtGjlBk4r/e2pzMMPOIoZHRItcJtOKOol0YvTTQLa6ZBA6iEhwPNf8usXSc0FBRkLf4+QI8Vj9V8kjJuePqciD0AzBD/xsekDs2xjLgQdgDVAe4EDCOM+hUr0BEyF9CrCyjGIgi1y3KD5KpB6aA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775233640; c=relaxed/simple;
	bh=pvTilDtBhKBIY+6xx/s5Gq6hvXKdnLiCnQn+KLPaRp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKphBzphCnG3O9OZd+5ks9P+pL8JbhU3B9I3DjT7U3pTe9ZUhMPaEo5nVd0bytWg3jNJsgFPgIggj6Poxo7w5b/+XRp5hUvKUPJOZzd9dBF4faXFul5FUTvVqnyzkCP+txVnDIG10RqlzUkeJ6MEyy6pwGI64Zqc2g99AanO4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E2Rg3Hzs; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9c04152730so310877066b.0
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1775233633; x=1775838433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUeQPGIt87F0rbyVQr6vuwoCOQ88eKT7ufcAUrXIRo4=;
        b=E2Rg3HzsztwqqvPOg+r9k5//9Lt88uD83BXycqqKT6urZ3PuPvEfdlldZxdaPLlOzV
         Lyb5S1x1tlKdEMUk+uZc4PO72Ad7NJUNgm74jxltv/0GEj0QdgFj/0XMqxnNswCBt+jT
         baDGlctS7lz1Aw8se4IHEwVPdZtF5WEhsXMO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775233633; x=1775838433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OUeQPGIt87F0rbyVQr6vuwoCOQ88eKT7ufcAUrXIRo4=;
        b=BTfEYHLdOdxF3LBZ9MriYukYAPLafrJcvYcBGXUm8A5nNb8/CfKF0h4aMdugbuSlE6
         WgN8howf/GIi51XMkjcFbF3kuJQeTQt62rDa89Y3Yb/1dw0ZyrE/PXUhSg+4zTpmLMSM
         jdOO9cI43Sm1vbszKcDxRmwyC6k3aGGW7ygcSKL8W5PrpUdf5ngmngaDGoKQk7k6pacA
         6pPgDal2DCn2ozkVRoU3m8rGIhIL3F2BgqQQUM5lXNcl2oqr0ry2ZnqZ4CwoS8JfYbBM
         yejaOlqpUEpkHtgKTDSp0GtXB2sRbjTVtVluj3jdBU2ljvG48WOWKjzjn/mB9kt1Zy+s
         +cfg==
X-Forwarded-Encrypted: i=1; AJvYcCXbAwpfGEF8K6T2IAE1fm4G2PdObpHi1KT9KZynue+Og6xXICPj8l/YBKLx06CH6wlH4FOszEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YymuUwnqlxZV2Qqq2AQs62P72BLN9BDCnMghsT1KwT3bNlpztc2
	oZnp7Oy2y5WqS0vvAtsUC+TGtoAjKTktB2l/SQl8Ay4ezwZ8Wwx5CvSgbMjBp4ZY+Jwbhq/YhHE
	aRDjvov46
X-Gm-Gg: AeBDietLX3Xdrsw5pvBt4nuvPPpQD/1BGSLe/kHak4z3YiiVvhk+z+MGH+LtR+qccPE
	MEPmeKxcfwvqgh13GbPIuBSD19mNDF20VBu9xDcItxzwyFlWeeNOxElaIq9o4Zj2ybv48ETbRuE
	89I82EpZR4YD8r+N0FfvBcVFZZ24/SUMVO2psm8C7GPzG2Q5DfWzLqf9KqMBTn8eIo7gClSBY+4
	M8clHKrytdvM71NrleKYt8yzGgfthV2isABjMgTULymyB/IpiojLzr20gxtI2oFRV5eX2VpVOR4
	KJXi5E3Pzp8pdn8jGGAtomgk6uXLdQ+JKUNKP5TkDEtjEipWen5mwvrwCS97ITW4oQRkEGwC00Z
	t85zljaUMCwpshALA5X5vWinYwoOL0LmhKw/lHo7uQt35EFTHZP4rgoyNF5BMQ/l2In0fxCHE1q
	ZaQu8v4gl6igU1DU1e5BxtndHwW6dI3FuKP1VJ9+8nDHnwPqqSo2TMoVDzkA/0kQ==
X-Received: by 2002:a17:907:25c3:b0:b98:8a9c:7059 with SMTP id a640c23a62f3a-b9c6744d8b8mr172387166b.19.1775233632911;
        Fri, 03 Apr 2026 09:27:12 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c99ec6esm207786266b.16.2026.04.03.09.27.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 09:27:12 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43d17bb1c1dso1903705f8f.2
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 09:27:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlCeAAKWrMwHZntZ8efRFXchlN5Wv2jKNMBsHInzbVvfQteQ0EqQRWLXq3hfUkqLPsP6w4f30=@vger.kernel.org
X-Received: by 2002:a5d:5847:0:b0:43b:4e13:221f with SMTP id
 ffacd0b85a97d-43d29300bf1mr5983818f8f.47.1775233630478; Fri, 03 Apr 2026
 09:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403005005.30424-1-dianders@chromium.org> <20260402174925.v3.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <2026040319-seventeen-humorless-5541@gregkh> <CAD=FV=XmnWjVzQcr13GmRKX3cvRortA==5C8TH5D-jRBe0VBqw@mail.gmail.com>
 <2026040353-glamour-repacking-0e53@gregkh>
In-Reply-To: <2026040353-glamour-repacking-0e53@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 3 Apr 2026 09:26:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XvqPH7FkRh16u7EE3LAuw-oUYbAdiL1nZxizVft2TqKQ@mail.gmail.com>
X-Gm-Features: AQROBzA-JM1RSDMJUI5giQRrfhVGhdnJrGAOYUF8apJWtN8tBElJTzv70RQO5p8
Message-ID: <CAD=FV=XvqPH7FkRh16u7EE3LAuw-oUYbAdiL1nZxizVft2TqKQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/9] driver core: Don't let a device probe until it's ready
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Robin Murphy <robin.murphy@arm.com>, 
	Leon Romanovsky <leon@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Eric Dumazet <edumazet@google.com>, 
	Christoph Hellwig <hch@lst.de>, Alexey Kardashevskiy <aik@ozlabs.ru>, Johan Hovold <johan@kernel.org>, stable@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233218-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AE4D3966EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Fri, Apr 3, 2026 at 8:44=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> > If you wish, I can turn this into something like:
> >
> > #define DEV_FLAG_READY_TO_PROBE         0
> > #define DEV_FLAG_CAN_MATCH              1
> > #define DEV_FLAG_DMA_IOMMU              2
> > ...
> >
> > ...but that seemed worse (to me) than the enum. Please shout if I
> > misunderstood or you disagree.
>
> If you make it a numbered enum, that's fine (I hate unnumbered ones),

Sounds like a plan.


> and a comment somewhere saying we will "max out" at 63, or have a
> DEV_FLAG_MAX_BIT entry in there.

Sure. To be compatible across all architectures, it should probably
max at 31, right? Atomic bitops works with an "unsigned long" which
might be only 32-bits. Oh, actually I should just add "DEV_FLAG_COUNT"
at the end of the enum and declare flags with DECLARE_BITMAP(). Then
there is no max.

In total, I've now got this:

enum struct_device_flags {
        DEV_FLAG_READY_TO_PROBE =3D 0,
        DEV_FLAG_CAN_MATCH =3D 1,
        DEV_FLAG_DMA_IOMMU =3D 2,
        DEV_FLAG_DMA_SKIP_SYNC =3D 3,
        DEV_FLAG_DMA_OPS_BYPASS =3D 4,
        DEV_FLAG_STATE_SYNCED =3D 5,
        DEV_FLAG_DMA_COHERENT =3D 6,
        DEV_FLAG_OF_NODE_REUSED =3D 7,
        DEV_FLAG_OFFLINE_DISABLED =3D 8,
        DEV_FLAG_OFFLINE =3D 9,

        DEV_FLAG_COUNT
};

...and "flags" is now:

DECLARE_BITMAP(flags, DEV_FLAG_COUNT);

Yell if you want anything changed. I'll restart my allmodconfig
compile tests now.

-Doug

