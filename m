Return-Path: <stable+bounces-241054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLY8GDbd62llSQAAu9opvQ
	(envelope-from <stable+bounces-241054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:14:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B2F463711
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 23:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CD89301B70D
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 21:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112E334C808;
	Fri, 24 Apr 2026 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax3ystkv"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B833368A2
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065239; cv=none; b=Th4JNLooo84qHgFSK4gcTZNRknkKl/97MEKomT1FV/E0sqzjAXmoYrnyChbHDboqFh9UahAyvI6e4IOR+RWfoxh7B1w7wHuqbT3TyF3dpr9mv8PJbEKdziIO9t/ZnHOhXKBXZ0jD8/GmONwEio/tX62xMZwQ/I02MeFSYpZzRSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065239; c=relaxed/simple;
	bh=4X0P8ejdvF73I701AfOvMxRC+eioHqCaro5ibeBLX34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eie7z0tJVxrqExsTCwFgDRFo18EOJl6iBrQWNWgZT7wBXYG7l2Hn6qcIJ7wabpRpgzTt1NoEC1yFW31Mktk1YqnkU9IoqGZuycaknyf7Dao50q28ztGw3z6q0ls92yH0rlDLfELwWbb3n0WoxGPSF+NQrlUYFJZtfmNTOQGTf/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax3ystkv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso54136055e9.0
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 14:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065236; x=1777670036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCrW5HFYPqr8TJuXxIupeIWbyph75TP9QqH4Asf6mk4=;
        b=Ax3ystkvK3NM0fj/tP6kQYiIsb4jbX6APO98Hw0WocGb1JoGfp/EwY+xs6Xs7VNhwZ
         322j+Knx0cNgYgqkjgH7XzAtLwyS8G/aqIzmp7G5Oswlq9hVO93DuCtxXUSDCcoHC8YT
         emfia2K87nJ8Do/hXNT+yPRaDUYMji1HkTvXCrAhGWbFnNLg+oPMQ/1GUoef1khbC0kR
         mLSsN411UtQV4Mv2K4RjQfivSD8zLvQM70CS6FpomDrjNMxWWrNiIVa+LjmMq0Yk+vQF
         nTDX13/r83Oe1zHbYK+DStsbcZea05m93b1pYjN+HA7P+Q0bGaKxJV6V5FmMxfX3oZo9
         k0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065236; x=1777670036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SCrW5HFYPqr8TJuXxIupeIWbyph75TP9QqH4Asf6mk4=;
        b=EbxzI5XHggGBlnqI+GgGvpXsxlitXjMbhxIQ1kiAeGBb22AxUAD9JGlcdSezY+D88I
         Ywe5q5XG+A9wJ1ve6z2tEqDvhgfLZOT6tj/iKtQGQndulofODZuOKD935yHX1NqU0Arl
         vPq//SYi6+l9FKO+zKlq0sbqIMP1w5WLC94RmSGw5sirSrma859XfFwqOdY+1ynziT8O
         sQGT+Zbddn0GNHrK7goFQ1QuY2qQWVPCMvLWm3rz0paLF1ZglfPeox0HRlsGMo+SjPQu
         68OhtucayzpHptCO2eAgn05c0rN9vZQZIBd3CAMhWLpSNAzNbGnKrRbtBLpZyJAn9cSQ
         EA8Q==
X-Gm-Message-State: AOJu0YxeGaavXBRElVz82TE1jGtZyDm1VqlRCLduNaPvP6cSAWuniiMH
	PB2VdKj5CnSRug+m5RE6rl3IKYlDHEsCE+9JJdaEFeOZ5RzNy7oI50u2AjkVr0ko
X-Gm-Gg: AeBDiev/16P6A1h5p8mRcRHeW27EpWNsoxVrKDvUjA94WxZ/144evoLt37dGzCAoEsH
	DcAQ5YLl/9nMbpyPtPqcuMHKiqVocuAMFzS6u5cxFYJgS6wa75FaxlgnEbahwvufzuID1ELN7iC
	t4WHUELmb8QT+SLrnQPQeCS0eXS9/BMTKmieGtmo/E1cy8DZOrV9TFI1r7LpVH7Ux4u7N3qzWly
	UQRO4vc5tPskLKUYsxatmKg1b1Kx7Z1FkE9UCb2ra+P30CXlhDv0rrIivd5s2wnozzz1hETb8fg
	ndfFVZ77v0dAJVL91N/5J2LHNkljmwMXQH8oRK71mPb2iO23ubjB90dOcGJDOQwRgmQkkSxdMRw
	n+M9s2e5Ly4/YYrhlWmA8/neNAW7dsaaj0Yk0lFIATJofCBZpTjpAhyGXVeKYbsQ+s7u4fOsYau
	kb25Zaf6vM9D3vGZwRyiwFRthwRS0bnQ0bSLPgg6lO
X-Received: by 2002:a05:6000:2dc6:b0:43f:dbbf:6d93 with SMTP id ffacd0b85a97d-43fe3dfd5bbmr51149032f8f.27.1777065235722;
        Fri, 24 Apr 2026 14:13:55 -0700 (PDT)
Received: from fedora ([156.207.128.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb1176sm63845677f8f.3.2026.04.24.14.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:13:55 -0700 (PDT)
From: Ahmed Elaidy <elaidya225@gmail.com>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	avagin@gmail.com,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Jann Horn <jannh@google.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Ahmed Elaidy <elaidya225@gmail.com>
Subject: [PATCH v1 9/9] testing/selftests/mm: add soft-dirty merge self-test
Date: Sat, 25 Apr 2026 00:12:43 +0300
Message-ID: <20260424211315.1072123-10-elaidya225@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424211315.1072123-1-elaidya225@gmail.com>
References: <20260424211315.1072123-1-elaidya225@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01B2F463711
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,oracle.com,gmail.com,kernel.org,google.com,suse.com,suse.de,suse.cz];
	TAGGED_FROM(0.00)[bounces-241054-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elaidya225@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]

From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

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

Link: https://lkml.kernel.org/r/d5a0f735783fb4f30a604f570ede02ccc5e29be9.1763399675.git.lorenzo.stoakes@oracle.com
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
(cherry picked from commit c7ba92bcfea34f6b4afc744c3b65c8f7420fefe0)
Signed-off-by: Ahmed Elaidy <elaidya225@gmail.com>
---
 tools/testing/selftests/mm/soft-dirty.c | 127 +++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 4ee4db3750c1..c3a9585de98c 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -184,6 +184,130 @@ static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
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
 
-- 
2.53.0


