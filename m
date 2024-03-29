Return-Path: <stable+bounces-33144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D938916E4
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 11:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433581C21BDC
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 10:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDB84AEDF;
	Fri, 29 Mar 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dqAG/k1T"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FBC56455
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708392; cv=none; b=pL/unqYggSBtcgAPsdQiEyIH00+FD5njS8syGGJkmT07oBkCb3fv4unIYt7CgcPLX4GKhY2t1w/sQ+9UP8aYPqXnkDW0tsYJpyAIKBhw3K+IWIMYvuLIYeiYTf5COr1FboH+TCmrSsWL9jrP7UsysYrxrEdpgchX9Vu6fg8xf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708392; c=relaxed/simple;
	bh=DD6Jah54JvVvy/pv9fBbtNuZFBhf+OamddQ7th7HeoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r2I7fIKXU8z76v0Wm461dtGDogLAtzAHk5MIf5i0PiUP+GKYPThLh9FQe35vhHK4Gg6Dp9cCZSX/1WEudL80OQv01eJRxaqUEzA7QosR3f4A1Lp8lxXBBc2ZL9L+qtagd9tb/UHenk/5wj6NOVVyhhqps1h/h7CwHv42d9R2EBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dqAG/k1T; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso236869766b.1
        for <stable@vger.kernel.org>; Fri, 29 Mar 2024 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711708389; x=1712313189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwoDgUONbFIzKdwbbRbTYAlPST0Ig55g88KHArxxc/c=;
        b=dqAG/k1TZGFK4J69GU1sKJ28uJU+FZ/elLKmkiZyngpDgrYgKVxj4yV2jUlZI5ZYFh
         32lgdO1Fw9aOxq1q+Khep/2Ulz0y4+ctNTp/GvPzWdZj8m9vnMcMzo/3MncVQm84XNwl
         CwDkLkCBPpNDsbVWNWhWKcT3161witvdQJvxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708389; x=1712313189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwoDgUONbFIzKdwbbRbTYAlPST0Ig55g88KHArxxc/c=;
        b=raE8g8soIipJ8Mh2aXMK5iCXV05vDwQ4Wzbvde/y9l+oxDych+X6n+DdQaXPTI8cYA
         daM9gn2MDvAB6Q2huZ0PXHTWVmez4NXiryQsTS+3+1HpIKUZm3n2fhtstB6B2hZYuNVH
         rtohl22R1rLcI5GWKC8737ZC4DLZ1jefowM5uDJkKwPUyUn2IXshJkD5MQUGmMLI/G2J
         /XMz0cOcH84HMKVUrc8+JQPDkPRVy9kMQlHZv0zmRO/9jF5clrsBRc9ESkDW/sOsxg4Z
         N8v3DjyQcMhqzSgKoiUwYiChCSZ2Ic4Dl+VQUEgdgQLPgi/ovQXzN0ZL6isXPDh/ANxd
         E1zg==
X-Gm-Message-State: AOJu0YyJQvcgdnKZiEfXH64+VfTRmvVVW0Db7XnvaW4wxsIg068Cvlub
	ycn9IBQn9t4pQuwxyfpr2jLXjP6+orewb1FpHO0xx4/QFiZ7gxmTVHvogreYg3Zgg00g76E3dmc
	6GU1Gik/jE1wwTSXcGIESHjR6BtuLYECvu8dT
X-Google-Smtp-Source: AGHT+IGVGcA9bR6UFeCQVCvMVEPcupaxgap9YC4ODdnvUbwCtxUjIvbwg3uzTjmWUTuBUs4WUwHGNMCIfALbUmIQgiA=
X-Received: by 2002:a17:906:f58a:b0:a4e:3c1a:d6c with SMTP id
 cm10-20020a170906f58a00b00a4e3c1a0d6cmr709159ejd.9.1711708388649; Fri, 29 Mar
 2024 03:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328123805.3886026-1-srish.srinivasan@broadcom.com> <2024032945-unheated-evacuee-6e0a@gregkh>
In-Reply-To: <2024032945-unheated-evacuee-6e0a@gregkh>
From: Srish Srinivasan <srish.srinivasan@broadcom.com>
Date: Fri, 29 Mar 2024 16:02:57 +0530
Message-ID: <CA+1BbzyCr4sFS8qQ4U6g6mi-sD72y==ubBd2bxXiRLEvvx8-KQ@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	vakul.garg@nxp.com, davejwatson@fb.com, netdev@vger.kernel.org, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Simon Horman <horms@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 2:53=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Mar 28, 2024 at 06:08:05PM +0530, Srish Srinivasan wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> >
> > commit 8590541473188741055d27b955db0777569438e3 upstream
> >
> > Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
> > requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
> >  -EBUSY instead of -EINPROGRESS in valid situations. For example, when
> > the cryptd queue for AESNI is full (easy to trigger with an
> > artificially low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
> > to the backlog but still processed. In that case, the async callback
> > will also be called twice: first with err =3D=3D -EINPROGRESS, which it
> > seems we can just ignore, then with err =3D=3D 0.
> >
> > Compared to Sabrina's original patch this version uses the new
> > tls_*crypt_async_wait() helpers and converts the EBUSY to
> > EINPROGRESS to avoid having to modify all the error handling
> > paths. The handling is identical.
> >
> > Fixes: a54667f6728c ("tls: Add support for encryption using async offlo=
ad accelerator")
> > Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls =
records")
> > Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > Link: https://lore.kernel.org/netdev/9681d1febfec295449a62300938ed2ae66=
983f28.1694018970.git.sd@queasysnail.net/
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > [Srish: fixed merge-conflict in stable branch linux-6.1.y,
> > needs to go on top of https://lore.kernel.org/stable/20240307155930.913=
525-1-lee@kernel.org/]
> > Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>
> > ---
> >  net/tls/tls_sw.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
>
> Now queued up, thanks.
>

Greg, this patch (i.e. v1) has hunk failures.

Just now I have sent v2 for this patch (after resolving hunks).
Requesting you to queue up v2:
https://lore.kernel.org/stable/20240329102540.3888561-1-srish.srinivasan@br=
oadcom.com/T/#m164567a5bd32085931a1b1367ae12e4102870111

Sorry for the inconvenience.

> greg k-h

