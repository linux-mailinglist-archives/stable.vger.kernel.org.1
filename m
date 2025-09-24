Return-Path: <stable+bounces-181634-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A15B9BD46
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 22:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 174B638086A
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 20:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922A0328562;
	Wed, 24 Sep 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TdtAsioL"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C8C30BF55
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758745052; cv=none; b=fSQVPupdmRwPXh1+ynq8K42SNpDLepHXJfXJ6/h6KAe8qNK65NB871lz7atJXBV+PZZoYQGxVCcX+Myzek/mUQo0oy1X0Hq7iYDcx2YIgq39ygfe5ueGMs4VpGqV00qOceUWCAdLRuyTrhF7aD2gt2wliP6D4RxNsV2dQZYt/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758745052; c=relaxed/simple;
	bh=11LSxohVQLtgYPqV705IwGyhWZ5zTC5qes4PC/XU5NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dktzVDxqoyiQUEwwhoABibJa3cZwYD0cXJwWwBIJsHNVwQl8MszYycdRLnv6Q/ZLvR/ntlFZ54ySggmlR4kZpUubzjk8HFSrOF7lO75SjLRePswPj4kvEe1c35qNwEaBWA4h0Iizy53ktbLnaqEGlSS4PujvZ2iDJg3EBmWtYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TdtAsioL; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b07e3a77b72so225313866b.0
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 13:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758745048; x=1759349848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KxL1IkdhPFqi7CXmsjucqEYlGYsVkwBpOGWKm6mx5yk=;
        b=TdtAsioLFIvvZ4aD55iuZbLfLlQZ6W4tQTsSymUPQM4a8e5z9/LCH3w6UmgjE87dL/
         7TVp+wsHsEf72FTTaQY699p2GGlsyZWXbUjGVEIJy7wnREtnDnyWor9BNLdfIr5cwWZE
         1DfNfOIKzbER8eiWaRJpg9l9kAtb7/rcVvXms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758745048; x=1759349848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxL1IkdhPFqi7CXmsjucqEYlGYsVkwBpOGWKm6mx5yk=;
        b=wy3Iohg/SqeRL3CkKyXMNhsGnqOVtab/7nCGvPU5BTnPJd64cap0j6V+/LGVbTo1xD
         gjgHZ3crU/hdzqxeXhBQXjwL+AVUl5fb5iDZCzJMMVahE9cNnQnlaVgeFCB/OHSTOqBk
         LhKqTsoGd0BFPYCcv7lijkDfyCxYWl22rczCqn/AUOf804cT5TKDmMgqyIodaFV1Op7I
         wpLjFE+1whRgfsR7AfkqCS+dyo+RAHtkGzJOq6p9bXpQkfvn8YGyaS5VlC7UmI00xnWB
         sLVfNEEpx/ubYCSjd6Jl/SEPEpAW0qb4a4uZlnJf5nLxx2VylnXc/vVn8Yilqi+MGD9N
         tbWg==
X-Forwarded-Encrypted: i=1; AJvYcCXrUGmRZ2vT/KlWOx1Lm2eGtlHwJ0dtGCgi/s+eAFF1bY6aEXuBq/Zqk0q5L5qrJbdsRbJ1s/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWyeQADwEmtOaVbH5DgWgZFhRNRwUv7vWCWgOXDTt52IVy43P
	J5IErJ+gbwwPVdtD6gzkUhiTubtKH/NlcZiQmfVdhkekDlb8xSrvaGV8/Pv29xLEZHVvwrpkkrX
	XGvyb2Wg=
X-Gm-Gg: ASbGncvunZlHGLR6ml/8Zzagp1PwHvzHOUfPii3D48wa1Z+TFW361LBcgn7WB3sk6Nj
	9LqpawNg5OsRHMqSkpCyyYBruWnsXlEfW4iFbJinstCJviPN8DpX4LiCjKnFs3MJFYyX4h8+LdN
	c/xJWXUnC0uChqa/3RzjKc3nkWowfleWi+J8fnumjjOs7PuhWgPkf8LAc2+lpsaHWljzl9fUSug
	ZFZ8WcME05XPyP/SMUkch0p1xd82aHLYmP4+MWDfW9x2IqisxyYIAcpC0Hpq8RGE6Vimq1K7Rda
	JI3NCGNLpfDDVDUKSRZeDLcM93oYoHXBdnHUq/qTlu7hHQ02BkqxZYmRQQYt3PIqsTQsAFyULg+
	2X4q7vg1S+uViDEJDrLgZ9gu0VGqq154UdVJ2Tjfu1QA0LublDb3Td+olwC24i9XRlXudGtft
X-Google-Smtp-Source: AGHT+IEHqoW5EKOE1TBlCnBWnb5ujsKZ4P+bdgU4sDBuWF3wMPEryJenJKdJHLOqQqByvS3uV1cAzA==
X-Received: by 2002:a17:907:7e8e:b0:b07:d815:296a with SMTP id a640c23a62f3a-b354ae9a113mr13562566b.12.1758745048341;
        Wed, 24 Sep 2025 13:17:28 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3545c851f3sm7556166b.109.2025.09.24.13.17.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 13:17:27 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3331adeadbso159324966b.1
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 13:17:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVtN94rPTzhf+MjOLR81qsAQVADQaQYqw09qy8ymKHuXnjGhpfRyf52jQEs3sA6YyOpjiFtGxg=@vger.kernel.org
X-Received: by 2002:a17:907:7e8e:b0:b07:d815:296a with SMTP id
 a640c23a62f3a-b354ae9a113mr13555466b.12.1758745046911; Wed, 24 Sep 2025
 13:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924192641.850903-1-ebiggers@kernel.org> <CAHk-=wieFY6__aPLEz_2mv-GG6-Utw9NQOLDzi4TF93xFAnCoQ@mail.gmail.com>
 <20250924201347.GA4511@quark>
In-Reply-To: <20250924201347.GA4511@quark>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Sep 2025 13:17:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjk5rMWnVt6K_3BSQ=_uEKNaYBs=FZH_fMLKqp9E4G8kg@mail.gmail.com>
X-Gm-Features: AS18NWB-TOLqbEIGYHOdjx4mWxKWbwYfZ2s88AY8lnF0tIKXxGgu95ZpuJakE_Y
Message-ID: <CAHk-=wjk5rMWnVt6K_3BSQ=_uEKNaYBs=FZH_fMLKqp9E4G8kg@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 13:13, Eric Biggers <ebiggers@kernel.org> wrote:
>
> I do think the idea of trying to re-pack the structure as part of a bug
> fix is a bit misguided, though.

Well, now it's done, so let's not change it even *more*, when a
one-liner should fix it.

I do agree that clearly the original fix was clearly buggy, but unless
it's reverted entirely I'd rather go for "minimal one-liner fix on top
of buggy fix", particularly since the end result is then better...

             Linus

