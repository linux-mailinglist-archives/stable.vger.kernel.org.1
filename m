Return-Path: <stable+bounces-36399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EC089BE1F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FE528162D
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 11:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD17657C1;
	Mon,  8 Apr 2024 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M2qR/Wgn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D4657BC
	for <stable@vger.kernel.org>; Mon,  8 Apr 2024 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575724; cv=none; b=PPqmkkqgw7uut3Sx3+KCOtAmsPpkn1DNU/K6suNB6awL1ciKk/pE0OXSKzN/5T0ZFxiiPnIVuHQxqI4xIu9c37NSyVwG6jxlYU4y1mccMhOkbueL53K4fvrbdeHogIefdTvCs+axkOnLIGMVmvw9Kb+eW+951kAOD+hCbkKpR+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575724; c=relaxed/simple;
	bh=aTvXnA8CEaRQx52aAKp/NIEMFIDUOto5D8wJWzz4mDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHhQbwZhw3oZa9Hp0X2c+2/7I4xioGMeo3ZRKDYhiuqTz+NzfhdClOmB54wMy+ELkG0ozcr9Ee9srHCe5HeRfoW3RhEW9tty6ME0MR9BegGGodL0dvCuJgo2BHoYimFSXbU8XmgxYOoYE7RbOPXAhKhKYZ8OQ6YCqMh5T//db/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M2qR/Wgn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20320C433C7;
	Mon,  8 Apr 2024 11:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712575724;
	bh=aTvXnA8CEaRQx52aAKp/NIEMFIDUOto5D8wJWzz4mDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2qR/WgnTvWUulMMfG052Mx2Vu5UrnsJr8dRGQrwKFAn2nZpzk8qIbEqVASqWDyaZ
	 W9qEgd/VDTtUrag3/7ore86SDZXRIMeqjXRMIS/+uOr1veL+dLfEVCGytVRa+eWKhy
	 UrvnF+xAJisWfSvtQqyERYEuT8i+J9iC2CgdkwfU=
Date: Mon, 8 Apr 2024 13:28:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: stable@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 5.15.y] gro: fix ownership transfer
Message-ID: <2024040831-broker-sandfish-a30d@gregkh>
References: <2024040543-backdrop-sequester-2458@gregkh>
 <20240408094416.68848-1-atenart@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408094416.68848-1-atenart@kernel.org>

On Mon, Apr 08, 2024 at 11:44:16AM +0200, Antoine Tenart wrote:
> commit ed4cccef64c1d0d5b91e69f7a8a6697c3a865486 upstream.
> 
> If packets are GROed with fraglist they might be segmented later on and
> continue their journey in the stack. In skb_segment_list those skbs can
> be reused as-is. This is an issue as their destructor was removed in
> skb_gro_receive_list but not the reference to their socket, and then
> they can't be orphaned. Fix this by also removing the reference to the
> socket.
> 
> For example this could be observed,
> 
>   kernel BUG at include/linux/skbuff.h:3131!  (skb_orphan)
>   RIP: 0010:ip6_rcv_core+0x11bc/0x19a0
>   Call Trace:
>    ipv6_list_rcv+0x250/0x3f0
>    __netif_receive_skb_list_core+0x49d/0x8f0
>    netif_receive_skb_list_internal+0x634/0xd40
>    napi_complete_done+0x1d2/0x7d0
>    gro_cell_poll+0x118/0x1f0
> 
> A similar construction is found in skb_gro_receive, apply the same
> change there.
> 
> Fixes: 5e10da5385d2 ("skbuff: allow 'slow_gro' for skb carring sock reference")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>

Now queued up, thanks.

greg k-h

