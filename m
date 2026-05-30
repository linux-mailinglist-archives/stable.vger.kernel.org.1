Return-Path: <stable+bounces-258872-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKjeAC8wG2qU/wgAu9opvQ
	(envelope-from <stable+bounces-258872-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:45:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938C612671
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F28983191449
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71FF3C9ECF;
	Sat, 30 May 2026 18:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nuOQaJbC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812AD3C3C1E;
	Sat, 30 May 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165824; cv=none; b=YrB0vNJkeHzzNu1BSJEh+1bQ8zcDAkWh+Ci47cmsdDLTdQmVn3seBFtL6g/u0jjCeuqaJqip+an09mwJDs2xUJuf5AkQQ5rBqxucly5kq7snFql36pQ1npcoZRZYYeuVLT4lkHBZYypEUGeHCvpyfCDAmWpRO3YSDdTsbq1qZss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165824; c=relaxed/simple;
	bh=J4um5ULmnFM+2EZ1csR6724dK/fqQ/Fb6JnU1WOKnjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=As3wGUfsQebnJnr2gpJqIE2yOZ+V8cdH5IPDh+MlQozZITSMcqQgD1dinmVjfOdtyIX0fDdmv72hJM+6otx/wHzTitJs/XuT0O+whemLx7MxHv9jy3H/WbMAsLQKoKpKaHhvvTq3IoFkaElbPbM9JUkzhkNcG3+/aSYuk9MsLLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nuOQaJbC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA1D1F00893;
	Sat, 30 May 2026 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165822;
	bh=APHa6lIbBg4NTSS+/N2Rko0KXTK7fWcCT/v47t2yIyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nuOQaJbC42gsO5fxmhMw34O3KomEWFlqye6XyRoROmBbxLzIqK2pZ+lqABeCtrvPv
	 j/jLPtYdcvKO85aQuFW3xXv53kpHQ6u1Ur1agYz6N9XWUxCBTJU5mR8M2x0ds5pomu
	 93FMCnNNNpJ1J71KFW+Xb78D4OmL8nOyNEhDPBQ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Denis M. Karpov" <komlomal@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10 175/589] userfaultfd: allow registration of ranges below mmap_min_addr
Date: Sat, 30 May 2026 18:00:56 +0200
Message-ID: <20260530160229.483288395@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258872-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,suse.de,oracle.com,zeniv.linux.org.uk,suse.cz,google.com,redhat.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,suse.cz:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,oracle.com:email]
X-Rspamd-Queue-Id: 5938C612671
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis M. Karpov <komlomal@gmail.com>

commit 161ce69c2c89781784b945d8e281ff2da9dede9c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/userfaultfd.c |    2 --
 1 file changed, 2 deletions(-)

--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1233,8 +1233,6 @@ static __always_inline int validate_rang
 		return -EINVAL;
 	if (!len)
 		return -EINVAL;
-	if (start < mmap_min_addr)
-		return -EINVAL;
 	if (start >= task_size)
 		return -EINVAL;
 	if (len > task_size - start)



