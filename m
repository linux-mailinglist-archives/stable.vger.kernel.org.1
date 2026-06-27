Return-Path: <stable+bounces-269393-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kAMhOk/UP2q+YgkAu9opvQ
	(envelope-from <stable+bounces-269393-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 15:46:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E29D6D2095
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 15:46:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=sakamocchi.jp header.s=fm1 header.b="r RZokgl";
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b=O0J5DExq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269393-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269393-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=sakamocchi.jp;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712013015717
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C5A3AD518;
	Sat, 27 Jun 2026 13:46:39 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EF32D12EC;
	Sat, 27 Jun 2026 13:46:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782567999; cv=none; b=qBecJv9JzS+HC/q9aO01FLWlj8zJDvhjr6bhCKzgGHYa/3QQqah0TUhGY7snprDNg78x76IPTQPTLLB3lwCmBakRfJpv0QAtamKk5mlWF8Hv34VaCtqajahli/pO/kqfZ4WMaC1w8F1opDdv1tENHhNN2s0LpnD2Uf1cmffh8Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782567999; c=relaxed/simple;
	bh=rymbKOINyVPQ9fM+uUWBtNeWQtOucy4Bg6SaeBViOoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxtQ94kD2LaDKiW5CB71bsLn9nqgUdi+QDLDXceJ/yI73BH9Ry8MDdJrxW4FPQLUlaamuSUf/whxBO2hvpQAufqt+0TqW71MrKiAYunQcbfQJwMKoVXRAMoIN++ntUEKfCxpy2zfeN5SggwuYC1NUtiVfINWIuxY7wGaEH7Cwrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=rRZokglB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0J5DExq; arc=none smtp.client-ip=103.168.172.152
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F7FC1400166;
	Sat, 27 Jun 2026 09:46:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sat, 27 Jun 2026 09:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1782567996; x=
	1782654396; bh=4U+xzYlqXfBGdhw//87pX4ghLmWw+sSYwJKgqsTTFLE=; b=r
	RZokglB1ky35FN1fErw6rV3slmuYyVa9c84XbE6jxFzspEafxglOQuXgsfydEWrt
	gCgJsU7WmB9I0Kei2/7yzWkSgZFCNwVQKNE0v6nRXDX5/SxzhhIB1YeBzWPXNLas
	LIKdPlfnQDSHKkirgc1i3kGAijl8MJ9279QoFlDdVCTSaXFs8xHL+CN9b+xjtOet
	y/vSm6uHKGeuRq6RpRPcvAb6C5+LW9QrFOFmjPALGTxUr6O1odEk02KJnKG5qP8I
	3yhBVMzCB7rq1G0pBGLK/frhnTPl/i2tA8pYBTL+NQrsm+JXBH4tqSRCaaHDf2wY
	sQUMvSqCF4OTa2yroU68w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782567996; x=1782654396; bh=4U+xzYlqXfBGdhw//87pX4ghLmWw+sSYwJK
	gqsTTFLE=; b=O0J5DExq6GUW/eWfYNQwsmSxGn5AAG/e+v7M90KPUT5Z6YDWWmG
	Q5LQBB3JXG40iMGMMWuXb35GkMUV3BXMYDjtN/oxL7pad8zK/aDE5+ejbZBs/PLy
	h5TcDeRjogazAK3onUITrlcwhaw9WRTpkFB8Ao8gAINx1LUnJY9qNjYwCeaYY8Ya
	D9BearFTuyqVjDlPDTyaJWBQjlQF3je9PNTwi8k/Qn/VGTKDc3kEhMv+KO1BHR+g
	zRhbWBQ7leeXAPW5lQJuVLLfDOY3tXMP5qDgtmgTP41XRwVgLI5WAm2xk4C3/DaT
	XhW/RFeIREWU6hH9etgsZTDtanOF5t57OTQ==
X-ME-Sender: <xms:O9Q_ajA-u4PtHR3aWbgAm04qNNsRCvuhcBWaRwKO-rY2KWSRJkCupg>
    <xme:O9Q_agaBBWBrbxGo7MCrz1z7FoRVuMbpCinBD7lyNr38rVCsxXFU0eCmoqjBgXcWm
    BrFRylHZFlYxUXFynfT6MUKyPL2K_qfhHNv2IaQWmEde9SUNOCCfuM>
X-ME-Received: <xmr:O9Q_am7m3ZzFLrW7917aUmNupe452yk3Nk3c7Jy3NserPC2cpR6z0V6DD0u1xTIdmdj6haC80-dHotJKDH1TxbtpNG72>
X-ME-Proxy-Cause: dmFkZTFVpxvSKS0iE+mrp2cBuQSPqyU8pC595P1qxeUX3zOujVYsyOWMGWjg/CbyBCbIvl
    dH+rlY7Jy07O3qCUjjCZKT3vYbagcRm+CjIGVYSWUzI1jz9df26koAMZEe+CUVJL4shqMv
    f/zAfTMVsHyCot14PC85nZjeDvnFCyHtZhEDxCe0m7/S3elQC+6TLWKx5Y7kPo0T3BdSjf
    IpklRRHFe/BaYg0/k3pQeA5A38b0PkBcOaBVwUTiJjWAvemgQ7kcTC/jG7tixQRc87Z2f4
    o2zVLygyu4RsBbjXbt8orPvGEDdRR4bbpBhLuyNr5SJ1jHUZf8zFnxKKPW227vY08ZTjo5
    04dgMwewWRUJkBFTzJM6zbE9LIj08veBwBnsN9bcjxhr/M2W4IhvE1Kc7qHWiFTknXPxcW
    IRXH2brRmWzk+6Sl7TCgGC5Ey2tyf5RxHw9GqbCHLI/8xPfModK5OGPVFi4UkAAQjYM2MM
    dQZ7zXUwvis/2HpZbHLYit3U+4V1Q5n3XIHhYCy9HVVWmWSmbfD5J5ZR3eZZL0+OSJOmP/
    GcQWtiAVApe4HwJl7pKmaL6iYrsqocMf8uJrDICdpJ9nw4OPqwvTbMnyzzcIwxW1TgChhi
    s7B4QZoSq0v10fq+BINR9gJiAFjlIt5F0dXPd9DGATvL+DwR7ZFp1EKDaleA
X-ME-Proxy: <xmx:O9Q_ahYbi34hCZTdjhAd6eCGABHmZj2hWWyqkAcKJ9HZ9yZ6KUVpQQ>
    <xmx:O9Q_algJ7hw94ljlY9fr-goJJb4EEwIDlcLwIfwdejWDgw0Wry-PXQ>
    <xmx:O9Q_ai9k2x4_R1s0o_DonLjAKWR_8fmMFWABeMnsXMvnc3nWEroUUQ>
    <xmx:O9Q_agoq-bITYVpZZcJPcV7YD6vnmvcLuuFruqGlpu-s2YerMU7RKw>
    <xmx:PNQ_avjz0LrE5SZ8si-Ck3ZJ2bUYukYBwvyKn1Jjqz2j8iHZ61xmXZ_N>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Jun 2026 09:46:33 -0400 (EDT)
Date: Sat, 27 Jun 2026 22:46:31 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] fix: firewire: report_lost_node: unconditional
 fw_node_put after   conditional fw_node_event causes excess put
Message-ID: <20260627134631.GA386463@sakamocchi.jp>
Mail-Followup-To: WenTao Liang <vulab@iscas.ac.cn>,
	linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
References: <20260626123743.36388-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626123743.36388-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sakamocchi.jp,none];
	R_DKIM_ALLOW(-0.20)[sakamocchi.jp:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269393-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:linux1394-devel@lists.sourceforge.net,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[sakamocchi.jp:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[o-takashi@sakamocchi.jp,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o-takashi@sakamocchi.jp,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E29D6D2095

Hi,

Thanks for the patch.

On Fri, Jun 26, 2026 at 08:37:43PM +0800, WenTao Liang wrote:
> report_lost_node unconditionally calls fw_node_put after fw_node_event,
>   but fw_node_event does not unconditionally acquire a reference. Since
>   for_each_fw_node already holds a reference on the node during traversal,
>   the extra fw_node_put over-decrements the refcount. The sibling callback
>   report_found_node does not call fw_node_put, confirming the extra put is
>   erroneous.
> 
> Cc: stable@vger.kernel.org
> Fixes: 3038e353cfaf ("firewire: Add core firewire stack.")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/firewire/core-topology.c | 1 -
>  1 file changed, 1 deletion(-)
 
As you note, in for_each_fw_node(), the reference count is incremented
for safe traversing over the topology tree once, and it is decremented
surely at the end. So the decrement of reference count in report_lost_node()
is the different purpose.

> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
> index bb2d2db30795..49820e4a34ff 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -298,7 +298,6 @@ static void report_lost_node(struct fw_card *card,
>  			     struct fw_node *node, struct fw_node *parent)
>  {
>  	fw_node_event(card, node, FW_NODE_DESTROYED);
> -	fw_node_put(node);
 
It corresponds to the initial increment of reference count when creating
the node instance. It is the part of node removal process in the tree,
and is required just in the line.
  
>  	/* Topology has changed - reset bus manager retry counter */
>  	card->bm_retries = 0;
> -- 
> 2.39.5 (Apple Git-154)


Thanks

Takashi Sakamoto

