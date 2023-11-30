Return-Path: <stable+bounces-3220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D67FF05B
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 14:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11EE0B20EA3
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 13:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD4A482C9;
	Thu, 30 Nov 2023 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jRtFzb4m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2138DE3;
	Thu, 30 Nov 2023 13:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 110A4C433C8;
	Thu, 30 Nov 2023 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701351656;
	bh=q45DORMSkGk8UwLHb+YCIhPn1+smyNc93IxGO9o+84Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRtFzb4mYg3flz8+fcSPOVf1RaGlngQN/gqXAUyHL3PNxAcpe2+tpVAc7NH5XCEhN
	 S/jY2ECVCd6hm/mq/i1F2xWDCC6191FImA7PVrUdbu1XohoTCjltNHOOaV5Rappfue
	 OvBDmpfc/QTXeybm7f2sxNlw+wIVaIIUJVAxJj0E=
Date: Thu, 30 Nov 2023 13:40:53 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	andrew.murray@arm.com, mark.rutland@arm.com, suzuki.poulose@arm.com,
	wanghaibin.wang@huawei.com, will@kernel.org
Subject: Re: [for-4.19 0/2] backport "KVM: arm64: limit PMU version to PMUv3
 for ARMv8.1"
Message-ID: <2023113045-headlock-improvise-cf6b@gregkh>
References: <20231128074633.646-1-yuzenghui@huawei.com>
 <2023112831-preachy-unshaved-790d@gregkh>
 <350d1f6f-953b-eac4-4e1b-9e59060c99bc@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <350d1f6f-953b-eac4-4e1b-9e59060c99bc@huawei.com>

On Tue, Nov 28, 2023 at 08:00:08PM +0800, Zenghui Yu wrote:
> On 2023/11/28 16:12, Greg KH wrote:
> > On Tue, Nov 28, 2023 at 03:46:31PM +0800, Zenghui Yu wrote:
> > > We need to backport patch #1 as well because it introduced a helper used
> > > by patch #2.
> > > 
> > > Andrew Murray (2):
> > >   arm64: cpufeature: Extract capped perfmon fields
> > >   KVM: arm64: limit PMU version to PMUv3 for ARMv8.1
> > 
> > We can not just take these in an old stable tree and not newer ones as
> > that would mean you could upgrade and have a regression.  Please provide
> > backports for all applicable stable trees and we will be glad to take
> > them.
> 
> Thanks for the heads up! "for-5.4" patches sent now.

Great, all now queued up, thanks.

greg k-h

