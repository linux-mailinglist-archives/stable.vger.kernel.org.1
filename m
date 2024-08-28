Return-Path: <stable+bounces-71449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A8E9634F8
	for <lists+stable@lfdr.de>; Thu, 29 Aug 2024 00:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAF1FB2442F
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 22:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368F01AC89F;
	Wed, 28 Aug 2024 22:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HudYQzUl"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81409158546
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885083; cv=none; b=W+O/ySwRMRHsFCQZ+g5wHJw/enWrro8pbkJ/Qa8tae0eMiEeheesNXWmQZF/gGLIORPpUUq//7z6MyhRXQ7F3ST7HElVenxeO15FgNLH7vV9gEyvgu2TFM9VrTgAydHs4DSUSahfx1S9VIelc4xO9L1wc2Uojt6/vc7AwLWZOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885083; c=relaxed/simple;
	bh=SwEclFldSyPTD/D6vVJ20bVS+A7gDHmz25gukkA2Leg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ETfMTbg3tbaSMHSwQ0uX6+y7Kxd86/q3jK1E5U91tEDyNfvkhCMoXzfK2CdYUDkBZx42goc3Fc6SHsyl1Ufkjco0hbnPClrO1ZFmYwTTBpi8OCg7haXay+3B/j+XixCcNavkdH54rCh9ZXUP0ccevPJBL0I6rBAiG4m6DJN1x3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HudYQzUl; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6af4700a594so1834587b3.0
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 15:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724885080; x=1725489880; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mIvzvPfWi4LBKv5sSorZD7s7Wi6+BN6aupxe12055wo=;
        b=HudYQzUl/QPc87nUPCz+AtYzkBhjZOBOzZiXKH06FteLKBh+tNxW390JT3tPzMF085
         flpk5SR5XV54xisMsrVUtawWLI19FWtlfae5sCigCG3jV7pQu1S4qiVc0Vke0qmpsxrc
         Fr/DTOGVjYxH0Zoh3WJG/f6zruGcVFzYW6bN2vnPAkGjsjVZD4BrUM9UqODiauyJwipA
         hjTDC8wTDu0fM3B8y54mpW8rvPJB2wTHSbC9Uhg/IfaWrkUC6NobPZwyPqCr7uJ2c4IB
         1WQkftGTnKOvj88ffVJx/SWR7Yfd07paixyVzH3XwOYEYQHjl1tL7A1s55FE0ZfrBgcI
         rfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724885080; x=1725489880;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mIvzvPfWi4LBKv5sSorZD7s7Wi6+BN6aupxe12055wo=;
        b=M9rg8h8b0R840uAtUEla4S8Y49CmPlu3s4nv+pGXi/3YTg8Mv46U41n/9iev7XUlqR
         tzre01MeEZ0QC5I0ROc3I7SMzVDWGyPxqLnGrk66rY/uBxVXXlGbyBHlhTCOjjRaGFbO
         4SRKZi+Ri+R7R3cr05oznhdZLtDcax1ootBcAecQF1P2kXNAbVV3C1+2VKi1Dut9je3E
         8BSfrz9GlVF00hEi7/fQtPzeUChO6DLd2RXYViwVqv6cYdHEBzzj3OowBApd3dUNmGB1
         7mtPbsNop9R5JoDQFDGQxNET4QAfaQkwkrmHzr3+s96RU8cqerjn7p2tZ7X4qhtdhjmr
         vLyg==
X-Gm-Message-State: AOJu0YzQq2nmhzUmndk0L5Y8qUgbLh2E5EuZ/Xn8P5EC1bHj9NeSy6Lr
	W6ksWOB/QszxfefwG4O/eq7P6lPSPcnn6orYlgwppqN7gnscFEIOS5/JiiDCBUnHTahHJ5Zuf5t
	zOxMb3RICxKkJMOduHVRNhkRDpYO5LkFaz48RGPFrcbAe4IwLCYrvUuQu0uzxswSy8Zb2JLjcHo
	BmHEZ2XdxZU5u1pmMW
X-Google-Smtp-Source: AGHT+IEld7hnjDmmc9IPR7E0WiDjGQFDrwE6ytheM6hveH/ER7N3rB0kcHSFDLu+H8UFFkaVouf5Rl4=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1148])
 (user=ovt job=sendgmr) by 2002:a25:e912:0:b0:e11:7210:f651 with SMTP id
 3f1490d57ef6-e1a5ae086e0mr1917276.7.1724885079811; Wed, 28 Aug 2024 15:44:39
 -0700 (PDT)
Date: Wed, 28 Aug 2024 22:44:36 +0000
In-Reply-To: <2024070108-cabana-swifter-f1c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024070108-cabana-swifter-f1c9@gregkh>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828224436.4081247-1-ovt@google.com>
Subject: [PATCH 5.15.y] ata: libata-core: Fix null pointer dereference on error
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
index 31a0818b4440..8c85d2250899 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5391,6 +5391,9 @@ static void ata_host_release(struct kref *kref)
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


