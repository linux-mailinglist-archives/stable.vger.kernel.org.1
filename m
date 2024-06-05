Return-Path: <stable+bounces-48079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2082E8FCC1B
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 14:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEE11C21533
	for <lists+stable@lfdr.de>; Wed,  5 Jun 2024 12:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA345197550;
	Wed,  5 Jun 2024 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCt5y84X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9360E19752E;
	Wed,  5 Jun 2024 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588451; cv=none; b=LpCdSDChPyw8E43ViABFO3nhvEFkoLV9e2GzndljjNGHAiWtDZZ326ppLKG831QcxM3uurjYF9OJNfbW92sClFeNQWtZ19ITsCbGPrY6rUw3e9YXnV2ai5VPkmBlNBRYUmiZdQSKmEFptfX9ByMWHmEs+ndJZkGn6P88ms0MVxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588451; c=relaxed/simple;
	bh=2OM9RluI5P3tgT/FuEMdv4m5T8LO/7Z+ZcmeBnkHodo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEgPAi5H0gC65tA6zvlYsiGniPcFxg3nnTL3+f4VAzwiTY/rF7EpSyw86UY2288aGxEp6hwGzxWJ0erOmmQ8cXm8HYOy7dLeQCLIqQY/cMZFVBqIO2+Qc/45lQf5eSdCGdXxhjZJ7HpF3AMGJGbyH9NfJx0inP7rkjQALNAO2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCt5y84X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254A5C32781;
	Wed,  5 Jun 2024 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588451;
	bh=2OM9RluI5P3tgT/FuEMdv4m5T8LO/7Z+ZcmeBnkHodo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCt5y84XkRxyoqsCOCZDpELqR+/dN4Kf17tPK4590lu6zwwQoq2oeKH0msFFBu0pj
	 DoVpIylycE9kJPHJpDkw4MsInUK6VvL1MWovx+vEe+ueA1iFI7U+HnyqanrKZPvcdN
	 R0IRVQkhulaiBb9nnMVI6FG9/rQbIKSSjcWlAfF8Gz4kmCIdFv4LL/ZuG1r5Q6xjpe
	 bXh9X0GooJkyF+UoFkLZf2GI9n1e8vXzbeu6wxs1QdTErXAbMfu54ir6LbhH7gcT7n
	 sMuGDwYJX2TD0ihz4qgtZEhtxXRFhdlGSSEMe4cGnBCxmQDH6aSx3tmniBqs3bTeqs
	 DKoM4JdxA1E5A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sEpDY-000000000x0-2U9q;
	Wed, 05 Jun 2024 13:54:12 +0200
Date: Wed, 5 Jun 2024 13:54:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.8 15/24] usb: dwc3: core: Access XHCI address
 space temporarily to read port info
Message-ID: <ZmBR5I_TQ-219IEq@hovoldconsulting.com>
References: <20240605115101.2962372-1-sashal@kernel.org>
 <20240605115101.2962372-15-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605115101.2962372-15-sashal@kernel.org>

On Wed, Jun 05, 2024 at 07:50:25AM -0400, Sasha Levin wrote:
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

Same here. Not a fix. Please drop.

Johan

