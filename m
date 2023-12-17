Return-Path: <stable+bounces-6887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93480815F15
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 13:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4759A281CBB
	for <lists+stable@lfdr.de>; Sun, 17 Dec 2023 12:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7ED42AB4;
	Sun, 17 Dec 2023 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0yryinz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A144360;
	Sun, 17 Dec 2023 12:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA99C433C7;
	Sun, 17 Dec 2023 12:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702817638;
	bh=JNQejdVwe4wbdwQ0rhcGiGtmdcp8mgsEXgDOORjnZeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b0yryinzoN8U9E3DbLLK4EKnHNSETzH70rlsGQzY/wVNzoSTLsjzREtygDrGAGKlF
	 /BLDKE0FLb1gcyBX2TaPu43tUzBqycWBomFvM8Tg4MpCKp/pPsUyLuMOQk9JJXyAy5
	 MKGRxuXXTlJO0uU+ev6UWd8+MfEBhJAFWpcKgEWevhYEP2D+FAjOcDlOk5tArkAlbV
	 nsPfDdOto4pSTJuPoawCs2TdEmitis60M7zOEJsmH+dxPWQpQyzxZGMZa6XdyXGiHp
	 2jtSiK40ibPWm9Mazs+9wbeQyrD1AbHX6AV2T56adCtGXk6Dbssesp1YJC6elZAnNB
	 yp7P8u9xca3QA==
Date: Sun, 17 Dec 2023 12:53:53 +0000
From: Simon Horman <horms@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Tristram Ha <Tristram.Ha@microchip.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: ks8851: Fix TX stall caused by TX buffer
 overrun
Message-ID: <20231217125353.GY6288@kernel.org>
References: <20231214181112.76052-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214181112.76052-1-rwahl@gmx.de>

On Thu, Dec 14, 2023 at 07:11:12PM +0100, Ronald Wahl wrote:
> From: Ronald Wahl <ronald.wahl@raritan.com>
> 
> There is a bug in the ks8851 Ethernet driver that more data is written
> to the hardware TX buffer than actually available. This is caused by
> wrong accounting of the free TX buffer space.
> 
> The driver maintains a tx_space variable that represents the TX buffer
> space that is deemed to be free. The ks8851_start_xmit_spi() function
> adds an SKB to a queue if tx_space is large enough and reduces tx_space
> by the amount of buffer space it will later need in the TX buffer and
> then schedules a work item. If there is not enough space then the TX
> queue is stopped.
> 
> The worker function ks8851_tx_work() dequeues all the SKBs and writes
> the data into the hardware TX buffer. The last packet will trigger an
> interrupt after it was send. Here it is assumed that all data fits into
> the TX buffer.
> 
> In the interrupt routine (which runs asynchronously because it is a
> threaded interrupt) tx_space is updated with the current value from the
> hardware. Also the TX queue is woken up again.
> 
> Now it could happen that after data was sent to the hardware and before
> handling the TX interrupt new data is queued in ks8851_start_xmit_spi()
> when the TX buffer space had still some space left. When the interrupt
> is actually handled tx_space is updated from the hardware but now we
> already have new SKBs queued that have not been written to the hardware
> TX buffer yet. Since tx_space has been overwritten by the value from the
> hardware the space is not accounted for.
> 
> Now we have more data queued then buffer space available in the hardware
> and ks8851_tx_work() will potentially overrun the hardware TX buffer. In
> many cases it will still work because often the buffer is written out
> fast enough so that no overrun occurs but for example if the peer
> throttles us via flow control then an overrun may happen.
> 
> This can be fixed in different ways. The most simple way would be to set
> tx_space to 0 before writing data to the hardware TX buffer preventing
> the queuing of more SKBs until the TX interrupt has been handled. I have
> chosen a slightly more efficient (and still rather simple) way and
> track the amount of data that is already queued and not yet written to
> the hardware. When new SKBs are to be queued the already queued amount
> of data is honoured when checking free TX buffer space.
> 
> I tested this with a setup of two linked KS8851 running iperf3 between
> the two in bidirectional mode. Before the fix I got a stall after some
> minutes. With the fix I saw now issues anymore after hours.
> 
> Fixes: 3ba81f3ece3c ("net: Micrel KS8851 SPI network driver")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Ben Dooks <ben.dooks@codethink.co.uk>
> Cc: Tristram Ha <Tristram.Ha@microchip.com>
> Cc: netdev@vger.kernel.org
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
> V3: - Add missing kdoc of structure fields
>     - Avoid potential NULL pointer dereference
>     - Fix stack variable declaration order
> 
> V2: - Added Fixes: tag (issue actually present from the beginning)
>     - cosmetics reported by checkpatch

Thanks for the updates.

This change looks good to me, and I agree that
the problem was introduced in the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>

