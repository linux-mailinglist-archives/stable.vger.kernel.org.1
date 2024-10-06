Return-Path: <stable+bounces-81184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6117991B9D
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 02:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F357283528
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 00:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A746116;
	Sun,  6 Oct 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEPSXgO9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F15A932;
	Sun,  6 Oct 2024 00:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728174650; cv=none; b=padk+Egt/XRD9ffJR8KGvPV/VGYOqOVHXoHoiBIDNPuEM4tmS7Zr2Vln78SF/7BighFFp2SQjlzQxXaKpfjS0eIqW5uzEZMDXPLIe5oqNjQ5aNgM0Pyb3HoBj4jLbMDh71kT5RXvEbBdsSpHhOOXKkjbWzuYhHZw/0AQ51n5WtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728174650; c=relaxed/simple;
	bh=dIuNe8jYldwpJ1AwCeeL/dWc7Oa0cW5RqVpdahmqgiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQh20akGLRMiOjzT10WtdMEIUCYyy0eAsTbhY3xwo2L0jy2DuvAcB119KwwkUa7j7adWAZGk123XwQGBfXTDjvQRb3ahJ7PqtgDnGr3q43by26coaHRUYc4I680WT77Yx/jnHe32ggnksYR3dR5RV2bIbJalBwOGpNwe+1UP4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEPSXgO9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710F9C4CEC2;
	Sun,  6 Oct 2024 00:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728174649;
	bh=dIuNe8jYldwpJ1AwCeeL/dWc7Oa0cW5RqVpdahmqgiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEPSXgO9OY5/81Guc8bi72bFXfbLN8CIXsXHba6mow1VqRYxoSQAMSjSwzVlw2cEe
	 1a/CLmm3xz5XmcpuLz0JEQuFHSbPEoczjgPJK8+tJc19F4j4S/Rw6hhH7wkE/rxv3Y
	 lTlTUl94jbtg/eA/BRd++4JlI2WsGe3z+0z719ytsC7guDDiTGdoWJczw5k+nU4mEV
	 I9poYpPRj09Fs7YchvYSr4GqPLh9XMW37PnkOqoYbvgzbLprIL2XmB0OHljhIdLLm1
	 6+BmTzuRwmrBzo8hW03u1FufXc5f6vbYR5dh6sSa41Ql8qHPuh05Hw6zx7P2AhDPyU
	 DCRzYUqXheHkw==
Date: Sat, 5 Oct 2024 20:30:48 -0400
From: Sasha Levin <sashal@kernel.org>
To: James Chapman <jchapman@katalix.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Tom Parkin <tparkin@katalix.com>,
	"David S . Miller" <davem@davemloft.net>, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.10 032/197] l2tp: don't use tunnel socket
 sk_user_data in ppp procfs output
Message-ID: <ZwHaOK5AWX7A2kuo@sashalap>
References: <20240925115823.1303019-1-sashal@kernel.org>
 <20240925115823.1303019-32-sashal@kernel.org>
 <4010bc54-6704-8144-189b-e945329fbad0@katalix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4010bc54-6704-8144-189b-e945329fbad0@katalix.com>

On Wed, Sep 25, 2024 at 03:12:23PM +0100, James Chapman wrote:
>On 25/09/2024 12:50, Sasha Levin wrote:
>>From: James Chapman <jchapman@katalix.com>
>>
>>[ Upstream commit eeb11209e000797d555aefd642e24ed6f4e70140 ]
>>
>>l2tp's ppp procfs output can be used to show internal state of
>>pppol2tp. It includes a 'user-data-ok' field, which is derived from
>>the tunnel socket's sk_user_data being non-NULL. Use tunnel->sock
>>being non-NULL to indicate this instead.
>>
>>Signed-off-by: James Chapman <jchapman@katalix.com>
>>Signed-off-by: Tom Parkin <tparkin@katalix.com>
>>Signed-off-by: David S. Miller <davem@davemloft.net>
>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>>---
>>  net/l2tp/l2tp_ppp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
>>index 6146e4e67bbb5..6ab8c47487161 100644
>>--- a/net/l2tp/l2tp_ppp.c
>>+++ b/net/l2tp/l2tp_ppp.c
>>@@ -1511,7 +1511,7 @@ static void pppol2tp_seq_tunnel_show(struct seq_file *m, void *v)
>>  	seq_printf(m, "\nTUNNEL '%s', %c %d\n",
>>  		   tunnel->name,
>>-		   (tunnel == tunnel->sock->sk_user_data) ? 'Y' : 'N',
>>+		   tunnel->sock ? 'Y' : 'N',
>>  		   refcount_read(&tunnel->ref_count) - 1);
>>  	seq_printf(m, " %08x %ld/%ld/%ld %ld/%ld/%ld\n",
>>  		   0,
>
>This change isn't needed in 6.10. The commit was part of a series for 
>6.12 that removed use of sk_user_data in l2tp tunnel sockets.

Dropped, thanks!

-- 
Thanks,
Sasha

