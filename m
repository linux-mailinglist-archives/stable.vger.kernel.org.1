Return-Path: <stable+bounces-35960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8408C898D68
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 19:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F45E290A04
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 17:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483D612B163;
	Thu,  4 Apr 2024 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ExTC2ZvU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03A12CD9C
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252512; cv=none; b=Tpm9FZAYupRmOWj10fiWgjlmVmMFvYUmIS9KeBc0EUecD3XSE6he1h0Ll8y9lzUW87RhdWnoD3d+MEIx3qpOwmjvcAyNi2Z1gtrdJ8SAcy0/cIZ4+CD8QYnuRCSBCOUAeuld5iyxg5Q1VaRprTUZ/0ZFkg8G1fvJlhNKFr21BYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252512; c=relaxed/simple;
	bh=QJcrvaUqNeLSD3sP8oKrhHn1V+DtHQD2tokKy7lm46k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A5fX0KSac4prIaO6FgNjnVGPE3PYa+JfmoWkclkfNa/+qGbPA8JzLhJL5lXnHMkCvO186mld0MGd54Ur/3LUPmojJ+hi6Vv84gLJfVFmxvmLKwCfmiARbtEdzidHrlc7plg5H4KERHZlxDSScml4ays9PpG4c8pS+5x7oW3dlk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ExTC2ZvU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a44665605f3so150702866b.2
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712252508; x=1712857308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VN0b2tawtHaPUNX4wk3tslHJG7emspSlRs8ITmny6iU=;
        b=ExTC2ZvUoju5s28WtB8h+fG6wSFVsIy4Z0yd6i/oBtpdkboj/YeD49FEGYZ6oDz98M
         3FmkSerCbtpmZmFXaIG7R7FTQbAAUBQHGp3IpEQMW2MQnd/Q934HpNyFvK+mM0E70bZM
         BY4TObbR1KMalcKKu5TJtBMMYtjl++A+1Wgqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252508; x=1712857308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VN0b2tawtHaPUNX4wk3tslHJG7emspSlRs8ITmny6iU=;
        b=JMBtZ8jfIok9acCPNqWwZmTcL28mYIszOw4WBWZy9JgVriX2bNwsJmCbwsSXp3ZNrh
         PzWxauvF5xfiwtVsU/l1nBlTlMT9UpLEotqkJ4irp0X9Y0c3m/tlcepBYnZwOHvtpO66
         5sDNnNqxD9gpaOBAfdyxitVYXpBnoATF3lGzZdWlPHVOOhLviHzZQ11YwLfmxPV6CA0H
         KZVXCJBsYu/wM5GArRm+IM9v9z8cXasGLlLYyCljVQ4DceLOIvPoRGqKBL+unHoRp7TT
         H0r1zGX5FQy23hVxHriPlJ5jrABDq/nKRUcQvVzuEpFm/8GJYqbMN3pRqMOwoRBEKuiI
         cYHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaIXg+r1pGns7yVyMViunjavjVAMF+w7MJdLQNsQdA7JtIh08/Mn1Q9rL01qWzoeKffqjfL6epFPmnEn2FcbWDcll2iOHE
X-Gm-Message-State: AOJu0YyskfuPmw0zreU9vlqcAugWleLKMfpJo4NdTsVq8on1BGlBZ1TE
	RJmJ3cjXAUSaeh/ePA/N550dzmO4UhFL3BgmqnQeMkah/B14yoK5pueITkRb9FVCMwWrsG0Wtpx
	gc6k=
X-Google-Smtp-Source: AGHT+IECHeaO/t0CoyHxZ0KXRlE6L7Hb9GucNDkkVCMJcjIPqt1aBzI6yhjYCLQZPDdRKAEqyyaetw==
X-Received: by 2002:a17:907:36a:b0:a51:9197:a2cf with SMTP id rs10-20020a170907036a00b00a519197a2cfmr1077709ejb.44.1712252508505;
        Thu, 04 Apr 2024 10:41:48 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id xd2-20020a170907078200b00a4e2e16805bsm8578800ejb.11.2024.04.04.10.41.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:41:47 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a472f8c6a55so178998166b.0
        for <stable@vger.kernel.org>; Thu, 04 Apr 2024 10:41:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRY3X3GUfR290NmZlv4mC5oqsDT9NXCmgZEhJDygjv1GLOGFdhf0/R9cmo5JGz8P8UhITy9QcPHQu2JVhFErlbXlRyzyyc
X-Received: by 2002:a17:906:710e:b0:a4d:f5e6:2e34 with SMTP id
 x14-20020a170906710e00b00a4df5e62e34mr1762782ejj.19.1712252507413; Thu, 04
 Apr 2024 10:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152549.131030308@linuxfoundation.org> <20240401152600.724360931@linuxfoundation.org>
 <87v84xjw5c.fsf@turtle.gmx.de> <20240404095547.GBZg55I3pwv8pttxHX@fat_crate.local>
In-Reply-To: <20240404095547.GBZg55I3pwv8pttxHX@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Apr 2024 10:41:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiiK8qEZ+PkOzeEpguxB18XrfcHGcSMyHzFtA30PvZP2A@mail.gmail.com>
Message-ID: <CAHk-=wiiK8qEZ+PkOzeEpguxB18XrfcHGcSMyHzFtA30PvZP2A@mail.gmail.com>
Subject: Re: [PATCH 6.8 387/399] x86/bugs: Fix the SRSO mitigation on Zen3/4
To: Borislav Petkov <bp@alien8.de>
Cc: Sven Joachim <svenjoac@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Ingo Molnar <mingo@kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Apr 2024 at 02:56, Borislav Petkov <bp@alien8.de> wrote:
>
> https://lore.kernel.org/r/20240403170534.GHZg2MXmwFRv-x8usY@fat_crate.local
>
> Once Linus commits it, I'll backport it.

This?

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e110732473e14d6520e49d75d2c88ef7d46fe67

already committed.

           Linus

