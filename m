Return-Path: <stable+bounces-12775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85A8837331
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B8A29198E
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE74640BE5;
	Mon, 22 Jan 2024 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="r07ae8Tg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zx0KvWYg"
X-Original-To: stable@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B425F3D981
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705953019; cv=none; b=rPX9NR1rsrZObfL3X+3qpURAwRWLlfFJaRJ/fCUMbi221pUOCbLiQ9J5me+H5FeO4c+QdDFb8ijpEG7MGzdlh5fgmIzIffpoyN4mvEimo0ZliLTO8sBIJKza/ECZ2uksWYOHO+OlbJdWkdQ748OwxLu0WN8LUD44YRAuU8Itl5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705953019; c=relaxed/simple;
	bh=ZTVAfs0+dvyrjqIQo3fkpG/HFDLznH075eSEF0sx3mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2Lb1MZM2IWip6f4GYFqysVhLIrudRmhXlA1zc+pLOsWMe0SLnb7bHkquXTc4xSw6gD2C0wOknRgNAmAi3jime2P/rgEj3aeUO8ZIXQX/bBfjDfaxjBAFcFy23dlQMVO/rucSCQ8g/sHWJBz8ZsLiEqsEQAnha1dPKfWJvZVE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=r07ae8Tg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zx0KvWYg; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A67DF5C01CA;
	Mon, 22 Jan 2024 14:50:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 22 Jan 2024 14:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705953016; x=1706039416; bh=Po9QnRvD+j
	vM8LlZ7bsrjlHHL6cp0hdlGZ3DvhrjW64=; b=r07ae8TgUdymEOFrUHaxR7dGw0
	bLKr4F5jN2SDIeaCMzQi+hcHs6i3yk1lqOVuaWJjpPVk/couoZe5S4nheU/WfO9j
	LdGJ0D3AyizNOxhaBWR5YFEJM9yrheJxZrcy/6Xj+OWwwqP/4JZkO9RFcAg9zqec
	nGhxgUNgVb1VOefR53VcMJgnsMeLr++sY8hlAuvMiDrjx2Vc98mxeF/c9uWXAxyJ
	4bw0TVf03noRH5yjLib/WoImOppODs1r4Yez2neZ8QbljLejZwQZ71QUEGY+D8rU
	O7m/fJIKZ+Dw+t+ZHjmEPBlppdJW6jJi2ZRTqOKuH0Y3itCJ4uDf0rkPzyxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705953016; x=1706039416; bh=Po9QnRvD+jvM8LlZ7bsrjlHHL6cp
	0hdlGZ3DvhrjW64=; b=Zx0KvWYgXe/+Ri/bq9X2ew3Y5Ai5T7wLNRA1FGnmJ79E
	YDWGgtlIMnd+f73ufDtmsKFWYneqb5418vwlYGZFcH8fuKWGKW0X8lp8xLveJypD
	8602GBgdflnAEtac02C6Y0WtCgYu9OPqbLFixf3BEOCT+SYkfsdl3YrWSN/D2ASG
	tiT1HgxH1fUlDPrpNqlLFUzjLfnFfABQw75wx9XnPSIfmMnA/rbW9dV/QwcYOUqu
	8icwzrC5VZT9Q1vNeqXzPpfjMZSjpeli6XLdM50D+aiDOGv/XBR7k0tLhEczvdYu
	rFi9mwZrlc3KITHD/kYo1OeeB032dm52qPIrz1t6tw==
X-ME-Sender: <xms:98auZT9Fy53MMC-_KuXBtaOviQaONKtBQIhETXrcpUJf0xVET9neXw>
    <xme:98auZfsxzY_3xgPhpKI6y_WD11ZFXZhhTJH3ocHaTFCFAvltAIHHMxwkkM2HLIQdv
    ne42knJixH3Xw>
X-ME-Received: <xmr:98auZRAiCkp5O5wFYyCl-hEvcoKuzHlRwg4Qef9y6PK3FEG2-LLKMyhrvA40i73BCKH1nbTHJnX55g8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpefgtd
    egtefhheelkeeiudelveekhedtffffueejkedtgeehgedugeelveefhffgtdenucffohhm
    rghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtgho
    mh
X-ME-Proxy: <xmx:-MauZfdMjiwH8aeI6B4x1awdev8Yn7AHD60M-uJksORoFUfFpEMWZQ>
    <xmx:-MauZYNztDP5k1JNhPK2sAaoHrRVsF2etMBDlDF2AOGFvjmIfXYRCA>
    <xmx:-MauZRl9R7v_IXrSeUyPNRVPW1x_DmYt5AonPaG_-p7zJYqDEvraiA>
    <xmx:-MauZUB4IFPxznw0gW36abBsHlSFeM_QGhWs6HDC3qMW5PPxYHMXGQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 14:50:15 -0500 (EST)
Date: Mon, 22 Jan 2024 11:50:13 -0800
From: Greg KH <greg@kroah.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: stable@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH 6.1.y] LoongArch: Fix and simplify fcsr initialization on
 execve()
Message-ID: <2024012204-trapping-entity-5e2d@gregkh>
References: <2024012237-handed-control-646a@gregkh>
 <20240122192803.2731419-2-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122192803.2731419-2-xry111@xry111.site>

On Tue, Jan 23, 2024 at 03:28:04AM +0800, Xi Ruoyao wrote:
> There has been a lingering bug in LoongArch Linux systems causing some
> GCC tests to intermittently fail (see Closes link).  I've made a minimal
> reproducer:
> 
>     zsh% cat measure.s
>     .align 4
>     .globl _start
>     _start:
>         movfcsr2gr  $a0, $fcsr0
>         bstrpick.w  $a0, $a0, 16, 16
>         beqz        $a0, .ok
>         break       0
>     .ok:
>         li.w        $a7, 93
>         syscall     0
>     zsh% cc mesaure.s -o measure -nostdlib
>     zsh% echo $((1.0/3))
>     0.33333333333333331
>     zsh% while ./measure; do ; done
> 
> This while loop should not stop as POSIX is clear that execve must set
> fenv to the default, where FCSR should be zero.  But in fact it will
> just stop after running for a while (normally less than 30 seconds).
> Note that "$((1.0/3))" is needed to reproduce this issue because it
> raises FE_INVALID and makes fcsr0 non-zero.
> 
> The problem is we are currently relying on SET_PERSONALITY2() to reset
> current->thread.fpu.fcsr.  But SET_PERSONALITY2() is executed before
> start_thread which calls lose_fpu(0).  We can see if kernel preempt is
> enabled, we may switch to another thread after SET_PERSONALITY2() but
> before lose_fpu(0).  Then bad thing happens: during the thread switch
> the value of the fcsr0 register is stored into current->thread.fpu.fcsr,
> making it dirty again.
> 
> The issue can be fixed by setting current->thread.fpu.fcsr after
> lose_fpu(0) because lose_fpu() clears TIF_USEDFPU, then the thread
> switch won't touch current->thread.fpu.fcsr.
> 
> The only other architecture setting FCSR in SET_PERSONALITY2() is MIPS.
> I've ran a similar test on MIPS with mainline kernel and it turns out
> MIPS is buggy, too.  Anyway MIPS do this for supporting different FP
> flavors (NaN encodings, etc.) which do not exist on LoongArch.  So for
> LoongArch, we can simply remove the current->thread.fpu.fcsr setting
> from SET_PERSONALITY2() and do it in start_thread(), after lose_fpu(0).
> 
> The while loop failing with the mainline kernel has survived one hour
> after this change on LoongArch.
> 
> Fixes: 803b0fc5c3f2baa ("LoongArch: Add process management")
> Closes: https://github.com/loongson-community/discussions/issues/7
> Link: https://lore.kernel.org/linux-mips/7a6aa1bbdbbe2e63ae96ff163fab0349f58f1b9e.camel@xry111.site/
> Cc: stable@vger.kernel.org
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> (cherry picked from commit c2396651309eba291c15e32db8fbe44c738b5921)
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
> 
> The conflict is because 6.1.y does not have LBT support, thus there is
> no lose_lbt() line.  Resolved manually.

Now queued up, thanks.

greg k-h

