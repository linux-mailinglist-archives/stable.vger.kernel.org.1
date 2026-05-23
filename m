Return-Path: <stable+bounces-253871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Io1M/gFEWp+ggYAu9opvQ
	(envelope-from <stable+bounces-253871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 03:42:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9102B5BC620
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 03:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B450E301FD7C
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 01:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E5A279329;
	Sat, 23 May 2026 01:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivusw1vd"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687B125DB1A
	for <stable@vger.kernel.org>; Sat, 23 May 2026 01:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779500478; cv=none; b=p8BAtA6ojJg7CJg0bdI+peo/0l3b6JwBJJcGK0axpqKFPTMu99Prh/sIsiZE+Wwgdr5QqMmYdInmTOKtMnEQI+2gvvgCWJn8sKzgcy341+d8LOuA6yc2tvn5yP1TKtMIs4gThs78i4JKPAAiflRxxaBRqjfUa0d9xENYIFApgfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779500478; c=relaxed/simple;
	bh=NKmTmNXZNUVsawrzyHgxo886ekn2OAXS4D0rn9JgprE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSk4inywCLw7U8GxQYP0GwVjjeNWAE9r+dNYeU8gYainDslEI2BNGhFK51O80YO3GuVtYgwGXbg2mxauj+PE4XGTgmLVnPGyW6fNcdZyZZlqW4ENwSVHRLindvJduHhsTET0fW3C7PAXqTxsKrY3Lgzfdxv/ncDgKw4cppuuUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivusw1vd; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51306c9f2a8so93582971cf.1
        for <stable@vger.kernel.org>; Fri, 22 May 2026 18:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779500474; x=1780105274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NznA/de/GNUvCfqwNzu7QISNK1Z1Xgcm290xHganHVE=;
        b=ivusw1vdQ5H+u5YVsniLG9/Z3lk6ixweGutLAPmpZFPTeKGnAaI8fnLH/SECIPcCg1
         MBtEj1OSrQS7on/laAe2GdQEtLcs2FVkEaoczNzTXsXjfaQsokYfEtIVsCy7YPin/q9Y
         vHPAQb2QJcqew5zeT7YYpZa7oOtikVsakMNxwlXyWDfHvJ6vZS5vdMGaZzPZEbZZobHD
         qr+lBf5iXM3VbsiBDZ4/Vd6fap2rQVct59IyciA+J+0N1myGcFQe/8zL6putrUUvFluY
         6RQFDUr4dOsIZN5hFPX2AmXZ7YjkzIOeqXABXy21Q+xNNmRIVqg3Lm+p1HuQfvns+Hqu
         ABSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779500474; x=1780105274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NznA/de/GNUvCfqwNzu7QISNK1Z1Xgcm290xHganHVE=;
        b=nw7QerYF837PBegciD62G35va8GRUeegx9UNPFdL7epXAKoT1+ydxHT9ws9L3S5Mo6
         ptWH2uU/b3v+AIxMmB+U/eUFrFIJ9n70jsH/D8OULUHgC/ZRl1RXA4Z9tPPCF9p+NpJy
         rivCHmzikzYn28NJlF1EBr2p61FOiagV2j8wXtWgiOBllCnEdLBGxkzUO5t8SQPbSQqK
         WjH/tPBq9Ya87p2s/fQzlXsW0JwBt7nBDSYO0jR8zzx1sMuacFiSbmAcU9Fl5KobXx9Y
         8xK8Yl3WxAVM7SDLmDA06P/w/8p+NEc+w55K690XTCu4c6EPD/LJcCGutwkLLiUofd+P
         43MQ==
X-Forwarded-Encrypted: i=1; AFNElJ8NUMVq0uiqsvAH9wtfVwg1qMRpmaeH3Cr8GzJThoM/5piTvr2wJ70GY1PcRGxZgeapaFK2Eek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmwOzh3lvG63itAROrJWwEj9zKFsK5kjb1GZuSglG9R5RJ3Fno
	FnWN32wOnLcpwvtFa3NFx9su6IDGIATgY+9mryAGgnQwXLH6ui9gdfe7
X-Gm-Gg: Acq92OHQjV46/x5nzmXsMu+hdXPlJF95ItSKzEU2KNK0vGR4gTr0Xo6DD6rvIMSKPzy
	Em7iLc2b062V36IT0PTjPLgn1KYd5KEFOigEOYD93MzZBHtfO7D+UU04bLFduNdMa905+DMOEhA
	l9PvImujCchx9sToQ1vK4+LT6V5JqCzU0N5YTdj87GJ07RYTtFote7DB3+UPJkY98bNVVqgQwZf
	Hq3L/o8Lsmkaed2jyFFPQQmgSOZGixM4IT8ySfDRah+2y0sUyo9V3LaMX481pONhb7vWMS6fMvt
	HiDRzzs/CZAk/DJptt9Zqe61/J+7HVuWvKwIDVmN4EwyP/M+ckGxTTND/SxFrtQLoUgHkjHtL0/
	pAzY5b4wKhb36NqsKkgjfi/oB9oaCqLwYMm5CNa9xqux42wPqfq3FQk1CQsD+UeoNuv+xpCxL85
	u4HNrt0IV7MX1DDyt0zcSin4LxnJklkvR8QxLJCw5F4rxuXzwbMHSx/1uJjq8n+O1wbOPTM2zqp
	g25jgZpry+8+AAOxZjwzJY9VYrf7uE=
X-Received: by 2002:a05:622a:5906:b0:50f:b9e6:e058 with SMTP id d75a77b69052e-516d444cb4dmr90035591cf.25.1779500474184;
        Fri, 22 May 2026 18:41:14 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b24cecsm32445651cf.9.2026.05.22.18.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 18:41:13 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] NFSD: restart ssc_expire_umount walk after dropping nfsd_ssc_lock
Date: Fri, 22 May 2026 21:41:07 -0400
Message-ID: <20260523014107.2460863-1-michael.bommarito@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-253871-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9102B5BC620
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfsd4_ssc_expire_umount() walks nn->nfsd_ssc_mount_list with
list_for_each_entry_safe(ni, tmp, ...).  For each expired entry it
sets nsui_busy = true, drops nfsd_ssc_lock to run mntput() on the
source vfsmount, then reacquires the lock to list_del + kfree the
entry and continue iterating via the macro's saved tmp pointer.

The nsui_busy flag protects the current ni from concurrent
nfsd4_ssc_setup_dul() finders during the lock-drop window, but it
does not pin tmp.  Another nfsd RPC thread that fails its source-
server mount and reaches nfsd4_ssc_cancel_dul() will, during that
same window, take nfsd_ssc_lock, list_del + kfree its own ssc_umount
item, and release the lock.  If that item is the saved tmp of the
expire walk, the next iteration dereferences a freed
nfsd4_ssc_umount_item.

Reachability: triggered by any authenticated NFSv4.2 client that
can issue OP_COPY with cna_src.nl4_type = NL4_SERVER to a destination
nfsd built with CONFIG_NFSD_V4_2_INTER_SSC=y and started with
inter_copy_offload_enable=Y.  The client chooses the source-server
netaddr and can pick one that fails vfs_kern_mount() (unreachable,
RST after EXCHANGE_ID, etc.) to drive nfsd4_ssc_cancel_dul() into
the laundromat's lock-drop window.  Default Linux nfsd ships with
inter_copy_offload_enable=N, so the bug is reachable only on servers
where the administrator has explicitly opted into inter-SSC offload.

Restart the walk from the head after the mntput() unlock window so
no saved next pointer survives the lock-drop.  The list is bounded
by the number of active inter-server source mounts (typically small)
and the expire delayed-work runs periodically rather than per-IO,
so the restart is cheap.

Cc: stable@vger.kernel.org
Fixes: f4e44b393389 ("NFSD: delay unmount source's export after inter-server copy completed.")
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 fs/nfsd/nfs4state.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

Reproduced under QEMU/KVM with KASAN, three nfsd network namespaces
on a single host so the kernel client treats them as distinct
servers, and Linux fault injection forcing vfs_kern_mount allocations
inside the destination nfsd to fail.  This drives nfsd4_ssc_cancel_dul
into a tight loop concurrent with the laundromat workqueue.

Stock kernel:

  BUG: KASAN: slab-use-after-free in laundromat_main+0x1756/0x1be0
  Read of size 8 at addr ffff88800ce9b200 by task kworker/u16:3
  Workqueue: nfsd4 laundromat_main

  Allocated by task 229:
   nfsd4_interssc_connect+0x3f5/0xd90    (nfsd4_ssc_setup_dul, inlined)
   nfsd4_copy+0x117d/0x1a30
   nfsd4_proc_compound+0xbe9/0x23f0

  Freed by task 229:
   kfree+0x18f/0x520
   nfsd4_interssc_connect+0xaff/0xd90    (nfsd4_ssc_cancel_dul, inlined)
   nfsd4_copy+0x117d/0x1a30

  The buggy address belongs to the cache kmalloc-128 of size 128.
  Kernel panic - not syncing: Fatal exception

Patched kernel ran the equivalent workload to completion with the
inter-SSC code path exercised 21-22 times per run and no KASAN
report.

The fault-injection knobs are standard Linux testing infrastructure
(see Documentation/fault-injection/) exercising the existing failure
path in nfsd; no kernel source was modified.  The same primitive
class was previously addressed by the OPEN-error path fix in
__nfs42_ssc_open(); this patch closes the corresponding hole in
the laundromat-driven delayed-unmount path.


diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6b9c399b89dfb..03582f15e3e7e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6728,30 +6728,37 @@ static void nfsd4_ssc_shutdown_umount(struct nfsd_net *nn)
 static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
 {
 	bool do_wakeup = false;
-	struct nfsd4_ssc_umount_item *ni = NULL;
-	struct nfsd4_ssc_umount_item *tmp;
+	struct nfsd4_ssc_umount_item *ni;
 
+restart:
 	spin_lock(&nn->nfsd_ssc_lock);
-	list_for_each_entry_safe(ni, tmp, &nn->nfsd_ssc_mount_list, nsui_list) {
-		if (time_after(jiffies, ni->nsui_expire)) {
-			if (refcount_read(&ni->nsui_refcnt) > 1)
-				continue;
+	list_for_each_entry(ni, &nn->nfsd_ssc_mount_list, nsui_list) {
+		if (!time_after(jiffies, ni->nsui_expire))
+			break;
+		if (refcount_read(&ni->nsui_refcnt) > 1)
+			continue;
 
-			/* mark being unmount */
-			ni->nsui_busy = true;
-			spin_unlock(&nn->nfsd_ssc_lock);
-			mntput(ni->nsui_vfsmount);
-			spin_lock(&nn->nfsd_ssc_lock);
+		/* mark being unmount */
+		ni->nsui_busy = true;
+		spin_unlock(&nn->nfsd_ssc_lock);
+		mntput(ni->nsui_vfsmount);
+		spin_lock(&nn->nfsd_ssc_lock);
 
-			/* waiters need to start from begin of list */
-			list_del(&ni->nsui_list);
-			kfree(ni);
+		/* waiters need to start from begin of list */
+		list_del(&ni->nsui_list);
+		kfree(ni);
 
-			/* wakeup ssc_connect waiters */
-			do_wakeup = true;
-			continue;
-		}
-		break;
+		/* wakeup ssc_connect waiters */
+		do_wakeup = true;
+		/*
+		 * The list_for_each_entry_safe() saved-next pointer was
+		 * not pinned across the spin_unlock() above: a concurrent
+		 * nfsd4_ssc_cancel_dul() can free the next item under the
+		 * same spinlock while mntput() runs.  Restart the walk
+		 * from the head so no stale next is dereferenced.
+		 */
+		spin_unlock(&nn->nfsd_ssc_lock);
+		goto restart;
 	}
 	if (do_wakeup)
 		wake_up_all(&nn->nfsd_ssc_waitq);
-- 
2.53.0


