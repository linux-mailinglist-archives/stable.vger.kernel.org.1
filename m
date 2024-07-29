Return-Path: <stable+bounces-62473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72C993F338
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEE83B208DA
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AEA144D2B;
	Mon, 29 Jul 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aBORLnwI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14452144D1C
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250314; cv=none; b=eFS7JJ9UHwauT7pbYWyFKK8JuWg9tv/4i8xvm1wxP2GRCkn7HftdtjXpqj9DEU2+OcRYS5N430fULtpbV0rhWAglACI3RaI+moYmDCbKKt92lTi1S3HBHB5AafCA95yKdGIl3yJGagu1FxonwYJzzu1VAQg1i/AkhJ5oOWIOJP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250314; c=relaxed/simple;
	bh=/rfdnmCBlErAd+P5rZFApDAykpecH9IRSmOcX9FUvgo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HW28BDhl5cY8N+rJJ1rnCxYb6DisOptAbXc9DCcM7jy+IndpnNnhQcV2wWekFpThqquUoIC8Lwj/9wS7MMZeVQJKhDzh3Z4k6jPppc5tCLQqRrz30xA6jCc3Al+ePTuyeHunjOQdBBdf9iPP0rS+oIZOe1Ehz1zjSWw2WmCMJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aBORLnwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4E7C4AF0C;
	Mon, 29 Jul 2024 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722250313;
	bh=/rfdnmCBlErAd+P5rZFApDAykpecH9IRSmOcX9FUvgo=;
	h=Subject:To:Cc:From:Date:From;
	b=aBORLnwI6+9sb6HgyygyKzPlebfFyJ1btniwbbleSxG6p9R4gcabSLayoMqaWuuOW
	 nNY65be2ReOUS2fRCKL6cSY00ww+MUw46SaqnsnRqPHjrT4Alt0va9hbLkkfUK1hg0
	 RgnkneybD9a7HCOZ2rX+VlkE/NTNkUX/NXZPbkxs=
Subject: FAILED: patch "[PATCH] drivers: soc: xilinx: check return status of" failed to apply to 5.10-stable tree
To: jay.buddhabhatti@amd.com,michal.simek@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:51:42 +0200
Message-ID: <2024072942-curse-primate-40bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9b003e14801cf85a8cebeddc87bc9fc77100fdce
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072942-curse-primate-40bf@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


