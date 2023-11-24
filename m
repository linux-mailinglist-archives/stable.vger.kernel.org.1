Return-Path: <stable+bounces-302-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E707F7873
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 17:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56209B20B84
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8A43308A;
	Fri, 24 Nov 2023 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OnWMZ1E4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849E286B9
	for <stable@vger.kernel.org>; Fri, 24 Nov 2023 16:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD4FC433C7;
	Fri, 24 Nov 2023 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700841702;
	bh=vI/MyF6lOQjfT/bfivwL2lJH/Lh6KFcqez9eGWP16pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OnWMZ1E4031Qvpw1gOGteXuPjLdBQy80HReBT5b8RAJBY8dfU4idUPlWcqjqh/n8y
	 PM/nPMU+Jqs5zhLP9Tzlz3NOEXFRSxbdjxYIm1JPvw/jFLT7cF6He/f8ukrDVrVcFP
	 Qd7HYcih7TBUbTZwXvwyLjKSbQhkpn383OC7JyZI=
Date: Fri, 24 Nov 2023 16:01:40 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: He Gao <hegao@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15] Backport the fix for CVE-2023-25012 to kernel v5.15
Message-ID: <2023112429-huskiness-prone-4e26@gregkh>
References: <20231113193227.154296-1-hegao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113193227.154296-1-hegao@google.com>

On Mon, Nov 13, 2023 at 07:32:26PM +0000, He Gao wrote:
> This is the fix of CVE-2023-25012 for kernel v5.15.
> 
> Upstream commit:  https://github.com/torvalds/linux/commit/7644b1a1c9a7ae8ab99175989bfc8676055edb46
> 
> The affected code is in io_uring/io_uring.c instead of io_uring/fdinfo.c for v5.15. So the patch applies the same change to io_uring/io_uring.c.

Both backports now queued up, thanks.

greg k-h

