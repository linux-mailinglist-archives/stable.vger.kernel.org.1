Return-Path: <stable+bounces-48066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623018FCBF3
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D818CB21923
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF231B011D;
	Wed,  5 Jun 2024 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gta6f3D6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274E31B0117;
	Wed,  5 Jun 2024 11:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588402; cv=none; b=AMJi8JnDmXPxBoEqdnDNoqCJpNVAlLcymlSkvXlEXGvZGloSge1fHZmRK0gzmTya6NZEb6rkoZuS3yZ5fpRCuOBtxY0+5XgjJl6VxRyxs5AegxyrzEPydVIWQW0J3eX97BJ4YtqL6CNhuK0YHkoAR86ukVqVVKKOn6Fj2TIaMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588402; c=relaxed/simple;
	bh=JUFUBLSPCoj+I9mnYkjmtKDkiyT83/kvukVxvmt/7KE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbacEDhPzx4W4kNZuHhvuGjqQnjI8ll/hpenXMPmm3YrOsd4WO8IE1GLeYt88m3uqVeIfZ8ncKuTBKO/FAWOhae8KXKh8nrPLlPxw4Lg+VnBWZjv6FJ26WV8Sc7zGB46dAJqteYn4kQSvPVoVAC9EvUQfAcuGxgIkM5peycoO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gta6f3D6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6F6C3277B;
	Wed,  5 Jun 2024 11:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588401;
	bh=JUFUBLSPCoj+I9mnYkjmtKDkiyT83/kvukVxvmt/7KE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gta6f3D6odVBdNeiHvZRcRfIvNLsNrzMCuubTl/PJpa2q44HECwEPD8iRL7h8cyK0
	 l2tIOd0fPJgef+aOJbUd39PEUf1xaS0DfFYNMWBqtQxV/r1r6phaJOKlC8ECu1eNIe
	 LHFJyNvsPFtW0kWRPD1kSGHWLQP+UXYlDwbulW4cVV//Pgyc+LHtd1H3eDFGT7m2h7
	 F4SwouJwQdzDbTSK5mmUqThEaNTQRvawXIF7atrxDFq7md9f073RxNhpAg2ZlngJ/y
	 zeEWcDEn2aV9J5DfEZdQ2boFJ2Qg6f06EovcOY2jauA6j3PZFGGOtbH+nQMdgvVWKc
	 Sa0CNswms8GBA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEpCk-000000000wA-2ky3;
	Wed, 05 Jun 2024 13:53:23 +0200
Date: Wed, 5 Jun 2024 13:53:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.9 16/28] usb: dwc3: core: Access XHCI address
 space temporarily to read port info
Message-ID: <ZmBRsqiexF9-sHpk@hovoldconsulting.com>
References: <20240605114927.2961639-1-sashal@kernel.org>
 <20240605114927.2961639-16-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605114927.2961639-16-sashal@kernel.org>

On Wed, Jun 05, 2024 at 07:48:45AM -0400, Sasha Levin wrote:
> From: Krishna Kurapati <quic_kriskura@quicinc.com>
> 
> [ Upstream commit 921e109c6200741499ad0136e41cca9d16431c92 ]
> 
> All DWC3 Multi Port controllers that exist today only support host mode.
> Temporarily map XHCI address space for host-only controllers and parse
> XHCI Extended Capabilities registers to read number of usb2 ports and
> usb3 ports present on multiport controller. Each USB Port is at least HS
> capable.
> 
> The port info for usb2 and usb3 phy are identified as num_usb2_ports
> and num_usb3_ports and these are used as iterators for phy operations
> and for modifying GUSB2PHYCFG/ GUSB3PIPECTL registers accordingly.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> Link: https://lore.kernel.org/r/20240420044901.884098-3-quic_kriskura@quicinc.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is not a fix. Please drop.

Johan

