Return-Path: <stable+bounces-25886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE8C86FF73
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 11:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB815286A0A
	for <lists+stable@lfdr.de>; Mon,  4 Mar 2024 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C723717D;
	Mon,  4 Mar 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOc7ju8J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630AF1B814
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709549430; cv=none; b=dzboQ903Nv4yetjIHWchSXpY1JJdZcKJym3hM0ukOQ7SVYDShzOg6gJ3VOTGJVx5fkMPi3V18D+nJf/9IRIcv6dhrN195//bpwCUcemNr3AYeuX7m8TPD9S+Grs63EGQwFq5fvhO8F0rKoiXIMtM6iCzzJSHHBjUYQ31FPq3O9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709549430; c=relaxed/simple;
	bh=nGsIcZ0Fo/9BomQExcmQt87FFQQHVzSIxQoeX6oRjUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cS30m/tg6uNzA8HyzcT11kwBjeBRCTBa3Oqqi6J3TIeae7Ai3ha9pRkjy0U8CQGkjevsc/DjMeR7tiCIVFflm2rrVpCpuw3qP8TQnpVc4Wzeirnq0bPiiS9EYxBMvW0UVSWqo2XWUAoV26x6eCdglj/l2vjtea5mnwf6ZJv6gRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOc7ju8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99C9C43394
	for <stable@vger.kernel.org>; Mon,  4 Mar 2024 10:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709549429;
	bh=nGsIcZ0Fo/9BomQExcmQt87FFQQHVzSIxQoeX6oRjUg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oOc7ju8JpltD3S0evKs6KQyDpYrHwKPV4EjN09hrxl1f8pB8rNOHRpQYershWi7AI
	 sT2r9AreCm8hKeL8XvWCz8QJIBiq3c/G0ZMPlh/889NmZ4j28C2jC+xO0YQfNw2KCS
	 6hXNdGOXEK7FGfyOiOHikoBhq4xMdd5GV1L4HYL98sQtB9aozvU6wx6z5aprhilmlt
	 0ShwpN/oDDWhRTMeuIiyxlsdbd5vqn5iR7lsC3Ok9XuRCtLIDYQAc8uowKmVn3oZs8
	 RayQeYnAh4CrHZOVqOgBOlpbmOIrpgD9DvuU+anmP6sLX5gXk7Rd6QsLlDlxQPVozO
	 CCdzRt0crpfXg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so52524851fa.1
        for <stable@vger.kernel.org>; Mon, 04 Mar 2024 02:50:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yyp5q5wL5WfuIPtVGvkr+9gJNSVXp1FM9NJEYLnZpTFop6QtUMW
	geMnRT6TMTdSyKW4B7ikvWPRAgFsrl56x0bKU7JswnMBv6A6fAufOpAxAm2ytiZjUoYs2Xwo0dH
	RHDho5SZYmHNT7sxy9p5JLfYenqg=
X-Google-Smtp-Source: AGHT+IGJptrgJ1zd1gI7pE462jCyqDOxXza1aqLEbcs24PtGOtyeKzQMiKeKsIX0ZvY5NTs7knhl3uwhaCwRiWJEdHE=
X-Received: by 2002:a05:651c:1258:b0:2d3:32e2:f953 with SMTP id
 h24-20020a05651c125800b002d332e2f953mr6237091ljh.18.1709549428137; Mon, 04
 Mar 2024 02:50:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMj1kXE5y+6Fef1SqsePO1p8eGEL_qKR9ZkNPNKb-y6P8-7YmQ@mail.gmail.com>
 <2024030419-booted-dwelled-619b@gregkh>
In-Reply-To: <2024030419-booted-dwelled-619b@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 4 Mar 2024 11:50:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEg8y-X89Xz+Rx0h03RHPkPTcNULDPrGrmk92SWt5khag@mail.gmail.com>
Message-ID: <CAMj1kXEg8y-X89Xz+Rx0h03RHPkPTcNULDPrGrmk92SWt5khag@mail.gmail.com>
Subject: Re: EFI/x86 backports for v6.1
To: Greg KH <greg@kroah.com>
Cc: "# 3.4.x" <stable@vger.kernel.org>, Dimitri John Ledkov <xnox@ubuntu.com>, jan.setjeeilers@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 11:37, Greg KH <greg@kroah.com> wrote:
>
> On Sun, Feb 25, 2024 at 11:02:50AM +0100, Ard Biesheuvel wrote:
> > Please consider the patches below for backporting to v6.1. They should
> > all apply cleanly in the given order.
> >
...
> For some reason, not all of these applied cleanly.  But they still build
> with just a subset :)
>
> Here are the ones that failed for me:
>         0217a40d7ba6 ("efi: efivars: prevent double registration")
>         df9215f15206 ("x86/efistub: Simplify and clean up handover entry code")
>         127920645876 ("x86/decompressor: Avoid magic offsets for EFI handover entrypoint")
>         d7156b986d4c ("x86/efistub: Clear BSS in EFI handover protocol entrypoint")
>
> Can you provide working backports for these 4?  Everything else is now
> queued up.
>

OK. I'll do those 4 as well as the remaining ones that didn't apply
cleanly to begin with.

