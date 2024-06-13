Return-Path: <stable+bounces-50452-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E53090660D
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 10:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82A871C23CF5
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 08:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA87B13D257;
	Thu, 13 Jun 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ztheQba6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A98913D256
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265496; cv=none; b=CTH2ZWFs97LRALa4smjwjMmYQpPs/EhoyjNkjj9nEFkQu/Eps5MQ/snsjKtYPdGkpudeRsw/a6vZHoaooLfYZ1ARYFh7DV/orH7VDhPGXtcXtnqtnZlUFAAAeRa88Q6oQ984yslUhRFBSoFQCIqEw6K7OF+3lGQGQ96oUxOpuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265496; c=relaxed/simple;
	bh=jyvL9xOQWtGj3klgfzXFLv5aib9mbzEwhxiGJeEQPrY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y7gHeSuoVV9rHEXsr65ILb8p/MqWXKa3UuxFUpX7M6TxKAWS5E9h039rrqmde3NRxJlPAw6dhpS82JFecb99GL1ikENZHb81l5JxAcSr0MkawTMBsF8ClhnqEr07ysEYU3nayCiSXTpiGoHASAe02ZzVfNIcKZ4gXMPFY5S/sHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ztheQba6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102F8C2BBFC;
	Thu, 13 Jun 2024 07:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265496;
	bh=jyvL9xOQWtGj3klgfzXFLv5aib9mbzEwhxiGJeEQPrY=;
	h=Subject:To:Cc:From:Date:From;
	b=ztheQba6RLEPIQwEZ3Fh7SUrKBVwBiXvEn8JMOzRkbrWsz6qci9uYiTyTGz5Qha0q
	 u8B/1ZlmB/NkIFnQjt3hRKbXPF1/pThtr0iEfIHCyN68XBlqigECRPgIYd025pH2vn
	 2Fa8AEPw5a7GHQsy2b2mBf3bSF4eDkWp7CkeDCwQ=
Subject: FAILED: patch "[PATCH] wifi: ath10k: fix QCOM_RPROC_COMMON dependency" failed to apply to 6.1-stable tree
To: dmitry.baryshkov@linaro.org,quic_kvalo@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:58:13 +0200
Message-ID: <2024061313-wistful-dipping-5d5b@gregkh>
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
git cherry-pick -x 21ae74e1bf18331ae5e279bd96304b3630828009
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061313-wistful-dipping-5d5b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


