Return-Path: <stable+bounces-244129-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MBuKKrj+WnMEwMAu9opvQ
	(envelope-from <stable+bounces-244129-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:33:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CC44CD933
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22E6F301AF53
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 12:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CF442B73C;
	Tue,  5 May 2026 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JC8biiU1"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00C3B2FCD
	for <stable@vger.kernel.org>; Tue,  5 May 2026 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984414; cv=none; b=kybYKnAqFgByr0uGHCWTC/m/z0rrh9m885pg8Gu3bCVQntgT2Olt7ANTkBYxJaxYDEFAbxKdWqOjxT+jwdGe87qPwTsT/JnMp9wVDhYm1niD6obtA+RLmpZ9ISjxdF+B0HwX9mvEzDKsZZj3FrypVwPbyFcJ5ieO1OcNY7WiT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984414; c=relaxed/simple;
	bh=eJUwj/6+y0W5arObbVvbwVlT1S3EDBPdkX1WUrpPh+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbcqIZa49ib6NsCysPkhBUqb9j6XSWJKjFZXlewJ8ebTxJZG0dhkV08lq7MuuHvZZLlalEk4AQyU0HwHViweIYqsb4B0nNq+aEv9vmMRxRem5EskJA/FXEx/GPN8pAqZEaDVSC7VewoXTEsxNYjyAu8ZJYGJAr5Z0WXyoqmhs8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JC8biiU1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso64190895e9.1
        for <stable@vger.kernel.org>; Tue, 05 May 2026 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777984412; x=1778589212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyCFE+ceK7mwjkt1bpKIqqKxoM45iMU7CYCzo3ix1vA=;
        b=JC8biiU1UeuI20egVHhlMZgB0eZASCz9qJU1A59mqT31W/Y41TDpwlR4+Cno1ysudl
         9XO4If3yFGmaV7icOiMGXs1gD2CbRQ87T5UxQ/z16QhB+oO+kZ/sckA01ws20EvJ9QNA
         JEDKI775HwsVIQUIg1hjLDHzU6i3Vw2VOxTnej8kNYIsWq3nkVed3NNeEccZNT28b72Y
         mM0/MLzbvUmzz8pXYpCV/C/KmphJv/Nj3tuT0Yox2IYCTJuuo2y2BA7D4MiG+BgJgwAH
         p244dlp91B/b48jBx/nSrvX38xlto7gTZumSO+WA5FqBrPd2bV/BGsJjZkdi3CM8LzTN
         lSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777984412; x=1778589212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UyCFE+ceK7mwjkt1bpKIqqKxoM45iMU7CYCzo3ix1vA=;
        b=Vkt1CJDRw48dN30Fx8UvHEQyYtkads8Iz/rLPWrHAo6F0yap29M47ctiKlgRxPWEbR
         oiCopYH8D0zBaTyH+Dvs2kIYesvK5zz0KIm3dGFY0wkAUSuvdhC2yOpfMmZJv/ATQyqA
         UWuovAg4KDy0r8yprBDHIgrbaT257KqJ7w4HXjLnNtcBOCIhI8SyYm7Y50ixSXJVO/ii
         h/9E00XkArYLSnUc8xO+0jhrrxt9DnoOuSHMwHDCo4u4ok1nbQ6n2mWM0y1Tvwl2GU+c
         A4bjXOdPdUXXmQWa98+9BTdO3gr7sTZbiUQtTm6GYgLn0WugziH8EVwukf/XlDfeSTeb
         fAew==
X-Forwarded-Encrypted: i=1; AFNElJ8LVMQoIWLmsZAvwwpuGerwycwdQftEvynrUsqOQuVqvNg1UMNw3Pe6QeTJn4EYcU5fiL9oB3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTtiZvcBjh/6iRCHwVyA3/V9yUZPRlwko3WQALq4dmNvLMtUIE
	MdHPpbkj6RxNEka6N3GnSbDhnfusJcCL9cFvVfTsyF5irq3Sit/J7n0=
X-Gm-Gg: AeBDiev8ZnxALW/uWTX+dPkAWo3gH00Hwy5sjTMpI2nTjCwUWgZwOoUtZQud7tEOKcB
	vnZg73QRYH5bz1zLUaspUEjuslAFfLfZ37mvUpNx7kwfo+YHe6UXi7XpLr7f/KHw3qErpzzBF6E
	HtKC9rFRBF8N1GZPff8Fgku4xF6rtmI3QYajWqqucLtVe1jHqp5jqarjDEYjH47mp7BHuOKB10o
	QPfDd9JJp5+RlG2oi4AjanIWDYl9hJx06mWReNLM+40RkdGB30WTnqhqpXSgmGUS91GI+TY4EWA
	gE3DVldHAEdVRac2xUZ/HeaTg+U540ldx0CFhIPSvjcRobgtVYktpfChzqrke+fkiDcQPqnatLH
	XD+bk0W87R8TqavJ4CVsB0MuD8io68cz8ZHXrqLsrotvOCSuzarAhOtavKnRHufpA7sHHBgLMb9
	rC5Og=
X-Received: by 2002:a05:600c:8b8b:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-48a986763admr241291605e9.25.1777984411565;
        Tue, 05 May 2026 05:33:31 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a822bf3ffsm431044285e9.7.2026.05.05.05.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 05:33:31 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com,
	syzbot+885a4f3281b8d99c48d8@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v2 0/2] jfs: fix use-after-free races during unmount
Date: Tue,  5 May 2026 12:33:28 +0000
Message-ID: <20260505123330.2822833-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501110236.43226-1-tristmd@gmail.com>
References: <20260501110236.43226-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 46CC44CD933
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244129-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,c244f4a09ca85dd2ebc1,885a4f3281b8d99c48d8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Tristan Madani <tristan@talencesecurity.com>

Two related UAF races exist in JFS unmount:

1. jfs_lazycommit accesses freed jfs_sb_info/jfs_log after unmount
   proceeds past jfs_flush_journal but before jfsCommit drains
   TxAnchor.unlock_queue.

2. lbmIODone (BIO completion in softirq) accesses freed lbuf fields
   after lbmLogShutdown frees all lbufs from the freelist.

V1 fixed only race #1.  Syzbot testing showed that race #2 can
still trigger independently.  This V2 adds a second patch for the
BIO completion race.

Changes since v1:
 - Split into two patches (one per race)
 - NEW: patch 2/2 adds atomic io_count to drain in-flight BIO
   completions before lbmLogShutdown frees lbufs

Tristan Madani (2):
  jfs: drain lazy commit queue during unmount to prevent use-after-free
  jfs: wait for in-flight log I/O before freeing lbufs in lbmLogShutdown

 fs/jfs/jfs_logmgr.c | 10 ++++++++++
 fs/jfs/jfs_logmgr.h |  2 ++
 fs/jfs/jfs_txnmgr.c | 35 +++++++++++++++++++++++++++++++++++
 fs/jfs/jfs_txnmgr.h |  1 +
 fs/jfs/jfs_umount.c  |  8 ++++++++
 5 files changed, 56 insertions(+)

-- 
2.47.3

