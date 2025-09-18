Return-Path: <stable+bounces-170097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1527CB2A29D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAEA189638E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6952131B122;
	Mon, 18 Aug 2025 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cPfJPQuL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2561130DD0F;
	Mon, 18 Aug 2025 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521505; cv=none; b=R+uBY8MKD++9c38ihRGR8SzIfAj6jdjnn0dcuofkvjRzygZjkxdXkzl+vLvJE7oak14NlgySXbovkbD9xWSklME8QD06lwDJOuBNSFjsA/5XEfV2bSoZ60wtnVGO5Ol6QRfBdCMA6byp33EjTi7qSCgB3C4G4txlTgaZaEGv1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521505; c=relaxed/simple;
	bh=ky7cTKK2JBo8t8B8hr0Ca2o0vtv3gif8wgOLFroDPjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxErkC1UykXUDDGI4347GYKZMgp/Ld0tCxydESZic8ZJ/KaC3m80L2QcuRto+o/ouCH1QQ38VJBsKvXRxfIfyooKgxUYuI4F2kK5SJUQKkqziVrfPCMJ7xPYh0QT0/3/OgiVCL2PL9PBQ9lbotkB79YPkB35px8AhiduS/gmmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cPfJPQuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B21C4CEEB;
	Mon, 18 Aug 2025 12:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521504;
	bh=ky7cTKK2JBo8t8B8hr0Ca2o0vtv3gif8wgOLFroDPjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPfJPQuLyz9E+6vP+eSjTL0E+oXtkXvMdr04rl7G85/FYInTWg7jzRWYL0REfLejT
	 d0tJqkNO80f9nOd1GHw0qG7wDxvBOYwm2rKHZjZR2oPDd4BQp0pMrM2XZadQoKnsrh
	 Hj4e9g9rIUyf9mIbrJGJfJnuPEmUpHd4H+P1Cct0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiayi Li <lijiayi@kylinos.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.12 039/444] ACPI: processor: perflib: Fix initial _PPC limit application
Date: Mon, 18 Aug 2025 14:41:05 +0200
Message-ID: <20250818124450.402425160@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
References: <20250818124448.879659024@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayi Li <lijiayi@kylinos.cn>

commit d33bd88ac0ebb49e7f7c8f29a8c7ee9eae85d765 upstream.

If the BIOS sets a _PPC frequency limit upfront, it will fail to take
effect due to a call ordering issue.  Namely, freq_qos_update_request()
is called before freq_qos_add_request() for the given request causing
the constraint update to be ignored.  The call sequence in question is
as follows:

cpufreq_policy_online()
  acpi_cpufreq_cpu_init()
    acpi_processor_register_performance()
      acpi_processor_get_performance_info()
        acpi_processor_get_platform_limit()
         freq_qos_update_request(&perflib_req) <- inactive QoS request
  blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
                               CPUFREQ_CREATE_POLICY)
    acpi_processor_notifier()
      acpi_processor_ppc_init()
        freq_qos_add_request(&perflib_req) <- QoS request activation

Address this by adding an acpi_processor_get_platform_limit() call
to acpi_processor_ppc_init(), after the perflib_req activation via
freq_qos_add_request(), which causes the initial _PPC limit to be
picked up as appropriate.  However, also ensure that the _PPC limit
will not be picked up in the cases when the cpufreq driver does not
call acpi_processor_register_performance() by adding a pr->performance
check to the related_cpus loop in acpi_processor_ppc_init().

Fixes: d15ce412737a ("ACPI: cpufreq: Switch to QoS requests instead of cpufreq notifier")
Signed-off-by: Jiayi Li <lijiayi@kylinos.cn>
Link: https://patch.msgid.link/20250721032606.3459369-1-lijiayi@kylinos.cn
[ rjw: Consolidate pr-related checks in acpi_processor_ppc_init() ]
[ rjw: Subject and changelog adjustments ]
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+: 2d8b39a62a5d ACPI: processor: Avoid NULL pointer dereferences at init time
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+: 3000ce3c52f8 cpufreq: Use per-policy frequency QoS
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+: a1bb46c36ce3 ACPI: processor: Add QoS requests for all CPUs
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/processor_perflib.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -174,11 +174,14 @@ void acpi_processor_ppc_init(struct cpuf
 {
 	unsigned int cpu;
 
+	if (ignore_ppc == 1)
+		return;
+
 	for_each_cpu(cpu, policy->related_cpus) {
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 		int ret;
 
-		if (!pr)
+		if (!pr || !pr->performance)
 			continue;
 
 		/*
@@ -194,6 +197,11 @@ void acpi_processor_ppc_init(struct cpuf
 		if (ret < 0)
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
+
+		ret = acpi_processor_get_platform_limit(pr);
+		if (ret)
+			pr_err("Failed to update freq constraint for CPU%d (%d)\n",
+			       cpu, ret);
 	}
 }
 



