Return-Path: <stable+bounces-238728-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0K/MA0Ly5WkMpgEAu9opvQ
	(envelope-from <stable+bounces-238728-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:30:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB4428E09
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2392E3039D92
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161F438F25F;
	Mon, 20 Apr 2026 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CRQl3FSW"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B438CFFA;
	Mon, 20 Apr 2026 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677393; cv=none; b=W0JV5lqPumBwFLRTfGK6miABlOIVm4Q7OJA5HHp6nVVvFF2ZiQxrZmBNWReAXMSSq4ZNg+s/igIjd1mSwjLLZYj6ev0A19QPjrDcxMcccgkdBscdRjGGR20DPwAbnsSzSUxnTQ+klXxXDmNcSN+T6IejLdCrj7yHlHByMScSotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677393; c=relaxed/simple;
	bh=dCyASQv/4XztmsIYk1Flo/oDFHV7wnr3lzX8kb24qtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FvXuScQ7OO8H9/f/RMc30W5E0zJZTRZv2v+CzWtdrw2KMG4rE36VURNDQMMnNAMErI/dHR7PCHaWl5z9oMG17raTV1hl116ayno1eIY1hGRietPDoxBippIhm0vNdhFe6DJPQOBTN6wxcWWLJYrip6rEXHePrIITAkq01VXgiWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CRQl3FSW; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=l3E7Js9iCtlEfFoCuvz8eXLkCYO1Y8/jvTZT5sU/BaI=; b=CRQl3FSWYhYcm8pcTXKhNrpvUZ
	EP7rGrDLzUEYtU8AqPC5MpNqCzsSMZKCw+BedlBQ1WWpPDEUz3eo4uWisHtnQAwtnkiEfDpfdzHhe
	C1qJ2LCI4IK4pCzyS4mIQJuQ8QtDpi5lYKRZd0EHpUKA8Qmq13AEg7Stuv2ltVrkFpRlerFVaTLOD
	mNN37pGoJ2O4+50iizUla1Q/wyRqz+DUVHC57tSQveQcomKbfVqtCPeaUxixqlIGWXLt1TLcwo3nb
	QW6fo3gfyYohX7E9rnEo1E28mxAN+CQe+iuxkCXPvCe1kght5RxOTxaIQLwfZRolfHA3eXosTfvtM
	+kX6N+rA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wEkwa-00HaDw-1t;
	Mon, 20 Apr 2026 09:29:28 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Apr 2026 02:27:13 -0700
Subject: [PATCH] ACPI: arm64: cpuidle: Tolerate platforms with no deep PSCI
 idle states
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-ffh-v1-1-6b4c10fec442@debian.org>
X-B4-Tracking: v=1; b=H4sIAHDx5WkC/yXMMQqEMBBG4asMf21AEwmaqywW6s7oWOiSqAji3
 cW1fMX3TiSOygmBTkTeNekyI1CREfqxnQc2+kUg2Nz6vCycERlN7cRXnZXStw4Z4RdZ9PhfPs3
 baesm7teH4rpuKopwrmcAAAA=
X-Change-ID: 20260413-ffh-93f68b2f46a3
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Huisong Li <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, pjaroszynski@nvidia.com, rmikey@meta.com, 
 kernel-team@meta.com, stable@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2471; i=leitao@debian.org;
 h=from:subject:message-id; bh=dCyASQv/4XztmsIYk1Flo/oDFHV7wnr3lzX8kb24qtU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp5fHzqn+00bv5uiKjyfb0L3oxZFEemEvZoPtx7
 SfZPToQOv2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaeXx8wAKCRA1o5Of/Hh3
 bSCeD/97foqkwPA2sEHhr9/FhCvzbuTMfq2L5IYng7YjGvEuYfpcRqx4O1FLN9tEr9/tUo7ONtJ
 C09130QdJvpFLNJfi2KYl4rLyEiGyT7DIzsfUmLFCN0zpTg0ilVHiNm28VutMdU04zMpRNn7v1m
 9VR2bGjBqr3hwSrA3Nqwx6Wv7envXp6cAWoqAWzOJb27+/zGR2fIHTHAEr95NDVEy+UI3eI/3v5
 s5q7jk06CVpyp3AAby8D60kpwQadz0TISp0kTw0O05uFrdCw0kd2/lHKh6FC9QeS0oppiy+/yrm
 o0DyFgJKyjytOJ78V2Nn7hnBacrT6WC0yVNowb10UlveuefuTmZfRNCBammkrTIGJrLrAlkRcGE
 BYKKD1keoP/tqfapcaLSyuhS3AYWuIUUG58ezNInLcs18HMa5Fyd1OFRwOIfjWajzxfA7b2mP7Z
 kwrL4MHM18KA0KYjgq/yLw+fqRjGi0/YQETM+KbnwIVTFLIHMNjSbALee/J+mM0DM6qOrm7TrZ4
 wmrcxSFME+g3Pa5yicC2aTtQJPEGByK90k+aYgM1vBDytiyfaNsHT44jvT0kWVh0em32tPanwWL
 5pHHY3aUlf3fV0WoQ+IlYrjxYKmRM+diZ/95gtNDyrfwE2Zh/rgnBnVl34tGq1uxi17NzwwiqIj
 b0Mhx3IjlF2IVkQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238728-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EFB4428E09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit cac173bea57d ("ACPI: processor: idle: Rework the handling of
acpi_processor_ffh_lpi_probe()") moved the acpi_processor_ffh_lpi_probe()
call from acpi_processor_setup_cpuidle_dev(), where its return value was
ignored, to acpi_processor_get_power_info(), where it is now treated as
a hard failure. As a result, platforms where psci_acpi_cpu_init_idle()
returned -ENODEV stopped registering any cpuidle states, forcing CPUs to
busy-poll when idle.

On NVIDIA Grace (aarch64) systems with PSCIv1.1, pr->power.count is 1
(only WFI, no deep PSCI states beyond it), so the previous
"count = pr->power.count - 1; if (count <= 0) return -ENODEV;" check
returned -ENODEV for all 72 CPUs and disabled cpuidle entirely.

The lpi_states count is already validated in acpi_processor_get_lpi_info(),
so the check here is redundant. Simplify the loop to iterate over
lpi_states[1..power.count). When only WFI is present, the loop body
simply does not execute and the function returns 0, which is the correct
outcome: there is nothing to validate for FFH and no error to report.

Suggested-by: Huisong Li <lihuisong@huawei.com>
Cc: stable@vger.kernel.org
Fixes: cac173bea57d ("ACPI: processor: idle: Rework the handling of acpi_processor_ffh_lpi_probe()")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/acpi/arm64/cpuidle.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
index 801f9c4501425..c68a5db8ebba8 100644
--- a/drivers/acpi/arm64/cpuidle.c
+++ b/drivers/acpi/arm64/cpuidle.c
@@ -16,7 +16,7 @@
 
 static int psci_acpi_cpu_init_idle(unsigned int cpu)
 {
-	int i, count;
+	int i;
 	struct acpi_lpi_state *lpi;
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
@@ -30,14 +30,10 @@ static int psci_acpi_cpu_init_idle(unsigned int cpu)
 	if (!psci_ops.cpu_suspend)
 		return -EOPNOTSUPP;
 
-	count = pr->power.count - 1;
-	if (count <= 0)
-		return -ENODEV;
-
-	for (i = 0; i < count; i++) {
+	for (i = 1; i < pr->power.count; i++) {
 		u32 state;
 
-		lpi = &pr->power.lpi_states[i + 1];
+		lpi = &pr->power.lpi_states[i];
 		/*
 		 * Only bits[31:0] represent a PSCI power_state while
 		 * bits[63:32] must be 0x0 as per ARM ACPI FFH Specification

---
base-commit: 1c7cc4904160c6fc6377564140062d68a3dc93a0
change-id: 20260413-ffh-93f68b2f46a3

Best regards,
--  
Breno Leitao <leitao@debian.org>


