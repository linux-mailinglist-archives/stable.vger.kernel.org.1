Return-Path: <stable+bounces-53789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393A290E63E
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7712283F2D
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F47F7C6DF;
	Wed, 19 Jun 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FaBOVCgX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009F42139B1
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786984; cv=none; b=eaujY7KevEjjZXdPvFAmFYQuOpjOPQdUdtHQsu3/GJcZcs1JYoW35SY6CV/CkmH0qVCTSmY5skjeHt8sxyEqqa30kaWo9bO5n6hXqEBbPGYESXoI16CMHLdk5NS884CJzNnrWCxyOISwVYjlRpGiq96A4XzJb0jxPErE4Six8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786984; c=relaxed/simple;
	bh=fcZDrjD29BXKZPcDZwkx78OBSTrsUN8FD8jiw4Q/8A4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jw3I3c/nv+kFm/imO1lvqQlXuCtCJ//3J3PglkYr5our13iOcmyz+pzEu8XL4gWclXKtkGoUhOW46oml4eS+Wh8nO4FFT/MTyXuMYdSwPODWVXS6v3ZoBw7IwYByMoB2Dzzh6p1djKb57C0XN4IXzX/NXCPQrCCQs8bmDkx3kuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FaBOVCgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708C0C2BBFC;
	Wed, 19 Jun 2024 08:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786983;
	bh=fcZDrjD29BXKZPcDZwkx78OBSTrsUN8FD8jiw4Q/8A4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FaBOVCgXvAeqfGIAKVm5PFdaLSgUXUkf9A8N53xN53ggwoA1GDu+HZuk7MZ7TDvXV
	 Vud4vahQLc3z5YnD9hL4peHoXHK0BzNcnUA5u5r4jXhWjN/CScG+71eDLXf3xJZ6Es
	 6GPKaZ76w/6+syEXQWvmVK2UrxC4a26l3xf3MN4c=
Date: Wed, 19 Jun 2024 10:49:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: stable@vger.kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	pabeni@redhat.com, kuba@kernel.org, bpoirier@nvidia.com,
	idosch@nvidia.com
Subject: Re: [PATCHv2 6.6.y 1/3] selftests/net: add lib.sh
Message-ID: <2024061911-crinkly-pointer-f564@gregkh>
References: <20240618075306.1073405-1-po-hsu.lin@canonical.com>
 <20240618075306.1073405-2-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618075306.1073405-2-po-hsu.lin@canonical.com>

On Tue, Jun 18, 2024 at 03:53:04PM +0800, Po-Hsu Lin wrote:
> From: Hangbin Liu <liuhangbin@gmail.com>
> 
> commit 25ae948b447881bf689d459cd5bd4629d9c04b20 upstream.
> 
> Add a lib.sh for net selftests. This file can be used to define commonly
> used variables and functions. Some commonly used functions can be moved
> from forwarding/lib.sh to this lib file. e.g. busywait().
> 
> Add function setup_ns() for user to create unique namespaces with given
> prefix name.
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  tools/testing/selftests/net/Makefile          |  2 +-
>  tools/testing/selftests/net/forwarding/lib.sh | 27 +--------
>  tools/testing/selftests/net/lib.sh            | 85 +++++++++++++++++++++++++++
>  3 files changed, 87 insertions(+), 27 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib.sh

This patch fails to apply on the lates 6.6.y tree:
	checking file tools/testing/selftests/net/Makefile
	Hunk #1 FAILED at 54.
	1 out of 1 hunk FAILED
	checking file tools/testing/selftests/net/forwarding/lib.sh
	checking file tools/testing/selftests/net/lib.sh

Please rebase and resubmit.

thanks,

greg k-h

