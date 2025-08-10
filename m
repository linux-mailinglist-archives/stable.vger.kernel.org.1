Return-Path: <stable+bounces-166940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6C0B1F76E
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 02:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44671420854
	for <lists+stable@lfdr.de>; Sun, 10 Aug 2025 00:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285654C92;
	Sun, 10 Aug 2025 00:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr/I2LrC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74164690;
	Sun, 10 Aug 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754785489; cv=none; b=EubuwVHAgTexqm4rOVNDAydGLO13m32mbkTEoQkP3GW1HXfk5FRQxJYMck8r/Vmi1a/Z2p6zl+JMabc020lSkDe480Xl6oXvaWC5TR/3M3SmNGotW+YhZne6UvWusUfk480ub+Q7sDaKEGtpBq/tjxxhIVrXuwRzSMhjts/9Uhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754785489; c=relaxed/simple;
	bh=+MYyrWF1r3HnrTCnEF6LLafDGHfYpJXCAD2vrMbxPI8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2ztKHVZGpU7a3cua69IzOnbKuKKlDIvs4WyITpUOWN4Tv8qNvx+GyxUgX73+T7or4I60MoGubFBVgsh1Mu3wbwLHLUWGlGOHRMd+OJW91cFwWZGcskbOSaaVtrhs3E8LVMHVbxXuWbvzyhDsFdmJ7Aepvoihw/9tlowWCOpars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr/I2LrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC53FC4CEE7;
	Sun, 10 Aug 2025 00:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754785489;
	bh=+MYyrWF1r3HnrTCnEF6LLafDGHfYpJXCAD2vrMbxPI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nr/I2LrCiwDb7fyWlOHGguMAQznvJg6Z+RWIAdSuzijsI27B9WJAcgByQ16XpJoBv
	 0vxJAVAqyB4nwj0i/po6ICSYOgi0YdToj6v07Gio7CytCd3ddueTxcaZB4nYhGBoDs
	 mbg3nTtKZd0SYxTid/RItEMokgxH4m1Eg4dtt/8hp7J8owXZB6Qy5hmQnL6lOphk0P
	 uNVXffdM09RPT+ks9tFPVS3vgfM5O0Sqe9pjMfHRwaDlnxVjsUJ5qJ2QU+hIRRv0YT
	 Di8HofxzUY3ZVyJGUuRatJrxh4F95PQ++zM3K3xmfW26NrykOCXcPgyZ0hl3ki+v+f
	 kcsN52c1BgF1Q==
Date: Sat, 9 Aug 2025 17:24:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
	linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: Only allow LTO with CMODEL_MEDANY
Message-ID: <20250810002445.GB1726533@ax162>
References: <20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org>
 <20250808215303.GA3695089@ax162>
 <b0fdcb23-4d68-4d0f-a8ac-2b389a0ce856@ghiti.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0fdcb23-4d68-4d0f-a8ac-2b389a0ce856@ghiti.fr>

On Sat, Aug 09, 2025 at 12:45:59PM +0200, Alexandre Ghiti wrote:
> Hi Nathan,
> 
> On 8/8/25 23:53, Nathan Chancellor wrote:
> > Ping? This is still getting hit.
> 
> 
> This is the second time your patches do not reach the linux-riscv mailing
> list [1] [2], not even my personal mailbox.
> 
> [1] https://lore.kernel.org/linux-riscv/?q=riscv%3A+Only+allow+LTO+with+CMODEL_MEDANY
> 
> [2] https://lore.kernel.org/linux-riscv/?q=riscv%3A+uaccess%3A+Fix+-Wuninitialized+and+-Wshadow+in+__put_user_nocheck
> 
> I don't know what's going on, do you have any idea?

Huh, not sure :/ I only use my kernel.org address and nothing about my
configuration or usage has changed plus it seems to have made it to
every other mailing list I sent it to?

https://lore.kernel.org/lkml/20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org/
https://lore.kernel.org/llvm/20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org/
https://lore.kernel.org/stable/20250710-riscv-restrict-lto-to-medany-v1-1-b1dac9871ecf@kernel.org/

Next time I have to send a RISC-V patch, I'll look at the archives to
see if it made it there and follow up if not.

> I'll pick this up in my fixes branch.

Great, thanks a lot!

Cheers,
Nathan

