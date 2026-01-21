Return-Path: <stable+bounces-210664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMpRBK1AcGnXXAAAu9opvQ
	(envelope-from <stable+bounces-210664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:57:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B3C501D0
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11F3052DBF9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 02:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27B932F749;
	Wed, 21 Jan 2026 02:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D4L5k5eQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032CA1B4223
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 02:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768964262; cv=none; b=cGZqdPIll5utMIbq9cqEBYzfD0hZ+4qrYRMF8rmbfF0X9TeD7Kk1S/RRVWc38AUbS3FkMhA9sw/wispUlfD/3xJ/8XIxEC7DJLaJyRw+SS1ajTHtd+12/XUFn3+R+yLP6m+85hwC88+xRErdXiV1JcEFvn5Ux/G4NOjp3JkGLWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768964262; c=relaxed/simple;
	bh=hbP6G2OEiSDygai0RblmEL6US2r6+OFe2H5LSh1lFQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRUfDtcDTPzIicL5SINhu2Ei/LG9U3Cv1cojsLIvg+/srcGL4RSlDOnU8bhErIIKhPrxjWLv8XbKWdb2QHshIkpzDdPdbzlTn/+euNBKKSWr19jxUFwIFrEdLfb3kEpk/6gteZBVXDDl/mlIfzbRBHCyxi7Bmd8k4ixwKeE38tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4L5k5eQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B79C19423;
	Wed, 21 Jan 2026 02:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768964261;
	bh=hbP6G2OEiSDygai0RblmEL6US2r6+OFe2H5LSh1lFQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D4L5k5eQETE4awRaX8mxyVqjLiQPu49WdLItsxEzkeNRuBlWasoMUQereR4IRrOSR
	 eGACV4Thjd/YS8MoQ2BxsAPTwKy0eWGPW5q5g+jJinID4btZikF+8Fyz1b4RMlgBz2
	 wI/XUuol2NHzIs4LhQP38OnDyw3RzlcCPWxMQvI11LW9oTK19U0xsk2GnHxPv1EzdI
	 3jGCZ3g6mIxb/cce+aKgHT8i4yW4gsowtQeK+J5CyE3zCUSx9yyWn28eIS6Pvc1bQt
	 IoaQPcA4lpv6FwsTZQ29A1SPPZdMp++bcljDM8MdxpoObLasz1H7rHGeFI8Mb8sNNv
	 pRtvFSQx/j7Kg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiaochen Shen <shenxiaochen@open-hieco.net>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] x86/resctrl: Add missing resctrl initialization for Hygon
Date: Tue, 20 Jan 2026 21:57:38 -0500
Message-ID: <20260121025738.1158111-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121025738.1158111-1-sashal@kernel.org>
References: <2026012056-existing-collide-49ad@gregkh>
 <20260121025738.1158111-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210664-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,alien8.de:email]
X-Rspamd-Queue-Id: A3B3C501D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xiaochen Shen <shenxiaochen@open-hieco.net>

[ Upstream commit 6ee98aabdc700b5705e4f1833e2edc82a826b53b ]

Hygon CPUs supporting Platform QoS features currently undergo partial resctrl
initialization through resctrl_cpu_detect() in the Hygon BSP init helper and
AMD/Hygon common initialization code. However, several critical data
structures remain uninitialized for Hygon CPUs in the following paths:

 - get_mem_config()-> __rdt_get_mem_config_amd():
     rdt_resource::membw,alloc_capable
     hw_res::num_closid

 - rdt_init_res_defs()->rdt_init_res_defs_amd():
     rdt_resource::cache
     hw_res::msr_base,msr_update

Add the missing AMD/Hygon common initialization to ensure proper Platform QoS
functionality on Hygon CPUs.

Fixes: d8df126349da ("x86/cpu/hygon: Add missing resctrl_cpu_detect() in bsp_init helper")
Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251209062650.1536952-2-shenxiaochen@open-hieco.net
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/resctrl/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 32005e229c03c..7dae63a953abc 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -834,7 +834,8 @@ static __init bool get_mem_config(void)
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		return __get_mem_config_intel(&rdt_resources_all[RDT_RESOURCE_MBA]);
-	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+		 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return __rdt_get_mem_config_amd(&rdt_resources_all[RDT_RESOURCE_MBA]);
 
 	return false;
@@ -960,7 +961,8 @@ static __init void rdt_init_res_defs(void)
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		rdt_init_res_defs_intel();
-	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+		 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		rdt_init_res_defs_amd();
 }
 
-- 
2.51.0


