Return-Path: <stable+bounces-212982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPs/EsvbfmkgfwIAu9opvQ
	(envelope-from <stable+bounces-212982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 05:51:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D32FC4F00
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 05:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E879B30160C0
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 04:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F572D8766;
	Sun,  1 Feb 2026 04:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="SSzaRxEU"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2957748F;
	Sun,  1 Feb 2026 04:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769921079; cv=pass; b=K8P28nQYCtASxYW/RoP93ERwYk4i4sbGdnEReVY/oqICgzaQmVXRqQRtP42Q4G67w+2JQLl8i3rzzc7h1MRkwnEVdb81ih3Wx2vIL4gmUQuXtukf3ZQuAp7qfMnOggKeraGt/wUPGJVNpPkDy0iwM6z1c8jbNzubEsLdbJDz3/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769921079; c=relaxed/simple;
	bh=cMOwmr47IFzgPtRwSpvF15YpswFde47IVbxdIUPq4z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9sKwMjJcbUn/higIdHjV5e9S6IruXmPZ8XuVz4eonmXGhU2Hre8XwA7ad5VJ9BIAngiPQSSppka5QHlQlf6BFG8FK6ogkql7ilwgb+ojlURe7NoBGG+b7mwBkixxNNGIcQTSeR9VAglZ6tINniPfqaK4TfkcWgnGaqxTv4fx+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=SSzaRxEU; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
ARC-Seal: i=1; a=rsa-sha256; t=1769921036; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h1dtd9gdsIywSjU2hq1rbCIgojDhVIZwk4+zdhO80bnRfgH7yY7Si0LZ8AXS6I0msRMgOiytWfwta9+7U0MDUJSmZ121YVgXtWKDEgZk8xoeIQvr2Hficb+8JUIqgdYpxOKfL0zdq4wat/AJ/zHljp17O8QlIc+nhC3tyzNcYDI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769921036; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jN3A5mwNdsi4fNTvnSJvZchnh0nKK5f4E1gczxpNa3I=; 
	b=lyO1+EF+ZqnMLk6mt2qxq0OKbHManaxrJ7/cNQSLB24Qe1w0Nk/j6SrCAUXgYzdS7eVsdahst2oNj3GNe40eHDEch6kh6hiqkxUP8fEozGdTKQ+J3vJNJeC0MXFyUASVq8rg2ueiw+hy+LMQqj5oSeA+YFA5xexk3X33Zx/Qo7M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769921036;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=jN3A5mwNdsi4fNTvnSJvZchnh0nKK5f4E1gczxpNa3I=;
	b=SSzaRxEUvcYgnS6zLR63wLwlIAImto2Wcv/C0LhhZXOqkLwgILYrT7Z4/2mAA7wg
	4t+HgqimafucOYal3YlyzN+hO6ABtp4MDL8pGxGsmFQPvnVCYmrNkZYLaV+p6Uto/m+
	r2U8uV1mwuLek8MBCq1vO4/IGCdpqC+KyN3BIdj0=
Received: by mx.zohomail.com with SMTPS id 1769921032597677.9981604122934;
	Sat, 31 Jan 2026 20:43:52 -0800 (PST)
Date: Sun, 1 Feb 2026 04:43:37 +0000
From: Yao Zi <me@ziyao.cc>
To: Huacai Chen <chenhuacai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Yanteng Si <si.yanteng@linux.dev>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>, loongarch@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: Correct spelling from clk_scr_i to
 clk_csr_i
Message-ID: <aX7Z-ZjXvhNa3Wsp@pie>
References: <20260201023619.366505-1-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260201023619.366505-1-chenhuacai@loongson.cn>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.34 / 15.00];
	URIBL_BLACK(7.50)[ziyao.cc:dkim];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[ziyao.cc:s=zmail];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212982-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ziyao.cc,quarantine];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[me@ziyao.cc,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,foss.st.com,synopsys.com,gmail.com,lists.linux.dev,vger.kernel.org];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[ziyao.cc:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.436];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziyao.cc:dkim,loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D32FC4F00
X-Rspamd-Action: add header
X-Spam: Yes

On Sun, Feb 01, 2026 at 10:36:19AM +0800, Huacai Chen wrote:
> In include/linux/stmmac.h clk_csr_i is spelled as clk_scr_i by mistake,
> so correct it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  include/linux/stmmac.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index f1054b9c2d8a..1ba583ef6e03 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -28,14 +28,14 @@
>   * This could also be configured at run time using CPU freq framework. */
>  
>  /* MDC Clock Selection define*/
> -#define	STMMAC_CSR_60_100M	0x0	/* MDC = clk_scr_i/42 */
> -#define	STMMAC_CSR_100_150M	0x1	/* MDC = clk_scr_i/62 */
> -#define	STMMAC_CSR_20_35M	0x2	/* MDC = clk_scr_i/16 */
> -#define	STMMAC_CSR_35_60M	0x3	/* MDC = clk_scr_i/26 */
> -#define	STMMAC_CSR_150_250M	0x4	/* MDC = clk_scr_i/102 */
> -#define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_scr_i/124 */
> -#define	STMMAC_CSR_300_500M	0x6	/* MDC = clk_scr_i/204 */
> -#define	STMMAC_CSR_500_800M	0x7	/* MDC = clk_scr_i/324 */
> +#define	STMMAC_CSR_60_100M	0x0	/* MDC = clk_csr_i/42 */
> +#define	STMMAC_CSR_100_150M	0x1	/* MDC = clk_csr_i/62 */
> +#define	STMMAC_CSR_20_35M	0x2	/* MDC = clk_csr_i/16 */
> +#define	STMMAC_CSR_35_60M	0x3	/* MDC = clk_csr_i/26 */
> +#define	STMMAC_CSR_150_250M	0x4	/* MDC = clk_csr_i/102 */
> +#define	STMMAC_CSR_250_300M	0x5	/* MDC = clk_csr_i/124 */
> +#define	STMMAC_CSR_300_500M	0x6	/* MDC = clk_csr_i/204 */
> +#define	STMMAC_CSR_500_800M	0x7	/* MDC = clk_csr_i/324 */

This seems only a fix to typo in comments, instead of real functionality
bugs, should this be backported?

> It must either fix a real bug that bothers people or just add a device
> ID. To elaborate on the former:
> ...
> - No “trivial” fixes without benefit for users (spelling changes,
>   whitespace cleanups, etc).[1]

>  /* MTL algorithms identifiers */
>  #define MTL_TX_ALGORITHM_WRR	0x0
> -- 
> 2.47.3
> 
> 

Regards,
Yao Zi

[1]: https://docs.kernel.org/6.15/process/stable-kernel-rules.html

