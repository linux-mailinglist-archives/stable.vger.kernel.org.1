Return-Path: <stable+bounces-230318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IppGFzFw2kVuAQAu9opvQ
	(envelope-from <stable+bounces-230318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:22:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01737323D31
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 12:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86F1431559DC
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9084A3CBE75;
	Wed, 25 Mar 2026 11:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XdE1npEi"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D463CBE62;
	Wed, 25 Mar 2026 11:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437183; cv=none; b=SDzHktVSPuO3k9LKxJ9IUn3Dg7ZeTnCQ9tqeuONNgnHFh9AcfURLZf++kFWN+c/AHqrQ8YAiW3wAVqsfnj0ZWqNoX2RjIIQMnTVAZBJz/ojVWNuffmxAaSajveqNIJIOkd/Bdjer8iH3/V+1ee5pswxrT0SYDuqYFbUZTDikGZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437183; c=relaxed/simple;
	bh=kCtS42tkLon9lDgRdKQo5dnjH0Y4km9Kc5WJOtpCfb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtMJo41cTgGEPbYuOeRxo7K6jqYJ7hs5gVHQqu3ebfB9sftHvBXzGZ9ghkjmY9mt4+tJONCJEWpj52TOrM2AL9SaeOgl6EPgPfhgMpT3BVRZWRwp1OlPlwzCP4vInMiT/VC78lsaYF3nXUuiDtTKxy8t5N6G74Qxo0Z6cqbPVcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XdE1npEi; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i9+zBdvf0DkjXoBGF/RhYMecX9tHanlgS2GoOCgt2l0=; b=XdE1npEi+kb38Ism3Ddn/oo4sQ
	oDo4ggORCEI2E/QMnWvHwlsKBa/sWWCgtBuPLOHLdXNJhldmMX1tTSN3TWOVfCYK+d0iOneByN/U3
	OkEZ3vntNIWgI5k9htMQvgBQaHdMeNwx/MAnXmRxR9TDYWldYnE6eY4nACYBCrLVfswcTyKZtocZW
	WePL4+zWloRMngaQywbBmWLqJxP/Z2d7G/VwYo5aHrN0RYcxCukY3S/sV7HR8vdbUCkf2kLJguTAG
	BPjK+dVU/Wq/GttAR24EZ+rQN2sHMbOQafkUhdUlLzUIjJJ7zBvX19S85vYwaBAkHK07TyM9lJelL
	dLUSfXTw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w5MAL-0092Be-7q; Wed, 25 Mar 2026 11:12:48 +0000
Date: Wed, 25 Mar 2026 04:12:42 -0700
From: Breno Leitao <leitao@debian.org>
To: Jianqiang kang <jianqkang@sina.cn>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com, treding@nvidia.com, 
	broonie@kernel.org, va@nvidia.com, linux-tegra@vger.kernel.org, 
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 6.12.y] spi: tegra210-quad: Protect curr_xfer check in
 IRQ handler
Message-ID: <acPDE9gBWneJWMn0@gmail.com>
References: <20260324060832.724228-1-jianqkang@sina.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324060832.724228-1-jianqkang@sina.cn>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[debian.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[sina.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230318-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,vger.kernel.org,lists.linux.dev,gmail.com,nvidia.com,kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sina.cn:email,nvidia.com:email]
X-Rspamd-Queue-Id: 01737323D31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 02:08:32PM +0800, Jianqiang kang wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> [ Upstream commit edf9088b6e1d6d88982db7eb5e736a0e4fbcc09e ]
> 
> Now that all other accesses to curr_xfer are done under the lock,
> protect the curr_xfer NULL check in tegra_qspi_isr_thread() with the
> spinlock. Without this protection, the following race can occur:
> 
>   CPU0 (ISR thread)              CPU1 (timeout path)
>   ----------------               -------------------
>   if (!tqspi->curr_xfer)
>     // sees non-NULL
>                                  spin_lock()
>                                  tqspi->curr_xfer = NULL
>                                  spin_unlock()
>   handle_*_xfer()
>     spin_lock()
>     t = tqspi->curr_xfer  // NULL!
>     ... t->len ...        // NULL dereference!
> 
> With this patch, all curr_xfer accesses are now properly synchronized.
> 
> Although all accesses to curr_xfer are done under the lock, in
> tegra_qspi_isr_thread() it checks for NULL, releases the lock and
> reacquires it later in handle_cpu_based_xfer()/handle_dma_based_xfer().
> There is a potential for an update in between, which could cause a NULL
> pointer dereference.
> 
> To handle this, add a NULL check inside the handlers after acquiring
> the lock. This ensures that if the timeout path has already cleared
> curr_xfer, the handler will safely return without dereferencing the
> NULL pointer.
> 
> Fixes: b4e002d8a7ce ("spi: tegra210-quad: Fix timeout handling")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Link: https://patch.msgid.link/20260126-tegra_xfer-v2-6-6d2115e4f387@debian.org
> Signed-off-by: Mark Brown <broonie@kernel.org>
> [ Minor conflict resolved. ]
> Signed-off-by: Jianqiang kang <jianqkang@sina.cn>

Acked-by: Breno Leitao <leitao@debian.org>

