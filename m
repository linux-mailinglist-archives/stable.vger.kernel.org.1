Return-Path: <stable+bounces-241969-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAVCD0ao8mlwtQEAu9opvQ
	(envelope-from <stable+bounces-241969-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:54:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F13549BDC5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E9E8302A51D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 00:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1C223DFB;
	Thu, 30 Apr 2026 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaK1WErH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD92147F9;
	Thu, 30 Apr 2026 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777510464; cv=none; b=C2J8dqbCOEYruyFz08kawHTkGeQcn9Ub+16kndF7oBc0qxMXxBgJSLxw53WahZHE1+L11PeDOIsp1Q/x9wRqo412LsqOlLRGEfmsPQN6f+mDbTVjhkBqhfKykQQ2ge808J59tDHO+Yci0bS1L/FUapQyksK7VEYjzDigeX1544w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777510464; c=relaxed/simple;
	bh=1jVVcjmjWGlmRxZMpNv0KbezYUh3E1fqOB92ATzcCuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQeC8BudgBQde322WtBU0JTMAoeePb/MVcxTg5Cv9t09JlvFGKG84U+Ys1CSwHtKnDusPY3eUkIBalB95UHvuC5zZx8aW7Dmuf7amACBSTDXaqlO8QslEH10GmY6GKEd9YdA+7HMDXfhbvP0dRhAal0Bsi7QXxaMsskQ10wpqos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaK1WErH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5E0C19425;
	Thu, 30 Apr 2026 00:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777510463;
	bh=1jVVcjmjWGlmRxZMpNv0KbezYUh3E1fqOB92ATzcCuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eaK1WErHK43V6oBQjqS2JgcQyBt63tXROg/QKwzWftbVguHr2RkZYQGPnZz0+oHuF
	 /PwDeQr7dXPHqeZw3+nEvZqcT3tqKZV9bQH0y5/VZq7TNX63Vmk03Wy7yLcyG07RGD
	 P7Y1sOoAbZ/SU8pcqbJKhWm31D37bfBCEfMnzYpMNRStGH5WDcPnrO1dJ4OwXiR1af
	 oHnWDUfVcu5ZS6aWpWLy9QdMmjycPjWY6uo6E2lGaUvTZMl3J+dARharO/1rbsPE0p
	 M/SSpJi1iZnnbBxWvxnhX0FJIXAbca9HFWab5qmX4XufNfHgEOsTNQfY2T/4pktzVm
	 MNSau0XUrKsAg==
Date: Wed, 29 Apr 2026 17:54:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, Yibo Dong
 <dong100@mucse.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v2] net: ethernet: rnpgbe: mark nonfunctional incomplete
 driver as BROKEN
Message-ID: <20260429175421.014bb28f@kernel.org>
In-Reply-To: <20260428030826.47509-1-enelsonmoore@gmail.com>
References: <20260428030826.47509-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8F13549BDC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241969-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, 27 Apr 2026 20:08:25 -0700 Ethan Nelson-Moore wrote:
> The rnpgbe driver as currently shipped in the kernel is incomplete and
> has no useful functionality. It will bind to a PCI device and create a
> network device, but that device does not function (its .ndo_start_xmit
> callback, rnpgbe_xmit_frame, just drops all packets). This situation
> means that users could enable this driver and have it load and attach
> to their device but not transfer any data. To remove the potential for
> user confusion, mark the driver as broken until it is completed and
> explain why this was done.

I'm having second thoughts about this. I'm worried users will come to
expect that drivers are marked as BROKEN until such time that they
can be considered a sufficiently complete replacement for an OOT /
vendor driver. This will be highly subjective.

