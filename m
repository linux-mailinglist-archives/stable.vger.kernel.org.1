Return-Path: <stable+bounces-263188-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hlJHJqbqL2r0IwUAu9opvQ
	(envelope-from <stable+bounces-263188-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:05:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC11685F74
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:05:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="B4MqD/GJ";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263188-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263188-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BACBD3003726
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5D3E5A35;
	Mon, 15 Jun 2026 12:05:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0B3E5ECF;
	Mon, 15 Jun 2026 12:05:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525126; cv=none; b=LzUQcEvU/VEK4rIcnHB6vMjsRR2wvTkja/R2ZSJU9D7y6ktEuM39zQG2RRQyF3sY6i0FUy8m1gKDaqVybB+9Tg4PL0U2ZMOWY/jStVmt6QH8rcqSfWa0gC7xe0oC9knKucBs8Ozo8kWJBcVk7xGSk8oYMdSv5LvN6KTmrHWejQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525126; c=relaxed/simple;
	bh=QdlTBwOO8Ra+4MX1guJFr+xP+zmF/waei9S/PUKzrZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhbQBHPV2wcELt973Qv6N4ALazF9V1wCVvYk2JF+irevzRkIhKdaqSRVUW4PwlcgAi86kzwAEayi3nNA2msKH95+pDvfQouiBbbjgT8I0VWAyPuGPUUizkf7ux6X5B35Qm85eoajuIINsltRKOJiShGlvBiNTmyuBksnPKIh0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4MqD/GJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E82941F000E9;
	Mon, 15 Jun 2026 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781525122;
	bh=+sZKOE5bnjIX0SDNXYZiCaVJ/3bt8ORU+ib2JKDeJrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B4MqD/GJeR49C+wIkqJtEJJhSlOwm47nEMGJ9yPcHJud7r/rwIXwEEg2imjC7ZrUI
	 HIA+5IgIWXn8uENQMeCYDaCRTqG2SyuH06YcBUyQq0C6Pvj1U146zLyXpC7oZsEOct
	 YMhskj/LtUTxBUADNZtkCJUMARnEn5piQupmIUDDm7VSqJq6athyLODgFV3+1D/G4z
	 XcB8mYA/KvXnvYwLW5LXZoCk/aYThd7ONHMrIJ6QezNwodqep3xxb/0c63XooRjN9i
	 +ocqV2MPNi1Rl2siHpRa1EDIv98WLWeq8wn7hLWySuJe5XavO06PtkxTl5pLV4VrAi
	 K38qB/wAhL+/Q==
Date: Mon, 15 Jun 2026 15:05:19 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: ZongYao.Chen@linux.alibaba.com
Cc: Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Michael Roth <michael.roth@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] crypto: ccp: Fix SNP range list bounds check
Message-ID: <ai_qfx0n5CywFoel@kernel.org>
References: <20260612092525.1203150-1-ZongYao.Chen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612092525.1203150-1-ZongYao.Chen@linux.alibaba.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ZongYao.Chen@linux.alibaba.com,m:ashish.kalra@amd.com,m:thomas.lendacky@amd.com,m:john.allen@amd.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:michael.roth@amd.com,m:bp@alien8.de,m:brijesh.singh@amd.com,m:tianjia.zhang@linux.alibaba.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jarkko@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-263188-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CC11685F74

On Fri, Jun 12, 2026 at 05:25:25PM +0800, ZongYao.Chen@linux.alibaba.com wrote:
> From: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
> 
> snp_filter_reserved_mem_regions() checks the range list size before
> adding a new entry. If the page-sized SNP_INIT_EX buffer is already
> full, the next matching resource can still write one entry past the end
> of the buffer.
> 
> Check that there is room for the next entry before appending it, and
> compute the next entry pointer only after the bounds check.
> 
> Fixes: 1ca5614b84ee ("crypto: ccp: Add support to initialize the AMD-SP for SEV-SNP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zongyao Chen <ZongYao.Chen@linux.alibaba.com>
> ---
>  drivers/crypto/ccp/sev-dev.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index d1e9e0ac63b6..9e6efb3ec175 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -1324,17 +1324,19 @@ static int snp_get_platform_data(struct sev_device *sev, int *error)
>  static int snp_filter_reserved_mem_regions(struct resource *rs, void *arg)
>  {
>  	struct sev_data_range_list *range_list = arg;
> -	struct sev_data_range *range = &range_list->ranges[range_list->num_elements];
> +	struct sev_data_range *range;
>  	size_t size;
>  
>  	/*
>  	 * Ensure the list of HV_FIXED pages that will be passed to firmware
>  	 * do not exceed the page-sized argument buffer.
>  	 */
> -	if ((range_list->num_elements * sizeof(struct sev_data_range) +
> +	if (((range_list->num_elements + 1) * sizeof(struct sev_data_range) +
>  	     sizeof(struct sev_data_range_list)) > PAGE_SIZE)
>  		return -E2BIG;
>  
> +	range = &range_list->ranges[range_list->num_elements];
> +
>  	switch (rs->desc) {
>  	case E820_TYPE_RESERVED:
>  	case E820_TYPE_PMEM:
> -- 
> 2.47.3
> 

Obvious enough:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

