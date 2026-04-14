Return-Path: <stable+bounces-237788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJJUMa0b3mmFnAkAu9opvQ
	(envelope-from <stable+bounces-237788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:49:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 442313F8F26
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AAEC3017F92
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33ED3D646E;
	Tue, 14 Apr 2026 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuUiwer5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122A635A952;
	Tue, 14 Apr 2026 10:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163403; cv=none; b=BegQUNRad11dDOJhQOtyxOxMY1w8ejimKRjh26Dmdpd7UJxmHM4r8N1b/sYQl766g5MGWirBeZcL9GF+gf9F7bQxIgRsmX9anKNCb2pE3hXC1T3mSzMzwlXpSaxVplr2Lweyx71nPQKv5MFj7ElIe+wRKkDGlv5HAMS7+NAyc/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163403; c=relaxed/simple;
	bh=aHBw8r9UG38xqO3orablJh4axD69BNCPvGseEiOj8Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lM4jifpPq8/3KrSM6PPr3r5JvDF8cN6pCW1eWfUvdNwJBSYtu1nZM+qnK8HvEk8SAc+3IKsaeElA55uPRq7NMy8MxDQwPyoRm/P/9p8HGLa78gqenFSsFMPoTH2VSzOXERclECzCJPdCvz8zgzKZvvHMva9v/u0FQ7CrMmEyXJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuUiwer5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28C4C19425;
	Tue, 14 Apr 2026 10:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776163402;
	bh=aHBw8r9UG38xqO3orablJh4axD69BNCPvGseEiOj8Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuUiwer5xRnY8xGT8HCUG6BFIdVkr1E3uadTG+y5mHHWjWch69XqmylqHes6y2a0+
	 tdDiiXiA0lNUwQMWBvFnzdrwGG7of/UQp+LkPJJJ0Z3I47JimhJJuCIVhrq/G6Iun0
	 7Z5k5tqGWmLgCPC0bahyMzTcKU5KNKulXXTrcaNkOBy+pTUb0YADO37WYcQRa/sBfP
	 d1PYLOg+QR0xybI4uM6YHt3PKLQ+4MqL51CWgiDcF9CmpX+IzDntzgjsn1VBaSh+ID
	 IfyZ0ZB3R3n9/sxatd0q7ImUksXAXZXbKFVoNRDHGBK+6/7AaEsktEVujsA7BVkOeq
	 Uco7+LuGs8yKA==
Date: Tue, 14 Apr 2026 12:43:17 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, Alistair Francis <alistair.francis@wdc.com>, 
	Hans Holmberg <hans.holmberg@wdc.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] xfs: fix memory leak on error in xfs_alloc_zone_info()
Message-ID: <ad4Z-yHwPs9ZDuI7@nidhogg.toxiclabs.cc>
References: <20260414034149.1116281-3-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414034149.1116281-3-wilfred.opensource@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237788-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nidhogg.toxiclabs.cc:mid]
X-Rspamd-Queue-Id: 442313F8F26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 01:41:51PM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> Currently, the 0th index of the zi_used_bucket_bitmap array is not freed on
> error due to the pre-decrement then evaluate semantic of this while loop used
> in xfs_alloc_zone_info(). Fix it by allowing for the i == 0 case to be covered.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Fixes: 080d01c41d44 ("xfs: implement zoned garbage collection")
> Cc: stable@vger.kernel.org

Code looks good.

After fixing Damien's suggestions, feel free to add:
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> ---
>  fs/xfs/xfs_zone_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
> index a851b98143c0..c64f9ab743a6 100644
> --- a/fs/xfs/xfs_zone_alloc.c
> +++ b/fs/xfs/xfs_zone_alloc.c
> @@ -1217,7 +1217,7 @@ xfs_alloc_zone_info(
>  	return zi;
>  
>  out_free_bitmaps:
> -	while (--i > 0)
> +	while (--i >= 0)
>  		kvfree(zi->zi_used_bucket_bitmap[i]);
>  	kfree(zi);
>  	return NULL;
> -- 
> 2.53.0
> 
> 

