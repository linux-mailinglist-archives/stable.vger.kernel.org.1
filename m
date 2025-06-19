Return-Path: <stable+bounces-154793-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F1AE0416
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 13:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24913A6AC8
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB18229B29;
	Thu, 19 Jun 2025 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsIeVAb1"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41C82264DD
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750333283; cv=none; b=uhU16Gz1N7gM5Wjt60JyFTC98z62W3hEIEOXC2hud8EODiacE0bdV2sHtwCxNoa7MtsPm8KdFAwhori1GsfUZEr30paobVtaGITnHRjQdYcHgvM4jT6qBQYfWTIbQCbbugLaeANZ2gfQgLDpMtAFC10865HKDuhT/J6lCVWvJzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750333283; c=relaxed/simple;
	bh=pzQ/qY1YTJoEEr9jqjLDXqrdQ4+BrFLRDT/nI1huIkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNlRZ1QmDkzsR+ft3NF7I+eo9KdH8yG1OcCbmgQx/C95Lgf95gsAokJ8aWkJbIkySC0SOVUWZnqhSq/1dVYjT7y9QOkhnE93ZWNStCQunpTuxCjeXS8G88x5amRHpfsdtXka4lpBYqG1+/v6hCE+LWLIGb6KQE6DHqtGfFZBtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsIeVAb1; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32b910593edso2680101fa.1
        for <stable@vger.kernel.org>; Thu, 19 Jun 2025 04:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750333279; x=1750938079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG6S8/NjXIgKO5wMRSf8gWFWSdx/l0RQ5ZJ9NoqkvRE=;
        b=YsIeVAb1jBD3296p395mLdi0S9G5xL+WdUQYTFMoyCG1Td+w0tSHsJzNf0XzVMX2Hr
         F9NwM641ovXy8nHwDm6dL7gHfV5YwCIoncYcAsAeK5vzH8FlHTDpj0KdnyZUP3KSKV0X
         FakYGxmngJydLRK3k6nBT2WweeFZMoZuIIgkYtlJDswQU6c4zcX6f7HQnQXkqQzL3jxN
         PgmKRpo2nhBunDp6T9nt/1mLGjXkAmw6lfzuH0xliy1gXDYPqxEpE4ZkDRnozENv1ABN
         dQh3d7C9GaHnSeD4ynzYuLOr2k7VPKdQ0Yj8sZQchHMjnDn3TlaROzbBXhPn9QbQ46d6
         4cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750333279; x=1750938079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uG6S8/NjXIgKO5wMRSf8gWFWSdx/l0RQ5ZJ9NoqkvRE=;
        b=w8ZO1tYrTXpm0sOegSWza4Ghf2Fs9kSrlsbCSL/jT/hULJkvKg6Pcpt04E+bOGdeCu
         c/4ZkfMTgtdL7q+gUo4zXxMeyMIC3w8L8J/32b2IRisML2K/R9/jQNVv0x4cZ/Vyy+Sm
         Q61yNTCyPxm3FD/Ytavoz1cHSm7X8o2CgDi1RI7hvVT7qTH7NvdkBaGqson/agpiPgiY
         eX50pHhwoi61FO/FgRgBuV2ZY5McAJkgM8Z7kAhml25CRNDTUzrX6xcuDCfqDwGbUPEh
         jD3NUuP+cXaAt9DUmiPk/GJgUHX+3eQPnj5ZRRvfQuR7fWqAvDcSxpm/5CN6YJw1pQlv
         T/7Q==
X-Gm-Message-State: AOJu0Yzldt9ARdk8SROURIk65vGj1ksgNutJj25GgtnXIVKscKZa9xKQ
	KNycdXLtTjQfWoYt8WLWCOmxsvuAMMducFsGUe5aByw2C1B0vd01MbIqD7X5FKy3j/DQ8phztvD
	K/ctEnfR/hokT/F5MhiIzbv0ttOot9D+qtA==
X-Gm-Gg: ASbGnctWbxPnnujh+hBjRugodkeOTmcDHSHUGfuJS8VBYw/1yWGHidF74X3QAkTwB/G
	OGj6vMZj0x+YgQllLmiXsylX913ju79T0bQ5vfkUVXzw2ddqpVTQ/S+/jCut1i5Xtw8Lzl/vkYS
	wXuSBq3RE5+NJpNEEx/VRlhoHcI494HUG8xdGs8qHwW/s=
X-Google-Smtp-Source: AGHT+IG/DLjSH5lCwIdlhJTb4loXHLpS/S+4tsQ3LTvt5+YhoHcp4+Sk2M1FFgj2OKRd6kkriZdto3aAKd5PBhUJA14=
X-Received: by 2002:a05:651c:1505:b0:32b:4fd4:f1b5 with SMTP id
 38308e7fff4ca-32b4fd4f515mr52489361fa.27.1750333278386; Thu, 19 Jun 2025
 04:41:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA76j91szQKmyNgjvtRVeKOMUvmTH9qdDFoY-QRJWSOTnKap5Q@mail.gmail.com>
 <CANiq72mRB7cbEpKdWm_k2EPf5zdHL8K=JT2Y+4XGwywN5AX9-Q@mail.gmail.com>
In-Reply-To: <CANiq72mRB7cbEpKdWm_k2EPf5zdHL8K=JT2Y+4XGwywN5AX9-Q@mail.gmail.com>
From: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date: Thu, 19 Jun 2025 13:40:42 +0200
X-Gm-Features: AX0GCFuXnZaWqZoGwvZCpvDX6GIZfs_HPvMyThISVw0VVvTEGuqRh8H1wYN-qpE
Message-ID: <CAA76j906WD6UYN_Q_94q0RQt3-9GfX9U=49KWqaPDCQQzcQA6Q@mail.gmail.com>
Subject: Re: [PATCH v2 6.12.y] Kunit to check the longest symbol length
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are correct. My bad, I guess I copy-pasted it incorrectly

Thanks for pointing it out.

I will send the correction in a new patch

On Thu, 19 Jun 2025 at 13:22, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jun 19, 2025 at 12:00=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
> <sergio.collado@gmail.com> wrote:
> >
> >     54338750578f ("x86/tools: Drop duplicate unlikely() definition in
> > insn_decoder_test.c")
>
> This hash appears to be incorrect, or at least I don't have it locally.
>
> Should it be
>
>     f710202b2a45addea3dcdcd862770ecbaf6597ef
>
> instead? Could you please double-check?
>
> Thanks!
>
> Cheers,
> Miguel

