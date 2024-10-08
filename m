Return-Path: <stable+bounces-82517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71948994D24
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EE11C2553C
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6411DED4B;
	Tue,  8 Oct 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sXp/tzcX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA97F1DFD1;
	Tue,  8 Oct 2024 13:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392530; cv=none; b=UnL5rmCa6au5EWCRefA/1jyglpRJv7Q9OSZ3z4n05SRsRz1n+ZTntPr/nZJzH7zYN8ltuGfHNtOXnXJePSFWX/lNzYfZ0rcfuaNlvOhcteRCcKCpQqa+t/djkIOpHRWLi3nX/E1wzLNlS5jYS8RVoT99Aj8TJoiP0r74t30RrFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392530; c=relaxed/simple;
	bh=hJpFPurEWlACbmqLAtC+R116rZtkaPOjw/YjrQW7CAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TnuP0m+hf0qaM989B3sss1StiY+SMWNWLIYdHEoic4AkrwyUpOO2xN62QU6hQCmTYPU0tcSPrJ51HxFxLp3qiOBg29Q3W/8rAeaf/pJuiorA2j6IfyQeKu3omwgzJTZj87Ccbg/6rACYDiHRMlv5Ym4+ewt03aUOlC3KDO1U+ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sXp/tzcX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1038BC4CEC7;
	Tue,  8 Oct 2024 13:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392530;
	bh=hJpFPurEWlACbmqLAtC+R116rZtkaPOjw/YjrQW7CAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXp/tzcX0+MF4oMfp0g2yxxowb5qsL7hJ4QHVifPtLYHP8Ue2VeNlhnsGN1lwZKrf
	 ApMLQAkPGOe5iQRlcK+ufIUZVJOYgRdDvkdF2Kl2MrBEAZsWolV0xaP2vj8jWsqRQx
	 B6izjTnhzw/Eyr9MtgUmAKi487REQezs2+GDNCu8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pu Lehui <pulehui@huawei.com>,
	Atish Patra <atishp@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 6.11 441/558] drivers/perf: riscv: Align errno for unsupported perf event
Date: Tue,  8 Oct 2024 14:07:51 +0200
Message-ID: <20241008115719.621779481@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

From: Pu Lehui <pulehui@huawei.com>

commit c625154993d0d24a962b1830cd5ed92adda2cf86 upstream.

RISC-V perf driver does not yet support PERF_TYPE_BREAKPOINT. It would
be more appropriate to return -EOPNOTSUPP or -ENOENT for this type in
pmu_sbi_event_map. Considering that other implementations return -ENOENT
for unsupported perf types, let's synchronize this behavior. Due to this
reason, a riscv bpf testcases perf_skip fail. Meanwhile, align that
behavior to the rest of proper place.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Fixes: 9b3e150e310e ("RISC-V: Add a simple platform driver for RISC-V legacy perf")
Fixes: 16d3b1af0944 ("perf: RISC-V: Check standard event availability")
Fixes: e9991434596f ("RISC-V: Add perf platform driver based on SBI PMU extension")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240831071520.1630360-1-pulehui@huaweicloud.com
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/riscv_pmu_legacy.c |    4 ++--
 drivers/perf/riscv_pmu_sbi.c    |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -22,13 +22,13 @@ static int pmu_legacy_ctr_get_idx(struct
 	struct perf_event_attr *attr = &event->attr;
 
 	if (event->attr.type != PERF_TYPE_HARDWARE)
-		return -EOPNOTSUPP;
+		return -ENOENT;
 	if (attr->config == PERF_COUNT_HW_CPU_CYCLES)
 		return RISCV_PMU_LEGACY_CYCLE;
 	else if (attr->config == PERF_COUNT_HW_INSTRUCTIONS)
 		return RISCV_PMU_LEGACY_INSTRET;
 	else
-		return -EOPNOTSUPP;
+		return -ENOENT;
 }
 
 /* For legacy config & counter index are same */
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -309,7 +309,7 @@ static void pmu_sbi_check_event(struct s
 			  ret.value, 0x1, SBI_PMU_STOP_FLAG_RESET, 0, 0, 0);
 	} else if (ret.error == SBI_ERR_NOT_SUPPORTED) {
 		/* This event cannot be monitored by any counter */
-		edata->event_idx = -EINVAL;
+		edata->event_idx = -ENOENT;
 	}
 }
 
@@ -543,7 +543,7 @@ static int pmu_sbi_event_map(struct perf
 		}
 		break;
 	default:
-		ret = -EINVAL;
+		ret = -ENOENT;
 		break;
 	}
 



