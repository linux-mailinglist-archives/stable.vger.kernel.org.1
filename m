Return-Path: <stable+bounces-242298-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ1qMsiI9GnFCAIAu9opvQ
	(envelope-from <stable+bounces-242298-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:04:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 368394ABDE5
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E303D3056ED4
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3D039B496;
	Fri,  1 May 2026 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IotO8lox"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A480C3603E8
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633371; cv=none; b=aRuYgkNVV4XPm2uZQAzyOLbZoWbywjfdTNiouOhOP+Qpszwr6N9MyJw64q/0neVNlHdJl3L04kJKciQ+s60ubzvblcgpWlFBeFvaUNFSVHPT78KpCpOw/9sHGuy1DGu+XjgJ98fPUFe9IHuymtIlS74+zJdP9cv29J6zB43iMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633371; c=relaxed/simple;
	bh=6HjCTBRsWx1vc0YtSk64cmudc+766gGE5dQ+9vFy68I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuJtzCfMpbWucMen8u4edKnnJ+4B1D/ULzpUu+nljXGJFji9xCB/ebKM3mRpBB9wmW3SKf/w8agfrjN1AKTRzyb/Jrir7WomC3V6fl7aUSi75Dz0Ool35g0l7YlBz/5mCmxBlieidPFtR9D1tpYYe98FjhwnqOjl9ePPHNZGPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IotO8lox; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-488ba840146so14904465e9.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 04:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633368; x=1778238168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t+8L5WJt5aFDWaIjaWK7lYM1zW6O2ZzLXWTAE6+TQR0=;
        b=IotO8loxjsV18VYUuL5BmYZYtk/bnjvkD2FlvccTKRjw3EmLvxhUWBOk+pwk9DTX/F
         5D8SvUoqtd5IjrbaPRPzCN/Ze7JuHx1iBBJxWE4Jdw4sZVRPzuKPBiB6BObrh3yFdQNh
         PzRENywIb8rDvqL9wOCITFiqWsecYs+P0YiK9guow2u1SEFmml3uVwOiOVp/lQ7WIS4j
         4bhr8woElvKzkXONWnQnnEXgIdQ1YRjl+eOTwErWn/a2DfQ2He5iqXw9Bv2azzPZQRBr
         Rg3qxend6IZ/gMljqWiwb/RL/FtAZD1GmEfcyjj+RItimw/513L6drBSVdPX96fJFNym
         HfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633368; x=1778238168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+8L5WJt5aFDWaIjaWK7lYM1zW6O2ZzLXWTAE6+TQR0=;
        b=GEVIGRZZQVptbXAbib+CE0gNuHBMzFYJClvNtXLKRrj8Y3VJ0zo+NqytbC8GEAXJFB
         tAzePH0uyyYdaq9Jyh3GX35HVcCP5Ku28v8GmAhakAGB8ZVzNZxQ3DHYMRvk6QUef2uT
         L1dZZGMcxJO36DcRDTSOWN6uMRIF8zbD1F0nbwJxacJ6NpgxNcbiF14jrEUyNJU1Zwxl
         wC1uuh1ZCe5IAq4c72PlQgefKftHo+L9cFnDu8Q3gQYeoCYplWT/yd/tayF+riFiURRG
         DKJg327NIhhFrmnWocIisbFJ0gl24UrniaNrOxmgXjZw/0qBd9nd3O5yM4VuxI4EqtQa
         r4RA==
X-Forwarded-Encrypted: i=1; AFNElJ+54RWDfrCnwx7eP3R46K7fElAC1O7QSZuvq9Yjbl4kGDiQGz4RsJKs9QAY98PK85ZIEOFU5g4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTXMPrwKipgjqrnd+P5UKxBv4aReIj4xorTswSDquA0kQPjqNU
	44q+hB0S3RVHniW9gESt1ma7cXcy9qI+fG7zFELtdqtJ6yXUSR9lY3lbKSDqnN8=
X-Gm-Gg: AeBDiesvY861JP0wurheYuHGRrT6NrzcWWbDpco1Oi+X+eNsuFU3kZGcIpbHEh2BY3P
	+57Dn/ZjP/h/hHqWrcp82Pxu3ReHDEzln42V2tzI/JszAKf9cPZHNxmcvdwJn6kHjRP7EFVAPoT
	u1D7T/SqfNaC8O2VHZOpLdLoLm+pBjlMu8VHWRRBd5IEsPRTakxFCl27uXULMlRqfh25xK3tLIN
	ttkKFWEUivsfUG1rmf3XaOOcOZlirDbun1cAUq/4vkdisNoV3m/d8/l2WaldeOjsTNkv3t8aWR/
	UD6DcRhvJCNX4DdvhcdZpj6wxfXvCS19nPSvnloP/k3PZXbjobb6D2DhyM7KyIPMSTa6VWqrpAx
	uMxs8aeGCZPwq4KDsphawaWFXcMs3t/F/5cuG17aPDOjAxGXCOzNfqyn8ofxSI5m3NMQSeFoalJ
	64vtvTcBziyMdcQg==
X-Received: by 2002:a05:600c:8901:b0:48a:7a10:4f47 with SMTP id 5b1f17b1804b1-48a83d6e15fmr81071565e9.3.1777633367941;
        Fri, 01 May 2026 04:02:47 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb3427fsm79491905e9.0.2026.05.01.04.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 04:02:47 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>,
	Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	syzbot+e84662c5f30b8c401437@syzkaller.appspotmail.com
Subject: [PATCH 1/3] jffs2: always stop garbage collection thread on unmount
Date: Fri,  1 May 2026 11:02:44 +0000
Message-ID: <20260501110246.50647-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 368394ABDE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242298-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable,e84662c5f30b8c401437];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]

From: Tristan Madani <tristan@talencesecurity.com>

jffs2_kill_sb() skips stopping the GC thread when the filesystem
is mounted read-only.  However, a filesystem can be remounted
read-only while the GC thread is still running.  In that case,
jffs2_stop_garbage_collect_thread() is never called, and the GC
thread continues to run after kfree(c), accessing freed memory.

The GC thread accesses c->gc_task, c->gc_mtd, and the full
jffs2_sb_info structure during jffs2_garbage_collect_pass().
After kfree(c), any of these accesses is a use-after-free.

Remove the sb_rdonly() check so the GC thread is always stopped
before freeing the superblock info.  jffs2_stop_garbage_collect_thread()
already handles the case where gc_task is NULL (no thread running),
so this is safe for the common case of a clean read-only mount.

Reported-by: syzbot+e84662c5f30b8c401437@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e84662c5f30b8c401437
Tested-by: syzbot+e84662c5f30b8c401437@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 fs/jffs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 81396a092ba88..c846b435a38b6 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -345,7 +345,7 @@ static void jffs2_put_super (struct super_block *sb)
 static void jffs2_kill_sb(struct super_block *sb)
 {
 	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
-	if (c && !sb_rdonly(sb))
+	if (c)
 		jffs2_stop_garbage_collect_thread(c);
 	kill_mtd_super(sb);
 	kfree(c);
-- 
2.47.3


