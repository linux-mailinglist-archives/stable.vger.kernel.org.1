Return-Path: <stable+bounces-32983-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 813EC88E89A
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3517E1F2402D
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81B59B71;
	Wed, 27 Mar 2024 15:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L+SjZv9W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563571879
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552162; cv=none; b=C/L3BYrxzjkLMQQnlqR8XwhdNiypAH0viENVzWbAVPzD3mHQH49G/Rbnjt9P9EAy4bikNw/CRyyU4HOpNvl13RB/OEBF1y4TyiQPvAujDj+RlwHDprZEnimTLfMxvOVEpomniyJVKHXR98YVsvnNWW9NYE1gg1bGWh045xd77J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552162; c=relaxed/simple;
	bh=Fzr+M+qAQ67V5LcWUpSfIXfXVyGF94qelV4OTf8/Tu8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZmoJ1lmXJJeq1L3YfqwDTR0MnpraK7enzcxD4MXpDJDosYRqaeQXt0iPMBi7a4lcYbqfpnVTaDcO/mLc+geSmugUoRhDCeliwgtm2Hkbp1zVuMxrQx0bd30wNba0Kkt2izNjiDWtiAAzPKNhjD23/JxGuRLusd5tsXQl0G2NucY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L+SjZv9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64795C433C7;
	Wed, 27 Mar 2024 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711552161;
	bh=Fzr+M+qAQ67V5LcWUpSfIXfXVyGF94qelV4OTf8/Tu8=;
	h=Subject:To:Cc:From:Date:From;
	b=L+SjZv9W0no98/rUpHx0VNp3uwVgnypw/vYoKOnbHMp/yczqgjz0ebresolZ8Qbvy
	 zHXTxHAPyZq3affOzwribdGulEYyouxLuTYBnCSUoxy0+EgqwLUte5yp3y0SvaoOi/
	 dTVcsbBImEM/MnKUrP4k2Tz7ZtIuG5qFqONDmd8M=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: fix UCSI on SM8550 & SM8650 Qualcomm" failed to apply to 6.6-stable tree
To: neil.armstrong@linaro.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 27 Mar 2024 16:09:08 +0100
Message-ID: <2024032707-among-rerun-a107@gregkh>
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
git cherry-pick -x 4a30dcac38c2b34f5b4f358630774bc2c2c104b0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024032707-among-rerun-a107@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

4a30dcac38c2 ("usb: typec: ucsi: fix UCSI on SM8550 & SM8650 Qualcomm devices")
1d103d6af241 ("usb: typec: ucsi: fix UCSI on buggy Qualcomm devices")
c6165ed2f425 ("usb: ucsi: glink: use the connector orientation GPIO to provide switch events")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4a30dcac38c2b34f5b4f358630774bc2c2c104b0 Mon Sep 17 00:00:00 2001
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 23 Feb 2024 10:40:40 +0100
Subject: [PATCH] usb: typec: ucsi: fix UCSI on SM8550 & SM8650 Qualcomm
 devices

On SM8550 and SM8650 Qualcomm platforms a call to UCSI_GET_PDOS for
non-PD partners will cause a firmware crash with no
easy way to recover from it.

Add UCSI_NO_PARTNER_PDOS quirk for those platform until we find
a way to properly handle the crash.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240223-topic-sm8550-upstream-ucsi-no-pdos-v1-1-8900ad510944@linaro.org
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index 53a7ede8556d..faccc942b381 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -301,6 +301,7 @@ static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
 	{ .compatible = "qcom,sm8350-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
+	{ .compatible = "qcom,sm8550-pmic-glink", .data = (void *)UCSI_NO_PARTNER_PDOS, },
 	{}
 };
 


