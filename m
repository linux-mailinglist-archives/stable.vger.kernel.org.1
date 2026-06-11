Return-Path: <stable+bounces-262783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8BfBHtTsKmoNzgMAu9opvQ
	(envelope-from <stable+bounces-262783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 19:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7586C673E42
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 19:13:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=korg header.b=NJLvE4JV;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262783-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262783-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E211305A1EC
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D84425CF5;
	Thu, 11 Jun 2026 16:57:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F0B409E1B;
	Thu, 11 Jun 2026 16:57:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197027; cv=none; b=J0NIn37iBUsOUqTwLGD5aNYiM879XhzlKILAKQnYbqRGjCpW7fX4xZhDhBpQeon7iy3XFfo3wmIhB5Uc2lxCaVJUxGgaf40NGTFht+1L1LFz5x75hLJaXI3z0R7n46R5bXlXSYHAABsf2YWsEhSjl3qipRLQN1ptt4EmnMYAW7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197027; c=relaxed/simple;
	bh=2aZVq+ET4HMbKAAl5quJjiT0IOH+ArAwSdVxujmsH0o=;
	h=Date:To:From:Subject:Message-Id; b=KXxVRiWtOt8HiuN/0MMI2laK1AaaxeYzPRycLOG4yWJZ+D70f8dstLHcjAKqZVGwES2kg7B5NM4ZdfFjy0gUCMiqvVuSr1ZFQY8jHn46gQKJi2eosSAgTU86AComL55aIoW1G+CB06FOdGMr+Kpys4QwfmvqYRgCIuarzQ2F5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NJLvE4JV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F0D1F00893;
	Thu, 11 Jun 2026 16:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1781197025;
	bh=fYZVN/8JrHXaEblKO/3T5yNJmci1vcoU7gZXoqwKlwc=;
	h=Date:To:From:Subject;
	b=NJLvE4JVb9W/Px1ktCgY/JumZNGbkLiMfmdPGfyfCjXSXi1r9QRMk0jDMwVIOF1WX
	 ojJIQXElF2jRel5bt3zF+np4/+/x93M5SJ8Fz130I6a3p8phH65BtgBaD9L2AoWA7g
	 dUZ8dbQVBjjtHJeU3NHC+XykQF8TcnfJvv6lKkls=
Date: Thu, 11 Jun 2026 09:57:05 -0700
To: mm-commits@vger.kernel.org,vbabka@kernel.org,stable@vger.kernel.org,pfalcato@suse.de,ljs@kernel.org,liam@infradead.org,jannh@google.com,aliceryhl@google.com,enelsonmoore@gmail.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-fix-config_stack_growsup-typo-in-tools-testing-vma-include-duph.patch added to mm-unstable branch
Message-Id: <20260611165705.A2F0D1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-262783-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mm-commits@vger.kernel.org,m:vbabka@kernel.org,m:stable@vger.kernel.org,m:pfalcato@suse.de,m:ljs@kernel.org,m:liam@infradead.org,m:jannh@google.com,m:aliceryhl@google.com,m:enelsonmoore@gmail.com,m:akpm@linux-foundation.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,suse.de,infradead.org,google.com,gmail.com,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:email,linux-foundation.org:from_mime,infradead.org:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,smtp.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7586C673E42


The patch titled
     Subject: mm: fix CONFIG_STACK_GROWSUP typo in tools/testing/vma/include/dup.h
has been added to the -mm mm-unstable branch.  Its filename is
     mm-fix-config_stack_growsup-typo-in-tools-testing-vma-include-duph.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-fix-config_stack_growsup-typo-in-tools-testing-vma-include-duph.patch

This patch will later appear in the mm-unstable branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via various
branches at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there most days

------------------------------------------------------
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: mm: fix CONFIG_STACK_GROWSUP typo in tools/testing/vma/include/dup.h
Date: Wed, 10 Jun 2026 18:22:44 -0700

Commit 2b6a3f061f11 ("mm: declare VMA flags by bit") significantly
refactored the header file include/linux/mm.h.  In that step, it
introduced a typo in an ifdef, referring to a non-existing config option
STACK_GROWS_UP, whereas the actual config option is called STACK_GROWSUP.

Commit 40a4af52e047 ("mm: fix CONFIG_STACK_GROWSUP typo in mm.h") fixed
this typo in the mm.h header file, but did not update the copy of the code
in tools/testing/vma/include/dup.h.  Update this copy as well.

Commit message adapted from the above-referenced fix to mm.h.

Link: https://lore.kernel.org/20260611012258.432043-1-enelsonmoore@gmail.com
Fixes: 2b6a3f061f11 ("mm: declare VMA flags by bit")
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 tools/testing/vma/include/dup.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/vma/include/dup.h~mm-fix-config_stack_growsup-typo-in-tools-testing-vma-include-duph
+++ a/tools/testing/vma/include/dup.h
@@ -243,7 +243,7 @@ enum {
 #define VM_NOHUGEPAGE	INIT_VM_FLAG(NOHUGEPAGE)
 #define VM_MERGEABLE	INIT_VM_FLAG(MERGEABLE)
 #define VM_STACK	INIT_VM_FLAG(STACK)
-#ifdef CONFIG_STACK_GROWS_UP
+#ifdef CONFIG_STACK_GROWSUP
 #define VM_STACK_EARLY	INIT_VM_FLAG(STACK_EARLY)
 #else
 #define VM_STACK_EARLY	VM_NONE
_

Patches currently in -mm which might be from enelsonmoore@gmail.com are

mm-fix-config_stack_growsup-typo-in-tools-testing-vma-include-duph.patch


