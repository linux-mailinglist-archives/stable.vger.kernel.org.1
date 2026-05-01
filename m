Return-Path: <stable+bounces-242287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN5rCDOI9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:02:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 676354ABD17
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECED6300D30A
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B95739A812;
	Fri,  1 May 2026 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eh+xpsBK"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42F53603E8
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633328; cv=none; b=A8EqxaFnmRKmV+bwtEj8GbQ+EpHXtnukRvwez9XYZq/wOsVGxH8GGX5DZ9GQDzhYiJ5up2xUFYtTda7VLUrtuLIL4LGDiN8wBBR6ybBEyBQIQ0iFr1Z252J9KB8swMgE2h01I0u/srG2S4MFaC+HOm0Arxo4/uEVyVMxcVGxfiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633328; c=relaxed/simple;
	bh=i9aHcnR3UfI48HD1OS5y0W5JFsKaLanCbnnKA7TqlGk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXvBf28PPJ60feFbblnYYMdsT7XafLlyZmHysQ6MTPCzAwAq/pxx+v/R4JipdwupQP03R0fYA/Gwkk+zdhKFoCOWZvjgYeKlD8+TC5Du2UJGQ6+Gg0A/ruRtfokQimsWRHBzNbmRt0fFA0bfQguIIcquurgLuxGeaKlCD59imiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eh+xpsBK; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfce3a195so955534f8f.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633325; x=1778238125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqZidDCn5y4gCrfLbOWYKSzW8HkTpyANFAvcSFhaUEo=;
        b=eh+xpsBKWMGSQe4n2zDtDjNOmg0sVLound5lvwUGctcIWWXFHTvgHzuv0/uKdDOORR
         fZ1dNMmLhVeBGLLlnzqalf1NOyn3/pPI8AmjhIZcsaTR8+8jNGD7Eb4igvVWeplG5CQw
         1SnN8UYvlvnOpR9y5/9nmE0LDAmglQllmUzu+aTI05w0P6YmHMW0oGOAHMoXedZzIg3j
         4H51KFzm0BC3LhzdQgPP4vqi0AKD7L32gpET89tdY7DKuoE/FwfmVLbId0zdCzXrwyT7
         G+wt2XcW11zKShxpvqHhYH5tEF6khqeqOelsxOr2zb6yMlSer5sYtKvCm3TsjC74bN+W
         lpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633325; x=1778238125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqZidDCn5y4gCrfLbOWYKSzW8HkTpyANFAvcSFhaUEo=;
        b=M7iBPnTxL2QVG872FGmwhujdSsC3TJfnVHpBNkRgwbOM9WFXW+TdhkzdNo8qzrRWgC
         KY2kw/6EbclBCHzXVfw9mLlr6LfoXLYyj2sEBo5i1q0ftQb58lzGjY/y0RCqq4Cdngmf
         6mhUg+MW3E+OSIW6TAylLlrde4B+BSOxFjJb/jmagY0Kc0Z3Y+CdRXZ+sfRmyxds++/p
         ypnAZB9UEUk4bS+2aLcMwG/+NYyIR6hihakgE83qBhmQ4f7LQ+ogntOsr2k4TXN8hIP7
         BvPml12BhN4SBq0RPcJYn9qusXjC7C1S2VSzmzVqkc221WsaWxpyCBSE7bdNbAgEhmN8
         +weA==
X-Forwarded-Encrypted: i=1; AFNElJ8Mxkxsb+iI9YpfGrlhju9Jz+ZxbOM0ccePvFhnusP2EDClAj4/vM96gOYGjwK5uJnmHrV6rNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb5d0CdrR/Bgp0ny+uMBocnjSQTZ3auVfuTt3XQzmeMGbl9dxi
	RHP163H0U60kgG9mxaCJ0xTTwb5V9/7+KDboB0PvVrTf8d6lWiRcwPE=
X-Gm-Gg: AeBDietMe0q3VwLlT2VqWjGq1VilCwXFMmZZuQvatfeoQt+ZV2JVRwtsFj5jGpJtM8v
	PgTlX/HHmW/mL3x+g8eE9+nGlOYsUdbE13WAjtDlX3qsRe3nMMdzCNZl00HiKxn9cHS6Cb/RuRC
	cHJL9kVx6boaFvyK7Qa+dg2QiRIgiDcjdBD7K0z1xWHPYX2iLk8K1+dD+SqepxOa6R9XixjOJFb
	A35KQS9eHahEov1+q2O4sGwrLWnFgIy3lUItH1mqDOOqIBuPqDrb8aVhIeamFCDQYynwmk2TA6f
	NyoXviS8YNvGzDSsy9ktDrKldfDF7FYAy9txYsWDuV+49dY+kp5W/638IEODRIlJtmEcqY/eZUD
	1niCDJaY+vBoWruKoqT9spKYvw7G9kIPnqwlkusHe0pIi5ewrkVUjPCGf8xt1ri+S5R5DkLNAor
	8HMEg=
X-Received: by 2002:a05:600c:4fc5:b0:488:a723:ea53 with SMTP id 5b1f17b1804b1-48a83d77ec9mr115852605e9.7.1777633324796;
        Fri, 01 May 2026 04:02:04 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fede418sm13928485e9.6.2026.05.01.04.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:04 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: fix use-after-free in gfs2_qd_dealloc
Date: Fri,  1 May 2026 11:02:03 +0000
Message-ID: <20260501110203.18771-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 676354ABD17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242287-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,42a37bf8045847d8f9d2];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Tristan Madani <tristan@talencesecurity.com>

gfs2_qd_dealloc(), called as an RCU callback from gfs2_qd_dispose(),
accesses the superblock object sdp through qd->qd_sbd after freeing qd.
It does so to decrement sd_quota_count and wake up sd_kill_wait.

However, by the time the RCU callback runs, gfs2_put_super() may have
already freed sdp via free_sbd().  This can happen when
gfs2_quota_cleanup() is called during unmount: it disposes of quota
objects via call_rcu() and then waits on sd_kill_wait with a 60-second
timeout.  If the timeout expires, or if gfs2_gl_hash_clear() triggers
additional qd_put() calls that schedule more RCU callbacks after the
wait completes, gfs2_put_super() will proceed to free the superblock
while RCU callbacks referencing it are still pending.

Add an rcu_barrier() before free_sbd() in gfs2_put_super() to ensure
all pending RCU callbacks (including gfs2_qd_dealloc) have completed
before the superblock is freed.

Fixes: a475c5dd16e5 ("gfs2: Free quota data objects synchronously")
Reported-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=42a37bf8045847d8f9d2
Tested-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/gfs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index a2ea121331f18..4d854556b5299 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -643,6 +643,7 @@ static void gfs2_put_super(struct super_block *sb)
 	gfs2_delete_debugfs_file(sdp);
 
 	gfs2_sys_fs_del(sdp);
+	rcu_barrier();
 	free_sbd(sdp);
 }
 
-- 
2.47.3


