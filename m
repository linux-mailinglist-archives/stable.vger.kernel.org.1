Return-Path: <stable+bounces-137283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AB6AA1292
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7530F17159C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9B92517BC;
	Tue, 29 Apr 2025 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Scxr8UDB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A89251792;
	Tue, 29 Apr 2025 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945605; cv=none; b=cv20X80bE1o1nQpAb16ZWQQAkmd434MS6/R/7blHZU08EzMnhk6qONKnYobip44dJe3hjoRVDFfai6ThYUHgK5dCy2SUnUfEe9gyZan2U0kCD7/83vFgHJu6eILjsTtAqZGsXjWmGjCsragd3Kmkhd/4WkWiCtRjBG+3PAvqums=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945605; c=relaxed/simple;
	bh=UGcKKVQF62LQ6hsPGiNLBxAkwhPYxGX2ggkQXxOx59E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3hsrQNtONAifW4icj4koppS0AApS4VdO2JuG8FsCucoOXn0qKydIAT6vuM8SDWda0/PpGJuouYCQKvr4wwd1OOSvHG+RQg6MsAWzCV2NXCQ6A9m6yGws8mA7U0fKKcvDE5GkR9xrO9875y8VsAKo8L1ylPvlAEcsr1TmYNsiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Scxr8UDB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AA5C4CEEA;
	Tue, 29 Apr 2025 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745945605;
	bh=UGcKKVQF62LQ6hsPGiNLBxAkwhPYxGX2ggkQXxOx59E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Scxr8UDB67KnQvqCCXhbOpKdwm1LeY6NpiVlg5X/yFgLDByBaOWBs47ipLZz3NNDm
	 HvP37FmsSysPqVU/Qc0mPX0h9ewOew0mwJWSK/CDnMNK6SqemYFECKMvLJxRmhNjJZ
	 KlffCCx6w7N5Tioo2Smh6ImSxhy0RQwTZrZURImg=
Date: Tue, 29 Apr 2025 18:51:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org, Kai Zhang <zhangkai@iscas.ac.cn>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable v6.6] riscv: kprobes: Fix wrong lengths passed to
 patch_text_nosync()
Message-ID: <2025042957-dazzler-frying-9051@gregkh>
References: <20250429161418.838564-1-namcao@linutronix.de>
 <2025042945-financial-rumbling-bcd0@gregkh>
 <20250429164614.g3w8JJAk@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429164614.g3w8JJAk@linutronix.de>

On Tue, Apr 29, 2025 at 06:48:21PM +0200, Nam Cao wrote:
> On Tue, Apr 29, 2025 at 06:31:09PM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Apr 29, 2025 at 06:14:18PM +0200, Nam Cao wrote:
> > > Unlike patch_text(), patch_text_nosync() takes the length in bytes, not
> > > number of instructions. It is therefore wrong for arch_prepare_ss_slot() to
> > > pass length=1 while patching one instruction.
> > > 
> > > This bug was introduced by commit b1756750a397 ("riscv: kprobes: Use
> > > patch_text_nosync() for insn slots"). It has been fixed upstream by commit
> > > 51781ce8f448 ("riscv: Pass patch_text() the length in bytes"). However,
> > > beside fixing this bug, this commit does many other things, making it
> > > unsuitable for backporting.
> > 
> > We would almost always want the original commit, why not just send that
> > instead?  What is wrong with it being in here as-is?
> 
> The original commit is probably fine. But I'm paranoid, because it is not
> completely obvious whether the original commit would break something else
> in v6.6. Because, as mentioned, it does more than just fixing the bug.

You should be more paranoid about creating a one-off change that is NOT
upstream as in our experience, that almost always causes a new problem.

Please just backport the original and submit it after testing it out.

thanks,

greg k-h

