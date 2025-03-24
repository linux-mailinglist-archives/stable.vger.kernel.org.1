Return-Path: <stable+bounces-125860-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD652A6D56C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 08:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60363188C053
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 07:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE652512D1;
	Mon, 24 Mar 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQ7H+DKr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96DC2500DA;
	Mon, 24 Mar 2025 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802595; cv=none; b=Ncyds/bSjL+CV4yCl4we/25p20DJq5q9CBYvrxQ0adUCBeqvswTensffyQbJmuhmtKf1bn7Fo4Hg4actCTPwxxW5SLrk2nTr/sPdURtuxtpLVRTN3leGAvlLGmvGgcXjTqYZzAieKjhRDmJeceMSGT5r0eMc0xIyYoTQ+fVWfJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802595; c=relaxed/simple;
	bh=jNLDCdJFoig06EFMoOmwsoZUr7jPMKWh4pnzp/qGePI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCeuybDycQkWEX6Cud0nUD0+VmhqFMcYfV9vLJcIPlCK9nPeRvLVXIV8BlctPHj8yLgIqx01D9PkeSY3tLAzz6XH96+sq7xHol72h3MB8umWzhRjEcpaCvgP5CO7Z4SxSnyDibiNtUQsQb68eWudpBT0AZVMw6E4sFg/bFd8ZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQ7H+DKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625CBC4CEEF;
	Mon, 24 Mar 2025 07:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742802594;
	bh=jNLDCdJFoig06EFMoOmwsoZUr7jPMKWh4pnzp/qGePI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQ7H+DKr4qbzeYG15TxlnrwjiGM974B0SG2GEAKppknwg7rZqtovB9o1PA5hFPSrd
	 +8PRrF/Zc9/KSf5QETr7yITWJp/v4ZN4v1EXv2buBta6Jy621IQX24Pg/llOeRY0x2
	 AbPs/923M5SMwRlWmpZk3I+IXX4YwfN+6ak0sjj8PHkm2yOH6IHtrCBSIZHdH1XsgA
	 kXcPaqmDG9b1mDdR37RtiQmCkvp5jukdfsEnnEo1jGDEB4SqLEbMg1j/AHHj81bqDH
	 VPhsXwo4T29SQP4whsqfESGYkw/gDdEQqRPaIE8x4w9kPFJj23+bDifu6uMczoeagp
	 shSPxqW4OaUfA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1twcZE-000000001Vo-2hf6;
	Mon, 24 Mar 2025 08:49:53 +0100
Date: Mon, 24 Mar 2025 08:49:52 +0100
From: Johan Hovold <johan@kernel.org>
To: Clayton Craft <clayton@craftyguy.net>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Miaoqing Pan <quic_miaoqing@quicinc.com>,
	Steev Klimaszewski <steev@kali.org>,
	Jens Glathe <jens.glathe@oldschoolsolutions.biz>,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: fix rx completion meta data corruption
Message-ID: <Z-EOoIjhOXrT84gX@hovoldconsulting.com>
References: <20250321145302.4775-1-johan+linaro@kernel.org>
 <51a59b41-4214-4e24-bfe8-3d8174ba1a3b@craftyguy.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51a59b41-4214-4e24-bfe8-3d8174ba1a3b@craftyguy.net>

On Sun, Mar 23, 2025 at 11:15:54PM -0700, Clayton Craft wrote:
> On 3/21/25 07:53, Johan Hovold wrote:
> > Add the missing memory barrier to make sure that the REO dest ring
> > descriptor is read after the head pointer to avoid using stale data on
> > weakly ordered architectures like aarch64.
> > 
> > This may fix the ring-buffer corruption worked around by commit
> > f9fff67d2d7c ("wifi: ath11k: Fix SKB corruption in REO destination
> > ring") by silently discarding data, and may possibly also address user
> > reported errors like:
> > 
> > 	ath11k_pci 0006:01:00.0: msdu_done bit in attention is not set
> > 
> > Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> > 
> > Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> > Cc: stable@vger.kernel.org	# 5.6
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=218005
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> > 
> > As I reported here:
> > 
> > 	https://lore.kernel.org/lkml/Z9G5zEOcTdGKm7Ei@hovoldconsulting.com/
> > 
> > the ath11k and ath12k appear to be missing a number of memory barriers
> > that are required on weakly ordered architectures like aarch64 to avoid
> > memory corruption issues.
> > 
> > Here's a fix for one more such case which people already seem to be
> > hitting.
> > 
> > Note that I've seen one "msdu_done" bit not set warning also with this
> > patch so whether it helps with that at all remains to be seen. I'm CCing
> > Jens and Steev that see these warnings frequently and that may be able
> > to help out with testing.
> 
> Before this patch I was seeing this "msdu_done bit" an average of about 
> 40 times per hour... e.g. a recent boot period of 43hrs saw 1600 of 
> these msgs. I've been testing this patch for about 10 hours now 
> connected to the same network etc, and haven't seen this "msdu_done bit" 
> message once. So, even if it's not completely resolving this for 
> everyone, it seems to be a huge improvement for me.
> 
> 0006:01:00.0 Network controller: Qualcomm Technologies, Inc QCNFA765 
> Wireless Network Adapter (rev 01)
> ath11k_pci 0006:01:00.0: chip_id 0x2 chip_family 0xb board_id 0x8c 
> soc_id 0x400c0210
> ath11k_pci 0006:01:00.0: fw_version 0x11088c35 fw_build_timestamp 
> 2024-04-17 08:34 fw_build_id 
> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Tested-by: Clayton Craft <clayton@craftyguy.net>

Thanks for testing and confirming my suspicion.

Johan

