Return-Path: <stable+bounces-108198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF545A092CB
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 15:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42ED1887A1A
	for <lists+stable@lfdr.de>; Fri, 10 Jan 2025 14:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13EBA20E03A;
	Fri, 10 Jan 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UmqyEQo7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374320FAA2;
	Fri, 10 Jan 2025 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517660; cv=none; b=opTIJzR0U3NJvAgUBqbSOTxAJsO6c2lTXHg5p9BYM2logDYmsml+guzxF4V+Am6Wax79DHh0Nb9Ir9P7apNdsL3Ns6r4v96zTAqfIQVeto85SVWZFbrj98XOPCRBBZM5C1fzwgbEo9bBUYv9Ivl7rKiGCJ6BOt+hbD+jWhue7hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517660; c=relaxed/simple;
	bh=2nqvfQg7rMWdfSyDjuTFLOQtbWDjzLQw34aKgFXPhKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu6yolwc2QVcKnIZbxZzQVvaxD03gCnv6seDngauzscbF9HyKA4E2YNsO3UsE942tDGB+j5LHSZh8XVhlRqY6nH7tdbEk1Kfv2ThMIQkeOXCJsBddWF1aDvEeNYYDeQKaRwL7QqSRCDmcm7DEnH/g34tn4V+zJA9JU41ttE8UqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UmqyEQo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6C5C4CED6;
	Fri, 10 Jan 2025 14:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736517660;
	bh=2nqvfQg7rMWdfSyDjuTFLOQtbWDjzLQw34aKgFXPhKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UmqyEQo7ogUAr2gr7Ic79nkk+h74OUFPWAXe3oh/rybQLV13ARcZO/+XewZ5bg12r
	 NeliKpgIhhGK2W0b+5h/g5uskjEP80JArWqtYUfXKXGXA1DtoSCrJr4Z7meoTJCaTv
	 DN9Q/ZbKBPJcKxMSW7cE1S0PMxHlZdIpXHbBcIB0=
Date: Fri, 10 Jan 2025 15:00:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: regression in 6.6.70:  kexec_core.c:1075:(.text+0x1bffd0):
 undefined reference to `machine_crash_shutdown'
Message-ID: <2025011035-carpentry-delighted-3d28@gregkh>
References: <20250110144004.1fca120a@ncopa-desktop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110144004.1fca120a@ncopa-desktop>

On Fri, Jan 10, 2025 at 02:40:04PM +0100, Natanael Copa wrote:
> Hi!
> 
> When updating the Alpine Linux kernel to 6.6.70 I bumped into a new compile error:
> 
>   LD      .tmp_vmlinux.kallsyms1
> ld: vmlinux.o: in function `__crash_kexec':
> /home/ncopa/aports/main/linux-lts/src/linux-6.6/kernel/kexec_core.c:1075:(.text+0x1bffd0): undefined reference to `machine_crash_shutdown'
> ld: vmlinux.o: in function `do_kexec_load':
> /home/ncopa/aports/main/linux-lts/src/linux-6.6/kernel/kexec.c:166:(.text+0x1c1b4e): undefined reference to `arch_kexec_protect_crashkres'
> ld: /home/ncopa/aports/main/linux-lts/src/linux-6.6/kernel/kexec.c:105:(.text+0x1c1b94): undefined reference to `arch_kexec_unprotect_crashkres'
> make[2]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/scripts/Makefile.vmlinux:37: vmlinux] Error 1
> make[1]: *** [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile:1164: vmlinux] Error 2
> make: ***
> [/home/ncopa/aports/main/linux-lts/src/linux-6.6/Makefile:234:
> __sub-make] Error 2

Should now be fixed with the 6.6.71 release.  If not, please let me
know.

thanks,

greg k-h

