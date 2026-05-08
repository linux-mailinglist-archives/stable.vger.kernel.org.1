Return-Path: <stable+bounces-244656-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D+XCCtM/WmUaAAAu9opvQ
	(envelope-from <stable+bounces-244656-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 04:36:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB24F0DCA
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 04:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F1F53049950
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 02:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E376827FB25;
	Fri,  8 May 2026 02:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="Az8bmT74"
X-Original-To: stable@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF512032D;
	Fri,  8 May 2026 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778207472; cv=none; b=esJ5FeS9DP9Q4+7RH1w9kH3GHtjRbrqwM++tqFEPvc4lI5ZjzcwA32iljutUVdQo5EN/aL7+Haijg+d2PgUxo3bxwwOBE2/utOqPqlKMbhOtjUJ/5oo26cYa5osHm8CyK2Nzq8xGJNjoRfKPjk3hXuus8xdh4r8yvSSPw7EgW54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778207472; c=relaxed/simple;
	bh=4hgc11Uo0aPk7n0C5XErVyPdWPcUwDSebmYa2bg/tVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f64LNsbacyzPs+gqL/1iwC+1Gw+1xQc+uDzMKAnw5ZTdSxNaAqZMcYhsSptxkZ5EP33LRbKB5UhM6USpaefvPB6P1pSKdIu9f5IeRQdvW/5JKK6qyFfxDn66NHhDtR/cY56QvaqlXWA+5ZFmBSpS8sXh2EnRykZ8dSngP1htioU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=Az8bmT74; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=rthU2BrXN03UHdxhSxsYA9rYzJBvBiU6k8p51/eN+i8=; 
	b=Az8bmT74krH/5JB+xCcCvjma53YNzn9JFRfxQRDTxsucevEB3iIIqFncqZlu/AtEe1znsuFQQ84
	GVRQ4PF+M1u4taU/DQr9OdZ2eKaOzw7DLvOfGpwsrN8cWhnek/J96lWCDQoV9oveN95EZIlBhuA5T
	3pZDbDMVdYA9hdZtN8dnOZa+xXh36/Rbh5BcomARHTV+ze5E/6Y7eyr01QBwyy6uelU1kZAZ3DuFu
	ax9Nxowo68TrjzHDiJ+wy2d2IK9CsmNw2EanNwLn5m98AQWGS309MmaXqqQ2l2T+4ktJ7Z+muKVGp
	Y3vFebzgZE5v670k+PBiDSKK3Xqm4LjQAuKg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wLAzR-00CH9L-2D;
	Fri, 08 May 2026 10:30:58 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 May 2026 10:30:57 +0800
Date: Fri, 8 May 2026 10:30:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aaron Esau <aaron1esau@gmail.com>
Cc: linux-crypto@vger.kernel.org, davem@davemloft.net,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: acomp - fix dst-folio branch setting src instead
 of dst in acomp_virt_to_sg
Message-ID: <af1K4d8cxGOvlJxY@gondor.apana.org.au>
References: <20260507233748.327004-1-aaron1esau@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507233748.327004-1-aaron1esau@gmail.com>
X-Rspamd-Queue-Id: 8FFB24F0DCA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-244656-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,apana.org.au:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:dkim]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 06:37:48PM -0500, Aaron Esau wrote:
>
> diff --git a/crypto/acompress.c b/crypto/acompress.c
> index f7a3fbe54..5a8b0cf3a 100644
> --- a/crypto/acompress.c
> +++ b/crypto/acompress.c
> @@ -237,7 +237,7 @@ static void acomp_virt_to_sg(struct acomp_req *req)
>  		sg_init_table(&state->dsg, 1);
>  		sg_set_page(&state->dsg, folio_page(folio, off / PAGE_SIZE),
>  			    dlen, off % PAGE_SIZE);
> -		acomp_request_set_src_sg(req, &state->dsg, dlen);
> +		acomp_request_set_dst_sg(req, &state->dsg, dlen);
>  	}
>  }

This patch doesn't apply against mainline.  In fact the code
that you're referencing does not exist on mainline.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

