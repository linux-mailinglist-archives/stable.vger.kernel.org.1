Return-Path: <stable+bounces-28243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA787CEC9
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 15:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428BE1C21D1D
	for <lists+stable@lfdr.de>; Fri, 15 Mar 2024 14:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA99381BB;
	Fri, 15 Mar 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npfOG5uG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD1F38380
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512755; cv=none; b=ephAqFVQ7t2rJn5UKpf+KGrmO5pXH5zvjqXw8Fme06Hg6WzIpSdFEgYohKgNSmnLuG/Q6zZfQzXifw+uxMiTYR6kp2oD74lwYK3sH/zDY7Qqt3/l3BR3JUceN3ADd38Ahknd3NTfISOHRgtFH/KTaF9PrRuCTQ9v+HD7IhvgRgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512755; c=relaxed/simple;
	bh=yCAii4u6k7UDf2mCfYs3azGv5SdtykhLrhBD1xm5jHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wvu2ZPkQY0253k69NSjB8RHYXi2gA+JBqZsPHNBfwcnCARDuNcQlG5/M9Fr0Hp0HvALIz2wqy8bTLlZiWV1hVANoJTMeVHQbZ9PPpwYuP4Ih+Awf/TH0jfr5iRv4rltQikRXr6WAcM6139uTJHFjXy27bJFYIF13CeRaMEPd7oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npfOG5uG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBEAC433C7
	for <stable@vger.kernel.org>; Fri, 15 Mar 2024 14:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710512754;
	bh=yCAii4u6k7UDf2mCfYs3azGv5SdtykhLrhBD1xm5jHI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=npfOG5uGsT42CXiqG5ONDEM9vZ68ZeBWf16auY8HA8VRWrgFWzudGniSnBGA9yrTM
	 3m1FPI6SswVyFknVGjhPbosK93bBlfuW+1TWCOpqD8IDACvUbc3kpniHU77YxCYhWy
	 A36mUKCMMeWJtoAvDGVi97Hwd4n3ZRLjIxgafRhzhnfBSGb3N7GCjj28jr1eTFi2ZG
	 PPu46Qn+HieDrf/V/40kOS9XYivDzci+1XG0ZhCnRDViHPjp3mehh1BvwjgA4sOR79
	 8rUPX2uJ/HHR/dp9KkD6n7Mrjp+3utzt/g1z0t0uybtqWXWkqhKzKLwXKUcU5JYeDD
	 3wvrpiV+nM/SA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d23114b19dso25246161fa.3
        for <stable@vger.kernel.org>; Fri, 15 Mar 2024 07:25:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YxUsT6cdo7QlHOeXoSKHi7AqC8JFuDu1bTa0OatNkJjaax8EeSl
	c3H6lNnU63/IJVpcvX0P45cHe4GQuU+jBhNF+sOnTy4xgnPWZFN1y8NDO568sFZVCxNhuBX0l84
	JL7aN+CWsPWSQ/PCcTD204n1R4cc=
X-Google-Smtp-Source: AGHT+IFOEzPhwI7bPX7c3aIyx5R9PN+Qx+tidIc3rtmHrgcwyOqKxM31J5bCrIAM16kOU+IuZMMYJQ7o8J9GCNZwefk=
X-Received: by 2002:a2e:b5c8:0:b0:2d4:76c9:2573 with SMTP id
 g8-20020a2eb5c8000000b002d476c92573mr3355048ljn.18.1710512753337; Fri, 15 Mar
 2024 07:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a99a831a-8ad5-4cb0-bff9-be637311f771@podgorny.cz>
 <CAMj1kXF7gaaARdyN=bVuXtJb_S=-_ewAavXHgN4DS36jxK8r6A@mail.gmail.com>
 <CAMj1kXEo-y1DfY_kBhwGU0xMkGp1PhdqGFmw6ToLePiZy4YgZQ@mail.gmail.com>
 <CAMj1kXFmgba8HyZ-yO7MsQBgOGjM10hZKWESBbfrUcjdhq0XsQ@mail.gmail.com> <225e9c2a-9889-4c9e-865c-9ef96bb266f3@podgorny.cz>
In-Reply-To: <225e9c2a-9889-4c9e-865c-9ef96bb266f3@podgorny.cz>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 15 Mar 2024 15:25:41 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGWMOOJwezcOyS1qfAimLHmptUuL=hiqrinLL_FWHpm2A@mail.gmail.com>
Message-ID: <CAMj1kXGWMOOJwezcOyS1qfAimLHmptUuL=hiqrinLL_FWHpm2A@mail.gmail.com>
Subject: Re: [REGRESSION] linux 6.6.18 and later fails to boot with "initramfs
 unpacking failed: invalid magic at start of compressed archive"
To: Radek Podgorny <radek@podgorny.cz>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 15:12, Radek Podgorny <radek@podgorny.cz> wrote:
>
> hi ard, thanks for the effort!
>
> so, your first recommended patch (the memset thing), applied to current
> mainline (6.8) DOES NOT resolve the issue.
>
> the second recommendation, a revert patch, applied to the same mainline
> tree, indeed DOES resolve the problem.
>
> just to be sure, i'm attaching the revert patch.
>

Thanks.

If the revert works for you, I think we can stop looking.

This points to an issue in the firmware's image loader, which does not
clear all the memory it should be clearing.

I will queue up the revert with your tested-by.

Thanks,
Ard.

