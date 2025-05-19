Return-Path: <stable+bounces-144764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C8CABBAFD
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 12:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70DE0188DA11
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 10:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29D92741AE;
	Mon, 19 May 2025 10:22:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A88A94F;
	Mon, 19 May 2025 10:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650135; cv=none; b=i9hVhtI1NZ7/L4BgaFHzleMdl2lfgeMk54wfod98MsAPLB6ET08RK7/EUS1fgZ1Dggs/hiubZqPQlFbz5BI7OTN02FUHcDc2uirHjh+Hf8zH3VTAfsSIsB4fFmZ4rf2HWT5+YESW25bkVZM0khK1n3ieZ6y6qRnhu6bP5Sht3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650135; c=relaxed/simple;
	bh=M66grIRayxuiFCfPOtRCmOUI64aUQPuVQIUUf0osrtk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=owBGxmQkFfrCKJ/F/7iMZ/zaknGLu3MlJIYhhWPLCihlkTVQLdGIHl5GxNaq5Hw8p7Rw0Idc1W5EmN8HASLm5iWUunt4MGb0K9dOEf+DYtixDAQpTHVNr0la8h/TslH31TxJUXh3WBdxNlRgCT9UJrMTVgJFb00oiQcR8LnbnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [124.16.141.245])
	by APP-05 (Coremail) with SMTP id zQCowAB3tylFBitovWVxAQ--.12796S2;
	Mon, 19 May 2025 18:21:58 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: irusskikh@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: atlantic: Add error handling in set_raw_ingress_record()
Date: Mon, 19 May 2025 18:21:32 +0800
Message-ID: <20250519102132.2089-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.42.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3tylFBitovWVxAQ--.12796S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWxXw48GF45tF4UJry5Arb_yoW8CFy8pw
	4a9F90g34Utw4fuFW8Ja1rCr45Z3y8try7Way3Gw1fZFyFyr4DtF4rXryF9F15WFWUAanI
	9rW0krW2kwn0y3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU52NtDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAgHA2gq9CsK8QABsn

The set_raw_ingress_record() calls aq_mss_mdio_write() but does not
check the return value. A proper implementation can be found in
get_raw_ingress_record().

Add error handling for aq_mss_mdio_write(). If the write fails,
return immediately.

Fixes: b8f8a0b7b5cb ("net: atlantic: MACSec ingress offload HW bindings")
Cc: stable@vger.kernel.org # v5.7
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 .../aquantia/atlantic/macsec/macsec_api.c         | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c b/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c
index 431924959520..5e87f8b749c5 100644
--- a/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c
+++ b/drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c
@@ -62,6 +62,7 @@ static int set_raw_ingress_record(struct aq_hw_s *hw, u16 *packed_record,
 {
 	struct mss_ingress_lut_addr_ctl_register lut_sel_reg;
 	struct mss_ingress_lut_ctl_register lut_op_reg;
+	int ret;
 
 	unsigned int i;
 
@@ -105,11 +106,15 @@ static int set_raw_ingress_record(struct aq_hw_s *hw, u16 *packed_record,
 	lut_op_reg.bits_0.lut_read = 0;
 	lut_op_reg.bits_0.lut_write = 1;
 
-	aq_mss_mdio_write(hw, MDIO_MMD_VEND1,
-			  MSS_INGRESS_LUT_ADDR_CTL_REGISTER_ADDR,
-			  lut_sel_reg.word_0);
-	aq_mss_mdio_write(hw, MDIO_MMD_VEND1, MSS_INGRESS_LUT_CTL_REGISTER_ADDR,
-			  lut_op_reg.word_0);
+	ret = aq_mss_mdio_write(hw, MDIO_MMD_VEND1,
+				MSS_INGRESS_LUT_ADDR_CTL_REGISTER_ADDR,
+				lut_sel_reg.word_0);
+	if (unlikely(ret))
+		return ret;
+	ret = aq_mss_mdio_write(hw, MDIO_MMD_VEND1, MSS_INGRESS_LUT_CTL_REGISTER_ADDR,
+				lut_op_reg.word_0);
+	if (unlikely(ret))
+		return ret;
 
 	return 0;
 }
-- 
2.42.0.windows.2


