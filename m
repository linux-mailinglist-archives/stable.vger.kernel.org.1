Return-Path: <stable+bounces-60696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F86A938F79
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964ECB21630
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 12:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0064916D9C0;
	Mon, 22 Jul 2024 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlZG2EiL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A6516CD07;
	Mon, 22 Jul 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721653007; cv=none; b=etwR7QgQjTtAxQE7To3Q0/x3LlzIoILN/+va8xXghvnzjnOOffo2sUjz4hQhb5qG+Dao4CODm+8/5dOUED7OPwrLOsVYdeZ5deBn1dLJqTBfLKsicSH3ot40U8h4KQJVGTreMp6hac0mf+CtyekQGikyb/Fa0QpniB8a9Z/HsyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721653007; c=relaxed/simple;
	bh=HfstLFI3f83x/yebpktBh7JO8BugbhGwTNzmrBVimpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GldRRHSI8ii2hingFpAiHJXixn7Kmg5JRZrM4s+XBTwsMocbwMItGeDT/scmP1pG+6sFZQT6q/AB1+7a9gc+fYgi0dghDl80tyr9OxMwoxu0ylRcCWqLVJSlAIuYAu01uc++FJKEpEE94aTpSJkdHoY3M7JSEciJgSr8wmDiEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlZG2EiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD40C116B1;
	Mon, 22 Jul 2024 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721653007;
	bh=HfstLFI3f83x/yebpktBh7JO8BugbhGwTNzmrBVimpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UlZG2EiL5eTY32qhPvTTFBhIxZBSDAQv/PAgNxqkI0D1o53LJli2h4bpcK8EY1SWA
	 oi0JZ45OX0uIHt8EYXr0WICXlfswAnyiaJTtKyxmHB5dyGANVTFJuaSljayF0Oe0G1
	 1/mlXcRAjJpk/bTk3w8QJOjeBnsBgW91hw92pQXb6BpE0vi5DslcOTFaZLOSEIyHkX
	 vaMzoy6yQvUg2mReOvGes/DnJ53oR7tnzcYWe9D2Rcrqq0Y3ScEr0FGfPS1ojiIhta
	 2uGxXeqizaoXvoofkyg3rmkngB4hZthlXg1Xmjn2phMZ8gMvIxT1kmkMK3TSRJYhgU
	 uaq5BkQ+3B0dg==
Date: Mon, 22 Jul 2024 08:56:45 -0400
From: Sasha Levin <sashal@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 15/24] usb: dwc3: core: Access XHCI address
 space temporarily to read port info
Message-ID: <Zp5XDcgS4Woh4QJc@sashalap>
References: <20240605115101.2962372-1-sashal@kernel.org>
 <20240605115101.2962372-15-sashal@kernel.org>
 <ZmBR5I_TQ-219IEq@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmBR5I_TQ-219IEq@hovoldconsulting.com>

On Wed, Jun 05, 2024 at 01:54:12PM +0200, Johan Hovold wrote:
>On Wed, Jun 05, 2024 at 07:50:25AM -0400, Sasha Levin wrote:
>> From: Krishna Kurapati <quic_kriskura@quicinc.com>
>>
>> [ Upstream commit 921e109c6200741499ad0136e41cca9d16431c92 ]
>>
>> All DWC3 Multi Port controllers that exist today only support host mode.
>> Temporarily map XHCI address space for host-only controllers and parse
>> XHCI Extended Capabilities registers to read number of usb2 ports and
>> usb3 ports present on multiport controller. Each USB Port is at least HS
>> capable.
>>
>> The port info for usb2 and usb3 phy are identified as num_usb2_ports
>> and num_usb3_ports and these are used as iterators for phy operations
>> and for modifying GUSB2PHYCFG/ GUSB3PIPECTL registers accordingly.
>>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
>> Tested-by: Johan Hovold <johan+linaro@kernel.org>
>> Link: https://lore.kernel.org/r/20240420044901.884098-3-quic_kriskura@quicinc.com
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Same here. Not a fix. Please drop.

I'll drop the ones you've pointed out, thanks!

-- 
Thanks,
Sasha

