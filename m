Return-Path: <stable+bounces-172763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 941B9B33213
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 20:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504BC441147
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 18:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186221448D5;
	Sun, 24 Aug 2025 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlL6YrVf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC0D393DF3
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756060394; cv=none; b=CgnmwyZPL/PnIqWQY1nrQAu0CzLg3Vs286IT0CVEOxU7+GSiV8A7l+DRvTLa/zfc9dsGHXb9clTQX748a7cAsTpfwX9KuExIcr3gzcbaMmGFeeh8aI81OF2KLRvuSSM0JDr1cSv0ggfoNJg4wggj09HJjWlgbZ3xPpZ8VeWg5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756060394; c=relaxed/simple;
	bh=0zO5k/pI2fRLsyACe7hyMmhCT16J8LqUF2Ggy4M0JIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucPfIfyhlecZu0tLTR46STnszE3nnFfcV3c84rQdMIc3t0/fANE2L5dhfevspzzGfq9CkA9C0/hmb2o75QjSUG0yhpB0+rBtv7b7MWFg7o1rmvUtTDgzFQ9w3/KqZAPbY5DeEi6OpD0VacyDXbtx5Khq4WrVyHDTYgtPDHI97Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlL6YrVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B60C4CEF4;
	Sun, 24 Aug 2025 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756060394;
	bh=0zO5k/pI2fRLsyACe7hyMmhCT16J8LqUF2Ggy4M0JIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tlL6YrVfh//z31JwBnt/jX5Qc19SABdRl3okY4D/YX7tGQwZTcew1zoBY94Ar7Plm
	 2StEnEJC0McfVUZ5fF33NqXRt0g1nHkxbShyenSsueBVJDXfDdj0x5NYFXQG8jXY8s
	 ng5TdEwKlaMWMZ+PvFSrEH5ApEZp1jtC723xZizKUpRJtREqG/T1VRGgMNJ5tRPnJr
	 fnN4WwjKEWd/svSLwxX1DnwENzIlQCyUHGRvkcgehk1q4scYnIv0vRBNGppbWUvRw3
	 EOBI0ZhOrh44m1ATAKoJvf77iMtEb5UW1MFZTyYutpBeTBhbLrPtN2x9BqRfon0egg
	 gRO+mdgeg3M8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amit Sunil Dhamne <amitsd@google.com>,
	stable <stable@kernel.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: typec: maxim_contaminant: disable low power mode when reading comparator values
Date: Sun, 24 Aug 2025 14:33:12 -0400
Message-ID: <20250824183312.795044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082341-salami-darkroom-6913@gregkh>
References: <2025082341-salami-darkroom-6913@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amit Sunil Dhamne <amitsd@google.com>

[ Upstream commit cabb6c5f4d9e7f49bdf8c0a13c74bd93ee35f45a ]

Low power mode is enabled when reading CC resistance as part of
`max_contaminant_read_resistance_kohm()` and left in that state.
However, it's supposed to work with 1uA current source. To read CC
comparator values current source is changed to 80uA. This causes a storm
of CC interrupts as it (falsely) detects a potential contaminant. To
prevent this, disable low power mode current sourcing before reading
comparator values.

Fixes: 02b332a06397 ("usb: typec: maxim_contaminant: Implement check_contaminant callback")
Cc: stable <stable@kernel.org>
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Rule: add
Link: https://lore.kernel.org/stable/20250814-fix-upstream-contaminant-v1-1-801ce8089031%40google.com
Link: https://lore.kernel.org/r/20250815-fix-upstream-contaminant-v2-1-6c8d6c3adafb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted macro names from CCLPMODESEL to CCLPMODESEL_MASK ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/maxim_contaminant.c | 6 ++++++
 drivers/usb/typec/tcpm/tcpci_maxim.h       | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index 60f90272fed3..eb84701c4ee7 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -5,6 +5,7 @@
  * USB-C module to reduce wakeups due to contaminants.
  */
 
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/irqreturn.h>
 #include <linux/module.h>
@@ -189,6 +190,11 @@ static int max_contaminant_read_comparators(struct max_tcpci_chip *chip, u8 *ven
 	if (ret < 0)
 		return ret;
 
+	/* Disable low power mode */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL_MASK,
+				 FIELD_PREP(CCLPMODESEL_MASK,
+					    LOW_POWER_MODE_DISABLE));
+
 	/* Sleep to allow comparators settle */
 	usleep_range(5000, 6000);
 	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_ORIENTATION, PLUG_ORNT_CC1);
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index 2c1c4d161b0d..861801cc456f 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.h
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -21,6 +21,7 @@
 #define CCOVPDIS                                BIT(6)
 #define SBURPCTRL                               BIT(5)
 #define CCLPMODESEL_MASK                        GENMASK(4, 3)
+#define LOW_POWER_MODE_DISABLE                  0
 #define ULTRA_LOW_POWER_MODE                    BIT(3)
 #define CCRPCTRL_MASK                           GENMASK(2, 0)
 #define UA_1_SRC                                1
-- 
2.50.1


