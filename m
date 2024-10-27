Return-Path: <stable+bounces-88237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF039B20EC
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 22:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2FC2814AA
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 21:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D079A187FFA;
	Sun, 27 Oct 2024 21:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L7lJUOUD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UiFmSj6e"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8993538A;
	Sun, 27 Oct 2024 21:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730065934; cv=none; b=m84wlh0bpxx5yGfw3jf0B4gYeXXwaMsw/TnFM7aVn5sRmHkH5PGHhyCLycqlOxuXSo3uAIqCVIh5iTi883I3SHtUZ8nG3hgbfgYej0yGnU7xpGNPK4eIY4As1DdgqNQoide8v8tFxO2E41fJr1cQiTVwx/2Nqnr6k9b1/R38FQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730065934; c=relaxed/simple;
	bh=MHHv6vB+VNZoiQzpwR22YudKVXaHFK977iJvrLYafWw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=alr7OkttmnSWspUr5a+KNXMB8M+WhRSk9E0Dztu6Ha2HQO1Sp+BngrI8eKchYmT0YNX6UNzD8tEf/LXFPktX+IPQjIzMdmX0QuRoVSbuBXGskuZmv96rHPgnAH6/tRtjQIKkSr6kJUT1BKFAhdOb2y4qQYcmv5Qf+xDfok3/87c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L7lJUOUD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UiFmSj6e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730065924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uy5LdYJketu0MffohoUl/Go4tqbAl9Nu0e0r5sC/9hg=;
	b=L7lJUOUDWecGzoSMUFeYyRVbMItKoikZPqkTFPPwfUFUmPYHkwCDaV6QZwRfeffPKSUds0
	EjQDESlPiLzYy01g6Lv9a1rX4eCjqASSNrLv4RLDqAt99nLECf/PFUyPfeVmI7EwknfoMf
	72jFv8ZWuqVzGFwgozvK7A1OT1b2D35AHmZty9QTbvcaz4Fla2037hXftQTiG2gdGp9vHe
	RvLXSGiLk8naQYc2oOygwjeVufCXVGvj40tfsxVxIPGnRjgHngT9Hx7HvrztZgyVJwA7DN
	rwCnJHyG/jTtUyEA7nsL8JOIHsTk6Yk9dq5FURfOdulGPOF5spLZxIfKpJpqAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730065924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uy5LdYJketu0MffohoUl/Go4tqbAl9Nu0e0r5sC/9hg=;
	b=UiFmSj6er+DDxtENWNJee2WvTT3oCW0HfJTNQKwWe0Bdj83ReRUBo4a5qWThGF9Gj62GHd
	5lmFOrjMukqig9CA==
To: Celeste Liu <coelacanthushex@gmail.com>, =?utf-8?B?QmrDtnJuIFTDtnBl?=
 =?utf-8?B?bA==?= <bjorn@kernel.org>,
 Celeste Liu via B4 Relay <devnull+CoelacanthusHex.gmail.com@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, =?utf-8?B?Qmo=?=
 =?utf-8?B?w7ZybiBUw7ZwZWw=?=
 <bjorn@rivosinc.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alex@ghiti.fr>,
 "Dmitry V. Levin" <ldv@strace.io>, Andrea Bolognani <abologna@redhat.com>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, Yao Zi
 <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] riscv/entry: get correct syscall number from
 syscall_get_nr()
In-Reply-To: <2b1a96b1-dbc5-40ed-b1b6-2c82d3df9eb2@gmail.com>
References: <87ldya4nv0.ffs@tglx>
 <3dc10d89-6c0c-4654-95ed-dd6f19efbad4@gmail.com> <87a5ep4k0n.ffs@tglx>
 <2b1a96b1-dbc5-40ed-b1b6-2c82d3df9eb2@gmail.com>
Date: Sun, 27 Oct 2024 22:52:03 +0100
Message-ID: <877c9t43jw.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Oct 28 2024 at 01:01, Celeste Liu wrote:
> On 2024-10-27 23:56, Thomas Gleixner wrote:
>> Equivalently you need to be able to modify orig_a0 for changing arg0,
>> no?
>
> Ok. 
>
> Greg, could you accept a backport a new API parameter for 
> PTRACE_GETREGSET/PTRACE_SETREGSET to 4.19 LTS branch?

Fix the problem properly and put a proper Fixes tag on it and worry
about the backport later.

Thanks,

        tglx

