Return-Path: <stable+bounces-240971-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGdMJIh262kQNAAAu9opvQ
	(envelope-from <stable+bounces-240971-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:56:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3581045FDC8
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8007A3006699
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE473DA7C6;
	Fri, 24 Apr 2026 13:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tWKIRAk3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F431214813;
	Fri, 24 Apr 2026 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038979; cv=none; b=jGWNoC2X5fxlifvvmMkMXOr6+Sa0TihFVR/MNsRMw7ArW8w8LSgFLhCUs0wOB0twKuIrypkWax/VPZEtnEYc/9oFlZS+MCwkklxFVrawfck4opzktF8HIm5czeHVy0SZsi/+fiR4Cw0P0NE9ehROcb/pN73geQ7aV4JSsfuK0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038979; c=relaxed/simple;
	bh=ChyUBkH34s7FeI8qgas9yFITZwgMiabL3SZHFnWYILE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aqgtqU7RV6QBAiDhQXlcEH2RFHNz9pk1WYAijyMw5vwR3GASHt60sdPFV5BXrpBHVJl85ywy7bDcVy0mm4OnzYClQ2LWayRNNUTKj3dbqWy9AtjeOGPTBh5sS9ln/VWsiLbvmzJQ9iU/5xxL2qDOUur752gyY1Bo0jhZrWrzfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tWKIRAk3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BB7C19425;
	Fri, 24 Apr 2026 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777038978;
	bh=ChyUBkH34s7FeI8qgas9yFITZwgMiabL3SZHFnWYILE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tWKIRAk3owCEWZorPHdqK5zTy/FQwaqxjq365RJkDdcfwpcqabpAt1Yr4kLsXU8FT
	 uYkiYJmlFLcMNFfsFmd4atsqFvS9zXPNphZ7uPYp8G6wcqaXe1DuKnkv9QI87dU0BC
	 kzoFM3cOse3Rrw5vfor2ChWhUhzkUWqyVa3CGVuU=
Date: Fri, 24 Apr 2026 06:56:17 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Marco Elver <elver@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>, Uladzislau Rezki
 <urezki@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, Vitaly Wool <vitaly.wool@konsulko.se>,
 stable@vger.kernel.org, "Harry Yoo (Oracle)" <harry@kernel.org>
Subject: Re: [PATCH] vmalloc: fix buffer overflow in vrealloc_node_align()
Message-Id: <20260424065617.5de5751ec5a5c91910d45a28@linux-foundation.org>
In-Reply-To: <20260420114805.3572606-2-elver@google.com>
References: <20260420114805.3572606-2-elver@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3581045FDC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240971-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,kvack.org,vger.kernel.org,googlegroups.com,konsulko.se];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]

On Mon, 20 Apr 2026 13:47:26 +0200 Marco Elver <elver@google.com> wrote:

> Commit 4c5d3365882d ("mm/vmalloc: allow to set node and align in
> vrealloc") added the ability to force a new allocation if the current
> pointer is on the wrong NUMA node, or if an alignment constraint is not
> met, even if the user is shrinking the allocation.
> 
> On this path (need_realloc), the code allocates a new object of 'size'
> bytes and then memcpy()s 'old_size' bytes into it. If the request is to
> shrink the object (size < old_size), this results in an out-of-bounds
> write on the new buffer.
> 
> Fix this by bounding the copy length by the new allocation size.

AI review is asking questions about the nearby code:
	https://sashiko.dev/#/patchset/20260420114805.3572606-2-elver@google.com

