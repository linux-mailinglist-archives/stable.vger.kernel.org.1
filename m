Return-Path: <stable+bounces-205084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF65CF87D4
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 14:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94A933009FB9
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 13:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC632ED37;
	Tue,  6 Jan 2026 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mSdGiVoW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B995432E144
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767705250; cv=none; b=R4AbvCo6D0UIUUvuTEty4xpgOeyp+yTW54so8/aOyQ9cMCY+sQQtDxDH/mxz3RuloVIITX6XsOiIx09KOH9YxKC11UkvfTbAQMv3aGY6woEf9zTrCZvEfQRi7syxbcs/gwndTMj/yFmnv+HcP5H6MW8Bp3ajy1P76TIloxyVh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767705250; c=relaxed/simple;
	bh=xhANzf8zPHqInwt7sqx1ceuLymDpjEml1Zk8b+gRlII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SCkeFgJgotr+ntE1c+drjRHbfFBuw4dLFWUlcypW/fvGOQhhX+qTvvJw8FqD83RrqA63CIKO+JiqPntJOeg8bvs6AfMVeOUE+vwrYpS0y6GCQ3PGeOrYeljOAMpbjuW+hoTqhqrqN602wllZ7O7/WJexdpxa4jljEJiUqO030LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mSdGiVoW; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a2ad13c24so7646506d6.1
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 05:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767705246; x=1768310046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OKoNVgafDUk8SCtl+9edMLUBCEIskB7+sjp4jDlq9us=;
        b=mSdGiVoWGQ8WVOy3pDHc//onwx0ZD7bPlESoG/mheZPPl6OvGXY00QG5zUeHHsUpoC
         ZkIM5i3kl+q/BmV/c2UxY5Hg6cYFZNfuGTW/jbw9jPoaiPzS+G2sevBXqVDL5InkW8Rm
         4KGZoK+Aan82oN0WywwdZT+sZFWKPgoiLzsTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767705246; x=1768310046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKoNVgafDUk8SCtl+9edMLUBCEIskB7+sjp4jDlq9us=;
        b=qJcwKeBEaJlwvBb+mPW3Gr1ROhqQ841hVpjeDN6p64kjHnQGrVZ/hVUwVMsfBTd7BN
         Vynf2CMNqtRd/f8Qobz4zoNd+bIRJkQiZOnBVyWHmY0tCs4mPD5yS/A/Ihqs72EvFzpi
         thk+JndLnx1L38gZzdFztRAxwwu4K2oJpQYpNLI6518g416StT4N4xFNv7Z9jyQYP2He
         Bqw9AGCTRsj1UHjVPCMnz1KqG0IuhNDeBWBc4es8ouEJjpkVw10n4sYn4SHN8yfbrW22
         WegvivVChmBvugul32Qhfn/jFKUv9oCu//uCUsFOWXIO3UEM8YvfW/K9UbEPqNnN3HYQ
         sOnA==
X-Forwarded-Encrypted: i=1; AJvYcCUugO1owWSX6Jf7EVZAzXwZLVrEzOwVB6BYkZRgOBSskxZ0YYH5mUa/TyIguEe1311FM4dNarA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMULTY0CgmKg/ULOf63c2Ao8vwL33qeTWU+rdJvMME2To5yOho
	fnlbju788reqWIXqWJxoaI/ysty+mw7c30iG6njFsG3yKLZGUmTUCcca0sE/khwNCigvdffn0XG
	q7mdk51fpnfveEn4cjQi60uGfMEjsx7BWcl8rLw2sAQ==
X-Gm-Gg: AY/fxX5b/nu1hAieMzVCL+5VUpJ2+Yp6pISL9vNlVU2MkAiWNAzLV8ASGvyQI5k2dKy
	azVkbY4X/MzSoooN56eaeQflBpZEuePDkacphbvWHmoAoYoCCM8pj8aNITKTveVivnw8ym/pphs
	Nl/6bpbICYPpnJdVy/se0//Sih+fpxFX1nZH//Qejhh/J45xMWwm0emwDCiAXXXDd4guCXqIbo8
	DMvvhecN62fY1PMsTL+yO/c5VgihrzH4q2USGbxVU9QrMy6hv3wkO59wJIf2TZZ0DfC8g==
X-Google-Smtp-Source: AGHT+IHW76vCaJhXrXtTlnreXmPXnBIYSekopXMOxH3fFuu6sJOI0CsMQDsWF0DT/SavMiCaskutPoC4R4PdrvU0vSc=
X-Received: by 2002:a05:6214:5786:b0:890:587b:207c with SMTP id
 6a1803df08f44-89075e43bfbmr38843306d6.12.1767705246435; Tue, 06 Jan 2026
 05:14:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <616c2e51-ff69-4ef9-9637-41f3ff8691dd@kernel.org>
In-Reply-To: <616c2e51-ff69-4ef9-9637-41f3ff8691dd@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 6 Jan 2026 14:13:55 +0100
X-Gm-Features: AQt7F2pvvv_dgMF5DVe6cpYkBdBWgiQKoSy1bex9EciACOPG1MjR_kzstwfJ66w
Message-ID: <CAJfpeguBuHBGUq45bOFvypsyd8XXekLKycRBGO1eeqLxz3L0eA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 11:05, David Hildenbrand (Red Hat)
<david@kernel.org> wrote:

> > So I understand your patch fixes the regression with suspend blocking but I
> > don't have a high confidence we are not just starting a whack-a-mole game

Joanne did a thorough analysis, so I still have hope.  Missing a case
in such a complex thing is not unexpected.

> Yes, I think so, and I think it is [1] not even only limited to
> writeback [2].

You are referring to DoS against compaction?

It is a much more benign issue, since compaction will just skip locked
pages, AFAIU (wasn't always so:
https://lore.kernel.org/all/1288817005.4235.11393.camel@nimitz/).

Not saying it shouldn't be fixed, but it should be a separate discussion.

> To handle the bigger picture (I raised another problematic instance in
> [4]): I don't know how to handle that without properly fixing fuse. Fuse
> folks should really invest some time to solve this problem for good.

Fixing it generically in fuse would necessarily involve bringing back
some sort of temp buffer.  The performance penalty could be minimized,
but complexity is what really hurts.

Maybe doing whack-a-mole results in less mess overall :-/

> As a big temporary kernel hack, we could add a
> AS_ANY_WAITING_UTTERLY_BROKEN and simply refuse to wait for writeback
> directly inside folio_wait_writeback() -- not arbitrarily skipping it in
> callers -- and possibly other places (readahead, not sure). That would
> restore the old behavior.

No it wouldn't, since the old code had surrogate methods for waiting
on outstanding writes, which were called on fsync, etc.

Thanks,
Miklos

