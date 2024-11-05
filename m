Return-Path: <stable+bounces-89892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAAA9BD2AD
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 17:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34BFC2830F9
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2D51D3633;
	Tue,  5 Nov 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J/LeDZ7r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A9166F1A
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730824973; cv=none; b=APWxVxgZEs0QcNTn3umdPHFS74jPEn6820qsrzBZeC4Gi3eMAC/hSk/ADw/IdsaK36J0x3F0GIqdPRkAR98C+wpY72y+tQJHUQvg0q2vw6OkCTgOnwLKRDwRK7QlXrI97R32BrH06WPqM5nOTAcuiTbzwqHaDNkMCxhg6Tj9OOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730824973; c=relaxed/simple;
	bh=n+3ICMoLst0c6dt8CNQycI79ckD+T0X6dKGnosLiJUk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KYCwqC2ks9QE7v/tlQ2q4j81IWbM1hb99Jg5QJ4txCEFZlD9HCX9JYtDASCW5yYa1FIQWksSL9jBFJOE3fIx5kfE+Kpq6XDP304KC04IABu94Xt0t7T3SyL2O/NxqVmOLI/uISaHAfSS0LZJyWJDVzc8Rw8Mmjh/Mmq2j89qXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J/LeDZ7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00B8C4CECF;
	Tue,  5 Nov 2024 16:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730824973;
	bh=n+3ICMoLst0c6dt8CNQycI79ckD+T0X6dKGnosLiJUk=;
	h=Subject:To:Cc:From:Date:From;
	b=J/LeDZ7rSDluw5Qc+tMgTZlPPOuD0HBSsoXce0PrOqlQm3odgMFbtyBeFXjPMYmV2
	 0XaJuPE9JFPLY6rQPzvUwrAZcf8PJTy1Igz7+j6ZYMw2qYk3pVzbZN/qZXwGMlpy1s
	 7d2/VlY+Dd7ayuBp1XNUOy/b9QeiXvTROs9raPro=
Subject: FAILED: patch "[PATCH] firmware: qcom: scm: suppress download mode error" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,andersson@kernel.org,quic_mojha@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 05 Nov 2024 17:42:27 +0100
Message-ID: <2024110527-maternal-devious-a112@gregkh>
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
git cherry-pick -x d67907154808745b0fae5874edc7b0f78d33991c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024110527-maternal-devious-a112@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d67907154808745b0fae5874edc7b0f78d33991c Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 2 Oct 2024 12:01:21 +0200
Subject: [PATCH] firmware: qcom: scm: suppress download mode error

Stop spamming the logs with errors about missing mechanism for setting
the so called download (or dump) mode for users that have not requested
that feature to be enabled in the first place.

This avoids the follow error being logged on boot as well as on
shutdown when the feature it not available and download mode has not
been enabled on the kernel command line:

	qcom_scm firmware:scm: No available mechanism for setting download mode

Fixes: 79cb2cb8d89b ("firmware: qcom: scm: Disable SDI and write no dump to dump mode")
Fixes: 781d32d1c970 ("firmware: qcom_scm: Clear download bit during reboot")
Cc: Mukesh Ojha <quic_mojha@quicinc.com>
Cc: stable@vger.kernel.org	# 6.4
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Link: https://lore.kernel.org/r/20241002100122.18809-2-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 10986cb11ec0..e2ac595902ed 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -545,7 +545,7 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
 	} else if (__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_BOOT,
 						QCOM_SCM_BOOT_SET_DLOAD_MODE)) {
 		ret = __qcom_scm_set_dload_mode(__scm->dev, !!dload_mode);
-	} else {
+	} else if (dload_mode) {
 		dev_err(__scm->dev,
 			"No available mechanism for setting download mode\n");
 	}


