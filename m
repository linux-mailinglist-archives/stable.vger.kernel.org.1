Return-Path: <stable+bounces-69854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 439EB95A88C
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 01:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85A71F226F7
	for <lists+stable@lfdr.de>; Wed, 21 Aug 2024 23:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6437217DFEB;
	Wed, 21 Aug 2024 23:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aMkCt/yP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9516F0DE;
	Wed, 21 Aug 2024 23:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724284767; cv=none; b=F71K0zg2u+F5OlqR5tlL+ba//Vrf0Bx1QPTUJuQiySgqh1pVBscciGc1sxAuvNE7rdX6CbIBXGC8rAhHeJs6nfYQQyfd77JMPKtsTejJ2iVfRWEnd1lE0HCreIgqgi8S7DIQRSWhAPN36NEDmBEwbtPEiqtuEu10thhaPNkCUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724284767; c=relaxed/simple;
	bh=KgL/9nau2beot43sS7BU+zMvTNTIkVz3apXW2wAILm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcsF8vy2iFVb9iL0eXn30kIqnff6/7rXyjz365wOq2enV2r5Ikd7gZOACjeMxDCJtb53vcNLcWk6dRlrpjtiKjYiind4VJe/cd2cfszj927IuEPQ+BeOd0ENK2hkiB8Y62eoe/s4QgKl/ThG6Xarl9NcyAjLnw9ryI2jXiJn+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aMkCt/yP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC1FC32781;
	Wed, 21 Aug 2024 23:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724284766;
	bh=KgL/9nau2beot43sS7BU+zMvTNTIkVz3apXW2wAILm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMkCt/yPdMTiJgMaYK4ndjUM3Vg7VROlAfJPpHKcVfsvkRg72EQMEOJ5rUZbPptq0
	 BqD3rCJ1heKYDj9B+s+uGXZ/JrSic/IoW1PLmKNi3FR3XavSdbceXgjVWp3U8YfD7X
	 sL7tVXjyqKeK2MsFLSZN3hLQSfxtFiUGgkY+iiV4=
Date: Thu, 22 Aug 2024 07:59:24 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	edumazet@google.com, Harald Welte <laforge@gnumonks.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: Patch "gtp: pull network headers in gtp_dev_xmit()" has been
 added to the 6.10-stable tree
Message-ID: <2024082214-spinach-acclimate-fb98@gregkh>
References: <20240819142022.4154993-1-sashal@kernel.org>
 <ZsZ9_XrOOZApAAUq@calendula>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsZ9_XrOOZApAAUq@calendula>

On Thu, Aug 22, 2024 at 01:53:33AM +0200, Pablo Neira Ayuso wrote:
> Hi Sasha, Greg,
> 
> Could you cherry-pick this patch for other -stable kernels?
> 
> I confirm this applies up to >= 4.19-stable since it already includes
> pskb_inet_may_pull().

Now applied, thanks!

greg k-h

