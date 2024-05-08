Return-Path: <stable+bounces-43449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC78BFABF
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 12:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE5A1F212E1
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442AE7E0FF;
	Wed,  8 May 2024 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEvI3jMc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE0B266AB;
	Wed,  8 May 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715163395; cv=none; b=N7Qu9K/ODjpJDc5u2Dl6PlMhyShh4g0M4iVgSKxI5ZTK3ei0+ueMTNtwkdV3kPu37oWA2tJBUgoeAFxlaBdc2BfsxEW2+7pvjKf5eYkT8pdkls2IR64uHkcgFIPcHKUVPRUqvJw25MgAvSjVEmKPxKRXivBlE+ZuUn44CRztXzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715163395; c=relaxed/simple;
	bh=lDKRFmsU38/PXRgXibvB1oA37phtjpbswn+NA0WBJC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ailXC+CQkNJqXlxlkholYlWqOrO77C0hS4NgXnoF/QomtThsKIKvGVNJWTM4bhgXqsOYhc9iisylsxipcePlNhOJjw6fSBIZXlLy1Om/NRZNkcXghzpcB2WIzQ47Tc+Y3ALD/FiY2mGvKeDZoh3wFvLx1pA3pljlMA5Alxh3GQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEvI3jMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BADC113CC;
	Wed,  8 May 2024 10:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163394;
	bh=lDKRFmsU38/PXRgXibvB1oA37phtjpbswn+NA0WBJC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEvI3jMcjVZPX9orLeR1UAzOEyUKkJH3ly5q/V+9TFhQK+H+rIYzwhLQvJXHNIZNR
	 poqNHOsPGQGZ1WSYgdFo8DgG36oc+lA+D7jH+X4XdMp3kax4qRP1a26u3Y0xKyVn4K
	 fyiX42Y5AR79t+vXdu8LOUgbVZ9ylj++0PoqdRmj7Cm8j9WFVnXEB16E010D3cElhp
	 M6B06V9i+7wJTc4QtbkOm1yI88s4jkVvYNw7hkUQZ/fTkDMqmLOHMwelwI9c4dXD1A
	 yH0byMmueKxFD9y5o/5ZFc113Tek3AhSLAJW7qtMQtxhLU7UvAp3asUWXiS7dbYq1J
	 Sx5LG0iTHizwQ==
Date: Wed, 8 May 2024 06:16:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>, mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 6/8] clk: Don't hold prepare_lock when
 calling kref_put()
Message-ID: <ZjtRACHwOpkMHX5g@sashalap>
References: <20240423110304.1659456-1-sashal@kernel.org>
 <20240423110304.1659456-6-sashal@kernel.org>
 <cc21ff5ddd8fbe07e75fdffd596c0aa1.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cc21ff5ddd8fbe07e75fdffd596c0aa1.sboyd@kernel.org>

On Tue, Apr 23, 2024 at 12:24:51PM -0700, Stephen Boyd wrote:
>Quoting Sasha Levin (2024-04-23 04:03:01)
>> From: Stephen Boyd <sboyd@kernel.org>
>>
>> [ Upstream commit 6f63af7511e7058f3fa4ad5b8102210741c9f947 ]
>>
>> We don't need to hold the prepare_lock when dropping a ref on a struct
>> clk_core. The release function is only freeing memory and any code with
>> a pointer reference has already unlinked anything pointing to the
>> clk_core. This reduces the holding area of the prepare_lock a bit.
>>
>> Note that we also don't call free_clk() with the prepare_lock held.
>> There isn't any reason to do that.
>
>You'll want the patch before this, 8358a76cfb47 ("clk: Remove
>prepare_lock hold assertion in __clk_release()"), to avoid lockdep
>warnings. And it looks like the problem was reported on v5.15.y so all
>5 patches from the series would need a backport.
>
> 8358a76cfb47 clk: Remove prepare_lock hold assertion in __clk_release()
> 6f63af7511e7 clk: Don't hold prepare_lock when calling kref_put()
> 9d05ae531c2c clk: Initialize struct clk_core kref earlier
> e581cf5d2162 clk: Get runtime PM before walking tree during disable_unused
> 9d1e795f754d clk: Get runtime PM before walking tree for clk_summary

Ack, looks like its already the case. Thanks!

-- 
Thanks,
Sasha

