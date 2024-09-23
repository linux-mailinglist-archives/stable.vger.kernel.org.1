Return-Path: <stable+bounces-76889-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F8D97E836
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 11:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5852817E2
	for <lists+stable@lfdr.de>; Mon, 23 Sep 2024 09:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4681946CC;
	Mon, 23 Sep 2024 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zTjHjh2s"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAAA28684
	for <stable@vger.kernel.org>; Mon, 23 Sep 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082534; cv=none; b=ENzICpFJ1JYippALu9CO1FfwMmu7uVKkRL0KZ5attRjry80bwww08OYgIiJ25WEGOgfhb3vycEnszzikLj2WL6bjgSalTytQvBwUIKUPYQWgCy9ep4cWVzX6ct6UpcnPd0FELotve2UCDVkGxd3gPOaQLdOtB9pfnD9MtO7CuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082534; c=relaxed/simple;
	bh=JELDF/Zw79oZ0FUIS2rLWoMNSuxFhGD3+cD8JeDI/eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lsYV0Szq+W7ZgNELfex9f2po4Uo1021J1VOlY3BsGKZ2gNMlDwqlVWi8cDjKOzlIy9LcZxQpPDJQUNNTghWUX6bxAJKTRuLIo/pggCjE4nRFG74YVWqPjFn5l+cn0k5oEr9LwSMFoKdlxpaoTY9ufWyhdhiK5Sofu1a2m2JoVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zTjHjh2s; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5365b6bd901so4575280e87.2
        for <stable@vger.kernel.org>; Mon, 23 Sep 2024 02:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727082531; x=1727687331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JELDF/Zw79oZ0FUIS2rLWoMNSuxFhGD3+cD8JeDI/eg=;
        b=zTjHjh2sMWoJu5owFEYbdlF+4UWLgteX9a/kwFOebMBVFAkyzWrdbET+h1rjkA8shv
         oydzO7mndNH1A3PvJJjPtScGFUJi/lg5FGllkwawkz5tZYhxp4crGQLOjZ1MnQVF/2+l
         a2vNArGW8Z0IISmFYUf5D67EJMvhrW7B8fPOa4OWTwX5rHdfLgI732hWcveOkl+25tj6
         VQYIgvG1vLhghsfbLmuDsuGpEZCaZ+P8Tym7K6U9WS+SO9kfKYsf/o0houN481hnA567
         wMmHlZP79Kx0IQT5yKRXshkU8sMtyeekXVdBy2rtz89TelrTwQbwfM+kKGhy9FMocUSg
         2whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727082531; x=1727687331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JELDF/Zw79oZ0FUIS2rLWoMNSuxFhGD3+cD8JeDI/eg=;
        b=gOsp8fGMOeF42Lfx9qhcX2PA5ApBRMMqobC43J4fy7WfBXt55qhu222peYGv6etsbf
         2URDQmMEky2isehGyDUeDtPRkQgT4NoY1BYPVQNFvEv+N+8QrEkhAOLyrpHhm+KLQoHA
         sm3cXe1Ue/sv6Ai8t9romyTrTtCqBrVBBbuFYhb/kCgtZXbDgrnSNM1u2JAzhhs7ld4d
         QlkOWpO/Pv7kZEDu2dtRn0YyEPOug/JGoDi3VTAne+2GQ7NVU0w2QvkfgsXQHSrWv57v
         mkU5a3TiwFn/OJ06t4JXVM2IpsPjwK3bW48G1MNSC3QPXQsHjV9bgrAmVBlf/DtVTYan
         VDhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0VFRomquUUOhoPNaUPQAxljBibVTPFDE9hLGiXCVM1HXHrF24q3NNQ1q1YPRNyChU/ky48Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZM1fjG+KyG4Qez8RfMvJH7VG0imsAo590PKFlF2k10asmMZq
	/wm4TzkLyxTOWaDUA+R+/iHTJf/Zr3Zpv4PUBBUEkqXdeB3uXdMKKZqBm5HB4OC5oDIu5Iocvme
	WVPS4wx1Vc4TsTWIc25ZAoUSEiyg1bQrmqhKoSA==
X-Google-Smtp-Source: AGHT+IHo5OqAsBLecq0W7uEgoSonYeSP+z4Hl3h5JMui3ZaIwaomJwFKc1/L2fAHd4MtYPhb8fguCO69PRbjQ+Nc6rM=
X-Received: by 2002:a05:6512:3a84:b0:536:550e:7804 with SMTP id
 2adb3069b0e04-536ad161b01mr4635287e87.18.1727082531360; Mon, 23 Sep 2024
 02:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905020917.356534-1-make24@iscas.ac.cn>
In-Reply-To: <20240905020917.356534-1-make24@iscas.ac.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 23 Sep 2024 11:08:40 +0200
Message-ID: <CACRpkdZYnwbpqSLrxaOZ-0rbbQq7XHjznnCqOx1Pk=8kPiYL9w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: check devm_kasprintf() returned value
To: Ma Ke <make24@iscas.ac.cn>
Cc: marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, maz@kernel.org, 
	joey.gouly@arm.com, stan@corellium.com, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 4:09=E2=80=AFAM Ma Ke <make24@iscas.ac.cn> wrote:

> devm_kasprintf() can return a NULL pointer on failure but this returned
> value is not checked. Fix this lack and check the returned value.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: a0f160ffcb83 ("pinctrl: add pinctrl/GPIO driver for Apple SoCs")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Good catch!

Patch applied for fixes.

Yours,
Linus Walleij

