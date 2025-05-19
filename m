Return-Path: <stable+bounces-144877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB020ABC26A
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 17:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8167A0C8E
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C932820BC;
	Mon, 19 May 2025 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GAD34dR/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478027A47A;
	Mon, 19 May 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668470; cv=none; b=rLJ93f9zOXX/yYvsUeR1ecXxmClBuYvrvE38gcJNs7rf96RCekEtm72rpPaF7skCihqbkkwXO0dkcQ7+6+voHHJTQ1+2cQNpzRQjpbBbKL7ILmdkhzQRg+AU4/uTCvH8XqfJN/tJHgn9zYZ7XbUJ6WYSCcdzz74brgsJVYcKaYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668470; c=relaxed/simple;
	bh=9y5T5nKud7PAo8wPy5g06NrFKIyDPyDp9HPP4A3HsbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvJDaPc3zgr/DEWOwrN/7A0P3bXnm8MWpkD4VUCn3/jTG/1MwWCe+diMXCdU1FBVKiCSPPJBmuMuSpD+ZfmSr/xIwxRX8I5Pn1vP/jRpLtFsNXFspi4n6haSEeMNLsOSyBG0dQiEcOiHGhEAkD80S/sukUBmfKOLk1AWRXdX5O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GAD34dR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8C2C4CEE4;
	Mon, 19 May 2025 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747668469;
	bh=9y5T5nKud7PAo8wPy5g06NrFKIyDPyDp9HPP4A3HsbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GAD34dR/CZbpA4vHXwiPJnse0+EXckMBJeADM3euznvPcihxcQIVnoMQILrl6fZte
	 AvFDOOPv0VsYGHkQwGO6ZISDEOerjvstI6Yn6H+vauY/RUVt+lz6CZzKNZnZVxVNbH
	 d8eMjPc3DdZvkuh1XDuYUwAyhQKEb8E6E8JLB9QU=
Date: Mon, 19 May 2025 17:27:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: regression in 6.6.91: arch/x86/kernel/alternative.c:1452:5:
 error: redefinition of 'its_static_thunk'
Message-ID: <2025051935-august-anaerobic-2745@gregkh>
References: <20250519164717.18738b4e@ncopa-desktop>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519164717.18738b4e@ncopa-desktop>

On Mon, May 19, 2025 at 04:47:17PM +0200, Natanael Copa wrote:
> Hi!
> 
> When building 6.6.91 for Alpine Linux I got this error on 32 bit x86:
> 
> 
> 
>   CC      net/devlink/dpipe.o
> /home/buildozer/aports/main/linux-lts/src/linux-6.6/arch/x86/kernel/alternative.c:1452:5: error: redefinition of 'its_static_thunk'
>  1452 | u8 *its_static_thunk(int reg)
>       |     ^~~~~~~~~~~~~~~~
> In file included from /home/buildozer/aports/main/linux-lts/src/linux-6.6/arch/x86/include/asm/barrier.h:5,
>                  from /home/buildozer/aports/main/linux-lts/src/linux-6.6/include/linux/list.h:11,
>                  from /home/buildozer/aports/main/linux-lts/src/linux-6.6/include/linux/module.h:12,
>                  from /home/buildozer/aports/main/linux-lts/src/linux-6.6/arch/x86/kernel/alternative.c:4:
> /home/buildozer/aports/main/linux-lts/src/linux-6.6/arch/x86/include/asm/alternative.h:143:19: note: previous definition of 'its_static_thunk' with type 'u8 *(int)' {aka 'unsigned char *(int)'}
>   143 | static inline u8 *its_static_thunk(int reg)
>       |                   ^~~~~~~~~~~~~~~~
>   CC [M]  net/sched/act_skbmod.o
> make[4]: *** [/home/buildozer/aports/main/linux-lts/src/linux-6.6/scripts/Makefile.build:243: arch/x86/kernel/alternative.o] Error 1
> make[3]: *** [/home/buildozer/aports/main/linux-lts/src/linux-6.6/scripts/Makefile.build:480: arch/x86/kernel] Error 2
> make[3]: *** Waiting for unfinished jobs....
> 
> 
> I believe this was introduce with
> 
> commit 772934d9062a0f7297ad4e5bffbd904208655660
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Wed Apr 23 09:57:31 2025 +0200
> 
>     x86/its: FineIBT-paranoid vs ITS
>     
>     commit e52c1dc7455d32c8a55f9949d300e5e87d011fa6 upstream.
> 

Thanks, I've cc:ed you on the thread that caused this issue.

greg k-h

