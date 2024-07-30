Return-Path: <stable+bounces-64207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6627941CD7
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 19:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46201C21535
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF5C18E04A;
	Tue, 30 Jul 2024 17:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wahbWiJK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A71F18C902;
	Tue, 30 Jul 2024 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359349; cv=none; b=heSss12iX4VS5ooTlgOqNOtlFLSb8/8VkLuj3JkWgbXjsMS9w0m3UH5qbrO1sdU/U6KJtGjnysFKViA9YJ2SaPjboeyDZnWgNWAw4X+cMPkTiyyFsVBMetZemetw+6TJdHbD8FIBhuVGAtDv04fwjSL9pdfvWvtYftS6TCaN9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359349; c=relaxed/simple;
	bh=0ylTgy9H6njHfFTtMoLZSMWdl1nh0T4AJtRN+5Ey3Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHccbPp0tpQt01Hl7ofym897WVg06f2cqPHdbj0Ek4toa9jKeQgEMQ9rxFa3LglqXjWnwV8+TEmM2bPZsGNNvWrIYno5QKeS1EZWswEFQlXJUSdrjJaYIjAEfUlqXVHoHwS7YN2+Syx1q+XQDxey4b0KV34CBuvEIX1M/kB5DSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wahbWiJK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D40C4AF0C;
	Tue, 30 Jul 2024 17:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722359348;
	bh=0ylTgy9H6njHfFTtMoLZSMWdl1nh0T4AJtRN+5Ey3Z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wahbWiJK2ojKbFT2GT8bWlVM0hzbXhvrZixIDOpWEbx7S+YyPS9g3umR4ObEIDv9B
	 V70h/Pe04NeldWK3qR9kARWhq5FLLGwpxgtDE4eROeCfqBS/jBVCI7PXEsx9SlFooX
	 oWlGlA1UuK/YRHO21anK0ffIP48oHHjrLesSD8VA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kan Liang <kan.liang@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>
Subject: [PATCH 6.6 470/568] perf/x86/intel/uncore: Fix the bits of the CHA extended umask for SPR
Date: Tue, 30 Jul 2024 17:49:37 +0200
Message-ID: <20240730151658.395677895@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151639.792277039@linuxfoundation.org>
References: <20240730151639.792277039@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kan Liang <kan.liang@linux.intel.com>

commit a5a6ff3d639d088d4af7e2935e1ee0d8b4e817d4 upstream.

The perf stat errors out with UNC_CHA_TOR_INSERTS.IA_HIT_CXL_ACC_LOCAL
event.

 $perf stat -e uncore_cha_55/event=0x35,umask=0x10c0008101/ -a -- ls
    event syntax error: '..0x35,umask=0x10c0008101/'
                                      \___ Bad event or PMU

The definition of the CHA umask is config:8-15,32-55, which is 32bit.
However, the umask of the event is bigger than 32bit.
This is an error in the original uncore spec.

Add a new umask_ext5 for the new CHA umask range.

Fixes: 949b11381f81 ("perf/x86/intel/uncore: Add Sapphire Rapids server CHA support")
Closes: https://lore.kernel.org/linux-perf-users/alpine.LRH.2.20.2401300733310.11354@Diego/
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20240708185524.1185505-1-kan.liang@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/uncore_snbep.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -461,6 +461,7 @@
 #define SPR_UBOX_DID				0x3250
 
 /* SPR CHA */
+#define SPR_CHA_EVENT_MASK_EXT			0xffffffff
 #define SPR_CHA_PMON_CTL_TID_EN			(1 << 16)
 #define SPR_CHA_PMON_EVENT_MASK			(SNBEP_PMON_RAW_EVENT_MASK | \
 						 SPR_CHA_PMON_CTL_TID_EN)
@@ -477,6 +478,7 @@ DEFINE_UNCORE_FORMAT_ATTR(umask_ext, uma
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext2, umask, "config:8-15,32-57");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext3, umask, "config:8-15,32-39");
 DEFINE_UNCORE_FORMAT_ATTR(umask_ext4, umask, "config:8-15,32-55");
+DEFINE_UNCORE_FORMAT_ATTR(umask_ext5, umask, "config:8-15,32-63");
 DEFINE_UNCORE_FORMAT_ATTR(qor, qor, "config:16");
 DEFINE_UNCORE_FORMAT_ATTR(edge, edge, "config:18");
 DEFINE_UNCORE_FORMAT_ATTR(tid_en, tid_en, "config:19");
@@ -5954,7 +5956,7 @@ static struct intel_uncore_ops spr_uncor
 
 static struct attribute *spr_uncore_cha_formats_attr[] = {
 	&format_attr_event.attr,
-	&format_attr_umask_ext4.attr,
+	&format_attr_umask_ext5.attr,
 	&format_attr_tid_en2.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
@@ -5990,7 +5992,7 @@ ATTRIBUTE_GROUPS(uncore_alias);
 static struct intel_uncore_type spr_uncore_chabox = {
 	.name			= "cha",
 	.event_mask		= SPR_CHA_PMON_EVENT_MASK,
-	.event_mask_ext		= SPR_RAW_EVENT_MASK_EXT,
+	.event_mask_ext		= SPR_CHA_EVENT_MASK_EXT,
 	.num_shared_regs	= 1,
 	.constraints		= skx_uncore_chabox_constraints,
 	.ops			= &spr_uncore_chabox_ops,



