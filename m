Return-Path: <stable+bounces-130743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F338AA80617
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B134A5BE1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213F126A1C3;
	Tue,  8 Apr 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aS9K5965"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191426A1BE;
	Tue,  8 Apr 2025 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114530; cv=none; b=JegEaGgN3pa37FxW5lHpEnk7lQKk3I1VzPZxd0Os7n4YpOcadBi94GY+09VYIyvSWC0YDA+wph8938XWA2RrbPaCEUFImN071MSuv7ArL6CthEnEs8qwaeTBhnqwDIJ7pHciGdNx96kXmpiUDpjyjyEcAeCfTt0rB/9NKL6v3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114530; c=relaxed/simple;
	bh=vj6BHWdqsdiLWC++i56gowSmGq8JXLOPRHPEd4vUlfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmqiNwqnW8aOXqfEvjT7NX69aTCiW48ej13KzRfvI4mGsNeHrAiMaJ1aAwUwAm8NHfNoiHoHFl1gm40e6LFcFsNcXOeyb4sMJ96iMI5CfGgT6mpdjRd8PR1a9fmeOOkDTPARgXyjkFLe6DnQSfVxNtvvy3SKdRaYhS4TCqtCTpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aS9K5965; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313ABC4CEE5;
	Tue,  8 Apr 2025 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114530;
	bh=vj6BHWdqsdiLWC++i56gowSmGq8JXLOPRHPEd4vUlfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aS9K59657UZVj0jan6Vhl+MLSFP/tKpUTZ08HT55A7EHQxM3nPLN0sRcmRFTjZabl
	 zmfm1fG5aGSaM+7ABmY7KAUxJqpLQvzdYhiLQ3U+85CR8m8f59IoRlPwyeEztHihl9
	 KhTfMZq9wkrbzPOYDvE2SSBeQPbgbkvJphKQzsPs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca.weiss@fairphone.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 142/499] remoteproc: qcom: pas: add minidump_id to SC7280 WPSS
Date: Tue,  8 Apr 2025 12:45:54 +0200
Message-ID: <20250408104854.729950686@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit d2909538bff0189d4d038f4e903c70be5f5c2bfc ]

Add the minidump ID to the wpss resources, based on msm-5.4 devicetree.

Fixes: 300ed425dfa9 ("remoteproc: qcom_q6v5_pas: Add SC7280 ADSP, CDSP & WPSS")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Link: https://lore.kernel.org/r/20250314-sc7280-wpss-minidump-v1-1-d869d53fd432@fairphone.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 78484ed9b6c85..9f2d9b4be2790 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -1348,6 +1348,7 @@ static const struct adsp_data sc7280_wpss_resource = {
 	.crash_reason_smem = 626,
 	.firmware_name = "wpss.mdt",
 	.pas_id = 6,
+	.minidump_id = 4,
 	.auto_boot = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
-- 
2.39.5




