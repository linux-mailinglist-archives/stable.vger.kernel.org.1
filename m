Return-Path: <stable+bounces-135065-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2755A96345
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 10:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B2F441C5D
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EDE26659B;
	Tue, 22 Apr 2025 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qi8EU0DS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CEE25E476
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 08:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311576; cv=none; b=KhfPQXow/k/hVUzSA5jjL759eLbnOAc9C41c/d0Hi8m4c0HNp8785wPj5pTBiDH/1I/N0IBiXRurTdaXfML1A3mQLtWhRWIo2KgPOjphgpBVmbDrpPhVxigxZvP8s4BZqB8sOkaVUTpGlL52DGyD6wHs0QSUpg1MnZoExvSx4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311576; c=relaxed/simple;
	bh=tUkRasQ0eyoYBWyIu72acuPRjooXypADxsAsiqfp04E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0QZKoBSEBbpEqeOt35XOiKuyRYHtcG3BwmOkApIiUek+/IhLas7oSGDB/hz/cBCqeYbTjaLVECO8UZgYE1VNFGr9DE9++mgHKPuP22JMiJfJEG9ZxhiF2O/UPRMuKu/RDE184oY6Igg/NsUddSTeBrvASieo0HASiaTu/cpnqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qi8EU0DS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601FBC4AF0B;
	Tue, 22 Apr 2025 08:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745311575;
	bh=tUkRasQ0eyoYBWyIu72acuPRjooXypADxsAsiqfp04E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qi8EU0DSD7i19V3amEDkYbNG9VcJjDDyBh5ihALtDBnFKXIPJhC/tc2XEenNW20Ev
	 E2iOm+LEKFdCTQF8gL7+KpK5054MPKTa8NrTrlX5TMlTea4eBrPcmnvTJ8TUfZT7zs
	 vUkiFgzwlqyOJmmZNyj53t9281I7rlj4ORrLchIg=
Date: Tue, 22 Apr 2025 10:46:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kai Zhang <zhangkai@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, stable@vger.kernel.org
Subject: Re: [linux-6.6.y bugreport] riscv: kprobe crash as some patchs lost
Message-ID: <2025042250-backlash-shifting-89cf@gregkh>
References: <c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn>

On Tue, Apr 22, 2025 at 10:58:42AM +0800, Kai Zhang wrote:
> In most recent linux-6.6.y tree,
> `arch/riscv/kernel/probes/kprobes.c::arch_prepare_ss_slot` still has the
> obsolete code:
> 
>     u32 insn = __BUG_INSN_32;
>     unsigned long offset = GET_INSN_LENGTH(p->opcode);
>     p->ainsn.api.restore = (unsigned long)p->addr + offset;
>     patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
>     patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
> 
> The last two 1s are wrong size of written instructions , which would lead to
> kernel crash, like `insmod kprobe_example.ko` gives:
> 
> [  509.812815][ T2734] kprobe_init: Planted kprobe at 00000000c5c46130
> [  509.837606][    C5] handler_pre: <kernel_clone> p->addr =
> 0x00000000c5c46130, pc = 0xffffffff80032ee2, status = 0x200000120
> [  509.839315][    C5] Oops - illegal instruction [#1]
> 
> 
> I've tried two patchs from torvalds tree and it didn't crash again:
> 
> 51781ce8f448 riscv: Pass patch_text() the length in bytes (rebased)
> 13134cc94914 riscv: kprobes: Fix incorrect address calculation

Neither of these apply cleanly.  Please provide working backports if you
wish to see them added to the tree.

thanks,

greg k-h

