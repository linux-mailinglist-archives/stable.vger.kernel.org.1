Return-Path: <stable+bounces-120165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E840AA4C85C
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057501764BF
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77754276045;
	Mon,  3 Mar 2025 16:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhGl3xEw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E2D276026;
	Mon,  3 Mar 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019543; cv=none; b=Q5xCCnnu/1/uq2VMIzy+dQa9MN+e7BktdXAI+J1LLOQvW4TNzDTqaKPV5H90sKHzXP+rJreuysgDu4JKowvNw7LExCrb/njeQicBiFgkE2ozHx0yg1npeq4WkkDly0afx3ibr58jEpBov9ih6treTEpMmPVL0Wi1wKdb5OGA6iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019543; c=relaxed/simple;
	bh=f2XNXZG1SYrbkKATe50la94npIAtTp3G3yKIcj6Ixd0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQok9Gcx7WUTQEvPpxkud7+zD3X/MitdyHRu+u59gi2gd8LfNhJLS+JFctHL2Bci/PT2HgO1/zAgoBCk57BV5q3aoI9WBzxiPLONUdcxxcNSCRr9MwcHlIeZKYZu8jTGd5qjR4rmHVjz5lmq/A7AEuMZ3SHesYO8S6+AlIp60N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhGl3xEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76099C4CEEB;
	Mon,  3 Mar 2025 16:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019542;
	bh=f2XNXZG1SYrbkKATe50la94npIAtTp3G3yKIcj6Ixd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhGl3xEwzxCPFL/w6nZiJcDoyVwJ7PJsX34qff8L6sRWIsZ9ZIne8ncSlUqqmyU24
	 8gr5OX8Cs8vwmExBuCfenW0u4LTlx2/qEnreyLHX7mp1ZKALuS7lnfHuE0mq6/eLgD
	 ibq7TGEvunNxtN6jMTOqjd8YY39uBKkYx65C/N7PAanXc3rPM15YtTDFP+P5ii/V1J
	 f6DwpUWa7RQXGTDoM2HyYagtoleVHI9E2bNg/mflqtfh6g8K6mYMzelBlEHfZqYjOk
	 oD9EEuMeNncm9uSq51CVNb9MAfiz/x5N8+DXeaED4DZPawHH0mxRA9ZOEZtM/vhlTS
	 ba/csDIcs60eQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	jacob.jun.pan@linux.intel.com
Subject: [PATCH AUTOSEL 5.10 5/8] x86/irq: Define trace events conditionally
Date: Mon,  3 Mar 2025 11:32:08 -0500
Message-Id: <20250303163211.3764282-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163211.3764282-1-sashal@kernel.org>
References: <20250303163211.3764282-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9de7695925d5d2d2085681ba935857246eb2817d ]

When both of X86_LOCAL_APIC and X86_THERMAL_VECTOR are disabled,
the irq tracing produces a W=1 build warning for the tracing
definitions:

  In file included from include/trace/trace_events.h:27,
                 from include/trace/define_trace.h:113,
                 from arch/x86/include/asm/trace/irq_vectors.h:383,
                 from arch/x86/kernel/irq.c:29:
  include/trace/stages/init.h:2:23: error: 'str__irq_vectors__trace_system_name' defined but not used [-Werror=unused-const-variable=]

Make the tracepoints conditional on the same symbosl that guard
their usage.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250225213236.3141752-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index ce904c89c6c70..3e01b80864031 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -22,8 +22,10 @@
 #include <asm/desc.h>
 #include <asm/traps.h>
 
+#if defined(CONFIG_X86_LOCAL_APIC) || defined(CONFIG_X86_THERMAL_VECTOR)
 #define CREATE_TRACE_POINTS
 #include <asm/trace/irq_vectors.h>
+#endif
 
 DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
 EXPORT_PER_CPU_SYMBOL(irq_stat);
-- 
2.39.5


