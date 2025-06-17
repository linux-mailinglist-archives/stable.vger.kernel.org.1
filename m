Return-Path: <stable+bounces-153535-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB8CADD4F8
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3616E3B8C96
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C42522DF80;
	Tue, 17 Jun 2025 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIWT2g2L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941CC2F237A
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176279; cv=none; b=htSC0QNLP+oq/A5h7kYG/NrvUyrtBDa10MlsVIE0j4uxj5zjyBUwe7JhrQwh4xcKraEyLuQhS2mn9H0W5EpaiUwYSwC/0L+XOMAMvlYN0FlORgd58Vjw2sbU+tXCTh+2x91mAt45w0UIwdIkHwulHyCqIWuv/Rsxk0mwdwxXp/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176279; c=relaxed/simple;
	bh=bN4PkMQM3zxK560E0186UooZs5Ho0CyJ+4xK8CNBJm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccJ1V3LtxFD9YSN0wwjHcNDW+W3C9jGlzyFkbHDnjAAv2HbYcZd9o35nWEcB3cxR8zCgL3Wkv4bOAs6RUvXds3PUlXUO7qxEnKmol8Shl3+n0UU8cqslb78II+a64Q0y828OkUlHP18Ps25gaGjxCzymFXYWO8OvzGt1QofnBEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIWT2g2L; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2ef73f26a9so249568a12.1
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750176276; x=1750781076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoL9pPL4wkcEXkWpIwwUzE5tMiwJ2CM0EmlkMjSDtII=;
        b=OIWT2g2L8YOb1gekThemxzWv9i6xsNjqEYIoL2OXUDkrcx2sa+WXmleiZu+80Yhcgb
         yVwZL5Qp1eDxYgEq8Cbz0aw3QX7qvAz5HF5SrpGWkAiOrWZzIRuzIgy1yZ/hsBXeI6BO
         fNUWdChGt4mf5umYqcvMaiSX2+M36dxnF6lvIwoAA/tdPADOLTon1R0XvUjO+OEZdRuY
         TocFGnPqOz58sp2WSIFPwvGH4Jl8NIjC/vtbrKoDNtym3gvT46AkTJit5XV6TVP7fD5r
         7VxJoZgpZGATqPB9+kQPHhp84DBudqsbFmRU99LYLg3DDO5TgowziVUjCdqNKU4tCloK
         KbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750176276; x=1750781076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QoL9pPL4wkcEXkWpIwwUzE5tMiwJ2CM0EmlkMjSDtII=;
        b=Kbe/cC22q5ZKWAYurOpyuX1D/4786i47ugmZGIDxC1d2BVt5qckPQ10Zd/1rJ5GJ2O
         3Umy4q+Cbc7A3paOVv81YYbp3sqUUbaLAzyL1wXmosqZVfb2q1Sfb/lFqEQ5q6tdNswj
         bPw0DAeA13JMnvOz9Ph2JPJgm74If9mR+NahfbamABeig1BQYxZYrnKRZHUS2obhoKlj
         vxiByI+L09w5w5diua1Ns1HFUwozQMLY/uk+XUvITeFHL7RoNlXld7vxwxh+ntQMUjWF
         GdBnwhiiVIeahl6P3CkFMMgg8a9C3DOWCa0cnxTcmZGdAsUMRrRRZB/xOyk5p7uqmnUH
         LE4g==
X-Forwarded-Encrypted: i=1; AJvYcCUYqPhsvXN2kX7s8/0AcayeEumURxMGM4FsiPBDq4mlmOyjEqKHOJ0PZKtUvLSgOgs0xGwCEes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXY2w9lnsWLqZ+bmPN7tJ2pJm6kZT5+CXKrqqvfDceoUdykt4j
	OOVnh/KI2E0UNkR70uj7q60CFOpZlPoCl6eO2EZW4lTapowot0Tv8yrol3jU01SsVHiYlecwibe
	pperf+pXBOfsnTQxoimZ7D98Yc1vH10E=
X-Gm-Gg: ASbGnctX1D7Zi6K74WOg7xyKvJP623F7a62q6ci/X4ICewaavBxypqLQ9o5nMi0P8Jd
	GrnrjvznIt2S2kYK2IQ5vJ3JoPfmBmc7ZVRdaYIamMBS5Nc/Z3LJzJL7eYKQXyEt3vm7pdQ5ObU
	L/U9FgPJc+JsXs4vh5YUcFgp9rC4l5EX9chaVzatrck74=
X-Google-Smtp-Source: AGHT+IF444PFKhRLjckYqe9N/y0hp4iazCmb29qPLT7xf3jS3xJmcSen6UF2CEobpeJRB19X4gadIfcG/G2gWpmsujo=
X-Received: by 2002:a17:902:dacc:b0:236:71f1:d347 with SMTP id
 d9443c01a7336-23671f1d670mr63176425ad.10.1750176275513; Tue, 17 Jun 2025
 09:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608145450.7024-1-sergio.collado@gmail.com>
 <20250608145450.7024-2-sergio.collado@gmail.com> <CANiq72mVx258c0rbGDwF1sP_gn0v_L7PPMG1q1XcBF2OQWH9-A@mail.gmail.com>
 <CAA76j93Bj00WmWEQeG3vi6YJtN1at8=fbryvf3-JP_gaBcnQkw@mail.gmail.com>
 <2025061731-onscreen-lethargic-d2b2@gregkh> <CAA76j934ogMSGU3K9jmUbbdHFXiEJ7EkG=x=tgYLPN5xbiEKqA@mail.gmail.com>
In-Reply-To: <CAA76j934ogMSGU3K9jmUbbdHFXiEJ7EkG=x=tgYLPN5xbiEKqA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 17 Jun 2025 18:04:23 +0200
X-Gm-Features: AX0GCFv5qOY5r4F5syVnqexdPg3qoBcmsLSY3ag5x5_tJV5_d4B5saUvhCxrxMk
Message-ID: <CANiq72nzSoupmLbMtQuckCu_MaFTpwv7vTrbW+055VOP1Pb65w@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 1/2] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 5:51=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
>  Should I resend the patch v2 with the full hash? or is it ok as
> Miguel already mentioned it?
>
>  commit c104c16073b7fdb3e4eae18f66f4009f6b073d6f upstream.

Since you said you didn't modify it, then if the patch applies cleanly
against 6.12.y (which it seems so currently, from a quick test), then
Option 2 in the instructions should be enough.

Thanks!

Cheers,
Miguel

