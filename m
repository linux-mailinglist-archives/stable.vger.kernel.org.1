Return-Path: <stable+bounces-254008-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i++HIlDnEmr75AYAu9opvQ
	(envelope-from <stable+bounces-254008-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 13:56:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2647D5C23F5
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 13:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C97A3009167
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 11:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7FC3932C8;
	Sun, 24 May 2026 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCfxjJQ1"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A053F39524B
	for <stable@vger.kernel.org>; Sun, 24 May 2026 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779623751; cv=none; b=WMmKjjw4AkVe5BjHAS1VJUmBhNl5syYVVUvjT8l1urSo7x2N2u8QmXNUeKa/ddK4QsNyMxy10J6vvDlAfQvNa8EmP7wGGBPXeZWq3767jg8dasvFUMNwU2XsaEGBsk4mKh6eccUxto0KdlSTxnDf8LatXz6cDZAgLtQ2iKGw7WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779623751; c=relaxed/simple;
	bh=Z6otwaDFT4Vu8XH4hi9joxGSGQ0OnK7Or3PSuisf+yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T/EoyiLl0GZQxc1tS0HTxavHLwp1eSATfWb/1apjoB8VIygWV9g+2igO+AhLtNPzecVJTkXrACGb3SpUH3WGQcxDHe8CbsVv2bECgSDEuGNxrekWGCWFfL7VdLVMag1mUvs6DJWUBqqP0Z4p7ff4N6lAevfaigtW/GHaB6mHEeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCfxjJQ1; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b74b460d77so120988556d6.3
        for <stable@vger.kernel.org>; Sun, 24 May 2026 04:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779623748; x=1780228548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNOIhZwEAyxoSU8hZDbj9MzcmmC5fm/C4a9DIHbn8HM=;
        b=CCfxjJQ16UUBvBYI0OXs8MwS0VV/XrYrfd1EsrDTxgA/b8tT8nok6Gxc+r6XoaAJ/G
         rstoTi5jjtl+wnab8YPoqWE9A71YaQvrjDv72lXb166qGYoXTUivIjPSzt7toafCa/J2
         9VGXsSrK8CHohuEsuuum6TKdS6g/xH1r7VpHq/Jh24LwTv/fuxMvuLyKnUEm6mLDzA3W
         /Hes9Glm3aajOAq1A/h1bRG6CoMp6Mbf/Odwj703VZ66W2zRP9JBtGBdwBtS4OdNJwC7
         5RXQYja7eb8f+RrYpdqNqvDde5kb7YAqAfoKajGyzsecL2e69jnxMj3q0XFxLc5pGYIW
         2KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779623748; x=1780228548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNOIhZwEAyxoSU8hZDbj9MzcmmC5fm/C4a9DIHbn8HM=;
        b=L31ZntWS1h4J59mZQAFRFoOrEb9UKH+jNVRCoievMt9dsgPPRSGrjZJrFe5ULwBVFm
         v/sSW9JYJQUgceLguV03Bhet82gV5/SIPm/40JYlwlDwPnrg+ll8aKlgJkL8WdfhGDMy
         C8cZbOs8lq6uHHjDr3RltIpyOKSsiAKRlctbsUlNOYYekfOwWtESSlYnoXb5Y/T2WiPL
         ZKtUmbNFmPz9KX6UNXWcOOgqBUBFagwfF1lfIulTd3zq6gzYwHI9/PSwoC2EbHu8YCR2
         q3ywKNdq4yerLZq1gXeqp5RXpkBp6wylf1flsLqeQMNlT/WdY1SXhEUQI/l6bqHu9Tqb
         jOug==
X-Forwarded-Encrypted: i=1; AFNElJ/o/efxsNkB/5ykioxx6avv7ObhyDNcOG/N4H1FiH2+iqrZ+Zk8seeJBqvvDlE8tzPYH6CG6Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNRCwKN1yRpGB+b7TzKDK6VVPjx//Zc65KJuF4qjFSfhjSiUV
	lCA1oUU2KslsIL1KVlIrnVVwkx6reJwZanUR0XBanRNIiGfg7xvoRORh
X-Gm-Gg: Acq92OE9pfv0WjDI/AujNlzAXF1J6p6zStg3/cJcZYyUQ4o/AfpDZsdSqJYRq4ZNrVr
	eoWI64ZKidztI9Vu3LyCEmAbiXRQomCUMORE63RBnJ+eLUxX+PdsBV1x+48sx65hPrFGB6+TkOH
	l16i+wikOoc04CcB9+mzFV3qT9mcOVjZ5+AFIiEjj/tthF6Mr/C4ppdAi2gprWFjLzuiey2wR2u
	Xh0ZP/1fFwRri/1ncMnmUUY06htEefER7Z4ZOoik9iCCf+cCeO7h3yCTTmFHBVxJX+QQjo8246s
	ESHiI/0IQDDkBlxCFrw3sjHP+SeK41cnrtUzaS0xtPudL/Cs65hr5gGWnBNDxL7bSSRk7HnNfoQ
	saleFHym9pQ/VtgtgaFKixlAmeN2Gd1usN5mV5IsaqFDUmgFLKhHxuj/DjF5ziGgvpPyOhVsHHI
	dgmtqxKFvLnlnD8mNn+FAX/Ry+BCMs3wZTxZRUndcaanxOo0b86TFz99Eh6Cbv4kg+Acxe0aPmP
	EIy9DbbGo5lblYMFSRAaFmEOIojzNA=
X-Received: by 2002:a05:6214:570a:b0:89e:f35f:79f7 with SMTP id 6a1803df08f44-8cc7b606790mr171511936d6.51.1779623748030;
        Sun, 24 May 2026 04:55:48 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80decd31sm81137386d6.13.2026.05.24.04.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 04:55:47 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] lockd: pin next file across nlm_inspect_file lock-drop
Date: Sun, 24 May 2026 07:55:27 -0400
Message-ID: <20260524115527.1734251-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-254008-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2647D5C23F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nlm_traverse_files() pins the current file with f_count++ across
a mutex_unlock for nlm_inspect_file(), but nothing pins the saved
next pointer.  A concurrent nlm_release_file() can kfree the next
file during the unlock window, and the iterator dereferences freed
memory on the next loop step.

Pin both current and next before the lock-drop.  Advance by
swapping the pinned cursors at the end of each iteration so next
is always held alive across the unlock.

Always call nlm_file_release() after dropping the iteration pin,
regardless of whether the file matched the predicate.  Use
nlm_file_inuse(), which does a live walk of the inode lock list,
rather than the cached f_locks field, so skipped files that never
ran nlm_inspect_file() are evaluated correctly.

Cc: stable@vger.kernel.org
Fixes: 01df9c5e918a ("LOCKD: Fix a deadlock in nlm_traverse_files()")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/lockd/svcsubs.c | 65 +++++++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

Changes since v2:
 - Use nlm_file_inuse() (live inode lock-list walk) for the cleanup
   decision instead of the cached f_locks field.  v2 skipped cleanup
   entirely for non-matching files, leaking dead entries; the v1 fix
   used cached f_locks which is stale for skipped files.
   nlm_file_inuse() is correct on both paths because it walks the
   actual POSIX lock list rather than relying on nlm_inspect_file()
   having refreshed the cache.  (Chuck Lever.)

Changes since v1:
 - Fixed premature kfree of non-matching files.

Reproduced under UML + KASAN with 768 concurrent POSIX holders and
parallel /proc/fs/nfsd/unlock_filesystem writes.  Stock kernel trips
KASAN slab-use-after-free in nlm_traverse_files.  Patched v3 silent.

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index dd0214dcb6950..0ce1e3711f003 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -284,47 +284,58 @@ nlm_file_inuse(struct nlm_file *file)
 	return 0;
 }
 
-static void nlm_close_files(struct nlm_file *file)
-{
-	if (file->f_file[O_RDONLY])
-		nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
-	if (file->f_file[O_WRONLY])
-		nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
-}
-
 /*
  * Loop over all files in the file table.
  */
+static void nlm_file_release(struct nlm_file *file)
+{
+	if (!nlm_file_inuse(file))
+		nlm_delete_file(file);
+}
+
 static int
 nlm_traverse_files(void *data, nlm_host_match_fn_t match,
 		int (*is_failover_file)(void *data, struct nlm_file *file))
 {
-	struct hlist_node *next;
-	struct nlm_file	*file;
+	struct nlm_file *file, *next;
 	int i, ret = 0;
 
 	mutex_lock(&nlm_file_mutex);
 	for (i = 0; i < FILE_NRHASH; i++) {
-		hlist_for_each_entry_safe(file, next, &nlm_files[i], f_list) {
-			if (is_failover_file && !is_failover_file(data, file))
-				continue;
+		file = hlist_entry_safe(nlm_files[i].first,
+					struct nlm_file, f_list);
+		if (file)
 			file->f_count++;
-			mutex_unlock(&nlm_file_mutex);
-
-			/* Traverse locks, blocks and shares of this file
-			 * and update file->f_locks count */
-			if (nlm_inspect_file(data, file, match))
-				ret = 1;
+		while (file) {
+			/*
+			 * Pin the next neighbour before we drop the mutex
+			 * for nlm_inspect_file(); a concurrent
+			 * nlm_release_file() under the same mutex would
+			 * otherwise be free to unlink and kfree it during
+			 * the unlock window, leaving us to dereference a
+			 * freed slab when we walked to next afterwards.
+			 */
+			next = hlist_entry_safe(file->f_list.next,
+						struct nlm_file, f_list);
+			if (next)
+				next->f_count++;
+
+			if (!is_failover_file || is_failover_file(data, file)) {
+				mutex_unlock(&nlm_file_mutex);
+
+				/*
+				 * Traverse locks, blocks and shares of this
+				 * file and update file->f_locks count.
+				 */
+				if (nlm_inspect_file(data, file, match))
+					ret = 1;
+
+				mutex_lock(&nlm_file_mutex);
+			}
 
-			mutex_lock(&nlm_file_mutex);
 			file->f_count--;
-			/* No more references to this file. Let go of it. */
-			if (list_empty(&file->f_blocks) && !file->f_locks
-			 && !file->f_shares && !file->f_count) {
-				hlist_del(&file->f_list);
-				nlm_close_files(file);
-				kfree(file);
-			}
+			nlm_file_release(file);
+			file = next;
 		}
 	}
 	mutex_unlock(&nlm_file_mutex);
-- 
2.53.0


