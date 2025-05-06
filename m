Return-Path: <stable+bounces-141844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495CAAC9DB
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 17:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B13698164D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 15:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C465C284686;
	Tue,  6 May 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XprHAZDI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3CC284677;
	Tue,  6 May 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746546477; cv=none; b=Il9xISlGJj0VJXBSLKl9duCln4oJvRJPQEXS2+ztAsnqvMbgX2o8iyK7Mbl2HVXrVY5Qp0xsqoIjelDeAxDvDVT462UZvqROheMBUv7c236goD0MtOElJpIxBBotV0Dieai4o2WBpFLpDmKw13SfAPBXTcDZjgOV4+HQvDF1+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746546477; c=relaxed/simple;
	bh=VlKeYwcQaeqU/yvMlvTPQlqWno4hH3XvK4blLqFDaIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tawtn6fLQDHqmEMsDTq+VMSABCTGYpXs2GVfRzaZYqO/2f4gNrlelDEOUe3nFC4bYwSnd/NLjO8vyq23SahpdE6h69N0KYNbjidf2ALhcP/5ImHeekNMfNt5HPBGQ2zVyfe+3uEJKARkgXStZCGEgTGw1260yT8XAdEhAiL/8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XprHAZDI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E769AC4CEE4;
	Tue,  6 May 2025 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746546476;
	bh=VlKeYwcQaeqU/yvMlvTPQlqWno4hH3XvK4blLqFDaIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XprHAZDIFW5jMFgCdD77umcWmeVNB59N9749ubg+qebmsLWLOTaMt4cMlnI17m5gu
	 LkZL1VLjbNNSeKgld8nAEw+B1vmZLxkKTNK+mzcJBdpffbetRoatjnR3w2VTiyKvfy
	 RM1a7UN6Yne2h4jiAEkAa/LysnQznb1AFrJjqhjB9LXTYgliModHPd+2uNBvqe+P7g
	 ax6DwUvdDMDIyDaZkcXrTlyw+ZR0tKvjClQKM+mpy9Pw0QAuogthsFtbRfpmeAqZum
	 xGX/PYJFWp6hcYV3A4+ROuITLc1WGK6KJatbiZSkqHvp5Od1huDQl7ZQ8RCxQbiVPo
	 cDOxSuyMgOrPQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uCKWP-000000008O4-02Ki;
	Tue, 06 May 2025 17:47:53 +0200
Date: Tue, 6 May 2025 17:47:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Steev Klimaszewski <steev@kali.org>,
	Clayton Craft <clayton@craftyguy.net>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: fix ring-buffer corruption
Message-ID: <aBovKWIyPRWG-DSR@hovoldconsulting.com>
References: <20250321094916.19098-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321094916.19098-1-johan+linaro@kernel.org>

Hi Jeff,

On Fri, Mar 21, 2025 at 10:49:16AM +0100, Johan Hovold wrote:
> Users of the Lenovo ThinkPad X13s have reported that Wi-Fi sometimes
> breaks and the log fills up with errors like:
> 
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1484, expected 1492
>     ath11k_pci 0006:01:00.0: HTC Rx: insufficient length, got 1460, expected 1484
> 
> which based on a quick look at the driver seemed to indicate some kind
> of ring-buffer corruption.
> 
> Miaoqing Pan tracked it down to the host seeing the updated destination
> ring head pointer before the updated descriptor, and the error handling
> for that in turn leaves the ring buffer in an inconsistent state.
> 
> Add the missing memory barrier to make sure that the descriptor is read
> after the head pointer to address the root cause of the corruption while
> fixing up the error handling in case there are ever any (ordering) bugs
> on the device side.
> 
> Note that the READ_ONCE() are only needed to avoid compiler mischief in
> case the ring-buffer helpers are ever inlined.
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218623
> Link: https://lore.kernel.org/20250310010217.3845141-3-quic_miaoqing@quicinc.com
> Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Cc: stable@vger.kernel.org	# 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

This patch fixes a long-standing issue that is hurting user of machines
like the X13s, but as far as I can tell it has not been picked up yet
(perhaps due to the temporary MAINTAINERS glitch that caused the
wireless list not to be CCed?).

Would be good to get this fixed in 6.15 and backported to stable.

The following related patches are also not yet in linux-next:

	https://lore.kernel.org/lkml/20250321145302.4775-1-johan+linaro@kernel.org/
	https://lore.kernel.org/lkml/20250321095219.19369-1-johan+linaro@kernel.org/

Note that I still intend to sending follow-on fixes for the other
missing barriers, but I'm a bit short on time at the moment.

Johan

