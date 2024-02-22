Return-Path: <stable+bounces-23362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E03385FE4F
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 17:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA732875B5
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 16:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FD98C0B;
	Thu, 22 Feb 2024 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iaKY3TNQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2E31509AF
	for <stable@vger.kernel.org>; Thu, 22 Feb 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620232; cv=none; b=Hno0hQwZx0w6bVSHsEuTdAHa96+GewjzqJ6pwG1PTk5H9/015GZyyN8+xtPITe6/YvjzeeJd97WY+PVMHQEL7CjfqZG7M8Hyg+eQWgmD+FwLvkn7/YYjlyithDPLRE0YPHlwnNHHw+hPi6TqogCN8hnw89/o5pIie3FSYeo8aLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620232; c=relaxed/simple;
	bh=blGXCQWbinQD12tf5lew+OFO7kdmX5WYe1FXNjbh2d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0PY+WiSpGXuKDF/WZdSfu9L2KHPQcarRQvsVw729M/HotkjL2Fk7feurAGeCAEtnRg/LFBxRQLfS+TOj8LzRDqGZPemCzPRg4v7DEeqC6NnEcdcj2+w/D6kex0KFWfMREsUW6uCy+1dO/MTEHdwiDM/eSa5JW3uuK/dYdhK7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iaKY3TNQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4129017c942so211135e9.2
        for <stable@vger.kernel.org>; Thu, 22 Feb 2024 08:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708620229; x=1709225029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blGXCQWbinQD12tf5lew+OFO7kdmX5WYe1FXNjbh2d4=;
        b=iaKY3TNQAt1pe8rPYA6dM2vsv1TiNG446InpPbybZoeIcG/pSCkv9mVqN5A6MjViMP
         UDcZLj5NvHhziGP+ZP0sVljWuEFYRF2st4B2JdxEO8VYj9eEOundVpvPkMmiwPWxfkaC
         b9NbfuhE34bl3fu0zpuz3nOrNQbb3qjdOErU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620229; x=1709225029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blGXCQWbinQD12tf5lew+OFO7kdmX5WYe1FXNjbh2d4=;
        b=PqavuDYmI5KwdUMiiqoGki8EQ3TUj/WhW2a/hVA3f1CaQen5uONX3n61b49DLY69wA
         r3xTd6zma6t5dgEGlwlo5GeS2yJ+OlNYCjxYih3UqnCb52xR2YPhmwxeXjP3bmGbwRKb
         4mWS+dULIPY6bi7w7KMmNiO76ZSjYB7e21CFN8lSXVj3bM0xpmzzfrD/yaf0NPURiixb
         8q0FYwrHB3fAd/JqI7020/SvPHfY+g7c1yyv04l0w0WYf6lljvFBtbRsh4x8h1r9WXba
         E+W2zn7CaIFnodj3KauhfhMB5r/Avw3X1h8Mn1GqQq1VEnRcSFYvWh3vcaY3e0nYS9Ux
         BKhw==
X-Forwarded-Encrypted: i=1; AJvYcCXuNt6Klu1eEkpJn2Hybho/KNwe2dgEGtdgllep27QRtsHIzxAcoz4COhkeBtGPfe2hUQ6xV9F2zfimvZdnMq+xjCQJ2Iau
X-Gm-Message-State: AOJu0YyaosAW04gNnWQRaQNLS5l4nOYKFhyQWrUdQM14b9+wBCnSpSOq
	ZPGtQKd7/hICcdShao/pJxTyaBIesG1CqMlNfIXPrRHTaor1RmAQODvaooR6l1tCzTCe31CJevb
	zVNaqFKwiIKOj6V/v05FjMGX/dB/y+ev7dDvj
X-Google-Smtp-Source: AGHT+IHPeFbJSDEot8fEBJUOQpHH3P+T2gkvI8J+VDy41RkRYDYg/pUrSO1BaeS0Z3eGGdJvHPDd7UZsn6op8oO0QU4=
X-Received: by 2002:a05:600c:1391:b0:410:e41a:fc0d with SMTP id
 u17-20020a05600c139100b00410e41afc0dmr16692583wmf.24.1708620229216; Thu, 22
 Feb 2024 08:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
 <20240221114357.13655-2-vbabka@suse.cz> <CAG-rBihOr+aAZhO4D2VBwSx-EGg_gbgBYKN3fSBTPKCXdz9AqA@mail.gmail.com>
In-Reply-To: <CAG-rBihOr+aAZhO4D2VBwSx-EGg_gbgBYKN3fSBTPKCXdz9AqA@mail.gmail.com>
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Date: Thu, 22 Feb 2024 09:43:38 -0700
Message-ID: <CAJZwx_nLcMjV+4vShx9LqCOVo26Bk_gDPXP6PiTp2UXdQAh2Zg@mail.gmail.com>
Subject: Re: [PATCH] mm, vmscan: prevent infinite loop for costly GFP_NOIO |
 __GFP_RETRY_MAYFAIL allocations
To: Sven van Ashbrook <svenva@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com, 
	cujomalainey@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-sound@vger.kernel.org, perex@perex.cz, stable@vger.kernel.org, 
	tiwai@suse.com, tiwai@suse.de, Michal Hocko <mhocko@kernel.org>, 
	Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With this patch, the test results have been promising so far. After 10
hours of stress testing, we have not hit the reported problem yet. We
will keep testing and report here if we hit the problem again. Thanks
for engaging with us.

On Wed, Feb 21, 2024 at 8:53=E2=80=AFAM Sven van Ashbrook <svenva@chromium.=
org> wrote:
>
> Thanks so much ! We will stress test this on our side.
>
> We do this by exhausting memory and triggering many suspend/resume
> cycles. This reliably reproduces the problem (before this patch).
>
> Of course, as we all know, absence of evidence (no more stalls in stress =
tests)
> does not equal evidence of absence (stalls are gone in all code paths).

