Return-Path: <stable+bounces-268691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HysZHcTOPWqy6ggAu9opvQ
	(envelope-from <stable+bounces-268691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 02:58:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CBE6C959D
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 02:58:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=G6Hk0z2y;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268691-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268691-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087A13044094
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 00:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892E72BEC52;
	Fri, 26 Jun 2026 00:58:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECCD2BE026;
	Fri, 26 Jun 2026 00:58:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782435502; cv=none; b=PN59J2D3qZFA+/a0uCf0bc7jCYXu3o/C+U3mJlmTxjHhAcZ0hW1xqej8qB6gYVYjCzYz/8n7oPgmJ0N6EWQhY4KFtBc06MboTmwsqWhSi7f8mIEtbA9dMMrHCngTXUX04cggofYeC06c1ct+eqYpQjxXhBugESAnoWE+Oh0Yh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782435502; c=relaxed/simple;
	bh=jWLTZ/AXVNOgS6js3xuxXtAxE4a0xngRkEbgyFI0d2c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hV/TUQgyOAoQvxJ0/WtHwYSilSB5md33LLFXQiBc/I7HDdXKilknlUqurLAgds8Rn4z2FxWs2X0UT67R+mFS3oA1/9KRlHkln1iSMB7KP4Uevx7FO6SExSRh79I1PmI/+jewSE0vn9hZtukd4F1+ieI93rTiuR9H1WrS577IQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G6Hk0z2y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA5C1F000E9;
	Fri, 26 Jun 2026 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782435501;
	bh=TAkkL3sPm5ZfzdmjNmlGFuALBQCcFtDjbOh35GYhvNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G6Hk0z2ylq/Oy/aFJH+415QHc50i7/EYqo3wFynduArUqCpblGlirmquZkLrq10MR
	 I8AL3Vdu7/MaQPVyeo6ceuWiGIEwARnndQz4E/EbdM90ufIi2Nz/MhJD5da/cwD+Ve
	 3bsn8HctYrKuNFCbsfe7/CGUvVz5Klqt4L58aXiY=
Date: Thu, 25 Jun 2026 17:58:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Balbir Singh <balbirs@nvidia.com>, david@kernel.org, ljs@kernel.org,
 riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
 jannh@google.com, ziy@nvidia.com, sj@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Lance Yang
 <lance.yang@linux.dev>
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-Id: <20260625175820.cdc6716095c3355257726afe@linux-foundation.org>
In-Reply-To: <20260626004416.vm4funxhn42hbi3c@master>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
	<38410976-ddac-4848-a4ff-e6a9f7d9c828@nvidia.com>
	<20260626004416.vm4funxhn42hbi3c@master>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:richard.weiyang@gmail.com,m:balbirs@nvidia.com,m:david@kernel.org,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:ziy@nvidia.com,m:sj@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lance.yang@linux.dev,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-268691-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux-foundation.org:dkim,linux-foundation.org:mid,linux-foundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9CBE6C959D

On Fri, 26 Jun 2026 00:44:16 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> >Should be PVMW_MIGRATION and "us we do" -> "as we do"
> >
> 
> Hi, Balbir
> 
> Sorry for missing your comment.
> 
> Hmm... looks you are right.
> 
> Andrew,
> 
> Would you mind handling it or prefer a v2?

I have made those edits.

