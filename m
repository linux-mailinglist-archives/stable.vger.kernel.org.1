Return-Path: <stable+bounces-158469-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 166B2AE747D
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 03:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BF41921CD4
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 01:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA032194A60;
	Wed, 25 Jun 2025 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="ZwAFCSlg"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw-fb.securemx.jp (mo-csw-fb1802.securemx.jp [210.130.202.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9701EB3E
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816286; cv=none; b=pGNsDCxIyIgDK3aGHrvsTak7k9QM2ep0J/nWDA/bCYoIY1ZTpe5YitYmY8MFwpat/yh04bO7WopaXpOh53i45dxUNRRWYMtCw17hf10Lm9/NTQObjkiEyin94yyPFogiVbvrVL9OkOlEV/FSr0nRmTrYduy/21XouDzdnpYhzhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816286; c=relaxed/simple;
	bh=6+oF5g13YM6SzDIcYgWRMhha8c3Mfo0D1LGHQY6tP7A=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GzL2R+jJP/6xZy1EjEEnwtq8I+opMzC4WWnSBPAf760Ehn0mrTk3MQ3Mme1xQUYcAcJh7TlFMC258SfG705HrUOt3tNVxJiCmbk1SGQAZXv9XpAhOMVF64mOIdIiqGQXfPYi62l/BIPlAZahxApBO+B3iRcM1oXC/tEwwsvrYpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=ZwAFCSlg; arc=none smtp.client-ip=210.130.202.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1802) id 55ONwahn1535609; Wed, 25 Jun 2025 08:58:44 +0900
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1750809489;x=1752019089;bh=6+oF5g13YM6SzDIcYgWRMhha8c3Mfo0D1LGHQY6tP7A=;b=ZwA
	FCSlgliDIDf/ey0xktsaEuE5gtpXKNI7p0veMBinFrfd6rF7ghYohR+cTnJqEzQfITiGm16+/a6Wl
	TserFvpLxqS6qZOPnYPH1NpMeqeUT3wgWeFr5JGCpnkVu5jKLHtgvLioFfY2nd4/lEjUqapWCoeRv
	f6mY/mJ/jPnmQm7A/6mnjvb14oLRti5FldSTFt8IzeNCQjZ6Zx5Vg8NR+9XZ16T0c5zwjgTn8Bnpc
	BSwVy/FgHGUF65bqe3qCGti78fBo5zGePwTvz6VE2h0MTM/EPdzixo5JBX8a8hNYNsoTFWDg5D9WY
	UGPNW+Yj9d6KvmQDDrwxkvjbHsfkzOw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 55ONw8e63406392; Wed, 25 Jun 2025 08:58:09 +0900
X-Iguazu-Qid: 2yAb5TJliZoeTtqrvr
X-Iguazu-QSIG: v=2; s=0; t=1750809488; q=2yAb5TJliZoeTtqrvr; m=FUHdYQnnWLFv0fqrneSFjHYdiHfMc04HFdeeQ6LQkqY=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 55ONw7bD2862213
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 08:58:07 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc: Seiji Nishikawa <snishika@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 5.4 and 5.10] ACPI: PAD: fix crash in exit_round_robin()
Date: Wed, 25 Jun 2025 08:56:14 +0900
X-TSB-HOP2: ON
Message-Id: <1750809374-29306-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Seiji Nishikawa <snishika@redhat.com>

commit 0a2ed70a549e61c5181bad5db418d223b68ae932 upstream.

The kernel occasionally crashes in cpumask_clear_cpu(), which is called
within exit_round_robin(), because when executing clear_bit(nr, addr) with
nr set to 0xffffffff, the address calculation may cause misalignment within
the memory, leading to access to an invalid memory address.

----------
BUG: unable to handle kernel paging request at ffffffffe0740618
        ...
CPU: 3 PID: 2919323 Comm: acpi_pad/14 Kdump: loaded Tainted: G           OE  X --------- -  - 4.18.0-425.19.2.el8_7.x86_64 #1
        ...
RIP: 0010:power_saving_thread+0x313/0x411 [acpi_pad]
Code: 89 cd 48 89 d3 eb d1 48 c7 c7 55 70 72 c0 e8 64 86 b0 e4 c6 05 0d a1 02 00 01 e9 bc fd ff ff 45 89 e4 42 8b 04 a5 20 82 72 c0 <f0> 48 0f b3 05 f4 9c 01 00 42 c7 04 a5 20 82 72 c0 ff ff ff ff 31
RSP: 0018:ff72a5d51fa77ec8 EFLAGS: 00010202
RAX: 00000000ffffffff RBX: ff462981e5d8cb80 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000246 RDI: 0000000000000246
RBP: ff46297556959d80 R08: 0000000000000382 R09: ff46297c8d0f38d8
R10: 0000000000000000 R11: 0000000000000001 R12: 000000000000000e
R13: 0000000000000000 R14: ffffffffffffffff R15: 000000000000000e
FS:  0000000000000000(0000) GS:ff46297a800c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffe0740618 CR3: 0000007e20410004 CR4: 0000000000771ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 ? acpi_pad_add+0x120/0x120 [acpi_pad]
 kthread+0x10b/0x130
 ? set_kthread_struct+0x50/0x50
 ret_from_fork+0x1f/0x40
        ...
CR2: ffffffffe0740618

crash> dis -lr ffffffffc0726923
        ...
/usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x86_64/./include/linux/cpumask.h: 114
0xffffffffc0726918 <power_saving_thread+776>:	mov    %r12d,%r12d
/usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x86_64/./include/linux/cpumask.h: 325
0xffffffffc072691b <power_saving_thread+779>:	mov    -0x3f8d7de0(,%r12,4),%eax
/usr/src/debug/kernel-4.18.0-425.19.2.el8_7/linux-4.18.0-425.19.2.el8_7.x86_64/./arch/x86/include/asm/bitops.h: 80
0xffffffffc0726923 <power_saving_thread+787>:	lock btr %rax,0x19cf4(%rip)        # 0xffffffffc0740620 <pad_busy_cpus_bits>

crash> px tsk_in_cpu[14]
$66 = 0xffffffff

crash> px 0xffffffffc072692c+0x19cf4
$99 = 0xffffffffc0740620

crash> sym 0xffffffffc0740620
ffffffffc0740620 (b) pad_busy_cpus_bits [acpi_pad]

crash> px pad_busy_cpus_bits[0]
$42 = 0xfffc0
----------

To fix this, ensure that tsk_in_cpu[tsk_index] != -1 before calling
cpumask_clear_cpu() in exit_round_robin(), just as it is done in
round_robin_cpu().

Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
Link: https://patch.msgid.link/20240825141352.25280-1-snishika@redhat.com
[ rjw: Subject edit, avoid updates to the same value ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-49935
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/acpi/acpi_pad.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 35de23ff50d6..3e7e28b7947e 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -128,8 +128,11 @@ static void round_robin_cpu(unsigned int tsk_index)
 static void exit_round_robin(unsigned int tsk_index)
 {
 	struct cpumask *pad_busy_cpus = to_cpumask(pad_busy_cpus_bits);
-	cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
-	tsk_in_cpu[tsk_index] = -1;
+
+	if (tsk_in_cpu[tsk_index] != -1) {
+		cpumask_clear_cpu(tsk_in_cpu[tsk_index], pad_busy_cpus);
+		tsk_in_cpu[tsk_index] = -1;
+	}
 }
 
 static unsigned int idle_pct = 5; /* percentage */
-- 
2.25.1



