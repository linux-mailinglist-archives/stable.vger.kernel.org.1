Return-Path: <stable+bounces-2869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A68F7FB3B2
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 09:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA85CB2138B
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 08:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E54D1640A;
	Tue, 28 Nov 2023 08:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UDuAcWI1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2D15AEA;
	Tue, 28 Nov 2023 08:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5677AC433CA;
	Tue, 28 Nov 2023 08:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701159134;
	bh=UC19cLX/am1tyUVqgR7l/ypb5xe0CmMMa/OY10J/5UM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UDuAcWI1u+j5easUv0wpld9clHbsBbup5GDOqUAen7GsMUaxC6ENr6h+sS4AdRali
	 unMf+rElT41B6sE1W8x6AZQz2wigbNHchM7SyA3o5VgBQ/0pEHElXVETb3Q6PK8cG5
	 gGVbi71DzV9+Rs0qw5Yz2t6dlJYKKKX2PFU+a/rI=
Date: Tue, 28 Nov 2023 08:12:10 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	andrew.murray@arm.com, mark.rutland@arm.com, suzuki.poulose@arm.com,
	wanghaibin.wang@huawei.com, will@kernel.org
Subject: Re: [for-4.19 0/2] backport "KVM: arm64: limit PMU version to PMUv3
 for ARMv8.1"
Message-ID: <2023112831-preachy-unshaved-790d@gregkh>
References: <20231128074633.646-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128074633.646-1-yuzenghui@huawei.com>

On Tue, Nov 28, 2023 at 03:46:31PM +0800, Zenghui Yu wrote:
> We need to backport patch #1 as well because it introduced a helper used
> by patch #2.
> 
> Andrew Murray (2):
>   arm64: cpufeature: Extract capped perfmon fields
>   KVM: arm64: limit PMU version to PMUv3 for ARMv8.1

We can not just take these in an old stable tree and not newer ones as
that would mean you could upgrade and have a regression.  Please provide
backports for all applicable stable trees and we will be glad to take
them.

thanks,

greg k-h

