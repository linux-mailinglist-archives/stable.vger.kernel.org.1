Return-Path: <stable+bounces-253644-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EtsEYKMD2oWNQYAu9opvQ
	(envelope-from <stable+bounces-253644-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:51:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A50CD5AC77A
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 00:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AA19303749B
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 22:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7631536604F;
	Thu, 21 May 2026 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omx52bTv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C52F3632;
	Thu, 21 May 2026 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779403862; cv=none; b=uDn7457n8iaz+toAvKs24NHFtaT7O3FZ1SvtMl5A6qjh0knX8ORiP5BruVsCjCOy7orGyOWQm9sEEGHcKPGZ71Rfp5rfKtMH2mmCpMWbwsE7q1X1QAaBcO8RpP5EIxotNFRyOygqDxQcA6u5RFQTvoAgfx0DtNhC+tAUCT5zuTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779403862; c=relaxed/simple;
	bh=E1rQoLyDWZQ8G6wbTgaRgLl2iqPjzbMspKatsIlFJOA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fhAh0ou7+MBQ8MNUNX1uIDlNVBmkRt/LLNLRoZhB4+TtnUMksKZt/sgrRuKUR0LKgSsMBLb9ehaC8bu//q6ZiYsWFFxprf7ZpjyqYuRXGZq/QYpFi5ukV2RHavUAUlAnbvcqnkqV/ornWSeYDdIdE/QnphSCjgr2P8daDZsUZQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omx52bTv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801711F000E9;
	Thu, 21 May 2026 22:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779403860;
	bh=WPWjKtDA7kQDjj6GVIm6c5sZdcY7OZ9bfxBSLXp/6JY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=Omx52bTv46z1LIS3lyH0XFiNG3p/8XF7Q3lFu9dPnmH3je16l9C1quavnLLlhXMJo
	 e+QmqmY4yC7HYsf2ij+z1RAi6YxKBgY9IxSZtQpxK7RrjGTa9z7ORPlw9dU11mHVcI
	 goSUlhrRHbJnjxPmaWHsVYy2Zh8X2xjpdhXck3F4M2KMWE5A7fdxOn7DI+7TJI+A0v
	 lcFgfuA2jPe68v4qs1KXKod4LW5DWj2hEp9b0lLDczrV5WsoH5+Nh0RKdjbZA3Y5kq
	 uOqGHswOIzABZppypN4cBAujhckNKBugJAVoKE6CKUgxMj5JN4ulfD2I0b2PmD+N/B
	 mqQIfNB3PlEuw==
Date: Thu, 21 May 2026 16:50:58 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Zishun Yi <vulab@iscas.ac.cn>
cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    alex@ghiti.fr, atish.patra@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] riscv: cacheinfo: Fix node reference leak in
 populate_cache_leaves
In-Reply-To: <20260509074040.1747800-1-vulab@iscas.ac.cn>
Message-ID: <58b50dc5-7307-c38d-3cdf-46343052bafe@kernel.org>
References: <20260509074040.1747800-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-253644-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pjw@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A50CD5AC77A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 9 May 2026, Zishun Yi wrote:

> Currently, the while loop drops the reference to prev in each iteration.
> If the loop terminates early due to a break, the final of_node_put(np)
> correctly drops the reference to the current node.
> 
> However, if the loop terminates naturally because np == NULL, calling
> of_node_put(np) is a no-op. This leaves the last valid node stored in
> prev without its reference dropped, resulting in a node reference leak.
> 
> Fix this by changing the final `of_node_put(np)` to `of_node_put(prev)`.
> 
> Fixes: 94f9bf118f1e ("RISC-V: Fix of_node_* refcount")
> Cc: stable@vger.kernel.org
> Assisted-by: Gemini:gemini-3.1-pro
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Thanks, queued for v7.1-rc.


- Paul

