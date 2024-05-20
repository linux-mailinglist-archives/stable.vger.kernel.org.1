Return-Path: <stable+bounces-45467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AE98CA466
	for <lists+stable@lfdr.de>; Tue, 21 May 2024 00:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA48A1C20F42
	for <lists+stable@lfdr.de>; Mon, 20 May 2024 22:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F792137F;
	Mon, 20 May 2024 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkUyPguE"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9641C2A3
	for <stable@vger.kernel.org>; Mon, 20 May 2024 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716243495; cv=none; b=rQcEIBoNvYjY4Fv/6CzgDHDgYoe/0NeybAxWsA7z+Igxq4mz0tyNify3U0rH6QvVA3awoHEetfnh6cISz6tDgs5slO7h9zeCrm2m40WTDtzGKTBl3vr/PsAaGRPusfcln8XdOnFK41yio/XJc49JoHXmBy9rtNwntjAyN+Y61yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716243495; c=relaxed/simple;
	bh=l3uDnU5Omnw9mvPyeTg0I3onhlPaw2D0S6U8dzuWFOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAAIQJEHUYn2/MdgWMQfmLRKG8FULfLStd2Y6mAoworiaRwDbLk+tbPKKDXKj+6Hf3JDcI+nhqprpXeAz1ZQvbWfiN3zyLnYcdY6zSQFSLl/FfqA/gBcVlzf1k2Q4vHgFNA1FxcYh3+1nSkytPUAgPyn0jhzXlFZJh5iTYmxLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PkUyPguE; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61df496df01so19871917b3.3
        for <stable@vger.kernel.org>; Mon, 20 May 2024 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716243493; x=1716848293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sBrO1ctFc2c/0tvUK6NJhFoOiIbX2bS/Vh9H6Ivw8V4=;
        b=PkUyPguE/mAZVEurRGgDTUF8OZmN/tDTR0ZluNuXWBjzG2PA+h4B8+IbGvAgP6+ymT
         tYuSM0M2N9eq48X2amRDCz9xzeP/rqghTjoDOQS9zQvBLd4tnBgXAIJuitx6Sx5dUfMt
         oEZLpKQBHPBqONiyjF8qcK+/uV3MkBmq/JI2iUNNfc4ISorPreZAxDaCGTn71q3+9hM2
         WURNrMVudq09mVC2u/uJg8vDYiUDFol/wHkRWVj4W6pJNF2p4R/K8nUanx7aGROYgxe/
         QPHjx9TsB2GjUxWyRBspq2ybLqmHn4WREmc8bBl7jpDaJVkwqvcbtsTFtMEem9c5qJPT
         sRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716243493; x=1716848293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sBrO1ctFc2c/0tvUK6NJhFoOiIbX2bS/Vh9H6Ivw8V4=;
        b=UQO0dDEYJYMddnkEnanU71hviP79lsvsYHDqxLeJSwuFreY3bcWgkjH44H+fxnVJVp
         d0JMwN3uNk20JchjANnWW93CrNbZQE+Hn42eOVcH8XJMW5oEwFA7qLE/bFBx/nyPHQBC
         UCfIVj96y0MODZR4e4IYMWdyJS32ryV0Uwg/LivHs1LQbRSw5UeFae6grF+zOXEj8+wZ
         ++/uKtE+gW4I/m4RCj64eLTmiW3EqJt0Fc2dnB1LNMixwRPdDIGaiKhjefq21e/wOLNc
         HBeo0xgmCHxuzivQbKcuHvauFuwkHK9AwfovjdXf9O7tDSsfb23N+vyXYjyg/VaC/WbT
         /0oQ==
X-Gm-Message-State: AOJu0Yy9jgG2HhR/saKevUI9MyLIMHdOEC5Uh7HMvKO+zg/SW74iXv4W
	BArqIPeb8+e8fvHePkeUVjNH5epj6hP9D0DaTWKQQ73jQw8kxWDmb9rAiRHoEW8WbZq8ciBxE8V
	mr0j3vhv7Y13uAYgYJ87ZufLsv7YfA6UnMH9aD/TqsV9S7bhTA4DF
X-Google-Smtp-Source: AGHT+IF2QB47BWSswR07JkE0WYCBisLCLQRyP/Ey7pF0cE+ItODh3f6Soq2dCHa5JIM2Jv64qkb7d0K4H8DYQs3uFMA=
X-Received: by 2002:a05:690c:6d91:b0:615:15fe:3cb8 with SMTP id
 00721157ae682-622aff80a5bmr328629507b3.28.1716243492574; Mon, 20 May 2024
 15:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240513233058.885052-1-jbongio@google.com> <2024051523-precision-rosy-eac3@gregkh>
 <CAOvQCn5LEhFw8njxO7oa9Q_Ku3b7UEEmJUAqPw9aTO3Gu90kRg@mail.gmail.com> <2024051632-qualifier-delta-f626@gregkh>
In-Reply-To: <2024051632-qualifier-delta-f626@gregkh>
From: Jeremy Bongio <jbongio@google.com>
Date: Mon, 20 May 2024 15:18:01 -0700
Message-ID: <CAOvQCn4XH7iV=Qcn7Oi9O3H=TG7ueTzj6Pck22J9eL7JJ3A=HA@mail.gmail.com>
Subject: Re: [PATCH] md: fix kmemleak of rdev->serial
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Li Nan <linan122@huawei.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 11:54=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
>
> A: No.
> Q: Should I include quotations after my reply?
>
> http://daringfireball.net/2007/07/on_top
Got it.


>
> On Wed, May 15, 2024 at 09:31:07AM -0700, Jeremy Bongio wrote:
> > 5.4 doesn't have "mddev_destroy_serial_pool" ... More work would be
> > needed to figure out if the vulnerability exists and how to fix it.
>
> Can you do that please?  I know Google still cares about 5.4 kernel
> trees :)
For 5.4 renaming mddev_destroy_serial_pool() to
mddev_destroy_wb_pool() should be good.
I notified the Android security team to test.

>
> > The patch also applies to 5.15, but I haven't tested it.
>
> I took it there as we can't take a patch for an older kernel and not a
> newer one, as that would cause a regression when people upgrade.
Makes sense.

>
> thanks,
>
> greg k-h

