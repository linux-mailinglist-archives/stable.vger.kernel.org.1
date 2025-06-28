Return-Path: <stable+bounces-158821-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A7AEC6B6
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 13:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D45F4A146A
	for <lists+stable@lfdr.de>; Sat, 28 Jun 2025 11:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE3D24A057;
	Sat, 28 Jun 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="npwluFr0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uQkarKkd"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89970248866;
	Sat, 28 Jun 2025 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751110419; cv=none; b=oriZdMvsB0uM7fdUtGK9w35NR49SG/y/JN/z7hucr0DPEczdnlNsC4AjN88BXWebNXkBEh0JncF2Vx7U87SyeD52JuDTAgVxZFkNqGy6FRq0FUiQNJ+AWkyhBRCtHSrFaIsZciufe5LHtnlFFdlBFJsA3XyjgQ6kWTPQW3+3n50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751110419; c=relaxed/simple;
	bh=Z8sK1M/bb1wRBNMh2M/ISgCal11mKoUBS/jNphTLSt4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O0bc96PjS3XMe3FBShrsiyPOVAQAfuMZYeX1OzE9oVT4FN90m3yzObIug0Jbld87X6z2L3YxdjEdSvmNLwc+Uuegl6E5vR14SUKt4XYcHSzursvtqg0JnX4sUlhfO5GdiIYrb+9S0XJQy4aim46WUK8kxSrF/2jOCm/+6LMbUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=npwluFr0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uQkarKkd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Jun 2025 11:33:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751110408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wb202bpvw2Il4BHrHdWyvUPnpTWWca7OThyZ0nEquo=;
	b=npwluFr0fB1l760Rhc7h3s2tlk3wh7y7Mh04SsMIRWZugBSBHIUfRRa/plbQCMrd1O2nu0
	VGgbuv+87KY+plIskOcYUY7m5ITUcElhy55XVhg6MwySg9RJNX/LUZ58wPKvryFeeRTJqa
	7ktk7dLi+SwxhrjEq6tS5s5lubXr73W1+lC+8+yE+Gi4/olQZeio9YXsO7N5nrZ3gmQD36
	gixC+GpLQF7ILeAby7CZtfFLRRs9W6QQ3+76C3wU7/F3u8bwSA20m7mbq5OQCO8kMlCkwY
	yTErn3sPULf/Zdg3hmoSfGnq70f3VsluGtYYmKwsoBIvs5JJSrDjaPHOGEE9Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751110408;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5wb202bpvw2Il4BHrHdWyvUPnpTWWca7OThyZ0nEquo=;
	b=uQkarKkdPEimRCNz8bGCI5si5uLrtA2tR0G259/hk0C2+GKpZYCG6VqwjBXUE+gOilpHWJ
	xATO8CZxdMzmbHDw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/urgent] x86/mce: Don't remove sysfs if thresholding sysfs
 init fails
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Tony Luck <tony.luck@intel.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250624-wip-mca-updates-v4-1-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-1-236dd74f645f@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175111040774.406.1915924164324676187.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/urgent branch of tip:

Commit-ID:     4c113a5b28bfd589e2010b5fc8867578b0135ed7
Gitweb:        https://git.kernel.org/tip/4c113a5b28bfd589e2010b5fc8867578b0135ed7
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 24 Jun 2025 14:15:56 
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 26 Jun 2025 17:28:13 +02:00

x86/mce: Don't remove sysfs if thresholding sysfs init fails

Currently, the MCE subsystem sysfs interface will be removed if the
thresholding sysfs interface fails to be created. A common failure is due to
new MCA bank types that are not recognized and don't have a short name set.

The MCA thresholding feature is optional and should not break the common MCE
sysfs interface. Also, new MCA bank types are occasionally introduced, and
updates will be needed to recognize them. But likewise, this should not break
the common sysfs interface.

Keep the MCE sysfs interface regardless of the status of the thresholding
sysfs interface.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/20250624-wip-mca-updates-v4-1-236dd74f645f@amd.com
---
 arch/x86/kernel/cpu/mce/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e9b3c5d..07d6193 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2801,15 +2801,9 @@ static int mce_cpu_dead(unsigned int cpu)
 static int mce_cpu_online(unsigned int cpu)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
-	int ret;
 
 	mce_device_create(cpu);
-
-	ret = mce_threshold_create_device(cpu);
-	if (ret) {
-		mce_device_remove(cpu);
-		return ret;
-	}
+	mce_threshold_create_device(cpu);
 	mce_reenable_cpu();
 	mce_start_timer(t);
 	return 0;

