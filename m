Return-Path: <stable+bounces-73150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A2596D11D
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 10:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DBD281E61
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 08:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC2219409A;
	Thu,  5 Sep 2024 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HmMbnvOB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EDB1925B5;
	Thu,  5 Sep 2024 08:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523251; cv=none; b=fhocYIqFo6WSAP4BiDvsgMJbFsYeN9wgGmTMUytq4uiUtWZrM5KbS6AnI06+OhN/j+Oa5wzqDtTLWsM9XZb2XhMMLVTKG2cxRk3CJIbu0TGKSHuMmiXfXFEtw6/A1eJnqGBGhntG58+1J56fRF41WzaAxoMUheJaE1dEcipyojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523251; c=relaxed/simple;
	bh=ScqcRzJzrJOWyA68G1JZS8v6Yq6FS0tP62JkMHHvik8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8FGsgch9I2JOLTBK+F5Uep3XLlZR8GvgCS4rxtHDuaaM6I0KXlTlST6PbvuzqxwJKVNtSscwy2nUpIoT50vCoh2ayAydqtUuBoKHsAmd46u726dZSPdmsvqLPYwWp0OUMW55VWyablCY3qPMEUXbk7yZsJh2GCkZT/TktGbGmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HmMbnvOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAC5C4CEC3;
	Thu,  5 Sep 2024 08:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725523250;
	bh=ScqcRzJzrJOWyA68G1JZS8v6Yq6FS0tP62JkMHHvik8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmMbnvOByDKwQylmRu68bqIF32+/jnRPp8ZsVuaVqU81NxxcKlFNoAEwoDyGafh+I
	 hjxXhUOxwhZrnA4pBSw9wPuyhID0haBM7RAMuTCHr35dm0JgCOdmrjmLwnMKstDU3G
	 YuV8fHaVWncFccFM3nHBJQZe+HU/mv7WJkDKTJuA=
Date: Thu, 5 Sep 2024 10:00:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shivani Agarwal <shivani.agarwal@broadcom.com>
Cc: stable@vger.kernel.org, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com, Breno Leitao <leitao@debian.org>,
	Heng Qi <hengqi@linux.alibaba.com>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v4.19-v5.10] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <2024090539-refusing-contour-2dbc@gregkh>
References: <20240904090853.15187-1-shivani.agarwal@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904090853.15187-1-shivani.agarwal@broadcom.com>

On Wed, Sep 04, 2024 at 02:08:53AM -0700, Shivani Agarwal wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> [ Upstream commit f8321fa75102246d7415a6af441872f6637c93ab ]
> 
> After the commit bdacf3e34945 ("net: Use nested-BH locking for
> napi_alloc_cache.") was merged, the following warning began to appear:
> 
> 	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0
> 
> 	  __warn+0x12f/0x340
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  report_bug+0x165/0x370
> 	  handle_bug+0x3d/0x80
> 	  exc_invalid_op+0x1a/0x50
> 	  asm_exc_invalid_op+0x1a/0x20
> 	  __free_old_xmit+0x1c8/0x510
> 	  napi_skb_cache_put+0x82/0x4b0
> 	  __free_old_xmit+0x1c8/0x510
> 	  __free_old_xmit+0x1c8/0x510
> 	  __pfx___free_old_xmit+0x10/0x10
> 
> The issue arises because virtio is assuming it's running in NAPI context
> even when it's not, such as in the netpoll case.
> 
> To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> is available. Same for virtnet_poll_cleantx(), which always assumed that
> it was in a NAPI context.
> 
> Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>
> Link: https://patch.msgid.link/20240712115325.54175-1-leitao@debian.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> [Shivani: Modified to apply on v4.19.y-v5.10.y]
> Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>

All now queued up, thanks.

greg k-h

