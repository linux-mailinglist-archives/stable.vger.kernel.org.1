Return-Path: <stable+bounces-225322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDFPBbAftGnahgAAu9opvQ
	(envelope-from <stable+bounces-225322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:31:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C57285048
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A55730AAE44
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631F39DBD8;
	Fri, 13 Mar 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih9a+euY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B64394789;
	Fri, 13 Mar 2026 14:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411972; cv=none; b=CUjGYGWd14ffycHgoWGWiYA/YZrBp4zff1IgNYNKt7ywEopQpLCBOa4QTuIi5gJd5B1UN1TqGpkmijvJ59KTKbeg/C/UyPUajCsUSwQyOyFy6h4mn6lllbnVmGzcuPZXgj242h2Nfmp7yahJmE84pRsmn4IaiV2pzEz2si3ZIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411972; c=relaxed/simple;
	bh=csugw47KFm4XbA/rI/DUl+toRdNAX0DSryGfDJl9TE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsXHs/iMwVC5Hbe2dSVqcSbyCiEeqPAhu4JasrH2iGZeOjj/SpSPIqcL5Im5q+FwC8Y+EEoXGGBReC25y9Rs4Tw5FbJVeOrk/qj6HU/YTb4wOIOp2OU9UrMog7t1tg6vEBma7NPDryU8byxcRTYWOgr1jKJfiH1+DEXHv1qXCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih9a+euY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030CBC19421;
	Fri, 13 Mar 2026 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773411972;
	bh=csugw47KFm4XbA/rI/DUl+toRdNAX0DSryGfDJl9TE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ih9a+euYd4XmHmgFZEcLEzk5USDClH/fJd1FOwYZhxdBt4Ukp0N9QBP4Gby72qchq
	 K5qt1hOBcPrErwNMOMtnvDSBq6UdA1M0w2oT1QsG0+mO1GjZ+LqP1u+Se0h8wb7M/8
	 W9MYWjga3XWcw2Ik39/Eo+S9p7BNMkkL3N3KnJEvlnnPU7vW7x9rOH63YVshzLrZfJ
	 GkhuPWEuBUA6tZ1zZ+Xg88FljZplw8muNEBQFre5s/MJ5C4GGepcObABeu5treW1NJ
	 ncBTPXuj3O600XkSKzWA12ShtZy7iZmm1CvSPXq/4bHqOLT/KnivNq02MmIpGgx4Nv
	 ZZLYuitry0Lzg==
Date: Fri, 13 Mar 2026 14:26:07 +0000
From: Simon Horman <horms@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	chopps@labn.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] xfrm: iptfs: only publish mode_data after clone
 setup
Message-ID: <20260313142607.GC461701@kernel.org>
References: <20260312113843.2883169-1-p@1g4.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312113843.2883169-1-p@1g4.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-225322-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1g4.org:email]
X-Rspamd-Queue-Id: A5C57285048
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:39:09AM +0000, Paul Moses wrote:
> iptfs_clone_state() stores x->mode_data before allocating the reorder
> window. If that allocation fails, the code frees the cloned state and
> returns -ENOMEM, leaving x->mode_data pointing at freed memory.
> 
> The xfrm clone unwind later runs destroy_state() through x->mode_data,
> so the failed clone path tears down IPTFS state that clone_state()
> already freed.
> 
> Keep the cloned IPTFS state private until all allocations succeed so
> failed clones leave x->mode_data unset. The destroy path already
> handles a NULL mode_data pointer.
> 
> Fixes: 6be02e3e4f37 ("xfrm: iptfs: handle reordering of received packets")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---
> Changes in v2:
> - Fix Fixes tag to point to 6be02e3e4f37

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

