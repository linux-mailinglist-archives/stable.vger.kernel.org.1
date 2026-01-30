Return-Path: <stable+bounces-212826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJZGAKMNfGkEKQIAu9opvQ
	(envelope-from <stable+bounces-212826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 02:47:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0506B6425
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 02:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E845730071E4
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 01:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FACF2857F0;
	Fri, 30 Jan 2026 01:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwgkMPgQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E72206A7;
	Fri, 30 Jan 2026 01:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769737633; cv=none; b=KBUsC0YytFqwuETY1Dr047siBJa9tNWHlmnRPjTCO9+2paqZex7kS7snGdccUZejNarTTmnvV4jo46C/iSeS5HhC7cyw2hwYFtgrApLr9DMoKvHNlA+82OfwYuUfmcMAS556esZW6MOUedBmjD5jo0tfF4AyX0SJRVEQIfRMD1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769737633; c=relaxed/simple;
	bh=uTSb/3Bkr4NURu+3jD3jtSKpyQ/UkCRXOV9UB1ooxao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7pU8qgwRYLQNO7foqKudBpGBZnZ/Aph3Ol0nMnXl5HTE9LqKjQhqWUuKApqmO7m1dA6YxgKYWXhw+nMlC1fNvi1nuIfM+RngJ49u8XKJZPFj2r/nzPR9Scn+ZQDo6SlFCsdMmv7gsGQkVMf6gFasaVZ+IYVe/JRJekp2R/6q4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwgkMPgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C906C4CEF7;
	Fri, 30 Jan 2026 01:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769737632;
	bh=uTSb/3Bkr4NURu+3jD3jtSKpyQ/UkCRXOV9UB1ooxao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZwgkMPgQt7vephvdERWPsEINhAslVuiyMHogeeVGrvSJmc5466bzjhdLBrgMg5IIZ
	 TqstFv4B+nyUSVrgWW7/FoisVLkFZ31hpWljhjzPIBH5UMbhObNR7E35Mbcp3Qkm8p
	 ugTb0/uITFunWHMIeRIUr16JM0Ys0+6rJkK/uPt2nxoJ0dEb3iLd2LyDchf2QmimJT
	 VPO7hTYYz4gnnbfDltJ/ORb3r/zhxbPNgufswZhl/dnTrSsTumnpU5GWLik+V81OTH
	 3N4U6S779MiELOlRApjmrQLrGo7qduNvRErsi9d2cBmZ1l6jfrhL4I0IiPMI3RdXYp
	 KLWs0Fp7LEg+w==
Date: Thu, 29 Jan 2026 17:47:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tomas Hlavacek <tmshlvck@gmail.com>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, dlan@kernel.org, wangruikang@iscas.ac.cn,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] net: spacemit: k1-emac: fix jumbo frame support
Message-ID: <20260129174711.2965f189@kernel.org>
In-Reply-To: <20260129042908.410326-1-tmshlvck@gmail.com>
References: <20260129042908.410326-1-tmshlvck@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-212826-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0506B6425
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 05:29:08 +0100 Tomas Hlavacek wrote:
> Subject: [PATCH v3] net: spacemit: k1-emac: fix jumbo frame support

Could you repost this with subject:

[PATCH net v3] net: spacemit: k1-emac: fix jumbo frame support

The "net" after "PATCH" is crucial, since the patch conflicts with
net-next. I needs to be ingested specifically for net in the CI.
-- 
pw-bot: cr

