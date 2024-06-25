Return-Path: <stable+bounces-55754-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87E09166CE
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 14:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169551C236C4
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA7B14A4F0;
	Tue, 25 Jun 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="taZ5wdtW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468D9137764;
	Tue, 25 Jun 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316917; cv=none; b=ep7oIJq4y3wf02aBu4K5hDdbXsiBkz7BqbJvadEdrhrS37LztLCErF3/4ZrfpfDfzqH7NO23X0UonCZVoEdpuwkvW6NRaZkEQLOfD6TjeaGitsx74wAUed3Me1pJQOqHJT/wqoMPw9mQHCqVOaL8gQ8ecyEjohKLfV7l69D5xV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316917; c=relaxed/simple;
	bh=6xAsTmCJo4fk6d/plweS+msCFdsu/qa5mCMQxZUg2eI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QagdXtWTf8CJClcEI88jAnYhnOgKWSeNo8dokFU8/lQolTOrHNoShcYmgcoFrhDEV5mvNIslUnqQ/4du0SZmJU6IO9fvwlAyXIVj6/an1IQUTRf8mMxGgTRwe3sg5Do7+BNnndHooeuCmMNeMxDh0smvLWripi4J4R2+AXBkE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=taZ5wdtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754BFC32781;
	Tue, 25 Jun 2024 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719316916;
	bh=6xAsTmCJo4fk6d/plweS+msCFdsu/qa5mCMQxZUg2eI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=taZ5wdtWSC9/u/spCnCt4YYPVOM/ywogOYp41lQX8A1lpqtp4cpxwY8hoKcE0f00B
	 hM+q91cjVMvpOiQdmvpDFTf1aTZACQvW4GYCwkR1pvActlekSNWE/RdZMIp2OjHF41
	 BH8myhd4UYHuidYFBPM6NtrV5y8VPfQbaCIS0vfQ=
Date: Tue, 25 Jun 2024 14:01:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: wujianguo <wujianguo@chinatelecom.cn>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6 100/192] netfilter: move the sysctl nf_hooks_lwtunnel
 into the netfilter core
Message-ID: <2024062537-entering-reprocess-3322@gregkh>
References: <20240625085537.150087723@linuxfoundation.org>
 <2935400.2255.1719311647175.JavaMail.root@jt-retransmission-dep-5ccd6997dd-985ss>
 <740d9249-534a-477c-9740-1e4c3a099d51@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <740d9249-534a-477c-9740-1e4c3a099d51@chinatelecom.cn>

On Tue, Jun 25, 2024 at 06:46:14PM +0800, wujianguo wrote:
> Hi Greg,
> 
> 
> This commit causes a compilation error when CONFIG_SYSFS is not enabled in
> config
> 
> I have sent a fix patch: https://lkml.org/lkml/2024/6/21/123

Please use lore.kernel.org for links.

Is this in Linus's tree yet?

thanks,

greg k-h

