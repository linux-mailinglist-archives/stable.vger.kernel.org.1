Return-Path: <stable+bounces-197062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9DCC8CAC3
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 03:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BFE60351AF8
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46890248867;
	Thu, 27 Nov 2025 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="fAcq+yWC";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="h76ftoVh"
X-Original-To: stable@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E2F21CC68;
	Thu, 27 Nov 2025 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764210770; cv=none; b=SRStTBQWjHWQeThrviKp7B66tDWn2WsQYVmVWVpuik+C9C+gl4vMx2FT2SkobAuxhuiswzk6yy16H8ziOA4s807chDiwtSEVtMHJ241IzGMxtmmAKhhpDQaF7Vp0MGT4F164CXgWPcKJDP4RHu25rYh5XwqFFcpjP4NZd8SeWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764210770; c=relaxed/simple;
	bh=TAXvV327W3/HWHYhaW8BCOljyf0ywz72yBANEpC5JMQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CQncGWCj0A1NG35reZtK27HNDpFPVltZxqgwCaJRotmNdYrzy40/vgN9h6oLOrgcOF43/+d/h3ojRbMusqnu+mksKIYIgDwtPLLHp3kuTxhSoxHT4IbHb0zKa0Ikb06nh865yrwsrrnRhdHL8F/Qo51ODdYNgi1UtyFYt508IsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=fAcq+yWC; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=h76ftoVh; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1764210766;
	bh=+gi4eVpD8x7Ekg5ewmo295blVaWoyq0TWrl7FTTPFZ8=; l=1250;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fAcq+yWCITpbSkMHiXK6qn87ikNC7JuMxJzU1vHOvNZEnspTJsapv7sbmCfcDY7mP
	 esyEGZ5LnHQKeIUcbQ8JxB0UuRQLasedm4WS6uJPhQxQnQ1OzLXACvnW4kWU8uHxJk
	 T5QIGMxxs/Kt6UmoMqjraxGVeJyQeB85WIUQ4zmho56bMP1IbAMz2/V2bsUpDHn7pC
	 HcZsTKKTS1ZwsBDN66qhoxpQxY8u81/CxcJlSJp7Vm2XIJsMUQpP/vWIbS5U3iCbM1
	 bywxf0anwSzpCiBApOVyVc4mEjpUmeyToHsnwcSVL2flmnUq0rVfbF6uXGdBGO4A/q
	 7ITuBKjsdziGQ==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128079:0:AUTH_RELAY)
	(envelope-from <prvs=1422232011=cy_huang@richtek.com>); Thu, 27 Nov 2025 10:32:45 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1764210765;
	bh=+gi4eVpD8x7Ekg5ewmo295blVaWoyq0TWrl7FTTPFZ8=; l=1250;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=h76ftoVhtClDxEwBidimxzqXyLXShkUsLjvQb8sQaM0GPli6f61m1FZGH4Tj/iEpH
	 b+Y6jUhDKLyPGI/AeMXrSz5Q9xQkk9JOOSdrDM1SotuuuS9P97Qy4TsCTqu8JGFvN1
	 2RG21TYl6L3uJfv43I7jKzXXhqMVq7AxPVOh2TQVnzyT+tmKQvgvS43cWmnKDHvowy
	 B5NpL8kdO1GPD9yHcLYFAjdvSpqQedcXq3O4HfTfa17FsHYqzxPJN4l/nNIldTfUTe
	 CmGBT+HzY+Cw8Ak2ct+6Ez9ETiqkQHNEYUcEQ195Wh52TAmfe8t7yCOFrfJUWRUOQl
	 ICOfOdP4ytVxw==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3436903:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 27 Nov 2025 10:25:56 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Thu, 27 Nov
 2025 10:25:55 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Thu, 27 Nov 2025 10:25:55 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Edward Kim <edward_kim@richtek.com>,
	<linux-kernel@vger.kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	<stable@vger.kernel.org>, Yoon Dong Min <dm.youn@telechips.com>
Subject: [PATCH 1/2] regulator: rtq2208: Correct buck group2 phase mapping logic
Date: Thu, 27 Nov 2025 10:25:50 +0800
Message-ID: <8527ae02a72b754d89b7580a5fe7474d6f80f5c3.1764209258.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Correct buck group2 H and F mapping logic.

Cc: stable@vger.kernel.org
Reported-by: Yoon Dong Min <dm.youn@telechips.com>
Fixes: 1742e7e978ba ("regulator: rtq2208: Fix incorrect buck converter phase mapping")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rtq2208-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 9cde7181b0f0..4a174e27c579 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -543,14 +543,14 @@ static int rtq2208_regulator_check(struct device *dev, int *num, int *regulator_
 
 	switch (FIELD_GET(RTQ2208_MASK_BUCKPH_GROUP2, buck_phase)) {
 	case 2:
-		rtq2208_used_table[RTQ2208_BUCK_F] = true;
+		rtq2208_used_table[RTQ2208_BUCK_H] = true;
 		fallthrough;
 	case 1:
 		rtq2208_used_table[RTQ2208_BUCK_E] = true;
 		fallthrough;
 	case 0:
 	case 3:
-		rtq2208_used_table[RTQ2208_BUCK_H] = true;
+		rtq2208_used_table[RTQ2208_BUCK_F] = true;
 		fallthrough;
 	default:
 		rtq2208_used_table[RTQ2208_BUCK_G] = true;

base-commit: ac3fd01e4c1efce8f2c054cdeb2ddd2fc0fb150d
-- 
2.34.1


