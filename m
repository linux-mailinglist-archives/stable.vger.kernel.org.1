Return-Path: <stable+bounces-214541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PsjJHTbhGkV6AMAu9opvQ
	(envelope-from <stable+bounces-214541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 19:03:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07468F6494
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 19:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FFC1301E95C
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 18:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB72B303CAA;
	Thu,  5 Feb 2026 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0aGkzYC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF0B2F6573;
	Thu,  5 Feb 2026 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314597; cv=none; b=Kq5PFW1n+aqFsikQbnlgxbfu9lVc4KeyyOE7D7b7bsHJPuKc7OCoVv0oQqg7IRb23TxINdoI0YdRKL5SpuPOTBZpEgMDytb75j1ow4rvIauW/uqp0sqkTnvQJPyXGpH8WgyVdzVd6oKTYLP6n0undxys29PLqFfu0vLCK5d7J14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314597; c=relaxed/simple;
	bh=eoGKI4mYUgozUN7iAaqPGmwPfFWlL1j3e5RUiBps78k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNyiK8CpkvqcMigeZsbQrxXzS9e2eMQPHQrQc19HzuN+fpyjC9OTVBLmP/gTnvJtZsThO/cL80QgR54pxZ30dog5Zm7sNLn2md3TXAQIzgPA/AJzXyqh9RyuNupEdS/xeeqZG8FBzJ1AaOoGypvqIIPjHSY7zt5XGLEUDjHAmFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0aGkzYC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA80AC4CEF7;
	Thu,  5 Feb 2026 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770314597;
	bh=eoGKI4mYUgozUN7iAaqPGmwPfFWlL1j3e5RUiBps78k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z0aGkzYCC4+yxMqLk7y/j67B5pkLEHi328Hr1fKKqnM79H/ynNVza+rr/aIwg2TeZ
	 CYo7AvpGnHLfzqm4q3dFyaRoiCEJdaTB+aiYJjeUIIcc5lDIH6C/tvvZAQkWODRg4R
	 Ie8loKcQmjAfbhaWjAyDWK5UzIYNyb3Aiaf0Vvk1TG2V2Unnp6Gr7l77zYMqpKycrd
	 IO/HQyE//Q1MxB1rEXdVMLWC1rZgoXvUJT3MVhTj+6qebJOtO1Q4Fx02ejooypgDfG
	 xMnypzrI6Dl3KTokE5tSKmDSUdm4siQdXfkXVB6rp5ErV7JLrxw7y8/0B38st6aMAC
	 FFym5TFGdzFyg==
Date: Thu, 5 Feb 2026 10:03:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, MD Danish Anwar
 <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: ti: icssg-prueth: Add dependency on HSR
Message-ID: <20260205100315.134766d7@kernel.org>
In-Reply-To: <20260203-icssg-dep-v1-1-bacaf5234fb3@gmail.com>
References: <20260203-icssg-dep-v1-1-bacaf5234fb3@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214541-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07468F6494
X-Rspamd-Action: no action

On Tue, 03 Feb 2026 20:43:08 +0800 Kevin Hao wrote:
> Commit 95540ad6747c ("net: ti: icssg-prueth: Add support for HSR frame
> forward offload") introduces support for offloading HSR frame forwarding,
> which relies on functions such as is_hsr_master() provided by the HSR
> module. Therefore, a dependency on HSR should be added for this driver.
> Otherwise, the following build failures will occur when icssg-prueth is

> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index fe5b2926d8ab060d83f5a58d91e749a45c6cea18..48aa3457fd6d7fd99147e4fb1148559d6fcba082 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -192,6 +192,7 @@ config TI_ICSSG_PRUETH
>  	depends on NET_SWITCHDEV
>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>  	depends on PTP_1588_CLOCK_OPTIONAL
> +	depends on HSR

Looks like there are appropriate static inlines in place to handle
HSR=n in the driver the only problematic case is if HSR is m and
drivers is y, no?

	depends on HSR || HSR=n

is likely more suitable.
-- 
pw-bot: cr

