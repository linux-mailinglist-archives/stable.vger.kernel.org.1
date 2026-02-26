Return-Path: <stable+bounces-219737-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE3AGF+Pn2kicwQAu9opvQ
	(envelope-from <stable+bounces-219737-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 01:10:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB50F19F4BC
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 01:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD4813023515
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 00:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01FA823DD;
	Thu, 26 Feb 2026 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT91BEcn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701D818C2C;
	Thu, 26 Feb 2026 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772064600; cv=none; b=WQ+sLkV+mF0yAImwZu1htSOrFoGezX6MBaANpvi36Ul0GtWQ7FtkwZyqwwurezDYB2TyXDh+io88+ChChIrlA7inqp/tvsyLvz91uyEHsdim1hzSeHs3c8eqhHwAuFJuTtyfZyrO6Uf7XPJ8VbjyMLaPjl78l3S8VY2FdMikpJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772064600; c=relaxed/simple;
	bh=UNC6gF7liqity0PwGtJb8bCXoVlqBKy00R2qY08OGhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MfYvwlYjHBAyeQYjY5IgYiXK4SrxDrXKw++N38YGMxNU9qgvbqWLTXmunKvSUagSCGIDxaExHqnGidLNxRuKh9wa+lwyNg186+uah0JhciJWS4YK4uA7+Bnm7nju0bD5czeg1FOyKwpdmyg5VXM9rCuTEWrm1w68EHpt96oV7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT91BEcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ADFC116D0;
	Thu, 26 Feb 2026 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772064600;
	bh=UNC6gF7liqity0PwGtJb8bCXoVlqBKy00R2qY08OGhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NT91BEcnyoODiJGf4W44SGpTL2sPxRaUFcH6E3t55dq07XA9OcMzmPZtAR/a897uE
	 1aJEzTvlLKsyATQj7KY4/k9kE/v19HLUVAWDEseIhPycTsh2EyBR/tDKwOzgNsapbn
	 Jvmwd7jG4lTHDgZqJfennbAF9o0xKyYCVqkQtHp1fSnU2Uo31ew1apwwzLdPJbEfXf
	 b+yxWGIDYOcjit2mVTp5zQPte5QrJSyN2ffYjYKA1v4PMEKMxorguayI2JNU0NWmc3
	 JYdZLBAiMn0FQsjVrlZoWrz5ysoMKQnq+PrIS+yRsbbsP/3ar4yLGXHNmEZdNoIP3f
	 Usn+ucsJ3xNvA==
Date: Wed, 25 Feb 2026 16:09:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
 <horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>, <v-singh1@ti.com>,
 <vadim.fedorenko@linux.dev>, <matthias.schiffer@ew.tq-group.com>,
 <vigneshr@ti.com>, <m-malladi@ti.com>, <jacob.e.keller@intel.com>,
 <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <srk@ti.com>
Subject: Re: [PATCH net 2/3] net: ethernet: ti: icssg_common: set
 irq_disabled after disabling TX IRQ
Message-ID: <20260225160958.64bbc4c5@kernel.org>
In-Reply-To: <be80263f-667c-4330-bc24-5078fe07b994@ti.com>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
	<20260220041431.372610-3-s-vadapalli@ti.com>
	<20260223184840.06069afa@kernel.org>
	<57e05b57556e94ed666acd8b4c542efc28e7408b.camel@ti.com>
	<20260224154953.63b558c1@kernel.org>
	<be80263f-667c-4330-bc24-5078fe07b994@ti.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-219737-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB50F19F4BC
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 17:01:31 +0530 Siddharth Vadapalli wrote:
> 	net_rx_action
> 		__napi_poll
> 			NAPI TX Handler
> 
> It does seem strange that the 'net_rx_action' leads to the NAPI TX Handler.

For historic reason rx_action runs all NAPI, it's fine.

> However, it is exactly this path that causes the warning, and it is due to
> this that we could end up in the following situation:
> 
>                  CPU0                             CPU1
>     -----------------------------      -----------------------------
> 1. TX HARD IRQ Handler entered         NAPI TX Handler is running
> 2. irq_disabled is set to true         Sees irq_disabled being true
> 3. Calls disable_irq_nosync()          Calls enable_irq()
> 4. Enters disable_irq_nosync()         [WARNING: Unbalanced enable for IRQ]

Right, but for Tx NAPI is only scheduled from the IRQ so this is not
possible. For Rx yes, AFAICT there are paths in the driver which
schedule the Rx NAPI (AF_XDP?). But Tx NAPI seemed to have only
been scheduled by IRQ. And if that's the case the NAPI can't run
until CPU0's IRQ handler calls napi_schedule().

