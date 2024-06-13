Return-Path: <stable+bounces-52078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E5D907970
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 19:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8334C1F23AAE
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 17:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698A4149C5A;
	Thu, 13 Jun 2024 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jgf3hbn/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47382149C54
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 17:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298574; cv=none; b=DGDGH4T8DkOitfgHmsSV2Ldf8AuHRpEjuW39Cblfzkuvb040xRtGWFkrfraucwaSTyj+II8GWJaBjwmTPeVHZ5WqRi177RxM9qOVjYQNUJX0KeWBRS38rCCZlhdvVw4xq03cCOjJT5/mYUktpLihA+sRrF3LUWv673KyBHleqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298574; c=relaxed/simple;
	bh=dro3L3OTKiADisnYmjVTVIsNtkmJ0Vg0GlldwOjDGkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5IAowQPu0OdjoaMo/m37LVfWZmFlWRmppJbpUgsLvV9qTmu8/ZnbRGtKD23RtIxIABTMZtz3hhysFXlb4fRYD9yBWxZ2dO5DRdVe3G3vy6H6Cf1GrJsX0U0mXnsBxr3KKmds+G2eCnYKCp1dqM7gI09WXtcCe5p6uVJfCwRECU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Jgf3hbn/; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f0e153eddso180907666b.0
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718298570; x=1718903370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yUKnSByiq7IJzswYOJlBbKH9FX6XnqL9Au/j9R0AESA=;
        b=Jgf3hbn/RMiqDr5/467CKsfroUPCQ9VbBnJv3EDMHUroRU6+YhgO8TbFZ2xJqeR29k
         sjbcRFsZzeje5dLJwBPwCEI2sW3RKik4NCTvUhDflynU9pxi+KEteK1Fkw1BHMJ+Ozmy
         yDs8DPrn2iMA6xrzj9zClNpRP25dFmOctbu7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298570; x=1718903370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yUKnSByiq7IJzswYOJlBbKH9FX6XnqL9Au/j9R0AESA=;
        b=hwumpL+xfQhOoxAtT3PpnKonl4Y7vELGVm/5RJYV07SmszQDWnw4M6pdKpXVkk0a5A
         KLOevD0n7ebKtnq3pety3tMInTavYmahOwj6tOrcHvfRtUoGXPDX2+zaRNlE5WIsewgm
         /2vG/vaveSEFizgfQvbfk86iycFNB8q9SjbOOSkqb5ZEKpyB4/s3hKXr9d3LujsNfXHT
         WsNjeghpu8iTaxBPTR5/yyEbrFoi0pGL7VyFatHzrT6/zqUhC5NWOFAMo5GodfEOZDx8
         lNIKdMRlCeu5DpI20i1rfbaUd5GcRwcAsEzO8i0NljoN5GkORcvPqTxJH29wZARFfBnr
         ArXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5xtB642bG21V1crRVc12j+ecAR0JnmFe1kn6S07I59uhkNNpk/FqdMZgs66C2FLjAmZ0ctlX0dmsDYTiIUdXu9z+jYLuo
X-Gm-Message-State: AOJu0Ywz/1Gfh2FPsklqrzHMC3FVgbxzbg0vnzwIHDh5OIAchp3AFmFK
	yN5r9iFK3ak9vG0QxpSSLXx71cw6Kgx0VapRaOPKNf2/TA2WA+nJi+lS4vvLgz7jtfS/iGlrGHf
	eQoM8PA==
X-Google-Smtp-Source: AGHT+IE82x+hQn8YCybAHG7aNJoP6yG96+WOiwV4mi5gPDlfYUBTLzQkCDdFFBqu/kvG7K4SrRkTbA==
X-Received: by 2002:a17:906:174e:b0:a6f:55e8:b357 with SMTP id a640c23a62f3a-a6f60cef35emr29203766b.10.1718298570494;
        Thu, 13 Jun 2024 10:09:30 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da4087sm91891166b.2.2024.06.13.10.09.29
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 10:09:30 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso186735166b.2
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 10:09:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1OBVeW25mA4ar1hO18bDDvKGOr5Uvt9B9f5LQ2SlrNGMv9684xvwAbxjOlf7d/K+JYcCRRKxsstlCZyZNEaINH20bIbQQ
X-Received: by 2002:a17:906:c7c5:b0:a6e:f645:f595 with SMTP id
 a640c23a62f3a-a6f60d2bcedmr25144366b.32.1718298568691; Thu, 13 Jun 2024
 10:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zmr9oBecxdufMTeP@kernel.org>
In-Reply-To: <Zmr9oBecxdufMTeP@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 10:09:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
Message-ID: <CAHk-=wickw1bAqWiMASA2zRiEA_nC3etrndnUqn_6C1tbUjAcQ@mail.gmail.com>
Subject: Re: [GIT PULL] memblock:fix validation of NUMA coverage
To: Mike Rapoport <rppt@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Jan Beulich <jbeulich@suse.com>, Narasimhan V <Narasimhan.V@amd.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, stable@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 07:11, Mike Rapoport <rppt@kernel.org> wrote:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock

What's going on? This is the second pull request recently that doesn't
actually mention where to pull from.

I can do a "git ls-remote", and I see that you have a tag called
"fixes-2024-06-13" that then points to the commit you mention:

> for you to fetch changes up to 3ac36aa7307363b7247ccb6f6a804e11496b2b36:

but that tag name isn't actually in the pull request.

Is there some broken scripting that people have started using (or have
been using for a while and was recently broken)?

                          Linus

