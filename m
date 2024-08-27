Return-Path: <stable+bounces-70352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F230960B19
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE32B2848FF
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CF31BD505;
	Tue, 27 Aug 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bEmUe8JS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEB71BDAAF
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763080; cv=none; b=Dq2ccuk+RaX3JN0jsW+3s9CmkaOYB67j8G5l4BL+zvq9viqfvbMx5itqWA2rrXbfCjhHUS4CZYF8j0iKrWvwzMY6EuVe3DjtCSTBzVgJ8r/vt3f+VpUvvcaNbTkbvpYE+EOOjw1J23f4RtBbisFLoGr3kDrDQNYDCLS+2FxmHfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763080; c=relaxed/simple;
	bh=04taoS82eWy3kKa2vbwJiaEBqMA6LqxqNHyU5xxLOVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY0lzAweb2bF/P/sh5W8zBgxqDv6bstPLIy/rpNsDXljfaId0CYPfge4Mg2XlZTUT7BOpVwB0KHO/CBBPaJdjoIFqILnFBPo7muAFMNf8ByKu7uDDmsiswp+676rweVz9mZNkY6bG2v7faKvWyYIOxX/tvv/5AuxJLbZ7xnkezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bEmUe8JS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6A3C6106D;
	Tue, 27 Aug 2024 12:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724763080;
	bh=04taoS82eWy3kKa2vbwJiaEBqMA6LqxqNHyU5xxLOVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEmUe8JSMY2Gv+uwmZ6r+u6r+AA+h362PEpCrIcbr3jZ1L2iY5PlVInuFPlGO1Bd1
	 du3olNXKORBN86CnBbfmSoo9B2CQs7zSOKsdjPsgcIjfOfO6usxjavSmRlvxcKiiev
	 dPxyh69Ks+vicmmVOycP3DbEuBhd/RfGHM8pu4UU=
Date: Tue, 27 Aug 2024 14:51:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: stable@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 6.6.y] net: ngbe: Fix phy mode set to external phy
Message-ID: <2024082709-placate-appendage-1721@gregkh>
References: <2024082635-dislike-tipping-1bee@gregkh>
 <600F7E75858E218A+20240827083130.94093-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <600F7E75858E218A+20240827083130.94093-1-mengyuanlou@net-swift.com>

On Tue, Aug 27, 2024 at 04:31:30PM +0800, Mengyuan Lou wrote:
> The MAC only has add the TX delay and it can not be modified.
> MAC and PHY are both set the TX delay cause transmission problems.
> So just disable TX delay in PHY, when use rgmii to attach to
> external phy, set PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
> And it is does not matter to internal phy.
> 
> Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Link: https://patch.msgid.link/E6759CF1387CF84C+20240820030425.93003-1-mengyuanlou@net-swift.com
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
> (cherry picked from commit f2916c83d746eb99f50f42c15cf4c47c2ea5f3b3)
> Signed-off-by: mengyuanlou <mengyuanlou@net-swift.com>
> ---
>  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Now applied, thanks.

greg k-h

