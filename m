Return-Path: <stable+bounces-212734-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHWiBW3wemkiAAIAu9opvQ
	(envelope-from <stable+bounces-212734-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 06:30:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B396EABECB
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 06:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B2EF3014109
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 05:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0B52DB79A;
	Thu, 29 Jan 2026 05:29:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4ED2D9797;
	Thu, 29 Jan 2026 05:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769664599; cv=none; b=k4ItmG7l3yRN2TaI46ZXJnIPAEVtdCONL+FA/sIq/70I4TYWbx/Jts9BIUQswiUOhE0EwUhph/3hfatHEELY8pBtbYZWnz5hu6diT/nXkqQ91XRF8vDL1OvCRMNOD/rvhW4CWi6PEllnYq4kS0BGaJj+81vXXAEh0WZTOWzb1P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769664599; c=relaxed/simple;
	bh=30+imTi0yv9XJyqLeLF4BtuFVz4ZSuLiBHlKCiyICQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XosbDX8YUaqSgcWWi67AJ4ExFxDPy5a87jDh2ilFpGYN98F/R+90FoxwC/Mj3mnKDmaC77d/PTUJiG6AKm7r0Mdh7n/BtfFOGaT9xJhI+CRRcHFDG9w2lVz5HfHKGKChh/o0mB+SzN/abh0GQoz8b8LkU1Q/lAgziuq1qJ15q40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [10.213.22.141] (unknown [210.73.43.101])
	by APP-01 (Coremail) with SMTP id qwCowAAHr2pB8HppvVmpBg--.14477S2;
	Thu, 29 Jan 2026 13:29:39 +0800 (CST)
Message-ID: <11bd0685-8665-45ef-bec1-8ccf9e38ad6c@iscas.ac.cn>
Date: Thu, 29 Jan 2026 13:29:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: spacemit: k1-emac: fix jumbo frame support
To: Tomas Hlavacek <tmshlvck@gmail.com>, netdev@vger.kernel.org
Cc: linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dlan@kernel.org, stable@vger.kernel.org
References: <20260129042908.410326-1-tmshlvck@gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260129042908.410326-1-tmshlvck@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qwCowAAHr2pB8HppvVmpBg--.14477S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw47Zr1UWrWrAr43ZF15CFg_yoWrAF1kpF
	4Y9F90krs0yrn2k3Z2ya18tFn8ta17Wr10k3yjv3y8Z3sFkr9rGrnxKrW3Cr9rurWkWF1F
	9a4UZrnruFWDXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07betCcUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212734-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangruikang@iscas.ac.cn,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:mid,iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B396EABECB
X-Rspamd-Action: no action

On 1/29/26 12:29, Tomas Hlavacek wrote:
> The driver never programs the MAC frame size and jabber registers,
> causing the hardware to reject frames larger than the default 1518
> bytes even when larger DMA buffers are allocated.
>
> Program MAC_MAXIMUM_FRAME_SIZE, MAC_TRANSMIT_JABBER_SIZE, and
> MAC_RECEIVE_JABBER_SIZE based on the configured MTU. Also fix the
> maximum buffer size from 4096 to 4095, since the descriptor buffer
> size field is only 12 bits. Account for double VLAN tags in frame
> size calculations.
>
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tomas Hlavacek <tmshlvck@gmail.com>
> ---
> v3:
> - Set all three frame/jabber registers, fix 12-bit buffer size field
>   overflow, use actual frame size with VLAN headroom consistently.
>
> v2: https://lore.kernel.org/netdev/20260126171449.83288-1-tmshlvck@gmail.com/
> - Added Fixes tag and Cc stable.
>
> v1: https://lore.kernel.org/netdev/20260126135919.77168-1-tmshlvck@gmail.com/
> ---
>  drivers/net/ethernet/spacemit/k1_emac.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
> index 220eb5ce7583..cd6879d7434c 100644
> --- a/drivers/net/ethernet/spacemit/k1_emac.c
> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> @@ -12,6 +12,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/etherdevice.h>
>  #include <linux/ethtool.h>
> +#include <linux/if_vlan.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> @@ -38,7 +39,7 @@
>  
>  #define EMAC_DEFAULT_BUFSIZE		1536
>  #define EMAC_RX_BUF_2K			2048
> -#define EMAC_RX_BUF_4K			4096
> +#define EMAC_RX_BUF_MAX			FIELD_MAX(RX_DESC_1_BUFFER_SIZE_1_MASK)
>  
>  /* Tuning parameters from SpacemiT */
>  #define EMAC_TX_FRAMES			64
> @@ -202,8 +203,7 @@ static void emac_init_hw(struct emac_priv *priv)
>  {
>  	/* Destination address for 802.3x Ethernet flow control */
>  	u8 fc_dest_addr[ETH_ALEN] = { 0x01, 0x80, 0xc2, 0x00, 0x00, 0x01 };
> -
> -	u32 rxirq = 0, dma = 0;
> +	u32 rxirq = 0, dma = 0, frame_sz;
>  
>  	regmap_set_bits(priv->regmap_apmu,
>  			priv->regmap_apmu_offset + APMU_EMAC_CTRL_REG,
> @@ -228,6 +228,15 @@ static void emac_init_hw(struct emac_priv *priv)
>  		DEFAULT_TX_THRESHOLD);
>  	emac_wr(priv, MAC_RECEIVE_PACKET_START_THRESHOLD, DEFAULT_RX_THRESHOLD);
>  
> +	/* Set maximum frame size and jabber size based on configured MTU,
> +	 * accounting for Ethernet header, double VLAN tags, and FCS.
> +	 */
> +	frame_sz = priv->ndev->mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN;
> +
> +	emac_wr(priv, MAC_MAXIMUM_FRAME_SIZE, frame_sz);
> +	emac_wr(priv, MAC_TRANSMIT_JABBER_SIZE, frame_sz);
> +	emac_wr(priv, MAC_RECEIVE_JABBER_SIZE, frame_sz);
> +
>  	/* Configure flow control (enabled in emac_adjust_link() later) */
>  	emac_set_mac_addr_reg(priv, fc_dest_addr, MAC_FC_SOURCE_ADDRESS_HIGH);
>  	emac_wr(priv, MAC_FC_PAUSE_HIGH_THRESHOLD, DEFAULT_FC_FIFO_HIGH);
> @@ -924,14 +933,14 @@ static int emac_change_mtu(struct net_device *ndev, int mtu)
>  		return -EBUSY;
>  	}
>  
> -	frame_len = mtu + ETH_HLEN + ETH_FCS_LEN;
> +	frame_len = mtu + ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN;
>  
>  	if (frame_len <= EMAC_DEFAULT_BUFSIZE)
>  		priv->dma_buf_sz = EMAC_DEFAULT_BUFSIZE;
>  	else if (frame_len <= EMAC_RX_BUF_2K)
>  		priv->dma_buf_sz = EMAC_RX_BUF_2K;
>  	else
> -		priv->dma_buf_sz = EMAC_RX_BUF_4K;
> +		priv->dma_buf_sz = EMAC_RX_BUF_MAX;
>  
>  	ndev->mtu = mtu;
>  
> @@ -2005,7 +2014,7 @@ static int emac_probe(struct platform_device *pdev)
>  	ndev->hw_features = NETIF_F_SG;
>  	ndev->features |= ndev->hw_features;
>  
> -	ndev->max_mtu = EMAC_RX_BUF_4K - (ETH_HLEN + ETH_FCS_LEN);
> +	ndev->max_mtu = EMAC_RX_BUF_MAX - (ETH_HLEN + 2 * VLAN_HLEN + ETH_FCS_LEN);
>  	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
>  
>  	priv = netdev_priv(ndev);

Thanks for the fix. This essentially matches what I've been testing as well.

Reviewed-by: Vivian Wang <wangruikang@iscas.ac.cn>



