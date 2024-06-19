Return-Path: <stable+bounces-54646-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5548990F0C2
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA5C1C22D3B
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59E71CFBE;
	Wed, 19 Jun 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adhV4Jb6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B29A1D545;
	Wed, 19 Jun 2024 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807602; cv=none; b=a8OWXbnzdr+cbbfF2OnJZ0DdoF4MxyIQVClY+fIfNnLnpyeDJy+PdchGJXTZqUsUCiNyJGuzZaY0ijMJ4S4Mg9SHvQZaz8ss7RdxgwgI8EBU5yk6zs6oaEsHMINGWQyVw3X79UE5yBLIQ7hd8+yaB4ujAJ2y2mOkTsyndat4DEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807602; c=relaxed/simple;
	bh=4J4/INqOxWh7C7XMEDneVXcBMfEaxAM3ar7OIpr3fVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO3vhMgQx0V2EWRheyVWYClDVDqnDtrffoG90FbuNYZdJ9I4xxEHDaN7Bxf4rq6Jt0kiQPM6tDJ90aT87ymr00BZqhgZJHmMFAiPt/60lcnBtdO7kw1xTF2cGlNGU9JIq07MSZjr8L5Pun51DAJjlmxu1P+wxm1LaFFvmS6URKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adhV4Jb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CB4C2BBFC;
	Wed, 19 Jun 2024 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807602;
	bh=4J4/INqOxWh7C7XMEDneVXcBMfEaxAM3ar7OIpr3fVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adhV4Jb6uF72CggtYmqfNP+X1hMT85zC8IEycsra4hCoT3TrcZmXN5CVYJyzS/yBu
	 aHt+LQNwWAoVE9QYygDEiiAVuV7pPvCbsNvGcMq0bY8D+U9X+OMb0TitCVLceyjr1Q
	 QxnGeSi1O/PPc9jfEN2EeFjLtRUXMhMSq1GeoztNCJtlyaBqoZiHR/PLvKXicuRm4r
	 6h/9f19pDfsSTgtPWgugZY9yE1kMrNuj2+mCjGa5eeW+a36ZEaVZQXUH1XetXBff2d
	 f5NAdYecbPqwAjGc7nuwfsG8Qondmhb+cUpOgZ+Ew+2FdUEfxrEoiN+f/3XCQi/EN+
	 bkOamhOnw9REA==
Date: Wed, 19 Jun 2024 10:33:20 -0400
From: Sasha Levin <sashal@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 16/28] usb: dwc3: core: Access XHCI address
 space temporarily to read port info
Message-ID: <ZnLsMLxMsKRUc3Lb@sashalap>
References: <20240605114927.2961639-1-sashal@kernel.org>
 <20240605114927.2961639-16-sashal@kernel.org>
 <ZmBRsqiexF9-sHpk@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZmBRsqiexF9-sHpk@hovoldconsulting.com>

On Wed, Jun 05, 2024 at 01:53:22PM +0200, Johan Hovold wrote:
>On Wed, Jun 05, 2024 at 07:48:45AM -0400, Sasha Levin wrote:
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
>This is not a fix. Please drop.

Dropped, thanks!

-- 
Thanks,
Sasha

