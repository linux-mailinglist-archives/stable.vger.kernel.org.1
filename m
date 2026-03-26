Return-Path: <stable+bounces-230505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMN9Dq1qxWl1+AQAu9opvQ
	(envelope-from <stable+bounces-230505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:19:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D463390FF
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 18:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 052873041BFA
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01543343D75;
	Thu, 26 Mar 2026 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDXTH51Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB3250BEC;
	Thu, 26 Mar 2026 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774545333; cv=none; b=e+ExuRroWPKtY2GBOr/0nmVKpPtG+uOGrz5e8a/emyydH7Me4TEATIhn4EbaBPvWTF4iugL3w0xv67Z4OBeQu0JQBSHQyGM9iWoMGlViy8KkVeV7pWleKf8hlMZNLlt6CieTJo49DXl/xjZctEsSkGb8wwwrm5ktOSwJGpFjvSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774545333; c=relaxed/simple;
	bh=jvkDS9tKLVeEgF0DgkEhc5+lTjNn80rqHLS3xCz8V0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmjR7j7ZVif4PKm0MqW4zV8yaBEUjvECb7tKhOxnG+tyaru3FTCcRtPZow5WWDLgknXZ+Rxx3XaA43myhUe/oi0cJKemKh9Mkr29TgulJl5epPIM9KFO05fBnVQeMm9T1zK1H3h7Gz3DXIUyMcFsRU7mHIB43wICmTeAMGN/qBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDXTH51Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F717C19423;
	Thu, 26 Mar 2026 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774545333;
	bh=jvkDS9tKLVeEgF0DgkEhc5+lTjNn80rqHLS3xCz8V0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDXTH51QoJgCKUhhoHf42bamFgq+wwWwg1N9Yig9JfaQ3gADMfymF5+pKFJZBgewY
	 scQZV+UZ1Twq7B/cvZGwTdphEYhvnqj1envTzFEZB1quSnoOAwsXV+D6CcgmWzSO3I
	 sNcM4Q264pAZgFkDgmoFWNG3zPjLGLiYXClrgzo/dqjANPgJ6I821qS009NzZkAV9q
	 b+e8Nh5yJ1KOp+KZ4C4oFIUMxq5q2iXPid9IYvcrcM057xWBWk36a+IR4lwec+qQBD
	 B6/NkJ4vU61QMiR2zZKH3k+RXdBxUpvHeuWY70qvzZ2G2nc7UvS3pGLV12cmDjkCkT
	 xJ1qQhQutGwmw==
Date: Thu, 26 Mar 2026 17:15:27 +0000
From: Simon Horman <horms@kernel.org>
To: "Sven Eckelmann (Plasma Cloud)" <se@simonwunderlich.de>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Elad Yifee <eladwf@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: mtk_ppe: avoid NULL deref when gmac0
 is disabled
Message-ID: <20260326171527.GO111839@horms.kernel.org>
References: <20260324-wed-crash-gmac0-disabled-v1-1-3bc388aee565@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-wed-crash-gmac0-disabled-v1-1-3bc388aee565@simonwunderlich.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230505-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,simonwunderlich.de:email]
X-Rspamd-Queue-Id: 81D463390FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 09:36:01AM +0100, Sven Eckelmann (Plasma Cloud) wrote:
> If the gmac0 is disabled, the precheck for a valid ingress device will
> cause a NULL pointer deref and crash the system. This happens because
> eth->netdev[0] will be NULL but the code will directly try to access
> netdev_ops.
> 
> Instead of just checking for the first net_device, it must be checked if
> any of the mtk_eth net_devices is matching the netdev_ops of the ingress
> device.
> 
> Cc: stable@vger.kernel.org
> Fixes: 73cfd947dbdb ("net: ethernet: mtk_eth_soc: ppe: prevent ppe update for non-mtk devices")
> Signed-off-by: Sven Eckelmann (Plasma Cloud) <se@simonwunderlich.de>

Reviewed-by: Simon Horman <horms@kernel.org>


