Return-Path: <stable+bounces-139721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0B1AA9854
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 18:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64FD516B19C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC45E264FB1;
	Mon,  5 May 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="32lxmmV+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQ+KrGWo"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAF25F98D;
	Mon,  5 May 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746461247; cv=none; b=rbcMV6ka8dUZBKhZlgKLFMVCuQmaZTAPjUT/PufThOWYgHOVuAC6KjR1TfoWxBTOeYntmgTPZfcSnyc7JB97cDFSktjiU/Y1fVu2BtahCSPiw1PptyDl9J+OaB8QjjEsUbrME9g4fPEPuRmIBp5uqgenIJ56J1R3l0RqE2GKYo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746461247; c=relaxed/simple;
	bh=DMeK6ilnzVwAGxKwctp44AaeblhvqSJvvyoBJcq//aM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYEyIWxa1gpZQZ0EVGZP/oUvdLzjILUMtqJE4JTC2W45KhxKEwkvRSAQ5oNdP0/aEYXkhB5DE70nuMs4nmSVlpvmIKUv2wU4CfhdCLL0QpyHkvsNQ0stxL9KO3Ee2Zm06kR6v3N0a/CqrtKTjeF8DxYwof+vfJ1kA80h/a3+940=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=32lxmmV+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQ+KrGWo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 May 2025 18:07:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746461244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08eIPimggJQjsCxpYwxCXgIC7iP02Dyp+Q4wrrtM0+A=;
	b=32lxmmV+XRVrWd4azsF3rJZe6ZR/Uj/1ZocrxB4jYGcujZIPOqZgdhGA4eZ3NVqGkLuzyv
	U4flqVMMIH2TBBxKeZTPmqOyB/sRHnxYFYxq6zXHx7GQSKQwSrsltoUBTXivkLjr3dDcWj
	Xrm6/fqVct34Ahp8yU9gbkTEKprC7xh5lBdkO8mo2FQgQZFvcMMcuy3Q6sbEQNe0TUdvq4
	wKuySY/NL6S7R/Bdh7ieB8MUyzuBCCU1l7y2ew4QJTlkjIj5rVH88IOIKhtxK8w8tqa50E
	3zpmp3Bgq8xWX8Cq8JilZ8f9aRQ23/uMfXayuS99NkFIqHAZOL11xSbejPtJhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746461244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=08eIPimggJQjsCxpYwxCXgIC7iP02Dyp+Q4wrrtM0+A=;
	b=oQ+KrGWoBQqoqXEOgZapUD0ZNjow+3J7oUxOWUAt91a3nahu+bRt1Z0jlADPCI6XycsS9k
	2MJCpevvQfne1cDQ==
From: Nam Cao <namcao@linutronix.de>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix kernel crash due to PR_SET_TAGGED_ADDR_CTRL
Message-ID: <20250505160722.s_w3u1pd@linutronix.de>
References: <20250504101920.3393053-1-namcao@linutronix.de>
 <c59f2632-d96f-43c6-869d-5e5f743f2dbd@ghiti.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c59f2632-d96f-43c6-869d-5e5f743f2dbd@ghiti.fr>

Hi Alex,

On Mon, May 05, 2025 at 06:02:26PM +0200, Alexandre Ghiti wrote:
> On 04/05/2025 12:19, Nam Cao wrote:
> > When userspace does PR_SET_TAGGED_ADDR_CTRL, but Supm extension is not
> > available, the kernel crashes:
> > 
> > Oops - illegal instruction [#1]
> >      [snip]
> > epc : set_tagged_addr_ctrl+0x112/0x15a
> >   ra : set_tagged_addr_ctrl+0x74/0x15a
> > epc : ffffffff80011ace ra : ffffffff80011a30 sp : ffffffc60039be10
> >      [snip]
> > status: 0000000200000120 badaddr: 0000000010a79073 cause: 0000000000000002
> >      set_tagged_addr_ctrl+0x112/0x15a
> >      __riscv_sys_prctl+0x352/0x73c
> >      do_trap_ecall_u+0x17c/0x20c
> >      andle_exception+0x150/0x15c
> 
> 
> It seems like the csr write is triggering this illegal instruction, can you
> confirm it is?

Yes, it is the "csr_write(CSR_ENVCFG, envcfg);" in envcfg_update_bits().

> If so, I can't find in the specification that an implementation should do
> that when writing envcfg and I can't reproduce it on qemu. Where did you
> see this oops?

I can't find it in the spec either. I think it is up to the implementation.

I got this crash on the MangoPI board:
https://mangopi.org/mqpro

Best regards,
Nam

