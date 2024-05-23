Return-Path: <stable+bounces-45657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F588CD169
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FC2CB213F3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3331487D5;
	Thu, 23 May 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hXP2W2gj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33B113C9CF
	for <stable@vger.kernel.org>; Thu, 23 May 2024 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464623; cv=none; b=kqMS/0N3dOFQU6DtRCaEBxFlpor9QTXqg2DFRl4F6dN60HgbqWrDD7pvmI6ea7vBdtJm8fIQVv+/AD5X9/8/1aV0NVVclH2lHL6IDe3gi5UGx6TWIFqEtI+ZUPw3lVOzxbeYpnPTmY4S/uC3BYyUjnXEyr2h3uDzh1wp467dmFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464623; c=relaxed/simple;
	bh=YK0jnekoOjFsyAxD40bRU7Vmw2Kj8wWY95l6nh/hTPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E22q+8U3AmTkw25DI/sK0MBOTHzHsL6m7ovdl6ZX65pKcDyUi6HNXwpKXxLU4bhOWsw/Q7xqB3EAFbmG3E+4VU+0RvZjkkWhr1klUz8kB4pBCYJ/Wt3ze65W56Gfa7ZpM9VUgK/WZGSynZoqPv2rYZ/8PZhHJUjtciyvhZsSPrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hXP2W2gj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C88C3277B;
	Thu, 23 May 2024 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716464623;
	bh=YK0jnekoOjFsyAxD40bRU7Vmw2Kj8wWY95l6nh/hTPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXP2W2gjnVJFrhS3Z/MdZQAfgJUqA6z9LHdR8KHuDlgWVuGNkITVud3KANyiaEH+g
	 Vbyw0ByjMal77KZH20TFp7KiCS1JyLWFEk2SYeDR/gJuMa0TSjWTbGy3VAvvyrNnPA
	 lrGBKi/ApPQN5VKelj9xNx6Bj8CvVPDX6uzWkwF8=
Date: Thu, 23 May 2024 13:43:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shaoying Xu <shaoyi@amazon.com>
Cc: stable@vger.kernel.org, sd@queasysnail.net, kuba@kernel.org
Subject: Re: [PATCH 5.15 0/5] Backport CVE-2024-26583 and CVE-2024-26584 fixes
Message-ID: <2024052322-shifting-gaining-4c22@gregkh>
References: <20240507221806.30480-1-shaoyi@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507221806.30480-1-shaoyi@amazon.com>

On Tue, May 07, 2024 at 10:18:01PM +0000, Shaoying Xu wrote:
> Backport fix commit ("tls: fix race between async notify and socket close") for CVE-2024-26583 [1].
> It's dependent on three tls commits being used to simplify and factor out async waiting.
> They also benefit backporting fix commit ("net: tls: handle backlogging of crypto requests")
> for CVE-2024-26584 [2]. Therefore, add them for clean backport:
> 
> Jakub Kicinski (4):
>   tls: rx: simplify async wait
>   net: tls: factor out tls_*crypt_async_wait()
>   tls: fix race between async notify and socket close
>   net: tls: handle backlogging of crypto requests
> 
> Sabrina Dubroca (1):
>   tls: extract context alloc/initialization out of tls_set_sw_offload
> 
> Please review and consider applying these patches.
> 
> [1] https://lore.kernel.org/all/2024022146-traction-unjustly-f451@gregkh/
> [2] https://lore.kernel.org/all/2024022148-showpiece-yanking-107c@gregkh/
> 
>  include/net/tls.h |   6 --
>  net/tls/tls_sw.c  | 199 ++++++++++++++++++++++++----------------------
>  2 files changed, 106 insertions(+), 99 deletions(-)
> 
> -- 
> 2.40.1
> 
> 

All now queued up, thanks.

greg k-h

