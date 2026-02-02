Return-Path: <stable+bounces-213077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHzoEvLNgGkfBwMAu9opvQ
	(envelope-from <stable+bounces-213077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:16:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7389CECCB
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 17:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 974F2300D99F
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 16:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3865E274B40;
	Mon,  2 Feb 2026 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CWbgTv5c"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965F2652A2
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049007; cv=none; b=cGRAqPvp0t2OmIq06cMpYNSSDgoh7WytJ52shFduC8ug31b+okb8KLF5G4k1Hg7XVT8GWx9Bw8tF9FZ/o/tnr4lcRTugn9oNK0hcfgE129iex9KM4DTkcz5z0psjxfGADrtMewhKnJDw3z1OHQhpDsP3qCW5pYnrLWw5AfFGIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049007; c=relaxed/simple;
	bh=PMp4djD8pRzTfzCwrEWdLRidXLy0AL6hraTfCK1hKTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTI+o4jkcgOCKzU/aA0i7yqVvBFBZytdy6LiSZw9cv0GBqNtlxdt+seMXL4qgqSy6l4LcXClcWukNmo7ExgpFs5341w3GvKTFVAaxbxkStMmvV8Q/DglO2CmXcoX5SbyiD0EQx2ESS8Dbr+3+h4/afKKCeCn6oFn0F0YD5i0vPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CWbgTv5c; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a09d981507so32758475ad.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 08:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770049005; x=1770653805; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yDIwIvjoA0KVZj8266aGVsS4EvreJW/WICQfNeIuAso=;
        b=CWbgTv5c8Io0cIiRd9rSz6q1Qpein0lLZLFY38XhSy0BEXwjecDMbfaUMO6Pp9bEd/
         kQcffYvQix74IkzH3aD7iBFKe40cDACIfoHvWqTyGJOoIoFcRQs7/aaAuVHitHnBlFjx
         66RE9zaeDoxCewjPK61LG3HgoWZSPKIpckz8lVMeVXWsHtc1j/snVLaHHU44KPAzYc/B
         LBZ5ha0uhDREkQ/opDd71zNtiXr0LrqjUX8Ns8iIzVXcCNEk1FdAb6c98GephXBkFtOF
         CQDY+dKR4eZRv3hsh/r1jAsLCslQUiWNizp4nUuizP8/LO9BdNGjF7bq51ciyecBkQQE
         0wCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049005; x=1770653805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yDIwIvjoA0KVZj8266aGVsS4EvreJW/WICQfNeIuAso=;
        b=v6xCtEJILEBz0m61pop6cTF00zR1gGVbbszT5TGDRf3k+abEH62JWd69rFfuXhsvHD
         43ppCuDYPLA54qFDaMRfPffqMP9xyuklHzNVSxnEXxGb5mkdIYX9/fZ/aZUbd8HRqA3b
         CzNaa0qwaT1KhoLNIh0z1B8Hg7FRnsAfDITylt1gktacHa5mPKUtmD82rQvTD/v0iDb7
         XC5zTNjmswnKWf4FZXlO9vXtBgE+r/VjloBwGCputKkKBatjeJN+cdWa/SptKRwZNeIt
         ry0wydTsBupVA4xbKnYo9sZNfbi+6Pa6eqJ3HBfTQjbMB4503VI47r3dBWBs9492XMmo
         gykQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhZefswSxZ3XOas5OvP8SOk8+NFWIDdTYdIOUK9Y49EUb+KYIpJBdlEyZuZCTOH7CeVycjmDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXmmX9cj+rk9nw6MO+71Y7owO2vkV+duUf5CnTG3vWmXH6DEUO
	qiivBXSaDH2r7DoMhMf28YbKADW1/qU+xgnPn8Yx4G3mCrSJY7x0dJm9gGBTx53VE7U=
X-Gm-Gg: AZuq6aJabzyhBO63WTWPrmTgPe0WGJMA6jVqxZduIdnyzFjCCPdd4/tsg16znG2Cjrh
	hdIuGdjbo46At8HlzoM++hGEjRfhhh8DdkjQLAR5Y7SFKHZBYLZ2EJezQo1dgypFDFJa1+gwm8q
	LKGgEGCbi7i+pE6ZWc42IDxX8w6TWU14eLXdAFgaMdwphaDdXh3On3iXsHfPOvhU0M2gGRMp7lh
	z9rIARtUTZ1QxtWejlJI6n/s7JdUv81UmXxHoJqJNaD06wvbmFpal7KdlgsaxaDNUcF4L/+h4LQ
	JdYNp2z8fW5R1gfuDYv7ybNyNFs5Al3y0sGCOFrNMT9DNuR+B0xQMDAS3/IRSL+mbtXj8iNsrGg
	7TiIn83dB3rIPnmwhcehnv+UPhLH2NI6eICfx0Pj5A3vOFxy/xDeDcWKOKsR3QD+aJYVuUoQ4lY
	/2CbYi0wtX9i75rMqUb6WSv9QN
X-Received: by 2002:a17:902:e749:b0:2a7:5f26:aaf9 with SMTP id d9443c01a7336-2a8bd4c6f2cmr162675685ad.14.1770049004918;
        Mon, 02 Feb 2026 08:16:44 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:ef20:b488:c934:4d5f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4154fcsm147962315ad.36.2026.02.02.08.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:16:44 -0800 (PST)
Date: Mon, 2 Feb 2026 09:16:41 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
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
Message-ID: <aYDN6X0WVT9nV8fg@p14s>
References: <20260129-imx-rproc-fix-v3-1-fc4e41e6e750@nxp.com>
 <CAEnQRZA-nMai9-CEdMqnr2drqBRXXPOKE3a+_3j4S_=x-bM0pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEnQRZA-nMai9-CEdMqnr2drqBRXXPOKE3a+_3j4S_=x-bM0pQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213077-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.nxp.com,kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.poirier@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: D7389CECCB
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 06:02:21PM +0200, Daniel Baluta wrote:
> On Thu, Jan 29, 2026 at 3:45 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > imx_rproc_elf_find_loaded_rsc_table() may incorrectly report a loaded
> > resource table even when the current firmware does not provide one.
> >
> > When the device tree contains a "rsc-table" entry, priv->rsc_table is
> > non-NULL and denotes where a resource table would be located if one is
> > present in memory. However, when the current firmware has no resource
> > table, rproc->table_ptr is NULL. The function still returns
> > priv->rsc_table, and the remoteproc core interprets this as a valid loaded
> > resource table.
> >
> > Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
> > there is no resource table for the current firmware (i.e. when
> > rproc->table_ptr is NULL). This aligns the function's semantics with the
> > remoteproc core: a loaded resource table is only reported when a valid
> > table_ptr exists.
> >
> > With this change, starting firmware without a resource table no longer
> > triggers a crash.
> >
> > Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> Changes looks good to  me >
> 
> > --- a/drivers/remoteproc/imx_rproc.c
> > +++ b/drivers/remoteproc/imx_rproc.c
> > @@ -729,6 +729,10 @@ imx_rproc_elf_find_loaded_rsc_table(struct rproc *rproc, const struct firmware *
> >  {
> >         struct imx_rproc *priv = rproc->priv;
> >
> > +       /* No resource table in the firmware */
> > +       if (!rproc->table_ptr)
> > +               return NULL;
> 
> I wonder if we can make this change generic because it should happen
> on other platforms also.
> 
> Maybe something like this:
> 
> remoteproc: core: Only copy loaded table when valid
> 
> Copy resource table in memory only when:
> * the current loaded firmware provides one
> AND
> * there is an explicit request to have the rsc table copied in memory
> via rsc-table
> 
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1281,7 +1281,7 @@ static int rproc_start(struct rproc *rproc,
> const struct firmware *fw)
>          * that any subsequent changes will be applied to the loaded version.
>          */
>         loaded_table = rproc_find_loaded_rsc_table(rproc, fw);
> -       if (loaded_table) {
> +       if (rproc->cached_table && loaded_table) {

But we would be doing the check for rproc->table_ptr twice (->table_ptr and
->cached_table should be the same).  The way it is currently writting forces
vendor specific implementation of rproc_elf_find_loaded_rsc_table() to do the
right thing.

The merge window has been pushed by a week, giving me an opportunity to merge
this patch.  Should I do that or should we continue discussing the best
approach?

>                 memcpy(loaded_table, rproc->cached_table, rproc->table_sz);
>                 rproc->table_ptr = loaded_table;
>         }

