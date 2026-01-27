Return-Path: <stable+bounces-211717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJKhD3YseGl7oQEAu9opvQ
	(envelope-from <stable+bounces-211717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 04:09:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DE28F679
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 04:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 296EB304DE8F
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670D52F659F;
	Tue, 27 Jan 2026 03:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsteKB38"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157122EBBB2;
	Tue, 27 Jan 2026 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769483118; cv=none; b=pFnNwSMk7x03k/BQQSbxRaMSaUgF4934iAqA7R4pw+4TvaNLI3eo6nc6/MHwn4V1MH2ngLjNFIZLx47614LZCrSHLPnI0XHbH/d0jJJC/oeQBqCZXcAu+MC1NyM8h/KrLFG+RzqJ3q2UMWOS9BPhAWoBsPYkzCPPgdbnXvnFeEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769483118; c=relaxed/simple;
	bh=0eIazrYKt2H5dVz7aR3WwR1CWkD2A4VVVnLg5inRWCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUrFJw0420cz8lznJ3c/gwvFOzGFG3PDIK52IQAWQP/31h2iUa2+VvnoArkf46GIe9elsMLSUMv6q5LwjzNkpFznUbsQo255Nm77T3P2JLqGJEKSTF/9qSH96unrzD6tAodYiYVomi05ZhZearGQc46i04qztbaV3cDpOXm5Tks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsteKB38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4736C116C6;
	Tue, 27 Jan 2026 03:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769483117;
	bh=0eIazrYKt2H5dVz7aR3WwR1CWkD2A4VVVnLg5inRWCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bsteKB38Vgdxvn6fjaonze1NGEu4h/x6dfnvShLEL5ZXBp6d78jL3+k0oIrPtrL+W
	 JHpww+J6XLaI8onnyqSBQJVjRb12xmCEaS4TMyuDwq6K2tOQz+pRYNQmAR58Kvkxek
	 kKKnilR3gJVsaXrW6PD0/KWxsNcOw1a91QXE8cNlprmiTDGns7cfmc66XiiN/ax1cJ
	 JofwEocyUtpkGH3rPHgThSTr8DSpgIUhh+CgrHJb0JUbKA5oHdKB2XWFdgj/OlnTgA
	 r+98poQyyjsQVifmEX6PEfHp1XmeQNa+NCJQ+shpBhFekKHzv20ZVeVRhh2KGrjnfn
	 S5XJNivEjJjqg==
From: Jakub Kicinski <kuba@kernel.org>
To: lihaoxiang@isrc.iscas.ac.cn
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	ast@kernel.org,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	john.fastabend@gmail.com,
	mcoquelin.stm32@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	daniel@iogearbox.net,
	linux-stm32@st-md-mailman.stormreply.com,
	boon.leong.ong@intel.com,
	hawk@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	alexandre.torgue@foss.st.com
Subject: Re: fix a potential memory leak in stmmac_xdp_enable_pool()
Date: Mon, 26 Jan 2026 19:04:47 -0800
Message-ID: <20260127030447.3838706-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260125135412.2070798-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260125135412.2070798-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,vger.kernel.org,fomichev.me,gmail.com,lists.infradead.org,iogearbox.net,st-md-mailman.stormreply.com,intel.com,davemloft.net,redhat.com,google.com,foss.st.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-211717-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: D2DE28F679
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
fix a potential memory leak in stmmac_xdp_enable_pool()

This patch adds xsk_pool_dma_unmap() to the error path when
stmmac_xsk_wakeup() fails, to release the DMA mapping allocated
earlier by xsk_pool_dma_map().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> index d7e4db7224b0..7d89d6066ea3 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c
> @@ -48,8 +48,10 @@ static int stmmac_xdp_enable_pool(struct stmmac_priv *priv,
>  		napi_enable(&ch->rxtx_napi);
>
>  		err = stmmac_xsk_wakeup(priv->dev, queue, XDP_WAKEUP_RX);
> -		if (err)
> +		if (err) {
> +			xsk_pool_dma_unmap(pool, STMMAC_RX_DMA_ATTR);
>  			return err;
> +		}

Is the error cleanup here complete? Looking at stmmac_xdp_enable_pool(),
before this point the code has already executed:

  set_bit(queue, priv->af_xdp_zc_qps);
  stmmac_enable_rx_queue(priv, queue);
  stmmac_enable_tx_queue(priv, queue);
  napi_enable(&ch->rxtx_napi);

When stmmac_xsk_wakeup() fails, the patch unmaps the DMA pool but does not
appear to reverse these other state changes. Comparing with the cleanup
sequence in stmmac_xdp_disable_pool(), should the error path also:

  - call clear_bit(queue, priv->af_xdp_zc_qps)
  - disable the queues and NAPI that were just enabled

The DMA descriptors allocated by stmmac_enable_rx_queue() and
stmmac_enable_tx_queue() would also be leaked on this error path.

>  	}
>
>  	return 0;
-- 
pw-bot: cr

