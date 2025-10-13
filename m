Return-Path: <stable+bounces-185095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7E4BD4A20
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F884281F2
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C5831A7E3;
	Mon, 13 Oct 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHhUimk/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE230E82B;
	Mon, 13 Oct 2025 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369319; cv=none; b=G+ymybXJOKOT17kkMgJc+tw0UCznyJLKFK1KUECHdy+rQDczbwRsrOFiI9mTrw/MM7BiM+fpPgnnrIerv/IEom05Aso1Np82Jik9FKa+cSlTRs1p9vIR/DWGQpZnNdWUDgKQicQkkj4N+KSe+mfXwn79nzxt0W2uO9W+Y4MucRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369319; c=relaxed/simple;
	bh=ieopgtLCYEyA71AR1Y28f66Opm60fSqf2LBmqKbaRME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6I6/+tsS9ynAQ15huZq1pvkUdp6pTUZ1w1pXw7nuhXgHogFO2RS4YpSC41oYyqBBLNySLhap6UWMkW44/LHGxEJ34Bsa9vc+8+lDvLgQRejkJCregQraOcjtJMLaMVR1TnmTsSdFqx4k9x5Wagfr4DvMTfnqJthvCg37P1wKuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hHhUimk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DDAC4CEE7;
	Mon, 13 Oct 2025 15:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760369318;
	bh=ieopgtLCYEyA71AR1Y28f66Opm60fSqf2LBmqKbaRME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHhUimk/M5JrQ4qirWKWyTCv75/PHAGpklC6pmw+iXqhuC7w/BtwJrbK1fwYQ+mrM
	 D6EURHZly+LJjx4ElxwPL1BNxEp2yNMbW30UXJShrp3Meo17Bjl+C1+XnMjDMXb37P
	 OajFc8Yo2s2ki8ShjaQkA3nmr1nKANiMrGp5gkR0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 197/563] thermal/drivers/qcom: Make LMH select QCOM_SCM
Date: Mon, 13 Oct 2025 16:40:58 +0200
Message-ID: <20251013144418.420384290@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144411.274874080@linuxfoundation.org>
References: <20251013144411.274874080@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit 57eda47bd14b0c2876f2db42e757c57b7a671965 ]

The QCOM_SCM symbol is not user-visible, so it makes little sense to
depend on it. Make LMH driver select QCOM_SCM as all other drivers do
and, as the dependecy is now correctly handled, enable || COMPILE_TEST
in order to include the driver into broader set of build tests.

Fixes: 9e5a4fb84230 ("thermal/drivers/qcom/lmh: make QCOM_LMH depends on QCOM_SCM")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250728-lmh-scm-v2-1-33bc58388ca5@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/qcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 2c7f3f9a26ebb..a6bb01082ec69 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -34,7 +34,8 @@ config QCOM_SPMI_TEMP_ALARM
 
 config QCOM_LMH
 	tristate "Qualcomm Limits Management Hardware"
-	depends on ARCH_QCOM && QCOM_SCM
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
 	help
 	  This enables initialization of Qualcomm limits management
 	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on
-- 
2.51.0




