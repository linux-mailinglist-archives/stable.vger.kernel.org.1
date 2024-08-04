Return-Path: <stable+bounces-65343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA7D946DB6
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 11:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E441F21333
	for <lists+stable@lfdr.de>; Sun,  4 Aug 2024 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68381F94A;
	Sun,  4 Aug 2024 09:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yi2MryGf"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F041BC40
	for <stable@vger.kernel.org>; Sun,  4 Aug 2024 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722762060; cv=none; b=uW0MAYSYZcEPBPWxCfruV7Yz+ReU8mYFtJBUw/Ty/5X8KwSBXtPs4DBlLG/OURh4fFdqEgtVGn4AKzI4GkeB74evwPnvFVtvi4bdXnhz4uy7rxIfh287wPUetZvDMoiKajfsxmAanaq7hHSX40E5reHDPIp6HpJJq3YTGB2/I4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722762060; c=relaxed/simple;
	bh=6douQ4r2VxBlUL7tGaGwEWLLUW2L8btVaNP1WvxxqPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlmMfAdiubFyIV8J4gKUJ+RKcUqZtOlRFfOhX3nxYX+4JUc2TxbyAuRL3s3cL9L1GhRaAPhNaA+7kevtA5h0sb/TsiFxDZy5CXBh+EOIh6HswnJ/MvVP/Hy0qJamggz/Fy0TOKacVFmxafDbDRIdzj9O84CrFmbCyR01BFmvuf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yi2MryGf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5b9fe5ea355so3713a12.0
        for <stable@vger.kernel.org>; Sun, 04 Aug 2024 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722762057; x=1723366857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6douQ4r2VxBlUL7tGaGwEWLLUW2L8btVaNP1WvxxqPc=;
        b=yi2MryGfRfL5+OaS3j0+ZbkZ2XfT1kiRtxk+Cm+UG7NwQHmPOeftQtD8QNoxrqapYv
         SzwrQR/TJHgn+gFVZSqz7o9N8vD1JWmMNCli7O8I8npxQc0uKf4FhtZnM9uhGZ3x8kgz
         /vruJykneqHkCs/HL7J8pom5mix3YZ56zaG/BSmvFmn6K4YnxzFGC8EREeConDh3AO0I
         LazwDIhDtS/wDpksIlJECXePQgB2qAbRg1CtsCG4b4dBn6QDelmPPzam45gUl4o++J3W
         B9RrQhAYa3r6Sjzv07WX71ENOGqk4cufYcvWw3HeBfYlgX1txvo10/nhJahzFO+tAg+Z
         t+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722762057; x=1723366857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6douQ4r2VxBlUL7tGaGwEWLLUW2L8btVaNP1WvxxqPc=;
        b=qa+UbZZ0jiCrNZ72Hw64W5YnyjcJHL527tXi62u0UHcoK8/hGeTGHskm6bCalaSA64
         kB25jBHP9+1cnWOEmC9Qt/5YZSr4Ef5YTAgkjjk2A7XW7ovlU/yTbfzENBUmnmpTLf+F
         b+JjNz06TvB+jUvCJOpg0MF7MsfphI5Wo8ZnqVsIfV0urMqw7JGH5r9oh3v1QgeRjxwJ
         NwuhTMdFerwdm7wLamb/jKHy8S9QYmQ9VrOysqpViIBaX4trFNkhV7moFcyqtq45omRe
         849gHUG1rG+ndgWNJ88mBNwa5rZR/eutZQS28gNqfBbbb4/VQgEQw08IBlXRbTF/FA77
         Bc/g==
X-Forwarded-Encrypted: i=1; AJvYcCUZNc1j+hpRasqMT8XMculgUpxdSD6nIKgSm00RBCt5Of2RFlgpzGNG/WIxhlMiXPlkHmrFVGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYxiKDmdRvXalk42PMCoedrgNGRth5FmKQ/MPFj6uFUMylvm+E
	JKx/uhUT0zCCJ/kQK5zlDpdxpKsDaRnrE9EcJpohm5JGzw5+AonAvI/hDfPOfMFMdcFynV8ujxw
	PgqXXaX5ZXssmgMRuljn3h5hVAEllgbTKbYJl
X-Google-Smtp-Source: AGHT+IHsOaLbEQDa/SLhfvl6vLUewKN8IIB9s8eNAiEJa6lQ5kE9/RutK1KXfjzWrUXk4vVOzUic+NxyV5tQ3pnhzzE=
X-Received: by 2002:a05:6402:2816:b0:58b:b1a0:4a2d with SMTP id
 4fb4d7f45d1cf-5b9c7adc509mr156359a12.1.1722762056858; Sun, 04 Aug 2024
 02:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726122814.729082-1-kyletso@google.com> <CAGZ6i=165A5k59MKqZxH4DvB8XNsZJ+26_0SuMZ+hidam2qRLA@mail.gmail.com>
In-Reply-To: <CAGZ6i=165A5k59MKqZxH4DvB8XNsZJ+26_0SuMZ+hidam2qRLA@mail.gmail.com>
From: Kyle Tso <kyletso@google.com>
Date: Sun, 4 Aug 2024 17:00:40 +0800
Message-ID: <CAGZ6i=0shz-2cW6BD-MUm4jEz9hXCM9ZsP5kwD9bS52PZgmYdQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: Runtime get and put usb power_supply handle
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, raychi@google.com
Cc: badhri@google.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	royluo@google.com, bvanassche@acm.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 3:55=E2=80=AFPM Kyle Tso <kyletso@google.com> wrote:
>
> On Fri, Jul 26, 2024 at 8:28=E2=80=AFPM Kyle Tso <kyletso@google.com> wro=
te:
> >
> > It is possible that the usb power_supply is registered after the probe
> > of dwc3. In this case, trying to get the usb power_supply during the
> > probe will fail and there is no chance to try again. Also the usb
> > power_supply might be unregistered at anytime so that the handle of it
> > in dwc3 would become invalid. To fix this, get the handle right before
> > calling to power_supply functions and put it afterward.
> >
> > Fixes: 6f0764b5adea ("usb: dwc3: add a power supply for current control=
")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> > v1 -> v2:
> > - move power_supply_put out of interrupt context
> >
>
> Hi maintainers,
>
> It seems that there are some problems in version 2. I will send out
> version 3 later.
>
> Kyle

version 3 sent

https://lore.kernel.org/all/20240804084612.2561230-1-kyletso@google.com/

Kyle

