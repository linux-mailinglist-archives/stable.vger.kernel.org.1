Return-Path: <stable+bounces-158910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D71AED89F
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 11:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8242E7AA088
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C477C24469F;
	Mon, 30 Jun 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NutF8GWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84858244689
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751275467; cv=none; b=hyCMv782zX97Aht3Xp4o1fzsIQUxHjyV9WKpiZCTT576JaY8oHVZvq1uMvyOcxLnMYbeMM0REhVyHPGgbQ7hhyaZ1hDOL8hGDbqOPE5KH1ZQswYprgVqYrWRskWQHj8a1MT6cRgpynAE9MRrabUXjt/alIG1eNRWCJU9/wbp7yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751275467; c=relaxed/simple;
	bh=WFU0OxiF6HhpgwPYCUufpcYurqWmlXTtD+bvQrgLbMA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RrncSnFhBEtRzspzrjaYwoCnG2GpLxd1ah6cRA/RjPmjw6mMb9PBckjVqsd6LOEzlL6UP08cj1Md9D7NcLLBnw027Ivng4wkLmngG+8d2GGVX2hjOCdSi98eqPuZrn0tIXWSGyEiNhcZt95AIWzg+0hrixVLKeTDR2Y2Uiv5Lhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NutF8GWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6FEC4CEE3;
	Mon, 30 Jun 2025 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751275467;
	bh=WFU0OxiF6HhpgwPYCUufpcYurqWmlXTtD+bvQrgLbMA=;
	h=Subject:To:Cc:From:Date:From;
	b=NutF8GWVqRg+5pGpsNas7DyyUXPM6hfr6VS+oCLo/2Iv/YCIz6yx5IPvu4WjBRRIZ
	 0sfjewq272Qsk6ih5ZS16MkTXGhVyOh9/wm1B4EWLBi+5+R1SdtyJ29tDPnXfxy/+z
	 JnqIDycpgOGecTJIoa7KpqtFXVq92CPXuqr52j/k=
Subject: FAILED: patch "[PATCH] scsi: ufs: core: Fix clk scaling to be conditional in reset" failed to apply to 6.1-stable tree
To: anvithdosapati@google.com,bvanassche@acm.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 30 Jun 2025 11:24:04 +0200
Message-ID: <2025063003-boring-overdraft-ac97@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2e083cd802294693a5414e4557a183dd7e442e71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025063003-boring-overdraft-ac97@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


