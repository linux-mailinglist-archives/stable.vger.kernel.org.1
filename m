Return-Path: <stable+bounces-159267-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B3AF640C
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 23:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A49D5228E4
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 21:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60881239E63;
	Wed,  2 Jul 2025 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZRHlHoT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBA22C9A;
	Wed,  2 Jul 2025 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491914; cv=none; b=h8Rkr5N5bR4EDBmQobIlI9PqD0Doglcjyvu9JAYSY6XWo0jFd77DFV6dhkGHM6Fh9NNCQijxgbbgE8cck44qS5F73tTBNJFi++Dl2MUrDTHGAburDBO4R6XBtZVqrpq3PY1Z2WDpqGbkAX0TuVN6w9CSc/qE/QinogSFpn2JjIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491914; c=relaxed/simple;
	bh=jzuLxHC9Uv+OUUWTt79avAJ566i/3yVd42ByhldChw4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8/6LsS40tCNkbKIvuIm/6vu9SrrWvTuxGGVIER1XfMS0p5qcqEdgHJtTAFAnkIaqee31edwTFETaAoFPH1Z+/ARd7xTF4qb3YdIO7RntMHNHTHbEHIQHereU6vPpdcpkPRFvlPyy7K4bPQ/ErKqpaBkvpVFCcitT7ErLfJhjAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZRHlHoT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C72C4CEE7;
	Wed,  2 Jul 2025 21:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751491913;
	bh=jzuLxHC9Uv+OUUWTt79avAJ566i/3yVd42ByhldChw4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HZRHlHoTGy+g/1aNgLxhPgFbZnq278AxETgu0ki8GNKptTrMw/M3OBClefV5ZPTNr
	 PxJ+bN2jAHJwQs6Gm+YQoAj1QKURdqSLRZI+DIwJWCPaRMtTeZNkNGYvxt4LHPK2yX
	 8X6XgDLxOnVWZXqUhoYsnRI/QchZPD0Y8OZ9I9JcqyNj9elCFW7jCHnnzw9RmdSbe7
	 G1EOOOYD5ZjWokBX/wumv6JEQ03EzG1MG1lBpMt+lfJihd9Z69IDCDA/VPd0UL23Xq
	 jfZ3D1AbL+1HMnszBgr7jOS2ZOMr8sHHKr8XBzvKzaKYDxQrhor9CmtvwCRNQLSPdw
	 TYJPugFhM4T6A==
Date: Wed, 2 Jul 2025 14:31:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 mengyuanlou@net-swift.com, duanqiangwen@net-swift.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: libwx: fix double put of page to page_pool
Message-ID: <20250702143152.6046ab7c@kernel.org>
In-Reply-To: <C8A23A11DB646E60+20250630094102.22265-1-jiawenwu@trustnetic.com>
References: <C8A23A11DB646E60+20250630094102.22265-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Jun 2025 17:41:02 +0800 Jiawen Wu wrote:
> wx_dma_sync_frag() incorrectly attempted to return the page to
> page_pool, which is already handled via buffer reuse or wx_build_skb()
> paths.

The conditions is:

	if (unlikely(WX_CB(skb)->page_released))

And only wx_put_rx_buffer() sets that to true.  And it sets page to
NULL, so I don't understand how this is supposed to work.

Please improve the commit message, if not the code..

> Under high MTU and high throughput, this causes list corruption
> inside page_pool due to double free.
> 
> [  876.949950] Call Trace:
> [  876.949951]  <IRQ>
> [  876.949952]  __rmqueue_pcplist+0x53/0x2c0
> [  876.949955]  alloc_pages_bulk_noprof+0x2e0/0

This is just the stack trace you're missing the earlier lines which
tell us what problem happened and where.
-- 
pw-bot: cr

