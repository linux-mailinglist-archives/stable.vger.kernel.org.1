Return-Path: <stable+bounces-114514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F68A2ECE6
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECCA18888E9
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 12:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D052206A5;
	Mon, 10 Feb 2025 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r/qTvmR+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ECC1F3D41
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191940; cv=none; b=t0ruKxdx3GL6J1ZIswhEGTnxBO1h+NMgochQRGkXcGmavDXX2+DZ46ZTPNIXWHhVS1UkJgNDSLcZac0tw0uJnU1OwU6d3muttspra6Df/+y4Ao4s+VCdS44Cp/Nz+vHeJMav9XceZcW0ohPkLRJtEB9NvyOy35xMb9iUrbHHwhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191940; c=relaxed/simple;
	bh=EWZP1Uf/RUzAPyPNMGOSiFHKQ2MKgiL2OiHgXUcIfGY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FzyQvbNDAv+9Vlngr5ccRbFCdDB47VsgaePz6a2lm7aKy7u72sbD5mgBkHcWvHqeUA0AwMSoQhYE150yUlkY2ntYRXarstJU3d2hPLeUw7OHP+rCnrT2O0EHt5+eKQ+3FUfQp82YcceB7ntwJxvtQSPTUNqVaijjPGVbmzbYdg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r/qTvmR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08795C4CED1;
	Mon, 10 Feb 2025 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739191939;
	bh=EWZP1Uf/RUzAPyPNMGOSiFHKQ2MKgiL2OiHgXUcIfGY=;
	h=Subject:To:Cc:From:Date:From;
	b=r/qTvmR+MUQhcet6mGPxTuoNhgMAL9CmjfpEAzzVUQzVUpXMxn1NzP9lOdhExIaM+
	 r/JvNDmi8xhBDLVp6zfkiLXSQTxIVAhuVvDb+t+440bP4XdGZV565nMOaBobmDgveI
	 /m215qSm3agC88wbJC3pSURHKX3E7kszQOAU/67s=
Subject: FAILED: patch "[PATCH] cpufreq: fix using cpufreq-dt as module" failed to apply to 6.6-stable tree
To: andreas@kemnade.info,javierm@redhat.com,rrendec@redhat.com,viresh.kumar@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 13:52:11 +0100
Message-ID: <2025021010-liquefy-pointer-8122@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f1f010c9d9c62c865d9f54e94075800ba764b4d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021010-liquefy-pointer-8122@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1f010c9d9c62c865d9f54e94075800ba764b4d9 Mon Sep 17 00:00:00 2001
From: Andreas Kemnade <andreas@kemnade.info>
Date: Sun, 3 Nov 2024 22:02:51 +0100
Subject: [PATCH] cpufreq: fix using cpufreq-dt as module

This driver can be built as a module since commit 3b062a086984 ("cpufreq:
dt-platdev: Support building as module"), but unfortunately this caused
a regression because the cputfreq-dt-platdev.ko module does not autoload.

Usually, this is solved by just using the MODULE_DEVICE_TABLE() macro to
export all the device IDs as module aliases. But this driver is special
due how matches with devices and decides what platform supports.

There are two of_device_id lists, an allow list that are for CPU devices
that always match and a deny list that's for devices that must not match.

The driver registers a cpufreq-dt platform device for all the CPU device
nodes that either are in the allow list or contain an operating-points-v2
property and are not in the deny list.

Enforce builtin compile of cpufreq-dt-platdev to make autoload work.

Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as module")
Link: https://lore.kernel.org/all/20241104201424.2a42efdd@akair/
Link: https://lore.kernel.org/all/20241119111918.1732531-1-javierm@redhat.com/
Cc: stable@vger.kernel.org
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reported-by: Radu Rendec <rrendec@redhat.com>
Reported-by: Javier Martinez Canillas <javierm@redhat.com>
[ Viresh: Picked commit log from Javier, updated tags ]
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 92a83a9bb2e1..ea9afdc119fb 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -232,7 +232,7 @@ config CPUFREQ_VIRT
 	  If in doubt, say N.
 
 config CPUFREQ_DT_PLATDEV
-	tristate "Generic DT based cpufreq platdev driver"
+	bool "Generic DT based cpufreq platdev driver"
 	depends on OF
 	help
 	  This adds a generic DT based cpufreq platdev driver for frequency
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2a3e8bd317c9..9c198bd4f7e9 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -235,5 +235,3 @@ static int __init cpufreq_dt_platdev_init(void)
 			       sizeof(struct cpufreq_dt_platform_data)));
 }
 core_initcall(cpufreq_dt_platdev_init);
-MODULE_DESCRIPTION("Generic DT based cpufreq platdev driver");
-MODULE_LICENSE("GPL");


