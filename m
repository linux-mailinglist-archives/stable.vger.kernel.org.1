Return-Path: <stable+bounces-268450-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sIZDJGcoPWqCyAgAu9opvQ
	(envelope-from <stable+bounces-268450-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:08:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6486C5F14
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:08:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="gYKz/8Jp";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268450-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268450-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 621763054EAA
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC372D060D;
	Thu, 25 Jun 2026 13:08:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB42DC334;
	Thu, 25 Jun 2026 13:08:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392894; cv=none; b=C87Kj8sClJ1rKPxIYEreJ3HHhHGNxbW9q8V2ITUJJrQasZXMjLOSrDbO+uOZBUE1NsK6jQ0U/3X44mm4YAJrwYVyCbVYB1B+iGkFVXLABE1py+oVNLx+OALWWBdYQPKAcQ1a99rdLfej5hU1lVdxv41ZlaJLPAqG1ompcqytpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392894; c=relaxed/simple;
	bh=pfZfuQEHDP42dBNoHHZhyveWire0DtYNviasEQVUCmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PiJVfTfjdjcs+hdiInQ5IUAYYMyN0RcISN8uU0ttRIY3gnMN4zrvpWKEBFMPS3v8EYAYWpmwu1K3REQKAomPH8uZWDp8RHTLIje6tLiLPfqg+ieDBSv5qlmFuhyk3v/68/FNhPRdSLOk/8SEZmTL2AZ9LDtjs0dMtsSBweGN8Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gYKz/8Jp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC571F000E9;
	Thu, 25 Jun 2026 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392892;
	bh=g2DoFrZJUjSKa78Fnxen5WaXlPtYmsR7htSp5vKDxvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gYKz/8Jpw1dnnLnkfPJpXnjG8r1ejw0kZuhLGZu2gE5UHQSwm8qe5Yy8P3V7c1msn
	 KnSwpMnh51korhQM27nVaqVwcCZpYWefQjkVvO2ru4GxSjvFw3ZFKsAypJTHD4dWoi
	 FZhwgbNwLFmBgSSr4T9ccyveHVtu7v5cj3pVjksE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrey Vagin <avagin@gmail.com>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Jann Horn <jannh@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH 6.18 41/60] testing/selftests/mm: add soft-dirty merge self-test
Date: Thu, 25 Jun 2026 14:03:26 +0100
Message-ID: <20260625125651.704240577@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
References: <20260625125645.554579168@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-268450-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ljs@kernel.org,m:avagin@gmail.com,m:david@kernel.org,m:jannh@google.com,m:liam.howlett@oracle.com,m:mhocko@suse.com,m:rppt@kernel.org,m:pfalcato@suse.de,m:surenb@google.com,m:vbabka@suse.cz,m:gorcunov@gmail.com,m:akpm@linux-foundation.org,m:elaidya225@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,google.com,oracle.com,suse.com,suse.de,suse.cz,linux-foundation.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,linux-foundation.org:email,suse.cz:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE6486C5F14

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

commit c7ba92bcfea34f6b4afc744c3b65c8f7420fefe0 upstream.

Assert that we correctly merge VMAs containing VM_SOFTDIRTY flags now that
we correctly handle these as sticky.

In order to do so, we have to account for the fact the pagemap interface
checks soft dirty PTEs and additionally that newly merged VMAs are marked
VM_SOFTDIRTY.

We do this by using use unfaulted anon VMAs, establishing one and clearing
references on that one, before establishing another and merging the two
before checking that soft-dirty is propagated as expected.

We check that this functions correctly with mremap() and mprotect() as
sample cases, because VMA merge of adjacent newly mapped VMAs will
automatically be made soft-dirty due to existing logic which does so.

We are therefore exercising other means of merging VMAs.

Link: https://lkml.kernel.org/r/d5a0f735783fb4f30a604f570ede02ccc5e29be9.1763399675.git.ljs@kernel.org
Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrey Vagin <avagin@gmail.com>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/mm/soft-dirty.c |  127 +++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -184,6 +184,130 @@ static void test_mprotect(int pagemap_fd
 		close(test_fd);
 }
 
+static void test_merge(int pagemap_fd, int pagesize)
+{
+	char *reserved, *map, *map2;
+
+	/*
+	 * Reserve space for tests:
+	 *
+	 *   ---padding to ---
+	 *   |   avoid adj.  |
+	 *   v     merge     v
+	 * |---|---|---|---|---|
+	 * |   | 1 | 2 | 3 |   |
+	 * |---|---|---|---|---|
+	 */
+	reserved = mmap(NULL, 5 * pagesize, PROT_NONE,
+			MAP_ANON | MAP_PRIVATE, -1, 0);
+	if (reserved == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+	munmap(reserved, 4 * pagesize);
+
+	/*
+	 * Establish initial VMA:
+	 *
+	 *      S/D
+	 * |---|---|---|---|---|
+	 * |   | 1 |   |   |   |
+	 * |---|---|---|---|---|
+	 */
+	map = mmap(&reserved[pagesize], pagesize, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	/* This will clear VM_SOFTDIRTY too. */
+	clear_softdirty();
+
+	/*
+	 * Now place a new mapping which will be marked VM_SOFTDIRTY. Away from
+	 * map:
+	 *
+	 *       -      S/D
+	 * |---|---|---|---|---|
+	 * |   | 1 |   | 2 |   |
+	 * |---|---|---|---|---|
+	 */
+	map2 = mmap(&reserved[3 * pagesize], pagesize, PROT_READ | PROT_WRITE,
+		    MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (map2 == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	/*
+	 * Now remap it immediately adjacent to map, if the merge correctly
+	 * propagates VM_SOFTDIRTY, we should then observe the VMA as a whole
+	 * being marked soft-dirty:
+	 *
+	 *       merge
+	 *        S/D
+	 * |---|-------|---|---|
+	 * |   |   1   |   |   |
+	 * |---|-------|---|---|
+	 */
+	map2 = mremap(map2, pagesize, pagesize, MREMAP_FIXED | MREMAP_MAYMOVE,
+		      &reserved[2 * pagesize]);
+	if (map2 == MAP_FAILED)
+		ksft_exit_fail_msg("mremap failed\n");
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 1,
+			 "Test %s-anon soft-dirty after remap merge 1st pg\n",
+			 __func__);
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map2) == 1,
+			 "Test %s-anon soft-dirty after remap merge 2nd pg\n",
+			 __func__);
+
+	munmap(map, 2 * pagesize);
+
+	/*
+	 * Now establish another VMA:
+	 *
+	 *      S/D
+	 * |---|---|---|---|---|
+	 * |   | 1 |   |   |   |
+	 * |---|---|---|---|---|
+	 */
+	map = mmap(&reserved[pagesize], pagesize, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (map == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	/* Clear VM_SOFTDIRTY... */
+	clear_softdirty();
+	/* ...and establish incompatible adjacent VMA:
+	 *
+	 *       -  S/D
+	 * |---|---|---|---|---|
+	 * |   | 1 | 2 |   |   |
+	 * |---|---|---|---|---|
+	 */
+	map2 = mmap(&reserved[2 * pagesize], pagesize,
+	PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	if (map2 == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	/*
+	 * Now mprotect() VMA 1 so it's compatible with 2 and therefore merges:
+	 *
+	 *       merge
+	 *        S/D
+	 * |---|-------|---|---|
+	 * |   |   1   |   |   |
+	 * |---|-------|---|---|
+	 */
+	if (mprotect(map, pagesize, PROT_READ | PROT_WRITE | PROT_EXEC))
+		ksft_exit_fail_msg("mprotect failed\n");
+
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map) == 1,
+			 "Test %s-anon soft-dirty after mprotect merge 1st pg\n",
+			 __func__);
+	ksft_test_result(pagemap_is_softdirty(pagemap_fd, map2) == 1,
+			 "Test %s-anon soft-dirty after mprotect merge 2nd pg\n",
+			 __func__);
+
+	munmap(map, 2 * pagesize);
+}
+
 static void test_mprotect_anon(int pagemap_fd, int pagesize)
 {
 	test_mprotect(pagemap_fd, pagesize, true);
@@ -204,7 +328,7 @@ int main(int argc, char **argv)
 	if (!softdirty_supported())
 		ksft_exit_skip("soft-dirty is not support\n");
 
-	ksft_set_plan(15);
+	ksft_set_plan(19);
 	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);
@@ -216,6 +340,7 @@ int main(int argc, char **argv)
 	test_hugepage(pagemap_fd, pagesize);
 	test_mprotect_anon(pagemap_fd, pagesize);
 	test_mprotect_file(pagemap_fd, pagesize);
+	test_merge(pagemap_fd, pagesize);
 
 	close(pagemap_fd);
 



