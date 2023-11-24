Return-Path: <stable+bounces-1263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C573B7F7ECB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A789B2180E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E62F35F1A;
	Fri, 24 Nov 2023 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qvH9i6ez"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7528DA1;
	Fri, 24 Nov 2023 18:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD56C433C8;
	Fri, 24 Nov 2023 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850963;
	bh=otLju7ysGNI5ABhakR3zClhNj/+Mk4q0XuA0Q2qyj/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvH9i6ezNmyIM2O57ax8s68wjPN6CqvK+y3PyiAfBapQ/HkAinOpphmSBPMDjvfos
	 ajpCkgfNXqmAecoiN07f+pZlUmk9w09SbBuSAIv8yECupyfmP+OQaMBZoOhapHq66d
	 uVfMTccaNJhwt0Hq3JaXbrAlmdnwwAB1rX90CchU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krister Johansen <kjlx@templeofstupid.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 6.5 259/491] watchdog: move softlockup_panic back to early_param
Date: Fri, 24 Nov 2023 17:48:15 +0000
Message-ID: <20231124172032.350347535@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krister Johansen <kjlx@templeofstupid.com>

commit 8b793bcda61f6c3ed4f5b2ded7530ef6749580cb upstream.

Setting softlockup_panic from do_sysctl_args() causes it to take effect
later in boot.  The lockup detector is enabled before SMP is brought
online, but do_sysctl_args runs afterwards.  If a user wants to set
softlockup_panic on boot and have it trigger should a softlockup occur
during onlining of the non-boot processors, they could do this prior to
commit f117955a2255 ("kernel/watchdog.c: convert {soft/hard}lockup boot
parameters to sysctl aliases").  However, after this commit the value
of softlockup_panic is set too late to be of help for this type of
problem.  Restore the prior behavior.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: f117955a2255 ("kernel/watchdog.c: convert {soft/hard}lockup boot parameters to sysctl aliases")
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/proc/proc_sysctl.c |    1 -
 kernel/watchdog.c     |    7 +++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1574,7 +1574,6 @@ static const struct sysctl_alias sysctl_
 	{"hung_task_panic",			"kernel.hung_task_panic" },
 	{"numa_zonelist_order",			"vm.numa_zonelist_order" },
 	{"softlockup_all_cpu_backtrace",	"kernel.softlockup_all_cpu_backtrace" },
-	{"softlockup_panic",			"kernel.softlockup_panic" },
 	{ }
 };
 
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -283,6 +283,13 @@ static DEFINE_PER_CPU(struct hrtimer, wa
 static DEFINE_PER_CPU(bool, softlockup_touch_sync);
 static unsigned long soft_lockup_nmi_warn;
 
+static int __init softlockup_panic_setup(char *str)
+{
+	softlockup_panic = simple_strtoul(str, NULL, 0);
+	return 1;
+}
+__setup("softlockup_panic=", softlockup_panic_setup);
+
 static int __init nowatchdog_setup(char *str)
 {
 	watchdog_user_enabled = 0;



