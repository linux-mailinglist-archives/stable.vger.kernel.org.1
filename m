Return-Path: <stable+bounces-7977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D594B81A13D
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 15:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A94FB2314D
	for <lists+stable@lfdr.de>; Wed, 20 Dec 2023 14:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A103DBBA;
	Wed, 20 Dec 2023 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OHQPpxYe"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E43D992
	for <stable@vger.kernel.org>; Wed, 20 Dec 2023 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3333b46f26aso4861879f8f.1
        for <stable@vger.kernel.org>; Wed, 20 Dec 2023 06:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703083147; x=1703687947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f2oUpPP2PLyXV8nPq8H1pk05VlePtZv14Y6rjtd2zCg=;
        b=OHQPpxYeWLJGbaLz8p4BpvQ7NyjQlaTkaTUXBQAJmGat/HsrBblxEiurb1sc8sakWX
         e3lNb0YVh3gmpab9htQuUvGKOeA6SJN6cKWFvn32zxzbh8c+WHYLhSQQVeOImlBf2vds
         8WA/IlsZzb5KMh2e6A+jmmhwSz0J9bZOQSAehYkyBMkR/LgMpB5TLhwqnpjTzsPVkwrC
         bfcXv7VWM/UEURiVSYwtiYkFJM7rQ6BhWcTMt+GYL6J69Xe6sRQNkNy+COYyqxckmB6o
         8Ec5pE5aTqNXMNg4dj4Lo/w5H2Uyu8snvlJ9demvEMwQCDiL4w+x0mXPxYlYagZGuRTt
         BPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703083147; x=1703687947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2oUpPP2PLyXV8nPq8H1pk05VlePtZv14Y6rjtd2zCg=;
        b=TiFOGq+2jy19wrnXTzgoPRC64Mb82dbfOoGO+rUL07OPVWIB6ltrE1m/hg8pKI1SUn
         PFxujvvhV3p8fbSI7JfuvBPJHzr+gfAVPYnf/9U6yi0vxZft/EJR9zPL65Tyy1V3Azw0
         PGtgwZoH02NmHFYC0V1f4k2e1GRPphU4oNjKs0YpFFPNycfLZLItz834W+sJXT7XLR9g
         8rNQnwN/i11SH9qZjC2T3DTfl8jly2n/Tk4ZBDQMBqig4cR46emUrJf0WDHw2wwkFQMk
         KjqXcHGbj2P0pKMAydw1zI2lwzqVX32UJ7sfaZ7DIkB9iIkqlxH03luHKfP6RRbIo93o
         sIgg==
X-Gm-Message-State: AOJu0Yx1+YKil8oMbeUO6o+OXlTODGF1qavossv8Y62bkTPzS0QceQ20
	LyzhPI2F4WhsGk4ijtAF2QMj/dLhNTrCKx2n8o1gey7qkrekdL3Zqzlxuw==
X-Google-Smtp-Source: AGHT+IF8K6EUmmfn1dSorG+bifQbkbItpBNPjm2gICGt2CYz8CKW5ogpaRIJFGwGAo1cEwXzCcejyo4bDjcnYdjSwOs=
X-Received: by 2002:a5d:47c5:0:b0:336:5b5d:245f with SMTP id
 o5-20020a5d47c5000000b003365b5d245fmr5663984wrc.140.1703083147437; Wed, 20
 Dec 2023 06:39:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com> <20231219090909.2827497-1-alpic@google.com>
 <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
In-Reply-To: <CALcwBGC9LzzdJeq3SWy9F3g5A32s5uSvJZae4j+rwNQqqLHCKg@mail.gmail.com>
From: Alfred Piccioni <alpic@google.com>
Date: Wed, 20 Dec 2023 15:38:31 +0100
Message-ID: <CALcwBGD1hW4RJEpm6ABgEA--0RKkn1U9O5mBPL1g3B4Hw+0gWA@mail.gmail.com>
Subject: Re: [PATCH] security: new security_file_ioctl_compat() hook
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>> By the way, for extra credit, you could augment the ioctl tests in the
>> selinux-testsuite to also exercise this new hook and confirm that it
>> works correctly. See
>> https://github.com/SELinuxProject/selinux-testsuite particularly
>> tests/ioctl and policy/test_ioctl.te. Feel free to ask for help on
>> that.

> I do like extra credit. I'll take a look and see if it's something I
> can tackle. I'm primarily doing ad hoc checks on Android devices, so
> I'm unsure how easy it will be for me to run the suite. I'll get back
> to you shortly on that.

In response to myself, I unfortunately won't have time to do the
testing updates this year. If someone else wants to help, that'd be
great! Otherwise, I'll take a look next year after vacation and see if
I can take a crack at it. Thanks!

