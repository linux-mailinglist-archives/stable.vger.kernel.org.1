Return-Path: <stable+bounces-145062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FDFABD6B3
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D11F188CE4F
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 11:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D722701AA;
	Tue, 20 May 2025 11:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fwh9tMDo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C943C264A97
	for <stable@vger.kernel.org>; Tue, 20 May 2025 11:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747740345; cv=none; b=ZfI9UYcHW1moeNtXd6S4xlnVdLFfd9DujmyhOzKVfhkviR1OM9XOcpA2ziPhNn6ibKndYsVb/LnH3oFIE5jOog21a8IqWWhkA4QNjqBEHCyqVpCwI1LU1qIPFqb6LFmLIEFF69HJLigY6r2WDFvL8KizP2fA9CHK9KsMUTv04F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747740345; c=relaxed/simple;
	bh=kXCLLToXdJAfMYHOOq6QH5btBAUtxudmsejOGFdzWW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhX4M9iI3xqvEb0J6Db0jIldbShUYgDhVrgT7WBR81oH2MN6asS+7T5D8Da+ieRdBisP2wcmrBOJu9qpSe3l+P3hRRyrsGud3QX+r0FWcVoMfBXE4rF8OXt3004laYbhzZBPxgivOgADz7bXVdQNFjQQYRKVlDRoR7N3OvrInYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fwh9tMDo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F3FC4CEE9;
	Tue, 20 May 2025 11:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747740345;
	bh=kXCLLToXdJAfMYHOOq6QH5btBAUtxudmsejOGFdzWW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fwh9tMDo20msnHXZOfCPCWC6F2OP/ugcMAGi8M27tbPgZAkmmJUB8vEjOwJkrtfng
	 JqwLcFZj7WLdAYwl7uFBM9bTbAWScjdgKXXEBpYpbLCqdS6SrKGftaiCqbfGcIcF6E
	 C6zjZRipkHreB05jcnFBlKuzrKQ8eTP/y/WJUUhI=
Date: Tue, 20 May 2025 13:25:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Feng Liu <Feng.Liu3@windriver.com>
Cc: adobriyan@gmail.com, kees@kernel.org, sashal@kernel.org,
	Zhe.He@windriver.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.10.y/5.15.y] ELF: fix kernel.randomize_va_space double
 read
Message-ID: <2025052021-freebee-clever-8fef@gregkh>
References: <20250509061415.435740-1-Feng.Liu3@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509061415.435740-1-Feng.Liu3@windriver.com>

On Fri, May 09, 2025 at 02:14:15PM +0800, Feng Liu wrote:
> From: Alexey Dobriyan <adobriyan@gmail.com>
> 
> [ Upstream commit 2a97388a807b6ab5538aa8f8537b2463c6988bd2 ]
> 
> ELF loader uses "randomize_va_space" twice. It is sysctl and can change
> at any moment, so 2 loads could see 2 different values in theory with
> unpredictable consequences.
> 
> Issue exactly one load for consistent value across one exec.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> Link: https://lore.kernel.org/r/3329905c-7eb8-400a-8f0a-d87cff979b5b@p183
> Signed-off-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
> Signed-off-by: He Zhe <Zhe.He@windriver.com>
> ---
> Verified the build test.

No you did not!  This breaks the build.

This is really really annoying as it breaks the workflow on our side
when you submit code that does not work at all.

Please go and retest all of the outstanding commits that you all have
submitted and fix them up and resend them.  I'm dropping all of the rest
of them from my pending queue as this shows a total lack of testing
happening which implies that I can't trust any of these at all.

And I want you all to prove that you have actually tested the code, not
just this bland "Verified the build test" which is a _very_ low bar,
that is not even happening here at all :(

greg k-h

