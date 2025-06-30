Return-Path: <stable+bounces-158907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E455EAED898
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BE6116554E
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426E024467D;
	Mon, 30 Jun 2025 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SXzgwRf9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02568239E60
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275447; cv=none; b=a7tTIYN3t40GkCqUDA/OlxOumTQmTiApPuyuXPGoZHgtxrPtABFF/2a39dDaqzaga5szgabAcKBMsOq8QDjNMndppHDZBwCSApdO25VhqM/cF1xI2xPB/CPjkkGOBz+jAb9AxlypOsIoxpQYsFYj/PCc3butsugFMrTbwEY9WNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275447; c=relaxed/simple;
	bh=ZBiPgmbugjaIm/ibiUsL3NiK6uwkZbsGGOVLdkajD+g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SIvZfF2ZYbDqILlxC1SmzhpGU8NKNgOcn/3as+qOZwx5ofnh9fW+EfdBPzguvPwPx9Rcp3A+j5O8nyK+S/FeUR5TsLMu5KD3jfimCTC3Q88KqY94JMdTx1S43Db3VaN87KIjNc0KLBgI3s1Dd8xvZzuZPNZp8f42KWI1PgIJ+00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SXzgwRf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BC8C4CEE3;
	Mon, 30 Jun 2025 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275446;
	bh=ZBiPgmbugjaIm/ibiUsL3NiK6uwkZbsGGOVLdkajD+g=;
	h=Subject:To:Cc:From:Date:From;
	b=SXzgwRf98BLcQzST37XUds4uxGUyV33vBM1HvErNPPE4aazso3sebWuOr95B17f6Q
	 pXNZ6u8RzXpZm9fvEFge8meVk9+4ZmVliCIxWFfxKBvwjpFEVJBHNBukbmFn/AlD/1
	 w9tOVVDH5XYwMZ4F30G/ezd5bR3hIlLvHcIfL11o=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Fix clk scaling to be conditional in reset" failed to apply to 6.6-stable tree
To: anvithdosapati@google.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:24:03 +0200
Message-ID: <2025063003-stalemate-sniff-e4ff@gregkh>
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
git cherry-pick -x 2e083cd802294693a5414e4557a183dd7e442e71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063003-stalemate-sniff-e4ff@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


