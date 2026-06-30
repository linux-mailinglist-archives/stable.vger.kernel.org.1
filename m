Return-Path: <stable+bounces-269922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f6isGayLQ2oNbAoAu9opvQ
	(envelope-from <stable+bounces-269922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:26:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B66E221C
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 11:26:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pTSAv86M;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269922-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269922-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF34E305043B
	for <lists+stable@lfdr.de>; Tue, 30 Jun 2026 09:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B9637F8A7;
	Tue, 30 Jun 2026 09:20:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDF6149C7B;
	Tue, 30 Jun 2026 09:20:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782811202; cv=none; b=GGXMbJA4px3RlnC90hBc85wv/cnixmpQqVpJdMnEI14bOlDVgQvl0ju/EjmTVDyDQ/daJl1glf2JjlkMqlhuOx8+cfek71qYW5l4VVifN/+dTRAv1QJx3+yGIcsXLKSWa4mskVv6AJ6RSMQQFDr7MhLMS67Z828EGjwwZh6UYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782811202; c=relaxed/simple;
	bh=oyguhuR6LbAqWw4xdToVEIjVc0kEnHRMdTIG+IIQ234=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lleev52wL0FjFyAqg0y6kBr+Y8A3TD52TC6qc4SNuGIL7OFaNJE8PFF7O437l3ruo85SjZ2oDJKDan5cl306jtpgAg6j4X3WRpluQYt73Kb7mh3/Af8dbxR7lFIoIFICFvmJp47v2Pf/4IGmhkEzLzymG4fYL7jkCLrRP27FNGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pTSAv86M; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393B21F000E9;
	Tue, 30 Jun 2026 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782811200;
	bh=P8y26ICau+Zq5nbRu9rFDpHLmiN9lzN8YryMUBW4Z8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pTSAv86MxiMhodCWxanIEFDXajdaw9kKMMAvHEU73DCrhG7+mnBvVResPe4mgebXr
	 c7XNC3u+9iar1gPM5/MH3SBlueeV0XoKt+oCP+UTr77JX4q+2ZxJso/SzltJVCllyn
	 LvwBEEMAYnTzsp0hYbxFfbg8SC4LOJWCNHQ87sMg=
Date: Tue, 30 Jun 2026 11:19:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: thierry.reding@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	jonathanh@nvidia.com, WenTao Liang <vulab@iscas.ac.cn>,
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/tegra: fix host1x_bo_pin leak in tegra_dc_pin
 error path
Message-ID: <2026063044-multiple-lion-95fe@gregkh>
References: <20260628150228.47948-1-vulab@iscas.ac.cn>
 <6iIwnfniQ6-oslWmeLae0A@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6iIwnfniQ6-oslWmeLae0A@nvidia.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269922-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ffwll.ch,nvidia.com,iscas.ac.cn,lists.freedesktop.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mperttunen@nvidia.com,m:thierry.reding@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:jonathanh@nvidia.com,m:vulab@iscas.ac.cn,m:dri-devel@lists.freedesktop.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:from_mime,gregkh:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B65B66E221C

On Mon, Jun 29, 2026 at 02:59:05PM +0900, Mikko Perttunen wrote:
> On Monday, June 29, 2026 12:02 AM WenTao Liang wrote:
> > When map->chunks > 1 triggers an error, the function jumps to unpin
> > before storing the current map in state->map[i]. The unpin loop only
> > cleans up previously pinned planes (indices 0 through i-1), so the
> > current mapping returned by host1x_bo_pin is never released via
> > host1x_bo_unpin.
> > 
> > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> > Fixes: c6aeaf56f468 ("drm/tegra: Implement correct DMA-BUF semantics")
> 
> This patch changes the code around the line, but doesn't look like it's
> the origin of the bug. Rather, I think commit
> 
>   49f821919bb9d45de7f1cde6072de01d36235b5d
> 
> is the origin.
> 
> Aside from that,
> 
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

I did not suggest this, so please do not accept this patch.

