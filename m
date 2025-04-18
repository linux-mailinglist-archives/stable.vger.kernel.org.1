Return-Path: <stable+bounces-134650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481AFA93E2E
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 21:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646E57AC137
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACBF2222BB;
	Fri, 18 Apr 2025 19:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QdY/lNT7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEB22F43
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 19:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745004457; cv=none; b=FhSONNwzpoN7lGOsUWpUdN3OocFWQmanSzG7o1l2JU6Zuw6L9l7ugGC+O5+GsYSKrRnVTaVZe2VV49JwjK6ZRfp22OYt2ZAr6g7sbbXGn1/2amuEl6bFaXwk1rciWeLf2hQiL8zqRXyyvYlTSJ9Had6dUENyJjWxC0aIettyg8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745004457; c=relaxed/simple;
	bh=PXliZB9xDy/vBKgpgY3nlv+6pXp7lLwAFFvpUkQS7Es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIJBuruLjja/6UQihhwR/6sOox4tw5UQeg4cTP0qaqir/I3ecVaBkJUx9dMmPeI8v6xJ/g8b4QazJLMcm3dHprRinHbCEXeZlUrEaB2qVSMzjDYxQnLJVrgtvNf6RG0+KGNfOKJAOEiLK+aBTwGS0pazUp8BeGjWfezbpoVsgkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QdY/lNT7; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so1985762b3a.0
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 12:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1745004453; x=1745609253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXliZB9xDy/vBKgpgY3nlv+6pXp7lLwAFFvpUkQS7Es=;
        b=QdY/lNT7zclZKdg/OeKALt+1UpSEbv4Ny4/0XdAX5gaN0mewPmy36NOeYKjNeZ92KM
         BGygNAdpLH7RM32FQCKfAQZgAfoz0sjzOg+K02LpyuXNDmC/awTnrGdp2MJeE3vl5Gcm
         Mp7M0I2DRIiIVxALmvxGOMug+hrJmzJGg/Z0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745004453; x=1745609253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXliZB9xDy/vBKgpgY3nlv+6pXp7lLwAFFvpUkQS7Es=;
        b=gnKAPNNJWmfdKFGmemOyy7/stUMCjN24s2CYeJ502IO//DPjxJ4ZEIvitA13E1fia4
         BsqdQzkKYZrIJfB8Fa3TZ+ag/5HM3Jzf61MYAoqXo7FVmEaE8WV8zXKT5LVh/zEXMAha
         L5l2OCJIE50Aji0g1jnfnkuBKAK6rF3gC+Ueyfv4oWfwo+rN+wCCqS1g2I6Eu2nMKrqf
         QCL1f8vkwfYIK6fGRJer2ghNhN6f33mfbZee0GJAUNPpEQ+6tUIuxN2ybXektZhVrNjR
         cCPraeYHzhAXJbpjKL43n3y9biYkzULp9r/8s1e7TMpvqjEu5ZZUGuQDLZ7jsYH7x20W
         nJrw==
X-Forwarded-Encrypted: i=1; AJvYcCWmQYhdfOjxyw2wyWbJczGfly742N5fzBoHgIChXNB2OHFdZF7r/SW7kFKi+H8giXE5D++lSlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoAq+6sKPIbU4bf7fa9e0KcnTqhWlKmTrfctwYTe9QOfM1kzbG
	ilYeJSIRxz5VqkMFdvZyExGnzfbkkgeZ2KJuBd69qFgHQZbodOa7drnDrKULmfmJGQ3pCaseXBQ
	=
X-Gm-Gg: ASbGnct+JoHD8dn55ypL7YaG++3mb8BY8zqvNIwhATiYgumWgdFFlSG/9rAFKJ73/sv
	t9uDJztMsgRiqw2kO/grcRg9+wCTtT9Zn1Gnn4pdQ104nhDHbifQLE66XrMFxcybqi0eF8ntdN/
	XBL1sg4r5mNjquG6P+hMc2zVY4Htjel/moVhaZCW3Irm7tr7ZpZ2gv8G1HDFFy7iayokNq7ha77
	bpXqo7Y6bYVI1JfGYNMrjCz6zKsvLC31ARccmoLgyELH10oXlTYWSmnyEoXF1ZldArF3HwGNAt1
	mGLCH9FtsPuuf7TV9gP8tM113v3n1CGInhCgo/OpEEGmEytFGqlVUA9Y5xTmCZ8X0R4zsxoMOFM
	FVqu0ufoa4Y47+ng=
X-Google-Smtp-Source: AGHT+IFzCqYf5tBuWJzUjK7Cv93x82nrUokyVrXLghNk086t22iA4tJLDy9rtP6s0tg+UcM766gpeA==
X-Received: by 2002:a05:6a21:38f:b0:1f5:7366:2a01 with SMTP id adf61e73a8af0-203cbd5b6bfmr6213479637.37.1745004453107;
        Fri, 18 Apr 2025 12:27:33 -0700 (PDT)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com. [209.85.216.53])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e4725sm2019036b3a.56.2025.04.18.12.27.31
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 12:27:31 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3015001f862so1712349a91.3
        for <stable@vger.kernel.org>; Fri, 18 Apr 2025 12:27:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUsNZsX1e3NAhZ1TRdn5PA0jfSxRigWvnXF/RVdNaOFYeanGzZWJO7Jr7OWQPdmCzJDHGjOOq8=@vger.kernel.org
X-Received: by 2002:a17:90b:4ecf:b0:2ff:692b:b15 with SMTP id
 98e67ed59e1d1-3087bbca3b0mr6080668a91.33.1745004450746; Fri, 18 Apr 2025
 12:27:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143710.1686600-1-sashal@kernel.org> <20250331143710.1686600-4-sashal@kernel.org>
 <aAKD+zsLwx8pBSOE@duo.ucw.cz>
In-Reply-To: <aAKD+zsLwx8pBSOE@duo.ucw.cz>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Apr 2025 12:27:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WvoAxfipbsG1O-WXBfoPn2kEvgQk495AdMike7swgnpQ@mail.gmail.com>
X-Gm-Features: ATxdqUE0FNJ4-KqG291tKKSsSflmlD7l8xzy9IRc-kV_X-qxA7cNZEuYYXsJ3pQ
Message-ID: <CAD=FV=WvoAxfipbsG1O-WXBfoPn2kEvgQk495AdMike7swgnpQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.10 4/6] arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
To: Pavel Machek <pavel@denx.de>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org, mark.rutland@arm.com, 
	oliver.upton@linux.dev, shameerali.kolothum.thodi@huawei.com, maz@kernel.org, 
	bwicaksono@nvidia.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 18, 2025 at 9:55=E2=80=AFAM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> > From: Douglas Anderson <dianders@chromium.org>
> >
> > [ Upstream commit 401c3333bb2396aa52e4121887a6f6a6e2f040bc ]
> >
> > Add a definition for the Qualcomm Kryo 300-series Gold cores.
>
> Why are we adding unused defines to stable?

I don't really have a strong opinion, but I can see the logic at some
level. This patch definitely doesn't _hurt_ and it seems plausible
that a define like this could be used in a future errata. Having this
already in stable would mean that the future errata would just pick
cleanly without anyone having to track down the original patch.

-Doug

