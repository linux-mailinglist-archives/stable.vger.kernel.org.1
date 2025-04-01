Return-Path: <stable+bounces-127337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8BFA77D86
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 16:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3026F3AEAA0
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 14:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E83204C17;
	Tue,  1 Apr 2025 14:18:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790451DF25C;
	Tue,  1 Apr 2025 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517120; cv=none; b=TNXAeOW515KmuIy6sJWDQ/Qar3xL4ih5+v0nSttdckSTtiI0Yp7yVkHwJ7iK6JosWXd/+Kr7/UrCh+E4OYoolUeN/ioO5qMfvaeGeDvpNWvFS9SINIPKCxPEKoFr0U8VOST+s643GKSCuiU0FKwzO/GFZAbx7M/QElhRcrcUp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517120; c=relaxed/simple;
	bh=+H8Y4inqSqA/NnBib4Aj5cYm+YX0DahBQFwcHapTRR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K+Sdlai1FG04SLxxrq183TTPvv0o3+Vf9LAKsIjV0qSEMQ/3nDynWJ7tOuHJAAIAG+0F4uSqAApEcBreM39lvTV+mpb73ipkAkCBCj5BPFuZAZMYxiCdNto2KvoOyOyKYjPBeT8dvk4Ita0sNMi83Zl7MB+8B4OIPWdgWLMXQRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowACn5g6W9etnbEPBBA--.49542S2;
	Tue, 01 Apr 2025 22:18:00 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] perf/x86/intel/uncore: Add error handling for uncore_msr_box_ctl()
Date: Tue,  1 Apr 2025 22:17:41 +0800
Message-ID: <20250401141741.2705-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACn5g6W9etnbEPBBA--.49542S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZw4xGrWrJF1rKFyUGFW7Jwb_yoW8JF1Dpr
	W29r9Iqry3ua95WayDGF18ArWayFWrGas8Wr4DG34fCrn8Jr13Gr47K3Waka95Gry8KFyx
	Zr18Xr4UGayDAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9j14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4
	AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE
	17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMI
	IF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4l
	IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvf
	C2KfnxnUUI43ZEXa7sRE2Q6tUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRETA2fr2Lpa7gAAsS

In mtl_uncore_msr_init_box(), the return value of uncore_msr_box_ctl()
needs to be checked before being used as the parameter of wrmsrl().
A proper implementation can be found in ivbep_uncore_msr_init_box().

Add error handling for uncore_msr_box_ctl() to ensure the MSR write
operation is only performed when a valid MSR address is returned.

Fixes: c828441f21dd ("perf/x86/intel/uncore: Add Meteor Lake support")
Cc: stable@vger.kernel.org # v6.3+
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 arch/x86/events/intel/uncore_snb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 3934e1e4e3b1..84070388f495 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -691,7 +691,10 @@ static struct intel_uncore_type mtl_uncore_hac_cbox = {
 
 static void mtl_uncore_msr_init_box(struct intel_uncore_box *box)
 {
-	wrmsrl(uncore_msr_box_ctl(box), SNB_UNC_GLOBAL_CTL_EN);
+	unsigned int msr = uncore_msr_box_ctl(box);
+
+	if (msr)
+		wrmsrl(msr, SNB_UNC_GLOBAL_CTL_EN);
 }
 
 static struct intel_uncore_ops mtl_uncore_msr_ops = {
-- 
2.42.0.windows.2


