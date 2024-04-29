Return-Path: <stable+bounces-41747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3611A8B5DC9
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 17:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF63D1F21686
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A498823AE;
	Mon, 29 Apr 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CTQtebj4"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A657F487
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 15:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404781; cv=none; b=ZCqqpXlJK44AgaKFNhPqGztmNC//VrfcLPKqMayhuBxRR30uKixQyFZgNaJUInpkr+bSGbQvY5QywIUZIuxsCbEJw17s3/GOvf8a3yW0WGNDfXNgQmtIcXNUNLJ/KIAqb1AgKjD38KGPAiuKXN2HP6tqOXW5U6kviA+ccxqdFws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404781; c=relaxed/simple;
	bh=wDxA9I9+VmVVSI9BroVzQWlSN5RXJEUSc5DnHUzQWGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRO/+LPQOrQGuBi/ksLB+o+hciKt/aihZlC+LQic9uhoI5vmBTtFeuGEp0Imh690+Vek+1X41u5CzyUS1Ov4FIB34Q7HYjgJAdAIhvgczOtO7oF3lO9ZUXmULwAxnhlkQAZvBBCG1xM/3WOA7JbJQ/KC4kNdeSqiUnJgg5cK2XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CTQtebj4; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso5607360e87.3
        for <stable@vger.kernel.org>; Mon, 29 Apr 2024 08:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714404778; x=1715009578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F8YJLjrLtk5N3O9qDCOgLkM7hm+XAZ4QGYxxZrlDK20=;
        b=CTQtebj4ihLIpLWckxpEu4DQFeSjn72SYH9b4eaK50hm9uIrWWY24Sj78wGUnZAoCb
         PN2rvNE9yiEZX9zEWidbtPRNEDSGJvFEk/DdWgNKcuJIcw37uNZCwbEflRu3iK7PJdOq
         FDZ2EswPQnHM4igm4abSTnganwhhmYNqCI9Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714404778; x=1715009578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8YJLjrLtk5N3O9qDCOgLkM7hm+XAZ4QGYxxZrlDK20=;
        b=uqZL1md/0IhZxdZbdWjsfZ910qcczB2r7ofONX1JyUB9AGlFmw9pYRbUz0YxC1Y6um
         XviRPJgC6iLShhmMgMRXLnYR892zYg5m1M0rf7XffwI5JbfGgjtGUcnuoDCTgw9EwU2T
         0igjCrgjsV4nTrK3BTV31zUKCZLkiG5EuUI80CR5W/TJhQt717NZ4OqkXYvJ8+sugmy6
         5IlEjBFZSHvowXwTTKH4SAjiRaJeNqD0qTO25sOp5dKDg4GVcHVOp3Y323SPgSBFDb89
         giOM01kqL/K5/F4VBBt7pkXo/BH6Knhak7ZbHfDhUEvfOpoulIoakHoS0uFnjJOAPplT
         Pkww==
X-Forwarded-Encrypted: i=1; AJvYcCX5Lf1q/pvDw1caJyFrTlhzt5yA8EfLRidXownzqGQwSnsU2lrzbOTcPkUxqIwMHMC2SWatEH9WlrShSpWJgqZ1dJaPBhZd
X-Gm-Message-State: AOJu0YzqDyH7yHyd9WKqVU1kEPsBDwhXLsibYwd5vZ3tIThDlaYEzQMe
	nnyqCaALr2JTiEskSOl7jp4BxXmq0LLANm7BJ16s8PE134tduODufpuHkFFKZ2BL5j/oTjvFEjh
	9SMwqbA==
X-Google-Smtp-Source: AGHT+IHwa6mLleDLs9sBkQGeawR9WZZFWC8mDZMw+LhVN1fW/BQvW97IK+d1Y6ViV6X1LsAlI0BfCw==
X-Received: by 2002:a19:8c01:0:b0:51d:2529:7c36 with SMTP id o1-20020a198c01000000b0051d25297c36mr3491496lfd.35.1714404777699;
        Mon, 29 Apr 2024 08:32:57 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id nb33-20020a1709071ca100b00a55778c1af7sm13908375ejc.11.2024.04.29.08.32.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:32:57 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57225322312so6202076a12.1
        for <stable@vger.kernel.org>; Mon, 29 Apr 2024 08:32:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKh+dQdDCmh5MBAAR8wJeJQeHp7XsuBul8o2d9oBDG307gHZwR4dJSiOCcLqTK8ImAzkmf8q+JMG05HsLdUWvrwyC3paFT
X-Received: by 2002:a17:906:12c1:b0:a55:3707:781d with SMTP id
 l1-20020a17090612c100b00a553707781dmr6533136ejb.73.1714404776259; Mon, 29 Apr
 2024 08:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429144807.3012361-1-willy@infradead.org>
In-Reply-To: <20240429144807.3012361-1-willy@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Apr 2024 08:32:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEMvpPLrzsi6BoH=o+-ScRKuuqxrdWSnrTtGEi=JvcNA@mail.gmail.com>
Message-ID: <CAHk-=whEMvpPLrzsi6BoH=o+-ScRKuuqxrdWSnrTtGEi=JvcNA@mail.gmail.com>
Subject: Re: [PATCH] bounds: Use the right number of bits for power-of-two CONFIG_NR_CPUS
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, 
	=?UTF-8?B?0JzQuNGF0LDQuNC7INCd0L7QstC+0YHQtdC70L7Qsg==?= <m.novosyolov@rosalinux.ru>, 
	=?UTF-8?B?0JjQu9GM0YTQsNGCINCT0LDQv9GC0YDQsNGF0LzQsNC90L7Qsg==?= <i.gaptrakhmanov@rosalinux.ru>, 
	stable@vger.kernel.org, Rik van Riel <riel@surriel.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 07:48, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> bits_per() rounds up to the next power of two when passed a power of
> two.  This causes crashes on some machines and configurations.

Bah. Your patch is *still* wrong, because bits_per() thinks you need
one bit for a zero value, so when you do

        bits_per(CONFIG_NR_CPUS - 1)

and some insane person has enabled SMP and managed to set
CONFIG_NR_CPUS to 1, the math is *still* broken.

The right thing to do is

        order_base_2(CONFIG_NR_CPUS)

and 'bits_per()' should be avoided, having completely crazy semantics
(you can tell how almost all users actually do "x-1" as the argument).

We should probably get rid of that horrid bits_per(() entirely.

I applied your patch with that fixed (which admittedly make it all
*my* patch, but applying it as yours just to get the changelog).

               Linus

