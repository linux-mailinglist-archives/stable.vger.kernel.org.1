Return-Path: <stable+bounces-67383-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B22B94F7C0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 21:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1EC1F22CB7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 19:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BC81917DB;
	Mon, 12 Aug 2024 19:57:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from 16.mo582.mail-out.ovh.net (16.mo582.mail-out.ovh.net [87.98.139.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A1F13BC02
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=87.98.139.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723492627; cv=none; b=m0qIcbts7yQv64ZLGBlnD8UXFTIw4+OEShxW6j6dPF7Gj+PamkgfbtEXXVlLaBjyzsq61M76DUQbDdPDx5K68S/4aUoytblTx8il8/9Uhjcfi9AR/+R5Zis+JD1evX4usoekM56A/OwkoYtVY4qpnJr/3V1fYiuj3OpCO30CfDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723492627; c=relaxed/simple;
	bh=OwaYBx/xSKuijtieDU7h0nqtEahyb7C8n+PL7wBUgJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sONZCuUfHUlogHa4SPMPnm1bA0a9FhkTlEOHLKkFRMZDSxtEKh+U+nuZcPvlFhTN9ilfIk3X0D7IFLskQRkyzlxcPzL6kX6aJclVyuEGmoSHriepxJyC1qkackbuJS7Z97G4G0RSaMEYCZfgFPQ450c1Odx6SzG9IAY+WVZtrrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=etezian.org; arc=none smtp.client-ip=87.98.139.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etezian.org
Received: from director1.ghost.mail-out.ovh.net (unknown [10.108.2.211])
	by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4WjPz44Pb6z1JLG
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 19:41:36 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-plhlz (unknown [10.110.118.244])
	by director1.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 283651FE44;
	Mon, 12 Aug 2024 19:41:34 +0000 (UTC)
Received: from etezian.org ([37.59.142.101])
	by ghost-submission-6684bf9d7b-plhlz with ESMTPSA
	id ymM3Km5lumZkMCAAii7AHw
	(envelope-from <andi@etezian.org>); Mon, 12 Aug 2024 19:41:34 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G00454ab9ec0-df5c-45fa-b21e-fd2114598578,
                    664DA16141902EE5CF70331F943976485F5C157F) smtp.auth=andi@etezian.org
X-OVh-ClientIp:188.155.229.193
From: Andi Shyti <andi.shyti@kernel.org>
To: linux-i2c <linux-i2c@vger.kernel.org>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	stable@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH 1/2] i2c: qcom-geni: Add missing geni_icc_disable in geni_i2c_runtime_resume
Date: Mon, 12 Aug 2024 21:40:28 +0200
Message-ID: <20240812194029.2222697-2-andi.shyti@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812194029.2222697-1-andi.shyti@kernel.org>
References: <20240812194029.2222697-1-andi.shyti@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7309342197315013237
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddruddttddgudeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetnhguihcuufhhhihtihcuoegrnhguihdrshhhhihtiheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpefgudevjeetgeetlefhteeuteehgeefhefhkedtvdelheethfehveekudelueeuveenucfkphepuddvjedrtddrtddruddpudekkedrudehhedrvddvledrudelfedpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprghnughisegvthgviihirghnrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth

Add the missing geni_icc_disable() call before returning in the
geni_i2c_runtime_resume() function.

Commit 9ba48db9f77c ("i2c: qcom-geni: Add missing
geni_icc_disable in geni_i2c_runtime_resume") by Gaosheng missed
disabling the interconnect in one case.

Fixes: bf225ed357c6 ("i2c: i2c-qcom-geni: Add interconnect support")
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: <stable@vger.kernel.org> # v5.9+
---
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

 drivers/i2c/busses/i2c-qcom-geni.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 365e37bba0f33..06e836e3e8773 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -986,8 +986,10 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 		return ret;
 
 	ret = clk_prepare_enable(gi2c->core_clk);
-	if (ret)
+	if (ret) {
+		geni_icc_disable(&gi2c->se);
 		return ret;
+	}
 
 	ret = geni_se_resources_on(&gi2c->se);
 	if (ret) {
-- 
2.45.2


