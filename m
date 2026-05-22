Return-Path: <stable+bounces-253678-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePWCHh67D2qCPAYAu9opvQ
	(envelope-from <stable+bounces-253678-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 04:10:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E16585ADE58
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 04:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 605693040209
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 02:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C61E2DC350;
	Fri, 22 May 2026 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="duXbEwSH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1007D1FE47B;
	Fri, 22 May 2026 02:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415628; cv=none; b=pvnUrYlC8Z9xhJKSUmm/qo+SyjpVTyQamzMhxf6S80llkt+/8Mpfq4Fwr7wOykml2cYrt0khLg37i1yBw/PPW95MlpYFPfRAHuZUwFyTFJeXLMZtaOY2El51qlyt6mEs3C/qnywz8mqOn5iYr9Wr6/3i2WyWoEnqLSk4kOvjy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415628; c=relaxed/simple;
	bh=J82F+S/ib+mJjVxwYZqJuv7nMMAOHyN1q2KS/tRm7Ck=;
	h=Date:To:From:Subject:Message-Id; b=YcvbeXyW+e8kRSTIzLoBFRDGlnzhoMdTaM7wl7GbY7fINEjy2WrGS8oBk1/943aswS+WaQMLwoNaphfzKSy9wj9SuuXQVoiV8uUUhYvnn0SqV8lUimrYbWUW9oUFpwLV9S0AFTCvwEOfRQi4cWBFJHPXxP0FyJKjlymPQUwHZ+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=duXbEwSH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75761F00A3D;
	Fri, 22 May 2026 02:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779415627;
	bh=bQ8jYZmbxlVEAKywPoIoYmbSwMsPvLw2bo3hGlcuqZE=;
	h=Date:To:From:Subject;
	b=duXbEwSHUn3uAW5jdkZgVi4+13OH2qYVFDN9ht/VAYLvleqW8Y3tiOXJ2O9duHQv8
	 onIkl42Ds+Ic2m/jTWPjSp4ZTr6j8KITRJF8YvUgbXmjGxEWPP3yWgdhFGHmeNsiuW
	 HwylaFuSd82SKoxJ3c7JZ3EF8xeie5pJabZE/kv4=
Date: Thu, 21 May 2026 19:07:06 -0700
To: mm-commits@vger.kernel.org,stable@vger.kernel.org,idosch@nvidia.com,baoquan.he@linux.dev,urezki@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-vmalloc-do-not-trigger-bug-on-bh-disabled-context.patch removed from -mm tree
Message-Id: <20260522020706.D75761F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253678-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,nvidia.com,linux.dev,gmail.com,linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,smtp.kernel.org:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux-foundation.org:email,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: E16585ADE58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: mm/vmalloc: do not trigger BUG() on BH disabled context
has been removed from the -mm tree.  Its filename was
     mm-vmalloc-do-not-trigger-bug-on-bh-disabled-context.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: mm/vmalloc: do not trigger BUG() on BH disabled context
Date: Fri, 15 May 2026 17:30:09 +0200

__get_vm_area_node() currently triggers a BUG() if in_interrupt() returns
true.  However, in_interrupt() also reports true when BH are disabled.

The bridge code can call rhashtable_lookup_insert_fast() with bottom
halves disabled:

__vlan_add()
 -> br_fdb_add_local()
  spin_lock_bh(&br->hash_lock); <-- Disable BH
   -> fdb_add_local()
    -> fdb_create()
     -> rhashtable_lookup_insert_fast()
      -> kvmalloc()
       -> vmalloc()
        -> __get_vm_area_node()
         -> BUG_ON(in_interrupt())
  spin_unlock_bh(&br->hash_lock)

this triggers the BUG() despite the caller not being in NMI or
hard IRQ context.

Replace the in_interrupt() check with in_nmi() || in_hardirq().

Link: https://lore.kernel.org/20260515153009.2296191-1-urezki@gmail.com
Fixes: c6307674ed82 ("mm: kvmalloc: add non-blocking support for vmalloc")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Cc: Ido Schimmel <idosch@nvidia.com>
Reported-by: syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/69ff8c7c.050a0220.1036b8.000b.GAE@google.com/
Reviewed-by: Baoquan He <baoquan.he@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmalloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/vmalloc.c~mm-vmalloc-do-not-trigger-bug-on-bh-disabled-context
+++ a/mm/vmalloc.c
@@ -3203,7 +3203,7 @@ struct vm_struct *__get_vm_area_node(uns
 	struct vm_struct *area;
 	unsigned long requested_size = size;
 
-	BUG_ON(in_interrupt());
+	BUG_ON(in_nmi() || in_hardirq());
 	size = ALIGN(size, 1ul << shift);
 	if (unlikely(!size))
 		return NULL;
_

Patches currently in -mm which might be from urezki@gmail.com are



