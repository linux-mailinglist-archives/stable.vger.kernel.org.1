Return-Path: <stable+bounces-268200-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AGEbC7QPPGqkjQgAu9opvQ
	(envelope-from <stable+bounces-268200-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 19:11:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 500F86C041C
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 19:11:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DZ3u4y1E;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268200-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268200-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8E78304BDAE
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 17:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9143CF1F5;
	Wed, 24 Jun 2026 17:09:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844136A372;
	Wed, 24 Jun 2026 17:09:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320978; cv=none; b=Fzb5LHAv5rdNFqusjSUlsEAngVs+AaQN2RcmQuc4hD3WcC1+xMf0nfkKhURPOuq4JOjF7xb2s1amQ65bBa3NU8TLRkR/S2feCpYTt4GNGE1TvRE2oAYUZpBR09PoTA4wJgbeSFK4EJ1ptfk5FpiSvRBiAnmfi/30AeczY9cmfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320978; c=relaxed/simple;
	bh=DYh1LUenaTDhEk/UmsDiMVbQZjBgGC/XJT4/INLu6Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijcgDzJhuHoHg/w+i0Mreh3hqK8hPFBqQowuODa4TSBghI6gZeDRn+9FpU3nHzSclfDpvLQWphvifE5ngvdIlZtI18jvM+KT+7obvQkM2sva9nE2feNkw9OUXICNTzl4Ix8d83kTTEvlx81mp3SLwHK7XT40pIG4rYE1/c76B0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ3u4y1E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926B31F00A3A;
	Wed, 24 Jun 2026 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782320975;
	bh=TLvkpf4KTJQFN28eqRP3QnEGWaIf2KNDDqo+8IaoD8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DZ3u4y1EuddVkVxZl9TuaKdGmj2sHTwSD7sWEekXqFsWZ+TVrESUWDSr4IqbDlWqG
	 P6TPQnntSk01MslZEtgeXo7N+5uklvsubn6N0PFOkfroCSQzqtWd5I/+khr5W6dm/6
	 qq6b7TCY2pev6ZaJYIsusdPam+L0AGzJnVZxnGUguvi5g9pEQAo92Lr2ZEZLAW1x+Q
	 x8cnu3inZPwCRmH87/Xqc4VOgEG5fs5xdxdUptdgXC2KCCNS8PqrZIeq2k202okG/l
	 95uZNKHpHLQN0Nd/DlD67QmeqUqG3yf8qgVd1Q/O3I+4JBZkOKKrhLEQk8FFilJGQE
	 oartZAyBYq5Ag==
Date: Wed, 24 Jun 2026 18:09:30 +0100
From: Simon Horman <horms@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: Free BPID bitmap on setup failure
Message-ID: <20260624170930.GB1131256@horms.kernel.org>
References: <20260623114316.2182271-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623114316.2182271-1-haoxiang_li2024@163.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-268200-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haoxiang_li2024@163.com,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 500F86C041C

On Tue, Jun 23, 2026 at 07:43:16PM +0800, Haoxiang Li wrote:
> nix_setup_bpids() allocates bp->bpids with rvu_alloc_bitmap(), which uses
> a plain kcalloc(). If any of the following devm_kcalloc() allocations for
> the BPID mapping arrays fails, the function returns without freeing the
> bitmap. Free the BPID bitmap before returning from those error paths.
> 
> Fixes: d6212d2e41a0 ("octeontx2-af: Create BPIDs free pool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Simon Horman <horms@kernel.org>

I am wondering if you did a pass for any other similar problems
with users of rvu_alloc_bitmap.

