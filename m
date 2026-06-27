Return-Path: <stable+bounces-269423-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZ10CeRiQGoCfQkAu9opvQ
	(envelope-from <stable+bounces-269423-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 01:55:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 729436D2D65
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 01:55:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=mEpFZpac;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269423-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269423-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A55673015E17
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 23:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C531E35838A;
	Sat, 27 Jun 2026 23:55:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612E13382C3
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 23:55:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782604511; cv=none; b=HZpbHnPc+yKdZ5vYyNhnq7ujT9YlOZj8D25KUIEjkN3h5tk0Dq62Kw0RfLeQ2/Eeqjjxp7YeZ//lgMzpDyhVAqtGzYH+5Uv945jOX+0dDAHhhcSB2uoY6e1wi7EaMe67H/NKiV574+GNtn2R8L/N82jRepePStTg5ewD8vFpkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782604511; c=relaxed/simple;
	bh=MoymQWTzLpOpVNBaGC1gfrCxK7bYuK6bn2S89oG53Is=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iMHg4GqDOlOukPpS3efaoQY2CByL/+SmWC6p0eVFx2cIJaNceC70/Y83T6KtGZk35pp7kmDPO+U6XDkg+uHzCrXN3kfljOpyuWFsRwXTZ+Q/YigsxtMH42gIn3gEMn96L/FQ4VJ+QLw+xfg1fnBoWIFVyMzZLuPfxkzhVmSJgSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEpFZpac; arc=none smtp.client-ip=74.125.224.42
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-6647bc8f900so2618862d50.0
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 16:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782604509; x=1783209309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1oasJ1uwrqjIjP3B2dhR4LOo4j09mY2wVNm1F23els=;
        b=mEpFZpacBNQ0Mpk6BYQsLJnKBxacPrnhcFJKXSEHC9V0HDCtmKc6EgQJmODWQXJ2sX
         6J/pRx3QY2Ei+1xJNeBSU5N3o8wtGP/3Vq2HBEv60A121+vNUDQwdPeS4zdM/C8LIUOR
         w2qUTOVbpcHr/pfby2hz3IMGQ18L/TiFpcBqgiEWZ0mCywejmSGmaGOktBLpbjnRW12S
         aE4Q+Kr6bkWZpW/McGjoKn8N1pilX/yKzjApZuredO+jwikr01tE8/Tpb3eZbGrDhfcm
         wpyj5kLLrdthH1NL+WAaTMVFkKfeutt36DNTNGks6o0qmpwPa6kO35wJgV8ggAJsVB/K
         tDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782604509; x=1783209309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1oasJ1uwrqjIjP3B2dhR4LOo4j09mY2wVNm1F23els=;
        b=HBRyYgmEOvK3lBSVbRT6K7vzNO71iGpFecYAaY1BKQl8O8/RJx7R7sAzeJ3QY8SYVd
         41OiqzYlGKv9dQYowGtgckpjG0Ig/WT3YFrbRiZDE02KsNcZN07jPO1vboG8bhCgRx6S
         pqCwxW6tlYPCJ2U0P2YhsziuhOghJRppZZgOdwZeM+orAQvA4m6PsJMLVuq2EUqswVTl
         hJo/6oUEhOYyRfQ+Ab6ks1ZiXaAIKyKWH9GtMbwtGpolMQGOUEy9i02MLoiBu6SmofK5
         U2hSe2bJTlKjCaI7ixqwC1jppWa503Zzm7K/m0SytVy0Jm7Q2Jy1b5+f3NXHfQT3CD6c
         Q85A==
X-Forwarded-Encrypted: i=1; AHgh+Rogl3xhWbfR4O/W1ss+6frliIkBW14/dA8zXaUSqQF4H6n6lC36lLOmHkNkvXmb6+Av/7ilxvA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7PQdg6TNC0kXaN5q/WKR51kCQDe6D2pcMfXpcM/cWMuwee0N0
	Xdr8BS+6k9wYYMVTSUY+D/qzwS89Na4jZ1OsZTQu6vPGzbX1tArnxcTt
X-Gm-Gg: AfdE7clEz6Md9SIo1wsoWMHXpWw3yW85+g7QMBNXJNhWvnlXjGfWjkANZQqbsQOrbbg
	CPpRbXi6pJaJ363SQKpFPtTfvraHxMpK6D430d274wxtEEV6KvPOInRAk/CUo0QEdmCL/dJxfim
	9uiigF8oL88+/IS+qAiSAPrOicT/VnJn5a90wbEVGZEfuO0yY6th4s5IV4IIKSGBL1FWGFQVAUI
	gwloY3mJjubj2/YgxgDQEQVt8+HH0fmFS2F0Sf1TmoCcSqdMueMazOgzdHvlQIotsVVvWWwuI22
	eiW8l/AUB2kd6AjrlGRjFkMYASUSbZfw4oc7n3UcBJqD1tV/9y0N61kxolWC4RPnRpau0IzG981
	pMeg3Yb24UxdxgLgmwqkFPTKacjfkN7d4XNswQOqGeMRYHfwCsX91YLVdJQjgKIeNEv83xGCwDD
	6ZZKXS84EO6AScBIbXT2IjnOFelA==
X-Received: by 2002:a53:d985:0:b0:664:ae6a:e9a9 with SMTP id 956f58d0204a3-664ae6b0ca0mr4092905d50.79.1782604509328;
        Sat, 27 Jun 2026 16:55:09 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-664c061fda0sm938837d50.9.2026.06.27.16.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 16:55:08 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Gabriel Somlo <somlo@cmu.edu>
Cc: qemu-devel@nongnu.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] firmware: qemu_fw_cfg: reject overflowing file directories
Date: Sun, 28 Jun 2026 01:54:28 +0200
Message-ID: <20260627235428.16263-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[nongnu.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-269423-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mst@redhat.com,m:somlo@cmu.edu,m:qemu-devel@nongnu.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:alhouseenyousef@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 729436D2D65

The fw_cfg file count is supplied by the VMM. On 32-bit systems,
multiplying a large count by the directory entry size can wrap, resulting
in a short allocation and an out-of-bounds walk of the directory.

Reject counts whose directory size cannot be represented by size_t before
allocating or reading the directory.

Fixes: 75f3e8e47f38 ("firmware: introduce sysfs driver for QEMU's fw_cfg device")

Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/firmware/qemu_fw_cfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cfg.c
index 0c51a9df5..3d5eece35 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -34,6 +34,7 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/overflow.h>
 #include <uapi/linux/qemu_fw_cfg.h>
 #include <linux/delay.h>
 #include <linux/crash_dump.h>
@@ -642,7 +643,8 @@ static int fw_cfg_register_dir_entries(void)
 		return ret;
 
 	count = be32_to_cpu(files_count);
-	dir_size = count * sizeof(struct fw_cfg_file);
+	if (check_mul_overflow((size_t)count, sizeof(*dir), &dir_size))
+		return -EOVERFLOW;
 
 	dir = kmalloc(dir_size, GFP_KERNEL);
 	if (!dir)
-- 
2.54.0


