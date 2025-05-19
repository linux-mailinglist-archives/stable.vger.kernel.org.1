Return-Path: <stable+bounces-144795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CE8ABBDF7
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 14:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7F817D33E
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC32278770;
	Mon, 19 May 2025 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWZAF9mz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D107527876D
	for <stable@vger.kernel.org>; Mon, 19 May 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747658142; cv=none; b=EzTNp80MqK38Z8WTr/64CIddjcffbV+Fu92W/1jsEvj3+t51JiV/w1CTo/yzO1/UBHXuN6cc3+Csdh0nJcoOS+4MhjKHYlnmbuZ4RyC5hYeoypzLW3jrObCSlBT8qBFlwJhZYy7JXON941jTiOPUl76aV4aHT58AIjEWGArgJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747658142; c=relaxed/simple;
	bh=h/jHKw3kD1UoLZdhvu9N8CX7eVHnHrwSEacWRDnO27c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E8Odub9/cETl9OzRGASHofEdvoaQ/NIOkfBQCaGGCzMjGL/JGVzvI/Dgvg47lcKHQ+d37E5w1g1AeVdD5Z2WRvhSDSB58XBYSsvG3tHcGtZ4zgRTDa0cGcu4kkKnG6GJWuItQ+t7CiK1CnF2lnTt3fs5ncb1UEk45nt9/gXFXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QWZAF9mz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad5297704aaso655756466b.2
        for <stable@vger.kernel.org>; Mon, 19 May 2025 05:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747658139; x=1748262939; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jaqnelmhXDMJ9MVU43vitj0wc6YSbcEgfnfp1MR4UNk=;
        b=QWZAF9mz6/OFydTa06zC4q6DYcEoelDrhUQqn2IYfcypSTiQYP6MURflYZNa9ZpyH+
         xkqC52LDP+7+tifGMw7LyeYOMvmNaJTIEtn7LFeWSXwFbljSaxP9vExt3we0hvbIJ6KT
         klp24sA2wC7+RGAm+7nAztxOe5Mz6pYnH97yjW3op/bEEbm6VcR25GsaxTOgw4hqigs8
         FxQCtneal0T3eoK8iUhmBYDijvIQALlwJcyqceNMZrQSDHeGspk3ZA0vM61SBBeb6AyX
         e3IdJmfvOWj0dT+71OXoOfB3mbetYoO7iCDQhJgTRuX6liUXMEIseT42Xf7H2RXV/Wj+
         ijwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747658139; x=1748262939;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaqnelmhXDMJ9MVU43vitj0wc6YSbcEgfnfp1MR4UNk=;
        b=KZu0Rek9I1W4FB+roN0b+qYFyAFdT9oah53UyddIRfdK6/5CoVEaCcRUX2WP/48Fld
         hIOzbvJ+oKAxyaGZBi3xrSY8uMHCRMMMttd2spHVRsfYJVQpEHMMMIafRPr9pud1lVxA
         yBRfrQKZ7L7F4m73M5KBs/yojam2f5rG6oyBkhQvsM/9oM5Ieu30kFaW0Dg7gEn2mROD
         v2Ax0qmSvlT0We/ZmeU/WxxnQJ8B+kNa9EY+dnQUZubLUm3qhFTj0gE0QR4rw7RUFtu7
         0FwoerILagMS5lvPjWVjkUzFNw7ynTEOFnCX/vYnKBtXeu0skQArVOTd6vfjJS7wZQRw
         ENrw==
X-Forwarded-Encrypted: i=1; AJvYcCVcWhUsVrMTKHidUMm/I5wtu9Set+mFIKYyRq/c9AAKb0RiWe/2BA6PNU6FgphF2BCteBr528g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdw3VGQFAitRztAoJmukrR54tClCP5By9TRzuqSLdwuJtBOTa
	m3D4f/0ly73eTEKFDOWGT2E0hytE/4Rsbm8j/9A3zo6rW9gkubn1gxRrg8QMqam/AlvD4orqCCC
	oNheQsynY5ElGZjlM9/1eMuPpWUabZr90Tv+PZEMX+A==
X-Gm-Gg: ASbGncuFat3uvz6aKYE1hRFrvDsfbWDLbzm9dhQTYApTfC5TfwYIDMGSt/6/YrImqDS
	83ESS1ux/vgQe/vV+TPphj/YJcukz/WDRIDy3XQwObVf8Bq8+MS+THB1fjMr71Gur62y9J/db/3
	X5fDU2pwVPEOv+Db3rJZtbUmNAm6/sWvfCP3EjyPezCUqn31OZfIxeMtXpDeNrjQ==
X-Google-Smtp-Source: AGHT+IF4eIqhtrc+6I57JtzN8T69+0a5kBByXRsTt5Vgm1fGY3uwK3UwQBXHYFy3TDCpoGVeZtntfDbE3hCBM0igRZg=
X-Received: by 2002:a17:907:60d6:b0:ad5:211e:8cff with SMTP id
 a640c23a62f3a-ad52d5ba7b7mr1057424266b.37.1747658139023; Mon, 19 May 2025
 05:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250519092540.3932826-1-limingming3@lixiang.com> <20250519093857.GC24938@noisy.programming.kicks-ass.net>
In-Reply-To: <20250519093857.GC24938@noisy.programming.kicks-ass.net>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 19 May 2025 14:35:26 +0200
X-Gm-Features: AX0GCFtwAPx-On4jvEu1RgfjZ7x8W6B4v1YRjdYURF1h2r811b2tPgdoSKyBZn0
Message-ID: <CAKfTPtB-fjPH+=EBbeZvvWvOdbecVJvPzmNB2sQrAM4H0gL8Dw@mail.gmail.com>
Subject: Re: [PATCH] sched/eevdf: avoid pick_eevdf() returns NULL
To: Peter Zijlstra <peterz@infradead.org>
Cc: limingming3 <limingming890315@gmail.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, limingming3@lixiang.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 11:39, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, May 19, 2025 at 05:25:39PM +0800, limingming3 wrote:
> > pick_eevdf() may return NULL, which would triggers NULL pointer
> > dereference and crash when best and curr are both NULL.
> >
> > There are two cases when curr would be NULL:
> >       1) curr is NULL when enter pick_eevdf
> >       2) we set it to NUll when curr is not on_rq or eligible.
> >
> > And when we went to the best = curr flow, the se should never be NULL,
> > So when best and curr are both NULL, we'd better set best = se to avoid
> > return NULL.
> >
> > Below crash is what I encounter very low probability on our server and
> > I have not reproduce it, and I also found other people feedback some
> > similar crash on lore. So believe the issue is really exit.
>
> If you've found those emails, you'll also have found me telling them
> this is the wrong fix.
>
> This (returning NULL) can only happen when the internal state is
> broken. Ignoring the NULL will then hide the actual problem.
>
> Can you reproduce on the latest kernels?, 6.1 is so old I don't even
> remember what's in there.

Wasn't eevdf merhged in v6.6 ?

