Return-Path: <stable+bounces-230792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oODUBLztx2mcfAUAu9opvQ
	(envelope-from <stable+bounces-230792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 16:03:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C64C34EC4C
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 16:03:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BEFF3050213
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3CF344DAB;
	Sat, 28 Mar 2026 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbuL8wGv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15196199931
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774710050; cv=none; b=JnAn55Yyneg5xJSWGlJoteS/wFjuzHAY+Nb6FneR5Z35ZZG9KfSvzmyp+2eoAVJSXQLydSd+LlVyCcCLrV5nKMesQiwQl5tXmAKG/R9bTeaXZLaW2FX5kOUtmq5iIVSBuEBAfSVc2jvla2tQvH8eguE6a2actSIjFg0A07dDnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774710050; c=relaxed/simple;
	bh=8ZVqhZ/N1PdMAWTWRuymqWQ5zXGNYBpTlwAycXGZ7jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L1KIy2sE1mDXv3x7IYm8LpV2amG0PX/vxp89HHOHWapMMA0y3JbTBJFhM3P5iybQEPGdx1EsVweiuKwiq07TlNjy5O9pTf9/Lrgelc3SgQ2D7OLlWI99T44CkstG2GeMWOpqm4Uzz6ub3ssRWX6DB4XQcqRl8IVRqFXlGLZ6qFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbuL8wGv; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c742723c863so1949536a12.0
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 08:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774710047; x=1775314847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUWulkuc6nwiMpNnsS5d9tfMi0kH9Q6gq1CmIp5Vans=;
        b=kbuL8wGv6tOTfB6Mm+UCbmak+ITUN0T9IoThMlQrYgX5/7R8YxKr8jq24lKBpUdBYx
         MPcAisMb2Uobm7QuR4PBwrM1tkXMd9R2/BUHoadOuJ6fq5HtG8tk08cj4InCx/EPn6X0
         jypmyvwvhJhvCgRtDyG/BfdIkLZL3uszZFsh87EgG723raA1/4RsBARL/0tXVieTv062
         cFJBHIA7d4ZpjPFMgsuJM5Xip132ikyGgFgIamIkyBM1MItOirTcwFa0nzAzb4HOOCTN
         LJf/ov307sQWLONcKcwGtshk8cOlMB784VqF6/6b9VViv7uhQmXAwqeW7tS3csgpNeM1
         YQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774710047; x=1775314847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUWulkuc6nwiMpNnsS5d9tfMi0kH9Q6gq1CmIp5Vans=;
        b=CGYrOmskQp1uqvDQLnLi7kAKFNN3BJKR3orQuzhNRQo9jVPJMUzaws4StPFehj1sTs
         EqZ2zKQEhu+m2h2GTOpBROsANA6E/pBOl4oRVlqdvw2cWVC7zrnMDwKGjS2WI87JpS9W
         mAxb6e+hZLG3w7fc2EKAs0cNmpx3TUtcq3CAF5YeDxMBfXBidYTwU6yQ5Qo1i6HEnHHj
         I0VBO670JrEltfBVlOaqu6/F0NOV78kM1pjXLvlGe5FgFE9n+I+taS3t4YtRP+oJmr1n
         abMwcmOwIGBfdfoncF9EmcIOCgHch07xjUNoC2qEadXB2qb5fcb8+7Qy+e464eHSFKTI
         d65w==
X-Forwarded-Encrypted: i=1; AJvYcCUSdjUgpI0zxSA7P+K2/lwzywi9xDw5S9s9eIwaUUIpSbaD/JYJWGjMV7Cp/SC1cP0qymJnMXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYCXup/EZ8vhH8RMiw+YWPgv6VRUXTw44jRe5DacKye2SrZF4d
	YBEIu7ehtw0K7YkEG7cnd/XqfGNcliEn2pdpwQeGWKsj2Alkrl3O4Rqf
X-Gm-Gg: ATEYQzz7nXVWjJ75sbZF38Yzc6yhBxY8vjD+E1SAmRENstGpyMcUbAZLD3ksER0cqc6
	W45Xb7GUFrKY9kuRXEuMewxopK8pg83MrjX5KwuJhCtCL44oZ6FZu1VT4y3Svg74ZeM051owCXy
	ngvXYpfcrxOoq2cVcirRSD3tGDG/OFba8YiGElgbLkkCL0+N5Ib3cHuzk9oJQc4E+VQeEEf7Qm8
	LM0nSb0WIxpSRxu2NiwwfQyhQZrVgxGYmMDGq+MHG4WHGXNclg1u9jQeohXc0IMfvKGkHnFYBdl
	+QJp4uaTXFxQimmniGaXhGkypWpyWs87GqJuYx67vPoDR/w1d+TniWPT3oyYyR98ph2JLKAl0Gt
	kSHuBDum92Qe0xhQmtWDmxJHkfAjWrWtV5G80vDgCwkWjowQemW266JQRZpWgeZheg762qMNEgX
	e9LwVzT91UPT0yUOhEp6JdZ9SBERfDMmzpp2qbJqtT+S+Z8edKOzbWLfB5/zIqq0cmE8XqbPrdB
	k4jawuRQfAoGVjiuA==
X-Received: by 2002:a05:6a20:a12b:b0:398:9466:2eef with SMTP id adf61e73a8af0-39c87812061mr7154979637.12.1774710046987;
        Sat, 28 Mar 2026 08:00:46 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:7beb:e3a8:8b1a:3a0d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85fc6e9sm2653328b3a.46.2026.03.28.08.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 08:00:46 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org,
	syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Subject: [PATCH v2] ext4: fix bounds check in check_xattrs() to prevent out-of-bounds access
Date: Sat, 28 Mar 2026 20:30:38 +0530
Message-ID: <20260328150038.349497-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230792-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,fb32afec111a7d61b939];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 6C64C34EC4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The bounds check for the next xattr entry in check_xattrs() uses
(void *)next >= end, which allows next to point within sizeof(u32)
bytes of end. On the next loop iteration, IS_LAST_ENTRY() reads 4
bytes via *(__u32 *)(entry), which can overrun the valid xattr region.

For example, if next lands at end - 1, the check passes since
next < end, but IS_LAST_ENTRY() reads 4 bytes starting at end - 1,
accessing 3 bytes beyond the valid region.

Fix this by changing the check to (void *)next + sizeof(u32) > end,
ensuring there is always enough space for the IS_LAST_ENTRY() read
on the subsequent iteration.

Fixes: 3478c83cf26b ("ext4: improve xattr consistency checking and error reporting")
Cc: stable@vger.kernel.org
Reported-by: syzbot+fb32afec111a7d61b939@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fb32afec111a7d61b939
Link: https://lore.kernel.org/all/20260224231429.31361-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
v2: Move the fix to check_xattrs() as suggested by Ted Ts'o,
    instead of adding a check in ext4_xattr_ibody_get().
---
 fs/ext4/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7bf9ba19a89d..c6205b405efe 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -226,7 +226,7 @@ check_xattrs(struct inode *inode, struct buffer_head *bh,
 	/* Find the end of the names list */
 	while (!IS_LAST_ENTRY(e)) {
 		struct ext4_xattr_entry *next = EXT4_XATTR_NEXT(e);
-		if ((void *)next >= end) {
+		if ((void *)next + sizeof(u32) > end) {
 			err_str = "e_name out of bounds";
 			goto errout;
 		}
-- 
2.43.0


