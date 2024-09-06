Return-Path: <stable+bounces-73731-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C50E96EE19
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7450B21398
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 08:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890A214B945;
	Fri,  6 Sep 2024 08:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWv0+dmp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4215B45BE3;
	Fri,  6 Sep 2024 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611443; cv=none; b=DCmxxZlA3C8kO5+qEOY2yPLJQwNI52T+xN3O6vHI+Y70MKxWt7+P0WjCWoarlp0XZz7QtgwXfXOBWK0JsRblEsBOZUOSQbksgVNGtCg/oOmx0zY1m1UUG0+gQX1aeT4rv+nHgRwNxE9mLCL+MbBLNAG7CSdnl7zX+gnqx9dWF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611443; c=relaxed/simple;
	bh=A5dq9VXSOyYLnbKAephiLb4/q2ZPRZWcqiBaCOExek4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVSXLKdkEmvibqVl4I/k2lI10WW5jlrpuioRs5TzIT0Bi1RI4v7jZcmkPi8D/TQ5iR3kC52ZtY/OE+9RTS6W4td4RmZDwLv6tN/q1nj4JP5wRtqiWdrKNnowyu6nVH73kuftEMYBROa6g82AVuzex9y2TSrJ+K1aBMtY9CEjzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWv0+dmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 619BBC4CEC4;
	Fri,  6 Sep 2024 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725611442;
	bh=A5dq9VXSOyYLnbKAephiLb4/q2ZPRZWcqiBaCOExek4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWv0+dmp0VjjpwgOjn/rgchbdug4Cxd8CeXi17mh1b0caKbFg21RCbpO1xdkdEA3+
	 UymzcCa7gSnv4pDx4yzQTEuwr2Jz/z58ImXpGaDYfed7FPRb4CaAt1b/4gFuZP9Y8c
	 9EZf8pTXk6Ycd3KP+Vi4IDTRUNB2QcuS8RU6dy8JBVho43tpxE0T3sRwSn67l1Actk
	 6lIZoXB/cJJrtaigyAABRHFX9913ntCZJR2iHERmKaCl7C+mPy8r8izFNlYviDJpAZ
	 q8aXYWL6HPNNRKB9ZtzJhIhYM3DmAfDbVAioCltQU9AwdksKpsW7nMfewX8PLvb+dH
	 LZG4fbO9qdUzw==
Date: Fri, 6 Sep 2024 09:30:38 +0100
From: Simon Horman <horms@kernel.org>
To: Gui-Dong Han <hanguidong02@outlook.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] ice: Fix improper handling of refcount in
 ice_sriov_set_msix_vec_count()
Message-ID: <20240906083038.GC2097826@kernel.org>
References: <SY8P300MB0460D0263B2105307C444520C0932@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SY8P300MB0460D0263B2105307C444520C0932@SY8P300MB0460.AUSP300.PROD.OUTLOOK.COM>

On Tue, Sep 03, 2024 at 11:59:43AM +0000, Gui-Dong Han wrote:
> This patch addresses an issue with improper reference count handling in the
> ice_sriov_set_msix_vec_count() function.
> 
> First, the function calls ice_get_vf_by_id(), which increments the
> reference count of the vf pointer. If the subsequent call to
> ice_get_vf_vsi() fails, the function currently returns an error without
> decrementing the reference count of the vf pointer, leading to a reference
> count leak. The correct behavior, as implemented in this patch, is to
> decrement the reference count using ice_put_vf(vf) before returning an
> error when vsi is NULL.
> 
> Second, the function calls ice_sriov_get_irqs(), which sets
> vf->first_vector_idx. If this call returns a negative value, indicating an
> error, the function returns an error without decrementing the reference
> count of the vf pointer, resulting in another reference count leak. The
> patch addresses this by adding a call to ice_put_vf(vf) before returning
> an error when vf->first_vector_idx < 0. 
> 
> This bug was identified by an experimental static analysis tool developed
> by our team. The tool specializes in analyzing reference count operations
> and identifying potential mismanagement of reference counts. In this case,
> the tool flagged the missing decrement operation as a potential issue,
> leading to this patch.
> 
> Fixes: 4035c72dc1ba ("ice: reconfig host after changing MSI-X on VF")
> Fixes: 4d38cb44bd32 ("ice: manage VFs MSI-X using resource tracking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@outlook.com>
> ---
> v2:
> * In this patch v2, an additional resource leak was addressed when
> vf->first_vector_idx < 0. The issue is now fixed by adding ice_put_vf(vf)
> before returning an error.
>   Thanks to Simon Horman for identifying this additional leak scenario.

Thanks for the update,

I agree with the analysis and that the two instances of
this problem were introduced by each of the cited commits.

Reviewed-by: Simon Horman <horms@kernel.org>


