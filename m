Return-Path: <stable+bounces-273361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jNneDwTWUWrXJQMAu9opvQ
	(envelope-from <stable+bounces-273361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 07:35:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 930B0740672
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 07:34:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273361-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273361-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5D66301A39C
	for <lists+stable@lfdr.de>; Sat, 11 Jul 2026 05:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2952F8E90;
	Sat, 11 Jul 2026 05:34:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2DA288C81;
	Sat, 11 Jul 2026 05:34:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783748094; cv=none; b=JUzzXUHzRXsvEdHt+Zh/lEfiqpuflVkJytwO1fXQQUhUFXLcvi0uwfLBYBMm3nxOUeiAXg13uteiajux5vx8FSWx83HC7bkwm13Dy9KqAYIBNdux9uQZSd1GJK22DUDHmqFQMRc6lqG/8X7WfDTmDRRXmoxO7W8pYTGJ3v1qwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783748094; c=relaxed/simple;
	bh=MxTmKRMTVDUByvezT6OukvwtVP70jdafbTyTIcFtMN8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YoyKbyrM8yKDF6UfGyPIIqHE/ZmkxGPA1mYkaIEq9fJ1Az/Q+MAd50CoXoMpLzHWjJNT+2pp1iKOQJ/NZYb1BDH/6IhmmmbRQIAP4xsi31kKFLjBhwLeGK/Jg7/Gn2XR/OauBCbgi41G39QCEWou8TyT6J6SWHB4P8xS/6ogBOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Received: from zju.edu.cn (unknown [10.190.131.5])
	by mtasvr (Coremail) with SMTP id _____wBnYCfu1VFqf7M3AA--.13293S3;
	Sat, 11 Jul 2026 13:34:39 +0800 (CST)
Received: from smtpclient.apple (unknown [10.190.131.5])
	by mail-app1 (Coremail) with SMTP id yy_KCgA3hp7q1VFq+T2_Ag--.36260S2;
	Sat, 11 Jul 2026 13:34:35 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] net: hip04: quiesce tx coalesce timer before teardown
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <20260709124309.1557255-2-horms@kernel.org>
Date: Sat, 11 Jul 2026 13:34:24 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 netdev@vger.kernel.org,
 shenjian15@huawei.com,
 salil.mehta@huawei.com,
 andrew+netdev@lunn.ch,
 "David S . Miller" <davem@davemloft.net>,
 edumazet@google.com,
 Jakub Kicinski <kuba@kernel.org>,
 pabeni@redhat.com,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4631C8F9-598D-4114-AD88-BEC5D8617BB6@zju.edu.cn>
References: <20260703050133.2445155-1-fanwu01@zju.edu.cn>
 <20260709124309.1557255-2-horms@kernel.org>
To: Simon Horman <horms@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:yy_KCgA3hp7q1VFq+T2_Ag--.36260S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?gnBNsAXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnVCjTgEH9dVomQuWcozCBBGAVZ0gFy3wimD7eC71nRSVmamgW/k8jttQxXWqYIFT8BCV
	Pg+cZSYfgUXQ7V0QX3HN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxtrWfCFW5uw1kZrWxtw4fWFX_yoW3GF1Upa
	yfKay7JFWvqryFgFZ7XF48Xry0ya1xGayfGr1ruws5uFnxAr10qF48KrWUuayUCr1kAwsI
	vr4jv3yDu34DArXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU85l1PUUUUU==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273361-lists,stable=lfdr.de];
	DMARC_NA(0.00)[zju.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:fanwu01@zju.edu.cn,m:netdev@vger.kernel.org,m:shenjian15@huawei.com,m:salil.mehta@huawei.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[12321260@zju.edu.cn,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[12321260@zju.edu.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,zju.edu.cn:mid,zju.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 930B0740672

Hi Simon,

Thanks for the v1 review. The updated patch fixes the PHY teardown =
ordering
and IRQ lifetime issues: hip04_remove() unregisters the netdev, running
.ndo_stop and phy_stop(), before phy_disconnect(), and frees the =
devm-managed
IRQ before free_netdev().

The remaining NULL tx_desc cleanup in hip04_free_ring() and RX refill
failure paths are independent pre-existing error-path issues. I will =
address them=20
in separate patches rather than expanding this teardown fix. In =
particular, the
RX fix must preserve the old descriptor mapping until a replacement =
buffer is
successfully allocated and mapped.

The latest revision is v3:
=
https://lore.kernel.org/netdev/20260711052922.1634837-1-fanwu01@zju.edu.cn=


Thanks,
Fan

> On Jul 9, 2026, at 20:43, Simon Horman <horms@kernel.org> wrote:
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> net: hip04: quiesce tx coalesce timer before teardown
>=20
> This patch fixes race conditions with the tx_coalesce_timer by =
properly
> canceling it during device stop and remove. It also serializes device
> restarts in the tx timeout handler using rtnl_lock().
>=20
>> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c =
b/drivers/net/ethernet/hisilicon/hip04_eth.c
>> index 18376bcc718a2..cb9b01c79ee6e 100644
>> --- a/drivers/net/ethernet/hisilicon/hip04_eth.c
>> +++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
>=20
> [ ... ]
>=20
>> @@ -761,6 +762,13 @@ static int hip04_mac_stop(struct net_device =
*ndev)
>>=20
>> napi_disable(&priv->napi);
>> netif_stop_queue(ndev);
>=20
> [Severity: High]
> This is a pre-existing issue, but does netif_stop_queue() adequately =
protect
> against concurrent transmission here?
>=20
> Since netif_stop_queue() only changes the queue state flag without =
waiting for
> an active ndo_start_xmit callback to finish (unlike =
netif_tx_disable()), could
> this allow the subsequent hip04_tx_reclaim() call to corrupt the TX =
ring or
> cause invalid DMA mappings if a transmission is actively running?
>=20
>> +
>> + /* Cancel the TX-coalesce timer after the arming paths (xmit via =
the
>> + * queue, rx poll via NAPI) are disabled, so a pending tx_done()
>> + * (which dereferences priv) is drained before the device is freed.
>> + */
>> + hrtimer_cancel(&priv->tx_coalesce_timer);
>=20
> [Severity: High]
> This is a pre-existing issue, but is it possible for the softirq to =
re-arm
> the timer after hrtimer_cancel() is called?
>=20
> In hip04_rx_poll(), the NAPI ownership is released via =
napi_complete_done()
> before the timer is armed:
>=20
> hip04_rx_poll() {
>    ...
>    napi_complete_done(napi, rx);
> done:
>    if (rx < budget && tx_remaining)
>        hip04_start_tx_timer(priv);
> }
>=20
> If the teardown thread cancels the timer and frees the private =
structure
> while the softirq is preempted just after napi_complete_done(), could =
this
> result in a use-after-free when hip04_start_tx_timer() is eventually =
executed?
>=20
>> +
>> hip04_mac_disable(ndev);
>> hip04_tx_reclaim(ndev, true);
>=20
> [Severity: High]
> This is a pre-existing issue, but is there missing hardware =
synchronization
> between disabling the MAC and reclaiming the TX ring?
>=20
> hip04_mac_disable() disables the MAC using a relaxed MMIO write =
without
> polling for an idle state.
>=20
> Since the very next call is hip04_tx_reclaim() which unmaps buffers =
and
> modifies descriptor memory, could this cause silent data corruption or =
IOMMU
> page faults if the MAC is still actively processing packets in the =
background?
>=20
> [ ... ]
>=20
>> @@ -791,8 +799,15 @@ static void hip04_tx_timeout_task(struct =
work_struct *work)
>> struct hip04_priv *priv;
>>=20
>> priv =3D container_of(work, struct hip04_priv, tx_timeout_task);
>> +
>> + rtnl_lock();
>> + if (!netif_running(priv->ndev))
>> + goto out;
>> +
>> hip04_mac_stop(priv->ndev);
>> hip04_mac_open(priv->ndev);
>=20
> [Severity: High]
> This is a pre-existing issue, but what happens if hip04_mac_open() =
fails
> during this restart?
>=20
> If dma_map_single() fails inside hip04_mac_open(), it returns -EIO =
without
> enabling NAPI. Because this return value is ignored here, the device =
remains
> broken and NAPI is left disabled (with the SCHED bit set).
>=20
> Will this cause a hard lockup later when hip04_mac_stop() spins =
forever in
> napi_disable() waiting for the SCHED bit to clear?
>=20
>> +out:
>> + rtnl_unlock();
>> }
>>=20
>=20
> [ ... ]
>=20
>> @@ -1029,10 +1044,15 @@ static void hip04_remove(struct =
platform_device *pdev)
>> if (priv->phy)
>> phy_disconnect(priv->phy);
>>=20
>> - hip04_free_ring(ndev, d);
>> unregister_netdev(ndev);
>=20
> [Severity: High]
> This is a pre-existing issue, but does calling phy_disconnect() before
> unregister_netdev() cause a use-after-free and WARN?
>=20
> phy_disconnect() halts and detaches the PHY, dropping its reference =
count.
> The subsequent call to unregister_netdev() invokes hip04_mac_stop(), =
which
> unconditionally calls phy_stop().
>=20
> Could calling phy_stop() on a detached and potentially freed PHY =
device
> pointer cause a crash?
>=20
>> - of_node_put(priv->phy_node);
>> cancel_work_sync(&priv->tx_timeout_task);
>> + hrtimer_cancel(&priv->tx_coalesce_timer);
>> + /* Free the rings only after the interface is stopped (.ndo_stop =
via
>> + * unregister_netdev) and the work/timer are drained; the TX/NAPI
>> + * paths touch them while the device is up.
>> + */
>> + hip04_free_ring(ndev, d);
>=20
> [Severity: High]
> This is a pre-existing issue, but does hip04_free_ring() safely handle
> allocation failures?
>=20
> During probe, if allocating the TX descriptor ring fails, =
priv->tx_desc
> remains NULL, and the error path calls hip04_free_ring().
>=20
> Since hip04_free_ring() unconditionally calls dma_free_coherent() on
> priv->tx_desc, could this cause a kernel panic on architectures that =
trap
> virtual-to-physical translations on NULL?
>=20
>> + of_node_put(priv->phy_node);
>> free_netdev(ndev);
>=20
> [Severity: High]
> This is a pre-existing issue, but does explicitly freeing the netdev =
here
> create a use-after-free race with the interrupt handler?
>=20
> The driver requests its interrupt in hip04_mac_probe() using
> devm_request_irq(), meaning the IRQ is only freed during devres =
cleanup after
> hip04_remove() completely finishes.
>=20
> If an interrupt fires between free_netdev() and the devres cleanup,
> hip04_mac_interrupt() will cast dev_id to the freed ndev pointer, =
which seems
> like it would lead to a use-after-free crash.
>=20
>> }
>>=20
>=20
> [ ... ]
>=20
> Regarding the RX polling path in hip04_rx_poll():
>=20
> [Severity: High]
> This is a pre-existing issue, but does a failure in build_skb() cause =
a memory
> and DMA mapping leak?
>=20
> Looking at hip04_rx_poll():
>=20
>    if (unlikely(!skb)) {
>        net_dbg_ratelimited("build_skb failed\n");
>        goto refill;
>    }
>    ...
> refill:
>    ...
>    priv->rx_buf[priv->rx_head] =3D buf;
>    priv->rx_phys[priv->rx_head] =3D phys;
>=20
> If build_skb() fails, the code jumps directly to the refill label, =
completely
> bypassing the dma_unmap_single() call for the original buffer. It then
> allocates and maps a new buffer, overwriting the array entries.
>=20
> Could this permanently leak the original buffer and its DMA mapping,
> eventually leading to an OOM crash under memory pressure?


