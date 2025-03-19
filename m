Return-Path: <stable+bounces-125589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC0A69580
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 17:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD8D19C3CCF
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 16:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416B41E3DE4;
	Wed, 19 Mar 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xa193cTt"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821DB1DF248
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403203; cv=none; b=cRVk14H3ZTHU3QQ64Af9EMjq+Y9f32b7qU0BmquERXLQxQslWMpEkcjwMHFUZbJPaLGC64vSmvhmFCc5QRD0f0+Md4FS4C/yCd807mwnnTod7T9mu9l/j/mhoXyV4yN4I/ptI8nc5CqgHV3te3sasdT99LfhrWSLcCBW/C+l+gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403203; c=relaxed/simple;
	bh=gZ91fGn4VM1jhjIigc/roNld//H+y2pnwO3JvtN5t1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjOq3MtXTGgrUgmZPdK83EagY2xj9D/wwcr63M3hSFdDt19jFOnlxF9HJKTyiThujLIFk+SsB3qBfMlW8jCnfV5A3X3aYmrIZ95PrFx59BhkSKGJOxphYb3+6Zdw8NkEtBxp3kxvFNtdCTRpGwWNpBsC9F03JqNw9QS1850g0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xa193cTt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742403199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QMYidfuF22qqOjt7R1FtIa+eC5SY/DINipfXYLFNQ3c=;
	b=Xa193cTtLwB6J+31fN+oeph9eGd+cvGcGoI+G+Ar3/BTKeEMfllAoXdhCauWJx/0hNdjeC
	AsxsXW8OnEXZALYm8ygHu41vSAkbpowr8HN6t783GZAoNHhyvfea+FcQ4vP2bSV3UfB/ud
	6laHbXx0CZZoJqlD03fh/7el54yTOaI=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-ie7cooVcMkKO_Cb_qc3TdQ-1; Wed, 19 Mar 2025 12:53:18 -0400
X-MC-Unique: ie7cooVcMkKO_Cb_qc3TdQ-1
X-Mimecast-MFC-AGG-ID: ie7cooVcMkKO_Cb_qc3TdQ_1742403197
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-86c428a6b92so1722643241.0
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 09:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742403197; x=1743007997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMYidfuF22qqOjt7R1FtIa+eC5SY/DINipfXYLFNQ3c=;
        b=Gjb8SBBAHDyJwaj3fnemGpsRR0AtH5O1jmRSunthoEI2vWwFSfAS9/zOfjK+HC+/1D
         0R/VjbOtO7mBAKLX2FWBvD46ioy4vHxQW+9y9b3mDK22c5dqNw0fNu8hL7+BgCXEaqnE
         jbyOI9++sQSQ/8wlAnv7BsfVBGQAbYDM0QAbAh6xCEOeUngRWOTaZ2vtwigAbXjPIHvq
         PbIXe8x4g+3xGxu9tn6B9KVQKRGqJhN0wnKvQRYEhCnhERL/ngoVRUMdTW5Dop4yHl+n
         ZFswhvg9otq8ff46AUiENb5mhep7Jli1mNymEXd1z2v9BG/vo0CWkgpm5fMrlYDU1YzC
         ae5A==
X-Forwarded-Encrypted: i=1; AJvYcCUhZyMqjpb1/2C7WWDfoaAW9NAUMwSMqT5MO8N5YPLV2pIX3LCtGaMZWu6ADoKIF3H8ziaMOtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVuo2+QIYzBI8vI9ZBccahpIXGn56vWFyvB1RT5T+PI2mMgHKJ
	vpEO+7sJGWCclJMolwHUPI3pz1cO8Qlu/qNIvVLWt6bYzdI3eIcgQrmw0yyBK5fcZ39zwVqVXVS
	Njqecf+sHMazbdkI82reWU7SuMZr7B401yPsZVrBEfCHC7EDdDOKKJDkbCDaxbvciTtuT5yIxAd
	U4zKB4GwvhCoVl2Yif+lW+8kWP9UoW
X-Gm-Gg: ASbGncsnqYz3ZbZN2sVY9Z3PgEFXYxgfX/6Jtu3q7F17IeZwTvWBGxnySTSo3SbIyLB
	ZqmeLWi4im0Yx3R/HpPfrIE9YK7QjqIwJRMi8J99I6vQ4zV2meXKZuDkeQfu+DS7EnHdpK0pi
X-Received: by 2002:a05:6102:c04:b0:4bb:d062:455 with SMTP id ada2fe7eead31-4c4ec2f2e0cmr3397545137.0.1742403197617;
        Wed, 19 Mar 2025 09:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBaHItzcn4FKUvbMcp1OcW2oWpcGSy2J17LaT6TvPL1Qm1q4Ep4ILwSlmKbFP+qP7MGksmGbNbt7PDdKxGz40=
X-Received: by 2002:a05:6102:c04:b0:4bb:d062:455 with SMTP id
 ada2fe7eead31-4c4ec2f2e0cmr3397539137.0.1742403197256; Wed, 19 Mar 2025
 09:53:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319064031.2971073-1-chenhuacai@loongson.cn>
 <20250319064031.2971073-4-chenhuacai@loongson.cn> <2025031943-disparity-dash-cfa3@gregkh>
 <Z9rYQy3l5V5cvW7W@t14s> <2025031942-portside-finite-34a9@gregkh>
In-Reply-To: <2025031942-portside-finite-34a9@gregkh>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 19 Mar 2025 17:53:02 +0100
X-Gm-Features: AQ5f1Jq9puc3zDkRAXP8CifSCOyuo9iakTiG2zcMin5No34Rk7G5vb8HVg7uT8A
Message-ID: <CAASaF6zNsiwUOcSD177aORwfBu4kaq8EKh1XdZkO13kgedcOPA@mail.gmail.com>
Subject: Re: [PATCH 6.1&6.6 V3 3/3] sign-file,extract-cert: use pkcs11
 provider for OPENSSL MAJOR >= 3
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Sasha Levin <sashal@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, stable@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, R Nageswara Sastry <rnsastry@linux.ibm.com>, 
	Neal Gompa <neal@gompa.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 5:26=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 19, 2025 at 03:44:19PM +0100, Jan Stancek wrote:
> > On Wed, Mar 19, 2025 at 07:13:13AM -0700, Greg Kroah-Hartman wrote:
> > > On Wed, Mar 19, 2025 at 02:40:31PM +0800, Huacai Chen wrote:
> > > > From: Jan Stancek <jstancek@redhat.com>
> > > >
> > > > commit 558bdc45dfb2669e1741384a0c80be9c82fa052c upstream.
> > > >
> > > > ENGINE API has been deprecated since OpenSSL version 3.0 [1].
> > > > Distros have started dropping support from headers and in future
> > > > it will likely disappear also from library.
> > > >
> > > > It has been superseded by the PROVIDER API, so use it instead
> > > > for OPENSSL MAJOR >=3D 3.
> > > >
> > > > [1] https://github.com/openssl/openssl/blob/master/README-ENGINES.m=
d
> > > >
> > > > [jarkko: fixed up alignment issues reported by checkpatch.pl --stri=
ct]
> > > >
> > > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
> > > > Reviewed-by: Neal Gompa <neal@gompa.dev>
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > ---
> > > >  certs/extract-cert.c | 103 ++++++++++++++++++++++++++++++---------=
----
> > > >  scripts/sign-file.c  |  93 ++++++++++++++++++++++++++------------
> > > >  2 files changed, 138 insertions(+), 58 deletions(-)
> > >
> > > This seems to differ from what is upstream by a lot, please document
> > > what you changed from it and why when you resend this series again.
> >
> > Hunks are arranged differently, but code appears to be identical.
> > When I apply the series to v6.6.83 and compare with upstream I get:
>
> If so, why is the diffstat different?  Also why are the hunks arranged
> differently,

He appears to be using "--diff-algorithm=3Dminimal", while you probably
patience or histogram.

$ git format-patch -1 --stdout --diff-algorithm=3Dminimal 558bdc45dfb2 |
grep -A3 -m1 -- "---"
---
 certs/extract-cert.c | 103 ++++++++++++++++++++++++++++++-------------
 scripts/sign-file.c  |  93 ++++++++++++++++++++++++++------------
 2 files changed, 138 insertions(+), 58 deletions(-)

Should be easy to regenerate with different diff-alg for v4.

Regards,
Jan

> that's a hint to me that something went wrong and I can't
> trust the patch at all.
>
> thanks,
>
> greg k-h
>


