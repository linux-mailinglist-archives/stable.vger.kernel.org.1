Return-Path: <stable+bounces-104435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD48B9F4450
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 07:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169B316D28D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 06:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6941957E4;
	Tue, 17 Dec 2024 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sm0p4/Od"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB755143C63;
	Tue, 17 Dec 2024 06:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417734; cv=none; b=jWVeUn1xEzO9y6+6VHvjju18uf9LDnnjVXutCrukOzxBedJ0wyHgB2logoz4bzYIObK+m25yNBLALkocNoKaaKCkur47iH5edwWsD7IbWU1FVIQQXUdlxIk6wWRbcqSv9vRpL7+dVzRjdx6pu4hzrucoxFKb8wqNNsPzho+YKFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417734; c=relaxed/simple;
	bh=7i3IQmkYE8FgvIPW4oGiFmwez9Z8UO2Lh0oJ8pXMwTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8TXiUDKFv1CGmbgaPvPeM6lBPg8V24/RCmqN+AW14GZBipuaNVGJAiCPjMHlCPrwfo45pJnipQprvXYvtAZy+VsYv5ZL5j2ddTbA+owUNEelwbIBo8J31u32ib/dDXnQ3aWCZ0tAhkQsv6AtBsDhMP2m37bf/7ECosXotgmS+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sm0p4/Od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA23DC4CED3;
	Tue, 17 Dec 2024 06:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734417733;
	bh=7i3IQmkYE8FgvIPW4oGiFmwez9Z8UO2Lh0oJ8pXMwTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sm0p4/OdlNdwfbrjzMyVubeGgw57G/F8lLPOOThm4LPvZyW0LqYZ2SAET92qeilzg
	 DUoi3pBmRJqVBmfGXohsI6mSlJtgXmitEte2JqVEtZsyY/mDT4fNyYbBUpBQl0b09R
	 Lnb0WsmeQaRbTguaDLDgeIMYFo7XGUamjzqNjCBI=
Date: Tue, 17 Dec 2024 07:41:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: stable@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
	hui.wang@canonical.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] serial: sc16is7xx: add missing support for rs485
 devicetree properties
Message-ID: <2024121709-fool-keep-c408@gregkh>
References: <20241216191818.1553557-1-hugo@hugovil.com>
 <20241216191818.1553557-2-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216191818.1553557-2-hugo@hugovil.com>

On Mon, Dec 16, 2024 at 02:18:15PM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Retrieve rs485 devicetree properties on registration of sc16is7xx ports in
> case they are attached to an rs485 transceiver.
> 
> Reworked to fix conflicts when backporting to linux-5.15.y.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> Link: https://lore.kernel.org/r/20230807214556.540627-7-hugo@hugovil.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I do not see any commit ids on this series matching up with what is in
Linus's tree.  Please fix up and resend the series.

thanks,

greg k-h

