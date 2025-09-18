Return-Path: <stable+bounces-170139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317C5B2A26D
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A02462296E
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C22431B10F;
	Mon, 18 Aug 2025 12:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JO5+RxZV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA18A27B355;
	Mon, 18 Aug 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521651; cv=none; b=F906p/vvrTJWvlaKeSGOhwnCJ87L38I1qpRmwInSgTmxIudPaSmJISmOoIckmN6IRrFrVojS7BvVIVfBCxSDFRK/pdzN46lUjbVdiExp1kPx+585D81x6EEOYyxsoBz8/XWjhwxhmtxVQ8saL29prl7ySnc2hhLiwj7jjaX34Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521651; c=relaxed/simple;
	bh=CWIkKYJMx0Ece/o0w/GrbQSDa4rU3MN+e31OYAUoh+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poiQDVaa2C/zRA55egsNA4QYW4biYFlVvdaipoIoCLCCOHQ3v6c/KL+mF+6zcocSKfDk/eXquhYTxoERsrDeodQJAximvk4+7fbJ5Hrb70JDeRDiqINGJrYj1BTxwIyqbLHFUoLTdbM45i2q0e18/V9Kz/5Luy9qVPwdKaklaa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JO5+RxZV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2599C4CEEB;
	Mon, 18 Aug 2025 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755521651;
	bh=CWIkKYJMx0Ece/o0w/GrbQSDa4rU3MN+e31OYAUoh+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JO5+RxZVZcZv3FOSa/W9msvcGY1deWROxorBtPH//9cCEFn6h52B6eeBgR1PsTY+B
	 qBNmdjhhMQdwKrR+qAB2UQmjPUYORoJ/iBS6/Zv6IIRwgYsSQsNCPtqab9EZqoohb1
	 7IT9SIXtGWnMGBmcpN+YgdF/LAsz1EvlT9AsPP5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 6.12 040/444] ACPI: processor: perflib: Move problematic pr->performance check
Date: Mon, 18 Aug 2025 14:41:06 +0200
Message-ID: <20250818124450.439410665@linuxfoundation.org>
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

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit d405ec23df13e6df599f5bd965a55d13420366b8 upstream.

Commit d33bd88ac0eb ("ACPI: processor: perflib: Fix initial _PPC limit
application") added a pr->performance check that prevents the frequency
QoS request from being added when the given processor has no performance
object.  Unfortunately, this causes a WARN() in freq_qos_remove_request()
to trigger on an attempt to take the given CPU offline later because the
frequency QoS object has not been added for it due to the missing
performance object.

Address this by moving the pr->performance check before calling
acpi_processor_get_platform_limit() so it only prevents a limit from
being set for the CPU if the performance object is not present.  This
way, the frequency QoS request is added as it was before the above
commit and it is present all the time along with the CPU's cpufreq
policy regardless of whether or not the CPU is online.

Fixes: d33bd88ac0eb ("ACPI: processor: perflib: Fix initial _PPC limit application")
Tested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/2801421.mvXUDI8C0e@rafael.j.wysocki
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/processor_perflib.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -181,7 +181,7 @@ void acpi_processor_ppc_init(struct cpuf
 		struct acpi_processor *pr = per_cpu(processors, cpu);
 		int ret;
 
-		if (!pr || !pr->performance)
+		if (!pr)
 			continue;
 
 		/*
@@ -198,6 +198,9 @@ void acpi_processor_ppc_init(struct cpuf
 			pr_err("Failed to add freq constraint for CPU%d (%d)\n",
 			       cpu, ret);
 
+		if (!pr->performance)
+			continue;
+
 		ret = acpi_processor_get_platform_limit(pr);
 		if (ret)
 			pr_err("Failed to update freq constraint for CPU%d (%d)\n",



