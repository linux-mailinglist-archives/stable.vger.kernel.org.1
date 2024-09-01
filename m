Return-Path: <stable+bounces-71901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED4B967844
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BEB1F2122F
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F66183CAF;
	Sun,  1 Sep 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DaMUkbM9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7513D53B;
	Sun,  1 Sep 2024 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208191; cv=none; b=GmqgNLu4BISha3WL8PLyfFTJIy/Mws2ZEW5jMoIUNU1MY/z3JAFRQ0Cwbwr6uQyqf4zKtLJwWYSHTpBrhJ7zNXBmeoHaZvDlpLxb4MQ200hDrfTsPfh+5wtwbTW1Km1uzhjedy+mHVF8/+Nyy9OjoPfGfDsx+p3WvFu2z2JR7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208191; c=relaxed/simple;
	bh=NX77U0BjP3ts4oQRUYwVk84yVpRK+zeDy6FzTGPS5og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7lvZ0sbDkXP7Tc4/c1jqFZML2FseqGgArdDjccgw4PTAsQ1OHjMPMMeybb6CwgxOIVcuv6POT8E+oLDQhFi0kFVsB4LPo4hi6OdQJGeyeupvuuzZfTfm8sPbwIwHzDRmyapjz4SuV1sv6G+RlzJCX/OKRidvjN+LtV4Z5zamJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DaMUkbM9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0867C4CEC3;
	Sun,  1 Sep 2024 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208191;
	bh=NX77U0BjP3ts4oQRUYwVk84yVpRK+zeDy6FzTGPS5og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DaMUkbM9XxG+y9kHXJQKG1wrDeXWr7FqB/y1LTEFDyRBTUNzYLMBA1mdP/fM1Xdcf
	 a06anvL3G/8E63X05Lr1ORALjeZx8KihJU0FgfEavoqLe08MhjpF/Rz7eFipya7GgW
	 4PdrwnzTyj4PInawBQwPx9x1sP2LyEnGp5D/9Vu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.6 71/93] soc: qcom: pmic_glink: Actually communicate when remote goes down
Date: Sun,  1 Sep 2024 18:16:58 +0200
Message-ID: <20240901160810.410576426@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160807.346406833@linuxfoundation.org>
References: <20240901160807.346406833@linuxfoundation.org>
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

From: Bjorn Andersson <quic_bjorande@quicinc.com>

commit ad51126037a43c05f5f4af5eb262734e3e88ca59 upstream.

When the pmic_glink state is UP and we either receive a protection-
domain (PD) notification indicating that the PD is going down, or that
the whole remoteproc is going down, it's expected that the pmic_glink
client instances are notified that their function has gone DOWN.

This is not what the code does, which results in the client state either
not updating, or being wrong in many cases. So let's fix the conditions.

Fixes: 58ef4ece1e41 ("soc: qcom: pmic_glink: Introduce base PMIC GLINK driver")
Cc: stable@vger.kernel.org
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Amit Pundir <amit.pundir@linaro.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Link: https://lore.kernel.org/r/20240820-pmic-glink-v6-11-races-v3-3-eec53c750a04@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/qcom/pmic_glink.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soc/qcom/pmic_glink.c
+++ b/drivers/soc/qcom/pmic_glink.c
@@ -178,7 +178,7 @@ static void pmic_glink_state_notify_clie
 		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
 			new_state = SERVREG_SERVICE_STATE_UP;
 	} else {
-		if (pg->pdr_state == SERVREG_SERVICE_STATE_UP && pg->ept)
+		if (pg->pdr_state == SERVREG_SERVICE_STATE_DOWN || !pg->ept)
 			new_state = SERVREG_SERVICE_STATE_DOWN;
 	}
 



