Return-Path: <stable+bounces-53819-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FE790E8BE
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C2E21F21100
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C412C132100;
	Wed, 19 Jun 2024 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bK0jPE2L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A9B4D8B2
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 10:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718794537; cv=none; b=pTRTfEOmO0n42XXMsxpV7U00SHuN42hiZaDeptpxVwErRwW69zpqMl0eu1v9F5q6i8H2+MAlkaE/Jp2REonFK3lAA9kCttTtugJ3/RxCFLTj0woE/l4iSH5q1APC9Hcmgw6x8pZiW1wbLQOjCCCva1cy2IEt0nnFbJi3KX90HEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718794537; c=relaxed/simple;
	bh=ELYn4QCdENU+Ldd4wWsyEdrinhJg/5B4gj4eY8Fs+rE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXy3ZAJDcicEv/NNIuyobnU4e8BSXcvmRLwXvLGyfDRK+S3W0l+O27yS9W5NbC9mMO7S7hU4mgtvfeaTLcPQES8ypacB7lBqSTjuo2+8SKXAaiWvUWJH2Qdaoj5JfFrCwsnSdVyEu2jqpuXGTWLL185jpM6bjCNJPI9ZbgYPmdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bK0jPE2L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC77C32786;
	Wed, 19 Jun 2024 10:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718794537;
	bh=ELYn4QCdENU+Ldd4wWsyEdrinhJg/5B4gj4eY8Fs+rE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bK0jPE2LZ0NTHFemEcXIVljH+AgwWT8fL+nEaHh9t1jNgWxNBv9/YevrFT++nV5gn
	 L8X665oA++CMl1ndvSbCfwrgb704JADDkpFe6AMSD3lznrrc7ync34SrKQn7GAptn4
	 81RU63BbI0tzmMR55i5qYCpnRoj/aA9QHk2OJb0I=
Date: Wed, 19 Jun 2024 12:55:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: stable@vger.kernel.org, petrm@nvidia.com, liuhangbin@gmail.com,
	pabeni@redhat.com, kuba@kernel.org, bpoirier@nvidia.com,
	idosch@nvidia.com
Subject: Re: [PATCHv3 6.6.y 0/3] Fix missing lib.sh for
 net/unicast_extensions.sh and net/pmtu.sh tests
Message-ID: <2024061921-prepay-upcoming-84db@gregkh>
References: <20240619093924.1291623-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619093924.1291623-1-po-hsu.lin@canonical.com>

On Wed, Jun 19, 2024 at 05:39:21PM +0800, Po-Hsu Lin wrote:
> Since upstream commit:
>   * 0f4765d0 "selftests/net: convert unicast_extensions.sh to run it in
>     unique namespace"
>   * 378f082e "selftests/net: convert pmtu.sh to run it in unique namespace"
> 
> The lib.sh from commit 25ae948b "selftests/net: add lib.sh" will be needed.
> Otherwise these test will complain about missing files and fail:
> $ sudo ./unicast_extensions.sh
> ./unicast_extensions.sh: line 31: lib.sh: No such file or directory
> ...
> 
> $ sudo ./pmtu.sh
> ./pmtu.sh: line 201: lib.sh: No such file or directory
> ./pmtu.sh: line 941: cleanup_all_ns: command not found
> ...
> 
> Another commit b6925b4e "selftests/net: add variable NS_LIST for lib.sh" is
> needed to add support for the cleanup_all_ns above.
> 
> And 2114e833 "selftests: forwarding: Avoid failures to source net/lib.sh" is
> a follow-up fix for tests inside the net/forwarding directory.
> 
> V2: Add 2114e833 "selftests: forwarding: Avoid failures to source net/lib.sh"
>     as suggested by Hangbin Liu.
> V3: Adjust commit 25ae948b to add lib.sh directly to TEST_FILES in Makefile,
>     as we already have upstream commit 06efafd8 that would make this change
>     landed in 6.6.y.

Thanks for the quick response, now queued up.

greg k-h

