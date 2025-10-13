Return-Path: <stable+bounces-184454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF20BD442A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9544041F4
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B51308F15;
	Mon, 13 Oct 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugT4Ok7t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1C41494C2;
	Mon, 13 Oct 2025 14:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367483; cv=none; b=hOonGbiyItkbrVFHOEzUxePUDyExrRG1qz0Q5QGPvUTdBAyqhFn8/dQv2bmyjPvZqwjiTFHl5qPNouzbNduQilp6VuKr4Y+NULvy4z6Dka0XvNlZuShVUbulZ3QB5mG1qDKYWmCnRu8c1EI5cJikBPQTCimcndOKc/j6EvAd6Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367483; c=relaxed/simple;
	bh=g/OBgPtL4cfJmd78Y5/IFGnkf94C+MOLzLszuuacJG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRgV1P1OESk6AfQ8yg3yxHregfyoWrwqNfpug7NDoN8gluwJQk63t8loeyOYQuR3+gbbtk1Xw1iwxKBHDoXg2ul8Olt838cTCeQWNRiV+IRTUJMAoMNFWj70BJHbapYILuAOeeoupVDOfWPwNLAEcttsvC6peELIEp0GrD9WaRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugT4Ok7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4171AC4CEE7;
	Mon, 13 Oct 2025 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760367482;
	bh=g/OBgPtL4cfJmd78Y5/IFGnkf94C+MOLzLszuuacJG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugT4Ok7tDB6ihSl8qAwk1RM9FEVA6mNSL2fM4O6GbiC0m9szmLvhxY1/4G3Q6+b64
	 AEzem28O//4OWNMUy40VMoUrUC6AHm8pEeBj6sR4cD1V2mSciT2ltQlEwjjxMt6eRa
	 pQrh8kGbal2O/jAVa1G4zrAOUfINCsNhlgXwAkiA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 027/196] regulator: scmi: Use int type to store negative error codes
Date: Mon, 13 Oct 2025 16:43:38 +0200
Message-ID: <20251013144316.177898890@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144315.184275491@linuxfoundation.org>
References: <20251013144315.184275491@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qianfeng Rong <rongqianfeng@vivo.com>

[ Upstream commit 9d35d068fb138160709e04e3ee97fe29a6f8615b ]

Change the 'ret' variable from u32 to int to store negative error codes or
zero returned by of_property_read_u32().

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly as pants. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 0fbeae70ee7c ("regulator: add SCMI driver")
Link: https://patch.msgid.link/20250829101411.625214-1-rongqianfeng@vivo.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/scmi-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/scmi-regulator.c b/drivers/regulator/scmi-regulator.c
index 29ab217297d6d..432654fbd7a12 100644
--- a/drivers/regulator/scmi-regulator.c
+++ b/drivers/regulator/scmi-regulator.c
@@ -257,7 +257,8 @@ static int process_scmi_regulator_of_node(struct scmi_device *sdev,
 					  struct device_node *np,
 					  struct scmi_regulator_info *rinfo)
 {
-	u32 dom, ret;
+	u32 dom;
+	int ret;
 
 	ret = of_property_read_u32(np, "reg", &dom);
 	if (ret)
-- 
2.51.0




