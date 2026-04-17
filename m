Return-Path: <stable+bounces-238515-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zeQMF2uM4mkC7QAAu9opvQ
	(envelope-from <stable+bounces-238515-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 21:39:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E5F41E538
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 21:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3127C300863C
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96ED302140;
	Fri, 17 Apr 2026 19:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDvWN9va"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B018BC3B
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 19:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776454757; cv=none; b=Qo71Y7NjC3/xe0YaDYxHwDjYknGQ8rAB3ySMhuheX/KcnXi0epDkS8rdfVYpk/J3MUfE7gntW8iGdWIPADlL0kVlcGsvPQqOPfpHw9/zDlRnxYDYSJNqFxSX9ghfRcnkdOfJxV0tITu+3ku3ycfNX3m3OLqjwKGQ0AtsQpf/sUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776454757; c=relaxed/simple;
	bh=NJ6/CANuGl3odwtb7ysxZy/MRZxYmQz1gQeHADHI/i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tHHKvkkX+pPuycwZikfaabT5hSPiooUsnb5je92SBTD1vWoF4w6XyAD4k0SZXY15X1qRp5itOSGkNAofDT1oLDd/Xni9AxjIvUPiniaOy1xAUyfK4vMvoexExN9bpn0qDzBzXWpWBXPTGOZvcWCPQiUzCm56cmT8TVcvQa48doA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDvWN9va; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ba6366a7so13706665e9.0
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 12:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776454754; x=1777059554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+guEPCIISTmp6PybkOSuXnNzgmVvlfkjaLWc09D5zw=;
        b=VDvWN9vaZTGPFxrTfm7EVkvoF4Y3X/GVXZZuXNsfEbnR6r8ymhgUpDi6hwYjAZE6Kc
         9lQhEhY+CgkHuGejfYTKfDOtsEEbrLVWuWB9yYQhFbh5tT3aezUcqAhiknhmYrGHvjGm
         QQzHJrK457Rf1HANYgZ061i6mwpAxRYVPE2Ermk5k6DEhCMnNEZqOXZhAKxfreY4jTMc
         ryi8HV+LTMFICIo4oNVieIDS0cTlZDd+ToHNOXtYBe8bw2XM/rJibQhV1GOyi5pPoVDI
         nTwAApzwMwAtVhLk+Fhab88Jiimb5HLCkzxdALRXdx8ocDx0kRTcWq7w0RdBgvYyuOkT
         OYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776454754; x=1777059554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T+guEPCIISTmp6PybkOSuXnNzgmVvlfkjaLWc09D5zw=;
        b=Fu9ra29hDRkssl1oygbZonR+5YPoEvFf4Lk4THtpurcJICrSTa5bCPVpR7rbHc/H9z
         KfbCrb5NbZX6NI+ZmglmOTzq3pFeEHypT4zWPlEvAGzjArkR5Ap3tK+s/P5t0C3bzYrt
         td44BXvX4hrotVESkSuzAe4WGxrzShnh0fsV+/+dMisbq/U+Bl73FfDHTIg5+i1HwhDj
         2hvY0uGvm6WuMz4c+3hBhPXX4XbaAv/eMMByROVGD5bgQiDAzFbRzxA+v3Jzz1uWH0P9
         NnIBJYSPF3yF9n5UF3nseJc1gNTo4OGoSzg7nzu83ZvPp0N3relMSdPgjOV0CqtzMy6l
         m7bQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qF5vOHuBUdXtWZWisOo2pB7AOpGKZIZr1unwELPCSTm9lcRvmC6QYFzTdHlq0aQ15fHf2EC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuBidZIdFCLVP3r4GNOMjiIspplmngNZDX8wPevEsnrZB+0z51
	UI8iD5Pjl8wQm3nMwsXuXqxlnlnpzGvARUZffonHevcmNJN2bwp4ahI=
X-Gm-Gg: AeBDiesCW0jkrisxOMcrYmnrv49g79wRJnad8HRkVVVMvgdM+wu6It1v80nunoKSEUn
	+lYHMBXdwJwa5/dre4nbUJ1Sunc4kMxxkzSrD2rWdwdYwuShmy1vNM5Lhe4TpghX2aIHSX/bKC7
	sciVIReMQzz6rQBVkT1SbTxG3qybxDhwaVaOTuQqogqpU0ocnNOK2k6pX976f+G7vLwhAuaPabu
	Ldu0ndCHoj3IkRwSX+N65cVw/S+tF6ScLOfkItUKOL2vk2vij/BfWMYEFrmDaGnJa0zigfGHmNB
	QoMKV09n/Z5JjJDuILQYJPstjHV2up55yd0/ltBM57bKEn5mPEkGnW0ZiZBOgSfJuDpxcX/acao
	I2GVjeBuHqPEUDEQ05N4RdvE478d3ejIH8dYJYu8cAkNkWn4cGX0SuRLPlyI4yKhP1/9D/tA4JL
	zZOW4krdgquMDuVAvh
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-488fb7844c5mr70072535e9.27.1776454754460;
        Fri, 17 Apr 2026 12:39:14 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm62834555e9.12.2026.04.17.12.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:39:13 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] hfsplus: zero-initialize data buffer in hfs_bnode_read_u16 and hfs_bnode_read_u8
Date: Fri, 17 Apr 2026 19:39:13 +0000
Message-ID: <20260417193913.338982-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238515-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,217eb327242d08197efb];
	NEURAL_HAM(-0.00)[-0.938];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 49E5F41E538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

hfs_bnode_read_u16() and hfs_bnode_read_u8() declare local data
variables without initialization, then pass them to hfs_bnode_read().

When hfs_bnode_read() returns early due to an invalid offset on a
corrupted HFS+ image (the is_bnode_offset_valid() check), the data
buffer is never written and the functions return uninitialized stack
data.  KMSAN flags this as a use of uninitialized memory.

Zero-initialize both data variables so that an early return from
hfs_bnode_read() produces a deterministic zero value instead of
stack garbage.

Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=217eb327242d08197efb
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/hfsplus/bnode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 14f4995588ff..4404cd35c192 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -96,7 +96,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int len)
 
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
 {
-	__be16 data;
+	__be16 data = 0;
 	/* TODO: optimize later... */
 	hfs_bnode_read(node, &data, off, 2);
 	return be16_to_cpu(data);
@@ -104,7 +104,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
 
 u8 hfs_bnode_read_u8(struct hfs_bnode *node, int off)
 {
-	u8 data;
+	u8 data = 0;
 	/* TODO: optimize later... */
 	hfs_bnode_read(node, &data, off, 1);
 	return data;
-- 
2.47.3


