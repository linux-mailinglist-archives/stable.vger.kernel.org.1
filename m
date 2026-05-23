Return-Path: <stable+bounces-253941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMmSOBaeEWr1oAYAu9opvQ
	(envelope-from <stable+bounces-253941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 14:31:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA5B5BEE2E
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 14:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7ED63017F94
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 12:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F0F399004;
	Sat, 23 May 2026 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PU+LJbLB"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26A53932C3
	for <stable@vger.kernel.org>; Sat, 23 May 2026 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779539470; cv=none; b=mUawJmTnmYbhO9qDj/3Mt39E/tXwbw6J0X0hMgtT31vKeZKvB9Ed7hU8brTIBTMEly3fqnhdPDreTbwaRoPTAU9KVGu+rGgGY6eVCakIznDXNkXT5z6dPRB+O0jsRGiwroNKF81vo065J+6EYP3g2+HjzaRv9lwL8f28GdvVFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779539470; c=relaxed/simple;
	bh=lPfLsuEru7s7Zjp+c+Ro6vfvvRixGRxpQtLo7wbk/pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQd4/vh5yLs4fiG0SabPy1Mn1VmowuamfUI4ohxfdfXXLJKcRjAYSqn2wFH7B1E6PB/l5Q8qjoQP0L/8Rhl32ixL44kX4V2Cus9HLICNkQ0l6zAoEcGm9WnfKVGvSrQzdJ1BhZ++pNgB7xy4gQi20/7HCJwjr8JtMlawVZlprK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PU+LJbLB; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so149898256d6.2
        for <stable@vger.kernel.org>; Sat, 23 May 2026 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779539467; x=1780144267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7dxo5nogsk0I0nc3SICs60+I3meZih1pCQB0Y6CwFM=;
        b=PU+LJbLBE/nFHaw57DAyQATmzdYwHg7s8yZyA/cagqSEPX+Vcf68Cwoc+rdAOOVYMC
         0yUriDIA58EpW4lce5wELO6cj+mluMIDNmxyuacvRmTeH6pJIuichtghwt8lAvSTHths
         B9hvpX0FVE0Y4H46NVzbHmqxJnWS02mAOvx79YBEW6rmxNyqDfN/+YCIxeMt9UL2IN+C
         w0+eLXGJyCd9nhWlO06CwwV3xDFGwyPEQnG1UL76DG1uMeWDqqqa1zgZ/AqJLtPkLenR
         ENlUPUy+cMgVGDTYp22NZmzdYuAmdfBWG+gF8puVNScKY9OC/cQX3fLQUCk8PIiRKTqF
         PAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779539467; x=1780144267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7dxo5nogsk0I0nc3SICs60+I3meZih1pCQB0Y6CwFM=;
        b=pxWY5fAL+v89SggvTBtuKL66rbVCiq2byqrXGU3q890bSi+4DsHlvlHqbc3M1SBD0k
         hsQkDnGbZAo9UerRi96iwUe4LC37rIffj/IwMiKRSC4S65VI4kCPkcV05a7XJt0p9eeI
         xFbtZSPeAlojVsOkBm5iQNbLjr/qGVhmUxDe/rWFkSNZBsFPIFgX7n5UVdJl4/Zf+e/k
         60sa44fodEyoPsk0ODl3WMK3urYjk9Jf102VC3uTYawEn2QsEbrb442w/Zvcvhame2OX
         2/1xhjEPpwXxQJB7gdkYzoN2euzO8iV7zBY5u/lBrMHbLNFaITDXwwAbMbxNifSxw/1k
         mfXA==
X-Forwarded-Encrypted: i=1; AFNElJ8ijHPmZqK4qMEl7pwXUXHLP7BFR2PdPcwAyGk/DQ3DFz6dsqLiGBWpC2ANJRiMoXJAFUWKwnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7+rdbjoMqTDdweCD9jz7ayE2IeW2b1WOO24SkBkjCk+VzhAS
	x4fIDpbkPejxSDIXzTLQX7ca3cFIiHMilT/lhgJkl//tdwj7Gyg42UOD2EJb73NVOdc=
X-Gm-Gg: Acq92OHi22vN90KF1TYbKZhfP6O4G/pJlT1pNiKHwl8nJ/OkRPF0bOq5W0bG4WaZU1R
	taHlGDuxGJnKGipAxyMDbHcKgb3W+8oMn7QlqNBwOylHj26mhcy3sgFfNpzcF5bOOCauwvFK+Wu
	7Nv/MldGrO3UlnDZ8b4fDaVmbA6KEM9iebTrHJwSf7E6/nRdXoXflF37nY/BkUHeiBdB/4vFMTA
	mPEQQTjs0rAFK3ULPvyFYJmoqzMPqwdEzWYaNW7MfP91wM9ynn8CwOEVKHoL0LVmkAZzg19+xIo
	BaaSEbSo3Av/njfq4ikOs8n5S8xHBgBD0XU2ShgzybZT0MytCf8QbSvy4QTf1WczvoCCUUGQsjT
	ePcp+JOo/p8uww3Mjo7iaSifPbOSChxWZFS9UgPY5LUvxe29hgBYDlp0tOUjVqwln+P0lGhhcg/
	m08Nj8iFgKmW1Lew6R5MXRwAO9Bq5gOWuhzRy0MJINbltsY8RGcDgzoWYPDhGsWd/Ou/E+ferPN
	1uO96K3cxoKjoTu3U9H
X-Received: by 2002:a05:6214:242c:b0:8cc:3546:260b with SMTP id 6a1803df08f44-8cc7b620d46mr126661786d6.14.1779539466787;
        Sat, 23 May 2026 05:31:06 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc8132f780sm45564746d6.49.2026.05.23.05.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 05:31:06 -0700 (PDT)
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
Subject: [PATCH v2] lockd: pin next file across nlm_inspect_file lock-drop
Date: Sat, 23 May 2026 08:30:53 -0400
Message-ID: <20260523123053.3480369-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-253941-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 5EA5B5BEE2E
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

Only call nlm_file_release() for files that matched the predicate
and were inspected.  Skipped files just get f_count-- to undo the
iteration pin; their f_locks is stale and must not drive cleanup.

Cc: stable@vger.kernel.org
Fixes: 01df9c5e918a ("LOCKD: Fix a deadlock in nlm_traverse_files()")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/lockd/svcsubs.c | 64 +++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 20 deletions(-)


Changes since v1:
 - Fixed premature kfree of non-matching files: nlm_file_release()
   is now called only for files that matched the predicate and were
   inspected.  Non-matching files just get f_count-- to undo the
   iteration pin.  (Spotted by sashiko.dev automated review.)

Reproduced under UML + KASAN with 768 concurrent POSIX holders and
parallel /proc/fs/nfsd/unlock_filesystem writes.

Stock kernel:

  BUG: KASAN: slab-use-after-free in nlm_traverse_files+0x71d/0x9d0

  Allocated by: nlm_lookup_file via nlm4svc_proc_lock
  Freed by:     another nlm_traverse_files instance

Patched v2 UML kernel ran the same harness silently.

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index dd0214dcb6950..0b38125cf86ab 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -295,36 +295,60 @@ static void nlm_close_files(struct nlm_file *file)
 /*
  * Loop over all files in the file table.
  */
+static void nlm_file_release(struct nlm_file *file)
+{
+	if (list_empty(&file->f_blocks) && !file->f_locks
+	    && !file->f_shares && !file->f_count) {
+		hlist_del(&file->f_list);
+		nlm_close_files(file);
+		kfree(file);
+	}
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
-
-			mutex_lock(&nlm_file_mutex);
-			file->f_count--;
-			/* No more references to this file. Let go of it. */
-			if (list_empty(&file->f_blocks) && !file->f_locks
-			 && !file->f_shares && !file->f_count) {
-				hlist_del(&file->f_list);
-				nlm_close_files(file);
-				kfree(file);
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
+				file->f_count--;
+				nlm_file_release(file);
+			} else {
+				file->f_count--;
 			}
+			file = next;
 		}
 	}
 	mutex_unlock(&nlm_file_mutex);
-- 
2.53.0


