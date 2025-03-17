Return-Path: <stable+bounces-124605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C97BDA64243
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 07:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073D6188C60F
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 06:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7F4218E82;
	Mon, 17 Mar 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0aEIKTPu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA041E1E0F
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194738; cv=none; b=UHCjpA5ZAmjf/mTzoh1EPURGsW0VrRV0/Mza6yVVSMGeUoIv1Jia8IcSrdu63M3cc7CALcn0Z+S6OebobOfkJpYr7AM8CTa63xsPWP+xFCw6jTcDkYx81MkxEbJASAOKKql3NOhXO7Q+w4yafTeC4QcmWqBxFkUAJ8q7JIZFZrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194738; c=relaxed/simple;
	bh=iiDOl0V+evEFD0Anew+Gu2soQ3O/8iWDnwxQQ+io10I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngJJsopig8HVZKE5KtTObKVU5FiGWIY/X7ZllhTKvGfyNSeWfigBTxTxUI3ZlZfJ6PPkOkcQuZ0GdPWYWjrl7cMSq0K4JALPfjjMt/nRxOgghEq5JWU1/ihhSxyEKEAoTmADSPbOTzV0bnxqAd9mwGS7fpd55+IHUCRXX582sak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0aEIKTPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE4BC4CEE3;
	Mon, 17 Mar 2025 06:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742194737;
	bh=iiDOl0V+evEFD0Anew+Gu2soQ3O/8iWDnwxQQ+io10I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0aEIKTPuqKSo6HiMKKjQNodO6SuQ4wmX/06cda6oaK1eLCdaQ/HsyBPN2OFSp6fX6
	 sixeqMu3sMywvYinmdyVpwRT8it0m3r423fLfGcdhdEep4UY8irfBEy4NMELHeAHnm
	 mxpSeovQnf5GZAUWWEAhr+PtRVSmfD8Q3O2qyxXg=
Date: Mon, 17 Mar 2025 07:57:38 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
Cc: mqaio@linux.alibaba.com, mhiramat@kernel.org, stable@vger.kernel.org,
	zhe.he@windriver.com
Subject: Re: [RFC PATCH 5.15/5.10] uprobe: avoid out-of-bounds memory access
 of fetching args
Message-ID: <2025031710-plexiglas-siding-d0e8@gregkh>
References: <20250317065429.490373-1-xiangyu.chen@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317065429.490373-1-xiangyu.chen@eng.windriver.com>

On Mon, Mar 17, 2025 at 02:54:29PM +0800, Xiangyu Chen wrote:
> From: Qiao Ma <mqaio@linux.alibaba.com>
> 
> [ Upstream commit 373b9338c9722a368925d83bc622c596896b328e ]

<snip>

Why is this an RFC?  What needs to be done to make it "real" and ready
for you to submit it for actual inclusion?

thanks,

greg k-h

