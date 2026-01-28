Return-Path: <stable+bounces-212044-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOaSEc8temnd3gEAu9opvQ
	(envelope-from <stable+bounces-212044-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:39:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF53A428C
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF2C309BD81
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F1B246BC5;
	Wed, 28 Jan 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PJrRTFeS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681E21FF30;
	Wed, 28 Jan 2026 15:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614212; cv=none; b=diUdszB5KnrOrb/JtMYCLXePX2mJ7i0EjBKFlnBo1tC4enGC7Z10RGcCHNjKttXmQaENs9QoXxX98nu39bY+/bJDXEsbozL60mH1zFCFS8BHf8hWwaZgnW843Y66yge1Pj0NQNl1s5BtoFemn7oi7FIQtvG0tWJGEMyocpmBrgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614212; c=relaxed/simple;
	bh=/WBEDbccF3kkgtXOlc9cRlBZM1iuikxxLIkDVr+q6Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUJoIbawPJbTMCqwHh5ykcy0QBb3VJEte44WVO0P73mb0PPOIt59LXXMulgBCNYHBJkDzUQxh3ECO9uksAVObsC0cccw3GwpkOiRJT3hhlXXJpnbQPLkLWtViC3JsG2/GnijDFdRGyaU1vv7POx99skdjUPb8BXPm/Lglwili/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PJrRTFeS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4969C4CEF1;
	Wed, 28 Jan 2026 15:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769614212;
	bh=/WBEDbccF3kkgtXOlc9cRlBZM1iuikxxLIkDVr+q6Ps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJrRTFeSB5zhi+DpP9k3rHEop6PdPUQVCY4LGW1zTUR328d0g/T0POUq1zuXvQXSB
	 IhzKSyEnr0pZklgCfXvIcgRZk7DLv4VRKZrILlC6w1bIz15MAZmmGckn4NnvVDq3fR
	 pzCDLl9/HcbgH5CLOlO92yRru2RfBpbHh5NEhsyU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiaochen Shen <shenxiaochen@open-hieco.net>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH 6.6 067/254] x86/resctrl: Add missing resctrl initialization for Hygon
Date: Wed, 28 Jan 2026 16:20:43 +0100
Message-ID: <20260128145347.108949102@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.698118637@linuxfoundation.org>
References: <20260128145344.698118637@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212044-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,alien8.de:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,open-hieco.net:email,msgid.link:url]
X-Rspamd-Queue-Id: 9CF53A428C
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaochen Shen <shenxiaochen@open-hieco.net>

commit 6ee98aabdc700b5705e4f1833e2edc82a826b53b upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/resctrl/core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -755,7 +755,8 @@ static __init bool get_mem_config(void)
 
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		return __get_mem_config_intel(&hw_res->r_resctrl);
-	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+		 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
 
 	return false;
@@ -907,7 +908,8 @@ static __init void rdt_init_res_defs(voi
 {
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		rdt_init_res_defs_intel();
-	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	else if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+		 boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
 		rdt_init_res_defs_amd();
 }
 



