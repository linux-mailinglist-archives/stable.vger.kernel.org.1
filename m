Return-Path: <stable+bounces-100537-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0242B9EC551
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C64E516426D
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 07:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3655E1C1AD4;
	Wed, 11 Dec 2024 07:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mhyGCt5B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC81C683
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 07:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900793; cv=none; b=uiM1Ny7/Hvy5f9da/BF0c6jpjNCvRzVmLAukzTrwkoUGcCqxi02fihZDoMH80TGrt0WDL+FPZXKfUqqpYd7hIpmLSk12pn06VgEQbo5yGCKee22L5nrSvAAWEywdnlZkdeqVBkoEF4X8plkrug1hhzsREN1dLyGF/Y4KCdlDBy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900793; c=relaxed/simple;
	bh=tc03L+lc2sOgOtXoGB2tQZporjBsxDjE7qm0OKxzhy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iayiZQwtmGTmP0tO8kzF0+oLi0HUMQeRgPdyRAJ/0YK7F1uM8lOJLwN8afmIAB3b5Oq/h+J5pFc4ImmVQsrpyKIdeqEXJDx0pWZdRX/VHWz3nAJbyXObrUW1KeL8zUmI1YiIqp9rooprVX42YOVfuz+nDAoA2lWWt2pJg4EJhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mhyGCt5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00893C4CED2;
	Wed, 11 Dec 2024 07:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733900793;
	bh=tc03L+lc2sOgOtXoGB2tQZporjBsxDjE7qm0OKxzhy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mhyGCt5BgMTlsKdO6HeL4rb1KdGT1jdAuuiiJz5xogF01ARbq8KjKVGeo3sy8ilqK
	 WjlCsK4i1Bk6OANKc+IeE0ItyTxBCJZ67g6hvNB3WqWlcAPnJmQ8BbtYU5pV4mY+4S
	 VzoJb7YctOGDx8etRap5DKGXoqQOWgjI7efbScw4=
Date: Wed, 11 Dec 2024 08:05:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: libo.chen.cn@eng.windriver.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15] crypto: hisilicon/qm - inject error before stopping
 queue
Message-ID: <2024121131-huddling-selective-f114@gregkh>
References: <20241211052959.4171186-1-libo.chen.cn@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211052959.4171186-1-libo.chen.cn@eng.windriver.com>

On Wed, Dec 11, 2024 at 01:29:59PM +0800, libo.chen.cn@eng.windriver.com wrote:
> From: Weili Qian <qianweili@huawei.com>
> 
> [ Upstream commit b04f06fc0243600665b3b50253869533b7938468 ]

<snip>

Why are you not also cc:ing all of the people involved in these commits
when sending backports?

Please fix this up for all of these and resend.

thanks,

greg k-h

