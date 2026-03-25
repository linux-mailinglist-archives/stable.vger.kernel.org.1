Return-Path: <stable+bounces-230366-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q1GcD/gYxGnlwQQAu9opvQ
	(envelope-from <stable+bounces-230366-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:18:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA4C329B02
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA67A30342AC
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBECA40245A;
	Wed, 25 Mar 2026 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="TbeMhuQd"
X-Original-To: stable@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4EE3F6605;
	Wed, 25 Mar 2026 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774458568; cv=none; b=PVz1x6r+/izO/fzsPsAAjowfJhSdh2aDSYsnLKILP0HJU6qy7Ua4KYrCKdDSBhh5pJr6m/xTpDZpWIlpwoLbNC4dhx3tX0xytLRZI8+PDB/bYw07UuLDn8Ex3Nb7nkmrDmsfqUrAqeHlEbb03lRAn+KkpaCMHAaN2dqhUBBNVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774458568; c=relaxed/simple;
	bh=6172EdHmthvw5crdoc1Hns6OepuVcQaX3UoIrgriuGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZaDWlSrtAHI7gifL0dmApIexU7zJ7RRvOs4TXrEF+a1NHyZZbHGItOWPywYMQo8Nn0qMlvoDpwNLlsRm8xUHiqsCVa9AcS4linQ/RfyHXOlASBBn5KcK7fbcRbBfSPXhPl1l7Yt/6CwaUvBltEXuac5LwFbA3zl530l6zYKvpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=TbeMhuQd; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HQWZdasIxp6APQSzsPpDV5QuKag2pZIMS9HO32BplR4=; b=TbeMhuQdoKnFY9qnqBAFAltn35
	2D/E4LuaawD32y7VfHEJcq9BTgeFlmgUNgI8zvqtdssWBCCCT5zUwBtV06PlcNo1gO+uh/QvxDM7G
	LaqsfFj1qIK/FzoLFWObTKdEb9+47IhL7eRd7VwtZfga6vh94KTr7IFKoFKB6wbUw0HrWEVQcAXo1
	3fLSb2EfdnC4Njvd7YXEXYkW61+CEYP80PAqM9ateNLLRCScPT2BrzzzSEfVXK2ScU6GRtrYernxO
	Al5OgSMbDsau481s6KGAo7YK2Vq9Ev0FtFGZvlue6iGCXN9XS16BmajLvrAbVHBiAsOLYXGHaF4Lt
	9UL3dORg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41972)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5RjE-000000003j0-3Mz5;
	Wed, 25 Mar 2026 17:09:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5Rj9-000000006Bm-2Pxo;
	Wed, 25 Mar 2026 17:09:07 +0000
Date: Wed, 25 Mar 2026 17:09:07 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Tyllis Xu <livelycarpet87@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, maxime.chevallier@bootlin.com,
	peppe.cavallaro@st.com, rayagond@vayavyalabs.com,
	stable@vger.kernel.org, danisjiang@gmail.com,
	ychen@northwestern.edu
Subject: Re: [PATCH] net: stmmac: fix integer underflow in chain mode
 jumbo_frm
Message-ID: <acQWs7sXUgWjGsCM@shell.armlinux.org.uk>
References: <20260321041058.901149-1-LivelyCarpet87@gmail.com>
 <20260323141822.GB69756@horms.kernel.org>
 <CAJsYhQJga9M1aqeOLu0ni4i5iRirTDTxP1c8qyWz4=-9pBpRtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJsYhQJga9M1aqeOLu0ni4i5iRirTDTxP1c8qyWz4=-9pBpRtw@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230366-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,bootlin.com,st.com,vayavyalabs.com,gmail.com,northwestern.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.080];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 8EA4C329B02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 01:07:47AM -0500, Tyllis Xu wrote:
> I will try to change the code to consolidate with the ring-mode
> code, avoid whitespace diff, and resubmit the patch with a new
> correct subject line. Thank you for your feedback!

I mentioned the possibilities of other problems. How about this:

static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
{
        unsigned int nopaged_len = skb_headlen(skb);
...
        enh_desc = priv->plat->enh_desc;
        /* To program the descriptors according to the size of the frame */
        if (enh_desc)
                is_jumbo = stmmac_is_jumbo_frm(priv, skb->len, enh_desc);

1. enh_desc is set if priv->dma_cap.enh_desc is set and DMA capabilities
   exist (dmwac1000 and more recent.)

2. in chain mode, is_jumbo will be true if skb->len > 8KiB.
   in ring mode, is_jumbo will be true if skb->len >= 4KiB
   (note the >= vs > there which is suspicious.)

Let's consider the case where is_jumbo is false. So this could be a
packet with skb->len up to 4KiB-1 or 8KiB.

        if (unlikely(is_jumbo)) {
        } else {
                dma_addr = dma_map_single(priv->device, skb->data,
                                          nopaged_len, DMA_TO_DEVICE);

                stmmac_set_desc_addr(priv, first_desc, dma_addr);

                /* Prepare the first descriptor without setting the OWN bit */
                stmmac_prepare_tx_desc(priv, first_desc, 1, nopaged_len,
                                       csum_insertion, priv->descriptor_mode,
                                       0, last_segment, skb->len);

This can call one of several functions.

ndesc_prepare_tx_desc():
        if (descriptor_mode == STMMAC_CHAIN_MODE)
                norm_set_tx_desc_len_on_chain(p, len);
        else
                norm_set_tx_desc_len_on_ring(p, len);

static inline void norm_set_tx_desc_len_on_chain(struct dma_desc *p, int len)
{
        p->des1 |= cpu_to_le32(len & TDES1_BUFFER1_SIZE_MASK);
}

#define TDES1_BUFFER1_SIZE_MASK         GENMASK(10, 0)

So, this masks the length with 0x7ff, meaning this can represent
buffers up to 2047 bytes _max_ for normal descriptors in chain
mode.

static inline void norm_set_tx_desc_len_on_ring(struct dma_desc *p, int len)
{
        unsigned int buffer1_max_length = BUF_SIZE_2KiB - 1;

        if (unlikely(len > buffer1_max_length)) {
                p->des1 |= cpu_to_le32(FIELD_PREP(TDES1_BUFFER2_SIZE_MASK,
                                                  len - buffer1_max_length) |
                                       FIELD_PREP(TDES1_BUFFER1_SIZE_MASK,
                                                  buffer1_max_length));
        } else {
                p->des1 |= cpu_to_le32(FIELD_PREP(TDES1_BUFFER1_SIZE_MASK,
                                                  len));
        }
}

#define TDES1_BUFFER2_SIZE_MASK         GENMASK(21, 11)

This works around the 2KiB limitation, and fills buffer 1 with
2047 bytes and buffer 2 with the remainder... but there is _no_ code
that writes buffer 2's address in this case. This means we will
transmit garbage - and unknowingly of transmit COE is enabled (because
the checksums will be based on the data the NIC read from memory.)

However, normal descriptors in ring mode can correctly transmit up
to 2047 bytes correctly, or garbage after that up to 4094 bytes.

Now, this in the probe function:

                ndev->max_mtu = SKB_MAX_HEAD(NET_SKB_PAD + NET_IP_ALIGN);

equates to:

   PAGE_SIZE - NET_SKB_PAD - NET_IP_ALIGN - aligned skb_shared_info.

Notice that this doesn't limit by what the hardware can actually do.

Consider the implications where PAGE_SIZE is 16KiB or 64KiB and the
stmmac hardware only supports normal descriptors. max_mtu gets set
to something close to PAGE_SIZE. Even for 4KiB, it'll be close to that.
If skb_headlen(skb) can approach max_mtu, then we have the very real
possibility of overflowing the first descriptor - which in normal
mode can only really handle up to 2047 bytes.

This has been on my list of issues to try and sort out at some point,
at the moment I don't have any patches, but I'm instead trying to
clean up the code to make it more understandable so I can start
thinking about possible solutions. The code here has been a total
trainwreck, and some of those cleanups have recently gone in to
net-next.

I think the driver has only really been tested with the standard
1500 byte MTU, and maybe briefly with the 9KiB jumbo MTU, but honestly
I feel like saying that the transmit paths need thrown away and totally
rewritten - including that absolutely wrong max_mtu setting in the
probe function.

However, the problem is... I don't have hardware that uses normal nor
enhanced descriptors - my hardware is a nVidia Xavier, which is a
dwmac4/5 implementation using a different descriptor format, so I
can only make changes through sets of simple transformations.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

