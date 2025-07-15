Return-Path: <stable+bounces-163009-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D58B06488
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 18:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6954B561EB1
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A0279327;
	Tue, 15 Jul 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SI3kAVwt"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2B27876E
	for <stable@vger.kernel.org>; Tue, 15 Jul 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597793; cv=none; b=WUq4S6lglhqge+/PE/QmxPFmqUaucVYqdQBHptwfOI88d7khQjH2P2EyglZk/4J8CwMdfSJE0B7QFO9VrUvMUVNmFlOyE6cYUKnJAIwCN1e8hTtIEJ99VQp26JhfDG7W/ggePuah9F7dMmOVrhuJc4EGXIIk8TbaSy1usbYvImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597793; c=relaxed/simple;
	bh=OZLBdP80AuAPBpQatgV4tnOFj5nsWaDVvWpCLDIyI1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cojWj0PgLoTBQdfC0wOXV1mrhegf8c1gVOPR8B4Ip8ZboWu6YikPT/Pa3JJGvQqs4mFMl5g5UtfAai7xlr4IS+24f47FSmS57pQiNm7vb0iAJutdf/ssB4ajof/n75rd07mIf2nacjp1rB5zVWW5piwcex/enDigKC1FRwLnTy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SI3kAVwt; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so10473200a12.0
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 09:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752597790; x=1753202590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46zpS+UQ3AzjYrdMtZXy87Fu+5mO7Am2ZTQb8NQ0ZbA=;
        b=SI3kAVwt4n2o1Aq3Hv+RmcxE60FVsLNTY25pw4y83pRPZN+IX1Cj1r8I5mooJ5zAs0
         zmC3mZV+tFEk/UqEF5Sy8eGCWQ2JCuGnN2ZC0y6kwvgGl3ioOoPy/GNX9tnydgCrzEL6
         Fi4b03i+ljxj35R8zMEfjAPKibfDra9z3dx5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597790; x=1753202590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46zpS+UQ3AzjYrdMtZXy87Fu+5mO7Am2ZTQb8NQ0ZbA=;
        b=rigRvTDMs3+QpeDpDJ3/VglG4GteDqnolfGqv7OZenBOUeOnca7DbZDbrSp2x6bDpa
         KB3hKv8fJeRm609KOVDCtNMbG6/xxkWbpQTj4hq+dwEojjoD3eyYAEvr02dTOkcArMBs
         aocJQmtsHgKPwtT9KtVenLXslkXwivJ+P64+ha+kdfCFhNGSkE8LMZa+2zcYcL3kghHC
         RcFvP7CKP1fLq1W/5VMetCjIufNrAjVxiVSXmFfiNYuUbDCrhFT0/3NVouJC0huUwUBD
         noCzJBLVY9UYHGNyUi5mzcb2d/CYXSMu0qccvI0Hcqi6WdvTjCv0q0dMA/2Y6w3z3rth
         fnRA==
X-Forwarded-Encrypted: i=1; AJvYcCUbbRhxr37f72/ErP/uNe89HqmTj24kF3w49mUlIyCCCp+Koq9fyDgEFLgOTlmkdbdETYQrM9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpKd7acXiaMrNPo/VbG4JF3o3HmYbCDye521rEc1YDosjaX5Pu
	WnApX5qt4ceye3Two8o4L78Da+irlRZPv1PebbZhi0WxS8OBrrETlRBWTos9gCJTEm19lP1jG4v
	6VoTyDqo=
X-Gm-Gg: ASbGncu+n6KDuI5aIsJJ0FiJUmGGGvY1kYu39w0rOBd8n5Uul45EHUk+mCD1GKpIhAc
	cbMcuzdiV6ve40D5PG8U/7g3ejOTCT0Gs+i8Nh9c+OkkmhaYmtqrxGvjpNHU5IO4oApL36ACZ3R
	EqTPKgA6sXNOCKDLvX7r1YCWtjK27DjYePvbe7TqKJW/te6onC8obh0gvqip7kfpH4iC4JE48HA
	v4nSOlkeRhnilJzri5qNZcXTRRba7mTBN/F5BuL9kZ7veSGNB9QHuRFFy4r/FSGbD7B1zFrcqlY
	0nw8vX3jmIeCYuFR0KItOpS//tEANh0T4zIfk2y2DbJ/PpOUypaqYAv3c6e8bnIDyb4wxX+Sbci
	dflJVEOuci+06R2gUD/Mveqy++PXY1ca3ok6ojc6HPadEP2fnhxwxmJprxdhRvEj50Jmh7CZinA
	YkTIQzEA0=
X-Google-Smtp-Source: AGHT+IEIrgAGU/WReWJIuStHjnMximEKVuCGOyFjaCa3RI5XeeDwHTQt54l7M/wa1KPA4OifSeJ/mg==
X-Received: by 2002:a05:6402:3549:b0:5f3:26bb:8858 with SMTP id 4fb4d7f45d1cf-611e8613dffmr17621839a12.34.1752597789748;
        Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9543144sm7518680a12.33.2025.07.15.09.43.09
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so11728120a12.3
        for <stable@vger.kernel.org>; Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrQGudwovpiOZuvb8sdGJUxHpODEWBUOYQ+rBLXA3OXObSweuoM1tYUhweFhRt2a01xu/2R0A=@vger.kernel.org
X-Received: by 2002:a05:6402:2686:b0:607:f64a:47f9 with SMTP id
 4fb4d7f45d1cf-61281f226d2mr26921a12.3.1752597788853; Tue, 15 Jul 2025
 09:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752581388.git.namcao@linutronix.de> <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
In-Reply-To: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Jul 2025 09:42:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
X-Gm-Features: Ac12FXwEFq81tRpxQQo-YtMJ6UxIp_wzb2appHmE6OGEEPULt8cuT-X-Zaqr3nQ
Message-ID: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 05:47, Nam Cao <namcao@linutronix.de> wrote:
>
>  fs/eventpoll.c | 139 +++++++++----------------------------------------
>  1 file changed, 26 insertions(+), 113 deletions(-)

Yeah, this is more like the kind of diffstat I like to see for
eventpoll. Plus it makes things fundamentally simpler.

It might be worth looking at ep_poll_callback() - the only case that
had read_lock_irqsave() - and seeing if perhaps some of the tests
inside the lock might be done optimistically, or delayed to after the
lock.

For example, the whole wakeup sequence looks like it should be done
*after* the ep->lock has been released, because it uses its own lock
(ie the

                if (sync)
                        wake_up_sync(&ep->wq);
                else
                        wake_up(&ep->wq);

thing uses the wq lock, and there is nothing that ep->lock protects
there as far as I can tell.

So I think this has some potential for _simple_ optimizations, but I'm
not sure how worth it it is.

Thanks,
          Linus

