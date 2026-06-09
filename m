Return-Path: <stable+bounces-262318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1cbqBRk5KGq0AQMAu9opvQ
	(envelope-from <stable+bounces-262318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 18:02:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55295662184
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 18:02:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=q3AXpyJY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262318-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262318-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9F7A307536D
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B02F49253B;
	Tue,  9 Jun 2026 15:50:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE90F35A952
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 15:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020241; cv=none; b=eZBsk2YFZC5vmiQG5ZciR6peG3dc1fkGpqG6CwjIjgXZQUf2Ijnr7bZxr8MrSFhClC/5++0Sg1IXdFYYBahma/wZxwRZIyWbK3DPnU1cDHrFROWvksH9WiXId9uv3ud6DamBudP4sVaeB+AN1ODFVJheENGB5reP8kDqGn3CZW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020241; c=relaxed/simple;
	bh=Xqrqdax3GvTji0D3s2oXp61F4Ax/hXxDzkBP9MuGAy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2s0OVEzMcA/Ui4sRJtwEmMAE/0itBrLRZbi6oO7jxTPHJUQXx+6GNreFZieQo9ziUbAKBeG793/9px8Ikbno/BVo5d1nnN8kZMFerGiMHGAruawmyiB7Mpuf5uWNpLQE1lhUjoqd/0xySPDaz6hEAYEs5fXrYpOMPmTGuklDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q3AXpyJY; arc=none smtp.client-ip=91.218.175.174
Message-ID: <ed2a595e-bcc4-4af9-99b0-4029f2a13476@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781020227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+6fcZSlWOlBCUqWc42EMaBGgUkNT9qApX3XmRXZGo4=;
	b=q3AXpyJYO06/Xzod4bGBw+cxyrlUjodg9xT2dpSd3ijWO8Hh2CTigI8fxhDNAvpIkDvNXK
	kJ6gBlfAJ11djJYYupjiyZ7pszRj9GhYrxI/76L6LIVaq4wYYK8F2zE3KXhdjyXEDwG3fu
	6wTG2CLRA1CYjTYyDwxdj/y50erOyN8=
Date: Tue, 9 Jun 2026 23:49:07 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] samples/damon/mtier: fail early if address range
 parameters are invalid
To: SeongJae Park <sj@kernel.org>
Cc: Zenghui Yu <yuzenghui@huawei.com>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 wangzhigang17@huawei.com, liqiqi23@huawei.com, stable@vger.kernel.org
References: <20260609144918.69429-1-sj@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20260609144918.69429-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:sj@kernel.org,m:yuzenghui@huawei.com,m:damon@lists.linux.dev,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:akpm@linux-foundation.org,m:wangzhigang17@huawei.com,m:liqiqi23@huawei.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zenghui.yu@linux.dev,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	TAGGED_FROM(0.00)[bounces-262318-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zenghui.yu@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55295662184

Hi SeongJae,

On 6/9/26 10:49 PM, SeongJae Park wrote:
> 
> I think this deserves Fixes: and Cc: stable, like below.
> 
> Fixes: 82a08bde3cf7 ("samples/damon: implement a DAMON module for memory tiering")
> Cc: <stable@vger.kernel.org> # 6.16.x
> 
> Other than that, looks good to me.
> 
> Reviewed-by: SeongJae Park <sj@kernel.org>

Thanks!

> 
> I applied  this patch to damon/next [1] tree.  We are now quite close to next
> merge window.  We (mm community) want to focus on making mm.git more stabilized
> and therefore ready for the next merge window, rather than adding more changes
> that are not really urgent.  I understand this series is not really urgent,
> because it is causing only DAMON internal weird behavior and one time warning
> on debug kernels.

Yup!

> 
> Hence, Andrew might not add this patch until next -rc1 release.  In the case, I
> will request adding this to mm.git after next -rc1 release.  So, no action from
> your side is needed for now.  Let me know if you think this is really urgent or
> I'm missing something.

I agree with you that this is not urgent and can wait for the next -rc1.

Thanks,
Zenghui

