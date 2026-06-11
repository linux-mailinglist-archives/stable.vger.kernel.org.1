Return-Path: <stable+bounces-262753-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ovX6NMfTKmq2xgMAu9opvQ
	(envelope-from <stable+bounces-262753-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:27:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A096730DA
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 17:27:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bKbwMp+G;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262753-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262753-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FEF03065E91
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58BA40F8ED;
	Thu, 11 Jun 2026 15:26:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7840FDB6;
	Thu, 11 Jun 2026 15:26:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191591; cv=none; b=fhXamVxPB1nGghTQysDFdV+V0dRePW5n+M9g5xk24mKK4fDE58GeA3Zk8ViIZsO0YhVjciWlhqnlHpYGTC0j7U1B58DIlb6Od7am2rI3uy0xWJU6uGw3hE0XX3qHv0IUotH3ffRu7F92OVN5qPfQA+AzdplHN0DNC09AtYBREC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191591; c=relaxed/simple;
	bh=6LXrZ1aYkYPQ86R1qjEGHQtqIpJ4sdxGxcM/MDc8B7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2tI6z5GyfijuIWBa+TXvkBliW5AvUhoHGpEB0fvbLzQGYO5u+so5AozkupvVgu0YJOxXVPv/5vDDKtVRmLx3ZFrLmRgiDs+SwfcGTkSB92wafogCM4hHd50zhjWYXAzZzZZkKtHdTf99MFMJlqsVWPSr67/jIbDEKrskps3r2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKbwMp+G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80E01F00898;
	Thu, 11 Jun 2026 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191590;
	bh=6LXrZ1aYkYPQ86R1qjEGHQtqIpJ4sdxGxcM/MDc8B7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKbwMp+GLD928jlx1bO+ICAuwTGOGQjGBZenytNiE3RTXfjNV4m2i/MolfJ9/Is3G
	 Fh73XwawgD+1MUlrJS2MxpCqJyLK8xgOWbFi2SObepgpXFS3V4G3gAOdMxefCdq+dt
	 f8FmIIbegf7ozBOfr/2zpy28MuoEFI0FclNc9KBfyPigKAdPnzJ1bmB1QY6JT0i4cB
	 YD6BGzJ9/ifn9nGhD98P/qSOCMdJeQvtHS5yOwhNEIDdtMn/3ODC1aiHH0Iq3UKDUm
	 OhHFzQIeKiAwKnp8Zqao30+gAXtHq+zXnT5t1cDyzu35uEg/zg1PSJ17/Epe60VBfT
	 GVtJY4zc+FBaA==
From: Sasha Levin <sashal@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Liebold <lieboldsimonpaul@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.12.y v2] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Thu, 11 Jun 2026 11:26:20 -0400
Message-ID: <20260611-stable-reply-0102@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611121127.3908131-1-simonlie@amazon.de>
References: <20260611121127.3908131-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262753-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lieboldsimonpaul@gmail.com,m:sashal@kernel.org,m:tpluszz77@gmail.com,m:fw@strlen.de,m:simonlie@amazon.de,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,kernel.org,google.com,redhat.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,strlen.de,amazon.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64A096730DA

On Thu, Jun 11, 2026 at 12:11:27PM +0000, Simon Liebold wrote:
> [ Upstream commit 1c428b03840094410c5fb6a5db30640486bbbfcb ]
>
> After async crypto completes, xfrm_input_resume() calls dev_put()
> immediately on re-entry before the skb reaches transport_finish.

Queued for 6.12, thanks.

--
Thanks,
Sasha

