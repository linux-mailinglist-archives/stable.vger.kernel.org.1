Return-Path: <stable+bounces-272773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hk80NoTzTmoGXgIAu9opvQ
	(envelope-from <stable+bounces-272773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:04:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 406E072B846
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:04:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=ReY8dtSC;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272773-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272773-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0846330B62A7
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 00:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC49390601;
	Thu,  9 Jul 2026 00:56:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9493911AD
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 00:56:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783558596; cv=none; b=PMg8rPdR/8eP9cj+YPqlyF4y9bAulIGQuN3loLi6O+qeoM1cY9gGAUFFrIiMrutQdmhtyYXQJkYwJ75dhlOFxROlvqaEHDGdAz2peIgt/k/447FfNVs3M+um6DrRJUrBQDD8p+MWDWjUjODC49lA3xAtjEsjGp6xzx5mfCyvqMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783558596; c=relaxed/simple;
	bh=QW4SY9Z/tGn1IPNVvL7G7PC98wn1mtgzpnrzSAfXEx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iqSBYlUW78RKuu3nCqM21PnsBpY4/mvBfo2v8GrUWGVZPUkqnxySd5r9oR7ZRjHAimgxdZLoPSsHGpFwR2/qwTzVTypah52rmBB+R+spl3siR3yhlwc9ZbuNjZQ8oxZ9VDzCeL3wDna9p3nQ8vSHpW3XuADEcQqk4r7ozGaXfkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ReY8dtSC; arc=none smtp.client-ip=95.215.58.187
Message-ID: <8f74de0a-4c86-4da9-ad1b-3f496d3ab733@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783558592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QW4SY9Z/tGn1IPNVvL7G7PC98wn1mtgzpnrzSAfXEx4=;
	b=ReY8dtSCkspGxZ1EJpSTPWaK+F/2B5C0ODBysqxbKXH+vvH+AXFB3TW5zeIYMmj/NyL39w
	CBqzyLzl3gk3EQwZ0T+11DIsHmqRSwXb39b6NBJDiylvSESTKetbLGFFawc4ezjrrNlK/m
	nvdf44pCn4oHTkdIL2vpmZjbpDcZJTI=
Date: Thu, 9 Jul 2026 08:56:13 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 5.15.y 6.1.y 6.6.y 1/1] mm/vmscan: flush deferred TLB
 before freeing large folios
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 linux-mm@kvack.org
Cc: jiayuan.chen@shopee.com, yingfu.zhou@shopee.com, willy@infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Huang Ying
 <ying.huang@intel.com>, linux-kernel@vger.kernel.org
References: <20260708041237.289026-2-jiayuan.chen@linux.dev>
 <20260708120502.agent5-0002@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260708120502.agent5-0002@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272773-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:stable@vger.kernel.org,m:linux-mm@kvack.org,m:jiayuan.chen@shopee.com,m:yingfu.zhou@shopee.com,m:willy@infradead.org,m:akpm@linux-foundation.org,m:ying.huang@intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 406E072B846


On 7/9/26 12:18 AM, Sasha Levin wrote:
> On Wed, Jul 08, 2026 at 12:12:36PM +0800, Jiayuan Chen wrote:
>> Flush the deferred batch before freeing a large folio inline, the same way
>> the order-0 path already waits for the flush.
> Queued for 6.6 and 6.1 with Matthew's Reviewed-by added, thanks.


Thanks Sasha.


>> destroy_compound_page was recently renamed to destroy_large_folio.
>> So it would be conflict when this patch was applied to 5.15/6.1
> It actually applied cleanly to the current 6.1.y (that tree already
> uses folio_test_large()/destroy_large_folio() there), but it does not
> apply to 5.15.y, which is still page-based
> (PageTransHuge()/destroy_compound_page()). Could you send a tested
> per-branch version for 5.15.y? 5.10.y has the identical vulnerable code
> shape, so a 5.10.y version would be welcome as well.


I will try to reproduce and fix in 5.15 and 5.10.


