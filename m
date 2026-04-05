Return-Path: <stable+bounces-233311-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJ7LI++x0Wk+MgcAu9opvQ
	(envelope-from <stable+bounces-233311-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 02:50:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E472E39CFA4
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 02:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69825300EA9C
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 00:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87532F12B3;
	Sun,  5 Apr 2026 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2m6T1DQq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521232EF67A;
	Sun,  5 Apr 2026 00:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775350241; cv=none; b=UZxPJDhsjDP9B+t55HKAvAT4ZU2sYYEsiyc3m47qB+ordJM7vKM8gYemD8acMzpFf1pFXPJA+4TSY436jIlSHphPSCfjxamDvlQrPjhaNSFgq90LcH0wWSgFeEJH6QUr8b+s/ORqL/paIqwD9JjTnxl8n/mgbrwdE7N517h7Pbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775350241; c=relaxed/simple;
	bh=SbhhwNVrp5/1gtDGXdM4lR4GcyYNdAQxRJjqoBWzZmA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=D27y9XOzruCNr1CXgIBWPrVcj270FqmkR1XKTIsrxiajEeQ0squKrsq+5c8445x8TyRqCoLhC/mVKefTTMew76uY1ASz5UxlGcEplYkTfRDV32QDmL2UjUPs8T2Uod8cgfnPgMG676aJHuSXAbLtxdHhhq72y8UYTZeSAcKAHZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2m6T1DQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA12BC19421;
	Sun,  5 Apr 2026 00:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775350241;
	bh=SbhhwNVrp5/1gtDGXdM4lR4GcyYNdAQxRJjqoBWzZmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2m6T1DQqjrw8r/6ngKXdQeZczTLQKb8wO1GsPAJFmbdPajTgmy9jQyRxio3uNyW9w
	 hnq38ISvUa5LCSv84I+9uwfDq7Ej4uo4BPFkP+poDUtAsbx4AGfXT2MfWSEbjtspYc
	 nr/NN5HZzHW3SLiLVIcc7hShhAnAFuroORgf0KJI=
Date: Sat, 4 Apr 2026 17:50:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: tejas bharambe <tejas.bharambe@outlook.com>
Cc: Tejas Bharambe <thbharam@gmail.com>, "ocfs2-devel@lists.linux.dev"
 <ocfs2-devel@lists.linux.dev>, "mark@fasheh.com" <mark@fasheh.com>,
 "jlbec@evilplan.org" <jlbec@evilplan.org>, "joseph.qi@linux.alibaba.com"
 <joseph.qi@linux.alibaba.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,
 "syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com"
 <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4] ocfs2: fix use-after-free in ocfs2_fault() when
 VM_FAULT_RETRY
Message-Id: <20260404175040.40a746040ddb0cb5ce347fe3@linux-foundation.org>
In-Reply-To: <JH0PR06MB66320ABCFAD8F239FE5112B2895CA@JH0PR06MB6632.apcprd06.prod.outlook.com>
References: <20260403035333.136824-1-tejas.bharambe@outlook.com>
	<20260403122947.2afc337b5333fb1990a78a65@linux-foundation.org>
	<JH0PR06MB66320ABCFAD8F239FE5112B2895CA@JH0PR06MB6632.apcprd06.prod.outlook.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233311-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux.dev,fasheh.com,evilplan.org,linux.alibaba.com,vger.kernel.org,syzkaller.appspotmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,a49010a0e8fcdeea075f];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,sashiko.dev:url,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Queue-Id: E472E39CFA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 5 Apr 2026 00:30:14 +0000 tejas bharambe <tejas.bharambe@outlook.com> wrote:

> Following is my response for question posted on https://sashiko.dev/#/patchset/20260403035333.136824-1-tejas.bharambe%40outlook.com
> 
> 
> No. For ocfs2_fault() to be executing, the file must be open and
> the process holds an active file descriptor. The inode's lifetime
> is tied to the file's reference count, which remains held by the
> file descriptor for the duration of the fault handler. munmap()
> can free the VMA (decrementing vm_file's refcount) but cannot
> free the inode as long as the file descriptor is open. The faulting
> thread cannot call close() while it is inside the fault handler,
> so the inode is guaranteed to outlive the trace call.

I don't think that's the scenario which Sashiko is suggesting.

Suppose userspace does

	fd = open(...);
	p = mmap(fd, ...);
	close(fd);

Now, that mmap is the only ref against fd.

Now, suppose that userspace does munmap() while another thread is in
the fault handler.


