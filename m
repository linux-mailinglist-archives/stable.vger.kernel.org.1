Return-Path: <stable+bounces-136664-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F4A9C074
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 10:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A15927AF6
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 08:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23D6233129;
	Fri, 25 Apr 2025 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0fAxchwT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCA9231A3F
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 08:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568481; cv=none; b=RJoXdwVI1jjtN7JvMus0wpPw5x5cP9rdUMeiWFyKjUG8ANMVRUiPVRZ47IJJjIPLSf+xtmNkQcTU19hE1LBEcVpx2tFsUl3rkcxQ2Vaple0dPdaWryV4sIE4YTXV7StMxxl7yAVWJvf4M++0tBmMpD7bQCvDcsIROd9Ci3AO6PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568481; c=relaxed/simple;
	bh=8zLFJJv2EdroXFnatIxABI6LSWfh7uy0wwY1KDv2MLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFHDADKdMEZOeizB3TUx8zgLNH+jBawxG33ZHAAlMeV7GIGCBnA6Qhp/UxT/zco/A4SB+ROIDP4RpL4fJV09egWKnCqsfl3nKqcQUJeZ6FCsA1SH53gzvJnfKqQWNkpTwINEdjCfDRVHoLveMeKorVSu2uED+lc0LIKnql8UTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0fAxchwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF70C4CEE4;
	Fri, 25 Apr 2025 08:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745568481;
	bh=8zLFJJv2EdroXFnatIxABI6LSWfh7uy0wwY1KDv2MLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0fAxchwTTC9hdv/ls9pshuJVBS5JBlo3LpYyp4Jkqcp2DuionodwavR590pP/3eQP
	 pfEDFqeTsbYL0uKaXE7llmMty6yBApSqHdt+OBnCQpttN5zPM553BJcaCR2is3P7Bm
	 pI9HVz67tRLrN/O5h+CDD624xkuxRU6Cd7I6mnUA=
Date: Fri, 25 Apr 2025 10:07:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kai Zhang <zhangkai@iscas.ac.cn>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, stable@vger.kernel.org
Subject: Re: [linux-6.6.y bugreport] riscv: kprobe crash as some patchs lost
Message-ID: <2025042518-craftily-coronary-b63a@gregkh>
References: <c7e463c0-8cad-4f4e-addd-195c06b7b6de@iscas.ac.cn>
 <2025042250-backlash-shifting-89cf@gregkh>
 <72896429-e966-4f7a-b2f2-ebc33368eb12@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72896429-e966-4f7a-b2f2-ebc33368eb12@iscas.ac.cn>

On Fri, Apr 25, 2025 at 04:03:41PM +0800, Kai Zhang wrote:
> On 4/22/2025 4:46 PM, Greg Kroah-Hartman wrote:
> > On Tue, Apr 22, 2025 at 10:58:42AM +0800, Kai Zhang wrote:
> > > In most recent linux-6.6.y tree,
> > > `arch/riscv/kernel/probes/kprobes.c::arch_prepare_ss_slot` still has the
> > > obsolete code:
> > > 
> > >      u32 insn = __BUG_INSN_32;
> > >      unsigned long offset = GET_INSN_LENGTH(p->opcode);
> > >      p->ainsn.api.restore = (unsigned long)p->addr + offset;
> > >      patch_text_nosync(p->ainsn.api.insn, &p->opcode, 1);
> > >      patch_text_nosync((void *)p->ainsn.api.insn + offset, &insn, 1);
> > > 
> > > The last two 1s are wrong size of written instructions , which would lead to
> > > kernel crash, like `insmod kprobe_example.ko` gives:
> > > 
> > > [  509.812815][ T2734] kprobe_init: Planted kprobe at 00000000c5c46130
> > > [  509.837606][    C5] handler_pre: <kernel_clone> p->addr =
> > > 0x00000000c5c46130, pc = 0xffffffff80032ee2, status = 0x200000120
> > > [  509.839315][    C5] Oops - illegal instruction [#1]
> > > 
> > > 
> > > I've tried two patchs from torvalds tree and it didn't crash again:
> > > 
> > > 51781ce8f448 riscv: Pass patch_text() the length in bytes (rebased)
> > > 13134cc94914 riscv: kprobes: Fix incorrect address calculation
> > 
> > Neither of these apply cleanly.  Please provide working backports if you
> > wish to see them added to the tree.
> > 
> > thanks,
> > 
> > greg k-h
> 
> revert 03753bfacbc6
> apply  51781ce8f448
> apply  13134cc94914

Thanks, but that's not how we take patches for the stable tree.  Please
submit these all in a tested patch series and we will be glad to queue
them up.

greg k-h

