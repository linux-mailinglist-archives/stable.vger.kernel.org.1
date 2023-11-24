Return-Path: <stable+bounces-1228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 236327F7E9F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7C85B21781
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CD428E32;
	Fri, 24 Nov 2023 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kgUPmt7n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6ADA2C85B;
	Fri, 24 Nov 2023 18:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B12FC433C7;
	Fri, 24 Nov 2023 18:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850877;
	bh=+FVhdxu2tl+foZPJFehkpuLJFqDUodOe60Jjuh7PjRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kgUPmt7n3sHsIFGkWqYLW6a3rqRpSt1NfRou/bW4LdejJ704iGlTIyB2A+N4MoYFp
	 ZIOMUQTjOZ6YisSQ2xttaZL7avxX24nMKIaBETkM9EvleK65R/POrpqjDK16pwbr2Z
	 +JWic+8iGRAReUs7kQyLCLBkMS7Ta9BrC6X6I4lY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Will Deacon <will@kernel.org>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.5 225/491] perf: arm_cspmu: Reject events meant for other PMUs
Date: Fri, 24 Nov 2023 17:47:41 +0000
Message-ID: <20231124172031.317850145@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilkka Koskinen <ilkka@os.amperecomputing.com>

commit 15c7ef7341a2e54cfa12ac502c65d6fd2cce2b62 upstream.

Coresight PMU driver didn't reject events meant for other PMUs.
This caused some of the Core PMU events disappearing from
the output of "perf list". In addition, trying to run e.g.

     $ perf stat -e r2 sleep 1

made Coresight PMU driver to handle the event instead of letting
Core PMU driver to deal with it.

Cc: stable@vger.kernel.org
Fixes: e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU driver")
Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Besar Wicaksono <bwicaksono@nvidia.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20231103001654.35565-1-ilkka@os.amperecomputing.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/perf/arm_cspmu/arm_cspmu.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -635,6 +635,9 @@ static int arm_cspmu_event_init(struct p
 
 	cspmu = to_arm_cspmu(event->pmu);
 
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
 	/*
 	 * Following other "uncore" PMUs, we do not support sampling mode or
 	 * attach to a task (per-process mode).



