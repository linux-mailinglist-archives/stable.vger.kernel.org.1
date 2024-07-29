Return-Path: <stable+bounces-62472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00F293F334
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5B31C21D75
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8FA1448E7;
	Mon, 29 Jul 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A3TqtUib"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11925144304
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250305; cv=none; b=YJS+SXM2p8UBqTCI4asm+Pk9hXzz78qLc7jQ0xWk7LLZtFqbDvckLww6EaPMFyUbjR8UGKVz/Bxik4QKNI3cJ+Unrbz6qiQphFEaZ7f7PS+CpqQ9Y1f8bWAm7szUNpOYlTyOkbG3hVRCRP5qDNbFLEEour9jPMtIzAAqAiYkUY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250305; c=relaxed/simple;
	bh=C8oEQltbTtnFiQRC5E/25hORrH7GWROCLqJwJuAXWmA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GIcJ+qK8/lIOQLL2qUZAgpP7HPlATbKDYKmT04W7BxssWD88H9ga/I/WzhLZ+lDWG+FPTW8oIZ7p6KbU0WiG1AGA0GjHTQ5nSwozP5YyUYY+u5wUPg20co9q4LjOTBLsF2MizOCxK+zAqpeyExVcj39ZA7UAOMSmz0RvTfdk6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A3TqtUib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80730C32786;
	Mon, 29 Jul 2024 10:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250304;
	bh=C8oEQltbTtnFiQRC5E/25hORrH7GWROCLqJwJuAXWmA=;
	h=Subject:To:Cc:From:Date:From;
	b=A3TqtUibk1w2LlbadKlwsGXJVNM8cSY61bBzvGbMGWzcRZdJPxxoPNNvID72/+5zX
	 WMWzK6q02nJQ6j/kC3RFRhEqfUp9lVdMSYft8ERtSUTZSRviUm5T9H+mFTjDrdbUGZ
	 VSEUws9XkKbR6gMgPfuAbGwjjT/HG4cSBPeOUCkI=
Subject: FAILED: patch "[PATCH] drivers: soc: xilinx: check return status of" failed to apply to 5.15-stable tree
To: jay.buddhabhatti@amd.com,michal.simek@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:51:36 +0200
Message-ID: <2024072936-ogle-royal-3339@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9b003e14801cf85a8cebeddc87bc9fc77100fdce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072936-ogle-royal-3339@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

9b003e14801c ("drivers: soc: xilinx: check return status of get_api_version()")
7fd890b89dea ("soc: xilinx: move PM_INIT_FINALIZE to zynqmp_pm_domains driver")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b003e14801cf85a8cebeddc87bc9fc77100fdce Mon Sep 17 00:00:00 2001
From: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Date: Wed, 15 May 2024 04:23:45 -0700
Subject: [PATCH] drivers: soc: xilinx: check return status of
 get_api_version()

Currently return status is not getting checked for get_api_version
and because of that for x86 arch we are getting below smatch error.

    CC      drivers/soc/xilinx/zynqmp_power.o
drivers/soc/xilinx/zynqmp_power.c: In function 'zynqmp_pm_probe':
drivers/soc/xilinx/zynqmp_power.c:295:12: warning: 'pm_api_version' is
used uninitialized [-Wuninitialized]
    295 |         if (pm_api_version < ZYNQMP_PM_VERSION)
        |            ^
    CHECK   drivers/soc/xilinx/zynqmp_power.c
drivers/soc/xilinx/zynqmp_power.c:295 zynqmp_pm_probe() error:
uninitialized symbol 'pm_api_version'.

So, check return status of pm_get_api_version and return error in case
of failure to avoid checking uninitialized pm_api_version variable.

Fixes: b9b3a8be28b3 ("firmware: xilinx: Remove eemi ops for get_api_version")
Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240515112345.24673-1-jay.buddhabhatti@amd.com
Signed-off-by: Michal Simek <michal.simek@amd.com>

diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index fced6bedca43..411d33f2fb05 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -288,7 +288,9 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	u32 pm_api_version, pm_family_code, pm_sub_family_code, node_id;
 	struct mbox_client *client;
 
-	zynqmp_pm_get_api_version(&pm_api_version);
+	ret = zynqmp_pm_get_api_version(&pm_api_version);
+	if (ret)
+		return ret;
 
 	/* Check PM API version number */
 	if (pm_api_version < ZYNQMP_PM_VERSION)


