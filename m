Return-Path: <stable+bounces-247078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPiOORggBWopSwIAu9opvQ
	(envelope-from <stable+bounces-247078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:06:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E00E653C8AF
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 03:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C16230086B8
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 01:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7B43016E3;
	Thu, 14 May 2026 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9jmVTZJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E474C92;
	Thu, 14 May 2026 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778720781; cv=none; b=o004eaW93iaxK2YPwSLvg4GvmWI2o/a5ePrhXz6mdZH+xwP15s0h5wSvAJWTx1lbVmgOAV1fWPeI/roBK4nW/YkFrFiUNQD3df7nLHkNqfOfdySqOrf2r0t8wrDLzW5SYIQBHXNr6J/qU7W0lz4xUjXZINGaYE0tPDz19tgytlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778720781; c=relaxed/simple;
	bh=Y5V9+WMecWRDrwqlEqRBaFEVNc1h5aRc/aLXIAEX//0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWC3i2r7ZigXk3GGj/Ys9E+YeqZwhslTyoJJaUyIUsSAab4h/1s6hmZaKtTXDkoUMMhfraDZfcK5tstDiyWMozdq6xREhZ/q5xng/fF4mdW/6NqE2dN0NkZWF8Y6iIOtPJhOK/v0bLrcB15mc7jc/eUVI/EQIBoyiOt2oHOFQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9jmVTZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E143C19425;
	Thu, 14 May 2026 01:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778720780;
	bh=Y5V9+WMecWRDrwqlEqRBaFEVNc1h5aRc/aLXIAEX//0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9jmVTZJJHSIhVp56Lvv+L8TIg9yO9XfS0AMQHak7MJ+HCFXsAX1EkrspC+kfrgyU
	 BLgeUFAxpWYIG66GpABCade2LlqMf3bk00fALuyypKil5NQ7ql18U0s3d52dfJbnlu
	 jydywJlu37fop2VDYaPAyG+d8K8JVC1nbr2zJJg8mCemyn+HIE//V52LfrAo15Q01T
	 EzI4CcElyPyYaDmP6OXdOOViLx3yxVq0O0KCZoC3ruUd06F7sR8vNX2FACuAwrCxkQ
	 vMDG/K457wvciv7DyE+eEpz/H/pNaWFUr8oFQAjbQjsYwxnkAh37ojs+SI/FKhR0o7
	 qyj3h0EUoVLgA==
Date: Wed, 13 May 2026 18:06:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Tonghao Zhang <xiangxia.m.yue@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: ifb: clamp ethtool stats loops to
 num_tx_queues
Message-ID: <20260513180619.47d447a1@kernel.org>
In-Reply-To: <20260511122835.441911-1-michael.bommarito@gmail.com>
References: <20260511122835.441911-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E00E653C8AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-247078-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, 11 May 2026 08:28:35 -0400 Michael Bommarito wrote:
>  static void ifb_get_ethtool_stats(struct net_device *dev,
>  				  struct ethtool_stats *stats, u64 *data)
>  {
>  	struct ifb_dev_private *dp = netdev_priv(dev);
>  	struct ifb_q_private *txp;
> +	unsigned int n_queues = dev->num_tx_queues;
>  	int i;
>  
>  	for (i = 0; i < dev->real_num_rx_queues; i++) {
> -		txp = dp->tx_private + i;
> -		ifb_fill_stats_data(&data, &txp->rx_stats);
> +		if (i >= n_queues) {
> +			ifb_fill_empty_stats_data(&data);
> +			continue;
> +		}
> +
> +		txp = dp->tx_private + i;
> +		ifb_fill_stats_data(&data, &txp->rx_stats);
>  	}
>  
>  	for (i = 0; i < dev->real_num_tx_queues; i++) {
> -		txp = dp->tx_private + i;
> -		ifb_fill_stats_data(&data, &txp->tx_stats);
> +		if (i >= n_queues) {
> +			ifb_fill_empty_stats_data(&data);
> +			continue;
> +		}
> +
> +		txp = dp->tx_private + i;
> +		ifb_fill_stats_data(&data, &txp->tx_stats);
>  	}

Take a look at ifb_stats64(), queues without Tx can't Rx here.
The use of real_* members is also not correct, the device
should report stats for all queues it has, not just active ones.
So please rewrite the ethtool stats code to dump rx and tx based
purely on dev->num_tx_queues
-- 
pw-bot: cr

