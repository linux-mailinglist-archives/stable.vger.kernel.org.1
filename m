Return-Path: <stable+bounces-161433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AD1AFE7FF
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 13:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CFF170482
	for <lists+stable@lfdr.de>; Wed,  9 Jul 2025 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC08D2D6631;
	Wed,  9 Jul 2025 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGwexLbR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498C2D3A70;
	Wed,  9 Jul 2025 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752061398; cv=none; b=WAukw4a6kbmDKquB2PJn0vpSjEMmnr60dMSDShu/F0Aly+HTgTzSorA/HBYeHicnlHViY3dGUwxFFl23z56wUBmDZWm6Q4ix4emYqQWL2rZSxZc3GQDtWZStcF27+E5EhYFWd3KJ95EmBFrPY8BY5O1QsfcXjCSI16sX+VnkF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752061398; c=relaxed/simple;
	bh=vxu/t74v79tLBxZ01udfNFo94hDgHGQYMfGTNp5sQ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLULq2YkZ3f9aOkSmA0Sei479oTmxpz9t3Y30xNluInIE3EvjiMGFAKKJ53hB/s8tVYY2Jf3r9kIOMAJohnydFRUiOkQUhdRTbo1DAqeRCTIgDLwd3AU/XQLpZwxnaUZD4Om8S6PeornMwnzb1BTsodCadB2F1c0S2IdK3EiSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGwexLbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2497DC4CEEF;
	Wed,  9 Jul 2025 11:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752061397;
	bh=vxu/t74v79tLBxZ01udfNFo94hDgHGQYMfGTNp5sQ/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGwexLbRrmsTq9bXRiWzUcx2UAhKdlqLNfA3Jse7y0IG0N5fJDrBYLc2AfgsLzOB1
	 5l3bRW0zPA1FfYR/IDiR2UXqnNfwpxjfuvxT4RLsoIuBDK6KoJuzf9rlE5LAP0i1KE
	 0RNJHNKPxoYzac8DGMRXWDaPTtiDpbxul2haJNts4+phEC5IrABrpnyx9ng9ulnVL1
	 YXDYR2ge7xlgQcE9ohHXQ6mDURp7mtjUzWxVUbg3hltY3AOuhjaqj63IYbp1bjp+Nf
	 50SEGZw9HB+RdOoHPRjrn4YWn4VBGwVs6xzKcmGW1sazOFTEghFEhUETQyAFVlXwJt
	 UxytJW/SMDwJw==
Date: Wed, 9 Jul 2025 12:43:13 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.kubiak@intel.com, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] net: libwx: fix the using of Rx buffer DMA
Message-ID: <20250709114313.GV452973@horms.kernel.org>
References: <20250709064025.19436-1-jiawenwu@trustnetic.com>
 <20250709064025.19436-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709064025.19436-3-jiawenwu@trustnetic.com>

On Wed, Jul 09, 2025 at 02:40:24PM +0800, Jiawen Wu wrote:
> The wx_rx_buffer structure contained two DMA address fields: 'dma' and
> 'page_dma'. However, only 'page_dma' was actually initialized and used
> to program the Rx descriptor. But 'dma' was uninitialized and used in
> some paths.
> 
> This could lead to undefined behavior, including DMA errors or
> use-after-free, if the uninitialized 'dma' was used. Althrough such
> error has not yet occurred, it is worth fixing in the code.
> 
> Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Simon Horman <horms@kernel.org>


