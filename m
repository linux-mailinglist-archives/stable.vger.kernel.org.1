Return-Path: <stable+bounces-221109-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aB9yKX9do2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221109-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:26:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1779F1C90D5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56FA73304272
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C840371464;
	Sat, 28 Feb 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2gOjI9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A115371460;
	Sat, 28 Feb 2026 17:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301459; cv=none; b=tk/C0BOVfY0fDznRnaqQMi6FpkjT3eBI8cAWGM5J+wa7ol3I68YnOYky9VooAcBi+ajl6/2s1xTjAO4WNAb3skggxL/0MYXqQUixAlo7v65AOH8LiYlPC6S+Dyr2GYP4NL70NIraVh96VSBgzAUN2u8TxAPYfpIhO13a2iOr4Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301459; c=relaxed/simple;
	bh=A1f1QShUP6lQqJ7k1RJjkakWAtceu7yz6XBz1K+AskQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLmXs/fXXoLLwpFxFFretfftfr7sFmj3ZYpooji00YwTsAL0ppe34L5T3p/UlWX7Gbr08j7u6HrptKSQEvLNQk6a2Y2T3ez9A/FBeMD+VeCYeA6ZmaBHXiYkHvaWO3vJbkKl+nhIWiVQxro63QS0USlQ0cYFBp9VXUQM6reJE9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2gOjI9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEC5C116D0;
	Sat, 28 Feb 2026 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301459;
	bh=A1f1QShUP6lQqJ7k1RJjkakWAtceu7yz6XBz1K+AskQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X2gOjI9ECiKwcs+H7GJsd6ozM2HqO9XqaK8SbZvsGOtJ6lihdpSUFbazUssuDW3gy
	 EGNHFX9CFBcmHj6sJAcpfB0w+CNl8BLT2O3V/9XGq0I/zx970noRTbsTV9ub0vbDTD
	 fsEZjIqJ6Gk9PTtMCt0Qda4SxqDhob+vc1IUov3f4V/oGThD3XIJ2dwyB/71oYSVLf
	 Y+igb14dxOk2xMSh+AFKkEbkMHUSo4fC3L6enwT5b+uPflA212+eykvgVvpFavFTZ0
	 JhNYsu6wRMsX833zbTWNqFbeOGdtKa8KgC+hTEC32L5Mf0qujkwPelOw41umKCshE+
	 cCQRY3UYZ8BTQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Li Chen <me@linux.beauty>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Philipp Rudo <prudo@redhat.com>,
	Ricardo Ribalda Delgado <ribalda@chromium.org>,
	Ross Zwisler <zwisler@google.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 644/752] kexec: derive purgatory entry from symbol
Date: Sat, 28 Feb 2026 12:45:55 -0500
Message-ID: <20260228174750.1542406-644-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221109-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,goodmis.org:email]
X-Rspamd-Queue-Id: 1779F1C90D5
X-Rspamd-Action: no action

From: Li Chen <me@linux.beauty>

[ Upstream commit 480e1d5c64bb14441f79f2eb9421d5e26f91ea3d ]

kexec_load_purgatory() derives image->start by locating e_entry inside an
SHF_EXECINSTR section.  If the purgatory object contains multiple
executable sections with overlapping sh_addr, the entrypoint check can
match more than once and trigger a WARN.

Derive the entry section from the purgatory_start symbol when present and
compute image->start from its final placement.  Keep the existing e_entry
fallback for purgatories that do not expose the symbol.

WARNING: kernel/kexec_file.c:1009 at kexec_load_purgatory+0x395/0x3c0, CPU#10: kexec/1784
Call Trace:
 <TASK>
 bzImage64_load+0x133/0xa00
 __do_sys_kexec_file_load+0x2b3/0x5c0
 do_syscall_64+0x81/0x610
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

[me@linux.beauty: move helper to avoid forward declaration, per Baoquan]
  Link: https://lkml.kernel.org/r/20260128043511.316860-1-me@linux.beauty
Link: https://lkml.kernel.org/r/20260120124005.148381-1-me@linux.beauty
Fixes: 8652d44f466a ("kexec: support purgatories with .text.hot sections")
Signed-off-by: Li Chen <me@linux.beauty>
Acked-by: Baoquan He <bhe@redhat.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Li Chen <me@linux.beauty>
Cc: Philipp Rudo <prudo@redhat.com>
Cc: Ricardo Ribalda Delgado <ribalda@chromium.org>
Cc: Ross Zwisler <zwisler@google.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kexec_file.c | 131 +++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 57 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index eb62a97942428..2bfbb2d144e69 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -882,6 +882,60 @@ static int kexec_calculate_store_digests(struct kimage *image)
 }
 
 #ifdef CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY
+/*
+ * kexec_purgatory_find_symbol - find a symbol in the purgatory
+ * @pi:		Purgatory to search in.
+ * @name:	Name of the symbol.
+ *
+ * Return: pointer to symbol in read-only symtab on success, NULL on error.
+ */
+static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
+						  const char *name)
+{
+	const Elf_Shdr *sechdrs;
+	const Elf_Ehdr *ehdr;
+	const Elf_Sym *syms;
+	const char *strtab;
+	int i, k;
+
+	if (!pi->ehdr)
+		return NULL;
+
+	ehdr = pi->ehdr;
+	sechdrs = (void *)ehdr + ehdr->e_shoff;
+
+	for (i = 0; i < ehdr->e_shnum; i++) {
+		if (sechdrs[i].sh_type != SHT_SYMTAB)
+			continue;
+
+		if (sechdrs[i].sh_link >= ehdr->e_shnum)
+			/* Invalid strtab section number */
+			continue;
+		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
+		syms = (void *)ehdr + sechdrs[i].sh_offset;
+
+		/* Go through symbols for a match */
+		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
+			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
+				continue;
+
+			if (strcmp(strtab + syms[k].st_name, name) != 0)
+				continue;
+
+			if (syms[k].st_shndx == SHN_UNDEF ||
+			    syms[k].st_shndx >= ehdr->e_shnum) {
+				pr_debug("Symbol: %s has bad section index %d.\n",
+					name, syms[k].st_shndx);
+				return NULL;
+			}
+
+			/* Found the symbol we are looking for */
+			return &syms[k];
+		}
+	}
+
+	return NULL;
+}
 /*
  * kexec_purgatory_setup_kbuf - prepare buffer to load purgatory.
  * @pi:		Purgatory to be loaded.
@@ -960,6 +1014,10 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	unsigned long offset;
 	size_t sechdrs_size;
 	Elf_Shdr *sechdrs;
+	const Elf_Sym *entry_sym;
+	u16 entry_shndx = 0;
+	unsigned long entry_off = 0;
+	bool start_fixed = false;
 	int i;
 
 	/*
@@ -977,6 +1035,12 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 	bss_addr = kbuf->mem + kbuf->bufsz;
 	kbuf->image->start = pi->ehdr->e_entry;
 
+	entry_sym = kexec_purgatory_find_symbol(pi, "purgatory_start");
+	if (entry_sym) {
+		entry_shndx = entry_sym->st_shndx;
+		entry_off = entry_sym->st_value;
+	}
+
 	for (i = 0; i < pi->ehdr->e_shnum; i++) {
 		unsigned long align;
 		void *src, *dst;
@@ -994,6 +1058,13 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 
 		offset = ALIGN(offset, align);
 
+		if (!start_fixed && entry_sym && i == entry_shndx &&
+		    (sechdrs[i].sh_flags & SHF_EXECINSTR) &&
+		    entry_off < sechdrs[i].sh_size) {
+			kbuf->image->start = kbuf->mem + offset + entry_off;
+			start_fixed = true;
+		}
+
 		/*
 		 * Check if the segment contains the entry point, if so,
 		 * calculate the value of image->start based on it.
@@ -1004,13 +1075,14 @@ static int kexec_purgatory_setup_sechdrs(struct purgatory_info *pi,
 		 * is not set to the initial value, and warn the user so they
 		 * have a chance to fix their purgatory's linker script.
 		 */
-		if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
+		if (!start_fixed && sechdrs[i].sh_flags & SHF_EXECINSTR &&
 		    pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
 		    pi->ehdr->e_entry < (sechdrs[i].sh_addr
 					 + sechdrs[i].sh_size) &&
-		    !WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
+		    kbuf->image->start == pi->ehdr->e_entry) {
 			kbuf->image->start -= sechdrs[i].sh_addr;
 			kbuf->image->start += kbuf->mem + offset;
+			start_fixed = true;
 		}
 
 		src = (void *)pi->ehdr + sechdrs[i].sh_offset;
@@ -1128,61 +1200,6 @@ int kexec_load_purgatory(struct kimage *image, struct kexec_buf *kbuf)
 	return ret;
 }
 
-/*
- * kexec_purgatory_find_symbol - find a symbol in the purgatory
- * @pi:		Purgatory to search in.
- * @name:	Name of the symbol.
- *
- * Return: pointer to symbol in read-only symtab on success, NULL on error.
- */
-static const Elf_Sym *kexec_purgatory_find_symbol(struct purgatory_info *pi,
-						  const char *name)
-{
-	const Elf_Shdr *sechdrs;
-	const Elf_Ehdr *ehdr;
-	const Elf_Sym *syms;
-	const char *strtab;
-	int i, k;
-
-	if (!pi->ehdr)
-		return NULL;
-
-	ehdr = pi->ehdr;
-	sechdrs = (void *)ehdr + ehdr->e_shoff;
-
-	for (i = 0; i < ehdr->e_shnum; i++) {
-		if (sechdrs[i].sh_type != SHT_SYMTAB)
-			continue;
-
-		if (sechdrs[i].sh_link >= ehdr->e_shnum)
-			/* Invalid strtab section number */
-			continue;
-		strtab = (void *)ehdr + sechdrs[sechdrs[i].sh_link].sh_offset;
-		syms = (void *)ehdr + sechdrs[i].sh_offset;
-
-		/* Go through symbols for a match */
-		for (k = 0; k < sechdrs[i].sh_size/sizeof(Elf_Sym); k++) {
-			if (ELF_ST_BIND(syms[k].st_info) != STB_GLOBAL)
-				continue;
-
-			if (strcmp(strtab + syms[k].st_name, name) != 0)
-				continue;
-
-			if (syms[k].st_shndx == SHN_UNDEF ||
-			    syms[k].st_shndx >= ehdr->e_shnum) {
-				pr_debug("Symbol: %s has bad section index %d.\n",
-						name, syms[k].st_shndx);
-				return NULL;
-			}
-
-			/* Found the symbol we are looking for */
-			return &syms[k];
-		}
-	}
-
-	return NULL;
-}
-
 void *kexec_purgatory_get_symbol_addr(struct kimage *image, const char *name)
 {
 	struct purgatory_info *pi = &image->purgatory_info;
-- 
2.51.0


