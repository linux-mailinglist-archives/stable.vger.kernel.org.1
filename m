Return-Path: <stable+bounces-116463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E84A36901
	for <lists+stable@lfdr.de>; Sat, 15 Feb 2025 00:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67046188CFE6
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 23:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758F01FCCF6;
	Fri, 14 Feb 2025 23:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HUygTgAs"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4B21FCD05
	for <stable@vger.kernel.org>; Fri, 14 Feb 2025 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739575153; cv=none; b=RcX4mXiiJ/vrDcxpcnaIaQRCqk5id/scAX4vsTGcn+AtXj6syvaAXc6S+aa1BeejD1ofkDp8440UbOpiOxR2tsGDENODhH+8vfHGgBLcqGApbCpaeMStQnwFWhGWdES1C6HSx5+j+ithGOnF2Je3Ymtpq64eyWK1VSd+tJHqWgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739575153; c=relaxed/simple;
	bh=SgmEvAU/vG04Qn0lJ4jDnjyvyJBjVNh66TzffQgnVOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4N+Pb0FWbCqQZ2GHohQqhokJ+/LbjqZPgUVZEHuj6tiCRFxGMmLx767Wa2UXnSf4gksaZBzQm8MTAC+NBkLBjZL69VdEo2U7jCNXCNImMSMKtTOYc0Bx1XdIZn17WtTGVjrI73gb9H4j1CycljeBmBRAT//unfcvoXJsc4ktQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HUygTgAs; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so3022009a12.1
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 15:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739575149; x=1740179949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGj/3HWHrhep/eH6jmzDeOoJQ8CQVCeqgV1vLe07A2c=;
        b=HUygTgAs3gCGNw/7iI89AFbmXPiV5N4VXRMZCGCvolY2FzIFNwl1paUHTgF9wtNVnh
         tBLAlt8Zz9gU7S6xLN0Vw4PA1m1P9Q34gWSG7JXMeKzW3NtQVj99KKgehWL724+wFaPs
         8RkPfZxgw50hncm6G9vW3DtLvL/ShThibCue4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739575149; x=1740179949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGj/3HWHrhep/eH6jmzDeOoJQ8CQVCeqgV1vLe07A2c=;
        b=Gqn2iqM7/NQkrxHdFxdijNT1rnsf59Y/uXHH3oCGyxuKItbIiUGM9sPh1icxhOh9z+
         y2ypkUAhQhIbqs4b3kgWleoJO47sB46t97dsfrLyeRXsisVXcoRBD3FjQib6NhIj5G9d
         AGVBnlFw9g6KdgOZl//j61cKArWcVXyCvN7gGPhdD3bEUaJwt7u3FPAYjPfo00HPKJTa
         wR1JJkP0lngVg7C/31qAc1khJNzYEJlnANLqAIpaoNL8AbU+T3/hiivbxEUNyexFaKTd
         WUyPW6kqUxBNjSNrKI0vD0wOIVaLUd/4hbD4EhpmuiWnKvuw6M3iq27va/Y4w3bKJ9KZ
         BTrg==
X-Forwarded-Encrypted: i=1; AJvYcCXqctFbikV2HvPMvn2rfyrGS7LFnNrVJVvBKY3LE41oega/IK5Cc+I0XfoxojPqZUlU6lRK4sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzluhWR/8bRYX1OMBq4Vd8cTOqT2y0vXomNEN2kzvBtJ/LxGmrw
	cBVdZIddx/nxumCdde7cjb9bPP6o9MSZgT7DMJ2I24szedkbcEbxgZIBhzae6/nqsClyHKTkKVS
	zRhk=
X-Gm-Gg: ASbGncsrflxMQO+Zwb2R6BsrLKqfEZ3u98O/4iIM+vN8H60B0nlPAgy6G+TohEHGiPc
	EnP/+n4Z56y+iswuC+VXpHUD6sejzxVDtIeUpaaMZzdC//V1YrC4nx/Ypy06C/OtT8CEUTxzVTl
	Rvmo3iACl+lkccpiTOGdcJebF1hW3CnEROZopRvWNf+fFQ2fqRgWf+aA0LSBKc0/XoGzJ8TZnu8
	K6HDuj7ZUoJFK4cW1HFILx2ac7U30KuhSVux7rZxMcB7RavL70M4kaxaPv48NFLjJ2Xfkf3VZ+J
	2DPlNjDo0koBtpgjQ+EMYhGsYOcfMbMvwfh44i+kh5eawj+TWUjQwoYcKEU2ueCPdQ==
X-Google-Smtp-Source: AGHT+IF6uOZX+0eCua6OqTKf7KaVEM+XiobvXi0rrgLhtVBUZYsOgGzcBBQj19dft+3Zn0xJ5V1Asg==
X-Received: by 2002:a17:907:6d08:b0:ab7:d87f:665a with SMTP id a640c23a62f3a-abb70dc5897mr98069966b.46.1739575148865;
        Fri, 14 Feb 2025 15:19:08 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bf5casm420355266b.182.2025.02.14.15.19.07
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 15:19:08 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb7520028bso12294366b.3
        for <stable@vger.kernel.org>; Fri, 14 Feb 2025 15:19:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVHZ28VvLFP7rkEPIahyAqwpxtWIBqx2uL1wZIq5ZWNt4vgOJXPJu/gOlPpF0lYksAI9xPbKjg=@vger.kernel.org
X-Received: by 2002:a17:906:3155:b0:ab7:5fcd:d4c4 with SMTP id
 a640c23a62f3a-abb70c054c6mr76397266b.33.1739575147640; Fri, 14 Feb 2025
 15:19:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213142440.609878115@linuxfoundation.org> <e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-asynchrony.com>
 <2025021459-guise-graph-edb3@gregkh> <9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com>
In-Reply-To: <9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-asynchrony.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 14 Feb 2025 15:18:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiqfigQWF1itWTOGkahU6EP0KU96d3C8txbc9K=RpE2sQ@mail.gmail.com>
X-Gm-Features: AWEUYZnpuwVNokIgf-y-LLoLlsjnsYUfEfqoXfSxgBhKGKvjpuPO1OGj0V6ncvE
Message-ID: <CAHk-=wiqfigQWF1itWTOGkahU6EP0KU96d3C8txbc9K=RpE2sQ@mail.gmail.com>
Subject: Suspend failures (was Re: [PATCH 6.13 000/443] 6.13.3-rc1 review)
To: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Phil Auld <pauld@redhat.com>, Waiman Long <longman@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding more people: Peter / Phil / Waiman. Juri was already on the list ear=
lier.

On Fri, 14 Feb 2025 at 02:12, Holger Hoffst=C3=A4tte
<holger@applied-asynchrony.com> wrote:
>
> Whoop! Whoop! The sound of da police!
>
> 2ce2a62881abcd379b714bf41aa671ad7657bdd2 is the first bad commit
> commit 2ce2a62881abcd379b714bf41aa671ad7657bdd2 (HEAD)
> Author: Juri Lelli <juri.lelli@redhat.com>
> Date:   Fri Nov 15 11:48:29 2024 +0000
>
>      sched/deadline: Check bandwidth overflow earlier for hotplug
>
>      [ Upstream commit 53916d5fd3c0b658de3463439dd2b7ce765072cb ]
>
> With this reverted it reliably suspends again.

Can you check that it works (or - more likely - doesn't work) in upstream?

That commit 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
earlier for hotplug") got merged during the current merge window, so
it would be lovely if you can check whether current -git (or just the
latest 6.14-rc) works for you, or has the same breakage.

Background for new people on the participants list: original report at

  https://lore.kernel.org/all/e7096ec2-68db-fc3e-9c48-f20d3e80df72@applied-=
asynchrony.com/

which says

>> Common symptom on all machines seems to be
>>
>> [  +0.000134] Disabling non-boot CPUs ...
>> [  +0.000072] Error taking CPU15 down: -16
>> [  +0.000002] Non-boot CPUs are not disabled

and this bisection result is from

  https://lore.kernel.org/all/9a44f314-c101-4ed1-98ad-547c84df7cdd@applied-=
asynchrony.com/

and if it breaks in 6.13 -stable, I would expect the same in the
current tree. Unless there's some non-obvious interaction with
something else ?

               Linus

