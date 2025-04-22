Return-Path: <stable+bounces-135008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DED4BA95DBA
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 08:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5E427A42A3
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 06:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7739119DF4D;
	Tue, 22 Apr 2025 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WulCfdCX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3695B1624DF
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 06:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302001; cv=none; b=Cx98iDz6+memzqzkt4G7fjecd4ba7HPx6f55iA82+EZxeQCxP6XtNCZQbJpMJbUmwv7SbD5kkN5Mn0zW4sW29cnjdQU/ILgow1dWjDFtURyy6MdIdEIXM2t6TEgwEgKMkw8aFA0JN7ulIl/kbCbKrQP/KdJXJprFLCiYgfmM9UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302001; c=relaxed/simple;
	bh=K2X0GhseZVdLu7+UMa6iuqiB821pYMxUdxCViamSCvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVhs/vFjIjei7I12uS9mqzmIUyEfgxusTS9eyYj8FreXp7YAsG7wJb07/h05Z/pEshVWKl9eIHIOFr8THuidZXOOyvLZyJE1rI+H2n10gVBIEGEUdpGJ/FxFTFpjuXiMIL0qOEdTN5PjWBAyVKVF4sp8mcwjqIIoBlijFW64C68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WulCfdCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38768C4CEE9;
	Tue, 22 Apr 2025 06:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745302000;
	bh=K2X0GhseZVdLu7+UMa6iuqiB821pYMxUdxCViamSCvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WulCfdCXZD82Jv+2J2jaMlZrc3ZWPVC2LL7RzPTIFhZsbkxlTr6WwoJ7QWy32kKET
	 0Djv0YhrrhWpcRoqg7RN+hagc8PxLAbdNX/Q9t5w8rR7IvMguuxY1vfn77DVPJzTii
	 HbE+uAt3SwgSdtZV4orNezcaJVd+dRPSTmhqoQ+g=
Date: Tue, 22 Apr 2025 08:06:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Please apply d2155fe54ddb to 5.10 and 5.4
Message-ID: <2025042251-energize-preorder-31cd@gregkh>
References: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALW65jbBY3EyRD-5vXz6w87Q+trxaod-QVy2NhVxLNcQHVw0hg@mail.gmail.com>

On Tue, Apr 22, 2025 at 02:04:45PM +0800, Qingfang Deng wrote:
> Hi Greg and Sasha,
> 
> Please consider applying d2155fe54ddb ("mm: compaction: remove
> duplicate !list_empty(&sublist) check") to 5.10 and 5.4, as it
> resolves a -Wdangling-pointer warning in recent GCC versions:
> 
> In function '__list_cut_position',
>     inlined from 'list_cut_position' at ./include/linux/list.h:400:3,
>     inlined from 'move_freelist_tail' at mm/compaction.c:1241:3:
> ./include/linux/list.h:370:21: warning: storing the address of local
> variable 'sublist' in '*&freepage_6(D)->D.15621.D.15566.lru.next'
> [-Wdangling-pointer=]

All mm patches MUST get approval from the mm maintainers/developers
before we can apply them to stable kernels.

Can you please do that here?

thanks,

greg k-h

