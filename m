Return-Path: <stable+bounces-116789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C59EA3A068
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 15:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFE6189902D
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999FC2500CD;
	Tue, 18 Feb 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wesm2oPX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D01DB361
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890063; cv=none; b=NQxNBtT9Brue4t8y8JrImrQP0zglcx9LVdr7IFBhunxg7sjL6199NecCZIUMvlQh6UOjWbG0kWiQtsXC+qaRC2fnabizPKBdfHaekrxuapY8GIvTQD0hHPlYVWNWoMQnNfCiG4MaPp2QUpok0Hk+9omyTyNhuNAGxNRi/DeDvxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890063; c=relaxed/simple;
	bh=AsPr1uKwJ5HOhkOl5Q0MbisHJUV4QXCilBUJS/IqwLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZ+kzYnFJW1JQqjgb/BnhmB+HeNMOVHOKvL8muIp5ZSv9UnE6Da9OiLk3VmSSKU7B5csauveXon6ZZwKigU+ItF/AHrZUHr3/B1Al33KsNx+4DBcw8lzxHflO7dxlXboycV+ELaXsOQMQP+5fcdC8MyYmXM63ReUbzpI+4p7jCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wesm2oPX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EA7C4CEE2;
	Tue, 18 Feb 2025 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739890063;
	bh=AsPr1uKwJ5HOhkOl5Q0MbisHJUV4QXCilBUJS/IqwLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wesm2oPXq6R4DEqaBHgsK4J121KxLdO/hte63bXG5jH6Z8CwEA+rlVbAdT1uI93JP
	 XnxMiFzzJPhHOVIsNWiIylSX+CN1SQguQAXqjsW/PN76Ng+/KVxvdAs9qtSRl0Eor0
	 3fq7Ofbgs/B7PUsEnXPZJp3LRAwP8+BzPH+iFr04=
Date: Tue, 18 Feb 2025 15:47:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: lanbincn@qq.com
Cc: stable@vger.kernel.org, Yang Erkun <yangerkun@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 5.15.y] nfsd: release svc_expkey/svc_export with rcu_work
Message-ID: <2025021848-mouth-destruct-c700@gregkh>
References: <tencent_4D4DC3879124B5B5140E1D0C64031B6D5706@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4D4DC3879124B5B5140E1D0C64031B6D5706@qq.com>

On Thu, Feb 13, 2025 at 07:46:56PM +0800, lanbincn@qq.com wrote:
> From: Yang Erkun <yangerkun@huawei.com>
> 
> commit f8c989a0c89a75d30f899a7cabdc14d72522bb8d upstream.

Why do you want a commit that was reverted because it was wrong to be
backported to a stable kernel tree?

Please fix your workflow to properly test and figure this thing out
ahead of time so that it doesn't waste our reviews.

thanks,

greg k-h

