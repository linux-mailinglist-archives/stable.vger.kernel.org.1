Return-Path: <stable+bounces-217852-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLbtK6URnWkGMwQAu9opvQ
	(envelope-from <stable+bounces-217852-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 03:49:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A191811FA
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 03:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B18E305E9C4
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 02:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33153267B05;
	Tue, 24 Feb 2026 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0r7REpI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E601E5207;
	Tue, 24 Feb 2026 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771901323; cv=none; b=jzBAxZsKoctdbVJhppjC89aYapZbMkQSfujpzDxpbU/N0DHAXZJdrTBrS/uUmCTmQ5rrUiM7lK2+4Uo+4YswjyfbrVpGAaltuSgjwSGDMUT1tkjc703ZJDgPPuDb03eZfowxmhwQZzdpY30OZmE+R8uAKnSBdqTFDLiKKuGMXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771901323; c=relaxed/simple;
	bh=7PJlfl1E8kHqQjY0Dl7T+Y3HgXwyKOBil5hIKHkainE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnSM3XSusFPA4uw+4E29hHhTwqvs9Ngpr9y3aAqrB2/mYDAFhWD5OsXZeKq/WUcJ20I5Eu7goATjT0+ha+8BufnxIiTCkA3Y+ff+YOS+kNThEUgjkrWCBzUfe0MdmHqlWHLXT5fhfDrcgHPVIDxlDR9fCPy9+Qo0MdNaPN8Lsyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0r7REpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43363C116D0;
	Tue, 24 Feb 2026 02:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771901322;
	bh=7PJlfl1E8kHqQjY0Dl7T+Y3HgXwyKOBil5hIKHkainE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c0r7REpI/o3XSVvBhMUsoa8mVeQQy/N1mZa0h9vor5J2fLnWeZgp1ByFLy0U3jhVp
	 05sQnXKohDzDQRJBAhzOdM/8yhm25w2TSC8P/Bq2M3lVefiF/zJrFrCL89RaKJoYz2
	 MtcrAFUasbYxLh1iT+sUECSU91JmdsIOIFbHSkeGaArrd+kdOYUcLkwV6bNnyJJQTs
	 Yu/TN2dAWBKfdY+aD8QKPApeuaXJogjOKMWlWD7W404Y2kkgfUTTaP71grxOdP8S03
	 KXRDOoUpCZqILopGpBexu9mGPP3QL5JwMyBs/CtegvM2+/rRZZukOCWY9z1nIwg/Lv
	 h4Vo7Rr0azmag==
Date: Mon, 23 Feb 2026 18:48:40 -0800
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
Message-ID: <20260223184840.06069afa@kernel.org>
In-Reply-To: <20260220041431.372610-3-s-vadapalli@ti.com>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
	<20260220041431.372610-3-s-vadapalli@ti.com>
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
	TAGGED_FROM(0.00)[bounces-217852-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18A191811FA
X-Rspamd-Action: no action

On Fri, 20 Feb 2026 09:41:58 +0530 Siddharth Vadapalli wrote:
> The 'irq_disabled' variable indicates the current state of the TX IRQ and
> is used by the TX NAPI handler to determine whether the IRQ should be
> enabled.
> 
> Currently, 'irq_disabled' is set before actually disabling the IRQ by
> invoking disable_irq_nosync(). In an SMP environment, this leads to a race
> condition wherein the processor taking the interrupt sets 'irq_disabled'
> while another processor executing a previous instance of the TX NAPI
> handler sees 'irq_disabled' set and invokes enable_irq() before the TX IRQ
> is actually disabled by disable_irq_nosync(). This results in the following
> warning:
> 	Unbalanced enable for IRQ ...

AFAICT the flow on the Tx bug is not buggy, owner ship of the IRQ
vector passes handler -> NAPI -> timer. I don't see how those can
race.
-- 
pw-bot: cr

