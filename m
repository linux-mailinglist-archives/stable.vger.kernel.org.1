Return-Path: <stable+bounces-43627-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F9E8C419A
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 15:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EA91C22F71
	for <lists+stable@lfdr.de>; Mon, 13 May 2024 13:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D9A1514E2;
	Mon, 13 May 2024 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oceXTWto"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695F559164
	for <stable@vger.kernel.org>; Mon, 13 May 2024 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606185; cv=none; b=BCAa2JprUmBaVo1WdL8yb7AvQ8omwJrOHNMzLdrYWRHVl0WNyNZrvaXodUnnMkZtHTZwTEfbZwtgDrjbQnxGoTv6tYh3NBAgsqKHP+RrlQu4eEU0IE9H0F7avdZp7S8c7ETX9m96f7l0FTHZXu63oH/YIGaHwQ1bwvTmPFpav5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606185; c=relaxed/simple;
	bh=52Da0mYamH6WSPjBQhjfP+G5tKjYSYzZmei8dk/soeg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=shlr6DSwqhGtluP4BwqStMLeTSn+vqYgp0X1Kqwyr3SLMoYV+e9nTFkJ/6oT7mJHlxTu9a1dWRmcYaueIlM5w2eFYrfyAo41SrIyKo6mUmjOyALYy93iCcPLxfN9YtQzzD6ACi5Ykt4U5SJbenwwTNQaNaeoHhVvpE+FfPR6Dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oceXTWto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649CAC113CC;
	Mon, 13 May 2024 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715606185;
	bh=52Da0mYamH6WSPjBQhjfP+G5tKjYSYzZmei8dk/soeg=;
	h=Subject:To:Cc:From:Date:From;
	b=oceXTWtoazpY8AyFhSoCIl/1vsXT0Ug3ooS8jz6BYkMTrZIajZURiZ8P+DX+H376+
	 0fuNiZ92o82wBaEGRKE0ey8TpnEJDl+N7uoO2cUVK/vOuEx2mF1oEw5fJH1/Qz5AY4
	 9BDjTMfFhcPbYQSkohNEFcShHfVwTxt00g1u7F/o=
Subject: FAILED: patch "[PATCH] usb: typec: qcom-pmic: fix use-after-free on late probe" failed to apply to 6.8-stable tree
To: johan+linaro@kernel.org,bryan.odonoghue@linaro.org,dmitry.baryshkov@linaro.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 May 2024 15:16:20 +0200
Message-ID: <2024051320-bleep-cure-25ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.8-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.8.y
git checkout FETCH_HEAD
git cherry-pick -x d80eee97cb4e90768a81c856ac71d721996d86b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051320-bleep-cure-25ea@gregkh' --subject-prefix 'PATCH 6.8.y' HEAD^..

Possible dependencies:

d80eee97cb4e ("usb: typec: qcom-pmic: fix use-after-free on late probe errors")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d80eee97cb4e90768a81c856ac71d721996d86b7 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Thu, 18 Apr 2024 16:57:29 +0200
Subject: [PATCH] usb: typec: qcom-pmic: fix use-after-free on late probe
 errors

Make sure to stop and deregister the port in case of late probe errors
to avoid use-after-free issues when the underlying memory is released by
devres.

Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
Cc: stable@vger.kernel.org	# 6.5
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20240418145730.4605-2-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index e48412cdcb0f..d3958c061a97 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -104,14 +104,18 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 
 	ret = tcpm->port_start(tcpm, tcpm->tcpm_port);
 	if (ret)
-		goto fwnode_remove;
+		goto port_unregister;
 
 	ret = tcpm->pdphy_start(tcpm, tcpm->tcpm_port);
 	if (ret)
-		goto fwnode_remove;
+		goto port_stop;
 
 	return 0;
 
+port_stop:
+	tcpm->port_stop(tcpm);
+port_unregister:
+	tcpm_unregister_port(tcpm->tcpm_port);
 fwnode_remove:
 	fwnode_remove_software_node(tcpm->tcpc.fwnode);
 


