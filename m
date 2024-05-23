Return-Path: <stable+bounces-45652-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 006258CD13C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC23E1F222E3
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51BC147C8B;
	Thu, 23 May 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KpeF3hQU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7897D13D293;
	Thu, 23 May 2024 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716463895; cv=none; b=YOD36iIUHjtmilhhwoOQEOk3t7qIx0kSul7LUcotILDAO6a4lkUAh95Xb1gNRpVxQWSIRw/7Gkfu9WnyTl/v02T4AcVYYChrPSWOXTtOOWR7V63I4JaK7BTMS9LjbzJp/kDh5s7kjmHLXwd1omW09/xxCoQkgeG+bv1aExreObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716463895; c=relaxed/simple;
	bh=TdT3Z/oqpZMtGUX0UvJK5EHjrgJ+sgTczuon/rWERhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmeLKx2Se4rQ1gnlmEYBceOC3GO1oLScxdD+trZ12z4tbPen7iDrO5pBCkv0YVc5fxQN6Pb/CyQyc8Qa0t7/DOypAv/LTpxYfhh1Vn/BflDK9cxC6RaStaBUlo7bVRk3HktckFU7Ky1EwdhTIyJkaRTols0xGJcvNl++9Cs3O8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KpeF3hQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90586C2BD10;
	Thu, 23 May 2024 11:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716463894;
	bh=TdT3Z/oqpZMtGUX0UvJK5EHjrgJ+sgTczuon/rWERhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KpeF3hQUzv+3UWwu+hrFkDpJEazX5xxsXqpzXSFJ6JVwSf8OBzjHP7vt+swefQRkK
	 b5gLwbBEz0G6EfN7suYujD8I5uwZA/3wpTTnlWSufhnhfcIlv3gVBuLhhalcrJjs4p
	 K4Fp3K5tnEsD5TlXMd1pkle8OHoGf6kblxJ4Cjqo=
Date: Thu, 23 May 2024 13:31:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Doug Berger <opendmb@gmail.com>
Cc: stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable 5.4 0/3] net: bcmgenet: protect contended accesses
Message-ID: <2024052326-popcorn-chloride-b06c@gregkh>
References: <20240516230151.1031190-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516230151.1031190-1-opendmb@gmail.com>

On Thu, May 16, 2024 at 04:01:48PM -0700, Doug Berger wrote:
> Some registers may be modified by parallel execution contexts and
> require protections to prevent corruption.
> 
> A review of the driver revealed the need for these additional
> protections.
> 
> Doug Berger (3):
>   net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL access
>   net: bcmgenet: synchronize use of bcmgenet_set_rx_mode()
>   net: bcmgenet: synchronize UMAC_CMD access
> 
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c     | 14 +++++++++++++-
>  drivers/net/ethernet/broadcom/genet/bcmgenet.h     |  2 ++
>  drivers/net/ethernet/broadcom/genet/bcmgenet_wol.c |  6 ++++++
>  drivers/net/ethernet/broadcom/genet/bcmmii.c       |  4 ++++
>  4 files changed, 25 insertions(+), 1 deletion(-)
> 
> -- 
> These commits are dependent on the previously submitted:
> [PATCH stable 5.4 0/2] net: bcmgenet: revisit MAC reset
> 
> 2.34.1
> 
> 

All now queued up, thanks.

greg k-h

