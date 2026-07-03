Return-Path: <stable+bounces-271755-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TQTpGAOuR2qOdQAAu9opvQ
	(envelope-from <stable+bounces-271755-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 14:41:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D357702702
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 14:41:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=lGEn1QW0;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271755-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271755-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B37623044A4F
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F383DD870;
	Fri,  3 Jul 2026 12:32:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A33DD536
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 12:32:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081979; cv=none; b=od3J9swsFc4wEgOs4iLnlavY9JA/OU4ENg3mVU0xT3tcahknkln/ljsjSylDS1uQlD3HCqdw/P2ed89S+xVO7eS1OjglU6VvlB1pu59DDuE/jOnHoBOL/z4C5iqmQY45gRsLF5QAo08sMy+u3GgrsEoy1JDi5ryEN7XtZJOeIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081979; c=relaxed/simple;
	bh=nmZA6+uB3urD2hKCpKw8hiD4oFjQ9dwF7f3r4Tfky8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIt+6vncFDo4BSDrO7SBgxxVHNu52mcfAZGxhfIb/5TxO+a64rZxcCqQuacVnnZ8m7gU+wAyIfJP2CiKke8AYCsXPhoakb6ZUD19tPJHdVC7UHwJo+Q53Cx0GG2LL+Cx7VIJ8U/zoqhtkgx+D7OJiMSQ67G65+CabOYAd7+v7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lGEn1QW0; arc=none smtp.client-ip=91.218.175.171
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783081964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPobOMpzLXIZ6h+MVV8WTmoa13pxNOpbezeoUAZoB28=;
	b=lGEn1QW0L8yjWbmvygdeC/+JFPmdBuDOtLNHL0GwaV3OabcFTtTB7N57JCebnvsxY5f11U
	JxPftL4Si3/LLOk4OVjNnBewAIQz2oL3dsHYRBTXUfkxsTC1OhC05Y7sLk10yR3fUokWTH
	pa9kLdLXv25oUUqe2O91ufSHmFeBjV8=
From: Usama Arif <usama.arif@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.18 044/108] block: invalidate cached plug timestamp after task switch
Date: Fri,  3 Jul 2026 05:32:35 -0700
Message-ID: <20260703123236.3139759-1-usama.arif@linux.dev>
In-Reply-To: <20260702155113.020016705@linuxfoundation.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271755-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:usama.arif@linux.dev,m:stable@vger.kernel.org,m:patches@lists.linux.dev,m:axboe@kernel.dk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,linuxfoundation.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D357702702

On Thu,  2 Jul 2026 18:20:41 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> 6.18-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Usama Arif <usama.arif@linux.dev>
> 
> commit fad156c2af227f42ca796cbb20ddc354a6dd9932 upstream.
> 
> blk_time_get_ns() caches ktime_get_ns() in current->plug->cur_ktime
> and marks the task with PF_BLOCK_TS. That cache is only valid while the
> task keeps running; if the task is switched out, wall-clock time
> advances and the cached value must not be reused when the task runs again.
> 


Hi Greg,

It looks like this patch was backported, but the preceding patch [1]
in the series was not bacported to the stable branches. Both this and its
prerequisite have the same Fixes tag.

Not having the prerequisite will result in a NULL derefernce.
Could we please add [1] to the stable branches?

Thanks!

[1] https://lore.kernel.org/all/20260616141604.328820-2-usama.arif@linux.dev/ 

