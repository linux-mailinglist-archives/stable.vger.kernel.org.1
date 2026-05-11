Return-Path: <stable+bounces-245153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI14HvuOAWoVeQEAu9opvQ
	(envelope-from <stable+bounces-245153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:10:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A2E509DE0
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FE103032CE9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA46E3B9D9C;
	Mon, 11 May 2026 08:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="JQegSdcg"
X-Original-To: stable@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C41D3B0AC4;
	Mon, 11 May 2026 08:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486933; cv=none; b=EA53lGPpqBTLYFjwL0KkPznO/XsCByXis7uulqAJY37rZwuAOfIjvPSsNriKgmgfcULB1KR+OP60CK4HcoAkh/yvBDpHny5LvuSg6OUvNqWEWqnyIMfn8lzU+jk3CVzOsguoQ/fRuQXhc08i2nSD7GUXiAbcz3WxOQ3ts9CJStg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486933; c=relaxed/simple;
	bh=1OTai5XQcPKAzlvbKeBHtZYacoe9n2xrOOUoEPBnkU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8d6+YNvaO8HqE2072/B02zdRrw+dqcmCLHcc9AMVbdsw+h97ST6ZuKLpv1DkmmPjx/VI0Tg2PNLa/klGnlL09JyMQfIBIM4eNqYVA2+f7m5epkauYf3y/wWq+SGQFMT5Zg33zKHxb8WQx2AzcXGk0FTE7f2WRQe8Q5GGoom9A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=JQegSdcg; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af1d9600f5faa5cebd6c042e.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:f5fa:a5ce:bd6c:42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id DD3DA1C44DC;
	Mon, 11 May 2026 10:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778486922;
	bh=1OTai5XQcPKAzlvbKeBHtZYacoe9n2xrOOUoEPBnkU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JQegSdcga1IhnUnKF+Sv0cnGkICuLjLcmCuSMJmh4xwPkFn5VhnXZoSWXrwh2N9M2
	 uyx5DS0/WE3dwiplV2AhosUqcYpXDlUL2JH5hLfdX3mjmlXELx3aZSM/Cep+h3eHWX
	 O8ge+w7D6inMIPQA6kw11HXNPboYOl+L1HS5dBhw97z4kdiVigJBtULQbtWtoW2fbv
	 me1VdyiWaqgzdcPJVLa0n+fkwjujeJU0VVAVUDOQfxXIseSKRMvnt4IBBC/5+Jo3bO
	 OIMXmgWlqT838OAZnTKHIuDNCSWy374DaLY5ZFKdOfELssMIttv7FnnGkvQhAhaB1j
	 i71I0iKNJHDbg==
Date: Mon, 11 May 2026 10:08:40 +0200
From: Joerg Roedel <joro@8bytes.org>
To: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ziyuan Chen <zc@anthropic.com>, 
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] iommu/amd: Bounds-check devid in __rlookup_amd_iommu()
Message-ID: <cfhoa2kztzk5xklrbl5nnygenxfrro2smow5naj4xascc4ugt6@byfaegjgwjpr>
References: <20260421-amd-iommu-rlookup-bounds-v1-1-bbac5f0f48bd@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421-amd-iommu-rlookup-bounds-v1-1-bbac5f0f48bd@linux.dev>
X-Rspamd-Queue-Id: D8A2E509DE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[8bytes.org:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[8bytes.org: no valid DMARC record];
	TAGGED_FROM(0.00)[bounces-245153-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[8bytes.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joro@8bytes.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[8bytes.org:dkim,anthropic.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toxicpanda.com:email,linux.dev:email]
X-Rspamd-Action: no action

On Tue, Apr 21, 2026 at 07:26:13PM +0000, Jose Fernandez (Anthropic) wrote:
> Fixes: e874c666b15b ("iommu/amd: Change rlookup, irq_lookup, and alias to use kvalloc()")
> Cc: stable@vger.kernel.org
> Reported-by: Ziyuan Chen <zc@anthropic.com>
> Tested-by: Ziyuan Chen <zc@anthropic.com>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> Assisted-by: Claude:unspecified
> Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
> ---
>  drivers/iommu/amd/iommu.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied for -rc, thanks.

