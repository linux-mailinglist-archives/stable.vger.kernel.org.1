Return-Path: <stable+bounces-145007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A600ABCF5B
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 08:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72FB8A34D5
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 06:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823B25CC74;
	Tue, 20 May 2025 06:30:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C421854;
	Tue, 20 May 2025 06:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747722630; cv=none; b=fExFLI/QFjc+r/JgyyJEHDANecUI3vctdrOxKvu8iQN5f5I9rYgsnLQ13J2Fa0stS0NscKQXOStim9rKKORmQLy0JsoJcJp6mTnX/Qr7IMP8ibvSZiZFyqa8VT24qKH3llg4Qml6ATuFidQQeN+4O1Osg0ufy+P7lIIm1Py91M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747722630; c=relaxed/simple;
	bh=pC7hcoBItm/p4ikdY5pstS8S6ncVBZrRXfm7pjZ61Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rp+2BXd8XkaqsYh1Xz8b+Z/eEMHJkUussR5o5Unu1soalqDWPFHyFYknjvnhTCuM717DhiL1LiPtAPCotBt6ODtb+w2mjhrXFG7qJGooIQ1RP478GQF8aZOHXL+GnxQiGABVj1bsDgKQ+XhFSTytg0p/7w4eK7vzpTalDGnRqiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxWXF1ISxoEA3zAA--.152S3;
	Tue, 20 May 2025 14:30:13 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDxu8RxISxo+8fiAA--.53745S2;
	Tue, 20 May 2025 14:30:10 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH for 6.14.y] perf tools: Fix build error for LoongArch
Date: Tue, 20 May 2025 14:30:09 +0800
Message-ID: <20250520063009.23504-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxu8RxISxo+8fiAA--.53745S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFy3tr4kKFy5XFWDArykXrc_yoW8Ar1UpF
	sxC34DtFWrWryrArnrur1IgFy8Gw4DX342qFy0kr45ZwnIgr9IqF97Xas8KFyxWa9FgrW0
	vrWSkay5GF48XabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALUUUUU=

There exists the following error when building perf tools on LoongArch:

  CC      util/syscalltbl.o
In file included from util/syscalltbl.c:16:
tools/perf/arch/loongarch/include/syscall_table.h:2:10: fatal error: asm/syscall_table_64.h: No such file or directory
    2 | #include <asm/syscall_table_64.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.

This is because the generated syscall header is syscalls_64.h rather
than syscall_table_64.h. The above problem was introduced from v6.14,
then the header syscall_table.h has been removed from mainline tree
in commit af472d3c4454 ("perf syscalltbl: Remove syscall_table.h"),
just fix it only for the linux-6.14.y branch of stable tree.

By the way, no need to fix the mainline tree and there is no upstream
git id for this patch.

How to reproduce:

  git clone https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
  cd linux && git checkout origin/linux-6.14.y
  make JOBS=1 -C tools/perf

Fixes: fa70857a27e5 ("perf tools loongarch: Use syscall table")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/arch/loongarch/include/syscall_table.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/loongarch/include/syscall_table.h b/tools/perf/arch/loongarch/include/syscall_table.h
index 9d0646d3455c..b53e31c15805 100644
--- a/tools/perf/arch/loongarch/include/syscall_table.h
+++ b/tools/perf/arch/loongarch/include/syscall_table.h
@@ -1,2 +1,2 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscall_table_64.h>
+#include <asm/syscalls_64.h>
-- 
2.42.0


