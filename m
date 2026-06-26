Return-Path: <stable+bounces-269234-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lg7HJ6atPmqOKAkAu9opvQ
	(envelope-from <stable+bounces-269234-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:49:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E866CF40C
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 18:49:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=n1iuLFxp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269234-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-269234-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D44873006114
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15C63FD943;
	Fri, 26 Jun 2026 16:49:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C7F3DB62F
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:49:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782492580; cv=none; b=MQdY3wabZRN3uaW6YKUnfD21EQN6jPwQe1vXMeQz2stuCd2ut7YjgDae16tiuKX31V2Z3yzsXBcS4oRea+dIE3JidHNUUUD4NGCYQLrPcnnZ/D4iBj0O/2EzNV7QXj3GNUOt0XY3FFiCy5QUwJmy+kSB90pR6Kz+LE12x7k+GUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782492580; c=relaxed/simple;
	bh=LHtnHVcHvaGJI0X6HGdEp2HjguFCMl0poNtw25Olve4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VyJ0ZrqfQidGaawkIyrME+w+pepTDFZNHnBJjhl8cRZcwN6mdztMKAGOqKRwVljfbM8BEL/cB8j/6ug0wVt80xSDGgZz5kdv0mazKP9Uf93P9KpJ1ksPqgLgKRkHW8SEGpRFJ48bybM8rFFPM3q/6y0ZSTFEGLcz/fLK7hQcSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=n1iuLFxp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E5C1F000E9;
	Fri, 26 Jun 2026 16:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782492579;
	bh=LHtnHVcHvaGJI0X6HGdEp2HjguFCMl0poNtw25Olve4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n1iuLFxpMtpGE5mv8i8CbeL0peisfF6NQmwEapcRmoyn0NuxB0bkwUhVHqK4zw0Kc
	 kzDG9Vks90pZFG9J/viaaKHaR+dB7b4qEEs7jEbvnxYjofzrjzupYGHE8osL4cs5UY
	 RBzWLiqn1cUux1NGfJd6Wio3AfOhlTwQjtlAH8nA=
Date: Fri, 26 Jun 2026 09:49:38 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, "Liam R. Howlett" <liam@infradead.org>, Alice Ryhl
 <aliceryhl@google.com>, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: fix CONFIG_STACK_GROWSUP typo in
 tools/testing/vma/include/dup.h
Message-Id: <20260626094938.a28667d2aa090fdb6ad204aa@linux-foundation.org>
In-Reply-To: <aj5qnsGDPC3nREdT@lucifer>
References: <20260611012258.432043-1-enelsonmoore@gmail.com>
	<aj5qnsGDPC3nREdT@lucifer>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-269234-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,google.com,suse.de,infradead.org,kvack.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ljs@kernel.org,m:enelsonmoore@gmail.com,m:vbabka@kernel.org,m:jannh@google.com,m:pfalcato@suse.de,m:liam@infradead.org,m:aliceryhl@google.com,m:linux-mm@kvack.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:mid,linux-foundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42E866CF40C

On Fri, 26 Jun 2026 13:06:23 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> So drop both Fixes, and the Cc: stable please as per David (Andrew - can
> you make that change? Thanks!)

Done, thanks.



