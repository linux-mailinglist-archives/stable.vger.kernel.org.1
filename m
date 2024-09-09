Return-Path: <stable+bounces-73981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993C097111B
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 10:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EDD1C223D5
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 08:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D8F1B0108;
	Mon,  9 Sep 2024 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yx8KFgNg"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7601B253A
	for <stable@vger.kernel.org>; Mon,  9 Sep 2024 08:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868806; cv=none; b=LOMwMTFT6PU6vG+7RgH1KohyUP1DaliglDN4d+DSWJgfB9KC/UNhaAmTdlOF6jC9LhD+ZvVcLnb/zS1AOXqDc3W7zG+dCphP0KQaZTTdfUQfLpu3D+4r5hyTboOvB5aegsITPeG6hnDp4NsLmW9IvhxXzMMTiLkogVQ+4bbJQKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868806; c=relaxed/simple;
	bh=gASu9HJMykXfExbmgPC2VNk6kZ5rnWb5Dpl91MM9Uv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gA4kJZ1DteGYXzcB41I27mlv0akPbgqV3YO2wQxtbBUk4sV1pd6nt/T6ClHO1Zjue5qXQlv1uVJNfWBGPBWqwflon+armpn4ENFDuh0tIyGDTVFXGOOrKjeWWhNRl7CrmxR2yMqJEqkrinqPFg2kXpf73oQmicPDZUKtQeJ6dtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yx8KFgNg; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so180896966b.2
        for <stable@vger.kernel.org>; Mon, 09 Sep 2024 01:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725868803; x=1726473603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9PBBHIYLAYRXzcCFakl56INq2rd/4/lng5YYPxEOZc=;
        b=Yx8KFgNgkwHnZ5FcpYYfuSeiw4xUqReprYWUEYgVZv/waKOJh6GcAEppa+DEQKkWBh
         UxK2ECty3U+hThCnrK05xxHP6AA1zW5rytEyd4VYlH99YZ8K1/vjvGRXAJMkgAhyz58/
         adtlu5OQRiJMFkxfdy+PvO3TFkAS7MJmLLNpAZbvgcCvqItN7+izjUv4cPoudJhgT9by
         k+4dXhQj2O2mRzPsrr6Qcd8n2wJ1nurE6cqxA66MC4Zwp6b4sdCDX7gcU4ZiIQA0WmhG
         +QLyajg3yaDJNBErev1H9lJgOasVq2GiSkVhn7zz3cTVBXpOEqsmDeETP6fm/xzl6M6X
         wMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868803; x=1726473603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9PBBHIYLAYRXzcCFakl56INq2rd/4/lng5YYPxEOZc=;
        b=d3FszRvi7F4lGIj1MLWOjzUPEXwk97Fw3owhQyTmN6T+apuAPLEOqzOjFN1jrEODfQ
         6UP0Yz5B2GM0dUO0ShNPAoVQLJIlmFXh6NTKtMV/SusTZJCpIH+6BTbgYNOeMlzs3MqL
         PWGGGDUAztYDaA69s7y/mnznDNGgt2d+RsYaEPNU1n1SDTRSQDE3NzZFdkI39RFjotoU
         GBQN5FTOhQPywaDcnRkczTdqad8RsRYorYyNIUin5SH0hUGfwDr7CBqSypEjSyk8d29f
         eo9Y/zUD0Y4SZfjTDpJgyF0r7trDmjUrcBS3ifYZqT5KqPiGWfM3cfeLxc49ShiiS/co
         kHKg==
X-Forwarded-Encrypted: i=1; AJvYcCVjltTNm1D4GTSoXrJnPvd9Tb7ajV7IkvQhWaiMGDqmgZrR0qslHBAZ6bZz94X08m2T22qJ7VA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzu/HTb3NI2DhvFHBafxRlqpC/894AkvIk5qKXBa0couKgIFtM
	haHSNqaOrCovNBUNwQGTyFUUMDQJ4gr1cg8U0dsuv+egb8TlUZCdnEItUw6BKCYNE3rf20ULLxH
	XMobdlrNY4EE017YNRwkPr/0c6Pc/hXDC0xw1
X-Google-Smtp-Source: AGHT+IF7bflO4E8blx4goAwDZGqrnf9Fzrlsnqdpl7vuwjrs1ihpS5afrZCe06fxAHAyEPJLi0rChmMnAxRNFq45+SQ=
X-Received: by 2002:a17:907:3e05:b0:a7a:ab8a:38f with SMTP id
 a640c23a62f3a-a8a88841c41mr843882966b.41.1725868802314; Mon, 09 Sep 2024
 01:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024090859-daffodil-skillful-c1e1@gregkh>
In-Reply-To: <2024090859-daffodil-skillful-c1e1@gregkh>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Sep 2024 09:59:49 +0200
Message-ID: <CANn89iJU9jPB+G5ETqwcEKcrRFt5ONVGF7=TsLnA21FUKT3+Rg@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] ila: call nf_unregister_net_hooks()
 sooner" failed to apply to 4.19-stable tree
To: gregkh@linuxfoundation.org
Cc: fw@strlen.de, kuba@kernel.org, syzkaller@googlegroups.com, 
	tom@herbertland.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 8, 2024 at 2:51=E2=80=AFPM <gregkh@linuxfoundation.org> wrote:
>
>
> The patch below does not apply to the 4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>
> To reproduce the conflict and resubmit, you may use the following command=
s:
>
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.gi=
t/ linux-4.19.y
> git checkout FETCH_HEAD
> git cherry-pick -x 031ae72825cef43e4650140b800ad58bf7a6a466
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090859-=
daffodil-skillful-c1e1@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..
>
> Possible dependencies:
>
> 031ae72825ce ("ila: call nf_unregister_net_hooks() sooner")
>
> thanks,
>
> greg k-h

Hi Greg, I think you can cherry-pick this patch from linux-5.3 era,
adding the pre_exit() method

commit d7d99872c144a2c2f5d9c9d83627fa833836cba5
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Jun 18 11:08:59 2019 -0700

    netns: add pre_exit method to struct pernet_operations

Then cherry-picking 031ae72825cef43e4650140b800ad58bf7a6a466 will work
just fine.

Thanks.

