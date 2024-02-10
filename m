Return-Path: <stable+bounces-19412-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF3E850632
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 21:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE471C23D21
	for <lists+stable@lfdr.de>; Sat, 10 Feb 2024 20:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015B15F55D;
	Sat, 10 Feb 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ow1Jg4rr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053E364BA
	for <stable@vger.kernel.org>; Sat, 10 Feb 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707595976; cv=none; b=uIAVfF/Ohb3VgA/b3gbQNFPb2/zj2tMA0RrQ/hU+T8NknxXSHJXgjI76jET2vsyo21mW80TVv5kX7yqxZt+Fg8jhIb6pWYh3mFROMQnRzlasNlyruxn8DpO/zJarQRBO1wl3ekVdb6gkBweLyw+Qk6xRw8gHuzWGYtdt/n+l+Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707595976; c=relaxed/simple;
	bh=1STC1V9YMx8sKQ6UuBw95l3TuyTGTcksaTaO2vuD/4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T4/Zv9tnUJ1N0Ir/blXtr1kPi2qyWJycvSMDIN6K/mZW5z8QZ70/lSrMCgpJMCpiPuyMatUiZYMUu92Qtw1WiXou/0FAFgIbEFV1V+vAZoSRbtkIDHZexQVQ1y0pvv9ZS5LD6ASNfpnMhKgLdxs08sMd34SYyCu2bUp1TbVAe5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ow1Jg4rr; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d98fc5ebceso11795585ad.1
        for <stable@vger.kernel.org>; Sat, 10 Feb 2024 12:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1707595973; x=1708200773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FG7TDb71syCopJ2EmqI/veNex007IgIKbGD42LrMjA8=;
        b=Ow1Jg4rrZfZj5FdcxwIsseBd3c2R+eFqS7rW9lOanWOZfg7V5SR1dCYpf7gSPzd7lI
         2PXM+365tWY760lWoAWFsAAKQosHr25f6jdfDQmJH75r1kefhkipkoI6NfgOalnfQIk9
         H1YyzTmnN+fQRyT3JguK568jdf9BX2yYenPmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707595973; x=1708200773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FG7TDb71syCopJ2EmqI/veNex007IgIKbGD42LrMjA8=;
        b=IXYyr78pEx6VKIZXPbNYj7GfxSNF39cft9sKV+Jy52LWE7R8YR6SzxO20RxpGFwFQC
         1NCDQip/WkME3F7+PousjoNvyojKmDl38pR3jvY0anGFE/STrpSzy/Q/sPUSFWM3987s
         Kp6CfCcfmD6LTIIk4q49ZfM8ocixBMdcvFN+haq3Cnvweo1kEpGrq4VgQ+4ByQEO4yIi
         25J79wtFzV6ZLt2wy31PMBydlTLfrA3wBqRuqYbNOqUWGkXrwfgSPNXJffIO10YEJXSv
         QP4qif7ss/nz8eTi6xze/skYgYVZuA8K1bPU9Bv/0rmjsaoW8H28/N8knu4H96jYdVXo
         4Yog==
X-Gm-Message-State: AOJu0YzYbKij5/EUTfYgRMBJMU7MgLIl/TN8UW2wTmVWQpsDBKwiD2Y5
	6ZvenH4JbXLLgNztMYxxEOdQ4AxFAcgPJePdLQFnrTBeLhtGzREx4SSsdTBh+Ue9AWNMQ8IeKtQ
	jkevQew/dzDPVxW8ueGFklnTY4V2Tdt9YZGgMvQSIP8Va8uPDTrrKxOfAqq6c+sTDSoaCuzvOgR
	20kABDSQwoXYtM1k21ZiYG4ca9c4TeGqLgpSOspeU2QhmbkDkpfiL4kmw=
X-Google-Smtp-Source: AGHT+IEf1mK1eAIky9ZNzAI4Wkrz9iVSASFTrrBznliLrxZBDO0TOcOLa0lh4gm6WrF5SJHPh6+qDA==
X-Received: by 2002:a17:902:d904:b0:1d9:924c:c9f4 with SMTP id c4-20020a170902d90400b001d9924cc9f4mr2139918plz.67.1707595973023;
        Sat, 10 Feb 2024 12:12:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdInRV2EHYcjIViBQAniHdQWA/eU/asFbAyUNN2rkv/8UqDot6NHZaDcf4h/CQVB8fxfjkF6wGO9KRmp/RPqa0vGF+jwziZMNL79Eiqec4C/0dgxbqJkNhrPI91nCwUFS88toJc5gEsB4B4Y7XZJAtzpYNmIryBtTTCsJSTWtr+t79aLIZcRE5zk+hR57uvldU6nV00suIrzrDs5oIQ+25725X+soSlhzCdtDKkFlZIVWvCpbBXZNsiH3ftNUhsNP0BFs=
Received: from bguruswamy-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id f6-20020a170902684600b001d8da07e447sm3503527pln.9.2024.02.10.12.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 12:12:52 -0800 (PST)
From: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	tapas.kundu@broadcom.com,
	Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 1/3] smb: client: fix OOB in receive_encrypted_standard()
Date: Sun, 11 Feb 2024 01:42:34 +0530
Message-Id: <20240210201237.3089385-1-guruswamy.basavaiah@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit eec04ea119691e65227a97ce53c0da6b9b74b0b7 ]

Fix potential OOB in receive_encrypted_standard() if server returned a
large shdr->NextCommand that would end up writing off the end of
@next_buffer.

Fixes: b24df3e30cbf ("cifs: update receive_encrypted_standard to handle compounded responses")
Cc: stable@vger.kernel.org
Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
[Guru: receive_encrypted_standard() is present in file smb2ops.c,
smb2ops.c file location is changed, modified patch accordingly.]
Signed-off-by: Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
---
 fs/cifs/smb2ops.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index f31da2647d04..867b32b1393f 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -5153,6 +5153,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	struct smb2_sync_hdr *shdr;
 	unsigned int pdu_length = server->pdu_size;
 	unsigned int buf_size;
+	unsigned int next_cmd;
 	struct mid_q_entry *mid_entry;
 	int next_is_large;
 	char *next_buffer = NULL;
@@ -5181,14 +5182,15 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	next_is_large = server->large_buf;
 one_more:
 	shdr = (struct smb2_sync_hdr *)buf;
-	if (shdr->NextCommand) {
+	next_cmd = le32_to_cpu(shdr->NextCommand);
+	if (next_cmd) {
+		if (WARN_ON_ONCE(next_cmd > pdu_length))
+			return -1;
 		if (next_is_large)
 			next_buffer = (char *)cifs_buf_get();
 		else
 			next_buffer = (char *)cifs_small_buf_get();
-		memcpy(next_buffer,
-		       buf + le32_to_cpu(shdr->NextCommand),
-		       pdu_length - le32_to_cpu(shdr->NextCommand));
+		memcpy(next_buffer, buf + next_cmd, pdu_length - next_cmd);
 	}
 
 	mid_entry = smb2_find_mid(server, buf);
@@ -5212,8 +5214,8 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	else
 		ret = cifs_handle_standard(server, mid_entry);
 
-	if (ret == 0 && shdr->NextCommand) {
-		pdu_length -= le32_to_cpu(shdr->NextCommand);
+	if (ret == 0 && next_cmd) {
+		pdu_length -= next_cmd;
 		server->large_buf = next_is_large;
 		if (next_is_large)
 			server->bigbuf = buf = next_buffer;
-- 
2.25.1


