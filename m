Return-Path: <stable+bounces-114264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4045A2C697
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 16:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB741887B58
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 15:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72711EB1B3;
	Fri,  7 Feb 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jx2XQMAi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846EA1EB1AF;
	Fri,  7 Feb 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738941068; cv=none; b=KuUVawSzSqaM+679uM2s+hnPW26OcO27Gv6dCMWqxHaA0eXKahN5SpTj3MabxcIRf7rhda+eFRInnkYgYy+C/7s3gN/H3yVOTccCSgV8+gvhpr7Qa9ts7HTkkmwbLQQnBCfYy8Icl74fVA0AWjlnSJTNjlWXqeVEslflwAbNWEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738941068; c=relaxed/simple;
	bh=k5BGTlEUCmgVpANzr5zQznfRMRcAxoVik7v2UWCnYXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mav0ieJ8Uma7uCW6Oc8DH/7F7PnfXLBLeQyoQMC/YrEDqdkeuJQdXRVwedXP8p2lghkK4DIuDuv41D3U0Ew5zLnwyz/aw0U/o088fNc8FoXEts3fVSm4GjEw7JpH0TgfIopsY/viLPPHe8AaRpI6dQ0UDNFkneytSqtYobNnZXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jx2XQMAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C19C4CEDF;
	Fri,  7 Feb 2025 15:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738941068;
	bh=k5BGTlEUCmgVpANzr5zQznfRMRcAxoVik7v2UWCnYXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jx2XQMAiEPI//dpMojgTg7ZeIMAxlZlxvbQSS0Vm89bRnPPDpAp072X1FxHdwU0MT
	 ko5Gjzi9ib7ED9dvl1s/buZBIvRmUVsP2dCi1C1r4IH+6JrYgbBc0xXRpVqIl5FE+7
	 erGnpw9hHXn37V8SoBeQJzPtTcSGoWhevKZ/tsBI=
Date: Fri, 7 Feb 2025 16:10:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: sashal@kernel.org, stable@vger.kernel.org,
	stable-commits@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Patch "hostfs: convert hostfs to use the new mount API" has been
 added to the 6.6-stable tree
Message-ID: <2025020730-divisive-zap-2416@gregkh>
References: <20250203162734.2179532-1-sashal@kernel.org>
 <e71dbfcd-317e-43b0-8e67-2a7ea3510281@huawei.com>
 <2025020534-family-upgrade-20fb@gregkh>
 <52c4c9a3-73a8-40df-ab37-e15b2f4f8496@huawei.com>
 <2025020654-worst-numbness-ca31@gregkh>
 <273cccc0-bbb1-4377-9ae6-a9c54ed64527@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <273cccc0-bbb1-4377-9ae6-a9c54ed64527@huawei.com>

On Fri, Feb 07, 2025 at 09:22:34AM +0800, Hongbo Li wrote:
> 
> 
> On 2025/2/6 11:54, Greg KH wrote:
> > On Thu, Feb 06, 2025 at 09:09:17AM +0800, Hongbo Li wrote:
> > > Well, by the way, is the patch added because there are use cases for the new
> > > mount API in hostfs?
> > 
> > I am sorry, I don't understand the question.
> > 
> 
> Sorry for my poor expression, I just wonder why this patch should be
> backported to the 6.6-stable tree. :)

Ah.  It was a dependency for a patch later in the series, and was
documented as such with the "Stable-dep-of:" line in the commit.

thanks,

greg k-h

