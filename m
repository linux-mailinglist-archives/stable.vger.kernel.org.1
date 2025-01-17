Return-Path: <stable+bounces-109368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416F8A15098
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 14:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C7F3A83CD
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF331FF618;
	Fri, 17 Jan 2025 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhJLfHwm"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D51FDE11
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737120868; cv=none; b=fjnpIsFQi79MY+6cQoFXsTqm629yFkdFF9QKLd/Ptt6yNj2DV2NtYZgnUFo1f5EIBPkYsVOMfxxOFLuiKzo2u8gvH2fUkY9CXRsaiiRrk6l2TnJQI/gRF+1aRpOwIruH43AK3F9c/Cu/gWjpyvpbyT25M9d5uJwjT2nzlK6pzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737120868; c=relaxed/simple;
	bh=xJozY5lV24/SGdMdkgL94sZFDwoBHt/7dqMj9adyiuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMWtqlL4cQ+erSOVOjciBOEWWvr79x3KlMMskDchxPYaqPe6LZ1Gnpc8ZWZry8GaUV+gBdxN2+YFiCXX3Ag5Ms2p7+5TDSNSksGmGqgW6tkq6C4GLm3BS9DKUbJitAuyodmc8R3dZdzqjvdfbvjCiQOvu4dCDP0lQOa2ThuO7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MhJLfHwm; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e4419a47887so3167902276.0
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737120865; x=1737725665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xJozY5lV24/SGdMdkgL94sZFDwoBHt/7dqMj9adyiuY=;
        b=MhJLfHwmnpMmZOF0DwokUeadZ/9VCu9vVrAiDvXkBjgpdzIfKboBpWonHdEV248Kzs
         qgedwYe9gy4qM6jjjNDhPGBGI130ytxuiP4vjvGLdIhbNLNLSBZwwI1fcbtHhMB6KQKP
         vsdGHl9/Gd2G2hUet3BNl8bV0iqBd7fqiSGsNndUO+Yu8vWayiy5eQ16wou17SvOEIRF
         jiGWTclJmojrkF38YlCib8mgzAF0uQSkVw178+LB1xmAjxYfFLBBuEvKRiBFGvkwQf9q
         XPpinlLJ+9pwBCx4KUw+uYJnA2UTIUtsLllUYNCv279GYT94X7MUh1VzWH1skw9JKOZB
         6Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737120865; x=1737725665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJozY5lV24/SGdMdkgL94sZFDwoBHt/7dqMj9adyiuY=;
        b=FG7k2fT2p2TwD4SOxgfkMCtkwBC/djss6RZ73yt8pD1pRDOKeJ/mKZxnv9WpTlme2e
         gWW6tx8eHUTTMd4aBe3TpGG8tKLwW2bwOgocVCdstqyiMFGYnoM22zokQl+cDAfhu73/
         wU7m6TjNSlJNen9IotVmKr5DxBLjMGiLQjeBRzwW+1XbPQtZs3Ic+4bC8RgGH05bR9ka
         18uM7eXX6pIhwQ5H5muY8sEX7SutPaQCHBOIEzYemnq8eC8QMMI8RVWqeNpoI9dqc23a
         8a21Z+gsiTEWzZ/R3od0pP8Kl84lE9oF5bdzaLVTMVgJi1rirlnf4FOTh5warR9olqjx
         lInQ==
X-Gm-Message-State: AOJu0YwykNbNhCGGJKew9pjtXw6LUN8c/j1Db7TY/mjLGlwnVaE8ASD5
	hJjdn4sH9fXlafOJWLX/4KZ8eVgPrVNeApmAjKej83c5wK2itamoRJQgBoSKixmSR4LWORfwX6p
	/h9xvYCaIQjqpFcsDPeoDH/kzKJmW9Ji2tt4+Yoj3nIS797SH
X-Gm-Gg: ASbGncvtMK3L+sIW3ZssWzeM49Ks4yW51tLZCGxDhBbY4lh2N4HYNWl5Uq6TA/q9YoY
	w9yU5y1oHh17B4YHbMwZs75+F19VopCRrKvS5
X-Google-Smtp-Source: AGHT+IEOgjG0GD+SDOj1DNPqpS8uC9bE+PoZo6UOgv6b3+TZN9jWMuw/JC+eqe1YneXO6eIcXrkwnsJ7CECF/c9GLoc=
X-Received: by 2002:a05:690c:7091:b0:6ef:8177:c322 with SMTP id
 00721157ae682-6f6eb67caa9mr17298037b3.13.1737120865247; Fri, 17 Jan 2025
 05:34:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABeuJB2PdWVaP_8EUe34CJwoVRLuU8tMi6kVkWok5EAxwpiEHw@mail.gmail.com>
 <2025011740-driller-rendering-e85d@gregkh>
In-Reply-To: <2025011740-driller-rendering-e85d@gregkh>
From: Terry Tritton <terry.tritton@linaro.org>
Date: Fri, 17 Jan 2025 13:34:14 +0000
X-Gm-Features: AbW1kvaRju37P1mCxFjLann-rhiNTKCMKJGDpkpddV49FDmaUzR9bGVE_90KW94
Message-ID: <CABeuJB3xEQfgx1TiKyxREQjTJ6jh=xt=N7bTQoKgjAN1Xoa5WA@mail.gmail.com>
Subject: Re: [REGRESSION] Cuttlefish boot issue on lts branches
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>, 
	Sasha Levin <sashal@kernel.org>, Daniel Verkamp <dverkamp@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Thanks Greg,
whats the best way to do that?
Do you need a patch for each lts branch affected or just one based on stable?

