Return-Path: <stable+bounces-233231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFq3Fi8V0GmV3AYAu9opvQ
	(envelope-from <stable+bounces-233231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 21:29:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7F6397A4E
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 21:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25A3F300B9E7
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 19:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04E833EB17;
	Fri,  3 Apr 2026 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XmHcnQM5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D234B19F;
	Fri,  3 Apr 2026 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775244588; cv=none; b=cxsokldVssavROWiPNN6X6zlXawgYbJsUK2GuqgIDExunrPbVfvskuXLDRjSXkUpGmXEYxYb2c+WALoUHMAQsPUhrFK1vWVRSpCZWUOXOJ8W3QETiZqCTeb7BqzUpVwyBAwVIgOtlF0bKYI0ESzCj7q03Zn9YEv5ugPQHNn1fsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775244588; c=relaxed/simple;
	bh=KVUOBm/XJXH3v16GB6JhY07VnRDXsYp6At0wwZo7LgE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ewBgLiuwcms/l61Rp8cWIA/8zUKlZzcY0Ulood4GWMdwrB/+CNVD5aQp7IkRMVsmJKPDJH4cV5YxkK71aogS0ptwbnEn1Wja4sDkgZqUxRvWGnCiTotRUTaP3n3tO8in1zyAd96phmxrchJY9fvDkkuVPQCJlKb4Jo25v+NaZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XmHcnQM5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C000BC4CEF7;
	Fri,  3 Apr 2026 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1775244588;
	bh=KVUOBm/XJXH3v16GB6JhY07VnRDXsYp6At0wwZo7LgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XmHcnQM5tBJuavm3UYXl1I6gZ5Do35IbN8BEgTgDFOl/a5894drXD1hbbWQK6iTpj
	 +Ha1GPT3mv4EEfaQBjwPAzscrG9qAf+gOQp+9xsdIGG8Xp2CDRsMNNjzwMRPuIMDcW
	 sHyZPIm96xsFvjd8bdUlJEDnb7qR47gDf8GZB9wQ=
Date: Fri, 3 Apr 2026 12:29:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tejas Bharambe <thbharam@gmail.com>
Cc: ocfs2-devel@lists.linux.dev, mark@fasheh.com, jlbec@evilplan.org,
 joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org,
 syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com, Tejas Bharambe
 <tejas.bharambe@outlook.com>, stable@vger.kernel.org
Subject: Re: [PATCH v4] ocfs2: fix use-after-free in ocfs2_fault() when
 VM_FAULT_RETRY
Message-Id: <20260403122947.2afc337b5333fb1990a78a65@linux-foundation.org>
In-Reply-To: <20260403035333.136824-1-tejas.bharambe@outlook.com>
References: <20260403035333.136824-1-tejas.bharambe@outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233231-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,fasheh.com,evilplan.org,linux.alibaba.com,vger.kernel.org,syzkaller.appspotmail.com,outlook.com];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,a49010a0e8fcdeea075f];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB7F6397A4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu,  2 Apr 2026 20:53:33 -0700 Tejas Bharambe <thbharam@gmail.com> wrote:

> filemap_fault() may drop the mmap_lock before returning VM_FAULT_RETRY,
> as documented in mm/filemap.c:
> 
>   "If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
>   may be dropped before doing I/O or by lock_folio_maybe_drop_mmap()."
> 
> When this happens, a concurrent munmap() can call remove_vma() and free
> the vm_area_struct via RCU. The saved 'vma' pointer in ocfs2_fault() then
> becomes a dangling pointer, and the subsequent trace_ocfs2_fault() call
> dereferences it -- a use-after-free.
> 
> Fix this by saving the inode reference before calling filemap_fault(),
> and removing vma from the trace event. The inode remains valid across
> the lock drop since the file is still open, so the trace can fire in
> all cases without dereferencing the potentially freed vma.

There's one question from the Sashiko AI reviewbot:
	https://sashiko.dev/#/patchset/20260403035333.136824-1-tejas.bharambe@outlook.com

