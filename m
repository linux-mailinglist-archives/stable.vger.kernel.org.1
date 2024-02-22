Return-Path: <stable+bounces-23335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B4285FAC8
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 15:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EFE1F234B0
	for <lists+stable@lfdr.de>; Thu, 22 Feb 2024 14:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B0E1474B1;
	Thu, 22 Feb 2024 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EzWNLqGh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC02F145FF6;
	Thu, 22 Feb 2024 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610800; cv=none; b=lcEHABBhp+Tt8OEBgxVcz+SOFK1b3ONno4vmhZ5XCATXKkod4p2Z7zeG8mM50tJ5sBKTzsEgw+VcmEOuEBwjk/0m0tADNcLbOxa1WJVXk1gn0Bqip+Xce/g2s2Z6l2ymUKTWx8J1buLRZNY+mm2tp89SOe3LlbLTR+Cm1eLUyU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610800; c=relaxed/simple;
	bh=fl8k89dEcdPl2nmfpb3JV5SActGiwtcJ9mg3xz1qfFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjDjJTpk3Lbv83zekKFsJsW4m8pMK0IbVgLfllLnGUjL/8H425X5u/p8x41ntUz1Nui4zM8bw2wXKiQCLob2WCayFCMHSIN258QAvSsRM7qWEB5dMpb7jmYhiSE8xzqbsJl1bM3hwqbiPeKEe4SeeS7JUkMUVt8R1NkUT9hNXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EzWNLqGh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99D1C433F1;
	Thu, 22 Feb 2024 14:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708610799;
	bh=fl8k89dEcdPl2nmfpb3JV5SActGiwtcJ9mg3xz1qfFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzWNLqGh4vp9/dWfsh530WKjgF/e71zbHDCit+qkEeZwDB9u2XNdVgko1HFtB6Bxr
	 HtM9SWI0iRxzn80lDpBZ3/JMcYHFtGqG61MQDRwBxUdJ9LJv+ms9Xb9NTskRUNd5b4
	 CDEvsGBp4gLy9QdfpObYW+x/zy/oPfK3xg0JWNc4=
Date: Thu, 22 Feb 2024 15:06:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
	Paul Menzel <pmenzel@molgen.mpg.de>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: port: Don't try to peer unused USB ports based
 on location
Message-ID: <2024022220-untried-routine-15e5@gregkh>
References: <20240222133819.4149388-1-mathias.nyman@linux.intel.com>
 <20240222133819.4149388-2-mathias.nyman@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222133819.4149388-2-mathias.nyman@linux.intel.com>

On Thu, Feb 22, 2024 at 03:38:19PM +0200, Mathias Nyman wrote:
> Unused USB ports may have bogus location data in ACPI PLD tables.
> This causes port peering failures as these unused USB2 and USB3 ports
> location may match.
> 
> This is seen on DELL systems where all unused ports return zeroed
> location data.
> 
> Don't try to peer or match ports that have connect type set to
> USB_PORT_NOT_USED.
> 
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>

What commit does this fix?  "all" of them?

thanks,

greg k-h

