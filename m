Return-Path: <stable+bounces-23197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3DE85E189
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E0CB25AB2
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCED80BE1;
	Wed, 21 Feb 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cZNKAyuP"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85A80629
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530044; cv=none; b=eaISjXEjhqsvW9PjJr86sBUyVy5X3sfdKGOBhNCk0ctmETD7y4vhdWuqtYBjHkD1zMRcV+Zh0f+xkO4jvaxRelZqlSfcE7wB5TVV0NY4he9OYaYqJOAqO5M7iBta0hT2Sa1B0ogxbB09nWKukJzT6EFiagEL0LXrYSa1h9pRS70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530044; c=relaxed/simple;
	bh=TJNXkizSShMtvcWSPYmsDvAjzar6qre/w0cVQV2Otns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O93DnKG0i0VNSwqt7FJF7qso95Ij679mL+5zfB3yxDpezVeHQafpOY4WZyFznLsOiqrTtMVvEv8kjz/loAN7pIHo60Hw/o+vG2sInOcYlSBSN5kd03GII+IBDuSEEM3efEZPSOGfYeyuhZ/GJ1SQRoTMD2SNeXqQK2bwehr+IzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cZNKAyuP; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-599fc25071bso4483464eaf.3
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 07:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708530042; x=1709134842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJNXkizSShMtvcWSPYmsDvAjzar6qre/w0cVQV2Otns=;
        b=cZNKAyuPFyJSHfGipdk/coNi3hyJbysX4WwZIQGRIKoIj6O0gnV4iBFJz8/SgiYX2q
         kssb8mCkh1Jk4Y67OSHshnSgrZq4KmNZQ9uCq0AKuA+UNgftX0+J4zx/R6wFniwk9w13
         lHGG2VO9VFwuiqIOOLsntY6EtinYbF8mkvBaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530042; x=1709134842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TJNXkizSShMtvcWSPYmsDvAjzar6qre/w0cVQV2Otns=;
        b=vZo9PF+NjDMgnXE4MihmoCEkHsYwYt3MHzBjPFnyK33o4DInAm5YlNXK6VyHQIv47a
         3uGqaVxQ9cSmRfRQKja86k05ITMrgTAT7CilWqMaGXDD3zYrlPsN9Udo6/Sonpsqbp49
         1aSGUk1VtAsHEipr25h8MvAJwsUvDTk5tTGNYtqiAwzBy46WPcf/tF8YQlLc3HzUiymn
         pMts9NzHcy2auss8Y1/hSrNpQB++zUp11+YweWKtFYs5Y6oJkHZyWNz/o4NA/m+gR8IO
         NAddVZELn+JZGEUdzDvMFn7wXMVWVCgcbkMw4qPAy85E7BslFdBbu0uDezazcUWooOXG
         p2zw==
X-Forwarded-Encrypted: i=1; AJvYcCUU9vj5NAU9DLLrNAk/uwTmj6knsjd/Xa/9GrVUXmPpNmqNY1CbiVAvrGsuMZBHDs1j9TXuqaHkZKAj/KSjejXuq9676LSK
X-Gm-Message-State: AOJu0YyRyE2ftYnBrZ8vJ7MeVZJPvlxRSEpWgLuZBO9nES05n8k5SJwT
	IBDdl9nkhbY77sZWFvw+Pejyn5E06m+PVNnodo2DtfuQPSv8HV4pFfo8cEiJQcPjMeRyBDJhomw
	qRwF6K0c2sHzN8NG2WGRxO2xX11b5lYlewEgG
X-Google-Smtp-Source: AGHT+IG9fiJiVZ3sgt6ThkuObMsIMuHe48ijTvcCFKf4u+aEJ+qF96oTdkX3z0ysfbLBVGafXqGjD13bjGzV2JUDNfY=
X-Received: by 2002:a4a:ea33:0:b0:59f:fe70:3281 with SMTP id
 y19-20020a4aea33000000b0059ffe703281mr5776435ood.5.1708530042119; Wed, 21 Feb
 2024 07:40:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
 <87jzn0ofdb.wl-tiwai@suse.de> <235ab5aa-90a4-4dd7-b2c6-70469605bcfb@suse.cz>
 <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com> <ea61304a-81a4-402d-9d71-b13b9ac89ed2@suse.cz>
In-Reply-To: <ea61304a-81a4-402d-9d71-b13b9ac89ed2@suse.cz>
From: Sven van Ashbrook <svenva@chromium.org>
Date: Wed, 21 Feb 2024 10:40:31 -0500
Message-ID: <CAG-rBij0di69U38JzWK+rWHOn7AoX1OOBtVUZ4TqLCfysMFsEQ@mail.gmail.com>
Subject: Re: Stall at page allocations with __GFP_RETRY_MAYFAIL (Re: [PATCH
 v1] ALSA: memalloc: Fix indefinite hang in non-iommu case)
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Karthikeyan Ramasubramanian <kramasub@chromium.org>, 
	LKML <linux-kernel@vger.kernel.org>, Brian Geffon <bgeffon@google.com>, 
	stable@vger.kernel.org, Curtis Malainey <cujomalainey@chromium.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:58=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> Thanks a lot, seems this can indeed happen even in 6.8-rc5. We're
> mishandling the case where compaction is skipped due to lack of __GFP_IO,
> which is indeed cleared in suspend/resume. I'll create a fix.

I'm really grateful for the engagement here !!

> Please don't
> hesitate to report such issues the next time, even if not fully debugged =
:)
>

Will do :)

