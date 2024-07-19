Return-Path: <stable+bounces-60585-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72359371FA
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 03:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE031C20DD3
	for <lists+stable@lfdr.de>; Fri, 19 Jul 2024 01:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9E01392;
	Fri, 19 Jul 2024 01:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="AlbyxxwW"
X-Original-To: stable@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B722566;
	Fri, 19 Jul 2024 01:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721352354; cv=none; b=DuIXIr/opMgD6F621GkWXFMaa/CNWVBTj1Li93AVQRha9rr18NZqYDa0CZBLSR4fYbvLkn32Tw2ZcjXI3PZD3CBx7j/sn1qBaxiSUdHZ5a5Tu49dR+jU3X+v65cHd8hxNZp6W6Tiq90ROc+Q5cgW1+OIxl5ug2vA4+W0JVe9CcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721352354; c=relaxed/simple;
	bh=3riBrHEJjYG8DQjo3gY2PvcG5udcv9iZE3KxU82i0UM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L5SI2adZEGCCmDpt2LMaDQ7iqqjAsPX5DlXCdLUBF/NrUoKNiVQ5hL+7hxTZ19FpCKdDT6Wn+nLSEc84PWfj7sPkJob4w+axOBkPyeGRfaiA9Uima4eeTRbqvUcwQV01128u6qeaHCdlMBofzy3o1T+I0zocS/9LyRl+ce4DJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=AlbyxxwW; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1721352350;
	bh=2GYiCu+lLOgWZgNTWvMezkWlfvj1uXjtSXatUQwpMbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AlbyxxwWJYV1b5fmCOBwJ5m6/L+oPgLmD06ClBZG8xDSPfjD7+9k31UoEfysJTayy
	 mVoL8e8M4jOsm7hHTOoj7JCaNLa8vpgnSxfNXb2bpJoqRp/Af9JYmldIk3qT9Strwz
	 081ltjvXKlzIDOVlrsJIpI/RbZuuCsnzqWGV+Nm5O2FjWvsGrwjhCoFYvgTNBmkXTA
	 ZD+OJ5g30B0yNGJU3CbI1N8YYBVfNonTgcxuM4J32WRzfaEnDhlJsNTIrnJPGUjJK8
	 f9EaWerVxiJ60vyqG1wt8+sWM7NDfSKuyMXsn5SUAGPtqhCr2+tTqEQflBX8/x/9EN
	 jWKyH7xW60udA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WQBnn6ZBTz4w2K;
	Fri, 19 Jul 2024 11:25:49 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ma Ke <make24@iscas.ac.cn>, fbarrat@linux.ibm.com, ajd@linux.ibm.com,
 arnd@arndb.de, gregkh@linuxfoundation.org, manoj@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, clombard@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Ma Ke
 <make24@iscas.ac.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v4] cxl: Fix possible null pointer dereference in
 read_handle()
In-Reply-To: <20240715025442.3229209-1-make24@iscas.ac.cn>
References: <20240715025442.3229209-1-make24@iscas.ac.cn>
Date: Fri, 19 Jul 2024 11:25:49 +1000
Message-ID: <87jzhiw4te.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ma Ke <make24@iscas.ac.cn> writes:
> In read_handle(), of_get_address() may return NULL if getting address and
> size of the node failed. When of_read_number() uses prop to handle
> conversions between different byte orders, it could lead to a null pointer
> dereference. Add NULL check to fix potential issue.
>
> Found by static analysis.
>
> Cc: stable@vger.kernel.org
> Fixes: 14baf4d9c739 ("cxl: Add guest-specific code")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
 
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

In practice I don't this bug is triggerable, because the device tree
that's being parsed comes from a single source (IBM hypervisor), and if
this property was malformed that would simply be considered a bug in the
hypervisor.

cheers

> Changes in v4:
> - modified vulnerability description according to suggestions, making the 
> process of static analysis of vulnerabilities clearer. No active research 
> on developer behavior.
> Changes in v3:
> - fixed up the changelog text as suggestions.
> Changes in v2:
> - added an explanation of how the potential vulnerability was discovered,
> but not meet the description specification requirements.
> ---
>  drivers/misc/cxl/of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/cxl/of.c b/drivers/misc/cxl/of.c
> index bcc005dff1c0..d8dbb3723951 100644
> --- a/drivers/misc/cxl/of.c
> +++ b/drivers/misc/cxl/of.c
> @@ -58,7 +58,7 @@ static int read_handle(struct device_node *np, u64 *handle)
>  
>  	/* Get address and size of the node */
>  	prop = of_get_address(np, 0, &size, NULL);
> -	if (size)
> +	if (!prop || size)
>  		return -EINVAL;
>  
>  	/* Helper to read a big number; size is in cells (not bytes) */
> -- 
> 2.25.1

