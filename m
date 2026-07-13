Return-Path: <stable+bounces-273995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M2C5HMJLVWoQmgAAu9opvQ
	(envelope-from <stable+bounces-273995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 22:34:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1364874F10B
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 22:34:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OGx4t0sO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273995-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-273995-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0E79301092F
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 20:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD34035C1A1;
	Mon, 13 Jul 2026 20:34:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E834DB74
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 20:34:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974848; cv=none; b=CsfuJnmmH0TejsM3WE3OZ8E8eWDlIGx3VOt8fYkY5lGZteihR5CeE6Ae81E26+1yyR3DHj4hWp6CJZwLjL2YSuuSJeeJPiUgl5k+MbQRkTDqo4hNavoSCvedkBRwSK9E7xu6B2SoyObJn9RPocuW2ZQChg4Qch75ljKVvG/sFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974848; c=relaxed/simple;
	bh=bIN1WVwlJsIk3XUFK6DVhfVx5Wq6A7sl0kQ0alXHYlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ksMGp//zEwxz4T+9SSjigXwVaUso9e5zisQYx9vYMUN4ShT4JUpWftvcyeW7UKNCRDKq05NPPH6jd+zlBH1optGvT6rCa++qr4Svul1fIzsOBBJaKeHsT0Zt1ZEGprk2RmOJe+UEWQGKcGWOrkyFwLYvpVwo5G8ao9NcVDBS2Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGx4t0sO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982F21F000E9;
	Mon, 13 Jul 2026 20:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783974847;
	bh=+gFjaJaBNq9lBRWf9QpaDh44lEpy7F8oLdWT0GazOIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OGx4t0sOyfjHCNVWtthCkVdxzn6CAY3nvonyNxBUPf3t7ofkwX5K6gR0biZbQnWpW
	 4oZR2pMFw2Flf+Opq6VvTIeKgEbDD7+Un5Ed8FzD76yKBiqpx3jSnt3tRfeHW5YMG8
	 MuPy/iWWcE19bmrq3OmB24C3iTQqZZrFhfpJcWRFm+es+R6ulLxwmM0KmNhWwY05yX
	 1YLjZv+pTfqlGhW0sRv320oeKV8uNm4fLrrHa1T+bmkYbQh9erHfNTVtbA+HaU5qXu
	 eLIAcy3qS8dAXQ970b3NlOSx4UV4y2OzVGjPNRaqMNF1QnGbfi8A67n3HK5QY6TNpv
	 v6fRmdiUREhIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	almaz.alexandrovich@paragon-software.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	Sudheendra Sampath <giveback4fun@gmail.com>
Subject: Re: [PATCH 5.15.y] fs/ntfs3: Change new sparse cluster processing
Date: Mon, 13 Jul 2026 16:34:01 -0400
Message-ID: <20260713131907.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713054907.1262553-1-giveback4fun@gmail.com>
References: <20260713054907.1262553-1-giveback4fun@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273995-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,paragon-software.com,linuxfoundation.org,brighamcampbell.com,xs4all.nl,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:almaz.alexandrovich@paragon-software.com,m:skhan@linuxfoundation.org,m:me@brighamcampbell.com,m:jkoolstra@xs4all.nl,m:giveback4fun@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1364874F10B

> @@ -687,25 +604,11 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
>  			 */
>  			for (; vcn < cend; vcn += clen) {
>  				err = attr_data_get_block(ni, vcn, cend - vcn,
> -							  &lcn, &clen, &new);
> +							  &lcn, &clen, &new, false);
>  				if (err)
>  					goto out;
>  				if (!new || vcn >= vcn_v)
>  					continue;

This hunk removes ntfs_sparse_cluster() but doesn't add upstream's replacement:
a first loop that allocates with zero=true up to cend_v (the valid_size
boundary), followed by the zero=false loop for the rest.

-- 
Thanks,
Sasha

