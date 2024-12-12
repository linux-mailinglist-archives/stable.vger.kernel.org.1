Return-Path: <stable+bounces-100883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E07A9EE486
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 11:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD86E1887336
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 10:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2319521129A;
	Thu, 12 Dec 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pSIsX5aJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB251F2381
	for <stable@vger.kernel.org>; Thu, 12 Dec 2024 10:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734000900; cv=none; b=I5kgOKiAe/e33SdtNgzWiTYLkhUsNYakVJceP7S8Babg+Nmtei8/gfuKA4uGPy/ua0eDc/SNgeh8FLCm9pMDRCiubUPGZDJi0ICYXPHbnqn36F3DTtR6XhdmibpnrBhOTGn1M1Idv5BS/fzEfUNUM0HIzjrQzgABisRuSwNvu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734000900; c=relaxed/simple;
	bh=bhlLOkeZapAGx9Fkhal6JZB6m9idaRZJ6S0JXkh61gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zd0t+3741jVVVi6nGgTDa38quOQW2rw4COwTSYDGlpnxJkHq4iAPSjD6rzR/vg3JCwgplUwZDm1knysn9BvqT+PQuqsxCv2lWMq3YQgYr+jNhI0Xg/mgyCiIt0WQfSdjgeqxtg1Px2/+2JMZiijxfoWl7dRosNee1/P9gChtyTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pSIsX5aJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2966C4CECE;
	Thu, 12 Dec 2024 10:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734000900;
	bh=bhlLOkeZapAGx9Fkhal6JZB6m9idaRZJ6S0JXkh61gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pSIsX5aJKvEbxj6E7pjIiBx7zsWzsCmQKj+yaoprZBb1Mgw2kvungnHdKjq1b9FU3
	 QA/QfOKZAKa8lnkqDd0hyIcqIj4bmcCcXSQ3IM0LIr5DMU66UdLp7endgQkaixqDCI
	 Xxx0UjyulFXOFzIT55P8c5GLtPrQIFmtP66zoim4=
Date: Thu, 12 Dec 2024 11:54:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Thomas Voegtle <tv@lio96.de>, Heming Zhao <heming.zhao@suse.com>,
	Su Yue <glass.su@suse.com>, stable@vger.kernel.org
Subject: Re: ocfs2 broken for me in 6.6.y since 6.6.55
Message-ID: <2024121244-virtuous-avenge-f052@gregkh>
References: <21aac734-4ab5-d651-cb76-ff1f7dffa779@lio96.de>
 <0f122ee5-56e3-45b0-b531-455fcf9cea3c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f122ee5-56e3-45b0-b531-455fcf9cea3c@linux.alibaba.com>

On Thu, Dec 12, 2024 at 06:41:58PM +0800, Joseph Qi wrote:
> See: https://lore.kernel.org/ocfs2-devel/20241205104835.18223-1-heming.zhao@suse.com/T/#t

And I need a working backport that I can apply to fix this :(

