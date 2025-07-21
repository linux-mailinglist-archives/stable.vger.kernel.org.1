Return-Path: <stable+bounces-163611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0213BB0C805
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 17:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB493189FA95
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 15:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F642E03FB;
	Mon, 21 Jul 2025 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyDuz0pc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259212E03F1
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753112955; cv=none; b=nlp9lfr0JouY/AT6iB2+RiVkPldoZeIJp8uVStPXcnEqQ9fhHf5CKCQ8iR0glD7biurQURK0gfBcegZ01qOuVwn2UFRRMye3kTbRSffh13qwkt3ke6HIQTvOV1LFVGd3XtbGQQrmA6WPKvQ+lzbrYIPk2Mc5aSpWPXj7/L91XwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753112955; c=relaxed/simple;
	bh=zH+Wbku+o5bKTkJjVN6pZrTe+T5eCu7LSg5feDrxtwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BeYC0E44zCy+/SX2hFV/+Ejw+jVPai5uSsZiaTktye7ntuCN7QVA5bXFEi051qe0IHi77xeCZYefOQ0TDYYsaxwrhuAM7U57f+C0i957Kvoxntz5vcubg8/Vq7TxgNyvGuH0cdUGc6fsrJtpdwkmWUj8euOSaADRyPLcd1K2Ua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyDuz0pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FEC9C4CEF7;
	Mon, 21 Jul 2025 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753112954;
	bh=zH+Wbku+o5bKTkJjVN6pZrTe+T5eCu7LSg5feDrxtwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyDuz0pcDYovGK3WSXF4PakJdcFFYWxlCD+FGKAJFbGuvxzsaui7I5EioxZxjTT9+
	 TBW26MVWYN+P5976I0RYUsg5RMIdWAPEv2lUXi5NYywZ/HYV9gfJ/vliSifg4HkhJW
	 UaxIIXTsO6qdy7apoC2WTeHCJSJoW8VMTyF1+OqwT3Z+vqHAv4jMFyRqZFfaQy8Z00
	 5QxaQa3+D+V/UEZdTwvv6HcwT3pEakI6dmxrkPu/9cc9JqyjQ8Gl+gc9KQrwbInl0I
	 O3DcR/Zf2RmPiuPyHeOR2fx9ywhk0TXv9S/1VWHcAK5AdP+1q0JkIZHyCQbiaMllZ9
	 vldJd/6iSKdFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: dwc3: qcom: Don't leave BCR asserted
Date: Mon, 21 Jul 2025 11:49:10 -0400
Message-Id: <20250721154910.855391-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072116-vaporizer-frayed-e632@gregkh>
References: <2025072116-vaporizer-frayed-e632@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

[ Upstream commit ef8abc0ba49ce717e6bc4124e88e59982671f3b5 ]

Leaving the USB BCR asserted prevents the associated GDSC to turn on. This
blocks any subsequent attempts of probing the device, e.g. after a probe
deferral, with the following showing in the log:

[    1.332226] usb30_prim_gdsc status stuck at 'off'

Leave the BCR deasserted when exiting the driver to avoid this issue.

Cc: stable <stable@kernel.org>
Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250709132900.3408752-1-krishna.kurapati@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted to individual clock management API instead of bulk clock operations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-qcom.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 93747ab2cf5b8..cdf114da31d8f 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -856,13 +856,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	ret = reset_control_deassert(qcom->resets);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
-		goto reset_assert;
+		return ret;
 	}
 
 	ret = dwc3_qcom_clk_init(qcom, of_clk_get_parent_count(np));
 	if (ret) {
 		dev_err(dev, "failed to get clocks\n");
-		goto reset_assert;
+		return ret;
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -966,8 +966,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 		clk_disable_unprepare(qcom->clks[i]);
 		clk_put(qcom->clks[i]);
 	}
-reset_assert:
-	reset_control_assert(qcom->resets);
 
 	return ret;
 }
@@ -997,7 +995,6 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	qcom->num_clocks = 0;
 
 	dwc3_qcom_interconnect_exit(qcom);
-	reset_control_assert(qcom->resets);
 
 	pm_runtime_allow(dev);
 	pm_runtime_disable(dev);
-- 
2.39.5


