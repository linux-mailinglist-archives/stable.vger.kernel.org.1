Return-Path: <stable+bounces-5354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1937480CB14
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452B41C20F6F
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4F03F8C6;
	Mon, 11 Dec 2023 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1GUy3h1S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD9B3D97E
	for <stable@vger.kernel.org>; Mon, 11 Dec 2023 13:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDD2C433C7;
	Mon, 11 Dec 2023 13:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702301570;
	bh=cQqYpa80niUcboA2ZrEzklpe1Sx5Et0MGoy0wZuuNSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1GUy3h1SVa4boO4sywrzw7I1ei6zGRjKKC3SFj8To5CDi8N5BBaRD/84CiwmyJPwK
	 jSXavIEr6ozRgbbUsim/MtX1aeMnjq2AzbEQG96Ik+W6yGguUf6kzPA8izGAw1zMdE
	 +fjIsvBU1XX3XAWTgzWcPAzCxDzE3vucMtQN5bHI=
Date: Mon, 11 Dec 2023 14:32:39 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, nhorman@tuxdriver.com,
	yotam.gi@gmail.com, sashal@kernel.org, fw@strlen.de,
	jacob.e.keller@intel.com, jiri@nvidia.com
Subject: Re: [PATCH 4.14 0/4] Generic netlink multicast fixes
Message-ID: <2023121132-retrial-dazzling-dab5@gregkh>
References: <20231211124301.822961-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211124301.822961-1-idosch@nvidia.com>

On Mon, Dec 11, 2023 at 02:42:57PM +0200, Ido Schimmel wrote:
> Restrict two generic netlink multicast groups - in the "psample" and
> "NET_DM" families - to be root-only with the appropriate capabilities.
> 
> Patch #1 is a dependency of patch #2 which is needed by the actual fixes
> in patches #3 and #4.
> 
> Florian Westphal (1):
>   netlink: don't call ->netlink_bind with table lock held
> 
> Ido Schimmel (3):
>   genetlink: add CAP_NET_ADMIN test for multicast bind
>   psample: Require 'CAP_NET_ADMIN' when joining "packets" group
>   drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group
> 
>  include/net/genetlink.h  |  3 +++
>  net/core/drop_monitor.c  |  4 +++-
>  net/netlink/af_netlink.c |  4 ++--
>  net/netlink/genetlink.c  | 35 +++++++++++++++++++++++++++++++++++
>  net/psample/psample.c    |  3 ++-
>  5 files changed, 45 insertions(+), 4 deletions(-)
> 
> -- 
> 2.40.1
> 
> 

All backports now queued up, thanks!

greg k-h

