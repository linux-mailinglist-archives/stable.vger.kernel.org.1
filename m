Return-Path: <stable+bounces-162532-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D6B05E42
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 15:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFA3172F8D
	for <lists+stable@lfdr.de>; Tue, 15 Jul 2025 13:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5274D2E9EDF;
	Tue, 15 Jul 2025 13:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r52BkJHJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C962E2F0C;
	Tue, 15 Jul 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752586804; cv=none; b=Ec1zwXSyj0TZlpUw7XvQgdtvVb+ziDhGCiUmnqXRwsbAmRyfwC0YgYkbUfk+yECBT1I8C3sbBt+9MRdENdYr48tmJ3mQTl5bNBkDFQFMLlIXaAKxv/whUSll04lSloeBIoT2VH7u6oNdZJLb+0RvMjPp0wEFaY8LTDd55OfPHGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752586804; c=relaxed/simple;
	bh=g7pNUjqqG4drXZZdTqvwNPb/Yv/7cTY+q3cQYCRw4NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIGQiLBIoSGMWfHHdN7jldvo9eXc/L9wK3LRzgiDxEgjwvZi0owiCdYwQGelhkqtirSFa5mPWkbxsLeh1f5RItgj90O0XTBTCCNc+V7AidD2BJuNCiJok6o54WOZdjYe8uYYMsOrskf7OwKwp/JDKyt4SYLpsLQiwYfrs4k/0+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r52BkJHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85ACFC4CEE3;
	Tue, 15 Jul 2025 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752586803;
	bh=g7pNUjqqG4drXZZdTqvwNPb/Yv/7cTY+q3cQYCRw4NY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r52BkJHJDHFh0h2il8JtKClJTF9tZrG1vrVhBzKzvs8Q1kYe+rXUfwiNFkg1i8s1W
	 WMLDPCwTcP/UVa0yR0OrW1jn/+zfQFBiV7ssRq8FIne3SJ/q+vPO2djnV+czwKA3C1
	 6SvdAJqyM+ZCtaKIpLmJJwvcgTgFWQI1KWFjT4K0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH 6.15 053/192] x86/mce: Dont remove sysfs if thresholding sysfs init fails
Date: Tue, 15 Jul 2025 15:12:28 +0200
Message-ID: <20250715130816.971382789@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715130814.854109770@linuxfoundation.org>
References: <20250715130814.854109770@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yazen Ghannam <yazen.ghannam@amd.com>

commit 4c113a5b28bfd589e2010b5fc8867578b0135ed7 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/mce/core.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2801,15 +2801,9 @@ static int mce_cpu_dead(unsigned int cpu
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



