Return-Path: <stable+bounces-180457-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F5B8227A
	for <lists+stable@lfdr.de>; Thu, 18 Sep 2025 00:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183711C80EF0
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 22:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A8130EF8C;
	Wed, 17 Sep 2025 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rc1UCYpI"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF4530E82E
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758148124; cv=none; b=iwC0ojWpdgAXrLUsW0AqOURdsttM/Z8G44Y19osMdGJ5PA2L0p6g6oauncZ38mSeZomqip5itMUuCjgkwHClW+p0/tvJCJdWlsLxiq0nj03J9nP27VywQV5KbwygeiN56taFJsIzDC8yV+jpIQ/g/D8G1XNWyeEOXNVZALPglo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758148124; c=relaxed/simple;
	bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AL9Ejz50MS0GKCewsTDA0oEg19HK5kxdddAb83xnvHVTIkk7fK10jgVyZx8Y9KjzrMsNlH5il6j8J0nctJQTz4X7bT6odHunsarVZyV0YqTMTC0SqRC1IBHrYe3teG88uc+xsvxrRal6cLrYmeibAnfdFa2/6dDHh04HF+qQNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rc1UCYpI; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-70ba7aa131fso3003666d6.2
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758148121; x=1758752921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
        b=Rc1UCYpIeZiBs7TWLP8eGp5TdgEs9GX8HR7TEJkNSpe4d9Y4sl6BNDCo7fILWFSaB/
         cHMGHwTpul8dnIbf2xtdYjB+Vy36OhURIQHeDfcv82U6BqVldxLFRC9QUWj2a85d3Wno
         HVztqkNJZ5RwceTZ1fd94nUlq7n1vOs/BS7Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758148121; x=1758752921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FibkJLFpdmPs16TWPQcjI1FEmw5E/LmUaqG65SaId+U=;
        b=qB1WcoDOzmayHEcEA4OLiqApZYe4hobtWozkbhPczChmnpyCB8jmCN4UNG2xUta3/k
         6dkYf6bTvPqr+08aRPjAGP9EKf0Oja7OIT0+ERdF9c26X6T58HzL0PqzzF8ylUCNAz3v
         pGTYOib/KuVQ8Wyn1vBM6kH3oiwV7m9pMoxJx6EEEUHL40ZUFcCJ+q8YOYAk+A8bcE5G
         I6gB4oCK5KhzDTmKUdG8JRK6SSKE4pY36HKY6u8Pd0XBWImmkIFnpuKVmMy9OFoAxydP
         XjhBI3FoXzbm8dHKUqW2XKK4HRHvSHkr/JGftHcV1SHT0a75atEHpfjsibTSPgslbe+v
         Ztdg==
X-Forwarded-Encrypted: i=1; AJvYcCUE0pxSuui//CFdZJ62TskfHL4fX+85xmcD5fYI+ZWGSthn1x7sk77UCZmMtPgiIrIRwlmTSvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXhRELQc3CfFmZ5BMee5lslhCZAqWvvIwd2aAvnDPuoX1tuVgr
	uA/eMi8i8t1Uf5wPfzq8t3Kczyzd9wQQvkVPQJYU6nsGTmJSrWWa3/IxGsXY7dTQSIksip81c91
	0iH4=
X-Gm-Gg: ASbGncvE709QxV5uEey5imfgpTzBTv1UvGaLdwfY6YHL6tksKLjsY7kfhy8L86avn3U
	kbWl2t8YLib/1ldC6wnE3uxqHobapYTuzZoxUUW5HEPMhRvDPYgSyrf+4K2MjCyyjNi61kYGr98
	zVLeJJBqZKhcEZgk5J2RTg/kRUGfsE5SOCouaQdAPr2xgUsXcrMZWe/+xWdcTk8ou6ljZ1QYKqw
	QBLsGZbAUNp9rRlMzIosE3SLNvbcoAUXC+7uoaSv/lxUm8enQmWcsUv2RlpxxKhMPng2/N6FBX3
	mTbLtIaMzULHrYj8Bo09ukrx15po5AneGFEKYSXQ9AUbviHlUs7eeI5Ji+1P8K3SDXDthEQedKB
	p3e6xyOsGkLWOL268/HCH+ZE2F43xfvyTtIm1Rc7bJ3JmHJa614Be4sJlTp621ipRVgLOdAZrpA
	2ZP6J8tQ==
X-Google-Smtp-Source: AGHT+IE89f5xeZZ+DOMbcSOuCp1YJ7SqULDY2sB4o753zG/ofPF0x38X7gx0MIaPWrzdMgBQhNx3KQ==
X-Received: by 2002:a05:6214:460a:b0:78e:d1a1:2331 with SMTP id 6a1803df08f44-78ed1b066a8mr39864936d6.12.1758148120673;
        Wed, 17 Sep 2025 15:28:40 -0700 (PDT)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com. [209.85.160.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79354c9eea8sm2760756d6.61.2025.09.17.15.28.39
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 15:28:39 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4bb7209ec97so57921cf.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 15:28:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViGylpgV9KVf8xPduINUYJlqidoWz53zcn1hYeIYT1+5eStUX3lXhbbckHVB3kUmU3n71S268=@vger.kernel.org
X-Received: by 2002:a05:622a:290:b0:4b0:f1f3:db94 with SMTP id
 d75a77b69052e-4ba2dbd91e3mr7888171cf.5.1758148118686; Wed, 17 Sep 2025
 15:28:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com> <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
In-Reply-To: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 17 Sep 2025 15:28:27 -0700
X-Gmail-Original-Message-ID: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
X-Gm-Features: AS18NWCUMtpdk9H0fWidPAaF1Bc8oxlz8rdMZKPuVQEPlj7Pq_GvycrjQRByVOg
Message-ID: <CACGdZYLByXsRruwv+BNWG-EqK+-f6V0inki+6gg31PGw5oa90A@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 11:03=E2=80=AFAM Khazhy Kumykov <khazhy@chromium.or=
g> wrote:
>
> One ordering thing that sticks out to me is
(ordering can't help here since we'll rapidly be flapping between
ovflist in use and inactive... right)

