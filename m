Return-Path: <stable+bounces-263020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U3aXCjZ5LWoMgwQAu9opvQ
	(envelope-from <stable+bounces-263020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 17:37:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D87067EF95
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 17:37:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=N4MmU8ye;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263020-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263020-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 866D43052E6F
	for <lists+stable@lfdr.de>; Sat, 13 Jun 2026 15:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678253FA5F7;
	Sat, 13 Jun 2026 15:37:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF33264F1
	for <stable@vger.kernel.org>; Sat, 13 Jun 2026 15:37:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365026; cv=none; b=gtAw1rBfgX9EoweD6Aa06Cwi87wsse2tWIJBf3eMs/lVkI68Jq2CtzaAkswoQ8PZQO4pP/iJPoTL4IKUx0wo6bB648fHPfHyoHB9pYPoC1+vabqDtovWWN+0pwSpXL3zv2MyAcYi/z3y8ukjjmywFN6uuHXalyO8rkrBZ4OS5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365026; c=relaxed/simple;
	bh=5qsifoWP8fmSJQM5dHwZSEdbauOe3h4dtgn+oQ6R7fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtaXJLEMKk0AlTpiXiBEYDRDK8Z/xE3uU662jwekdJXvj3Ygo23X4S1EB59YkHLuB3fqlPYUwxi+vfCH6UI44ic5GnkYvy1027QyCVwaRAT+McQS2aOK1/F9LjOY8/n6xDsif4E7IOXkXrNSAJoTFG8A5+dTl2Gb1aRfD6t6gRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N4MmU8ye; arc=none smtp.client-ip=95.215.58.174
Message-ID: <683801c1-23a7-424c-ac8d-12a24961088d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781365009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kAnta1paEwdFIQxih/xgWEJ4+KGJdhDjTjYkexN5zvo=;
	b=N4MmU8yeOUrd20h8DE2N3CrJynJuhtfy2OdKynqokByRbOz2lu15GrpNB3K1dOvVaJUE+N
	Z3cEr1BqUE2WZFHW+Wejet/iGlHgNbbc2zM60EMC7N9GfpAASmkSPZNWTVTRFoR4EeHDFJ
	ukvsUWELv05KfVVr/HIcMUzLDaYttmQ=
Date: Sat, 13 Jun 2026 23:33:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH v4 0/6] samples/damon: handle damon_{start,stop}()
 failures
To: SeongJae Park <sj@kernel.org>
Cc: "# 6 . 14 . x" <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260610135546.64943-1-sj@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260610135546.64943-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:akpm@linux-foundation.org,m:damon@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[zenghui.yu@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-263020-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghui.yu@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D87067EF95

On 6/10/26 9:55 PM, SeongJae Park wrote:
> All DAMON sample modules are not correctly handling failures from
> damon_start().  Among those, mtier also has an additional problem for
> handling of damon_stop() failures.  wsse and prcl also have a problem in
> their damon_call() failure handling.  As a result, memory leaks, next
> DAMON operation disruptions, and use-after-free can happen.  Fix those.
> 
> Note that only the damon_start() failure caused issues can reliably be
> reproduced.  Reproducing those issues require the admin permission,
> though.
> 
> Changes from RFC v3
> - RFC v3: https://lore.kernel.org/20260610011420.3018-1-sj@kernel.org
> - Add damon_Call() failure handling fixes for wsse and prcl.
> Changes from RFC v2
> - RFC v2: https://lore.kernel.org/20260609142119.68120-1-sj@kernel.org
> - Add damon_start() failure handling fixes for wsse and prcl.
> Changes from RFC v1
> - RFC v1: https://lore.kernel.org/20260609005443.2122-1-sj@kernel.org
> - Add damon_stop() failure handling fix to the series.
> 
> SeongJae Park (6):
>   samples/damon/wsse: handle damon_start() failure
>   samples/damon/prcl: handle damon_start() failure
>   samples/damon/mtier: handle damon_start() failure
>   samples/damon/mtier: handle damon_stop() failure
>   samples/damon/wsse: stop and free damon ctx when damon_call() fails
>   samples/damon/prcl: stop and free damon ctx when damon_call() fails
> 
>  samples/damon/mtier.c | 14 ++++++++++++--
>  samples/damon/prcl.c  | 11 +++++++++--
>  samples/damon/wsse.c  | 11 +++++++++--
>  3 files changed, 30 insertions(+), 6 deletions(-)

Looks good,

Reviewed-by: Zenghui Yu <zenghui.yu@linux.dev>

Thanks,
Zenghui

