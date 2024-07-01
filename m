Return-Path: <stable+bounces-56247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87A191E275
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 16:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585DFB27CB5
	for <lists+stable@lfdr.de>; Mon,  1 Jul 2024 14:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E92D167DBD;
	Mon,  1 Jul 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aF/wdcyy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD988167DB5
	for <stable@vger.kernel.org>; Mon,  1 Jul 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719844232; cv=none; b=fN3ZIL3e+z/Rwus4vGafr4QCNV03D/RS44d4D1TVECj0JXc5TQ43WzxLaI3CbsENGviGNjSyTneuyFB9ahSt99dVjVEZTT+VWXA6aS6gkbeBeQf4bqvph0KxTcmpx38UBBA08GvTUv58TfzHD23JOdKL74t589w8kNm2qZVKFHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719844232; c=relaxed/simple;
	bh=RqMJUD5ZfWj9j4oLiAUfhj0PYDJ1p9RYOtol7+dWPRA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=E4NZJMn9WZA58DAsNocRxxb4TY2f9CMHQCH/aCKc2meDBDfTL7Jn3jjTbUvL89jfOxh7r5JoWgWyxeSG4bdXxpdeg/eIoBUJsoH61c3YriolLvoX+I5Ox6spmS4cRv1tHmZdFrieBL7CtFOzxgp3rKcQKuEoSMtwbROnHpM5ghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aF/wdcyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F039AC116B1;
	Mon,  1 Jul 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719844230;
	bh=RqMJUD5ZfWj9j4oLiAUfhj0PYDJ1p9RYOtol7+dWPRA=;
	h=Subject:To:Cc:From:Date:From;
	b=aF/wdcyyQ4ORto4udmS0gFlvpfuAlXbFD+TXrs15ywBj0J0LwHu/GkeUynw55RD9P
	 EYCnuDE2BidDSjLoxpKb2UR21CIw5c6FQMmPfxiC++8vTm54d6Dl4UqT+tkllJgcIy
	 dOMZE7hBBHm2oUZsMuhKWBSQmHHYDlPm05QG1eSw=
Subject: FAILED: patch "[PATCH] cpu: Fix broken cmdline "nosmp" and "maxcpus=0"" failed to apply to 6.6-stable tree
To: chenhuacai@kernel.org,chenhuacai@loongson.cn,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Jul 2024 16:28:54 +0200
Message-ID: <2024070154-legged-throwaway-bd6a@gregkh>
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
git cherry-pick -x 6ef8eb5125722c241fd60d7b0c872d5c2e5dd4ca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024070154-legged-throwaway-bd6a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

6ef8eb512572 ("cpu: Fix broken cmdline "nosmp" and "maxcpus=0"")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ef8eb5125722c241fd60d7b0c872d5c2e5dd4ca Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 18 Jun 2024 16:13:36 +0800
Subject: [PATCH] cpu: Fix broken cmdline "nosmp" and "maxcpus=0"

After the rework of "Parallel CPU bringup", the cmdline "nosmp" and
"maxcpus=0" parameters are not working anymore. These parameters set
setup_max_cpus to zero and that's handed to bringup_nonboot_cpus().

The code there does a decrement before checking for zero, which brings it
into the negative space and brings up all CPUs.

Add a zero check at the beginning of the function to prevent this.

[ tglx: Massaged change log ]

Fixes: 18415f33e2ac4ab382 ("cpu/hotplug: Allow "parallel" bringup up to CPUHP_BP_KICK_AP_STATE")
Fixes: 06c6796e0304234da6 ("cpu/hotplug: Fix off by one in cpuhp_bringup_mask()")
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240618081336.3996825-1-chenhuacai@loongson.cn

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 74cfdb66a9bd..3d2bf1d50a0c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1859,6 +1859,9 @@ static inline bool cpuhp_bringup_cpus_parallel(unsigned int ncpus) { return fals
 
 void __init bringup_nonboot_cpus(unsigned int max_cpus)
 {
+	if (!max_cpus)
+		return;
+
 	/* Try parallel bringup optimization if enabled */
 	if (cpuhp_bringup_cpus_parallel(max_cpus))
 		return;


