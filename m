Return-Path: <stable+bounces-274727-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UoLFHp8QV2o1EwEAu9opvQ
	(envelope-from <stable+bounces-274727-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:46:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C257175A826
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:46:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=q4O8mCN2;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274727-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274727-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A627304A8F8
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 04:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385A3A987B;
	Wed, 15 Jul 2026 04:46:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C275188596;
	Wed, 15 Jul 2026 04:46:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784090766; cv=none; b=HXVId/nvYSwSWGGpV/+o3uGoESD/C27MNNxdfkuqY6ws6yhfseEq8ZhN/zx/DiGQnux+qYwVcKu8EJz5Fxj261XWtSqiiQ2qrHyXRP29vMHdY88HKnRysfOhVDKisDp9oj+Ypo1620LHBEip5SqeW4TDEsrFK1ZrU2YGKT1rhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784090766; c=relaxed/simple;
	bh=EQs7O/KsN/wK8A+H5ZylPYHQYmQjSimXgQsiXtNU6b4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D4HdSRmT4+uQIg4gZI9jlolevr0P0aUDkHAL4tnl1yrq1TSIvA3mYBzabCsQ934t7BgqPmS21B7pWCOZQDo26Ya5dT1586YSEYH+hc1Pd8FVnT3o0S1WmjPQgc6UTXyCPEMS9GNbzT+gLhMtFv0Y28K9Rr/YXI217Eiss6+X/zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=q4O8mCN2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0311F000E9;
	Wed, 15 Jul 2026 04:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784090765;
	bh=yPSXgtZyZUjPzhY0+tGPbfG3fWnFA8alzR4dcKz8MY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=q4O8mCN2Wldnjn2dROG4NkiHVkge2rzmi9u30M/YOygz85Hzobi2j0PY1EBOS2f75
	 vi70A6NF+w51j7g7FpFqmM30I7/b33bWqJk8/OxKpLUoeJsckqqCxZDh9FyRENit/G
	 2LV3lx5ZSMX8q/wLIeXQU3jBZd3EuN/KTX5kh49I=
Date: Tue, 14 Jul 2026 21:46:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@davidgow.net>, Fernand Sieber <sieberf@amazon.com>,
 Leonard Foerster <foersleo@amazon.de>, Quanmin Yan
 <yanquanmin1@huawei.com>, SeongJae Park <sjpark@amazon.de>, Shakeel Butt
 <shakeel.butt@linux.dev>, damon@lists.linux.dev,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1.1 0/6] mm/damon: unurgent fixes for infinite loop,
 NULL de-ref and races
Message-Id: <20260714214604.10fc4c786277eaed523d0724@linux-foundation.org>
In-Reply-To: <20260715031002.108504-1-sj@kernel.org>
References: <20260715031002.108504-1-sj@kernel.org>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:stable@vger.kernel.org,m:brendan.higgins@linux.dev,m:davidgow@davidgow.net,m:sieberf@amazon.com,m:foersleo@amazon.de,m:yanquanmin1@huawei.com,m:sjpark@amazon.de,m:shakeel.butt@linux.dev,m:damon@lists.linux.dev,m:kunit-dev@googlegroups.com,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-mm@kvack.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274727-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C257175A826

On Tue, 14 Jul 2026 20:09:55 -0700 SJ Park <sj@kernel.org> wrote:

> Sashiko found a few issues in DAMON that could cause infinite loop, NULL
> dereference and monitoring results degradation.  The first two sounds
> scary but the infinite loop happens only under unreasonable user setup.
> The NULL dereference is only in a unit test.  Monitoring results
> degradation is trivial since it is only best-effort, and those happens
> from only unlikely races.  Still those are bugs that better to fix if
> possible. Fix those.

> Subject: [PATCH v1.1 0/6] ...

So... what is the significance of "1.1" here?

