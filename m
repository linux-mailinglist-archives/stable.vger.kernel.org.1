Return-Path: <stable+bounces-158909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FA8AED89D
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C137AA03B
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952FB2459CF;
	Mon, 30 Jun 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I6HEZzan"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585C24503C
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275459; cv=none; b=lLBFjlrvv3e3d9k/Qi3qaQvwBZzHpJim1B2iP77c5kD8HLE9P9yBguLYl+ZMoSiCAregzHvgG2EJM3xYN70OiQJvrwrHqziDTR2bV61wuXieCavA3btce8ofqWGj8LRch08H0Cb39TQM2A/xYSSNMxEXvlCKgKEg2AS/A6tdGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275459; c=relaxed/simple;
	bh=lA3VI5aMaCEgxLFcsdrEsPZiMKQO8azOWxsaLPD6vVs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UCYV5B0zqmNPWonXSnXkgB5WycmAALQksNN231xjYe4mmuJPXV0g+U/hinGgVGpn3FVzSooUnb9Vzkd6C/Kfu2v8+H/PwisEX/RJsz1OQF8Vv5C/n9WOo8iVmJhMbBkhCAusHlfwNDiHF9ATPytV6RY6sortJmr7ZyLBnoTpS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I6HEZzan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65E1DC4CEEF;
	Mon, 30 Jun 2025 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275458;
	bh=lA3VI5aMaCEgxLFcsdrEsPZiMKQO8azOWxsaLPD6vVs=;
	h=Subject:To:Cc:From:Date:From;
	b=I6HEZzanbSz24COtkJTI+ftdoC/Fp5wkYPUDb5TMBdUi6qdyWf+DHW5ueDLA2Lzno
	 N7/hDcQrTQEOkOyUshE6LH+E1Jn91MKcL7loPJOHQKGBugygnetMyXXJ/hR9GBxuMc
	 qRNfZP1oJV2dJM4kPqSkE+9ZVr6RmlHzrPtReu8g=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Fix clk scaling to be conditional in reset" failed to apply to 5.10-stable tree
To: anvithdosapati@google.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:24:04 +0200
Message-ID: <2025063004-observer-ruckus-6111@gregkh>
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
git cherry-pick -x 2e083cd802294693a5414e4557a183dd7e442e71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063004-observer-ruckus-6111@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2e083cd802294693a5414e4557a183dd7e442e71 Mon Sep 17 00:00:00 2001
From: anvithdosapati <anvithdosapati@google.com>
Date: Mon, 16 Jun 2025 08:57:34 +0000
Subject: [PATCH] scsi: ufs: core: Fix clk scaling to be conditional in reset
 and restore

In ufshcd_host_reset_and_restore(), scale up clocks only when clock
scaling is supported. Without this change CPU latency is voted for 0
(ufshcd_pm_qos_update) during resume unconditionally.

Signed-off-by: anvithdosapati <anvithdosapati@google.com>
Link: https://lore.kernel.org/r/20250616085734.2133581-1-anvithdosapati@google.com
Fixes: a3cd5ec55f6c ("scsi: ufs: add load based scaling of UFS gear")
Cc: stable@vger.kernel.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index f62d89c8e580..50adfb8b335b 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7807,7 +7807,8 @@ static int ufshcd_host_reset_and_restore(struct ufs_hba *hba)
 	hba->silence_err_logs = false;
 
 	/* scale up clocks to max frequency before full reinitialization */
-	ufshcd_scale_clks(hba, ULONG_MAX, true);
+	if (ufshcd_is_clkscaling_supported(hba))
+		ufshcd_scale_clks(hba, ULONG_MAX, true);
 
 	err = ufshcd_hba_enable(hba);
 


