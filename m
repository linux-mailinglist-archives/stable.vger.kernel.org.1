Return-Path: <stable+bounces-32960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2321C88E808
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1B330082D
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB56D149C68;
	Wed, 27 Mar 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xzuTZSBa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B3914659A;
	Wed, 27 Mar 2024 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550271; cv=none; b=GpEQznjGjjSAOOVKV8RHTGraZJrDlf0wIAr+KwaMh5lV6WdeARVhxV4ZxnLsauVj7dvexa5o8vY8jmPNatUu56yBjIsSINNajPmGmdmnSe9WJmCTPTw7mQeZB0hsV+uMAlCk3WGwJJBsVpdauAJCz1ZkKOmHl8p+qQr7NphIhwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550271; c=relaxed/simple;
	bh=d+1+22sVSGzYxPrvLwgHoaoTt9M7aBJRMT25MX0cxuI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORo0KmokRXm8MA7vxDFFyd0uEw2tOawDa3rygNAQpLU0dx1OBDmasp6b6YHHKHvzOrFMEm9VqgeAry9RJPwBhWFiWyuTNxeGvylwhshIbmKouRLjgW22cg0gndkrxpyDvIjNFFRVQKiEvWSUhMoZ3iG9eBBtuTvWdj35hoJRjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xzuTZSBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C23C433C7;
	Wed, 27 Mar 2024 14:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711550271;
	bh=d+1+22sVSGzYxPrvLwgHoaoTt9M7aBJRMT25MX0cxuI=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=xzuTZSBakeIeXIqimdvXQSQogs61P+L/IYfB5wKQlftbcY0DfYFygaM4ZkKG7VUoo
	 z0WFNBOyNBWQUSna74v+SsaHr7Wck2IvJJgcuRYeWesJFhbrXBPmc7T4eIQH8ckUVf
	 Nuvx3/Cql0rdluNj/vKflfDsP3taJstdTRAQWItA=
Date: Wed, 27 Mar 2024 15:37:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, heng guo <heng.guo@windriver.com>,
	netdev@vger.kernel.org
Subject: Re: fix IPSTATS_MIB_OUTOCTETS for IPv6 in stable-6.6.x
Message-ID: <2024032740-runny-giver-3d64@gregkh>
References: <ZauRBl7zXWQRVZnl@pc11.op.pod.cz>
 <20240124123006.26bad16c@kernel.org>
 <61d1b53f-2879-4f9f-bd68-01333a892c02@gmail.com>
 <493d90b0-53f8-487e-8e0f-49f1dce65d58@windriver.com>
 <20240124174652.670af8d9@kernel.org>
 <ZbIEDFETblTqqCWm@pc11.op.pod.cz>
 <ZbJ5Wfx7jNfXBpAP@pc11.op.pod.cz>
 <08d60060-ee2b-436f-9dcc-8aad1c8c35a1@gmail.com>
 <ZecuUV4xwXxQ8Ach@pc11.op.pod.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZecuUV4xwXxQ8Ach@pc11.op.pod.cz>

On Tue, Mar 05, 2024 at 03:38:09PM +0100, Vitezslav Samel wrote:
> 	Hi,
> 
>   could you, please, include commit b4a11b2033b7 ("net: fix
> IPSTATS_MIB_OUTPKGS increment in OutForwDatagrams") from Linus' tree
> into the 6.6 stable tree (only)?
> 
> Reported-by: Vitezslav Samel <vitezslav@samel.cz>
> Fixes: e4da8c78973c ("net: ipv4, ipv6: fix IPSTATS_MIB_OUTOCTETS increment duplicated")
> Link: https://lore.kernel.org/netdev/ZauRBl7zXWQRVZnl@pc11.op.pod.cz/
> Tested-by: Vitezslav Samel <vitezslav@samel.cz>

Now queued up, thanks.

greg k-h

