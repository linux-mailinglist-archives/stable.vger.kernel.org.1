Return-Path: <stable+bounces-89211-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 775B89B4BFC
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 15:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5EC9280A84
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6D22071E3;
	Tue, 29 Oct 2024 14:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA+iCVwy"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE972071E8;
	Tue, 29 Oct 2024 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730211562; cv=none; b=Id6H4Zf0HAmPomC9Wr+IbSEfJsOpuT2hX86b9KjcKqhpzfjCTV32tHY4d6sy+8mTfhL3EMJS+oJtj/CnXcFBnKpeb23Z/lUXP0H69FZTrfGi/fhCjrXFWZ1lSsvjOgG/G3dszF9SnAaabsy11bVov+7Mmj6F2ujhh34iTv0e7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730211562; c=relaxed/simple;
	bh=tA5sCYoeUjhRtn+y9hymUojsFEhOSIZxNR2YW/DMXsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJQgdQsnEXiJsVK/ckKnEAm5yAyumLyGOV/EPCYnCi1/aXAjfRtcWwallB1zqjdbEsbXBZJu+8U9xiP80S2Mtog6KS556Ixmn9puYrrlG3unkuEgyq92PN6i0r6fnNjm65MhlM57hch8J098N1GCIyxRnlCmc3i4LAaz44e2n1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA+iCVwy; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e6359ab118so1790784b6e.1;
        Tue, 29 Oct 2024 07:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730211559; x=1730816359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7HYSwpcECGpfVNHidkAxD9FJiVwdCLohbwQxJSDtSc0=;
        b=BA+iCVwyxdJ7BFXTe3CBW7a4dAKq6hxOx0hG80o/3utJCTXOzjkyvaDVBrB7PqBes1
         YoX/PmMoALmBWDBOk9DWyzls26ezWHjwG1izfnW7cK3G16YYQBEa5r81ygW3pR3Cxfhc
         RqcsyIEQBPSVP6N4xPJg/UPY3fsknPayiI5jzpBCbx40ToFO2v/neldaqLgrhGcSXlOn
         YRc3JF+aUDxoSxS4I+gpg10iNZLgntsUGWRDVfyrqAfQi2Gwbbpq2m8tUoDlOYywpd7a
         ciG8z7IuFjmt+0MUaQy1WKdwNhINiWJbXt/7srExarRfjRW7Kl233RdNxCK3RYnlKH7P
         E3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730211559; x=1730816359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HYSwpcECGpfVNHidkAxD9FJiVwdCLohbwQxJSDtSc0=;
        b=jQOH5XZLVjYT7VfHFM+g3o67h+Irr9IRpKRRNnZpXEgBzQ/VnG8uZawLYveNbnJW/R
         9H87v0/I6a0lzeHko1fflegLAS1lg/5raPFZ6D+JM6+BzJmf9DpKt5zzvKAWngXt0zpG
         ZF43nyXO09Ok9CZ4zVR8dynK4b6n+PAp5YHWF/w7Uwo4dFKCVEnKe3V3b/2DoggUmz1T
         URQeU6/Ow2AHyo0ypoNPfC3ryDxvVlMC7Ibcd6FyoiX9WF70pXXvQy1lqHhN+MxGbQpA
         0SLfaE8/REE4wUSfPDgZGNM42zAgmy/AU0F+0B17f7p/qhjMcvjOK3MiY5HBgYx7lKPi
         0wxg==
X-Forwarded-Encrypted: i=1; AJvYcCUzhGkzf/dTqbaTfXlSZ+Yhj9MfsM5EV7t1IQ+xZH3GEilqkCW6L0VSh8eWYYKLl2291WwnveYJ@vger.kernel.org, AJvYcCWQS+OB3yjjxGIAa9EQQj3zbhpBf/H6xw7V8FPGfXf2xIrs+ddKDu2BG68PnxUxM/USxngrO+qgrPg6zfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0n5jRJtdWOh5TdYbWQu2u1S/H185G9QqQFbDPKaZhPamWQLQX
	v26aP+AuPdICuMdgyisgp14N6giZWKfLjMJ+nAbKfbhnPO2VMuF4ROZfcJubSv91g5c56Pe9YSC
	d9PvFlVHfIMuHr7MJvwbLzn1ir4lTLtYkAuf4jA==
X-Google-Smtp-Source: AGHT+IGwmosdiSix2Ury+05PZd34B1zjQ6eUZ7gol1Akj9wSD1CftDjqGniqYvswO00427L1FytOlVJiyySkAayLY8w=
X-Received: by 2002:a05:6808:1a0c:b0:3e5:f4e7:82e4 with SMTP id
 5614622812f47-3e65256f9a6mr1302706b6e.21.1730211558095; Tue, 29 Oct 2024
 07:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028062312.001273460@linuxfoundation.org> <dc2297a1-aa4e-410c-b4a8-ded53a4a96a1@heusel.eu>
In-Reply-To: <dc2297a1-aa4e-410c-b4a8-ded53a4a96a1@heusel.eu>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 29 Oct 2024 15:18:59 +0100
Message-ID: <CADo9pHi+=T-oQGeL8fAAf_RDx1xnSYD1b1AONmxo66CqaNz_Fg@mail.gmail.com>
Subject: Re: [PATCH 6.11 000/261] 6.11.6-rc1 review
To: Christian Heusel <christian@heusel.eu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"

Works good on my desktop


Tested-by: Luna Jernberg <droidbittin@gmail.com>

AMD Ryzen 5 5600 6-Core Processor:
https://www.inet.se/produkt/5304697/amd-ryzen-5-5600-3-5-ghz-35mb on a
https://www.gigabyte.com/Motherboard/B550-AORUS-ELITE-V2-rev-12
https://www.inet.se/produkt/1903406/gigabyte-b550-aorus-elite-v2
motherboard :)

running Arch Linux with the testing repos enabled:
https://archlinux.org/ https://archboot.com/
https://wiki.archlinux.org/title/Arch_Testing_Team

Den tis 29 okt. 2024 kl 12:37 skrev Christian Heusel <christian@heusel.eu>:
>
> On 24/10/28 07:22AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.11.6 release.
> > There are 261 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 30 Oct 2024 06:22:39 +0000.
> > Anything received after that time might be too late.
> >
>
> Tested-by: Christian Heusel <christian@heusel.eu>
>
> Tested on a ThinkPad E14 Gen 3 with a AMD Ryzen 5 5500U CPU and on the
> Steam Deck (LCD variant).

