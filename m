Return-Path: <stable+bounces-273318-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KRMzGgJYUWp5CwMAu9opvQ
	(envelope-from <stable+bounces-273318-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 22:37:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C296673E6AA
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 22:37:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=Qjt9Yomp;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273318-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273318-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 219883049E29
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 20:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A85386C0C;
	Fri, 10 Jul 2026 20:33:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF77336CDF3;
	Fri, 10 Jul 2026 20:33:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715637; cv=none; b=OmIi2ERucT4zViy/ouAsJ5SX3xkVfDYqXUcarOjbCNXpsPIOCF9RrWRImhdxYpNcJIM03q0y4SrdJHtjofsLSCFomGxyu7djBP0XnxS4o8ZegQPj9HXyIhYJnANBoH17FTdSPxECehtVn+AG0bhMf/sSnSihcUpw/Bai1U6fFSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715637; c=relaxed/simple;
	bh=38QLWyaFVLxKK7+i8qOQz0ABOCp8tWO1g5mU+E0Tt/4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IjQ7GKHPV8SpKnmaDlCW/RH5/3UUv0mswHpwT68hEBXto643GfevTwen98p49fOrNkb69SK7P0L/yJneYxUMBGP6W/Av5cQkZjY57dKP1B5pwFL+TgNki8wY21pIhy9Gi0+8SibxjPpU6WvmKpr4y6/MNGcSj7UyvnvbCU4LTYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qjt9Yomp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED6B1F000E9;
	Fri, 10 Jul 2026 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783715636;
	bh=5oGfM+FTjuYuVJad47F+GseYS0DI2Zhal3DsS17VUGs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qjt9YompLl+zWyjMTe4syXhCubhAV1r6+MW7I0iPnaQmpGVx1DrEHUOLPneYEQ3lg
	 I47RwVvpQ9AUvoqDIfI9ol22mHIVQcbqZMoKM60s46BJB/wtQj+0GE2iWFCOC8YHu+
	 W6GGCQHFWDPrmy7F16TVzGhkKHdjN/we75siVe6c=
Date: Fri, 10 Jul 2026 13:33:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, Joseph
 Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ocfs2: validate rl_used against rl_count in refcount
 block validator
Message-Id: <20260710133355.7c0b0d781d148f1262138902@linux-foundation.org>
In-Reply-To: <20260709132609.44233-1-security@auditcode.ai>
References: <20260709132609.44233-1-security@auditcode.ai>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:security@auditcode.ai,m:mark@fasheh.com,m:jlbec@evilplan.org,m:joseph.qi@linux.alibaba.com,m:ocfs2-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-273318-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:from_mime,linux-foundation.org:dkim,linux-foundation.org:mid,sashiko.dev:url,auditcode.ai:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C296673E6AA

On Thu,  9 Jul 2026 15:26:09 +0200 Ibrahim Hashimov <security@auditcode.ai> wrote:

> ocfs2_find_refcount_rec_in_rl() walks the on-disk refcount record
> array with:
> 
> 	for (; i < le16_to_cpu(rb->rf_records.rl_used); i++) {
> 		rec = &rb->rf_records.rl_recs[i];
> 		...
> 
> rl_recs[] lives in a single metadata block (4096 bytes on the common
> configuration), so its real capacity is fixed by
> ocfs2_refcount_recs_per_rb(sb) (247 records for a 4K block with the
> 16-byte ocfs2_refcount_rec). rl_used and rl_count are both read
> directly off disk by ocfs2_validate_refcount_block() and are never
> checked against that capacity, nor against each other, before any
> refcount/reflink/CoW operation walks the array.
> 
> A crafted (or corrupted) refcount block with rl_used == 0xffff makes
> the loop above walk far past the end of the block, dereferencing
> rl_recs[i] for i up to 65534. The resulting index is then handed to
> the sibling ocfs2_insert_refcount_rec(), whose insert-shift does:
> 
> ...
>
> Add the equivalent pair of checks to ocfs2_validate_refcount_block():
>

Thanks.  AI review might have found another bug in there:
	https://sashiko.dev/#/patchset/20260709132609.44233-1-security@auditcode.ai



