Return-Path: <stable+bounces-273579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qdh4L8KJVGocnAMAu9opvQ
	(envelope-from <stable+bounces-273579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 08:46:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36734747A0A
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 08:46:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273579-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273579-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B2D9300CBD8
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 06:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E592FE07D;
	Mon, 13 Jul 2026 06:46:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FE17A300;
	Mon, 13 Jul 2026 06:46:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783925182; cv=none; b=RaPBZ5Ph0gEXeOdt9GCJj4SJZhzUVlgk/kUbWrYDXwKOphmg5ZL56PjYyOidxoZxeOruazMTp1sI2iYADPo598WnSnFlhNYLQpRJMCK9NYvyzSflnM/gn0bXeu4+ZK4DSHhP7hClkkhLn6RpgvWeQwqMePW86YiEVfkaS3Snvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783925182; c=relaxed/simple;
	bh=dFj4PXIWzhbmUJOFmzQNt1qgtQ8syeC3KliuYY5z/vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVMCenNngCeskcPYjlHrKpkPsoYNJFkzanCDnU8OSqOU7p8x62O6xWdQI+ciedHX+D10biLgwVQdOhcz9tpenqZgKLAyb+M8lcCCdRIyErPcn/rY2dTIcIHwnZopsDfJLrtlwmYBUdOT/lU6zXjsGObGMVv6yrLbR/bXeYQwYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92FDB68BFE; Mon, 13 Jul 2026 08:46:18 +0200 (CEST)
Date: Mon, 13 Jul 2026 08:46:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guanghui Yang <3497809730@qq.com>
Cc: linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] xfs: propagate errors from xfs_rtginode_load
Message-ID: <20260713064618.GG29416@lst.de>
References: <tencent_542687AA9C474951C4132E84DAED17622105@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_542687AA9C474951C4132E84DAED17622105@qq.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:3497809730@qq.com,m:linux-xfs@vger.kernel.org,m:cem@kernel.org,m:djwong@kernel.org,m:hch@lst.de,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273579-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:from_mime,lst.de:email,lst.de:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36734747A0A


Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


