Return-Path: <stable+bounces-211722-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK1WHmJBeGlspAEAu9opvQ
	(envelope-from <stable+bounces-211722-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 05:38:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D354D8FDE3
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 05:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 809C6301DB87
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 04:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4C72D248D;
	Tue, 27 Jan 2026 04:38:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253F3C2F;
	Tue, 27 Jan 2026 04:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769488728; cv=none; b=h0yyplQzRdb2Hi8YFLBx0Du59BxPOtwpYcmSa1FCnTaGqG0n5QbnBnvCdZ14b4CHvkxaADZdE1hhbutg4pFBiXnmqvqwHNzuubk8xrrM6/6/Koc1CAUF5dSpmd1g90ARTQRtdgaNtVtb6BRl9znu5E7UG/P9KJXyqhX6VQeS274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769488728; c=relaxed/simple;
	bh=2pxIiiqvyVltJcyDScY3y+LrRMiWAYkh+pHfqfGsi9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrWhwgQ/VhHw9kG7GJayEjbQUUqJ00+WcF7ysoEPNjZxZ2ZrGCew2RvoU8hJ+KwU0z01jBQ4V/QxC+2muftc8ehXapm1lCBJYNWm4KbW7hMnmKYqxxGHER6V/tnyBNpU7BJXAkesVRa8sfw44k1gVPibTauS159jKgbnKXsV+R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.213.22.4] (unknown [210.73.43.101])
	by APP-03 (Coremail) with SMTP id rQCowAC31dxGQXhpI1vqBg--.61005S2;
	Tue, 27 Jan 2026 12:38:31 +0800 (CST)
Message-ID: <42765b5f-2d94-4fd6-8cd9-977729220696@iscas.ac.cn>
Date: Tue, 27 Jan 2026 12:38:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: spacemit: k1-emac: program frame size
 registers for jumbo frames
To: Tomas Hlavacek <tmshlvck@gmail.com>, netdev@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Yixun Lan <dlan@kernel.org>
References: <20260126135919.77168-1-tmshlvck@gmail.com>
 <20260126171449.83288-1-tmshlvck@gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260126171449.83288-1-tmshlvck@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:rQCowAC31dxGQXhpI1vqBg--.61005S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZw17Jw1xCFW7XF4kuF4UArb_yoW5ArWkpa
	y5XasI9r4jyF1xKa1kAa18X34rJa1IqFyUCFyYvrWrZ3WDJr17WryrKFW3Cr98urWrWw1S
	va4UZw43CF1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5MwZ3UUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[iscas.ac.cn];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211722-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D354D8FDE3
X-Rspamd-Action: no action

Hi Tomas,

Thanks for the fix. Just a few more things...

Firstly, I believe it is preferred to send a new patch version in its
own thread with a link to the previous version. See
Documentation/process/maintainer-netdev.rst:

  The new version of patches should be posted as a separate thread,
  not as a reply to the previous posting. Change log should include a lin=
k
  to the previous posting (see :ref:`Changes requested`).

You can do that for v3.

Secondly...

On 1/27/26 01:14, Tomas Hlavacek wrote:
> [...]
>
> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethe=
rnet/spacemit/k1_emac.c
> index 220eb5ce7583..31b1bdb2827e 100644
> --- a/drivers/net/ethernet/spacemit/k1_emac.c
> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> @@ -228,6 +228,12 @@ static void emac_init_hw(struct emac_priv *priv)
>  		DEFAULT_TX_THRESHOLD);
>  	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOL=
D);
> =20
> +	/* Set maximum frame size and jabber size based on configured buffer
> +	 * size.
> +	 */
> +	emac_wr(priv, MAC_MAXIMUM_FRAME_SIZE, priv->dma_buf_sz);
> +	emac_wr(priv, MAC_RECEIVE_JABBER_SIZE, priv->dma_buf_sz);
> +

I tested this (also setting MAC_TRANSMIT_JABBER_SIZE, as Yixun
described)=C2=A0and it appears that this has surfaced a latent bug in the=
 code.

I found that the hardware can't actually handle 4096-byte buffers, since
the size field is only 12-bit. (It was my fault to assume that existing
code was right in this regard...) So MTU larger than ~2000 breaks the
hardware, and also triggers the WARN_ON_ONCE() in emac_rx_frame_good().
4095 works just fine.

Can you include this in v3 as well? Maybe also reword the commit
messages a bit. Thanks.

(Here's hoping Thunderbird hasn't destroyed the whitespace...)

diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethern=
et/spacemit/k1_emac.c
index 31b1bdb2827e..78306a06a329 100644
--- a/drivers/net/ethernet/spacemit/k1_emac.c
+++ b/drivers/net/ethernet/spacemit/k1_emac.c
@@ -38,7 +38,7 @@
=20
 #define EMAC_DEFAULT_BUFSIZE		1536
 #define EMAC_RX_BUF_2K			2048
-#define EMAC_RX_BUF_4K			4096
+#define EMAC_RX_BUF_MAX			FIELD_MAX(RX_DESC_1_BUFFER_SIZE_1_MASK)
=20
 /* Tuning parameters from SpacemiT */
 #define EMAC_TX_FRAMES			64
@@ -937,7 +937,7 @@ static int emac_change_mtu(struct net_device *ndev, i=
nt mtu)
 	else if (frame_len <=3D EMAC_RX_BUF_2K)
 		priv->dma_buf_sz =3D EMAC_RX_BUF_2K;
 	else
-		priv->dma_buf_sz =3D EMAC_RX_BUF_4K;
+		priv->dma_buf_sz =3D EMAC_RX_BUF_MAX;
=20
 	ndev->mtu =3D mtu;
=20
@@ -2011,7 +2011,7 @@ static int emac_probe(struct platform_device *pdev)=

 	ndev->hw_features =3D NETIF_F_SG;
 	ndev->features |=3D ndev->hw_features;
=20
-	ndev->max_mtu =3D EMAC_RX_BUF_4K - (ETH_HLEN + ETH_FCS_LEN);
+	ndev->max_mtu =3D EMAC_RX_BUF_MAX - (ETH_HLEN + ETH_FCS_LEN);
 	ndev->pcpu_stat_type =3D NETDEV_PCPU_STAT_DSTATS;
=20
 	priv =3D netdev_priv(ndev);


