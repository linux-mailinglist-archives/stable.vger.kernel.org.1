Return-Path: <stable+bounces-65467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC7D9486FC
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 03:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8531C2222C
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 01:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEB18F6C;
	Tue,  6 Aug 2024 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MMLzCxyN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED498A947;
	Tue,  6 Aug 2024 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722907631; cv=none; b=EmVonNcEjIwrN0oliQFTM/xbT4f412JtCfEYZqVwkxg2fbVK+Fb0UMRPma9MXSvDyqgw/TKGgYLmSzcQtFnIQ1v6SjtvHMigOJODBFGl9KqjuA4L4w1uYHgkK99m+jhhsGZZnEE+mlnC9QPs3CCDrqcyqtHYwMwabyQc3ulc5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722907631; c=relaxed/simple;
	bh=h+w5Fo+Phs7B+HE9oJS+dIKAMtFUWEc/jX9twNNONC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdaQTctOrkGBQqc7QTAXp2C2olX12iuGsbUFl/MhaccqZFOcJJ4PpLU1Qo66/s8lCxBCiMerVFTH9jhxuyrAzFipcrpe++LTFjU6X3BlQLOSDWgBvotiiSVGHkw5d93DorMVh4Je4Q2cwK6jjsVWinP+Q3Gly+8WC12hjKKGLBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MMLzCxyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D524C32782;
	Tue,  6 Aug 2024 01:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722907630;
	bh=h+w5Fo+Phs7B+HE9oJS+dIKAMtFUWEc/jX9twNNONC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MMLzCxyNw65/mHmR4+wO3R9sofT76y3vvXeJ5G1gtWinCuX7Anu1o758oIOcyZDj2
	 y+aiTpoog+kOQoaJI6r4kpugdZIk2U0OZLvYyTRv0Y8UjNcPpdBvLEeu72VwHrQV6J
	 E2EkS0s8khHmdNTHWNLoczn0fa2RxJrIi0pdSnDR8Pl/1S4ITSrvbXtgJfi2LbJ/Ou
	 GUaAEVEXY9cLE6Cb9Vstnw9Imb7xHumiGMyGUhTkaHhVPtoYChjc0NyA2hzbRFhaNs
	 GIr+PD53Q1Vi5VRNkEPMNh1Sz5Fk4CCuIeP/i/RGzHGGcLzF9xhZlB7T0UIHe25AqX
	 FOfdkWrrEOHDQ==
Date: Mon, 5 Aug 2024 21:27:08 -0400
From: Sasha Levin <sashal@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>
Subject: Re: Patch "net: move ethtool-related netdev state into its own
 struct" has been added to the 6.10-stable tree
Message-ID: <ZrF77NoLb0TqRnkq@sashalap>
References: <20240805121930.2475956-1-sashal@kernel.org>
 <65f0f054-2de7-572e-d6aa-926a0f3598f4@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65f0f054-2de7-572e-d6aa-926a0f3598f4@gmail.com>

On Mon, Aug 05, 2024 at 01:45:18PM +0100, Edward Cree wrote:
>On 05/08/2024 13:19, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>     net: move ethtool-related netdev state into its own struct
>>
>> to the 6.10-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>      net-move-ethtool-related-netdev-state-into-its-own-s.patch
>> and it can be found in the queue-6.10 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>
>This, and the series it's from, are absolutely not -stable material.
>The commits do not fix any existing bugs, they are in support of new
> features (netlink dumping of RSS contexts), and are a fairly large
> and complex set of changes, which have not even stabilised yet — we
> have already found issues both within the set and exposed by it in
> other code, which are being fixed for 6.11.
>
>> commit e331e73ff4c5c89a7f51a465ae40a7ad9fcd7a28
>> Author: Edward Cree <ecree.xilinx@gmail.com>
>> Date:   Thu Jun 27 16:33:46 2024 +0100
>>
>>     net: move ethtool-related netdev state into its own struct
>>
>>     [ Upstream commit 3ebbd9f6de7ec6d538639ebb657246f629ace81e ]
>>
>>     net_dev->ethtool is a pointer to new struct ethtool_netdev_state, which
>>      currently contains only the wol_enabled field.
>>
>>     Suggested-by: Jakub Kicinski <kuba@kernel.org>
>>     Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
>>     Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>     Link: https://patch.msgid.link/293a562278371de7534ed1eb17531838ca090633.1719502239.git.ecree.xilinx@gmail.com
>>     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>     Stable-dep-of: 7195f0ef7f5b ("ethtool: fix setting key and resetting indir at once")
>>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>As far as I can tell, 7195f0ef7f5b should backport fairly cleanly
> to 6.10 with only simple textual fuzz.
>It should not be necessary to backport the "ethtool: track custom
> RSS contexts in the core" series to support this.
>
>The above NAK also applies to the backports of:
>     net-ethtool-attach-an-xarray-of-custom-rss-contexts-.patch
>     net-ethtool-record-custom-rss-contexts-in-the-xarray.patch
>     net-ethtool-add-a-mutex-protecting-rss-contexts.patch
> which were notified at the same time.

Makes sense! I've modified the backport of 7195f0ef7f5b ("ethtool: fix
setting key and resetting indir at once") as proposed.

-- 
Thanks,
Sasha

