Return-Path: <stable+bounces-81239-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96D992894
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16D6F28108E
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00DD18BB95;
	Mon,  7 Oct 2024 10:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VzXS8xI5"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D52261D
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 10:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295217; cv=none; b=F2dvTTc9IIQqNNIPxVit01rgiVbZ6nhOyqWp11T6Uj6BuY869YWiSIlZWjHxJ0MuMVu3ukigZ2V/solCNYrA64HNJhE9qfII+RVvoKlMivXS5DUXEyCPxuIjET2v+ffuR/nDfxrzKSAD9h0rtV00a4gKHqXI6T5kArM+LcQU57Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295217; c=relaxed/simple;
	bh=NUOR7qj+/wkj6oamVSBO1ic/DNWbPDk67N13HM9yFFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p73ZGLJStqjMU0lJgp9n3LxYXgHL1OcB6IJu76VzX/bF+74jtucMi5LRTYOWbPvcQ+xprJ1Kbujm82ddxGEYcwjHBZA2EdycHQhUBAhTsy+3AycqS3BWJi10Rhtz/fVwwSI2A2DfVhb7iNRx5BumID8eswxSWLsRxHSN5oiMWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VzXS8xI5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cfa129074so2895088f8f.1
        for <stable@vger.kernel.org>; Mon, 07 Oct 2024 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728295214; x=1728900014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEwjxMNY56oTzbd3XhPW0x+k9Hrzf7+Yv7Y9xFtgitg=;
        b=VzXS8xI5iZic7v0PxWvDsXu7GDcA3cJDTWAXHClYXH8TCIxY4umwI1LjFZMNwmVyP2
         JLu44Rv/tL0xIy+ndMbxcOcxfQyV1Qf3SHHue0lHgEPZnOWtHoGu1NbRSfF/RMT89COJ
         008CuY6bjxXY2fPgDYz7RwYa+oZKuCTRWUjq6wBl1md+kjx6CfQYy+r90Rm3kXk6pHjk
         tM3SUZNxgz1LzUuZyrMy2Spea9IK52en1kjuX4xhmCkO4ljHzKoG2jInFhbp/vkJeZ8N
         BuqfF1dSS9t3sX9avI5N+8PQh0DVHI+ynSaILWcQM1KXGzvy0tRxIXSBkTYDYzW3FSaf
         rACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728295214; x=1728900014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEwjxMNY56oTzbd3XhPW0x+k9Hrzf7+Yv7Y9xFtgitg=;
        b=p45rvYD2UPRI2X6JLcE8xKqUNQKfBYBfBnTLOcsxJ1Esh+i79Tvq1kEkL3EnhU/O60
         uAoFZ+FQKSX7c2NU36+celcj6jrb/e8gA/PQ9hwK6JuozKfRSEuLsAgqXOnA8CLynxl/
         agsDFaWFi/j7/UQEgYQN70ukDhKjv9VHTG3/cRV27BCExzdrWf3udBQBtD607DNT/VQR
         XjjuwpEOsU9h+zHyZcjArDkspOyRK2SUX3i5OITEnHxC6dL5cfz7oFB8BjQUaY6Fn3Tg
         azlhcmqmkwsfNQtp6oeeIoWfFAc5RadDCdFiVBDxKT09QawPxA77Rzj70kSpxES99nUR
         /jvQ==
X-Gm-Message-State: AOJu0YwZSzJi1st3ph7u0bOHJ1VI7nuNjtcAkCvFhnNKNf+HA/EVkVsf
	MmDc7nC67QL7z6g0WIqeFTr4d096M97Gi4Zp+q1I57htnDgPzK0pJ8qZ3bk8BU025Ti7KyZjU3n
	e6+4=
X-Google-Smtp-Source: AGHT+IGQrnzcgKJlfynFiXUAD+cTMQHxAYd2AL6OuEUp2eB79i8P/iEbdxIR9rTZM+LAJ6BTAAZJIw==
X-Received: by 2002:a5d:5604:0:b0:37c:c5c2:c692 with SMTP id ffacd0b85a97d-37d0e4f8a06mr5698839f8f.0.1728295214138;
        Mon, 07 Oct 2024 03:00:14 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e0594932sm2965896a12.16.2024.10.07.03.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:00:13 -0700 (PDT)
Date: Mon, 7 Oct 2024 12:00:12 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: Patch "cgroup: Disallow mounting v1 hierarchies without
 controller implementation" has been added to the 6.10-stable tree
Message-ID: <ca7qy5ccqffwxscpqhzndsqhbpnvgwg4k23ktffkop3t6kjltm@odwgvz4jvi62>
References: <20241006152759.10704-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2rntgkh5sp74saig"
Content-Disposition: inline
In-Reply-To: <20241006152759.10704-1-sashal@kernel.org>


--2rntgkh5sp74saig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Sun, Oct 06, 2024 at 11:27:58AM GMT, Sasha Levin <sashal@kernel.org> wro=
te:
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

There's little benefit of this patch in kernels (pre-v6.11) without
	773e9ae77fe77 ("mm: memcg: factor out legacy socket memory accounting code=
")=20
(and later reworks)

HTH,
Michal

--2rntgkh5sp74saig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZwOxKQAKCRAt3Wney77B
SQSfAQDF2X6vaJ+R0bNFAPo/rsCBOoBZ4OGfZIuOZqPP//iEgAD9EWJqEouuvPG/
9ykptX9Z5juB9+tyXyZcMKkhGHQOBg8=
=twjX
-----END PGP SIGNATURE-----

--2rntgkh5sp74saig--

