Return-Path: <stable+bounces-202968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A588CCCB9A7
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 12:26:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EF473074CCC
	for <lists+stable@lfdr.de>; Thu, 18 Dec 2025 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9851930C613;
	Thu, 18 Dec 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VuDjZ2DY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BFA29B766;
	Thu, 18 Dec 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766057012; cv=none; b=pjv4UcjmvWdFbbQwEvn8XPab0EtgIpD+KWQmIyazmhSHSFsjsQAOi9VEvzIQYv1tk8XZw41MbGOCBAKWJ/Dd4Zzre8dzmUKrplxHj68Ipi7CLk+MURLPfC6xJDxF2njbOTReASJbkoiy2jXy0LHzTpwA2QAU2MVQfaGOZk9QnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766057012; c=relaxed/simple;
	bh=iLH5eFGUQovWBcSuWdXkzuGbA8ytIyEwLyms+DAJhys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8HV2YbwW3BQIqC5x/AoKLonKKPkpcqZAsFL5K3R7o+LYuY0Kh5ts4t5VcBT26BzMvl67ILyOMvphqX3v52WdjsgiaI3b+r+hYC+PoXHRn7FY5DKMbJvcn4xVGuECvLBqlUg+tK2w+Hir//zPyvqkjEKCvbHHnCUnLKXcjxpa6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VuDjZ2DY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E2AC4CEFB;
	Thu, 18 Dec 2025 11:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1766057011;
	bh=iLH5eFGUQovWBcSuWdXkzuGbA8ytIyEwLyms+DAJhys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VuDjZ2DYDvg05DDJIYfFn10m7jmnCRdwAOYbdcc5Q1t+6Im28KwGhmyoekyKt9DkL
	 ecWyogAS+JcyP6YTbsMJXxxXvZUuN8HJHlAuu8YJfFb5u6reST2WG8kSnOrAeNHNBo
	 KXMF6FYWBe1p7EInPw+BNQgo3MO1ALSHXesYm8Cc=
Date: Thu, 18 Dec 2025 12:23:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: rafael@kernel.org, dakr@kernel.org, Jonathan.Cameron@huawei.com,
	kbusch@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] node: fix a api misuse in node_init_node_access()
Message-ID: <2025121820-circus-jukebox-1295@gregkh>
References: <20251218085251.555749-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218085251.555749-1-lihaoxiang@isrc.iscas.ac.cn>

On Thu, Dec 18, 2025 at 04:52:51PM +0800, Haoxiang Li wrote:
> If device_register() fails, put_device() is the correct way to
> cleanup the resource.
> And free the dev name is unnecessary.
> 
> Fixes: 08d9dbe72b1f ("node: Link memory nodes to their compute nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
> ---
>  drivers/base/node.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 00cf4532f121..28c89ad67d0b 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -170,14 +170,15 @@ static struct node_access_nodes *node_init_node_access(struct node *node,
>  	if (dev_set_name(dev, "access%u", access))
>  		goto free;
>  
> -	if (device_register(dev))
> -		goto free_name;
> +	if (device_register(dev)) {
> +		put_device(dev);
> +		return NULL;
> +	}
>  
>  	pm_runtime_no_callbacks(dev);
>  	list_add_tail(&access_node->list_node, &node->access_list);
>  	return access_node;
> -free_name:
> -	kfree_const(dev->kobj.name);
> +
>  free:
>  	kfree(access_node);
>  	return NULL;
> -- 
> 2.25.1
> 
> 

How was this found and tested?

