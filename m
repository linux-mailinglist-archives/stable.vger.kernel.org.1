Return-Path: <stable+bounces-126876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EF6A7354B
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 16:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13E261725DD
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F298149C7B;
	Thu, 27 Mar 2025 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kbF/Fw9M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77731146A66
	for <stable@vger.kernel.org>; Thu, 27 Mar 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087858; cv=none; b=XTKMxzmBTZHHKoZ+9Qaa5fX/JUmOX/hQbtsJ2F3BiLNT++NW3d/L4xr8nJ7bCQ3jjmKCxyncSAn2uowXPqDf8wMHoiArkixBuhwb8Ni4mSyT2a5WfTDmjQ2c7BS6WRm4qQwR/1Fhu5hPMtfb2pjj1mQ14tABdVoPUAkvjQvUDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087858; c=relaxed/simple;
	bh=hTh/cfVgLHrPOGu6GYfIXW4bOU+Eq28EHmrYsiW2aWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnDOhhyYDzac9ZHky5KQTb6Ms1bOpWoQx718IjtT4iApSitMx0s0vMBsQmpVu8hwbgkqj91CwH8TZmyvPpGAVO+eSPGRKy741mk9oCfunA6Tz7Y8/JhCFAY+SgX/uktdQmi0sQ82PEqlI6lXigTcjLFGgosuSruNLPhiFkZVcSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kbF/Fw9M; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2240b4de12bso32122055ad.2
        for <stable@vger.kernel.org>; Thu, 27 Mar 2025 08:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1743087857; x=1743692657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1dzn/q3DwJwUQakeNgiZfS0yjXlYy1cHDyYLgM2hgUc=;
        b=kbF/Fw9MBisX2Nd+N1XCOWW4BNOdcPuWdY/X1h4czHDt63O1ELouX1qamvPp7ZmqY/
         P9QL4FSdWBbeQrmTo2rTG8o/RQ+2AnW8Cy6RuIR9vumG4dN4PlvDb9P3ub3BnG+YBp7R
         obrEjGz2Sj7Ux5o+3km31lHIumfwOFwGI5t7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743087857; x=1743692657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dzn/q3DwJwUQakeNgiZfS0yjXlYy1cHDyYLgM2hgUc=;
        b=meDax9oVwb1F/xxLdvaPnbQvMeLhH62r5BKTDwXlujYmxd+MtiCBNvK/bjjVc/yoaG
         QhqccQJenu2whej+LU61C8TCAVlfypnyk+0aFKxmvmVLLyppRNnuYQshtuFyWT5EAVyr
         BtdBFemxkjoB5GO8X+SF66brGdPfH/2cgeEhCXc7Q/Kv+tcgtuq1DEm4njrJNvJPobLk
         GrkZeljZpMpa+/bEMsrqUtOVOwPe76TGqw+aFZiCJYhcskXFhMea1e3k/pwy/V292sgZ
         45tMEb2ri1Zj/RRUDe+K5FQ2uh10WUh9iHAQHAozXyxxXT2PHox8cWlCGCW/+JVD4P6p
         R+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXyKzwYMrnfVm5sccpQif4GdUk5iL3BNHdZmVLSrIbBpzgTpYTiCrsRpV5aVT+7vHbvnueIC6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+IF75Zb7ZVcYwbwn/2oyxI8+RUCjd0md2V148rnimMDTi7uA3
	FzqPXCMkxGENG8QrbChL9g8lzRLZ/VsCQ45HcABuE2MlU5FRdvbQaB7dZZA5rw==
X-Gm-Gg: ASbGncuqUB4Y14ADq6zmHoDsE30nsUkCrRngj0x66gxy6fv7XvmtcURGqATk7Txt9MZ
	EeiW5AEv3sZH+jo/G4+VSMTqnR601DRpTdW25P88LewEy/IzixfrS1VOeZgYHV7MwYaYlWY7ili
	hRT1lxOTPrVOwBhhyuVRk0K4wuNwvF9XmjWKaAFU9rFMFO3HWCamiS9PipfsiZAXrAl771WCxqA
	Zdzz1T9ULzpMQ7u5dH9JKIf/qVBLIUy1gG4fmoa/wdJvruE7iEG4RirUSWE7bpEPeQyl3ZDQhGR
	zGd0CJV0f1GJXrAICHl3V6IuVC0Y5h/QPuU78ngc7qIXBBdx44s5Uz2aiWwljkCUdPq8ZQ==
X-Google-Smtp-Source: AGHT+IEVqGTm9SnJQYYYVq75N+ryfrvO/8a+zp+Bo8G0CL6FxM48RSgxG269/Ff2pGWCEpMLTxoWGQ==
X-Received: by 2002:a17:902:ef4d:b0:224:1ef:1e00 with SMTP id d9443c01a7336-2280485782emr63449195ad.19.1743087856578;
        Thu, 27 Mar 2025 08:04:16 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:cd9c:961:27c5:9ceb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee0bafsm619715ad.90.2025.03.27.08.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 08:04:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCHv3] thunderbolt: do not double dequeue a request
Date: Fri, 28 Mar 2025 00:03:50 +0900
Message-ID: <20250327150406.138736-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of our devices crash in tb_cfg_request_dequeue():

 general protection fault, probably for non-canonical address 0xdead000000000122

 CPU: 6 PID: 91007 Comm: kworker/6:2 Tainted: G U W 6.6.65
 RIP: 0010:tb_cfg_request_dequeue+0x2d/0xa0
 Call Trace:
 <TASK>
 ? tb_cfg_request_dequeue+0x2d/0xa0
 tb_cfg_request_work+0x33/0x80
 worker_thread+0x386/0x8f0
 kthread+0xed/0x110
 ret_from_fork+0x38/0x50
 ret_from_fork_asm+0x1b/0x30

The circumstances are unclear, however, the theory is that
tb_cfg_request_work() can be scheduled twice for a request:
first time via frame.callback from ring_work() and second
time from tb_cfg_request().  Both times kworkers will execute
tb_cfg_request_dequeue(), which results in double list_del()
from the ctl->request_queue (the list poison deference hints
at it: 0xdead000000000122).

Do not dequeue requests that don't have TB_CFG_REQUEST_ACTIVE
bit set.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: stable@vger.kernel.org
---

v3: tweaked commit message

 drivers/thunderbolt/ctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index cd15e84c47f4..1db2e951b53f 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -151,6 +151,11 @@ static void tb_cfg_request_dequeue(struct tb_cfg_request *req)
 	struct tb_ctl *ctl = req->ctl;
 
 	mutex_lock(&ctl->request_queue_lock);
+	if (!test_bit(TB_CFG_REQUEST_ACTIVE, &req->flags)) {
+		mutex_unlock(&ctl->request_queue_lock);
+		return;
+	}
+
 	list_del(&req->list);
 	clear_bit(TB_CFG_REQUEST_ACTIVE, &req->flags);
 	if (test_bit(TB_CFG_REQUEST_CANCELED, &req->flags))
-- 
2.49.0.395.g12beb8f557-goog


