Return-Path: <stable+bounces-33724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCFA891F4A
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99850288F2E
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EB785C43;
	Fri, 29 Mar 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zYtFZbqY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A376A032
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718115; cv=none; b=CSRvc+qyqHFRjdyrPRcO5fVf3qUmYg9HuL9AGfldRZGpowfwuHInyXHM2deMd4f6px/6qP1G30aQvGW6jxI3yHNxYxgg8Wu7DSXoI1vD7yLjL2JQLz9d+JXkoyzlBojW0gxj1b6eK0WBEpvcPibbYj4eXFEWQsyRsmA9y4lVcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718115; c=relaxed/simple;
	bh=SXxQmWkMYtTeEu0wM0ZZLc4fskX3b9plcxCm0Lm+APs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hn/UYhqz6X47L+cwEURPEmrvAn6FDRy3lEw4ykzibDUuOQnc+ZYtK4FxY8OBHFwaEGV5tBUUekrlnkYntxmCUB8SkJW5dZ8MNwF18x5R82oSl/LyIYdo9xByZEKdTMIvRh2BpkQsnV6Ct4kcdBik5OvfTY/w0QGue0H3j04TR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zYtFZbqY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C089C433F1;
	Fri, 29 Mar 2024 13:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711718115;
	bh=SXxQmWkMYtTeEu0wM0ZZLc4fskX3b9plcxCm0Lm+APs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zYtFZbqY4t5iRlyzs3H+Md7bJ44GInJXzapKKou50je2lT7VuxE8Q9Yexn6SmDF0T
	 sJS2WY6XucFfHroR7JHH0YcwAnlaG+YxzNKQrCx1Oh2GX7oYaKA3Ir9qxUTikSRwYA
	 2D55JLpM/R+JPBkjgKsvWVATtSQqAs6R7jrZpJFg=
Date: Fri, 29 Mar 2024 14:15:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: stable@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: v6.7+ stable backport request for drm/i915
Message-ID: <2024032904-reformed-pupil-7519@gregkh>
References: <ZfnpxcS2dXkzlExH@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfnpxcS2dXkzlExH@intel.com>

On Tue, Mar 19, 2024 at 09:38:45PM +0200, Ville Syrjälä wrote:
> Hi stable team,
> 
> Please backport the following the commits to 6.7/6.8 to fix
> some i915 type-c/thunderbolt PLL issues:
> commit 92b47c3b8b24 ("drm/i915: Replace a memset() with zero initialization")
> commit ba407525f824 ("drm/i915: Try to preserve the current shared_dpll for fastset on type-c ports")
> commit d283ee5662c6 ("drm/i915: Include the PLL name in the debug messages")
> commit 33c7760226c7 ("drm/i915: Suppress old PLL pipe_mask checks for MG/TC/TBT PLLs")
> 
> 6.7 will need two additional dependencies:
> commit f215038f4133 ("drm/i915: Use named initializers for DPLL info")
> commit 58046e6cf811 ("drm/i915: Stop printing pipe name as hex")

All now queued up, thanks.

greg k-h

