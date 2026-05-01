Return-Path: <stable+bounces-242292-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGi+Ik6I9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242292-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:02:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ABC4ABD4B
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DF75301AA91
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC4A39BFEE;
	Fri,  1 May 2026 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnTolhOI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E9439A818
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633343; cv=none; b=DTgGzXjJdNtl7KBQKysWdNLzIHwGUDMWkQWHsCyKcby1+VaHa8zUGo7Z3PFR5MNdh2mJ8vo5uJXCM6qTAydQwmSQjZGbckOHEczc4CCtmE8E89rNnLnjyZOQSs3LlWjpTNty13p5vQnCHCoHSGNGE6r35L0btawp9TTjBywmHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633343; c=relaxed/simple;
	bh=e96F4VL0FqghnjCcfD5j5AlSChhZ6jZluo6CEFl4jqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx3uAWb/ujRL8JVgH/HauKXyXcnbXCBeEkt/8uMswFFDht9Q0CFZh1v1/q5DlJkX3yCDv//ldamWVO4w+ml+0uWx7Pi1kc6DmjJguUJKnvbMvaphvaXcmPdhJHieqjVea/thPVc/kXf31xDMI2Kmr/e3mwpGLTyqab1foYonXaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WnTolhOI; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso16096935e9.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633340; x=1778238140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8YgggC+mPdbH7rnccFGr/mooO19vkDnSnGo0lHMmlI=;
        b=WnTolhOIWmbDz2RYtAOoRocfSl7akvFcw8CR9SyNd5auy33oaOR7OwiLojc8PokBCU
         vhnsWpQgXojrgCbZhd24FsWAhgsXhhIe4pz8kaVaEI1bEHMGbQk+DDh5MFqYfamJBunm
         pAo87wZvrxWStPugMN+kfPqjzzY5r+DeTl1AC5tckoJcUV3lLNihAO0TtvwsNDDbU2Ri
         DuYW6rWVYnkB7Y+KXOUyf2Jm6g1UK8fn/Ui/16tz2O9J2ZSdOCaIeogfhHSuMX3MEvnj
         CVIECKGkmz6PC+RWWXm+t12xFStGYcAOER6JSXSwBisVZZhdZaWLelCkhXLyLUnzoelJ
         72Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633340; x=1778238140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M8YgggC+mPdbH7rnccFGr/mooO19vkDnSnGo0lHMmlI=;
        b=IKSDSWazNQ1MDINy+nFFyrRjqW71gWUxM7X6iHi9sRqqv24FqIV5FgbRX9aQvj6Ib1
         ZL9dZxTDMJcvFj2y+y4pTRMOOV1KVROSWa5z/QYdLVofnuGb+xCOggJWCK9xxMcGIlzE
         LJ6ZRc9cgi7QmV0XqV8xmn17ZRSgcqOgY63xYHUiotVNY7ihmU9OKc6gT0D9hDWzm3v6
         yuRVq0CkOKCaN6iuZILFtCebXjufu2tVGmJca5CZrcONkXUq/399ytb+kzkpCjTSx6r+
         HU0FMPlHZhfkf7AFoEX6mu0knx/AS1pFXQT4qKclsdLVkZ6Tn4YLEqH9+4RZKHRWrv/y
         f2fg==
X-Forwarded-Encrypted: i=1; AFNElJ+3MjztJ3NFy2wvJIHo/BgML0b4ekwNdMBNP9OLVUEmLqaT5onhazEbDWAKosDLs/uxMc1mUZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1NVnz9a9XwyG6XyHdH+gJq2lZGR7naNxWMOQ5UTythYWJECz6
	x7HAG5/Yz/E180bXijwLj6JZpNNzzkXP6qojFdmqsLJBVA4RpMuHGdY=
X-Gm-Gg: AeBDievmQTtMgct0J5D2+ruzVAuOIBe9e7Hwzf9qcDnhvAECLrLQue/+mgaHXaXdBX4
	O/ADPF70SQqQXzLMffS0mbzEnrivAmYnwSGkB/vA1r9MD9LtJT5mJ+lltuYFTu95dUbA5OD1fqt
	zQ3DPuRcRYIfiXseP1HPkywHH4NvP256G2gtWOYEKESAYu2qNsJx9ohhznn6eXryhzER9t3qE0D
	mfVBND9G09F6GUQa1PYthhpGvtE1B1Tsc2zlcFzjt657Qrq1Mgw4avhX+os6H29OP+gMFxs88kA
	aEC13ZgiSyxsZH0MFA0nJwvSdCkCinW1HXjWdpETWgdeyV9Ix4rhNWTob0F0a/99oR04WV10Nnv
	85d0RCMqtf242pLE+qaWjsR4Wpr94XjYZJtdxw1ege5zbduRLL1sKTCWaepWpSJWW4CTvTaNQYO
	QFhv0=
X-Received: by 2002:a05:600c:a40e:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-48a83f6e2e9mr85879755e9.1.1777633340022;
        Fri, 01 May 2026 04:02:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm121627405e9.4.2026.05.01.04.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:19 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Subject: [PATCH 2/3] hfs/hfsplus: initialize data buffer in hfs_bnode_read_u16 and hfs_bnode_read_u8
Date: Fri,  1 May 2026 11:02:16 +0000
Message-ID: <20260501110218.29906-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260501110218.29906-1-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4ABC4ABD4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242292-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,217eb327242d08197efb];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]

From: Tristan Madani <tristan@talencesecurity.com>

hfs_bnode_read_u16() and hfs_bnode_read_u8() declare local data buffers
without initialization, then pass them to hfs_bnode_read().  If
is_bnode_offset_valid() fails inside hfs_bnode_read(), the function
returns early without writing to the buffer, leaving it uninitialized.
The caller then returns the garbage value to its caller.

This triggers KMSAN uninit-value reports when a corrupted HFS+ image
has a node_size of 1, causing rec_off to underflow in hfs_bnode_find()
and the subsequent hfs_bnode_read_u16() to operate on an invalid offset.

Zero-initialize both buffers so that callers get a deterministic zero
value when the underlying read fails.

Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=217eb327242d08197efb
Tested-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfs/bnode.c     | 4 ++--
 fs/hfsplus/bnode.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index c00645a4a5733..08307faea7a68 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -97,7 +97,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
 {
-	__be16 data;
+	__be16 data = 0;
 	// optimize later...
 	hfs_bnode_read(node, &data, off, 2);
 	return be16_to_cpu(data);
@@ -105,7 +105,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
 
 u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 {
-	u8 data;
+	u8 data = 0;
 	// optimize later...
 	hfs_bnode_read(node, &data, off, 1);
 	return data;
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index f8b5a8ae58ff5..35790085b5b2e 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -55,7 +55,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
 {
-	__be16 data;
+	__be16 data = 0;
 	/* TODO: optimize later... */
 	hfs_bnode_read(node, &data, off, 2);
 	return be16_to_cpu(data);
@@ -63,7 +63,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
 
 u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 {
-	u8 data;
+	u8 data = 0;
 	/* TODO: optimize later... */
 	hfs_bnode_read(node, &data, off, 1);
 	return data;
-- 
2.47.3


