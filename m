Return-Path: <stable+bounces-238563-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJAINuU542lzDgEAu9opvQ
	(envelope-from <stable+bounces-238563-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 09:59:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42A4205C9
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 09:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC656300E69D
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 07:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19837472A;
	Sat, 18 Apr 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lqXt1ow+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA00372EF0;
	Sat, 18 Apr 2026 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776499157; cv=none; b=sRX0md4BEEs2hT3NkBt/X4Wm/Xa8itP3UdjppU2WmM+5VBQT7yXPfL8xa4z5CQkPQo2K/ppp8YLE9IByOpT1lV7v7YYm85yGdJbZj7Qsik00raBbClS7GudZDeKlYAgTkpF/ydDljf0Y0fhnPixSefYG+YxD6edtV02nSW/LViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776499157; c=relaxed/simple;
	bh=cUDNqbfCRXoOJijhfC+7sSfNpMkw2/5SN4nm52/XnUA=;
	h=Date:To:From:Subject:Message-Id; b=S5+2jkVhfdRxCyTHLKCTft8OobMSC3xb9YmSIyLy76JlQ+UvqIKdukPU1/Y2nNFZiA4g20JO0IS2AyVr7lZjBXZEjsAUJL+trs9JZiIyC98mnkp+osldkK9gE4nZwUNcBNpYNWzv5ypNlKd/Bkb8VndRcEWGEmgh+ONCGIYYek0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lqXt1ow+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F48C19424;
	Sat, 18 Apr 2026 07:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1776499157;
	bh=cUDNqbfCRXoOJijhfC+7sSfNpMkw2/5SN4nm52/XnUA=;
	h=Date:To:From:Subject:From;
	b=lqXt1ow+ZwGFYO6y7LYSea97cceb+cTZggwTvRnkOH7Y2rx1etuyk4HU5GRV4Ev2X
	 jWOweroDB8jD+md98RnI8BjBSkyPUk5o5LcPl6JUyU9XPpt2vBS5N1Ic/iTDWcS00v
	 EvFXl1dleRbwNAXhewV4/s66jINinaLhfiT51g7s=
Date: Sat, 18 Apr 2026 00:59:11 -0700
To: mm-commits@vger.kernel.org,viro@zeniv.linux.org.uk,stable@vger.kernel.org,rppt@kernel.org,pfalcato@suse.de,peterx@redhat.com,ljs@kernel.org,Liam.Howlett@oracle.com,jannh@google.com,jack@suse.cz,harry@kernel.org,brauner@kernel.org,komlomal@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-stable] userfaultfd-allow-registration-of-ranges-below-mmap_min_addr.patch removed from -mm tree
Message-Id: <20260418075916.51F48C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238563-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.de,redhat.com,oracle.com,google.com,suse.cz,gmail.com,linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,linux-foundation.org:dkim,linux-foundation.org:email,suse.de:email,suse.cz:email]
X-Rspamd-Queue-Id: 5A42A4205C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: userfaultfd: allow registration of ranges below mmap_min_addr
has been removed from the -mm tree.  Its filename was
     userfaultfd-allow-registration-of-ranges-below-mmap_min_addr.patch

This patch was dropped because it was merged into the mm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: "Denis M. Karpov" <komlomal@gmail.com>
Subject: userfaultfd: allow registration of ranges below mmap_min_addr
Date: Thu, 9 Apr 2026 13:33:45 +0300

The current implementation of validate_range() in fs/userfaultfd.c
performs a hard check against mmap_min_addr.  This is redundant because
UFFDIO_REGISTER operates on memory ranges that must already be backed by a
VMA.

Enforcing mmap_min_addr or capability checks again in userfaultfd is
unnecessary and prevents applications like binary compilers from using
UFFD for valid memory regions mapped by application.

Remove the redundant check for mmap_min_addr.

We started using UFFD instead of the classic mprotect approach in the
binary translator to track application writes.  During development, we
encountered this bug.  The translator cannot control where the translated
application chooses to map its memory and if the app requires a
low-address area, UFFD fails, whereas mprotect would work just fine.  I
believe this is a genuine logic bug rather than an improvement, and I
would appreciate including the fix in stable.

Link: https://lore.kernel.org/20260409103345.15044-1-komlomal@gmail.com
Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 fs/userfaultfd.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/userfaultfd.c~userfaultfd-allow-registration-of-ranges-below-mmap_min_addr
+++ a/fs/userfaultfd.c
@@ -1238,8 +1238,6 @@ static __always_inline int validate_unal
 		return -EINVAL;
 	if (!len)
 		return -EINVAL;
-	if (start < mmap_min_addr)
-		return -EINVAL;
 	if (start >= task_size)
 		return -EINVAL;
 	if (len > task_size - start)
_

Patches currently in -mm which might be from komlomal@gmail.com are



