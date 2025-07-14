Return-Path: <stable+bounces-161830-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFB5B03CFA
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 13:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49E67A944E
	for <lists+stable@lfdr.de>; Mon, 14 Jul 2025 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE17242D83;
	Mon, 14 Jul 2025 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDwzhYxp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E67A920;
	Mon, 14 Jul 2025 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491514; cv=none; b=GeCvTLFy/GEkd6VV6Rv2QZBtZ4gECORQLpRUYzhF6z/dlNUlAEKbLE4dS7EtvN2MYVhwDz54L6W+RSQRopBzTUaIMhRVMcYxElv+WEP36v7xkLUI9Xm3b/HchriGSsIXqoF2PtpVjkcpOxC2wXWhQBYv+F/YKe7P8FourL2qGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491514; c=relaxed/simple;
	bh=K7ai1RNZpl+ipvteH723QkLX51VaUzlzH4tIcQZg+7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOo/6dQWPXS1fVT0/sjL4fDThu+BZxKYWeWWIuMKt+SpiF0QSq+0MsuWzgWFykeaEZbN4vRjw+dVLpLTkKG+QFM/1q1teUxCjy9CvE+ZMfcQjzmXL5TPU8BXNsKu0nCyZ0udTrlcpI6mfxhKjU6miCBGNnXPaZpKoPygS+FXOJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDwzhYxp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A78DC4CEF4;
	Mon, 14 Jul 2025 11:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752491514;
	bh=K7ai1RNZpl+ipvteH723QkLX51VaUzlzH4tIcQZg+7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dDwzhYxpCNVBKfTTA6euZTTWsJL7eq3EgcVJGsWxXn3LDG39dm7V8Hg7kf9sjhKvV
	 3XxtTNBUU3Qy/gl5YidNDT7osUtQb0w6tpvJcQSTPxNZoH1xLHNShHlnZtRN9sRunm
	 rmPxqsZ3RFOcTNarqb0J5cSqxkXuVIH9OXnxdjAg89UqS32BUwcU7z0OrNTXWmdHpE
	 q0iA+u/HR24cPjnbrKExlykW8wQFQh+CeEsvDCum9Z0REV+jjb5ArB9KSW0x56hn9F
	 Nn4hi+mbJcqSh33c3lXCuNcbdd1CGNX4ci9sOyRv0ufnzbqiuRnxrpsM4mTkF0FJ3N
	 lwFV9CUHCrwxg==
Date: Mon, 14 Jul 2025 12:11:50 +0100
From: Simon Horman <horms@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.kubiak@intel.com, mengyuanlou@net-swift.com,
	duanqiangwen@net-swift.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] net: libwx: remove duplicate
 page_pool_put_full_page()
Message-ID: <20250714111150.GL721198@horms.kernel.org>
References: <20250714024755.17512-1-jiawenwu@trustnetic.com>
 <20250714024755.17512-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714024755.17512-2-jiawenwu@trustnetic.com>

On Mon, Jul 14, 2025 at 10:47:53AM +0800, Jiawen Wu wrote:
> page_pool_put_full_page() should only be invoked when freeing Rx buffers
> or building a skb if the size is too short. At other times, the pages
> need to be reused. So remove the redundant page put. In the original
> code, double free pages cause kernel panic:

...

> Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

