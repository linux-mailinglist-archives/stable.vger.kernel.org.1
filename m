Return-Path: <stable+bounces-5250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDB480C17B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 07:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D60CC1C20934
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F871F60A;
	Mon, 11 Dec 2023 06:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oIWYsJhF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2A1D69A;
	Mon, 11 Dec 2023 06:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3723C433C8;
	Mon, 11 Dec 2023 06:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702277175;
	bh=kHnEszmD14gAE0yGcIoS2wtHuhi2+yTazSYkElaFc64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oIWYsJhFRtc3rznu98ThG9D4IUodSsPJLVR05l1lNjoBnXFiodm4CLeNRzFwUTd6t
	 pSLWnN6uSyY7t8k0yNeggaTa4Klfnl35h/XVn4gjU4kbh4kZONSs1PzdEZgLv0ifQz
	 QH6hzW703/HeTf/GCZV9+Ue56WAhKglL3s5cI4gw=
Date: Mon, 11 Dec 2023 07:46:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Simon Kaegi <simon.kaegi@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>, jpiotrowski@linux.microsoft.com
Subject: Re: [REGRESSION] vsocket timeout with kata containers agent 3.2.0
 and kernel 6.1.63
Message-ID: <2023121156-giblet-thumb-037f@gregkh>
References: <CACW2H-4FpZAizkp+U1aS94V_ODn8NUd1ta27BAz_zh0wo63_rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACW2H-4FpZAizkp+U1aS94V_ODn8NUd1ta27BAz_zh0wo63_rQ@mail.gmail.com>

On Sun, Dec 10, 2023 at 11:05:37PM -0500, Simon Kaegi wrote:
> #regzbot introduced v6.1.62..v6.1.63
> #regzbot introduced: baddcc2c71572968cdaeee1c4ab3dc0ad90fa765
> 
> We hit this regression when updating our guest vm kernel from 6.1.62 to
> 6.1.63 -- bisecting, this problem was introduced
> in baddcc2c71572968cdaeee1c4ab3dc0ad90fa765 -- virtio/vsock: replace
> virtio_vsock_pkt with sk_buff --
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.1.63&id=baddcc2c71572968cdaeee1c4ab3dc0ad90fa765
> 
> We're getting a timeout when trying to connect to the vsocket in the
> guest VM when launching a kata containers 3.2.0 agent. We haven't done
> much more to understand the problem at this point.
> 
> We can reproduce 100% of the time but don't currently have a simple
> reproducer as the problem was found in our build service which uses
> kata-containers (with cloud-hypervisor).
> 
> We have not checked the mainline as we currently are tied to 6.1.x.

What is "tieing" you to the old 6.1.y tree?

Also, can you try 6.1.66?  Numerous fixes have gone into there as well.

thanks,

greg k-h

