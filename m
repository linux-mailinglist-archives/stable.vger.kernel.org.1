Return-Path: <stable+bounces-127560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B03A7A5C6
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 16:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB583AE0D7
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 14:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986DC2500DE;
	Thu,  3 Apr 2025 14:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZCX1QEnU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559962500C5
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692061; cv=none; b=pk6XS1ouQBL6qmFyiOVXXLnLZIXv5L3CcnPf863RhPfJwKhB3mydWjdGTAJnPo4kJy0F+8yrfSWJ1dP14iSU3mAQnNBIIHrWAAT8//JTiK2zllJZyORnVN7DSooggKexLVjPBrUWAyp9mUerFefwpQjj7DO7kuPcE99V+gE0yOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692061; c=relaxed/simple;
	bh=bjHsE498GvFpBMUWpqL8nDc4Q6/iNiEANfOkEixkVxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAVgAnCfhEMu4ZMlcMt/P0KJcno1mEySF9BhG/vHIwbhQXrk8T73U5hdfgTHbEE8tmcsx0sOHwpHMAaUFpJoaPxtC9yRfSmIubhHsVaZLpr2YfvOwyxAfxhQgfxVHESfTdThSgn4ZCLfEodus5+8SprZq2ur63zgCo+2NB1mXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZCX1QEnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726ACC4CEE3;
	Thu,  3 Apr 2025 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743692060;
	bh=bjHsE498GvFpBMUWpqL8nDc4Q6/iNiEANfOkEixkVxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZCX1QEnU9mAvFEy3F+mJb6k+KBimzqehW4hswTg8+Zf4AUGz5osy/vggSw9fKlhpf
	 rWspaH6NYbY7N9hSaxiy/zJoNKTciA8ejSDpI3y9JH5+la1K7MEb8/jFGqdenH9RA5
	 zftv2nY0cVOoeScrL+E38q5zq4XCVq84CXURjVqA=
Date: Thu, 3 Apr 2025 15:52:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kang Wenlin <wenlin.kang@windriver.com>
Cc: stable@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	ebiederm@xmission.com, keescook@chromium.org,
	akpm@linux-foundation.org
Subject: Re: [PATCH 6.6.y 0/6] Backported patches to fix selftest tpdir2
Message-ID: <2025040344-coma-strict-4e8f@gregkh>
References: <20250402082656.4177277-1-wenlin.kang@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402082656.4177277-1-wenlin.kang@windriver.com>

On Wed, Apr 02, 2025 at 04:26:50PM +0800, Kang Wenlin wrote:
> From: Wenlin Kang <wenlin.kang@windriver.com>
> 
> The selftest tpdir2 terminated with a 'Segmentation fault' during loading. 
> 
> root@localhost:~# cd linux-kenel/tools/testing/selftests/arm64/abi && make
> root@localhost:~/linux-kernel/tools/testing/selftests/arm64/abi# ./tpidr2
> Segmentation fault
> 
> The cause of this is the __arch_clear_user() failure.
> 
> load_elf_binary() [fs/binfmt_elf.c]
>   -> if (likely(elf_bss != elf_brk) && unlikely(padzero(elf_bes)))
>     -> padzero()
>       -> clear_user() [arch/arm64/include/asm/uaccess.h]
>         -> __arch_clear_user() [arch/arm64/lib/clear_user.S]
> 
> For more details, please see:
> https://lore.kernel.org/lkml/1d0342f3-0474-482b-b6db-81ca7820a462@t-8ch.de/T/

This is just a userspace issue (i.e. don't do that, and if you do want
to do that, use a new kernel!)

Why do these changes need to be backported, do you have real users that
are crashing in this way to require these changes?

thanks,

greg k-h

