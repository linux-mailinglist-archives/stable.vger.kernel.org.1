Return-Path: <stable+bounces-65554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A57394A981
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 16:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98E53B21269
	for <lists+stable@lfdr.de>; Wed,  7 Aug 2024 14:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F122C69B;
	Wed,  7 Aug 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o2yANulK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4504621373
	for <stable@vger.kernel.org>; Wed,  7 Aug 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039853; cv=none; b=HSsCQX5XyF1C7Y4iq+4BWKO9JrgP874Da0TOs76wT31Kmd3HqeSxaUaJw2u+CbEDwQfz2PErgxjhwH5p542/sAkluEeM7qOACxIu3pjKDcy3Mh6D9GMMv1uA79qb8Y2iRhQQiiAsl1OwJ5cHzR8eFJwAS0S1BbaBqgUaM5KF/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039853; c=relaxed/simple;
	bh=cGuEkM6S2Zt+QRJSK2kXCm3LMKF2np5uYMpFziaRBMg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hbe+nG3/vcWhhjKfo+zU/+kmOgND29fctqazRwo5zMI2GqIlFz8wIyV5pDCuxAJ/xDovYhgGGCIBGRG3lZPrnTTuNzvXdWPJCr1NDXHfeQFTAYJDaC0WlUuNeJZe+6k3oyeP3uKnQ0ATtfPoj7mIKZ21Abt0o7Z8fzDj0qlplTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o2yANulK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3DDC32781;
	Wed,  7 Aug 2024 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723039852;
	bh=cGuEkM6S2Zt+QRJSK2kXCm3LMKF2np5uYMpFziaRBMg=;
	h=Subject:To:Cc:From:Date:From;
	b=o2yANulKvPlm+9mqJE0jBfaKwLywp41KkmhrJKd6F8zAq1KT12JY/Eh1FT7lpJXA6
	 GM007bwrkaYE0ABDaG/MgcM9rxih72eFQNVKQCFl6b/qkqeOQZGrlEnPf2cocp+xdx
	 eFg2QatzMFLiwQUuOPapuDbuGF0WAyA9i4ViOBp4=
Subject: FAILED: patch "[PATCH] wifi: ath12k: fix soft lockup on suspend" failed to apply to 6.6-stable tree
To: johan+linaro@kernel.org,johannes.berg@intel.com,quic_jjohnson@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 07 Aug 2024 16:10:49 +0200
Message-ID: <2024080749-nuzzle-pretended-b1a0@gregkh>
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
git cherry-pick -x a47f3320bb4ba6714abe8dddb36399367b491358
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024080749-nuzzle-pretended-b1a0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

a47f3320bb4b ("wifi: ath12k: fix soft lockup on suspend")
604308a34487 ("wifi: ath12k: add CE and ext IRQ flag to indicate irq_handler")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a47f3320bb4ba6714abe8dddb36399367b491358 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Tue, 9 Jul 2024 09:31:32 +0200
Subject: [PATCH] wifi: ath12k: fix soft lockup on suspend

The ext interrupts are enabled when the firmware has been started, but
this may never happen, for example, if the board configuration file is
missing.

When the system is later suspended, the driver unconditionally tries to
disable interrupts, which results in an irq disable imbalance and causes
the driver to spin indefinitely in napi_synchronize().

Make sure that the interrupts have been enabled before attempting to
disable them.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
Cc: stable@vger.kernel.org	# 6.3
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Link: https://patch.msgid.link/20240709073132.9168-1-johan+linaro@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

diff --git a/drivers/net/wireless/ath/ath12k/pci.c b/drivers/net/wireless/ath/ath12k/pci.c
index 876c029f58f6..9e0b9e329bda 100644
--- a/drivers/net/wireless/ath/ath12k/pci.c
+++ b/drivers/net/wireless/ath/ath12k/pci.c
@@ -473,7 +473,8 @@ static void __ath12k_pci_ext_irq_disable(struct ath12k_base *ab)
 {
 	int i;
 
-	clear_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags);
+	if (!test_and_clear_bit(ATH12K_FLAG_EXT_IRQ_ENABLED, &ab->dev_flags))
+		return;
 
 	for (i = 0; i < ATH12K_EXT_IRQ_GRP_NUM_MAX; i++) {
 		struct ath12k_ext_irq_grp *irq_grp = &ab->ext_irq_grp[i];


