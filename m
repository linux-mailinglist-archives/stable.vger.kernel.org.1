Return-Path: <stable+bounces-15493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69625838B27
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 10:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E91AB21141
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A939E5C5FA;
	Tue, 23 Jan 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKWG7d2A"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41F5C8E2
	for <stable@vger.kernel.org>; Tue, 23 Jan 2024 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003825; cv=none; b=pLJ1dQwwVzSsWzq1EpOXZ8b11tZaBw3yScx9LzT4xLZDL4/AvTHNfcIoJBZa74yqyPDOIV7sUTAGSA/XwXt2dFDTYOfouIkLmQ/FXez8VvgrWQBmmD93GDD76Qn/HdLlvKp1nRPtO2jtGx4S0H5JHxonOu+wTYqwI9elokDXCIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003825; c=relaxed/simple;
	bh=2a4zx/E4HXHMQCrFRTMcQxxbfLKxlGBDrsmWNtMNU34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0rb1fDoKne9MJ3J/mbJ7HoXjp7dahG0Pc0JU6n3F2psmPXYMepfqCY9Q3xgNaSaJOFH/9f3l+OWjFdvu6HU+6Kp1jJaGJzI6V7RmqUx6eiy/QUAl9kWBdRJXmevD4sbNbJUZqiqcRn8oM2EJdrrarJ7Li75z24OsWnMEYao+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKWG7d2A; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5ff7ec8772dso33577497b3.0
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 01:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706003821; x=1706608621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx8VNoB5xNb50VoOTbN0kgG1Wr33n3CjaRFmMnrWwK8=;
        b=aKWG7d2AAtAQ3IS0zLB5rK9qODcfiag9L6TgtMpkg/j/BhWyG6sLfyJIquJO/DVN0l
         3XQbp0HabPnTiasRZiSaQW7H3f9TPalsgpO1OQnttq5U4lvVZ0fYw03O+acvhYrBGWAw
         2lMdP4ytAYyIpGYiZBtnQrZ2VZZlHXU6a3aGMv9/fS3gMhst7x2BSL3v8ILIMTRGooDy
         Mwd1R9vyAs5wjJ4LHW5o/SsIKHImhOD3H97C+ZvwddfT8lPajLrYWU6P0GSHIUBpGUq4
         51bqUc0y26QmPU93WvA0CkAjQi1/KvkOaL4DL5yMImiHZKewVqFZ5iXpbIGK5LUaHhnB
         F7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003821; x=1706608621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dx8VNoB5xNb50VoOTbN0kgG1Wr33n3CjaRFmMnrWwK8=;
        b=Jqzejb9jfZfBupckJfbLjBpDJrM8uO+I9F7yEqJ/ze+1/w/2PQ1h98eMgAey1fZqLi
         M7pdoTip+vf47oy5v2BTgGAtIeD9xAVyqSQ0zzm7qHK3+enRFaHQ4NcTInYsnSP0egcZ
         octg5PvCe+zaKBPaXQ7lCx1lupAlskscMQ4Ulv1vpMOyd44WertIJ9Dg2gLCX+X4Sijd
         pHoz0lqtfPrzTnom5zXts+BzwTMr19uS8Wxh+U1fEGqelRciDmnIcw6RxWPpaqEdcy7K
         XOlwVVxaurj6nKqquUR3HCu91yc2WGTZk/x/naEpA74gDIhkWiZ18PzP1/kl99JGRpH9
         DdZg==
X-Gm-Message-State: AOJu0YyX0AsEmOOrnebzDqqb1yd8CdjDgb5Mv3+ILCGB5hx9KDra1GJo
	lhd9LLF1AVl6vdQqqV1L0fp2YmwbcChy3yNGHfBzKFAZVR1YupEFEaFFaX6ngjcYmDH7nqKXxo5
	xemEplq64cnhjK2vD4yNHnrqgXASctvTusSGZWQ==
X-Google-Smtp-Source: AGHT+IE+Y1hSMZGHVELT5QGI6zTMJ5w8f3ijh0TFj72VdyzH5fdSw5hkSKV2Fl3eI9tm1tzHr+S15Vy8GashmMFemPE=
X-Received: by 2002:a81:4809:0:b0:5ff:a40c:5fc1 with SMTP id
 v9-20020a814809000000b005ffa40c5fc1mr4105759ywa.54.1706003821481; Tue, 23 Jan
 2024 01:57:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235812.238724226@linuxfoundation.org> <20240122235822.085816226@linuxfoundation.org>
In-Reply-To: <20240122235822.085816226@linuxfoundation.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 23 Jan 2024 10:56:50 +0100
Message-ID: <CACMJSevr71oSy-CjUKkyXa4ur=mQL3R+PBnJUWQB-Pw3yp+kgA@mail.gmail.com>
Subject: Re: [PATCH 6.6 328/583] gpiolib: provide gpio_device_find()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Linus Walleij <linus.walleij@linaro.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 03:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.6-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> [ Upstream commit cfe102f63308c8c8e01199a682868a64b83f653e ]
>
> gpiochip_find() is wrong and its kernel doc is misleading as the
> function doesn't return a reference to the gpio_chip but just a raw
> pointer. The chip itself is not guaranteed to stay alive, in fact it can
> be deleted at any point. Also: other than GPIO drivers themselves,
> nobody else has any business accessing gpio_chip structs.
>
> Provide a new gpio_device_find() function that returns a real reference
> to the opaque gpio_device structure that is guaranteed to stay alive for
> as long as there are active users of it.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Stable-dep-of: 48e1b4d369cf ("gpiolib: remove the GPIO device from the list when it's unregistered")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---

Greg,

I think there's something not quite right with the system for picking
up patches into stable lately. This is the third email where I'm
stopping Sasha or you from picking up changes that are clearly new
features and not fixes suitable for backporting.

Providing a new, improved function to replace an old interface should
not be considered for stable branches IMO. Please drop it.

Bartosz

