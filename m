Return-Path: <stable+bounces-213275-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFTOLiEkgmnPPgMAu9opvQ
	(envelope-from <stable+bounces-213275-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 17:36:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 261BDDC124
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 17:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AED1731495A5
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 16:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087693D1CD5;
	Tue,  3 Feb 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ximlcXcW"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EB03D1CCD
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770136132; cv=none; b=HuJxR+quYeh8CqCYT0RckCdivELY97eJJpGPKx+90I+43Gx8VCBpCq/dHb2XZmrMeqtKd2ig79hQfyQxVlIk+qLHFNA2J5c9tiVjsQCzpg7oSVVkFYkkPy8p7g7m53R9SlfjDfyawtrinJPtI1gKTb/x5Jsx9IeTtQY+y2C9+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770136132; c=relaxed/simple;
	bh=WTd3yzufsVxFkPGEYEeOvGW7Bj+BHGOfD5k7yFY0r90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHqRY7WPmLgnomH2iDBcYed/bPDCwhU4rOGtthu54EyvD2Jh7rEdKPjB055nM0myiDeqeAOW1kFSk1POrQ2ZIYO839XHHgoWYVuCSopSoN3ONZzy45yb7Y8u13Oe+UkRwlu+xBNR1pARGKDnEaYyOJc1ccXwUZTPhYh8HZV+5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ximlcXcW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d67f1877so39053095ad.2
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 08:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770136131; x=1770740931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2ttDn1w1QA2Cz+Z+5lpKBPVG/z+n2qwJYLNRD++3uA=;
        b=ximlcXcWCjGU2iWIMO0sNJL0D9SdoCql1Su4iJHOENh0zKwbPumX0mF8ZNIM8xBS8W
         nOqu4dWNHciHOKV5lkCuuk+WPmy6Kc/sNq37vVG7q+cRJJh0F+zQlJSxgX6ql5ZogGQO
         PVWi4zn1CP8LmDvrsWrFuBmpXbrHGZ1aoVk0svemMbEKuneuTAB8XiFeXvld3cDrCVWM
         2+iQKgKlSehYN4Zk1Sv43IiQjHPQOl9/DRGQS4pLfx2wbs0/IlQZQlrI/HLi+3IXZPtB
         xfXzQ7+JQ8aAYI0SuWNy2pceXa3ztTCiQJCMO7zaNuIQgSw8hAxypncAqrCT3TeOLCKW
         7Vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770136131; x=1770740931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2ttDn1w1QA2Cz+Z+5lpKBPVG/z+n2qwJYLNRD++3uA=;
        b=wMTeRH4OAFP/LlN7Q34YyOjuUD7HL0KiD6iW9Vg5MLcD6n/atiNnYHC+a/qjfvOdYJ
         e8By1ZHBVXl347KSX3KSYAi6eJSd6dnCM7oilDZqrekEdf3xCc9FoK3xjwxKLdhx0Vtu
         hlUWgNgaBq0Rj9jz+EHen2FrU5hYXAxvIy8ejAJvUrPGlhbqNUp3Oqg+/UguVfOJTVts
         CoopMjX9vq9pq+UBWh+d3KaaKqwCLrUL4jltB+CXkYs2v9naHWSxhFEciovfG10CuJbK
         JifL2q7qQI1CMqbEmiuz8JKIZYrkZ1BjcNQ3p0fusiShlQDScsXWhn1WTKkwisgXcbMs
         6W4A==
X-Forwarded-Encrypted: i=1; AJvYcCUzu5uEq4KodwPq/vELN+oGjZ4zegy08k5rwyq9xSVIIsqx5Yef8r6UuuDPCNS0mx0KLya/NXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxip+iLTWApt463j77eudt70R67MG4PvVgXoh84SHu+odCMBsp4
	X4zHDIgfjyMrADKQs2KYVCr9fZXqxaFxLG6cECTxt4W9mTuMPBNtHaD0ZA/K4t8SFq4=
X-Gm-Gg: AZuq6aLHnA6B3nFBz3pWGqWZX1XAeQhSuJEjSqSAzoYSUl5E03zRaTfmRbBYTZcdNaI
	nXqJqcWkdCSgV2Lyljz469PaS/SjEYS096niUPOm6UNICXk6EtxshwFDl2quzjGz7YWpyfsJKk1
	0LRj/JSmTPPYq3grjclYaf6i4y9UHaZ4f46MXXcrBmLF5/MOVLHADlr9dEIlEQlbgqbSCjp6dYd
	pDmQP0iOKwIBDW6JVtDRi6/xhsrdZwPeY9hRCWMJjSe2ZtYhmDpkBUP1TC/7FlLXBGg+YTQXAmb
	fcavvxk5eBrvm6XbweaxgqRf9rRooaEh8/b2Y8NKh+9TPgBtleABnFstTQc0dN2rybU7V5b2bg2
	Jj1TrbX9fV3p1/oBqkTAkvOR7mDlaHTPFjFeyWm7Vb4VLYj1D036gYjbpvMQJPiMaqQb5SMpk2G
	oU9bv3/qjW7QNm
X-Received: by 2002:a17:902:f690:b0:2a0:e94e:5df6 with SMTP id d9443c01a7336-2a8d81818c8mr134926125ad.50.1770136125857;
        Tue, 03 Feb 2026 08:28:45 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:8fb0:b75b:356:3f2b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3d57sm177851015ad.60.2026.02.03.08.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 08:28:45 -0800 (PST)
Date: Tue, 3 Feb 2026 09:28:42 -0700
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
Subject: Re: [PATCH v3] remoteproc: imx: Fix invalid loaded resource table
 detection
Message-ID: <aYIiOtUpTebzMZcd@p14s>
References: <20260129-imx-rproc-fix-v3-1-fc4e41e6e750@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129-imx-rproc-fix-v3-1-fc4e41e6e750@nxp.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213275-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.poirier@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim]
X-Rspamd-Queue-Id: 261BDDC124
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 09:44:48AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> imx_rproc_elf_find_loaded_rsc_table() may incorrectly report a loaded
> resource table even when the current firmware does not provide one.
> 
> When the device tree contains a "rsc-table" entry, priv->rsc_table is
> non-NULL and denotes where a resource table would be located if one is
> present in memory. However, when the current firmware has no resource
> table, rproc->table_ptr is NULL. The function still returns
> priv->rsc_table, and the remoteproc core interprets this as a valid loaded
> resource table.
> 
> Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
> there is no resource table for the current firmware (i.e. when
> rproc->table_ptr is NULL). This aligns the function's semantics with the
> remoteproc core: a loaded resource table is only reported when a valid
> table_ptr exists.
> 
> With this change, starting firmware without a resource table no longer
> triggers a crash.
> 
> Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> Changes in v3:
> - Update patch subject and commit message using this one [1]
>   [1] https://lore.kernel.org/all/CANLsYkyrz+A1iEabGZ6rFybFo4=mM+TPVDRSckFB2YUS_7aKow@mail.gmail.com/
> - Link to v2: https://lore.kernel.org/r/20260127-imx-rproc-fix-v2-1-7288fcf74385@nxp.com
> 
> Changes in v2:
> - Per Mathieu, Check rproc->table_ptr, update commit log
> - Include R-b from Frank
> - Link to v1: https://lore.kernel.org/r/20260122-imx-rproc-fix-v1-1-36cc64369a40@nxp.com
> ---
>  drivers/remoteproc/imx_rproc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 375de79168a1c8d11b87ac1bd63774a3feac106d..f5f916d6790519360f446f063e09d018c5654953 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
>  {
>  	struct imx_rproc *priv = rproc->priv;
>  
> +	/* No resource table in the firmware */
> +	if (!rproc->table_ptr)
> +		return NULL;
> +
>  	if (priv->rsc_table)
>  		return (struct resource_table *)priv->rsc_table;
>

Applied.

Thanks,
Mathieu
  
> 
> ---
> base-commit: e3b32dcb9f23e3c3927ef3eec6a5842a988fb574
> change-id: 20260122-imx-rproc-fix-e206f8e6e477
> 
> Best regards,
> -- 
> Peng Fan <peng.fan@nxp.com>
> 

