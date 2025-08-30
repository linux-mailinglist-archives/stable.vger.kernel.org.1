Return-Path: <stable+bounces-176737-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE3DB3C879
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 08:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4013B23C8
	for <lists+stable@lfdr.de>; Sat, 30 Aug 2025 06:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95601CCEE0;
	Sat, 30 Aug 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WXTL18uC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9556052F99
	for <stable@vger.kernel.org>; Sat, 30 Aug 2025 06:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756534747; cv=none; b=fUw3D5+1Vk42kx9oGVikmboMtSgZ7lD4xRKDRpZPK5Onf4IPFe1JqXjZt+kS5rn+hApCYAxNyd+3MRrTfk9WP70AzMxcbKX0jigkiT5fvIAdPD/Ho7kIbJEKD/AydXVT9vhEdwKKLWNTbsuqCA+wQc1tEaR14OG6qh5U8YMBNbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756534747; c=relaxed/simple;
	bh=EizBb/VTEiRJ55vzNdftliC2XA11+ng7XxeOR8X6X38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6kWaAPRZmmq6tfyiyDKh9JXFu3qcyXgSSnNqyHBp4Z6U1p7KbRMJABc/iQRYSZcCycoh5sLByFpfeNqUVo5NjRC/BdUZKrjl5yF/XHTcCaWuPY3+ym2GQZBbKWjj4oKbUUleisyYB9vjgUm65fZ7Ec4kecQTRBHYo6FsLxIl48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WXTL18uC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF48C4CEEB;
	Sat, 30 Aug 2025 06:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756534747;
	bh=EizBb/VTEiRJ55vzNdftliC2XA11+ng7XxeOR8X6X38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WXTL18uCfOQAPMm74ayAvqfSJRgjwo30kS7dC1eOjwILXlf98gxG+xcsEMQ68ckRH
	 7ZuVqhaEnoFr6WdG6yLoIZfEDqIu5X4Kr3l9gC8sfuGuGO2T+LAt9FLBVb9voJW+Lt
	 PTsEVolnaqBHsrzKy9hTekEKHzFvsDY6S2ZsVyZ8=
Date: Sat, 30 Aug 2025 08:19:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH] Revert "drm/amdgpu: Avoid extra evict-restore process."
Message-ID: <2025083040-startle-shortlist-3f48@gregkh>
References: <20250829193652.1925084-1-alexander.deucher@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829193652.1925084-1-alexander.deucher@amd.com>

On Fri, Aug 29, 2025 at 03:36:52PM -0400, Alex Deucher wrote:
> This reverts commit 71598a5a7797f0052aaa7bcff0b8d4b8f20f1441.
> 
> This commit introduced a regression, however the fix for the
> regression:
> aa5fc4362fac ("drm/amdgpu: fix task hang from failed job submission during process kill")
> depends on things not yet present in 6.12.y and older kernels.  Since
> this commit is more of an optimization, just revert it for
> 6.12.y and older stable kernels.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org # 6.1.x - 6.12.x
> ---
> 
> Please apply this revert to 6.1.x to 6.12.x stable trees.  The newer
> stable trees and Linus' tree already have the regression fix.

What is the commit id in Linus's tree for this fix?  Why can't we just
take that one instead?

thanks,

greg k-h

