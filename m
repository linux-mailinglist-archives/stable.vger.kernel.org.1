Return-Path: <stable+bounces-125840-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B04A6D40F
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345361887DDD
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8860743159;
	Mon, 24 Mar 2025 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b="AW+seEM8"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB9BE5E
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 06:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796967; cv=none; b=h+nHZvH5i/0lCwE+BOp41+cfcxiTMhPmPFCiY+lQMNsXnIdf6Hu+uaZpn7cc4qmTdx9+gk7MhHjQmJx9/K/6CFcGydQVtRHGO8BMcQftEKTGG9oxGjY+6eDuS4UCilo14tTVaNC0s6ndWPzzG8M3xRPxJzcCvwPIx+kS7SzkNJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796967; c=relaxed/simple;
	bh=T0fMoQbxKTs+J5RN/iwSWQZM40qUvOQCb8V4cNqTR+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bI5wqDYacXWp5btOQVcGxv2mpABoZXwfDtK13JzxCR84bt0Wymkmft7YmV9dKc/S2ldz/nw2KqKDl6J0a/FYps9H4mRu4wWQssv/FnliZwjF73HvxCpjc/F7bAfHF5LQ13Pqo39LZhAPqSphe88mEQWfqMJj2G1KOBJyffSP9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=craftyguy.net; spf=pass smtp.mailfrom=craftyguy.net; dkim=pass (2048-bit key) header.d=craftyguy.net header.i=@craftyguy.net header.b=AW+seEM8; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=craftyguy.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=craftyguy.net
Message-ID: <51a59b41-4214-4e24-bfe8-3d8174ba1a3b@craftyguy.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=craftyguy.net;
	s=key1; t=1742796960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C8JLMiI733S4xTq1mEOv/zfYlCWUzTNqm+0T4v8oraU=;
	b=AW+seEM8/syKljhEMGkSA3KPt7Al/dEjX1dKgxcynyPa3TzM90Nkz9NV5h8KEnLn5A68h3
	FxZ6EH8ioKxSvJL8hLKfdMixNTsT1QFvBtLxgxyOianttCUaek8gCrrGfuPeTP8L4ClgDk
	/oflXwoN9AcoCuO9PVKg40w3+QxUYU0r/IkmqPYasPmFdRgNfNiDACSNNgGvkkf3+046cO
	4Wv+hZdpFk9byAk/ls69EtsmpsGckON7smiMeAU+T6Mrv3dhjmYhxhQrl9bNv3OcFeluYF
	2Z5lRmC8sbkYx5+7Aj/ikPyxRWFKIhxg2f3ojVkpM27iEeSnQZIfZ/kXVurXSA==
Date: Sun, 23 Mar 2025 23:15:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] wifi: ath11k: fix rx completion meta data corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: Miaoqing Pan <quic_miaoqing@quicinc.com>,
 Steev Klimaszewski <steev@kali.org>,
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250321145302.4775-1-johan+linaro@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Clayton Craft <clayton@craftyguy.net>
In-Reply-To: <20250321145302.4775-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/21/25 07:53, Johan Hovold wrote:
> Add the missing memory barrier to make sure that the REO dest ring
> descriptor is read after the head pointer to avoid using stale data on
> weakly ordered architectures like aarch64.
> 
> This may fix the ring-buffer corruption worked around by commit
> f9fff67d2d7c ("wifi: ath11k: Fix SKB corruption in REO destination
> ring") by silently discarding data, and may possibly also address user
> reported errors like:
> 
> 	ath11k_pci 0006:01:00.0: msdu_done bit in attention is not set
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org	# 5.6
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218005
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> As I reported here:
> 
> 	https://lore.kernel.org/lkml/Z9G5zEOcTdGKm7Ei@hovoldconsulting.com/
> 
> the ath11k and ath12k appear to be missing a number of memory barriers
> that are required on weakly ordered architectures like aarch64 to avoid
> memory corruption issues.
> 
> Here's a fix for one more such case which people already seem to be
> hitting.
> 
> Note that I've seen one "msdu_done" bit not set warning also with this
> patch so whether it helps with that at all remains to be seen. I'm CCing
> Jens and Steev that see these warnings frequently and that may be able
> to help out with testing.
> 

Before this patch I was seeing this "msdu_done bit" an average of about 
40 times per hour... e.g. a recent boot period of 43hrs saw 1600 of 
these msgs. I've been testing this patch for about 10 hours now 
connected to the same network etc, and haven't seen this "msdu_done bit" 
message once. So, even if it's not completely resolving this for 
everyone, it seems to be a huge improvement for me.

0006:01:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765 
Wireless Network Adapter (rev 01)
ath11k_pci 0006:01:00.0: chip_id 0x2 chip_family 0xb board_id 0x8c 
soc_id 0x400c0210
ath11k_pci 0006:01:00.0: fw_version 0x11088c35 fw_build_timestamp 
2024-04-17 08:34 fw_build_id 
WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Tested-by: Clayton Craft <clayton@craftyguy.net>

