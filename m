Return-Path: <stable+bounces-87036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D7E9A604D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 11:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AFCB2A262
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 09:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81641E377E;
	Mon, 21 Oct 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nzPbGMz0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B09A1E3775;
	Mon, 21 Oct 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503486; cv=none; b=gOmBzxdtZOjUd7nkdzkb+zcspVcTwjK0qdeHRbgvNqwuo6CQ+gqcRssxj171jU36U678/GiVO8FYjTP28Nx8RTXiBfujZNVb4ivfb1XbIp5G4VRS+13P7AHEiFwUiRGOuNmDXWoh+DO0ABEEjPmQKqp+JdSe9ic3pcJZVthaj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503486; c=relaxed/simple;
	bh=8gQTVo/QYO3uKadqGBAxsgft4BziE+jiZEdRfqos2XM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSENZYnfOMwJcv/QsHDgkMkXA7rIlfJXF9VHzdJqnnUyvBXwWWykqFtm1Z5qoCLfdrQuKIvIZ3K4IiH6JQkhov9OFNwTvml29QI9hdDoCcJZPWi75T3br0mFMUMpfEo/rwqRhlcyKRFGDxSn3NVxtHZyeRCqo+TnmObug4xAwBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nzPbGMz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12A1C4CEC7;
	Mon, 21 Oct 2024 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729503486;
	bh=8gQTVo/QYO3uKadqGBAxsgft4BziE+jiZEdRfqos2XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzPbGMz0VFNG7ab7pLU72pK5VALYfuZAxpMJotXkNIolKJXlOlGEGvSSf/TSw2i5J
	 NAPuYcDYI7PX8Ngm3iKZa/3fD74T4IL+ml0cBU1ehgfL+rVxYs8clesoeFQYtyn3ga
	 2tLdSPfr+FNG+DuPv83yOwZdTw+t5P98FWg+dYS4=
Date: Mon, 21 Oct 2024 11:38:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, stable@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH 6.1.y 0/2] mptcp: fix recent failed backports
Message-ID: <2024102156-scrounger-unaligned-1157@gregkh>
References: <20241018173656.2813913-4-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018173656.2813913-4-matttbe@kernel.org>

On Fri, Oct 18, 2024 at 07:36:57PM +0200, Matthieu Baerts (NGI0) wrote:
> Greg recently reported 3 patches that could not be applied without
> conflicts in v6.1:
> 
>  - 4dabcdf58121 ("tcp: fix mptcp DSS corruption due to large pmtu xmit")
>  - 3d041393ea8c ("mptcp: prevent MPC handshake on port-based signal
>    endpoints")
>  - 5afca7e996c4 ("selftests: mptcp: join: test for prohibited MPC to
>    port-based endp")
> 
> Conflicts have been resolved for the two first ones, and documented in
> each patch.
> 
> The last patch has not been backported: this is an extra test for the
> selftests validating the previous commit, and there are a lot of
> conflicts. That's fine not to backport this test, it is still possible
> to use the selftests from a newer version and run them on this older
> kernel.
> 
> Paolo Abeni (2):
>   tcp: fix mptcp DSS corruption due to large pmtu xmit
>   mptcp: prevent MPC handshake on port-based signal endpoints
> 
>  net/ipv4/tcp_output.c  |  4 +---
>  net/mptcp/mib.c        |  1 +
>  net/mptcp/mib.h        |  1 +
>  net/mptcp/pm_netlink.c |  1 +
>  net/mptcp/protocol.h   |  1 +
>  net/mptcp/subflow.c    | 11 +++++++++++
>  6 files changed, 16 insertions(+), 3 deletions(-)
> 
> -- 
> 2.45.2
> 
> 

All queued up, thanks.

greg k-h

