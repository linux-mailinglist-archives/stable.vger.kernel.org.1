Return-Path: <stable+bounces-192288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B606C2E7D0
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 00:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 899E94E536D
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 23:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C430216F;
	Mon,  3 Nov 2025 23:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XTpIGphC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0D30147A;
	Mon,  3 Nov 2025 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762214045; cv=none; b=mR/DTh+FCclHAXsVjGnEfv12DBPIZSuBRKPd8ykIgTvYiDBUYMFVpPsYiWhS6vfo8QC1YpotI6MM88w1zGCMRvL2B/531ws80O5UwL5RQHA1ZSeo/qlUaQ25k+5WT9zj4yRvfqBaclkNSeVAPNbJc54f4EEK1L2v114TlzEfpMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762214045; c=relaxed/simple;
	bh=UVNzrMusqOU6GYBHUTbZTOdkeG10tADERbGG7oMrZrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI0gmNubirSpFpgOO4Dgjc4RCxTZJGyIst11iuYVrBwdRmWn7ES7JNbPBvG7mNqFlwSQTLCZt6igSNjh251JbZGadbIVjoPfaMJoElXJrS5O99ZgZi44Bvb5g+I84gck/r8o/PPLkc8i2+UkCapu9aT6xy0ku0odos0z7oo47HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XTpIGphC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CD6C4CEFD;
	Mon,  3 Nov 2025 23:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762214044;
	bh=UVNzrMusqOU6GYBHUTbZTOdkeG10tADERbGG7oMrZrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTpIGphCDs9/cZht1SaBb9Xn//vQQ+GZF/kGDjKVpLPU6Kat4IeMT8KrRKKY+Zt/D
	 nXghC5UVY90nRK+0+F56i7MnaNK6AVbDaqiZKg7Aj2JrU+8Kfr5NDmg5+baTfkXvKb
	 XP7pfQIiuLPMOl9TpdaHLdHJqDPXbYE6Z45J2NQU=
Date: Tue, 4 Nov 2025 08:54:01 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: stable@vger.kernel.org, sashal@kernel.org,
	MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH 6.12.y-5.10.y] selftests: mptcp: connect modes: re-add
 exec mode
Message-ID: <2025110410-cake-tasty-1a16@gregkh>
References: <20251103165433.6396-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103165433.6396-2-matttbe@kernel.org>

On Mon, Nov 03, 2025 at 05:54:34PM +0100, Matthieu Baerts (NGI0) wrote:
> It looks like the execution permissions (+x) got lost during the
> backports of these new files.
> 
> The issue is that some CIs don't execute these tests without that.
> 
> Fixes: 37848a456fc3 ("selftests: mptcp: connect: also cover alt modes")
> Fixes: fdf0f60a2bb0 ("selftests: mptcp: connect: also cover checksum")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> I'm not sure why they got lost, maybe Quilt doesn't support that? But
> then, can this patch still be applied?
> The same patch can be applied up to v5.10. In v5.10, only
> mptcp_connect_mmap.sh file is present, but I can send a dedicated patch
> for v5.10.
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh | 0
>  tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh     | 0
>  tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh | 0
>  3 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100644 => 100755 tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
>  mode change 100644 => 100755 tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
>  mode change 100644 => 100755 tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_checksum.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_mmap.sh
> old mode 100644
> new mode 100755
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_sendfile.sh
> old mode 100644
> new mode 100755
> -- 
> 2.51.0
> 
> 

This is going to be a pain to apply, given that we use quilt, and that
does not handle modes well, if at all.

So yes, that is why these files are not marked executable, but I thought
we were moving away from that anyway, most scripts should not be marked
that way.

thanks,

greg k-h

