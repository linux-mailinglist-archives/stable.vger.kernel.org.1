Return-Path: <stable+bounces-242291-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LK2A0GI9Gl3CAIAu9opvQ
	(envelope-from <stable+bounces-242291-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:02:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C0A4ABD2D
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 087693006107
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EBD39B965;
	Fri,  1 May 2026 11:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNjju8WS"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151CA39A7EF
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633342; cv=none; b=eapgcqve/Gs8S3yc6y5NW+jWKFcyCCykOGrTo58dUBDncqQUqA4iUcjp7yhohyh0peHYoAgck2ykVx1cYEfpNES5GTUBr7jKENrjUoVLybedw8scBySm5bV/pVGLefkizMejDrDYr3NGHFUFWuIORT5iCLxuaup4eyEDRo9ZmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633342; c=relaxed/simple;
	bh=6q7Cse9LTZEajpIegGdnRfkT5EI8IG2GJIGVRzPO0tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuPzszAU1xPCQLhCJuGmR4J14TFiGfb1mo+2YISQlBoAIIOTZQ2k6U82q4scwNRLyzv3CbxIzZB8w/aOkoCc497FNf/z0WJDJ0zm/Rm6pdZmm+2ISz52MGcNVycjHzOWpe9UyTO9USYDsgcuTeEcSotGqzSasQjUtSGfMqumiFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNjju8WS; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso15400655e9.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633339; x=1778238139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+eCDUN5/k1aTUcp0ocOWEOuyZhFTl6ujThN0C1b1A0=;
        b=BNjju8WS4lnA/Alb5bTNhxbGspl/940t68iZBlNDpyqPt1F5lQc04bfTvt0/2vAOWk
         nthzTPpNDR/H6bqdX7T3urcyO97P1LP/tl1+CC3aSZE9uRrdSIlombaPWPrPS5+q0Ixu
         XRDZGZyQ7e4zmZIRtTzOwUuoINLT0Ak0Y4Q8Sv2S9WY+O423cVQNOPxysCTxejUXIeB3
         iyMdwDG++oN0LGiBFq4nOZ8X1KC6jXFSkIEj0gLlHd/DT8gg/KE9TKcnTgssThmeyQYT
         u9t5X6r2Iosg0JsqNwMcy1zzPwTs6U4CD7S7KuNJu6DS/tk9gI9VrhH5AhJhvPqo7Zus
         GqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633339; x=1778238139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+eCDUN5/k1aTUcp0ocOWEOuyZhFTl6ujThN0C1b1A0=;
        b=pAkfWkNnXcpRoZSW7u1LdrCQmSLR0/jXN3oJCIN4GaWQo6b4PKlMYznT0iYJ5s3Hh7
         2PSCoIUZZwPzeVBGJGDzmZjMC0nUnCbxdG826eRf8GRJ2z4bMhm3Ce4ur0+BOnNiiwdT
         x6dv2Ovbcvo/x1FvO6PcszxZdKGD96M69xsdIiemT3hFUdNrickL9LZKHvQuuIn88tVV
         6jXEm7j8tQ1s0omeRV7jETY2mAWAiZau1+frLzyHgkn8XzmdrxjqaSd/ngOoYvo2kTWo
         YJNV3i8X3QPfIpaXTQJ0KHIiRIlR+C8HQE9SBUgDeGVUSv2YNUMWercqU7alS//wndzO
         pm0w==
X-Forwarded-Encrypted: i=1; AFNElJ971quYHA5uQrrMoKWJXbrLmXQB+rDKq3LMxoIaGWx0hYepGTIN5izf1KKbFw4DmaVHMzrDnsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymqyiZUfP+rJ0vHVtleArrBlMw/ivRSuGlEHaw0nj+zUvHxTfO
	Q1/vocQw+EnDd+/7jc5pZjRF0PWuX2b6NWZxwSOXjU7TBjoNVDXoNZc=
X-Gm-Gg: AeBDievARyUmNKUD5p+qUKl6KQQrbfD5mGstDEsFH7K+HcJLll9Krnuht12dXdjzFUJ
	mPg1efkE+eXIJAluoox/4Ey2veex4svDNgIem6ylv6FEaP9pZCoU4J9RUcBArhuytpud7PDv7ie
	R+9nAtK62tScZ3zVSJtDwszuy4Bi0upigxgNGhIQXC37gi9TYSeWLCFD1BjQJY9q3j59SEcn7q/
	d/RgfD/T35mL8m1+9DzA7g07cEo0s+8o+D63ZfTVt6guRKADiWSih5UlvBdKRwgihAzVBQuIIV9
	rgAUgAqfXoeGOp31WPw0CEIM4Y6Q97gyf+Y2LUqzNe3xWTfBubuDg//80ZMMBC5rBNDzour3q0Y
	XUh7eJl5xVktarDXBrAdZuNzcC9EUd3FeGyhVJSLyTmb0qtAd6SIUVkvHgG9KaaFD4HPBIzkEdq
	7HHC8=
X-Received: by 2002:a05:600c:a00a:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48a8eb73a3cmr38267405e9.11.1777633339156;
        Fri, 01 May 2026 04:02:19 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a820c8556sm121627405e9.4.2026.05.01.04.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:18 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com,
	syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Subject: [PATCH 1/3] hfs/hfsplus: fix u32 overflow in check_and_correct_requested_length
Date: Fri,  1 May 2026 11:02:15 +0000
Message-ID: <20260501110218.29906-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C2C0A4ABD2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242291-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,6df204b70bf3261691c5,e76bf3d19b85350571ac];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]

From: Tristan Madani <tristan@talencesecurity.com>

check_and_correct_requested_length() compares (off + len) against
node_size using u32 arithmetic.  When the caller passes a large len
value (e.g. from an underflowed subtraction in hfs_brec_remove()),
off + len can wrap past 2^32 and produce a small result, causing the
bounds check to pass when it should fail.

For example, with off=14 and len=0xFFFFFFF2 (underflowed from
data_off - keyoffset - size in hfs_brec_remove), off + len wraps to 6,
which is less than a typical node_size of 512, so the check passes and
the subsequent memmove reads ~4GB past the node buffer.

Fix this by comparing len against (node_size - off) instead.  Since
is_bnode_offset_valid() already guarantees off < node_size before this
point, the subtraction cannot underflow.

Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6df204b70bf3261691c5
Tested-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
Reported-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e76bf3d19b85350571ac
Tested-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfs/bnode.c          | 2 +-
 fs/hfsplus/hfsplus_fs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 13d58c51fc46b..c00645a4a5733 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if (len > node_size - off) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 3545b8dbf11c5..10b2dda3f8044 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -600,7 +600,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 
 	node_size = node->tree->node_size;
 
-	if ((off + len) > node_size) {
+	if (len > node_size - off) {
 		u32 new_len = node_size - off;
 
 		pr_err("requested length has been corrected: "
-- 
2.47.3


