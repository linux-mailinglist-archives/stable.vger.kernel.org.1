Return-Path: <stable+bounces-57948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E7892647F
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 17:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967EF1F22057
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2472181B9A;
	Wed,  3 Jul 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip5Iq2He"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB85E17E8EE;
	Wed,  3 Jul 2024 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019440; cv=none; b=nRiHXrdjYK1fC8XT4FTJKoLL6InUpHqYqF5LDbQBer6dj7arBpf5Ln0W9DYkXvcW+UYBYTi5lKOmECfSabGJdHb18XfXWMWX0yyxFkOnR89M01+zpYjnNb3pSQ/HuQYmd4YDgrsSn/qj9YyrXNP+QWqw9rpiXObvf+E/6Jzizxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019440; c=relaxed/simple;
	bh=z5NT7nklWyh3rDy0r1YW8buRwoHbBrZ6LTh94YKUM84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRRjgCWpfvRGqUjWMfhqw0ReFAYgAwwXosr9DSagVxk1IcWJnQMl7GTgcCarVpMVNI18bJtJWFmJEUCeLUVg0YHGR++a6gg5NYUg7xF7h5sZTyKNt09DK/AY/xMEdkjwZoJI88r8euwioiZ12JXVQyR2xdhxnovVeTIiPZ1LIa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip5Iq2He; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C715DC2BD10;
	Wed,  3 Jul 2024 15:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019440;
	bh=z5NT7nklWyh3rDy0r1YW8buRwoHbBrZ6LTh94YKUM84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ip5Iq2HezpBHXYt/93hPbeMG7Zo/ec1gIvdcgAC9d8gL6AZN3LQUDCb874Tj88Cho
	 4tKk+8DPYZFlQia57yoq0HWevC8Kw+XR+C7ZmDpCmXW+slcUp/I9w4zd/7EtxgG7K3
	 /WrPDnpnK1Ki+fsWWSOAKR7hB6o4C05njYsnmFYyHb3sSeSCbaE30Mu2aXzk4YmoXx
	 sEh9a5qkKq6KPKr+OGXfp4WnQLO2lYWnsouQXl3XbmCCMChZMbobi1MIsNNms/3yin
	 cStctn9CCEXxDKaMmF1z0el9UOQDqR5yZADzGBYxR0vxXbC2LKEgiTpgXc5biTgHxC
	 0drEK1adVdLxw==
Date: Wed, 3 Jul 2024 16:10:35 +0100
From: Simon Horman <horms@kernel.org>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v1 4/4] igc: Fix qbv tx latency by setting
 gtxoffset
Message-ID: <20240703151035.GQ598357@kernel.org>
References: <20240702040926.3327530-1-faizal.abdul.rahim@linux.intel.com>
 <20240702040926.3327530-5-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702040926.3327530-5-faizal.abdul.rahim@linux.intel.com>

On Tue, Jul 02, 2024 at 12:09:26AM -0400, Faizal Rahim wrote:
> A large tx latency issue was discovered during testing when only QBV was
> enabled. The issue occurs because gtxoffset was not set when QBV is
> active, it was only set when launch time is active.
> 
> The patch "igc: Correct the launchtime offset" only sets gtxoffset when
> the launchtime_enable field is set by the user. Enabling launchtime_enable
> ultimately sets the register IGC_TXQCTL_QUEUE_MODE_LAUNCHT (referred to as
> LaunchT in the SW user manual).
> 
> Section 7.5.2.6 of the IGC i225/6 SW User Manual Rev 1.2.4 states:
> "The latency between transmission scheduling (launch time) and the
> time the packet is transmitted to the network is listed in Table 7-61."
> 
> However, the patch misinterprets the phrase "launch time" in that section
> by assuming it specifically refers to the LaunchT register, whereas it
> actually denotes the generic term for when a packet is released from the
> internal buffer to the MAC transmit logic.
> 
> This launch time, as per that section, also implicitly refers to the QBV
> gate open time, where a packet waits in the buffer for the QBV gate to
> open. Therefore, latency applies whenever QBV is in use. TSN features such
> as QBU and QAV reuse QBV, making the latency universal to TSN features.
> 
> Discussed with i226 HW owner (Shalev, Avi) and we were in agreement that
> the term "launch time" used in Section 7.5.2.6 is not clear and can be
> easily misinterpreted. Avi will update this section to:
> "When TQAVCTRL.TRANSMIT_MODE = TSN, the latency between transmission
> scheduling and the time the packet is transmitted to the network is listed
> in Table 7-61."
> 
> Fix this issue by using igc_tsn_is_tx_mode_in_tsn() as a condition to
> write to gtxoffset, aligning with the newly updated SW User Manual.
> 
> Tested:
> 1. Enrol taprio on talker board
>    base-time 0
>    cycle-time 1000000
>    flags 0x2
>    index 0 cmd S gatemask 0x1 interval1
>    index 0 cmd S gatemask 0x1 interval2
> 
>    Note:
>    interval1 = interval for a 64 bytes packet to go through
>    interval2 = cycle-time - interval1
> 
> 2. Take tcpdump on listener board
> 
> 3. Use udp tai app on talker to send packets to listener
> 
> 4. Check the timestamp on listener via wireshark
> 
> Test Result:
> 100 Mbps: 113 ~193 ns
> 1000 Mbps: 52 ~ 84 ns
> 2500 Mbps: 95 ~ 223 ns
> 
> Note that the test result is similar to the patch "igc: Correct the
> launchtime offset".
> 
> Fixes: 790835fcc0cb ("igc: Correct the launchtime offset")
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


