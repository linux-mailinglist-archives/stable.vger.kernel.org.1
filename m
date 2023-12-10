Return-Path: <stable+bounces-5199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF0E80BA96
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 13:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004AD1C20918
	for <lists+stable@lfdr.de>; Sun, 10 Dec 2023 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218CC8F4D;
	Sun, 10 Dec 2023 12:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=heiner.kallweit@web.de header.b="WmAqpPmL"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3269AFF;
	Sun, 10 Dec 2023 04:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1702210432; x=1702815232; i=heiner.kallweit@web.de;
	bh=OBMOkhoXAecIp5sfEkZ3KSvDUWQc1RoB+uECuldF84E=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=WmAqpPmLija5q44LAzf+ULbHYZOT/0HFBhRukbJtfpHdtx60CCwpit2qz2fe+q7R
	 rcEHX5SHMDDZx8YpA4VpaIghbx8DdT1APxxPZEkxPMpG22DF5rEhVZL1r+ETWUa4R
	 rL+yS3iNAKqFSzlqH28W8E5GT3yHWham9hBKVT0SfCt9b5WFhMhUmaQHCfuJbVtpE
	 jHJrELMfn37Mk6PZSPxiiSQD7T4O5EFtXa/IOvMExRgw+Ik/G/bdNNsZ6d/WPnGIY
	 9w2ZV+Fvoil/999BPQe+xyirlHIAB+vDYPEu1PqlFlVIw7svPWlP7hvcMnDfeNQAn
	 OOYS44xtHQ2s2vqawQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.86] ([77.178.50.203]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMAE-1rgQgt2UoI-00fc2g; Sun, 10
 Dec 2023 13:08:29 +0100
Message-ID: <32257d86-610f-4e8f-8057-53f5f76f58ac@web.de>
Date: Sun, 10 Dec 2023 13:08:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ks8851: Fix TX stall caused by TX buffer overrun
Content-Language: en-US
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, stable@vger.kernel.org
References: <20231210110130.935911-1-rwahl@gmx.de>
From: Heiner Kallweit <heiner.kallweit@web.de>
In-Reply-To: <20231210110130.935911-1-rwahl@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vtz43a7CqIuWuSbdIhVzNek1MldvGAwUeShdr+hVqC7FZQ4pcIp
 R9/0uKrm8KaE/kwP6UiD7RVizgsh1I7cubXLGviNhFGLdJN5mcqkgK3WwEyebk4SjYLGy/n
 EUT99Y+jvEXNA54qMjFeAdAL+x4ZiJ0RfeUgyop4+BfVw7K9iW+Z54U40w12nt0wSx98Nqi
 ZOmzpXAoQhgPsSrdZH/jw==
UI-OutboundReport: notjunk:1;M01:P0:jm2qX7ycy+s=;ez3Z35/7g/v30YrRIuJB9ji9+pl
 DFE9CRw/8QP/12vO898BoqU6zx/LsDFREhoWhce1h9wiBMixPNjXgwXVt5VO0D9ch4n60orpk
 KTH5VhOQSa9UJzLYkNTfN6Ak2RR1RmyeIGu/c6ZM7G/1C143frMiqNZIH8C2n4v0j86UBYX8g
 qW1CPlXM9od+92u8EgeU+oZaprjI2/qLnCj4Lqokv+wtz1zLfDE9DoKjO6RpoI9ZDKodcqkyJ
 1Yj0M+K3M/pUMEs4hBW1USUvVXLA7WBVZcVKJKztyFJtqPPNSyx9se/t+a27pfgKX3jqI9n4P
 y+WwohIlQJcssMJDE0CV5y28Ch9G8BjqzufMJ19xhgo/91N35fJlJAkz/nWRS6g/ZpcvGYcnv
 OAXgiMj3fKzsvzdG2gD2/FCB/XuFITli50LqUCdz70urX7EwOYHZCCCzQ67CzctpofKhhE1P0
 OoIyXNMsenv3BA9iT7zEGudJMQIgbi4VfLJ0w0gyaOehwR0xaKt1ClaV3RPBiZoJ9+5p/nLth
 rQJDKgabakfFYxZ+PEah2HsSvuUTl9ipzG7T6xSgo90/006TsTUpnUrKCMaHgCKewKzo7IJLA
 0z3fQhkNgxUVsYVqfXzC+ioUXuESKLaKhQ7VvWxs1bw+6EiLWGg8u7BsA7AyU9Qc6KEvJBXA3
 vBuuO/6DpAyVGFXTwYeUuC5Lnvpo/7uXDhHdh6lcsQuc4yljyTuDKAsK2ttb8uIoeQBSiJ5Q0
 e3or2kJDAiUdaA220BhSIX1RimmgOQLfFSV3fZG+XTp/PR482EOI6ZBMqtE+ej11gYFSBgSzE
 4GsxasGlN4wKo9/Lp70SssaZN86/d95NJH5S8WuM3vjiZhQY7RuH4SPgIPTDK/ZozJjakk+hG
 B8S6PaagUhSGeoQmnLH9G28mNEAQLpPSzpXoJ5jinUTciV8GlCOaWRNprWo6ULBairLi5A0iN
 AIaApA==

On 10.12.2023 12:01, Ronald Wahl wrote:
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
> choosen a slightly more efficient (and still rather simple) way and
> track the amount of data that is already queued and not yet written to
> the hardware. When new SKBs are to be queued the already queued amount
> of data is honoured when checking free TX buffer space.
>
> I tested this with a setup of two linked KS8851 running iperf3 between
> the two in bidirectional mode. Before the fix I got a stall after some
> minutes. With the fix I saw now issues anymore after hours.
>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Cc: stable@vger.kernel.org # 5.10+
> Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
> ---
>  drivers/net/ethernet/micrel/ks8851.h        |  1 +
>  drivers/net/ethernet/micrel/ks8851_common.c | 21 +++++------
>  drivers/net/ethernet/micrel/ks8851_spi.c    | 41 +++++++++++++--------
>  3 files changed, 37 insertions(+), 26 deletions(-)
>

Patch should be annotated as "net", and Fixes tag is missing.


