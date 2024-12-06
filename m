Return-Path: <stable+bounces-99658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035729E72D1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C470416D8DF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895DB206F10;
	Fri,  6 Dec 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="slyxAfmG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E33207E02;
	Fri,  6 Dec 2024 15:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497921; cv=none; b=lUSPWQXCK5Ybog+22c0TsfevTNjCpgk2x16oOQFc8lBSb/JvrTdd8cN7tmNIX8m1kHW3mPEap7Y1OYtBBy4fCie248e1BHQbue3F7bKpt7vMK1y1omPm1zmnBe4uKt1Qe9o0IBohq7doD+5fhP/OMAY+EkBWdFugoGIQOFYHVxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497921; c=relaxed/simple;
	bh=RSxJBU8BRWH1dHAzc+h2Fn/vaT9ct24tvTknsBjMsc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbY9EDhU6ARUy2zUTV/gLi5wVHW/JMf3ZsOKwYIfXdVv6R+uX4P5TjLzlg3Kl58FL63zbOzDKpIv1p0mkp2FVtD+E84ueJaPkCppslkquqVuUcvsCEw3VORCGpoeaHDSIJyK9kzIE8wl6Wi1tdhNly/2r1KYf+eftHJWNCwfO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=slyxAfmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DA2C4CED1;
	Fri,  6 Dec 2024 15:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497921;
	bh=RSxJBU8BRWH1dHAzc+h2Fn/vaT9ct24tvTknsBjMsc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slyxAfmGSwyalAwwEBxS2ie81Xx3eUTFuJzTiuN3twFKJyprIbfMDywkp0xD466fi
	 W6oC457LZttoSAqd5FkIZzilkL2mwInMtAHwVirSncJlaqaBOECawEjIB4979OTclT
	 Y5ezqKSnq2f1ojZjM50GhvnyWjAMlEYQx8PdgPCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julien Panis <jpanis@baylibre.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 433/676] counter: ti-ecap-capture: Add check for clk_enable()
Date: Fri,  6 Dec 2024 15:34:12 +0100
Message-ID: <20241206143710.255925219@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit 1437d9f1c56fce9c24e566508bce1d218dd5497a ]

Add check for the return value of clk_enable() in order to catch the
potential exception.

Fixes: 4e2f42aa00b6 ("counter: ti-ecap-capture: capture driver support for ECAP")
Reviewed-by: Julien Panis <jpanis@baylibre.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Link: https://lore.kernel.org/r/20241104194059.47924-1-jiashengjiangcool@gmail.com
Signed-off-by: William Breathitt Gray <wbg@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/counter/ti-ecap-capture.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index fb1cb1774674a..b84e368a413f5 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -576,8 +576,13 @@ static int ecap_cnt_resume(struct device *dev)
 {
 	struct counter_device *counter_dev = dev_get_drvdata(dev);
 	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+	int ret;
 
-	clk_enable(ecap_dev->clk);
+	ret = clk_enable(ecap_dev->clk);
+	if (ret) {
+		dev_err(dev, "Cannot enable clock %d\n", ret);
+		return ret;
+	}
 
 	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
 
-- 
2.43.0




