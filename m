Return-Path: <stable+bounces-41762-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317DD8B6112
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 20:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB109282553
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C75128826;
	Mon, 29 Apr 2024 18:28:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8474183CB1;
	Mon, 29 Apr 2024 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415309; cv=none; b=eKNy6eR+ufwFdK11oyjZqXUGMkMymXXNbXRUubznUVAdx5Afi+0GIRdcHDp7/Huere13JvuwRGNWWj0IEY4BH2g4aRImaVicNH6N/qLO18SiSzO9UoWjL/DA0W0Z7U+0hLqn7HCt+Nl0fdd2z4JCx6lcUuyibABn0NWoXFG/FJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415309; c=relaxed/simple;
	bh=8gKah3ghORwSGGK/lLqzKUstmtlsU0Ko8BP6JJhYCX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCqTqz+uwBwqPcuohxWEMRerG6tHMv6F5DAs0TflESFo6OJfZLgatlxIF6t/GbXhpC/RTa9EGYAh4JpqvwGhPOxLh7/B2Prh/25lPyN7w957HjEZ1r8jkXGQLP6YiIktgUTB40Uzt+iddT/UvLa7wwcC/8/HGFZoOTQGJhfUQ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=m4x.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=m4x.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso5186703276.2;
        Mon, 29 Apr 2024 11:28:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714415306; x=1715020106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gKah3ghORwSGGK/lLqzKUstmtlsU0Ko8BP6JJhYCX8=;
        b=VY59Nu7xrAPGA4Yxd2WNs6nop5Xe2xJeym2KC9PHmWyhKpno+4Dn2NtreInMfo/dtk
         H8fVIRK+TvzSu4tYIB+g5WsBrKLw8ueL3GW1cLNiZKCqLHs98hJSED8lNz18BjTn9wsp
         r8xU25iQOYpR1N65RLRnQ2qMKPtcQEN09MdG+VIik1Fd3MlE1Xc4hzkIH/t/WXieDO4V
         wdK8MxBFALKlESxwi6pUCApK/m0pwJRowIo+ZzOgO9WMWn/RPe+5gnXnU3tPVF9/QQN8
         UxIfuPfTX57hMxVHzW2Wl/TMPjkzesZQ6gwaCKE63x+AOw3ud5atllqxIIRFJyVtCoEf
         iecw==
X-Forwarded-Encrypted: i=1; AJvYcCV6WTZ+oVogACmpuKF9jEnvx6RPYxfo1KP0h/naS9oM9VYISyLWBCu5blYmkBJBWgPjxfmQZOubXkXTIbzDmQrqcg8HzotZ/eLP4RBGx+1b
X-Gm-Message-State: AOJu0YycbTvB5QXSuUn9U218qUtM2cHHt27QlRMPkeY8KxHBTslpmoLE
	3R7vdlWa0okZkEs72F7dcQurupMFS8/Jdx9AIUABtIAHSSRZSZ2MOWE7iVxOPtBO8ZlmHTBULGX
	tZ9z8IvkYCVP8e42+AZlo7yKluAk=
X-Google-Smtp-Source: AGHT+IHOyBFS0F26owaRkYzjeQ6P7JZp13vcQ6OpfgJfXqxeemEwewCnezmmd/d2OHC+eX+zxX0/6o4drbJoo9aPPc8=
X-Received: by 2002:a05:6902:1b8d:b0:de5:d1cd:b580 with SMTP id
 ei13-20020a0569021b8d00b00de5d1cdb580mr443367ybb.36.1714415306415; Mon, 29
 Apr 2024 11:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADRbXaDqx6S+7tzdDPPEpRu9eDLrHQkqoWTTGfKJSRxY=hT5MQ@mail.gmail.com>
 <1de62bb7-93bb-478e-8af4-ba9abf5ae330@leemhuis.info> <4bf3497d-0ede-4e05-a432-e88e9cbc10b4@leemhuis.info>
In-Reply-To: <4bf3497d-0ede-4e05-a432-e88e9cbc10b4@leemhuis.info>
From: =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>
Date: Mon, 29 Apr 2024 20:28:15 +0200
Message-ID: <CADRbXaBkkGmqnibGvcAF2YH5CjLRJ2bnnix1xKozKdw_Hv3qNg@mail.gmail.com>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Mon, Apr 29, 2024 at 12:24=E2=80=AFPM Linux regression tracking (Thorste=
n
Leemhuis) <regressions@leemhuis.info> wrote:
>
> So we either need to find the cause (likely a missing backport) through
> some other way or maybe revert the culprit in the 6.1.y series. Jeremy,
> did you try if the latter is an option? If not: could you do that
> please? And could you also try cherry-pikcing c7eaf80bfb0c8c
> ("Bluetooth: Fix hci_link_tx_to RCU lock usage") [v6.6-rc5] into 6.1.y
> helps? It's just a wild guess, but it contains a Fixes: tag for the
> commit in question.

I gave it a try, and sadly I'm still hitting the exact same bug when I
cherry-pick the patch you mentioned on top of 6.1.y (at tag v6.1.87).

Thanks for trying, is there any other patch that looks like a good candidat=
e?

Jeremy

