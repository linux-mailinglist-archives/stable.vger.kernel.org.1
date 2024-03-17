Return-Path: <stable+bounces-28319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2682087E00C
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 21:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5899281638
	for <lists+stable@lfdr.de>; Sun, 17 Mar 2024 20:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883F91EB2D;
	Sun, 17 Mar 2024 20:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOaHryKO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C8A1BC4F
	for <stable@vger.kernel.org>; Sun, 17 Mar 2024 20:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710708949; cv=none; b=aksEfzrZMAJwXpP4scLTWTjmpiITxZXE8Ns5jTx8KMaEHIshUuCRe2yhnZEuxK2gmCFO3Re7NH7R/MlXvRiXp4M3xvNu70qPbq4JCrzE25aznMZsSpaIUQ2sEr5AcUSwQQ4XwqggdZYDryv7/kfj5TAFAGFL788m7p66qhgAG9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710708949; c=relaxed/simple;
	bh=1AfHrDsSNbMUkjzV2ygJfYJ3cd/4tLvxYlwr6T9+3ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUY4eHH4qbTdkIzUYEZwtgfyoo3hydPXCMbWff8CyMQ/iZpWn6Mkvs3n1PuOL+Wpf2iRKMBeGW0ofBeYQWoX+6eKdOHnsAmGuWpFpHil77HRkwLnVkdSj/tnp3lxIAvT3cOu5dhbJqg2Nr6wppeUDPrAYDR2hXWeMvp9RJQT3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOaHryKO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41410a86d5cso1456385e9.0
        for <stable@vger.kernel.org>; Sun, 17 Mar 2024 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710708946; x=1711313746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1AfHrDsSNbMUkjzV2ygJfYJ3cd/4tLvxYlwr6T9+3ro=;
        b=dOaHryKOVQikBvdTQcdmBKUTgy3jGIZ9ti6mbpx4xcHqO+fAQu7+qoMl0dl4cDMA0t
         PvVEqnm/c3ZE2P2dat+etfmnP1ddro6PpOZ+tP2q2jt09SXjnwk5gQcrnj2MbDyRhCQe
         hPdjoy370Ae/Je5UPY3WU/K9UWLsvntxR0ZR8kEBMO/fI1fsv4z5utYQF1NEWzIbayti
         hXwo3yq68TQbIkvdb9Q7PCEdYgR8a/11KaS/zIPf5tIDYs1MOKCFhlSXfZ3vd7Xqkpc1
         DJG6AOOWGdaelIlAjybTQKkiNLsBNPCZHgZyGHTbvIV1uslzPYMpxiOG2hRurH9iX34c
         VNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710708946; x=1711313746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1AfHrDsSNbMUkjzV2ygJfYJ3cd/4tLvxYlwr6T9+3ro=;
        b=m3/Vk0yx7VQr0e2MaO5BSDu/GK02oRz9nyO41G1VJPFq64eytvDvrYTkEp/ndY867b
         LwW3ZBAiH45ZxVwBDql5OMfwzzXIE3ndqoeoe0CJV2t9n20L2m0RdyxXsqwDSQWtwL4Y
         yGx8ACXV78fjQPIkI04GbLMcQSlF41Wb9feJFXeAKoNVz/Nh5jdb/6XeiXTkQrdh6TYJ
         c3IhdmxQ7j8f2otXGiWcTM433nd8eYL1w1wdCkQo6DdyrZer00jwPrzVlcc9JSp45tzd
         BG981eYwQ33PANXSC8Xb+yDKf8J0cCtAAlyHsrV8TrvO76IVlgLecg74/GmllbR+t2Zx
         TQBg==
X-Gm-Message-State: AOJu0YyDVLa1L5taEBiPtmHdSN0KV+AxoHPMUWuEkUOjBDyM4D9HfakZ
	lEVlMeoPDxjkzh4DO21tfhnJri8gNNYzdHQpzzYI7aet7Aqf0IOCdvyqfkqS5/TAinX2N7IcUy9
	3KApRqiNMR84Yj0dLgVHkqZu3yT47eGvC9SWm
X-Google-Smtp-Source: AGHT+IEy6nQmDsV06xbSjuZPGAmigDacaSPSSZkoxFTRFiJjy7unRlc9A4cTyG7Y7GIWsTJlAYp1+UdrRhIuqaCtz9A=
X-Received: by 2002:a05:600c:1989:b0:413:ef97:45e5 with SMTP id
 t9-20020a05600c198900b00413ef9745e5mr7947365wmq.21.1710708945812; Sun, 17 Mar
 2024 13:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317010651.978346-1-alex.vinarskis@gmail.com>
 <20240317010651.978346-2-alex.vinarskis@gmail.com> <2024031728-stainless-showroom-1e79@gregkh>
In-Reply-To: <2024031728-stainless-showroom-1e79@gregkh>
From: alex vinarskis <alex.vinarskis@gmail.com>
Date: Sun, 17 Mar 2024 21:55:34 +0100
Message-ID: <CAMcHhXrHB-+1NTmSdXMz9DGMwyJbrOekcdW-LAhWgXETUvWTSg@mail.gmail.com>
Subject: Re: [PATCH v0 1/2] mfd: intel-lpss: Switch to generalized quirk table
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 17 Mar 2024 at 20:06, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Mar 17, 2024 at 02:06:50AM +0100, Aleksandrs Vinarskis wrote:
> > Introduce generic quirk table, and port existing walkaround for select
> > Microsoft devices to it. This is a preparation for
> > QUIRK_CLOCK_DIVIDER_UNITY.
> >
> > Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
> > ---
>
> What is the git commit id of this and patch 2/2?

Apologies,
patch 1/2:
commit ac9538f6007e1c80f1b8a62db7ecc391b4d78ae5 upstream.

patch 2/2:
commit 1d8c51ed2ddcc4161e6496cf14fcd83921c50ec8 upstream.

