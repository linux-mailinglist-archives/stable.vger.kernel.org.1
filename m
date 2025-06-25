Return-Path: <stable+bounces-158612-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62045AE8AEE
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 19:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F2A3A78C5
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01972D9EEF;
	Wed, 25 Jun 2025 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHNahn6L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B692D5436;
	Wed, 25 Jun 2025 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870238; cv=none; b=FEXFj6xqUh4T6BQ7vRjzXcSm4RzAN6chtP8GySd0QEgdOrRyEFSwE1kICPC6DbdMg9/L2devIsRfHi3AOel2L80n7lrU7OJRuaMJMcI+tYQ88HIgM2g1yJXL2cQxBgRdx+7KaUZcZma1mIep8ELoarUqKV4LUDoXMBwYDH+1jlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870238; c=relaxed/simple;
	bh=/C5v0k5vwFElv+YbYy/5m/tariiZVeEQsCrYwhIpOgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5VcsrpEU+UM5KD1EWLGV/7ldOR7Q3oI31CcFVK8gbjdMlfFEgaupsOavH+q29eBexMqADstAWavTvdKTEeuHKSqVlMrTTT4X0NS8esTGzyPDMx6pnf+Hq04iJab+FfbW8mj+QfHdyiFbmQzbAuRqv8PRTn5If6h3cWPVOGDsVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHNahn6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23711C4CEEA;
	Wed, 25 Jun 2025 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870238;
	bh=/C5v0k5vwFElv+YbYy/5m/tariiZVeEQsCrYwhIpOgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jHNahn6LRu21+klp/cyu2n5YuMLCBWSbr4fTLnpMpKi7gOZxEV+S39okDcHLzcbph
	 6wZtiAsktCFPmTYkN9YsQ9bZsNbrsb3iG5iG9OLHzB0+kAghrrXHb/3JxnoeU+HU+Y
	 LFYKhahqlGStnmXkBzJQMi0mh69SU+kuehtKZZP7YICStbPI8+m2CDWR8w8TZQfAJo
	 t6mY8jWFUpfE2BbEyH1UrwhdRXogN8biZzNRmTNut9wRhGs/IqAPH33F2zzp0U0XlY
	 DGbx7tAemI8v33e4KdbZTSU/I3rZQk7QmSi8LG0Ik+7K/2g6vGutqnBr0A72HpVfuA
	 fY9Z8leedl0lw==
Date: Wed, 25 Jun 2025 17:50:34 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mengyuanlou@net-swift.com, duanqiangwen@net-swift.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: libwx: fix the creation of page_pool
Message-ID: <20250625165034.GG1562@horms.kernel.org>
References: <434C72BFB40E350A+20250625023924.21821-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <434C72BFB40E350A+20250625023924.21821-1-jiawenwu@trustnetic.com>

On Wed, Jun 25, 2025 at 10:39:24AM +0800, Jiawen Wu wrote:
> 'rx_ring->size' means the count of ring descriptors multiplied by the
> size of one descriptor. When increasing the count of ring descriptors,
> it may exceed the limit of pool size.
> 
> [ 864.209610] page_pool_create_percpu() gave up with errno -7
> [ 864.209613] txgbe 0000:11:00.0: Page pool creation failed: -7
> 
> Fix to set the pool_size to the count of ring descriptors.
> 
> Fixes: 850b971110b2 ("net: libwx: Allocate Rx and Tx resources")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


