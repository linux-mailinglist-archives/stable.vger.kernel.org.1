Return-Path: <stable+bounces-269764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pV+CKyB8QmpW8QkAu9opvQ
	(envelope-from <stable+bounces-269764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 16:07:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D036DBBE1
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 16:07:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=F4OwseFI;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269764-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269764-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76BBD315727B
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 13:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D0A226D05;
	Mon, 29 Jun 2026 13:41:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9BC2222C5;
	Mon, 29 Jun 2026 13:41:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740509; cv=none; b=a0rTUHlGBPEt0wfAu7JjC1w88LZqNJhna67Ysl86xIW1gS/POH232zdf33WUmiOs+2rDQowDDZ3S/hHJP6KvCdmtU8NqoTJy5sOmgSjDCRTxWWNi+qIU3WuJLYmjwnVU8NyEwlzrwdAA/CNlMaAjNQlggykJNdX+/nxIM2jCQpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740509; c=relaxed/simple;
	bh=/hZEURy9HjyqcqqFq73ZLo83nMLjQcbuy5GlFL8YSpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fglAkxC92/rsKWYCBql0UJKGX/x8Y1Ah4tsAoBxfalKY3CNOIrI+U1hb6MX3nc8H9EzVV0vnzutQChZftLO2oxXheCBvmKljdnwys/ytHi3kPgmz0HUQbZ1a2/UAfisxJshSBIA2cKruiZ3YH7Kxs5Plw6FEAqM6XWTibbX/wb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=F4OwseFI; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y49woqPm8tB8WLLWvn2nFdbqKXEKAzBZs8I2/c34JrI=; b=F4OwseFIEDLyWEU1hIkFs9OifA
	3UNFh+nRMAhcP+vDTdwV9v5aR+Wjs6fFeoVCV0aSNX9bzECTKfvkACLHV7/ZDnn6uR0AX4pxYV4eb
	t2DabiF7+Uy5+mp2kSvgWtJRfSOC3ce7XmL/U2feUFwM3lhImSpPUy3WsLlb3ZlPYY94Tjq0KbEQC
	CLQY3aURHUC9ZxXC2OPzXv/zux43ScfoDlcTIYcD5xYwl6z1QFaSjmrKyFA5hm48htJmp1oXNcnf2
	Qe1w3UQ0+NJ4j+Cr4/NA3dhUBbfgaQw/Pqzd0nNpIBnWI2pRlWtBRSiQUR4x9eUlvBTNBB0YW32nB
	SqdcUnKA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weCF4-006KaG-0l;
	Mon, 29 Jun 2026 13:41:42 +0000
Date: Mon, 29 Jun 2026 06:41:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Bradley Morgan <include@grrlz.net>
Cc: akpm@linux-foundation.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] lib/bootconfig: fix undefined behavior involving NULL
 pointer arithmetic
Message-ID: <akJ0f2gsiEt01spu@gmail.com>
References: <20260628115617.3190-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628115617.3190-1-include@grrlz.net>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:include@grrlz.net,m:akpm@linux-foundation.org,m:mhiramat@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-269764-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03D036DBBE1

On Sun, Jun 28, 2026 at 11:56:16AM +0000, Bradley Morgan wrote:
> When xbc_snprint_cmdline() is called during the size-probing phase
> (with buf = NULL and size = 0), the function computes the end pointer
> as 'buf + size' (NULL + 0) and repeatedly advances the pointer via
> 'buf += ret'.
> 
> Under the C standard, performing pointer arithmetic on a NULL pointer is
> undefined behavior. While harmless inside the kernel, this code is also
> compiled into the userspace host tool 'tools/bootconfig', where host
> compilers with UBSan or FORTIFY_SOURCE enabled abort the build when they
> detect NULL pointer arithmetic.
> 
> Fix this by tracking the running written length as an integer offset
> ('len') rather than advancing 'buf' directly. Only perform pointer
> arithmetic if 'buf' is actually non-NULL.
> 
> Fixes: 5a643e462323 ("bootconfig: move xbc_snprint_cmdline() to lib/bootconfig.c")

Isn't commit 5a643e462323 ("bootconfig: move xbc_snprint_cmdline() to
lib/bootconfig.c") just a code movement?

>  	xbc_node_for_each_key_value(root, knode, val) {
> @@ -439,10 +437,12 @@ int __init xbc_snprint_cmdline(char *buf, size_t size, struct xbc_node *root)
>  
>  		vnode = xbc_node_get_child(knode);
>  		if (!vnode) {
> -			ret = snprintf(buf, rest(buf, end), "%s ", xbc_namebuf);
> +			ret = snprintf(buf ? buf + len : NULL,
> +				       size > len ? size - len : 0,

Why not keeping rest() and updating it, instead of open coding it?

Thanks for the fix.
--breno

