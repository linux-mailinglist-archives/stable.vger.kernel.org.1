Return-Path: <stable+bounces-71448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3799634B2
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 00:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04A21C21E78
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 22:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC5B1AC8A9;
	Wed, 28 Aug 2024 22:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1sW/bAvQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920AC1AD3F9
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884129; cv=none; b=nqoysb1xPmNJJC+WoTqFcKSnm0lZQ+WoeXV9Bg7fFZZadrn5/VvhgzJGKgomtCk/9x76xCaslphL0VdIPb/kNYcD6Tz5FeH7aoTTPQeetRrRDk1QtlUiQFwtWCot02nLddPDqHrTRo22nJgfnjMhnxJ9L+ir6ddiFSBpgP6CQMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884129; c=relaxed/simple;
	bh=KRlY6ibm6FtIwpS+D5qdOZlJ1Xa+WDLRv0lZfRX/2+0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ci8sN7nbETslA76+JA5scsZIz7KzXnJQ31ZZVa0hHFi8HPUp2cZobM71KxniZqmzIisxsPADs4GyZytLegTbL8QYo80DjjE0NKay5RnfgYOJSUF3s+0JeSm8R4YmRzx9hkcWKEUDdJE3kDTIJ/rUOlWoLFYy+r4Rq93Z4rdYMxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1sW/bAvQ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7143e0e4cdbso40613b3a.1
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724884127; x=1725488927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ILVJC0oO4s+B5yk61W4+LbqgkAQ+/zImARVJ767wJyk=;
        b=1sW/bAvQzfUqbiU6dhJ0cZ/WXpQ1xDolnPVWcAO8bsCmpeBG0YRpY15fsm/VTC6FXZ
         njy2wlZL+ZZa1bQH54LRHqGz1gREshZuYyZcgZxtgoYqrS6dDFr/4Agh7TSmZHeu1+Le
         gmsaWaB6mS7c7beFME0iFCBktdHsnN/kRMqjSdVm+K89RQzpk6HQKanRe/FdWnRbVW8s
         Xrea76r+y/INqaDfWhJ3wrar/LSiEVvXYfA9zk/EKdf583NIdimpWLIXbZXfLDok/lMs
         edWmwS1GmGKQY2xUVUacBQvlX77nqJOQj+yRecvT76wA9mWemBPMNDaII0DlEva1aNDf
         ocCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724884127; x=1725488927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILVJC0oO4s+B5yk61W4+LbqgkAQ+/zImARVJ767wJyk=;
        b=fWRO8zBV7MDsZ8vbF3MQuK4tSesqx40rzA4FrJ5krtUW4ak7Fqh8DALUudCg7c8AME
         x83UMXk8QN8ALev3wpiIPU7oQzYqsZBwWXtVJkbPjgdXvrYf+OevTMsqZl4rM3I4iQ5f
         iup9uuFBkoIuh74CYMYjO4HFC5Qbmww/jTeUcVYHv9yuMf8nPVfVtvU9npMyJI1duWdZ
         egRUxqYBndyNKKDbIYMbe47yB67FbeMKhi7qSuhGgmO8VJb40wlC2gKeYe+FomBasokt
         SNCAlFZ4whN0AnZUD8aolxNPGXqwQ4bzuPvtgBKbgQYOLcRrR3SKNPy5ZKp5Ubwx+3dE
         L5KA==
X-Gm-Message-State: AOJu0Yz3Nx4NCGhy4gAQo/6ZMFjRuAOo5mcUA6ufWSqr3rYADxATVaFY
	yrE/y65pePhPGhxO3DDnSjEgcTAWbyoHhT9qqtn9EmTF+7w7rFXQGCXaOC5/iN7CFuS7lzZsD9K
	nxsnJ1FYZ7EyhCZPftQ1Zl3l7151/nBy5mKQOFvaQVTMCZi+jYp7aeyYjzBjEJ7w2Eil7iHSEff
	QY/8aV/ksAeWRdJZh9
X-Google-Smtp-Source: AGHT+IHYsxZVtdZ/QP6KjHbGpbwCLaL/VL34oCaWTxQRbXbgiCdhkCcy8eVz5I801hShOl25QBTVDtk=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1148])
 (user=ovt job=sendgmr) by 2002:a05:6a00:915b:b0:714:3451:860 with SMTP id
 d2e1a72fcca58-715dff5551bmr14652b3a.6.1724884125659; Wed, 28 Aug 2024
 15:28:45 -0700 (PDT)
Date: Wed, 28 Aug 2024 22:28:35 +0000
In-Reply-To: <2024070107-underrate-unusable-ddb9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024070107-underrate-unusable-ddb9@gregkh>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828222835.4003809-1-ovt@google.com>
Subject: [PATCH 6.1.y] ata: libata-core: Fix null pointer dereference on error
From: Oleksandr Tymoshenko <ovt@google.com>
To: stable@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Hannes Reinecke <hare@suse.de>, John Garry <john.g.garry@oracle.com>, 
	Oleksandr Tymoshenko <ovt@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Niklas Cassel <cassel@kernel.org>

commit 5d92c7c566dc76d96e0e19e481d926bbe6631c1e upstream.

If the ata_port_alloc() call in ata_host_alloc() fails,
ata_host_release() will get called.

However, the code in ata_host_release() tries to free ata_port struct
members unconditionally, which can lead to the following:

BUG: unable to handle page fault for address: 0000000000003990
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
CPU: 10 PID: 594 Comm: (udev-worker) Not tainted 6.10.0-rc5 #44
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
RIP: 0010:ata_host_release.cold+0x2f/0x6e [libata]
Code: e4 4d 63 f4 44 89 e2 48 c7 c6 90 ad 32 c0 48 c7 c7 d0 70 33 c0 49 83 c6 0e 41
RSP: 0018:ffffc90000ebb968 EFLAGS: 00010246
RAX: 0000000000000041 RBX: ffff88810fb52e78 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88813b3218c0 RDI: ffff88813b3218c0
RBP: ffff88810fb52e40 R08: 0000000000000000 R09: 6c65725f74736f68
R10: ffffc90000ebb738 R11: 73692033203a746e R12: 0000000000000004
R13: 0000000000000000 R14: 0000000000000011 R15: 0000000000000006
FS:  00007f6cc55b9980(0000) GS:ffff88813b300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000003990 CR3: 00000001122a2000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? __die_body.cold+0x19/0x27
 ? page_fault_oops+0x15a/0x2f0
 ? exc_page_fault+0x7e/0x180
 ? asm_exc_page_fault+0x26/0x30
 ? ata_host_release.cold+0x2f/0x6e [libata]
 ? ata_host_release.cold+0x2f/0x6e [libata]
 release_nodes+0x35/0xb0
 devres_release_group+0x113/0x140
 ata_host_alloc+0xed/0x120 [libata]
 ata_host_alloc_pinfo+0x14/0xa0 [libata]
 ahci_init_one+0x6c9/0xd20 [ahci]

Do not access ata_port struct members unconditionally.

Fixes: 633273a3ed1c ("libata-pmp: hook PMP support and enable it")
Cc: stable@vger.kernel.org
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/r/20240629124210.181537-7-cassel@kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 drivers/ata/libata-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 5a13630034ef..826d9a102a51 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5471,6 +5471,9 @@ static void ata_host_release(struct kref *kref)
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
 
+		if (!ap)
+			continue;
+
 		kfree(ap->pmp_link);
 		kfree(ap->slave_link);
 		kfree(ap);
-- 
2.46.0.295.g3b9ea8a38a-goog


