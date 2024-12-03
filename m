Return-Path: <stable+bounces-96289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D6A9E1BCF
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 13:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95F39B3F7F8
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BA81E3793;
	Tue,  3 Dec 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN1DKp96"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33831E3777;
	Tue,  3 Dec 2024 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224985; cv=none; b=L9osZMQo32ScRTJVybnKMbX2WZHEXZvnX7rLoKAn+QeUufJ27pNf+pdTrs9llfn6pIeUN6CQSNw1gBCBlA17tQe2EQRc2/g6yh++lP7YdZgkStifIwduBGPmol54DkFqeUO1IcMhvuAmXdiqzoGz/QTPvjGLfOyzH2QVtFByv1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224985; c=relaxed/simple;
	bh=LWrHeEAcDdiZ/xoyrOTd94Gq02Fz5NLIsrn0bqh7X7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OyYyeOGCIVJZ3IvVfjqQqwNtaLwVlVRRfJWyLzlweimP9T1fqKqBz4e2BPpHItvWmJTuvSsGkF57+C01HDnbCXr/CQkCtGy21zu0oLSSYV+ru0rkCbWi7gbaUwp87H4IMzYYFyAnBm0EwBMmSy8aPxsOLm7qbrqUhPiwqMZQ5+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN1DKp96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7767C4CECF;
	Tue,  3 Dec 2024 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733224985;
	bh=LWrHeEAcDdiZ/xoyrOTd94Gq02Fz5NLIsrn0bqh7X7g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WN1DKp96SqgUh3Uljzsv+QiuDSYm4DYXnmN9ZJgItrNM9Lnf60MeEQsDgLukPxtV5
	 pZf3TLeZqxGGrnS3L+meY0jUphgKjmo0o6pEkX4LSwAxqJwU+fg9AgPQhJJOZKGmpH
	 c46hhoFOjk9jsoqV0AwDs7L18fSJxCuULDC51+20VV+vthi2d78Nt9kEzNojpVETcR
	 7vNKlJ7ACEHHrh+yCzFRpAOwATfIXKJ1RQAvTNqFWVMPynBmXuZoGiEjebnc/I1Smf
	 tG0WMbratU6QeUNRyn0vZri0r7BXi2cbbXClkkxzX9qapOE76fcRdvG/m+nvnTLrUX
	 2TTSJoJYBkSCA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Celeste Liu <uwu@coelacanthus.name>, Oleg Nesterov <oleg@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Eric Biederman
 <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>,
 Andrea Bolognani <abologna@redhat.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, Felix Yan
 <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, Shiqi Zhang
 <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, Yao Zi
 <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] riscv/ptrace: add new regset to get original a0 register
In-Reply-To: <31d48f53-eaf0-445e-b9e3-7c56070ff6ad@coelacanthus.name>
References: <20241201-riscv-new-regset-v1-1-c83c58abcc7b@coelacanthus.name>
 <87v7w22ip6.fsf@all.your.base.are.belong.to.us>
 <31d48f53-eaf0-445e-b9e3-7c56070ff6ad@coelacanthus.name>
Date: Tue, 03 Dec 2024 12:23:01 +0100
Message-ID: <87jzchdn8q.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Celeste Liu <uwu@coelacanthus.name> writes:

>>> +static int riscv_orig_a0_get(struct task_struct *target,
>>> +			     const struct user_regset *regset,
>>> +			     struct membuf to)
>> 
>> Use full 100 chars!
>
> Linux code style prefer 80 limit.

No, it has been increased to 100, since many years [1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/checkpatch.pl#n60

