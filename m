Return-Path: <stable+bounces-181658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1808B9C4B5
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 23:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 487667A522A
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 21:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778DE2882B4;
	Wed, 24 Sep 2025 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gpvaMTzE"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A32030A
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758750296; cv=none; b=F4yCEoF2g/2TOexDtBxfbsFFsViy+66w4iss4KDsWXVgFGmUEX5FJh13hkE6yUf5Jy1NXG1K2MD0siIbw5277dYzjvcVGuxphXtW+wQRvuChaUR8p3AN1gysiYRaVQgHyPhsIUZbR17BJ/YA0WFfjzY0ZlsWhCjyL3uZovgZzQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758750296; c=relaxed/simple;
	bh=PzqRSymdVzt1Og9H2m/pVZgy34E6YLnOoomg2VWITJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1s5YlWYqNErlCm/+fDQrHF/PN3HmziaAoFP2km90QPf1L02s8pZjTjLUyuEoddYMql47VMrxFeqI53J53TO3vOZC0QB5h7SDsc1wllIPXMrmFq15WHK1eUEM1XOHbc3UEeclBWhd2ugVoLZsvOIv0nnslPHk/skpUvrARnBhWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gpvaMTzE; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-62fa0653cd1so405076a12.0
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758750292; x=1759355092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=38X5IFenUzwUhQGVC0bd120a5LFhgoZi9a0z5DrCvfg=;
        b=gpvaMTzECxo9tYItWL8VaHkOTQFEmuAjhUKojozeoWFDAle4CMUllQvEAoPiMS0JWP
         qc1Gqd6SgJqN239aGs5b8AJDnDrd5AS1L07XWQZk52Z3ZpoqOdg/+bhWj9yfwM+Al+ZX
         6PU6Ksh6AIL0jEMJkCGgOafJr0+fSZJ4Z+toc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758750292; x=1759355092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=38X5IFenUzwUhQGVC0bd120a5LFhgoZi9a0z5DrCvfg=;
        b=XhMed/e55Pbp3FxTRnW3WT8brSO9nVTV6Ml0JwcXe6B3yTWQURjxSJHs7+w3oMuuUB
         jCWpA7PcuWoEQnH7hAFiK4WlXDg03lWnFIk5/yCDCtJlN/FNQY6JivXpVBUzFGfOUrho
         G+sl6nR9WVKv/RmrTHdUNhW9+e1mC4uFd55Z4C5/2kYlkHrfn+xMawRSPz1TjkC91fRL
         wdj50RQLmgAqqBk7RWR5z7uwm9EEO5YMijvwzvaQRgPSSmMRUwtFYqs+LgRO5IayjFJo
         w2lPVLAvTYs9ksLEQaIkFzbLnCnSH9ZIDj17pkzKq+7uyu2NXQer14VIAnT6wV7sPF1U
         B7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCUehVDgjDL2IK7xFhh3gHI4w24d31EaJBdKhq3KJwkIly+HYK/36GcsGAVb/UOu8qQ7pfkii3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJ42/5sFMYxjyzdNYRfeYpQtDtkIfnBZlGy5YxfBpHeXdlL94
	LCEE9mjRq6o+bESdswal7OUM6oUECW9uuG6MVFa3If2K5lxxVsWOsirFt9xpGnOikIZLMv1+7AS
	vsffB79I=
X-Gm-Gg: ASbGncuepRZsbZ1plLaIcLkbJm/VIVc5KZZYM7bp9cEcpvMrdKMOdIs0XGBoq7o21BM
	iYkk/Yua3Ev92c/U4llBqXQsgZWLfJPLT+MPWWGals7D9HkaNmdEOktfU0BfSb5KfnLMjxiuWgD
	i1UuOIvVFeL2O4iWdXQu7IkL7kXPTJ7ExeuK269nymkI1mbcIDvFRs3rhdhQDkhX6W1uy5EWKuV
	3RV+Cd0kbUUigsjveyIuxb4MJ3h6ygfRCx6kZIfWq6ko2UZ8j8zGTwNjvn2kwinvfkn5rezR0yD
	4GXAIYtQFfDeZGO8RYzfRNClfPmFdtHYwHmK/fsK357EsUvvxNVuZzzK/KyleS0mvdnCbdIrTpL
	/uyKQxqgnMGyFeVSq+Oly9mJIS0bT/vVJ4jDPaGC3dxS7ynrPUfq3Q2BnZHFJYIWHv0sMu10Obv
	XBKKK+Iug=
X-Google-Smtp-Source: AGHT+IEPI6fCsJlevr4i5A5nAVhFTuCVJJUN9dOeYSUn8XLE+aoV6OC80Z+vK8IgDPI2wYBOSUQOLg==
X-Received: by 2002:a17:906:7949:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b34b7209d91mr108179966b.9.1758750292273;
        Wed, 24 Sep 2025 14:44:52 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d2eb6sm23123566b.13.2025.09.24.14.44.51
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 14:44:51 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so503598a12.2
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 14:44:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUD9T2uhdEew/EQRerS9PHeRoMHwnWnky5JkB8P+b8+MazoVfpb/tu65u3cAP2qN8HYZRxJU4Y=@vger.kernel.org
X-Received: by 2002:a17:907:3d9e:b0:b2d:830a:8c17 with SMTP id
 a640c23a62f3a-b34bd068ecdmr129037066b.56.1758750290992; Wed, 24 Sep 2025
 14:44:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924201822.9138-1-ebiggers@kernel.org>
In-Reply-To: <20250924201822.9138-1-ebiggers@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Sep 2025 14:44:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivFdqXAytf0Hv4GQ9FgD1hGBMutrrbicgSZirX5qYR_A@mail.gmail.com>
X-Gm-Features: AS18NWBx1VupiFgf0uY-dl7iFrU4oMoZkrOXQfLP0z514sSYRpKr3DVixUA0aJI
Message-ID: <CAHk-=wivFdqXAytf0Hv4GQ9FgD1hGBMutrrbicgSZirX5qYR_A@mail.gmail.com>
Subject: Re: [PATCH v2] crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 13:19, Eric Biggers <ebiggers@kernel.org> wrote:
>
> Fix this by restoring the bool type.

Applied directly since the end is nigh.

          Linus

