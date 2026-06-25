Return-Path: <stable+bounces-268246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zf0QHpuRPGrepQgAu9opvQ
	(envelope-from <stable+bounces-268246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 04:25:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3902D6C2605
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 04:25:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VhzAUM+y;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268246-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268246-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A01DB300A8C4
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 02:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5A13644A4;
	Thu, 25 Jun 2026 02:25:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A5419C54E;
	Thu, 25 Jun 2026 02:25:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782354316; cv=none; b=BKMcCR5Vlfu4UYQUPT3wPCeLJqh34MH9m7NwD3TjR7W63ZxrQxRzReVnpq/CMNx7lgp+RVVyNqvgMGv5urWOkCQJP3u1IIq59rJIQsHJeC60Rfj9BEvT2qFeoAmwZkneGty4tN2IpJtUVVfwjfTM7Qh6JpBz2oAZjONH2dDTsrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782354316; c=relaxed/simple;
	bh=fNNJnh667D4SGrad3vyQ7ShgISCq7vKlq7l3BQhOo8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beQFOR7XjReEGKPq0sTnp9xC4h2jR8+5B31993E6e7z781bMV1dDE20rKLnXq42xhmYnhrEax4ir1jPwf4YKzuRAwpPrWTbXgH5G5tzER71fBkK0TgPrAtIt9lJlNjoS1PzDMs06csCouMhmfLqLajCEuYvahXMNunJo0X0iG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhzAUM+y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449C01F000E9;
	Thu, 25 Jun 2026 02:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782354314;
	bh=tGSgxbQOZ/A/Rx2qFngn3z7HrOY74eUjampP2chvJqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VhzAUM+yQqbkWsU/q0sNWkuc3rOVIrO3s4DOLtGKCfMjSFNHUuJMRK3z2JRDDhjs1
	 GSdnuNMzSMXJs+FT+JPvW/No/ZAL8Si7hlOxBs5nJY/PcWLWzadmrKSG9jSD8fQUOw
	 gnbrZaK2n1SVU0BrAKtcJJy1xBHgKM13TqvHKPsGeNNgd9oj0M0q8I+LUzby5XYkNc
	 RvTLEXMy0S4uT1yDzurCf95S0hA/dT6CkmEC/HQFedQmORGCXD9/tFNInmsjJnOmJP
	 /zmrzM90mb0a+1LY5aRf4m8JDYMzaWfO7iT3ejRFFpSlu9eH+WvGBGfbhhnsx5Ogvv
	 Yykm/b407/77A==
Date: Wed, 24 Jun 2026 19:25:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Amerigo Wang <amwang@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vlad.wing@gmail.com,
 asantostc@gmail.com, kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net] netpoll: fix a use-after-free on shutdown path
Message-ID: <20260624192513.33023e54@kernel.org>
In-Reply-To: <20260622-netpoll_rcu_fix-v1-1-15c3285e92e6@debian.org>
References: <20260622-netpoll_rcu_fix-v1-1-15c3285e92e6@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268246-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:amwang@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:vlad.wing@gmail.com,m:asantostc@gmail.com,m:kernel-team@meta.com,m:stable@vger.kernel.org,m:vladwing@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,gmail.com,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3902D6C2605

On Mon, 22 Jun 2026 08:01:23 -0700 Breno Leitao wrote:
> +		 * synchronize_net() does not protect the worker
> +		 * (queue_process() is not an RCU reader). It fences the
> +		 * senders -- the real RCU readers -- so they cannot re-arm
> +		 * tx_work after the np->dev->npinfo was set to NULL.
> +		 */
> +		synchronize_net();
> +		cancel_delayed_work_sync(&npinfo->tx_work);

Maybe we can avoid the sync_net and the comment by using
disable_delayed_work_sync() ?

