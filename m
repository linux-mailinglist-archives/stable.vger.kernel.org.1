Return-Path: <stable+bounces-268674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D3GxFZOYPWrI4ggAu9opvQ
	(envelope-from <stable+bounces-268674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 23:07:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5D46C8AB4
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 23:07:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=tNo9mlwv;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268674-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268674-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 546F8302BE16
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7837267E;
	Thu, 25 Jun 2026 21:07:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850C8346E56;
	Thu, 25 Jun 2026 21:07:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782421647; cv=none; b=a+CvBnPEydCF4Aiywy/BFCjg670YesVfIpxMSxUinf7oE0W8D77gYea/7veFck0ZffTlHrTc+nmNy+AuHfpCsIrMQ2iz3JQBbdK75Kbq3WinGSiFHSdW1IZ/nr0JzriT78HzHE52tIWU91REG+k/UK+kIWimwr4EQnn/K0SYLV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782421647; c=relaxed/simple;
	bh=iW8j/hMTRdm3ei62TqTZ/oEHaBEmMC1qvSEVov4fR1I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DBBwO0qOi1p3+gR7RZ/1rILj7qGUXtz1n7hiyLU7JfqFYm084gbOq4QnpqwymOmrI4qrEbrNjFp+ZpUYfRJkqdaFsOQCmJIJGwPZKj69jEBirnAq3SQOh+af+fdx9q3EvDDZVT2DitTWNMU9/KcY44tPpHWboNniiVSkkoyVYXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tNo9mlwv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89AD1F000E9;
	Thu, 25 Jun 2026 21:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782421646;
	bh=XCf31iXVjV/xmKk4RzROAt3XMkVH30g6uJirV06m81Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=tNo9mlwvZrMW09CQHCsb1IqYR+uR1kIeFNoUrsmo9Zt2VKQXPUkk/Hn9oMr3EkDi9
	 kB1its+rg+gu3WKtHfTJjhW8G0dmcMuqT4p8sqcVYm+UrUDoQIhKjUrtyIFoVf6+1/
	 o4x58Mc4ANn9xd6n5H31c7cqP4+ToM4YN+XhTnqg=
Date: Thu, 25 Jun 2026 14:07:25 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: richard.weiyang@gmail.com, david@kernel.org, balbirs@nvidia.com,
 ljs@kernel.org, riel@surriel.com, liam@infradead.org, vbabka@kernel.org,
 harry@kernel.org, jannh@google.com, ziy@nvidia.com, sj@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-Id: <20260625140725.15fdfe5a48b6d7f0d667c948@linux-foundation.org>
In-Reply-To: <20260625114235.40611-1-lance.yang@linux.dev>
References: <20260624085756.6598-1-lance.yang@linux.dev>
	<20260625114235.40611-1-lance.yang@linux.dev>
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
	FORGED_RECIPIENTS(0.00)[m:lance.yang@linux.dev,m:richard.weiyang@gmail.com,m:david@kernel.org,m:balbirs@nvidia.com,m:ljs@kernel.org,m:riel@surriel.com,m:liam@infradead.org,m:vbabka@kernel.org,m:harry@kernel.org,m:jannh@google.com,m:ziy@nvidia.com,m:sj@kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:richardweiyang@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268674-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	DMARC_NA(0.00)[linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,nvidia.com,surriel.com,infradead.org,google.com,kvack.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:mid,linux-foundation.org:from_mime,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC5D46C8AB4

On Thu, 25 Jun 2026 19:42:35 +0800 Lance Yang <lance.yang@linux.dev> wrote:

> >Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
> >
> >as well?
> 
> No need to resend. I think Andrew can add this when applying :)

I managed.

Thanks, I'll queue this as a hotfix.  Somewhat tentatively - it's
unclear whether we'll be seeing a v2?


