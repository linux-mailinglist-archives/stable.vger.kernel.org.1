Return-Path: <stable+bounces-183592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D825BC3E67
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 10:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A1C019E2D8E
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 08:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C502F2602;
	Wed,  8 Oct 2025 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/SRhARr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3665212568;
	Wed,  8 Oct 2025 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913150; cv=none; b=kN0O+b5kL44TBCBtzSe5BsThGN5dD4Sn0rgjSllh+nMFUHL4ccL484kyBgjarUF8D7oYV6swooK4UyO0XJv/9dN8SIbRHbCaYTJf0i7Hd+Obv7iXVw+mljIwKvaezfDcj3VJ53iyVLL44mzEpAf2bFhKFfZHTtpIW7OhJU07Pdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913150; c=relaxed/simple;
	bh=/tT7K/+4Yic47D9gSJOVksDXGGdOZm6NjABI8bxhXZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVc6BI2v7coyQLSruEHlpIs2sYanE3fB7DMfaPu2tHtkn1Ff/FQwTcdFcVP2zeum+/p2QAkXtCeX4FQaTZRFa9fYlfUjpXlEv9+OCQpC6kzb6oVLG4yZ3TQo4tUdv5oX2g/7SKYHlib+/lcxujwY2eaf8+n5fezlg1QFccqbnYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/SRhARr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69559C4CEF4;
	Wed,  8 Oct 2025 08:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759913150;
	bh=/tT7K/+4Yic47D9gSJOVksDXGGdOZm6NjABI8bxhXZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n/SRhARr89olGEmHCXk6SVGPbo61lltxmCojxUI1OPSr9+MCr1mMhFzhmwaraWyHr
	 6GNgMhv8EAEO7fVc080LNIr3L7IPATMwRF8/iinwYoicHfXfeCL4AlAy0NOPKFrB6+
	 KhvYUeLJiIc+h93A3EW9EBof+BV7l0BfOGMZz9ojqHV6CGZjCjI18dltE/6LECdBRf
	 2jsxHNqTjIwGIygKNp+KP2aHY1T8a5pnS+BgGO4dz009tW16nAHe0m3tfb//2JqHLI
	 pwoj6BcTANg2SxqrW7yu3TdbD2yuDkl8xbd+KkFlJm9Zlul3yoqZoAMf3m8mF74vx2
	 UZWMgB/zFyAfQ==
Date: Wed, 8 Oct 2025 09:45:45 +0100
From: Will Deacon <will@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tomasz Figa <tfiga@chromium.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: kvm: arm64: stable commit "Fix kernel BUG() due to bad backport
 of FPSIMD/SVE/SME fix" deadlocks host kernel
Message-ID: <aOYkuatjNVyiQzU1@willie-the-truck>
References: <hjc7jwarhmwrvcswa7nax26vgvs2wl7256pf3ba3onoaj26s5x@qubtqvi3vy6u>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hjc7jwarhmwrvcswa7nax26vgvs2wl7256pf3ba3onoaj26s5x@qubtqvi3vy6u>

On Wed, Oct 08, 2025 at 01:45:32PM +0900, Sergey Senozhatsky wrote:
> Commits 8f4dc4e54eed4 (6.1.y) and 23249dade24e6 (5.15.y) (maybe other
> stable kernels as well) deadlock the host kernel (presumably a
> recursive spinlock):
> 
>  queued_spin_lock_slowpath+0x274/0x358
>  raw_spin_rq_lock_nested+0x2c/0x48
>  _raw_spin_rq_lock_irqsave+0x30/0x4c
>  run_rebalance_domains+0x808/0x2e18
>  __do_softirq+0x104/0x550
>  irq_exit+0x88/0xe0
>  handle_domain_irq+0x7c/0xb0
>  gic_handle_irq+0x1cc/0x420
>  call_on_irq_stack+0x20/0x48
>  do_interrupt_handler+0x3c/0x50
>  el1_interrupt+0x30/0x58
>  el1h_64_irq_handler+0x18/0x24
>  el1h_64_irq+0x7c/0x80
>  kvm_arch_vcpu_ioctl_run+0x24c/0x49c
>  kvm_vcpu_ioctl+0xc4/0x614
> 
> We found out a similar report at [1], but it doesn't seem like a formal
> patch was ever posted.  Will, can you please send a formal patch so that
> stable kernels can run VMs again?

Yup, already queued up for stable:

https://lore.kernel.org/r/20251003183917.4209-1-will@kernel.org
https://lore.kernel.org/r/20251003184018.4264-1-will@kernel.org
https://lore.kernel.org/r/20251003184054.4286-1-will@kernel.org

Sorry for the breakage.

Will

