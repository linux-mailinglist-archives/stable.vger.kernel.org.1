Return-Path: <stable+bounces-50453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D8790660E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11321C23DAF
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2213CFB2;
	Thu, 13 Jun 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eI0YKAZ4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEDC13D256
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265505; cv=none; b=agGqOrcsep6wC75tGB78e8qHO6Q8wlFU6g4FS8u3cA/F/G8F5uEsVbngwx473Ei17rWKY9h0wPJlq9w4LAIRcAVccrP3nzYYVcC0X5SW/DbIYRyej4s+o5858BFtx6RFNwICQp8Vxw/afiGo72F0leap1Hpa3OEJqvCu0cXRFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265505; c=relaxed/simple;
	bh=ZmVpdt8P+BYYPmJuu/jUM3aS2lJ06oR1Z0uOex8tas4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FnRgV64Da5qmBxwgaV0fONUM3nhgMTsDCxVY0dkiiVPW1un2C/2yqD/0mlHqFMGIt0eiA20aqhw7u5NElpkpzttXkIRe/PSIOOkLzQSNV3hvERkuF0QppJWiPlH+XfFSrbaVSHa4tsQh9cKOGqjnQ0basqWMjt4ycXso7FVqQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eI0YKAZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D764FC4AF1C;
	Thu, 13 Jun 2024 07:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265505;
	bh=ZmVpdt8P+BYYPmJuu/jUM3aS2lJ06oR1Z0uOex8tas4=;
	h=Subject:To:Cc:From:Date:From;
	b=eI0YKAZ4Cy8hVw5hIRiRKHyEulD8DIugJTZ3POC6ozDyS2Z8U/MHk+OY+h/rns6mv
	 lwPlQYpeNevaL7+MUiSXhpK+JKjuwF/NDhtPjSJyYfuLUaOnyjZCntBPhH9tKTc05L
	 t4W1ow5oJfVQ6zID4FnELajVquJpksxW27nWDdhY=
Subject: FAILED: patch "[PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency" failed to apply to 5.15-stable tree
To: dmitry.baryshkov@linaro.org,quic_kvalo@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:58:14 +0200
Message-ID: <2024061314-platypus-impaired-f82d@gregkh>
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
git cherry-pick -x 21ae74e1bf18331ae5e279bd96304b3630828009
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061314-platypus-impaired-f82d@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

21ae74e1bf18 ("wifi: ath10k: fix QCOM_RPROC_COMMON dependency")
d03407183d97 ("wifi: ath10k: fix QCOM_SMEM dependency")
4d79f6f34bbb ("wifi: ath10k: Store WLAN firmware version in SMEM image table")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 21ae74e1bf18331ae5e279bd96304b3630828009 Mon Sep 17 00:00:00 2001
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 17 May 2024 10:00:28 +0300
Subject: [PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency

If ath10k_snoc is built-in, while Qualcomm remoteprocs are built as
modules, compilation fails with:

/usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_init':
drivers/net/wireless/ath/ath10k/snoc.c:1534: undefined reference to `qcom_register_ssr_notifier'
/usr/bin/aarch64-linux-gnu-ld: drivers/net/wireless/ath/ath10k/snoc.o: in function `ath10k_modem_deinit':
drivers/net/wireless/ath/ath10k/snoc.c:1551: undefined reference to `qcom_unregister_ssr_notifier'

Add corresponding dependency to ATH10K_SNOC Kconfig entry so that it's
built as module if QCOM_RPROC_COMMON is built as module too.

Fixes: 747ff7d3d742 ("ath10k: Don't always treat modem stop events as crashes")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240511-ath10k-snoc-dep-v1-1-9666e3af5c27@linaro.org

diff --git a/drivers/net/wireless/ath/ath10k/Kconfig b/drivers/net/wireless/ath/ath10k/Kconfig
index e6ea884cafc1..4f385f4a8cef 100644
--- a/drivers/net/wireless/ath/ath10k/Kconfig
+++ b/drivers/net/wireless/ath/ath10k/Kconfig
@@ -45,6 +45,7 @@ config ATH10K_SNOC
 	depends on ATH10K
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on QCOM_SMEM
+	depends on QCOM_RPROC_COMMON || QCOM_RPROC_COMMON=n
 	select QCOM_SCM
 	select QCOM_QMI_HELPERS
 	help


