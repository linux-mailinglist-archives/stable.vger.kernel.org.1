Return-Path: <stable+bounces-67028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D460B94F396
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB881F21AC7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBAF187563;
	Mon, 12 Aug 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ckNIHTjD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C2183CA6;
	Mon, 12 Aug 2024 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723479562; cv=none; b=EBPVrJSMUTs+ukSA0stZTEABwuHq+WHS90krOFk28DFLPOejq8lFn6WfBifNeW7A5WkYw63NPFA8tGPIF4iTt86O0tvIKzltzqQ+m6sjL26A6UBvfGrGyTtob3ReGet7/5YW3mbhDsIx1nCJZHqt5vMefi13SSroVVE26VEkI+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723479562; c=relaxed/simple;
	bh=xb93y6jILMo7QqTeg37fCnt+/qmcfi8/totlVNzC0vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niQzHJDS9yVZTLNlJnuEr9vbrvOdyheQ9Ju3FZF/pJxs6PlByg4y7QpA4+oxxHUuNEruLAH6fMt3jlYy2d3FLHpW1PMoCUZVlCgMZXZNoav/cRFDqw9a8NInJPnnprAEwUkRBgxm7kPHEcuxCCv3gQUJ2Tjk+gz2nOFHOMAIEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ckNIHTjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED945C32782;
	Mon, 12 Aug 2024 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723479562;
	bh=xb93y6jILMo7QqTeg37fCnt+/qmcfi8/totlVNzC0vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckNIHTjD0RCyeEOoo6V1U8kUkj9nIfWopI4uxR9vtZlozPoNt9EQ7dwjEwbehTZaJ
	 MyQCt8dETohIHtqx/5zsBOY5IGuswop4w+/PAhKn2OHPm2UxQ06vbhgfvV6HsWqMO4
	 BBAGI6jvkcVfpkTSqP+wpC2Np3GAOifJh7uhp2GU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anjana Hari <quic_ahari@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 6.6 124/189] scsi: ufs: core: Do not set link to OFF state while waking up from hibernation
Date: Mon, 12 Aug 2024 18:03:00 +0200
Message-ID: <20240812160136.918656124@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160132.135168257@linuxfoundation.org>
References: <20240812160132.135168257@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

commit ac6efb12ca64156f4a94e964acdb96ee7d59630d upstream.

UFS link is just put into hibern8 state during the 'freeze' process of the
hibernation. Afterwards, the system may get powered down. But that doesn't
matter during wakeup. Because during wakeup from hibernation, UFS link is
again put into hibern8 state by the restore kernel and then the control is
handed over to the to image kernel.

So in both the places, UFS link is never turned OFF. But
ufshcd_system_restore() just assumes that the link will be in OFF state and
sets the link state accordingly. And this breaks hibernation wakeup:

[ 2445.371335] phy phy-1d87000.phy.3: phy_power_on was called before phy_init
[ 2445.427883] ufshcd-qcom 1d84000.ufshc: Controller enable failed
[ 2445.427890] ufshcd-qcom 1d84000.ufshc: ufshcd_host_reset_and_restore: Host init failed -5
[ 2445.427906] ufs_device_wlun 0:0:0:49488: ufshcd_wl_resume failed: -5
[ 2445.427918] ufs_device_wlun 0:0:0:49488: PM: dpm_run_callback(): scsi_bus_restore returns -5
[ 2445.427973] ufs_device_wlun 0:0:0:49488: PM: failed to restore async: error -5

So fix the issue by removing the code that sets the link to OFF state.

Cc: Anjana Hari <quic_ahari@quicinc.com>
Cc: stable@vger.kernel.org # 6.3
Fixes: 88441a8d355d ("scsi: ufs: core: Add hibernation callbacks")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20240718170659.201647-1-manivannan.sadhasivam@linaro.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ufs/core/ufshcd.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -10157,9 +10157,6 @@ int ufshcd_system_restore(struct device
 	 */
 	ufshcd_readl(hba, REG_UTP_TASK_REQ_LIST_BASE_H);
 
-	/* Resuming from hibernate, assume that link was OFF */
-	ufshcd_set_link_off(hba);
-
 	return 0;
 
 }



