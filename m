Return-Path: <stable+bounces-74119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC58A972AC3
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D9FA2854E1
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 07:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180E117D366;
	Tue, 10 Sep 2024 07:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kpu9cwxz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F11BC44;
	Tue, 10 Sep 2024 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953450; cv=none; b=qBAiQrSHrVCbD5YG2tnzdUvGrF7mVGc2bdwh9++3RrWOC16/OkW0IPdMOdNZ6Nv22liGX+KEiSxEv3lOLQdlywG/4sBiozQT0cDEcPvt+BTLKhq4nT/qpLx3MREJkljTi8sFSBfqlxalJ0D0CQNOCLyx4ev/qmO/9JIKIP/zrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953450; c=relaxed/simple;
	bh=KrKi1M0mL9cTG9gfxXfAtzMSk9BxbIrhK8UeqvacG7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrU3dcYJZpkMGiKDLziG9Psln7878vbpJ4k+xVGCQiL7wA9mJwUM0cca5R6h5DlVdVsAXy9hDd6WNKknjc0WZPy4Hd2g5U5YluOvhp3jCUCfg5SqjCbtGPd1KzRoGCPL5P2NPFath/IZSmpPlB9O8ljL4AL5MemK/GAWLoL5CLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kpu9cwxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09870C4CEC3;
	Tue, 10 Sep 2024 07:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725953450;
	bh=KrKi1M0mL9cTG9gfxXfAtzMSk9BxbIrhK8UeqvacG7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kpu9cwxzlO8vcVsLJCUhfjgWxcXa1Nuinf6a39P0pbT2lvmcNHXjsTQ+umrgyV6xl
	 HvFOMp8ah0xSgLCjjRo4UysMjQ1YTI5DguKFfWYGUENewbjcPm3vQWeT98Jh2bMwAh
	 PIRZTgH+CQy0RTja4cp5Y5iqDbnX4O8mDwPNbq+M=
Date: Tue, 10 Sep 2024 09:30:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, christian@theune.cc,
	mathieu.tortuyaux@gmail.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH 5.15 0/4] Backport fix for net: missing check virtio
Message-ID: <2024091037-undivided-earthy-ef7d@gregkh>
References: <20240909182506.270136-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909182506.270136-1-willemdebruijn.kernel@gmail.com>

On Mon, Sep 09, 2024 at 02:22:44PM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Backport the following commit, because it fixes an existing backport
> that has caused multiple reports of breakage on 5.15 based kernels:
> 
>   net: drop bad gso csum_start and offset in virtio_net_hdr
> 
> 
> To backport without conflicts, also backport its two dependencies:
> 
>   net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
>   gso: fix dodgy bit handling for GSO_UDP_L4
> 
> 
> Also backport the one patch in netdev-net/main that references one
> of the above in its Fixes tag:
> 
>   net: change maximum number of UDP segments to 128
> 
> 
> All four patches also exist in 6.1.109
> 
>  include/linux/udp.h                  |  2 +-
>  include/linux/virtio_net.h           | 35 +++++++++++++++++-----------
>  net/ipv4/tcp_offload.c               |  3 +++
>  net/ipv4/udp_offload.c               | 17 +++++++++++---
>  tools/testing/selftests/net/udpgso.c |  2 +-
>  5 files changed, 40 insertions(+), 19 deletions(-)
> 
> -- 
> 2.46.0.598.g6f2099f65c-goog

all now queued up, thanks!

greg k-h

