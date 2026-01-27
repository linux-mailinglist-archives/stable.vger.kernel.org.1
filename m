Return-Path: <stable+bounces-211850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DJkC63eeGnytgEAu9opvQ
	(envelope-from <stable+bounces-211850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:50:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809789715C
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323BC3053BA4
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9CF35CB76;
	Tue, 27 Jan 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJn17s0I"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608E435CB90
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528852; cv=pass; b=nlBxi3dZEomfUvySmD6GujBjHz5wlwUPQ6nglmjpPoK0Tz/GhludYzIlVf2keUxTltkU2rmv/T6uyFUtiWkBpLT99Qf5lKNkWiujUFEummhc1UQZHXtBT1qMWKnDGJmsdwa0qQId8OQHwPkSyXXX5rsVTULYm5jVKK+UY8KDFIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528852; c=relaxed/simple;
	bh=HCLPCR2cutuEe8a9e/T0nSzNtiAitdZEV3TVlV7ptNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ln1xJU3AG+GS5OvbtNYs09ExZ+9jdX6WsG2H/XVSPCkZBHTHbisjfUCDn/lOQNxBHBpe3D/rlARMStvM5Qhi+JgRQgzRyWCLLWsbicuu+6iudmVAmSVEolzRPigl8Dr7Ejxqbl5HX8uzFqSWsM+OpjDN6/nYlmtYiCUUfqR3GQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJn17s0I; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so9948655a12.1
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 07:47:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769528849; cv=none;
        d=google.com; s=arc-20240605;
        b=aSnHNNV/ZKK74p7J8DtSKRDvLNxjh8irNQyyy2jcu0QT5P1IxS6ZnjTOA7kjblTQZD
         dBC6JLrHT55Phf3QcBwkTG9/WzJyRPNG12MUDJXTBkBrGFf7H4zbrHFKMcISsIqnAq0t
         C/S9TDr+Ikfmu/0dO+fBa60bbqhO7gc6X2Lyjk33Udk0s+PN/ST7f/MKF5D6ss3yZvsB
         tJ9PuaYoWVf3CDgQmiNHRsxUUVIt7ZQSbl1nJV3HH/whC2qnOMALi5SR5Gv76T/jM93V
         GhWs1zChJk+nIcxJfugDCdAT6btae3GrBk/c74VNPu/QkXXlk9E1/hSOJKnG6lHRY9tN
         cR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7eOuyosWnsXIdwMTE3mmiW0j22cD4OeLu7JqhilojCE=;
        fh=CyjebdA5QijnDWgEpxCWlbb1hrtJtyh1Vhh6AFVWou8=;
        b=d+LFwYalSkpuCobnYmE/d5EoOUDF+6g0pfRGw9bK5wfWgXTRbDsKxaO1eK1UMfGG7Q
         yCG1QTyNdnrgybKPlm58o6eMKsCnhm26VaTkjUlwcCGt5mF1IN3VZSa+/dQeAb+N2e54
         nLrpr/peg647prKi93fEddoOsYOpFBcpmak7w1qDasicrWiepZADmyXa+CwKcojM935W
         Qcy+OjsAa+/fXjKOuX5SPAsiHmQqRViYDeW8S9bw90edUNNA8eHIeFNLxwtNyaXPNgtV
         Qg3vXMuSIgG/MzCTzJJaAuhTO+j5WEvltyxR27ZHjnDnNVdfK+UZ4Pm2G8cV305+Zysw
         BJ+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769528849; x=1770133649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7eOuyosWnsXIdwMTE3mmiW0j22cD4OeLu7JqhilojCE=;
        b=qJn17s0IrTl4xJkDKhNywAaqJqGO9lHhElHPHVyKUcuiATjYXxws2FECPTUxpsFGqe
         mQ7/x2rc+Q3/19V8309D7DAMz3hUAy/hXulFKUJlfRVQ1gl3nc8SY6Vs8YWhqsqBhVYf
         oK0+5wIKd3aIwBGv1XU2wFQpsNak3CEv00bcoDhm7ZJ0YjxeVAw/8hh3Ds7TM4xyP/L6
         2aLUec/qKoXFpcJgsqGjUYQH2xDvY+OPASVzxcAVhKOrOfmD/ZpUo3dsejpp9nfunRAh
         MebGadxEOSu9DKrtB/pBWOHvSiVWNl79u75FH7TBiy1LvEQzecm/PRqyaK8W182LRnmn
         wQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769528849; x=1770133649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7eOuyosWnsXIdwMTE3mmiW0j22cD4OeLu7JqhilojCE=;
        b=NfqQJ7S1XiIjohsakX5ECKfv+JY3G4GuBgSf61aYDqWbLEji6Ni076GhzqtFoWuAs5
         MEK1E48JILPutO3iPuVMbeq1CftKNpVfroVTjDC3dK3YuFrKa82L3uXMJWHq/pFdMg1p
         /J4p2dMZMI5Pw50hj6OfqbxRqImIdtPkVFfqVR+TaePlh3svJWVR4H/JOlTONR6UkrIH
         zSCPXaTJkrq7tKi9fPr8zFEDRf5cAbPjo46OrfBaltkWjyhzjSy0rYTWGDgmbhIdT53P
         4//hkhy5ajT+mbZgLSiDszLoZ3rf2HRP1WBgbIswuVCKYSAVjuP6iMraJf59ihNDUc4v
         9ldw==
X-Forwarded-Encrypted: i=1; AJvYcCVlSvzjHw6gKjwoe4DY0sur6ZYcriSy5GF84JgGzg/huROprIyuupRBsW2mO+7Czi/ghZDw6zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdlGJwCUyFFM+R3FOyeG9RqoJ06cawWQhVSXIFdcIjA0TR71o6
	x8XfUNPXPlms9m58ULcnJW8gm5ehP8414YFqlcwOVLlcUQ3KPtPRerTtrX925QwmDRxCA4AMj7X
	y8wUz5vDtr3QNryOmwttxjkeyX4YS8cKqxJB/7+KzPg==
X-Gm-Gg: AZuq6aJn5jza8qf0jgxV//wrAHdCgM2aqGAqTpyDf+Z9z23JHJ3JeAGX8HQlkGBT3MS
	jblIzcAWHWNUMBO7RvuPo+lTjv/03zEPCyN1bJKCZHIuZZIby7Suwa1S0VMZ0uj0klWWvg9FKCD
	KtHvBmmS8OxQMA3XT5JzdrJ8ntYkCiqqi7JS4pLkjfJK/ZH+TjalRn3z8qc2flpsFAWB7hrvD2+
	/9Dt5gzEcSWLkCGZcpSB1O+wLV3cfUGfnaVFjz7eMHhzlqPIlNn3Y/cyKZ12Bs9NPj4wfcaBdwB
	awTYlUj/IY6ebwvLorIIpjhMq2RtLg==
X-Received: by 2002:a17:907:1b24:b0:b87:2cf8:f7b2 with SMTP id
 a640c23a62f3a-b8dab3e10c3mr158375566b.56.1769528848592; Tue, 27 Jan 2026
 07:47:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-imx-rproc-fix-v2-1-7288fcf74385@nxp.com>
In-Reply-To: <20260127-imx-rproc-fix-v2-1-7288fcf74385@nxp.com>
From: Mathieu Poirier <mathieu.poirier@linaro.org>
Date: Tue, 27 Jan 2026 08:47:17 -0700
X-Gm-Features: AZwV_QjqQbFcKArui8POG1LTyVyFyhUaVHLmRHbU-P_6uXh9D3Ex2V3D86esp5E
Message-ID: <CANLsYkznMVh240wMUZGayJHRzsUV-NNTiU+ezpLt3rjcwSn5Wg@mail.gmail.com>
Subject: Re: [PATCH v2] remoteproc: imx_rproc: Not report loaded resource
 table when none
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Iuliana Prodan <iuliana.prodan@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Frank Li <frank.li@nxp.com>, 
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Peng Fan <peng.fan@nxp.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211850-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,pengutronix.de,gmail.com,nxp.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.poirier@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,mail.gmail.com:mid,linaro.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 809789715C
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 at 23:51, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> priv->rsc_table is not NULL if the DT has a "rsc-table" entry, indicating
> that _if_ there is a resource table in memory, that's where it should be.
> Function imx_rproc_elf_find_loaded_rsc_table() is buggy so the narrative
> about a previously running FW with a valid resource table can be dropped.
>

(sigh)

You apparently did not understand my last comment.

> In this case rproc->table_ptr is NULL because the current firmware does
> not contain a resource table, but the remoteproc core still interprets the
> non-NULL return value as a loaded resource table and attempts to memcpy()
> from rproc->cached_table, leading to a NULL pointer dereference and kernel
> panic.
>
> Fix this by returning NULL from imx_rproc_elf_find_loaded_rsc_table() when
> there is no cached resource table for the current firmware. This ensures
> that a loaded resource table is only reported when a valid table_ptr
> exists, which matches the remoteproc core expectations.
>
> This issue can be reproduced by:
>   1) start a firmware with a resource table
>   2) stop the remote processor
>   3) start a firmware without a resource table
>

Another sign you did not understand my last comment.

I had hopes of merging this patch but the changelog is too garbled to
be salvageable.  I suggest you ask Daniel or Iuliana for help.

> With this change, starting a firmware without a resource table no longer
> causes kernel dump.
>
> Fixes: e954a1bd1610 ("remoteproc: imx_rproc: Use imx specific hook for find_loaded_rsc_table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
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
>         struct imx_rproc *priv = rproc->priv;
>
> +       /* No resource table in the firmware */
> +       if (!rproc->table_ptr)
> +               return NULL;
> +
>         if (priv->rsc_table)
>                 return (struct resource_table *)priv->rsc_table;
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

