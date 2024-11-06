Return-Path: <stable+bounces-90525-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD14C9BE8B8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C29284285
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202F81DF756;
	Wed,  6 Nov 2024 12:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QmaKZJcG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DEB1D2784;
	Wed,  6 Nov 2024 12:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896030; cv=none; b=F5EeZlXF2u8GPQ114NWNBDp3t2EmO2EmRo/A0lP2dWx0N+OiVXDWbXn7yLVQBNppX0WWcGhYwr6Fyug8EUx5xqLCIctRxcxUD9h93Yr/cVKfqoeDQlwMsHJbQv6uoZ4TA+8TjgsK40WOyhSXXcxAOoiQMwaHF40hlNG0l42hAwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896030; c=relaxed/simple;
	bh=a4fnKqXuiIJRg/tO6TjfnKv68cyqDShclJKJ0hzDu8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z74eBQb/90EmalYcPhrdDNhh6pK0JVQd7Q1a5ie01aK/DFa4neR7ifpLEkgqrTa/whkuJwVLfpswiO+V655YTkj3NGx7dt3Nl/lez2RNqiKRytn20y/d7XSsNtuyyoD+Q9RikSKYVRPaEOP375O6c4LAG1ZHnV9KwRp4ubasJBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QmaKZJcG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF48C4CED5;
	Wed,  6 Nov 2024 12:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896030;
	bh=a4fnKqXuiIJRg/tO6TjfnKv68cyqDShclJKJ0hzDu8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QmaKZJcGBu1xGYK1aauYjSuaF8GXjnaSNmqbl5xzq4GeHG8yybvNigFvMC30fBXRi
	 Nuu247Y8B/qVHB8OAjk3z0UAvrBILo65K2VsqnMTfbPFclYMFZTej18G+iEmJbkFrg
	 5f3PJkFp84y2OlRENwsJOHWJ7goSIabNHnchXEl8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pierre Gondois <pierre.gondois@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 066/245] ACPI: CPPC: Make rmw_lock a raw_spin_lock
Date: Wed,  6 Nov 2024 13:01:59 +0100
Message-ID: <20241106120320.831899185@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120319.234238499@linuxfoundation.org>
References: <20241106120319.234238499@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit 1c10941e34c5fdc0357e46a25bd130d9cf40b925 ]

The following BUG was triggered:

=============================
[ BUG: Invalid wait context ]
6.12.0-rc2-XXX #406 Not tainted
-----------------------------
kworker/1:1/62 is trying to lock:
ffffff8801593030 (&cpc_ptr->rmw_lock){+.+.}-{3:3}, at: cpc_write+0xcc/0x370
other info that might help us debug this:
context-{5:5}
2 locks held by kworker/1:1/62:
  #0: ffffff897ef5ec98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2c/0x50
  #1: ffffff880154e238 (&sg_policy->update_lock){....}-{2:2}, at: sugov_update_shared+0x3c/0x280
stack backtrace:
CPU: 1 UID: 0 PID: 62 Comm: kworker/1:1 Not tainted 6.12.0-rc2-g9654bd3e8806 #406
Workqueue:  0x0 (events)
Call trace:
  dump_backtrace+0xa4/0x130
  show_stack+0x20/0x38
  dump_stack_lvl+0x90/0xd0
  dump_stack+0x18/0x28
  __lock_acquire+0x480/0x1ad8
  lock_acquire+0x114/0x310
  _raw_spin_lock+0x50/0x70
  cpc_write+0xcc/0x370
  cppc_set_perf+0xa0/0x3a8
  cppc_cpufreq_fast_switch+0x40/0xc0
  cpufreq_driver_fast_switch+0x4c/0x218
  sugov_update_shared+0x234/0x280
  update_load_avg+0x6ec/0x7b8
  dequeue_entities+0x108/0x830
  dequeue_task_fair+0x58/0x408
  __schedule+0x4f0/0x1070
  schedule+0x54/0x130
  worker_thread+0xc0/0x2e8
  kthread+0x130/0x148
  ret_from_fork+0x10/0x20

sugov_update_shared() locks a raw_spinlock while cpc_write() locks a
spinlock.

To have a correct wait-type order, update rmw_lock to a raw spinlock and
ensure that interrupts will be disabled on the CPU holding it.

Fixes: 60949b7b8054 ("ACPI: CPPC: Fix MASK_VAL() usage")
Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://patch.msgid.link/20241028125657.1271512-1-pierre.gondois@arm.com
[ rjw: Changelog edits ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 9 +++++----
 include/acpi/cppc_acpi.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ed91dfd4fdca7..544f53ae9cc0c 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -867,7 +867,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	/* Store CPU Logical ID */
 	cpc_ptr->cpu_id = pr->id;
-	spin_lock_init(&cpc_ptr->rmw_lock);
+	raw_spin_lock_init(&cpc_ptr->rmw_lock);
 
 	/* Parse PSD data for this CPU */
 	ret = acpi_get_psd(cpc_ptr, handle);
@@ -1087,6 +1087,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	int pcc_ss_id = per_cpu(cpu_pcc_subspace_idx, cpu);
 	struct cpc_reg *reg = &reg_res->cpc_entry.reg;
 	struct cpc_desc *cpc_desc;
+	unsigned long flags;
 
 	size = GET_BIT_WIDTH(reg);
 
@@ -1126,7 +1127,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			return -ENODEV;
 		}
 
-		spin_lock(&cpc_desc->rmw_lock);
+		raw_spin_lock_irqsave(&cpc_desc->rmw_lock, flags);
 		switch (size) {
 		case 8:
 			prev_val = readb_relaxed(vaddr);
@@ -1141,7 +1142,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 			prev_val = readq_relaxed(vaddr);
 			break;
 		default:
-			spin_unlock(&cpc_desc->rmw_lock);
+			raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 			return -EFAULT;
 		}
 		val = MASK_VAL_WRITE(reg, prev_val, val);
@@ -1174,7 +1175,7 @@ static int cpc_write(int cpu, struct cpc_register_resource *reg_res, u64 val)
 	}
 
 	if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		spin_unlock(&cpc_desc->rmw_lock);
+		raw_spin_unlock_irqrestore(&cpc_desc->rmw_lock, flags);
 
 	return ret_val;
 }
diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
index e1720d9306669..a451ca4c207bb 100644
--- a/include/acpi/cppc_acpi.h
+++ b/include/acpi/cppc_acpi.h
@@ -65,7 +65,7 @@ struct cpc_desc {
 	int write_cmd_status;
 	int write_cmd_id;
 	/* Lock used for RMW operations in cpc_write() */
-	spinlock_t rmw_lock;
+	raw_spinlock_t rmw_lock;
 	struct cpc_register_resource cpc_regs[MAX_CPC_REG_ENT];
 	struct acpi_psd_package domain_info;
 	struct kobject kobj;
-- 
2.43.0




