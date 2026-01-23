Return-Path: <stable+bounces-211399-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFycESObc2nNxQAAu9opvQ
	(envelope-from <stable+bounces-211399-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 17:00:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC42781D9
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 17:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B333059907
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 15:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436735977;
	Fri, 23 Jan 2026 15:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=csmantle.top header.i=rong.bao@csmantle.top header.b="aGtZgn3h"
X-Original-To: stable@vger.kernel.org
Received: from o47.p25.mailjet.com (o47.p25.mailjet.com [185.189.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CA2F851
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.189.236.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183795; cv=none; b=uQFW5RQtlQgmAci/CtxtsDGsqTiWoIUa5aoqlS2AMZVfiR7wl8qqu9KT6Ti4bMDXSDbQfZJwIGj4rs/qI3PcAerDJq6/FLgie90WAJab275uhzZhNb6nYjDp/314MqzDs0H7aguRJ0kck0488OPpInStS6iHyj0z/vjh00z3edY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183795; c=relaxed/simple;
	bh=n625F9iOcmfm4oeosR440PIXnRGSOWmz0lx0rm52p6Y=;
	h=Message-Id:MIME-Version:From:To:Subject:Date:Cc; b=FWZjyvePACyYNnbDArk37zAYbogs4/6FVr9lRChajVO3V9k6R7xl+rQdzdk/HWRZlURqAst3Hk6SqOMjq07/x6jSyZV7Ey1D2HYJVgjfOI3Y7HPK0tmqhzQtJcD2vpNtPTmJV7H74BjaxqeWDWgKP3gL5FeOjTx5INd5LOmKaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top; spf=pass smtp.mailfrom=a3364097.bnc3.mailjet.com; dkim=pass (2048-bit key) header.d=csmantle.top header.i=rong.bao@csmantle.top header.b=aGtZgn3h; arc=none smtp.client-ip=185.189.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a3364097.bnc3.mailjet.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; q=dns/txt;
  d=csmantle.top; i=rong.bao@csmantle.top; s=mailjet; x=1769190989;
  h=message-id:mime-version:from:from:to:to:subject:subject:date:date:list-unsubscribe-post:list-unsubscribe:
  cc:feedback-id:x-csa-complaints:x-mj-mid:x-mj-smtpguid:x-report-abuse-to:
  content-transfer-encoding;
  bh=n625F9iOcmfm4oeosR440PIXnRGSOWmz0lx0rm52p6Y=;
  b=aGtZgn3hMy1Xs9KHzley4W/fFaKJz5l+VXzUMpsqFnRyUfoDiGWgrLvyP
 fxP7ir9NG51cQkd5bZCvfGzLYh6B9Xu+kTgmdUP94kVcvQc1m1ZCRPjowHgM
 2neoX/TsQVEPOxa/Ji/kAP9iKNq+nOA8LO1A806a1aB7f82fMRCGLzJyHAjY
 qar+/zFRPLb/HLAHd4vHauCLe6BKaZgqM7DHazLbv8wfrzPiaaoCcGI3KdyV
 9tMs6HBDXiF8MS2sqTw42DtNzkYkWb8zsD/AIjZk297O8zjUesI9+EJ8Lzfu
 HzMYKbVN1kvWkrr8Fj4buGax+7k1sSwnVHJwdLzKDGj+w==
Message-Id: <e44d8406.AWMAAIrycOEAAAAAAAAAA-ma1qUAAYKJPtkAAAAAADNVAQBpc5ot@mailjet.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rong Bao <rong.bao@csmantle.top>
To: Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH] loongarch: retrieve CPU package ID from PPTT when available
Date: Fri, 23 Jan 2026 23:56:06 +0800
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Cc: Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>,
	Rong Bao <rong.bao@csmantle.top>, stable@vger.kernel.org, WANG Xuerui
	<kernel@xen0n.name>, Yuli Wang <wangyuli@uniontech.com>, Yanteng Si
	<si.yanteng@linux.dev>, Masahiro Yamada <masahiroy@kernel.org>,
	Hongliang Wang <wanghongliang@loongson.cn>, Thierry Reding
	<treding@nvidia.com>, Tianyang Zhang <zhangtianyang@loongson.cn>,
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Feedback-Id: 42.3364097.3062169:MJ
X-CSA-Complaints: csa-complaints@eco.de
X-MJ-Mid:
	AWMAAIrycOEAAAAAAAAAA-ma1qUAAYKJPtkAAAAAADNVAQBpc5otdaWHx0l4T1eqou6TQoQvzQAuuZk
X-MJ-SMTPGUID: e6c17ccd-6fab-4083-aa61-d129a700786e
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
	abuse@mailjet.com with a copy of the message
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[csmantle.top : SPF not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[csmantle.top:s=mailjet];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211399-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[csmantle.top:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rong.bao@csmantle.top,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailjet.com:mid,csmantle.top:email]
X-Rspamd-Queue-Id: 9EC42781D9
X-Rspamd-Action: no action

Currently, the LoongArch CPU topology initialization code calculates
each core's package ID by dividing its physical ID by
loongson_sysconf.cores_per_package. This relies on the assumption that
cores_per_package counts in the same domain as physical IDs.

On Loongson 3B6000 (XB612B0V_1.2), cores_per_package matches the visible
core count -- 24 in this case. However, the physical IDs range from 0 to
31 in a noncontiguous fashion:

        $ cat /proc/cpuinfo | grep -i -F 'global_id'
        global_id               : 0
        global_id               : 1
        global_id               : 4
        global_id               : 5
        global_id               : 6
        global_id               : 7
        global_id               : 8
        global_id               : 9
        global_id               : 10
        global_id               : 11
        global_id               : 14
        global_id               : 15
        global_id               : 16
        global_id               : 17
        global_id               : 20
        global_id               : 21
        global_id               : 22
        global_id               : 23
        global_id               : 26
        global_id               : 27
        global_id               : 28
        global_id               : 29
        global_id               : 30
        global_id               : 31

Retrieve the exact package ID from ACPI PPTT when available, in the same
style as retrieving the core ID and thread ID in parse_acpi_topology().
Use this information in loongson_init_secondary() when PPTT readout is
successful. The original division logic is kept as a fallback.

Cc: stable@vger.kernel.org
Signed-off-by: Rong Bao <rong.bao@csmantle.top>
---
 arch/loongarch/kernel/acpi.c | 9 ++++++++-
 arch/loongarch/kernel/smp.c  | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 1367ca759468..82c7ffd4f1ac 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -176,7 +176,7 @@ int pptt_enabled;
 
 int __init parse_acpi_topology(void)
 {
-	int cpu, topology_id;
+	int cpu, topology_id, package_id;
 
 	for_each_possible_cpu(cpu) {
 		topology_id = find_acpi_cpu_topology(cpu, 0);
@@ -194,6 +194,13 @@ int __init parse_acpi_topology(void)
 
 			cpu_data[cpu].core = topology_id;
 		}
+
+		package_id = find_acpi_cpu_topology_package(cpu);
+		if (package_id < 0) {
+			pr_warn("Invalid BIOS PPTT\n");
+			return -ENOENT;
+		}
+		cpu_data[cpu].package = package_id;
 	}
 
 	pptt_enabled = 1;
diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index 8b2fcb3fb874..409e49d4da37 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -412,7 +412,7 @@ void loongson_init_secondary(void)
 	numa_add_cpu(cpu);
 #endif
 	per_cpu(cpu_state, cpu) = CPU_ONLINE;
-	cpu_data[cpu].package =
+	cpu_data[cpu].package = pptt_enabled ? cpu_data[cpu].package :
 		     cpu_logical_map(cpu) / loongson_sysconf.cores_per_package;
 	cpu_data[cpu].core = pptt_enabled ? cpu_data[cpu].core :
 		     cpu_logical_map(cpu) % loongson_sysconf.cores_per_package;
-- 
2.52.0


