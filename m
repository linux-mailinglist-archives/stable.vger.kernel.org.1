Return-Path: <stable+bounces-152534-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D47AD681C
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 08:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 457FE17BBF3
	for <lists+stable@lfdr.de>; Thu, 12 Jun 2025 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA691F4616;
	Thu, 12 Jun 2025 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaJ7SvjT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F424A1E;
	Thu, 12 Jun 2025 06:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749710314; cv=none; b=ICm9nWus6CsQTPGgplAPPDWB5Jd26GslF5KIUGgFGponUZpb6iCUff3EspVn3Flt4RIRulLNuQJhpcAL/uDAgQLkomFBszqq8FxbibH+ahtgPk/V9vSiNgzK+BO//eIJwJDpdrr54RYmM8hVYEO27hyxy7QLT3bg+5HairgMHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749710314; c=relaxed/simple;
	bh=DNaP2b18RLwC0dvD3DmJMp8aMZKCaBX+OyT9uu5maEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZC53rpkHAUgttDzx7zOF7BYDfypw4Hk8ek4amS+49GTqHhG30hHtpG3bj9a+qpblNAUZ+JGzGYSSfnBdolUtTXk/nOhfrKx0gMe8YtOGUf0KuMCUX3RNJXBAwod+24s/grWzBZGdJsVbSdmla42dnS7W1r1FlGthd2T4TqtOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaJ7SvjT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-453066fad06so3659655e9.2;
        Wed, 11 Jun 2025 23:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749710311; x=1750315111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8bjTfFr32DnYdLike+eqAQTQ6LqadDrobLqw6eKXqjY=;
        b=JaJ7SvjTRUhri5uZn47xxvQaLSCI2YsoFOLu27D1fSbVVjFnM85nLCTIqVGb2MJDKd
         Lmob4JVhxozxgl3m7AbC99WvHDMtCB42tHrAZv+LfgMJEAnYAiF5S093B88w2dT8p3xK
         koRm9q0nFYN/qZar2m90UzAzmTJZW1AeZ2gorwsi3tBTCNNx0BranfmFaXyJUcTfwIWI
         c9FByyD1Vb+5uGONOvpIRKCnPOYrdluR1MMb/QZnx8S+/93RPFpyCpE61AFeLpC5AIlp
         3do5385lsUaePtKjgr2Ydht3frq7QdEY+JmG48cYHFqaTZl4QIQtGOPBOyuU4vUWDM44
         AslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749710311; x=1750315111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8bjTfFr32DnYdLike+eqAQTQ6LqadDrobLqw6eKXqjY=;
        b=hXvLX9d0pn4UwRAjN7CEuJi7xjZ5JC2f/i6wJ36AKs5a809dVBDFKSmf3m9829U/fw
         0PaPi8mhwuGMtlx4xqdHULHVpsn/zY9DCjzywH6BpYKDxsrgRXwyvyQ3zH6xVxPaFo/O
         9Mom6Lz2LS9AufQ+LE9rQ6JCrZnMQiH+WzDZYXhuAw7PIJWu/AFlGrRCL68/FakSvjGR
         U23AVXOBK+pg06aZzlRP396kWeU/iPxFO3ZwI6gO8xRc/5awSGbyKDOm3K8hai2AnnHh
         ly6HnZ16ETzmjAWnywO6TM4OKp0Y9uawnIhuyQUtos8BfOlZqo1/alOn7/REzw7STS1+
         /f9g==
X-Forwarded-Encrypted: i=1; AJvYcCWjFdMcJY+JOB7j81PeJpXWeUpXuo7f9oA+MDE7HR0PnV1fv1iHAnHu2hqcPKzigN+NuCftoePs@vger.kernel.org, AJvYcCX0GSfssMJY7gOV222m3/I4sJe9qvHqZ2pjgg233nvHZElUDQjxWrPJQeEwVzJQ7BoiCfX7Y1FqnD6zzjc=@vger.kernel.org, AJvYcCXFJA7q9HUM4gTO3FnWTtxhvh0HvLQhI5RPABQkJ0jZAtLX4zd9R/KzDFfTdTTHpMcXVjTUFbJe@vger.kernel.org
X-Gm-Message-State: AOJu0YzKXyxU452LnVDJA+5YXID3kkDKIK3oH1n4z1eaCNaJ5BYOKiUZ
	vmtuE21mbO9kdgVs+zsKhKILA2Dih+kMOceWHMRlaNkjmlZWvkq74qeuUFL3vaczOlPsYZDaZaN
	D4voERfRW71qVAxcH0H4ZfxXppb8Xe1o=
X-Gm-Gg: ASbGncuWvpc1w8Z3Ne90CUf4UsNs39u+plJ/q3MpyWKSH7YB0aK1XTz/hvc9LNrJacG
	A5VTeWMmjM0SAPi2Sdz9Eb3YCzP9tHxr5+9z2X+X7zg2WBvIyUzfjt3XZDE/86jti8mxlxkhkUb
	ox2gtAMnh0ac+KNemJrwwmKa6OlCnlN0O/Wf8jDL3CTdOjAfpl+IZawWMIUef6rKJLTX4RWl4fU
	lUCeTNir+mAcA==
X-Google-Smtp-Source: AGHT+IEVN5HAlsP0HCxGv2neCTKzhKxQV6Oy9iItbZevlaTIZ4CvV3/m18xVAnQDvH5iWMWLeerSZclqCIXIsaTQDWY=
X-Received: by 2002:a05:6000:1a88:b0:3a4:dd00:9af3 with SMTP id
 ffacd0b85a97d-3a558800c9dmr4448166f8f.56.1749710311423; Wed, 11 Jun 2025
 23:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610160612.268612-1-rubenkelevra@gmail.com>
 <87cybbzbe3.fsf@posteo.net> <20250611145144.2bc0a7b7@kernel.org>
In-Reply-To: <20250611145144.2bc0a7b7@kernel.org>
From: Ruben Kelevra <rubenkelevra@gmail.com>
Date: Thu, 12 Jun 2025 08:38:20 +0200
X-Gm-Features: AX0GCFt6ZyFDkgwAI3QouTDoe0U-mXCGEmaKXT0wo2gsD9e3Y8ot9ocel2G7Sxk
Message-ID: <CAGHX7-P5fgFCs3cJTYERu9dLne=UADPc-dHPZ6GYvkcdmTHXwA@mail.gmail.com>
Subject: Re: [PATCH] net: pfcp: fix typo in message_priority field name
To: Jakub Kicinski <kuba@kernel.org>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

I hit it while building an out-of-tree module that reads hdr->message_prior=
ity.
Cross-compiling for a big-endian target failed for me, because of it.

That=E2=80=99s the only reason for the patch; net-next is fine, no need for=
 stable.

Cheers,
Ruben

On Wed, Jun 11, 2025 at 11:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 10 Jun 2025 18:42:28 +0000 Charalampos Mitrodimas wrote:
> > > Fix 'message_priprity' typo to 'message_priority' in big endian
> > > bitfield definition. This typo breaks compilation on big endian
> > > architectures.
> > >
> > > Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
> > > Cc: stable@vger.kernel.org # commit 6dd514f48110 ("pfcp: always set p=
fcp metadata")
> > > Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
> >
> > I had the same issue today, happy there's a patch for this.
>
> Could y'all share more? What compilation does this break?
> The field is never used.
>
> More info about how you found the problem would be useful.
> And I believe this can go to net-next, without the CC stable
> and without the Fixes tag. Unless my grep is lying to me:
>
> net-next$ git grep message_priority
> include/net/pfcp.h:     u8      message_priority:4,
> --
> pw-bot: cr

