Return-Path: <stable+bounces-262390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NBMMHSSyKGocIQMAu9opvQ
	(envelope-from <stable+bounces-262390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 02:39:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9118664FD4
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 02:38:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=trailofbits.com header.s=google header.b=SVgEui6f;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262390-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262390-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=trailofbits.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46D95303429F
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 00:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040011C84D7;
	Wed, 10 Jun 2026 00:38:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F540D562
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 00:38:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051928; cv=none; b=JgSKPuzlUNDvfprMQJFXVRdZQfxyLRsQJLROFyoiQUvM5LCpHj6vf9noXq0mQ7Bo//jhy/O4vb7VA6Msz4G3UFvglND5d6SMlutLaxBaSweomkak+qgxAtqmCZMu081leyaOt/s7RrKA0khurKmsi/wJlrbpa4iaIE7nkijtlaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051928; c=relaxed/simple;
	bh=8W4LSmmAd4tjAcHgGMcfpD9VPEhPb8gkaJNtbe3vw1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XH4L52elQZyuj5FXVis4UXY/E54rrFOPZH/f7e28kSTzRX0d6gq/qIrZ+njTZPiWq89yEF8Pp1gZFlxnoXK5qrQkiIi2wq9tvpnRCbg2gWcJkXzNK0dloDNMe7d93lZ5tWl3IzJua+i7aJ6FZXY2AeGko6CuBP3LLD8H76S0faA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=SVgEui6f; arc=none smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8cebfb15413so64346676d6.0
        for <stable@vger.kernel.org>; Tue, 09 Jun 2026 17:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1781051926; x=1781656726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4HD4CyZy0JUNR44EyaczU983Jr0FqnBLzgetNoKQtXo=;
        b=SVgEui6fE3h+dNzu5aucN1MJsBt+3NjSylE9GeKvSY3GAb7OOBbkIOjXlpzzhameSn
         ViBxRi9OLZBMgQfaPcYsPLyLqXSyJY+92j5x5I7hgXgmGCZkW/z3f+1aqD15tMOEfh5q
         fCDDgguR0dv4t0c51slBTI8fg2uXmY94YjFWcxBjmpuXlGmdMS1k+8lNRZSi8OTZfE+e
         W12Le4QSGNZR7jglmErVHv/JE+OJjMEVXKTFYRcOi5gCW+cpFo0Nev337xFTqhY7oqbR
         HjXPXoANA9jByfM2pZBnFmKYs8lbhlo+4a4ni6AzMFSk2IJ1ke+8MPHHeXVKDq7NHecO
         fSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781051926; x=1781656726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HD4CyZy0JUNR44EyaczU983Jr0FqnBLzgetNoKQtXo=;
        b=gcRveJAbFfGNaQNeF38FkK9EkZ9YC3bcvPeyIm+QkWQjejt9EhXzv+CCAUBKPlkAXq
         PZ6ywI0J8pgLOxewv9jFS1LvE5yMr9kli4xgtlegubuzeY2834OMCCCMoivUHZm9hNiU
         //cQEhRAElwHHzotD77UoM1excfNYEXUwRBmyuNhISW4MKk+NyEsZfOOcRm9iuKpMHM/
         zF+GsvoGz8X8Eyyn0xVZulgh+1y2EY8qUB9hdzWw5CQfLBYtPhTFRDZdjIrrHoQNKNAz
         RbMoQnrHLRIll3dwNtYY+36WTKFove9WVtM9tT4/mRzOvlc3Y1XKifisWnRUn6JhViHg
         RUzw==
X-Forwarded-Encrypted: i=1; AFNElJ+Ev8qKEBUmml8rQVJd9A5AwL22NtRGt3yDgXRfwYuVwNC5LwwJjN29j0/9GZoaUKV+mbSnoxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQIvrI5Zc7LSOj/SIYbw5OVz02tOatxZ2+5zh95s+Fhs5mkdt
	GJICMvpSqF/iu4ShoA3mJNP8lDLW36PPdFh2iiE2glkf7QX0sfGInvxqOxxw9+VpgIo=
X-Gm-Gg: Acq92OG73PookuVDUjaL3Te2qrogXC7j2vixmy3dNkMCof6tzyXzoiVHFMHGhf4//dr
	GcaZXcE3cY4ojARd27NMmSkdlvCwPEZRrPg6qnp3VaWnG2aSdBTBWfwaC2YuOH7oOvUZA03oqqD
	LrbDjoBil+GYUrDXsscTPHkezPH9EH68EnlLFK6Cfmyj03K29/PT017+VD0H9ReScj3VhZKGG5Q
	NwP/BN/keTpX+ILAIp4NDEz68LqpOydKIR9FJ6t6t16wnX2eFUtGcgqxYmL9uVAr4cpuknRDMlx
	EAi+DxBqZvJPZgE28pFN1Osz2Md0LcM8cd0s1XY2Y+zHEbNwDi6cnlXu6XNe3gR2v95kealc96M
	F/SLaPNKgXEBqxOOcyetWo6s1fEIIaByxfIj6PIbV7p2w8eJjmuBrX/p5Y+jCxEQHDUmlKVisNP
	fp9DgMzhj0iqcmtP7uxg6lU6CRtYOJhNGtuaUplw==
X-Received: by 2002:a05:622a:400c:b0:517:7971:a234 with SMTP id d75a77b69052e-51795b729ffmr331041021cf.4.1781051925756;
        Tue, 09 Jun 2026 17:38:45 -0700 (PDT)
Received: from localhost ([161.35.96.86])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-51775c297a8sm196989031cf.8.2026.06.09.17.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 17:38:45 -0700 (PDT)
From: Samuel Moelius <sam.moelius@trailofbits.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
	stable@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-fsdevel@vger.kernel.org (open list:FUSE: FILESYSTEM IN USERSPACE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] fuse: avoid 32-bit prune notification count wrap
Date: Wed, 10 Jun 2026 00:37:18 +0000
Message-ID: <20260610003717.1720575.7a414fc8c0ea.fuse-notify-prune-count-wrap@trailofbits.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[trailofbits.com,reject];
	R_DKIM_ALLOW(-0.20)[trailofbits.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262390-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:sam.moelius@trailofbits.com,m:stable@vger.kernel.org,m:joannelkoong@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[trailofbits.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sam.moelius@trailofbits.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sam.moelius@trailofbits.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[trailofbits.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9118664FD4

FUSE_NOTIFY_PRUNE validates the nodeid payload length with:

    size - sizeof(outarg) != outarg.count * sizeof(u64)

On 32-bit kernels, size_t is also 32 bits, so the daemon-controlled
count multiplication can wrap.  A prune notification with count
0x20000000 and no nodeid payload passes the check, enters the copy
loop, and asks the device copy path to read nodeids that are not
present in the userspace write buffer.  In QEMU this reaches the
fuse_copy_fill() BUG_ON(!err) path.

Validate the payload length with array_size() instead.  That accepts
exactly the same valid messages, but avoids wrapping arithmetic before
the copy loop consumes the count.

Assisted-by: Codex:gpt-5.5-cyber-preview
Fixes: 3f29d59e92a9 ("fuse: add prune notification")
Cc: stable@vger.kernel.org
Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
---
Changes in v2:
  - Use array_size macro

 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c105aaf9ff5d..0c6d1855003e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2081,7 +2081,7 @@ static int fuse_notify_prune(struct fuse_conn *fc, unsigned int size,
 	if (err)
 		return err;
 
-	if (size - sizeof(outarg) != outarg.count * sizeof(u64))
+	if (size - sizeof(outarg) != array_size(outarg.count, sizeof(u64)))
 		return -EINVAL;
 
 	for (; outarg.count; outarg.count -= num) {
-- 
2.43.0


