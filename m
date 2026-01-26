Return-Path: <stable+bounces-211654-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG9rJsObd2n0iwEAu9opvQ
	(envelope-from <stable+bounces-211654-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:52:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 493C58AF56
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 17:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A8A330503D6
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 16:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49F234A77A;
	Mon, 26 Jan 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BjM4epAa"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5634A3A7
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446187; cv=none; b=POANVpVKGP9oJAP3+1ZFcQ+66e7clGQard+GDxO5WJOMri+YwQjj8JBC7bLN2QuzciNZmn2GyjpJQQ9kFkkxp3hU/hQ8WwCXP6AS+56dJgmAj2ZcOC+Dnq0ckqMYnJz7bulZK4f5f2RGM0YsTsaslUyCCxphRCHmMsUS3EcI3BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446187; c=relaxed/simple;
	bh=wcDl92qrj6gtr3M+a+7Ixmj+6kaZn8WOD9ZkxcA6MLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDGgfECgsBpX4qI+P8o92WCqwT9rmv/rqupqf2WWcy1mxSu9/f/gLt5i4zBh6y6wAzZdsxXWgineSuK5oT5mlOQ3imISVcAtv3XEx5mm+d7K/+uRRW1HBPqJYwkgeYrPc4roHUKLwI4C+djSo5KCNctGd8ZrbGJl95NPAfUWsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BjM4epAa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so50510485ad.2
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769446182; x=1770050982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKR5exgvtJ4nN+wmy7UGkJjcYwJf1VIP0gn7pcEz2lI=;
        b=BjM4epAaJ4p2jQsPCwsNkegXG/zmd8pGi/mGOhx5MLMIuJVCQ7pE4FyKKf7Lh9YEf0
         IY1wk3IwexyaCM7LALsPFyygxcFjb+ePi0u7OTKdtgEQY86GKfOz/4u9upQ6PcyvBXE/
         KPwg5RctjbNe0fQsur+3Tfaj1IzLZnhyCDCoXW3yUll6VX3jsTezIEj0XztL1dJVrVx7
         y74VTKB/o91Ol6aNomJahfygQPJTrrBz0IcoZCvM1iO4sE/WHrDpJGM6CgQnVOrewrdj
         1wFgmOK7AMLXkn7XnDyEr930adCuHOd/EEkBlWY3Jvwl/F4XJnebfyw1YreNGdQGOSuM
         /I9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446182; x=1770050982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKR5exgvtJ4nN+wmy7UGkJjcYwJf1VIP0gn7pcEz2lI=;
        b=g+LLy/0kPcMWS9z81fjvBuDPWxZQtSe9xrkpwqBOOqmaoC+ji906/3FmWhNkTufQBs
         cMUE2As+UAhkHd3ZpjZYlxsBv1lmYc7x1sTdIXmE7y3Lp2LQgwP7gkQEOfevA24ug2uj
         trdtaqyfvGcHQBJ7UAsA8L7R9TxX+ImRTlGgjWBO8oSXy1I8QTfdBAt8CxVFee3EIge3
         bH7bCi/dCdsF97RM3dlYKMWbMk5+SdF20hj1ebN/RHtaipOLnaRBHgCk2mbabPHjCNSq
         IG2d9LtRA/fNboVaZKHmhds0//30fofbKOc6cAwl5IPVbEACKWnNs8UP7HmwXVBobzHo
         Ml+g==
X-Forwarded-Encrypted: i=1; AJvYcCWNgJeO/+exy1loQL7ey9Qz9XmtKeeDOqDkw6nVbC06+1zv/xej4TT5zE8YeL72yZ7KUJhiYf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBGlfgU48rIAfpnZJB5xd7TUTtGnbRGqzVT34G2iHbQXjOd5Qm
	0QnHuYxU2EBPXdpd2qRExqfcT3woemvRfM9gY6nTHny47hzunRZ4vmW36sUGuy4wWjE=
X-Gm-Gg: AZuq6aLYQKXTb13yutp4pyDIGNPmZ9WIuQuZK6ihP3lt/njFmSIl5oZSlJPudKD/Z86
	g2Pl+UBYlmKhUz435l3wOoLDtuBrzh9od82YqcIFSl5UggmfwPHI+EpuN2pqpE87F4HYNoI4460
	+xndBEMMRdCyJI6+MRHKqHhx2HzqHWS2TrO+8Uxxu5JNeQNqCl+bMIvOWNSPKxknW6N5m9FweKy
	bvVz+Wxra1L19ztXCAr6vNUQgbvOJlB8TWdRQkqLdbWxZ4QgAnNmHq/bZLnRNJSkTLXvHI4BMTW
	5LosrOiDvyJlpoHR7u8UdfTeU5Mbzs7xbhXueKXPjRCjfL2PUEBPTvg9LaQK0uEHT5oy2GKBeZz
	CM0qJ5h78bn7VOFbqTCN1ZSAawpGz12MJy7CMGaWkSfKczxWyIUJnm/Db1U6jXB67KTLHmGuLeV
	hbOy61vXtEfC/hmg==
X-Received: by 2002:a17:903:11c3:b0:2a2:caca:35d2 with SMTP id d9443c01a7336-2a845224d47mr49945825ad.16.1769446182265;
        Mon, 26 Jan 2026 08:49:42 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:6260:7bcf:7e2d:fa8d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802dcdb8csm94531115ad.31.2026.01.26.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:49:41 -0800 (PST)
Date: Mon, 26 Jan 2026 09:49:39 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Iuliana Prodan <iuliana.prodan@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: imx_rproc: Not report loaded resource table
 when none
Message-ID: <aXebIztkPihBsLRK@p14s>
References: <20260122-imx-rproc-fix-v1-1-36cc64369a40@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122-imx-rproc-fix-v1-1-36cc64369a40@nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211654-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	URIBL_MULTI_FAIL(0.00)[linaro.org:server fail,sto.lore.kernel.org:server fail,nxp.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.poirier@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linaro.org:dkim,nxp.com:email]
X-Rspamd-Queue-Id: 493C58AF56
X-Rspamd-Action: no action

Good day,

On Thu, Jan 22, 2026 at 11:24:43AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When starting a firmware without a resource table after previously running
> one that had a resource table, imx_rproc_elf_find_loaded_rsc_table() may
> incorrectly return a valid device memory pointer (priv->rsc_table).

priv->rsc_table is not NULL if the DT has a "rsc-table" entry, indicating that
_if_ there is a resource table in memory, that's where it should be.  Function
imx_rproc_elf_find_loaded_rsc_table() is buggy so the narrative about a
previously running FW with a valid resource table can be dropped.

> 
> In this case rproc->cached_table is NULL because the current firmware does
> not contain a resource table, but the remoteproc core still interprets the
> non-NULL return value as a loaded resource table and attempts to memcpy()
> from rproc->cached_table, leading to a NULL pointer dereference and kernel
> panic.
> 
> Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
> there is no cached resource table for the current firmware. This ensures
> that a loaded resource table is only reported when a valid cached_table
> exists, which matches the remoteproc core expectations.
> 
> This issue can be reproduced by:
>   1) start a firmware with a resource table
>   2) stop the remote processor
>   3) start a firmware without a resource table
> 
> With this change, starting a firmware without a resource table no longer
> causes kernel dump.
> 
> Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 375de79168a1c8d11b87ac1bd63774a3feac106d..cf044b385b58fe1e17d0fc440c243d76ecf020ae 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
>  {
>  	struct imx_rproc *priv = rproc->priv;
>  
> +	/* No resource table in the firmware */
> +	if (!rproc->cached_table)
> +		return NULL;
> +

I think rproc->cached_table should be kept for internal remoteproc core usage
only.  Please use rproc->table_ptr.

Thanks,
Mathieu

>  	if (priv->rsc_table)
>  		return (struct resource_table *)priv->rsc_table;
>  
> 
> ---
> base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
> change-id: 20260122-imx-rproc-fix-e206f8e6e477
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 

