Return-Path: <stable+bounces-271974-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QFVGKpIdSWr1yQAAu9opvQ
	(envelope-from <stable+bounces-271974-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 16:49:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F9707C85
	for <lists+stable@lfdr.de>; Sat, 04 Jul 2026 16:49:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=xpdf4EW1;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271974-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271974-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D014E300809B
	for <lists+stable@lfdr.de>; Sat,  4 Jul 2026 14:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2ED26E710;
	Sat,  4 Jul 2026 14:49:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2925A2B5
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 14:49:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783176580; cv=none; b=rDGklspiEYPG/nRJ0ilDerLO22B4NGHlFBBuLu3bIimZAszF93/WB1/yqVHRRRch67gRITTsOCubCsM4NVmft/6XFmvAAMu917BbiyZWQ/SQk/O1wdn8fpFqy8+E6tJiVkpaP9B4klkUSuV83wBLPzWDSKRKaybzCBKZdXXc1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783176580; c=relaxed/simple;
	bh=Y4WszYhVE/Fob4GoABh9lu4hyPP4923GPcHmmbETQOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+7r4Os39PVSC4HtvLgrAyimN0i6qnX5KEkn8y48ITSDS8GVbDAtnszqslO7IKVhvE55c2UxK+JHChGNEJvyn3AnsLzPfKJheiVAJhqqPzA++x0nQ4cMQ8ayKSY7/JIYDipAuvgRmLUrS/VwLxihGOc/V6XZNme1kc+kzhz9tsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xpdf4EW1; arc=none smtp.client-ip=95.215.58.179
Date: Sat, 4 Jul 2026 09:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783176566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQOtDnFjQPANSHnV8tBbe0M1MlY+ZRcnYotgj5bs1e8=;
	b=xpdf4EW1tjYGnfLvNeH/0v7a7QMnFqMhb8T+RHAqOkiLnSjRjGTsai3uppblFmBX5qe6SC
	cMjCWZGQUyd5cuQnDpylrA2pRzm7L4hceHi6mPYKzg9P3wiEHgQB52ZFsh1ogUCPjb2LDJ
	44bKG9IjByxmi0koiaYQpEweOMuk/BQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable@vger.kernel.org, Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH 6.12] bcachefs: avoid truncating fiemap extent length
Message-ID: <akkdYigsmB8tJf6T@shelob>
References: <20260703114813.113406-1-mdmitrichenko@astralinux.ru>
 <2026070315-stable-reply-0028@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026070315-stable-reply-0028@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:mdmitrichenko@astralinux.ru,m:linux-bcachefs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[kent.overstreet@linux.dev,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271974-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kent.overstreet@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shelob:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A08F9707C85

On Fri, Jul 03, 2026 at 10:05:22PM -0400, Sasha Levin wrote:
> On Thu, Jul 03, 2026 at 02:48:13PM +0300, Mikhail Dmitrichenko wrote:
> > No upstream commit exists for this patch.
> >
> > bkey sizes are stored in sectors as u32, while fiemap reports byte
> > lengths as u64. Shifting k.k->size before widening performs the
> > conversion in 32 bits, so an extent of 4 GiB or larger can wrap before
> > it is passed to fiemap_fill_next_extent().
> 
> Thanks for the patch, happy to take it if we can get an ack from the bcachefs
> maintainers.
> 
> -- 
> Thanks,
> Sasha

Ack

