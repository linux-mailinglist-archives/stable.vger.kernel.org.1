Return-Path: <stable+bounces-223395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHHMDNdbq2nTcQEAu9opvQ
	(envelope-from <stable+bounces-223395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 23:57:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC93228713
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 23:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DFF3300846E
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 22:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED56535F606;
	Fri,  6 Mar 2026 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rQU6mmxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05E93537CF;
	Fri,  6 Mar 2026 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772837841; cv=none; b=rzrl5avIkZTCZya/8E9YTr9qta72114nv1obEpw+iSbu0GFVdZmDIIz22cLuLcFjS5yha2sOSagwDvKwLoKlMI4H2RzQo1cuZ9T6PuC9Ew1G/bwYd7U0knk9kMHdN0UXGabW/l9kBjHKQcTJ/DofhAzSWH3mZglW6g0GE/xwJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772837841; c=relaxed/simple;
	bh=+UpDJ8R8P09+MTeCv2vqlFR2qoA2D9Oi9pY9w7S2NpM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fwEwM044mEknpEeNe8pY9GSlpRmks1P/f/BV70iAvQs2sWqhixYHGpiq+uhJ42UD8/6z3Fsm3d/JK1uly/L9qmXjvgIa4J3Y7UjT75YbgrlD5N1uZSQkLV5fm73heGFIG7/z7X6RSCStFnJ3bAwDc4e1MXT0O3KRnhLib8IUKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rQU6mmxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A959C4CEF7;
	Fri,  6 Mar 2026 22:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772837841;
	bh=+UpDJ8R8P09+MTeCv2vqlFR2qoA2D9Oi9pY9w7S2NpM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rQU6mmxZ5Jx7rNAFejrpaxCnUme6UV8ASDx6caVu2UEP2Z5rvv8f8noKKML98jSYW
	 gLPBxBg3xU8hRkRMUlNTucpcKCuIMcsT4FuxToJfCoZ53Ugt4Yimi9tEFEOS8zJFlg
	 FAK+BOgor9qTaGFy4UZVgKNV5kmZQ1SfXEk7+BT4=
Date: Fri, 6 Mar 2026 14:57:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Liam Howlett <liam.howlett@oracle.com>, Matthew Wilcox
 <willy@infradead.org>, Alice Ryhl <aliceryhl@google.com>, Andrew Ballance
 <andrewjballance@gmail.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Josh Law <objecting@objecting.org>
Subject: Re: [PATCH v2] lib/maple_tree: fix swapped arguments in
 mas_safe_pivot() call
Message-Id: <20260306145720.e8b6afd26aeb9b5caa277026@linux-foundation.org>
In-Reply-To: <20260306223219.2824040-1-objecting@objecting.org>
References: <20260306223219.2824040-1-objecting@objecting.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4DC93228713
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223395-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[oracle.com,infradead.org,google.com,gmail.com,vger.kernel.org,objecting.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.968];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:mid]
X-Rspamd-Action: no action

On Fri,  6 Mar 2026 22:32:19 +0000 Josh Law <hlcj1234567@gmail.com> wrote:

> From: Josh Law <objecting@objecting.org>
> 
> The call to mas_safe_pivot() in mas_wr_extend_null() has the pivot index
> and maple type arguments swapped. The function signature expects
> (mas, pivots, piv, type) but the call passes (mas, pivots, type, piv).
> 
> This causes the pivot index to be interpreted as a maple node type and
> vice versa, leading to incorrect pivot lookups. In practice, this means
> a null-extending store into a maple tree node can read the wrong pivot
> value, potentially corrupting the range tracked by the maple state. For
> a VMA maple tree, this could cause an incorrect vm_area_struct range to
> be returned during operations like mmap or munmap, leading to silent
> memory mapping corruption.
> 
> Every other mas_safe_pivot() call site in the file passes the arguments
> in the correct (piv, type) order; this is the only one with them
> reversed.

This all appears to be identical to v1?

> Link: https://lkml.kernel.org/r/20260306200820.2819999-1-objecting@objecting.org
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Josh Law <objecting@objecting.org>
> Cc: stable@vger.kernel.org
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andrew Ballance <andrewjballance@gmail.com>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---

Right here after the --- is where people add their
what-i-changed-since-last time notes.

>  lib/maple_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


