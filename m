Return-Path: <stable+bounces-113962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ACCA29ADC
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E12C169C06
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 20:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B83E214A6A;
	Wed,  5 Feb 2025 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0vG1fwS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D01D6DD4;
	Wed,  5 Feb 2025 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738786231; cv=none; b=GSs9k4vtevVQnH07irVvXF4UbfeiJgy/bcwyZsEXotd3WS5tPkehG1wdyxgVR4EtdI0ZIGySbhOz9W/tlZJvpdm+skk9JxLLxj6xtpzmA6s5VpI2weXgqnGJRpO9XcCR8BNrbaSgUmIPP0VSjEh8QZxmTNHisL43ROslWUe06gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738786231; c=relaxed/simple;
	bh=n5Fu9QQKG274QOcfOnLbIuHfV+7+uC51NIfVkJyjpUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nba9lmhraQkTCyeLGSVSPbDs9O/3pn7GCIww8o5nBeDXmDP3Vr+2AdKNkcOMVDNXNQss5d2KlOTDkIUS0RU7G6/eaJgesuIeLxcxo9e7IVqSB8F2qjdK4jwZLrmh86aGc2lA01K1Ce+p/A3NjTvhiDiEM58JhFDnmBoZw6SNPms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0vG1fwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B01C4CED1;
	Wed,  5 Feb 2025 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738786230;
	bh=n5Fu9QQKG274QOcfOnLbIuHfV+7+uC51NIfVkJyjpUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0vG1fwSrABA9KsB/GC3atYToYgUnehdtv5U1rahq7r6NUCKCxVDZRqW0LDgquv8M
	 bEOWhROAEucIWEEcgrTrYL69PObFHuAfjtUjliTBKd7FWDuJjs4AkFW4ncLqq5yqQh
	 z2lcMDUCzkgICFWMLPEYxEuvLdMGG1nriNejoGkpyNXQu7H1qjRXS2/Jc+aJEGaNRb
	 iPrnu18g9s7G802Y0JOzyWoWhtmYYdmPdE/aRlQnDkU+f6alj/hNtM7E1WqyY9GnzL
	 943ze64Hep2uRbCL10E/TJndQkGzur1fnttdrTZPcgivhCDWd9h1mLFXPctL2R1nQz
	 FA6TTCGXE3xMQ==
Date: Wed, 5 Feb 2025 20:10:25 +0000
From: Simon Horman <horms@kernel.org>
To: Song Yoong Siang <yoong.siang.song@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Malli C <mallikarjuna.chilakala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v1 1/1] igc: Set buffer type for empty frames in
 igc_init_empty_frame
Message-ID: <20250205201025.GL554665@kernel.org>
References: <20250205023603.798819-1-yoong.siang.song@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205023603.798819-1-yoong.siang.song@intel.com>

On Wed, Feb 05, 2025 at 10:36:03AM +0800, Song Yoong Siang wrote:
> Set the buffer type to IGC_TX_BUFFER_TYPE_SKB for empty frame in the
> igc_init_empty_frame function. This ensures that the buffer type is
> correctly identified and handled during Tx ring cleanup.
> 
> Fixes: db0b124f02ba ("igc: Enhance Qbv scheduling by using first flag bit")
> Cc: stable@vger.kernel.org # 6.2+
> Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

