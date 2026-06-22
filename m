Return-Path: <stable+bounces-267816-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nr80JVy8OWoiwwcAu9opvQ
	(envelope-from <stable+bounces-267816-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 00:51:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0186B2B54
	for <lists+stable@lfdr.de>; Tue, 23 Jun 2026 00:51:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=i-love.sakura.ne.jp (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267816-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267816-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80B7C302528A
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4E837AA7F;
	Mon, 22 Jun 2026 22:51:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341B436606B;
	Mon, 22 Jun 2026 22:50:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782168662; cv=none; b=seC9QbbepBx3DTSNmmPrJJHOTyeWZ4tA/N2M8jbWqI5pCa4NwXk/udSmlQJopvhQLoCuMz6ym3GnuWQYH13VJdXq4ir3l7+TIi1EWcAGDaST5WVkqbnkPIM1H/H+nJOrC+s6426MhhSIwhjwXHvOTUBbZVnqC7Vc5cTm9OIdiIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782168662; c=relaxed/simple;
	bh=rnT96qVqQg7ABIMSKNyGXskW+j2yYZzvm0HmE4v8Gow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cq6rNbrdahhWN/VxougMt9yVtHoPiq3iGCCkrQAB8j21f33/rYo3W+54btZMTCFhNLKK5wLDotQhDkGObW4f+XpRxGOSy0uKwD9ZPs1fFbkDlt/2IFjrXLFhRRyUcci92+09nJBF7t5B1oKUBSyJI+cJJbDLodftd+fZZwhsuyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 65MMoasU052557;
	Tue, 23 Jun 2026 07:50:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 65MMoZsx052553
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 23 Jun 2026 07:50:36 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <a9388816-e934-45d0-bfc5-8a40418d4adf@I-love.SAKURA.ne.jp>
Date: Tue, 23 Jun 2026 07:50:36 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] profiling: don't free prof_cpu_mask on init failure
To: Tristan Madani <tristmd@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
References: <20260622000022.3375262-1-tristmd@gmail.com>
 <fb12bd4b-58e0-4d78-a725-7e2d44b6350c@I-love.SAKURA.ne.jp>
 <178215292501.1603617.6905680542049189509@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <178215292501.1603617.6905680542049189509@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav104.rs.sakura.ne.jp
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[i-love.sakura.ne.jp : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267816-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tristmd@gmail.com,m:akpm@linux-foundation.org,m:dave@linux.vnet.ibm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	FORGED_SENDER(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DA0186B2B54

On 2026/06/23 3:28, Tristan Madani wrote:
> I went with the minimal fix you suggested since 7c51f7bbf057 touches
> two files and adds serialization, which felt heavier for a stable
> backport.

OK.

> 
> Would a v3 with the corrected Fixes tag and a note explaining the
> choice over 7c51f7bbf057 work, or would you prefer to just Cc stable
> on your commit?

Just as you like. I am not the person who makes decisions on for-stable-only
patches.


