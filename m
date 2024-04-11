Return-Path: <stable+bounces-38048-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8351B8A08A7
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 08:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50961C21475
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 06:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C9C13D613;
	Thu, 11 Apr 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBO9BYzQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F013CF81
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817829; cv=none; b=p2XZqiXKKtshO8fyzE27k9Kgl+gKCCjaPGgHSw5gxH5B/OzQIxH1VLeJ9Zhwk6IE9Q9AsB7dhdGPkFHGdetfTpbMMcsr7QQ7K55aje9yeFMgII9zwerrF9hnuWgMA1iF89FmuxebQ9hdgS3XKIqAG4B+o/RDTh+RiLUHMJrgnB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817829; c=relaxed/simple;
	bh=XZLDi9yMfdD5htl6aTLkBdQoyDg1JHq32SKqeXhS3V4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=rrUkMAMmTM0fdP6diddXvtcIYjBECe5KXCXSglJInURNg6vWMc4vtS7zExAJAe4muKH9lDPQR+F0oegod9zzD1zazWieJ8DFYMwEwOi8F3hpd8KLm+spPhJ00m4FNv6iKoAQOrvr2hlYYCQV2GwzWT8L8I9x0ha4McfLBSdOL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBO9BYzQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DBAC43390
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 06:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712817829;
	bh=XZLDi9yMfdD5htl6aTLkBdQoyDg1JHq32SKqeXhS3V4=;
	h=From:Date:Subject:To:From;
	b=YBO9BYzQSACRZ4ZNFZPilcE+ZeVvtYVw+52tOYIwh832B3IW3oCQYGEsH4Mg4CnZ0
	 I7A400X1GrA2aJXJ3IC6XTxZFgtfLHDqQxIh6vsebt+k/g6qj7koi3zVnULqlBJXmm
	 apKNu8qze2WEC/JmD7bBItW3Gs+sBfKb8+tIiScNyyMYN4jzh7I6ClFQn8zxpz1j5R
	 YR+m6JgYWULc/eHIqaLS6IJXAQYA+kSoqfJoJEHtdBZxyARfIQu/uNOEKnhEYmwaE/
	 GIxbykelgis6GkbqpIOB+RhXVpEX3kqWUcjsVmImo+ABFK62gQOr2WuvVAF6Yr/Uoq
	 yJ+H/C/ej+D+Q==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so70875841fa.3
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 23:43:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YwwFPltaKJGd/byRogN3XSaAgruYjgPU+/QPjbYqd/SkF/JENQX
	tm1Qz6yTsiPxvG1NLmmHVP7CYesWJGahrHYh6rmlk0S8rh8IvYTytfL8vUWv1zJizP6vughFOH6
	ca1N2X+b9PM5hulqkiBb8gzLn4vk=
X-Google-Smtp-Source: AGHT+IHlH7Vf5XIQbbs9aRIiH37DnhWFQne7MxpwXfCYgwPw7tPCz6m46OataJqOigON7akZxr4K3ZC+VDuvOYauQyA=
X-Received: by 2002:a2e:91cd:0:b0:2d6:b0b5:bb12 with SMTP id
 u13-20020a2e91cd000000b002d6b0b5bb12mr3339259ljg.18.1712817827177; Wed, 10
 Apr 2024 23:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 11 Apr 2024 08:43:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHi=hF=Qb1rQZ941TBA5v1H39+NRjqXU=o=aB=7AH=uGA@mail.gmail.com>
Message-ID: <CAMj1kXHi=hF=Qb1rQZ941TBA5v1H39+NRjqXU=o=aB=7AH=uGA@mail.gmail.com>
Subject: v5.15+ backport request
To: "# 3.4.x" <stable@vger.kernel.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

please backport

e7d24c0aa8e678f41
gcc-plugins/stackleak: Avoid .head.text section

to stable kernels v5.15 and newer. This addresses the regression reported here:

https://lkml.kernel.org/r/dc118105-b97c-4e51-9a42-a918fa875967%40hardfalcon.net

On v5.15, there is a dependency that needs to be backported first:

ae978009fc013e3166c9f523f8b17e41a3c0286e
gcc-plugins/stackleak: Ignore .noinstr.text and .entry.text

The particular issue that this patch fixes does not exist [yet] in
v6.1 and v5.15, but I am working on backports that would introduce it.
But even without those backports, this change is important as it
prevents input sections from being instrumented by stackleak that may
not tolerate this for other reasons too.

Thanks,
Ard.

