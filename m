Return-Path: <stable+bounces-67755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BADD952B3B
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 11:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3BD1C20FAA
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF9119DFA3;
	Thu, 15 Aug 2024 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKgmTocG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CE019ADAC;
	Thu, 15 Aug 2024 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723710883; cv=none; b=NoF+k3AW8dpmE15sW06XY0ZEUu0Smwds4En/Gmsl7ymL3v6u+Udm9O1n84u+Alpwb01fNV26DSNUlvuXFtcmcJUSrPxRRL7arnPZzHwIqgcAoVxCNUUI4KJ3QpO3I91A2ksmixzzPYikPg6M+E9LG5uD66UFlyKWTi8GEADYL1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723710883; c=relaxed/simple;
	bh=KvpcwIo8lnjtyv161WHNR39x00rmKNpdWNyvp/sCM4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K83/LlX8U5BGn/I5zivn6g1svTDY0+IFDp6tcyLJI3iCHOOCegvbaLV9zVneteZgTxeHnYIKKAgEcMw4vRvNIZQQZUDJKpbMRfQ04BsSYH5dpYKeQsKisDz8F6SiKwjygu9oprUH2G++vfxL+FGdnidZEgPQLNT+nkAV0Za98Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKgmTocG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE54EC4AF09;
	Thu, 15 Aug 2024 08:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710883;
	bh=KvpcwIo8lnjtyv161WHNR39x00rmKNpdWNyvp/sCM4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKgmTocGi7iP2Hea6buvvwzKNx9xfvL7+KHbfXBWthsRbBwElWRbn9NWrSewV7TGA
	 HSXjrFJ5wdFdmqEkZpOt8YuL2cTALGYX9kvVeBjAPIISTvbCPXwn3S8wKLEKN+BIE4
	 FUhaA7pyf8aFqilwH7vLN/BYCGQto+0WpiNi2/Uo=
Date: Thu, 15 Aug 2024 10:34:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Mat Martineau <martineau@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] mptcp: fully established after ADD_ADDR echo on MPJ
Message-ID: <2024081532-discard-kitchen-04a6@gregkh>
References: <2024081208-motion-jubilant-6af5@gregkh>
 <20240813090606.939542-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813090606.939542-2-matttbe@kernel.org>

On Tue, Aug 13, 2024 at 11:06:07AM +0200, Matthieu Baerts (NGI0) wrote:
> commit d67c5649c1541dc93f202eeffc6f49220a4ed71d upstream.
> 
> Before this patch, receiving an ADD_ADDR echo on the just connected
> MP_JOIN subflow -- initiator side, after the MP_JOIN 3WHS -- was
> resulting in an MP_RESET. That's because only ACKs with a DSS or
> ADD_ADDRs without the echo bit were allowed.
> 
> Not allowing the ADD_ADDR echo after an MP_CAPABLE 3WHS makes sense, as
> we are not supposed to send an ADD_ADDR before because it requires to be
> in full established mode first. For the MP_JOIN 3WHS, that's different:
> the ADD_ADDR can be sent on a previous subflow, and the ADD_ADDR echo
> can be received on the recently created one. The other peer will already
> be in fully established, so it is allowed to send that.
> 
> We can then relax the conditions here to accept the ADD_ADDR echo for
> MPJ subflows.
> 
> Fixes: 67b12f792d5e ("mptcp: full fully established support after ADD_ADDR")
> Cc: stable@vger.kernel.org
> Reviewed-by: Mat Martineau <martineau@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Link: https://patch.msgid.link/20240731-upstream-net-20240731-mptcp-endp-subflow-signal-v1-1-c8a9b036493b@kernel.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Conflicts in options.c, because the context has changed in commit
>   b3ea6b272d79 ("mptcp: consolidate initial ack seq generation"), which
>   is not in this version. This commit is unrelated to this
>   modification. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/options.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Now queued up, thanks.

greg k-h

