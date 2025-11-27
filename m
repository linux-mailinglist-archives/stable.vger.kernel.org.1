Return-Path: <stable+bounces-197063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D1030C8CACC
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 03:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 21337351001
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 02:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48269265CA7;
	Thu, 27 Nov 2025 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="fhmW7gLJ";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="r/3/1voM"
X-Original-To: stable@vger.kernel.org
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6078222560;
	Thu, 27 Nov 2025 02:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764210772; cv=none; b=tXJv7FWewoUf3vvGIyqOyOhufNI2SQwg68h4mDsAKdJl5x4FX1MQCaUcUYa96VrTMheId0Q/BQuir3dFfOL8zB2qVVKhpZeBGOSr0PpHVOWx5Fv6pDoG/ePts6K8NtYO6dp3X0R04aaFV7t9BRv6UNaVi9MsV/eb0aIFswsOErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764210772; c=relaxed/simple;
	bh=4QsLxt5+m/Q/cbJLp4jdEHLVLzLrd53A5WhaMfslvR0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FU35v+r+5tib7puT62viW5q9SoccLIT+UbtQXdk7mRB3mZXZ6FNQ/25h+fVD2MbwjlEdsO5/gqdUHN8KJ1Q6Udq1FXhx321kSSWZvDzcGfCoMiQcyIzpUWkhq5V3hnmbOac4DlILZad+yB5nSu0EC8zsUrl1yi63fKpgSQ6yYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=fhmW7gLJ; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=r/3/1voM; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1764210766;
	bh=lBgpYdf7TvegPjkMulksVmLXNXQ0fFwjDEhxaU3PE48=; l=940;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=fhmW7gLJRMj5bhyyqb31PimORv9sH7KoJpU2Ql6iu1jl81uZvsi+xyhLbRvnuBcQN
	 dpf6TKma8NmLiOGsOnAxXxj1heOYX8AVSuAtLhDSx+uox97kklTEX95UAO6L1/5EkJ
	 vtf2PK9YgUHDfEIGolPZQ2xr/EjtfjvzJe5Pz+nG33INsa0/2p7CkwqJ1MwQOYx3ky
	 BAJJPqLJMBoJGD6pw3wIZgaM68RoLGU2iWoZz2Rtwr9yAGCD680vSP5DIyy3g0hwzS
	 XzMzNabw4oeOiC1ED3DxbL5xOSZJSEcSqlc2ICeLVQw5pLPK3WKFsofhhqXpHEpV8R
	 bcjZbfFHfmJ/w==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128080:0:AUTH_RELAY)
	(envelope-from <prvs=1422232011=cy_huang@richtek.com>); Thu, 27 Nov 2025 10:32:45 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1764210765;
	bh=lBgpYdf7TvegPjkMulksVmLXNXQ0fFwjDEhxaU3PE48=; l=940;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=r/3/1voMR7UmBg5JwmbSEvZn2aInk08RSKnRYljxcu/IaCzaUBJV+LamXhZ4j6gnx
	 zfFSUM/0qUBsIxS2USIejVIWuiljIhVGL6r/WbNaxHH5C4zncaPDDGcUu3gfVzZpCU
	 g+9Pvts+/yxX85XV+XGWUySgH232BTVgQm4rQuhB/JDpqLyQqcuS6p81HCD3m/6xqs
	 8LX8razapMdNt2ULif/B4+RcTHIQYAWaZ+6TFYWV7SoZmlYdbp30dKuRVHE1VYABlK
	 wKr+vox6mycID3kgZhgtoXcx2iu1XRRQO/9qrrIcATZyigmxCFPEYLNlGDlU1JoKbQ
	 If7Ly0I4vMTtA==
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3436934:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Thu, 27 Nov 2025 10:25:56 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Thu, 27 Nov
 2025 10:25:56 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1748.26 via Frontend
 Transport; Thu, 27 Nov 2025 10:25:56 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Edward Kim <edward_kim@richtek.com>,
	<linux-kernel@vger.kernel.org>, ChiYuan Huang <cy_huang@richtek.com>,
	<stable@vger.kernel.org>, Yoon Dong Min <dm.youn@telechips.com>
Subject: [PATCH 2/2] regulator: rtq2208: Correct LDO2 logic judgment bits
Date: Thu, 27 Nov 2025 10:25:51 +0800
Message-ID: <faadb009f84b88bfcabe39fc5009c7357b00bbe2.1764209258.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <8527ae02a72b754d89b7580a5fe7474d6f80f5c3.1764209258.git.cy_huang@richtek.com>
References: <8527ae02a72b754d89b7580a5fe7474d6f80f5c3.1764209258.git.cy_huang@richtek.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

The LDO2 judgement bit position should be 7, not 6.

Cc: stable@vger.kernel.org
Reported-by: Yoon Dong Min <dm.youn@telechips.com>
Fixes: b65439d90150 ("regulator: rtq2208: Fix the LDO DVS capability")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/regulator/rtq2208-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rtq2208-regulator.c b/drivers/regulator/rtq2208-regulator.c
index 4a174e27c579..f669a562f036 100644
--- a/drivers/regulator/rtq2208-regulator.c
+++ b/drivers/regulator/rtq2208-regulator.c
@@ -53,7 +53,7 @@
 #define RTQ2208_MASK_BUCKPH_GROUP1		GENMASK(6, 4)
 #define RTQ2208_MASK_BUCKPH_GROUP2		GENMASK(2, 0)
 #define RTQ2208_MASK_LDO2_OPT0			BIT(7)
-#define RTQ2208_MASK_LDO2_OPT1			BIT(6)
+#define RTQ2208_MASK_LDO2_OPT1			BIT(7)
 #define RTQ2208_MASK_LDO1_FIXED			BIT(6)
 
 /* Size */
-- 
2.34.1


