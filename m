Return-Path: <stable+bounces-270995-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lhRQDoeiRmrEagsAu9opvQ
	(envelope-from <stable+bounces-270995-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:40:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 395216FB88C
	for <lists+stable@lfdr.de>; Thu, 02 Jul 2026 19:40:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=H6uMoPIU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270995-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-270995-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A222430A95D5
	for <lists+stable@lfdr.de>; Thu,  2 Jul 2026 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEBB3624B7;
	Thu,  2 Jul 2026 16:39:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08FD323417;
	Thu,  2 Jul 2026 16:39:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010393; cv=none; b=V0eVzqmEgSvvjuNrDJ+nsmQyb2L+gLXsUa5f9mt15C/b5H0qHG0qwKqNjxfQGPq/NpCqz7ruxQbeyHr9P6VCHSef8ZOySm1JDW56dSkApMjC/fEy3bZ8ypf7/jPlRGmufLxacgSOOBUlZDfDxdzApfm1srJVp449svZDGiUx+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010393; c=relaxed/simple;
	bh=cqwuhyQ9ANR3Rdfqi7boVm9ymXWB4I5vfHJlMqYfktc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMZisKGxUZD+dDQJB8Pw8NcDScRwNU/UIRcAZGgS6vhUp4oFF+6/KSeK4uJ2nsFv45y1bovATZVqpynFChQyJXdQu9y7vFJ+VokbdcehyicJbSwVPaWyUBi2mgplmkZxNz+4itI6e5F9QoFAcpcitcU9Pyw3VL7Ha/xG13O7MqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H6uMoPIU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FFC1F000E9;
	Thu,  2 Jul 2026 16:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783010392;
	bh=/2cYM3z5N1+Jo9Y1OFnyPbyShkQFERpiBeTti1tcvXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H6uMoPIU/0jJ4eM0SqTRI51hDVtG6FDeHQX3B/pefapfzfzNiXgZ1CtYbUiudgFqc
	 znRDfrTD/EisCicwHNN5Dhmx67IxqHPlCQ+gP/SUQQnxqfZ34KI7LLJ8Gp0/OO4fbU
	 W7hD0QMVfCetSBLYThK8Pgzy3fvpwoVGl8zk5twE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	bpf <bpf@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Subject: [PATCH 6.12 065/204] scripts/sorttable: Add helper functions for Elf_Ehdr
Date: Thu,  2 Jul 2026 18:18:42 +0200
Message-ID: <20260702155120.025931385@linuxfoundation.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702155118.667618796@linuxfoundation.org>
References: <20260702155118.667618796@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:bpf@vger.kernel.org,m:mhiramat@kernel.org,m:mark.rutland@arm.com,m:mathieu.desnoyers@efficios.com,m:akpm@linux-foundation.org,m:peterz@infradead.org,m:torvalds@linux-foundation.org,m:masahiroy@kernel.org,m:nathan@kernel.org,m:nicolas@fjasle.eu,m:zhengyejian1@huawei.com,m:martin.kelly@crowdstrike.com,m:christophe.leroy@csgroup.eu,m:jpoimboe@redhat.com,m:rostedt@goodmis.org,m:andrey.grodzovsky@crowdstrike.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270995-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 395216FB88C

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 1dfb59a228dde59ad7d99b2fa2104e90004995c7 ]

In order to remove the double #include of sorttable.h for 64 and 32 bit
to create duplicate functions, add helper functions for Elf_Ehdr.  This
will create a function pointer for each helper that will get assigned to
the appropriate function to handle either the 64bit or 32bit version.

This also moves the _r()/r() wrappers for the Elf_Ehdr references that
handle endian and size differences between the different architectures,
into the helper function and out of the open code which is more error
prone.

Cc: bpf <bpf@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Zheng Yejian <zhengyejian1@huawei.com>
Cc: Martin  Kelly <martin.kelly@crowdstrike.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/20250105162345.736369526@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/sorttable.c |   25 +++++++++++++++++++++++++
 scripts/sorttable.h |   20 ++++++++++++++++----
 2 files changed, 41 insertions(+), 4 deletions(-)

--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -85,6 +85,31 @@ static uint64_t (*r8)(const uint64_t *);
 static void (*w)(uint32_t, uint32_t *);
 typedef void (*table_sort_t)(char *, int);
 
+static uint64_t ehdr64_shoff(Elf_Ehdr *ehdr)
+{
+	return r8(&ehdr->e64.e_shoff);
+}
+
+static uint64_t ehdr32_shoff(Elf_Ehdr *ehdr)
+{
+	return r(&ehdr->e32.e_shoff);
+}
+
+#define EHDR_HALF(fn_name)				\
+static uint16_t ehdr64_##fn_name(Elf_Ehdr *ehdr)	\
+{							\
+	return r2(&ehdr->e64.e_##fn_name);		\
+}							\
+							\
+static uint16_t ehdr32_##fn_name(Elf_Ehdr *ehdr)	\
+{							\
+	return r2(&ehdr->e32.e_##fn_name);		\
+}
+
+EHDR_HALF(shentsize)
+EHDR_HALF(shstrndx)
+EHDR_HALF(shnum)
+
 /*
  * Get the whole file as a programming convenience in order to avoid
  * malloc+lseek+read+free of many pieces.  If successful, then mmap
--- a/scripts/sorttable.h
+++ b/scripts/sorttable.h
@@ -27,6 +27,10 @@
 #undef uint_t
 #undef _r
 #undef etype
+#undef ehdr_shoff
+#undef ehdr_shentsize
+#undef ehdr_shstrndx
+#undef ehdr_shnum
 
 #ifdef SORTTABLE_64
 # define extable_ent_size	16
@@ -39,6 +43,10 @@
 # define uint_t			uint64_t
 # define _r			r8
 # define etype			e64
+# define ehdr_shoff		ehdr64_shoff
+# define ehdr_shentsize		ehdr64_shentsize
+# define ehdr_shstrndx		ehdr64_shstrndx
+# define ehdr_shnum		ehdr64_shnum
 #else
 # define extable_ent_size	8
 # define compare_extable	compare_extable_32
@@ -50,6 +58,10 @@
 # define uint_t			uint32_t
 # define _r			r
 # define etype			e32
+# define ehdr_shoff		ehdr32_shoff
+# define ehdr_shentsize		ehdr32_shentsize
+# define ehdr_shstrndx		ehdr32_shstrndx
+# define ehdr_shnum		ehdr32_shnum
 #endif
 
 #if defined(SORTTABLE_64) && defined(UNWINDER_ORC_ENABLED)
@@ -250,16 +262,16 @@ static int do_sort(Elf_Ehdr *ehdr,
 	unsigned int orc_num_entries = 0;
 #endif
 
-	shdr_start = (Elf_Shdr *)((char *)ehdr + _r(&ehdr->etype.e_shoff));
-	shentsize = r2(&ehdr->etype.e_shentsize);
+	shdr_start = (Elf_Shdr *)((char *)ehdr + ehdr_shoff(ehdr));
+	shentsize = ehdr_shentsize(ehdr);
 
-	shstrndx = r2(&ehdr->etype.e_shstrndx);
+	shstrndx = ehdr_shstrndx(ehdr);
 	if (shstrndx == SHN_XINDEX)
 		shstrndx = r(&shdr_start->etype.sh_link);
 	string_sec = get_index(shdr_start, shentsize, shstrndx);
 	secstrings = (const char *)ehdr + _r(&string_sec->etype.sh_offset);
 
-	shnum = r2(&ehdr->etype.e_shnum);
+	shnum = ehdr_shnum(ehdr);
 	if (shnum == SHN_UNDEF)
 		shnum = _r(&shdr_start->etype.sh_size);
 



