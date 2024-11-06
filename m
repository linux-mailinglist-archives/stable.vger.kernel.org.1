Return-Path: <stable+bounces-89999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B3E9BDC6A
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8360B283161
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C541DF755;
	Wed,  6 Nov 2024 02:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYyYTIqP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC51DF746;
	Wed,  6 Nov 2024 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859134; cv=none; b=P8Dl47jjFyprOLGaCMxknUfaCsik0ccGLluLU86Xu0mIvyw+S5IsodXO+y6jy5cXE8I07Ccc7S42zHoZg5Y1eRssyuEZSTgzpj7WQyn0Ig5Aele7IpL4EpcGt9bcj1alvu6/p7BQzSI+cf4t/6/9/fGqQZPSZJX4XZE+IQ6l28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859134; c=relaxed/simple;
	bh=/7psXaKrO72ygdHt3ghBcLiEMgOPbc/TQpXjdBdPo/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngPEJ01vtJwtTw3NhwJnyUT4Pfe4ZTLYUUSUcZUTvU4Ej2lNnaHHh5fqiItFm4y6OmgK8iUhYbvl3SiaYymGM5iQ1BcnZD8jD4FTpzX1l9+xz2FLaGGhdv8URQkaDRLr4eoKEPPZ+ur2Mb7ZBCBJ9i2a2ZM8c8OvBo9hhym7Pj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYyYTIqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0452FC4CECF;
	Wed,  6 Nov 2024 02:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859133;
	bh=/7psXaKrO72ygdHt3ghBcLiEMgOPbc/TQpXjdBdPo/Y=;
	h=From:To:Cc:Subject:Date:From;
	b=tYyYTIqPb/mpAZcENlc8i5qjiI1JwxkTM0t3Vut0bJvNuBfAwUTtBP3jKyjEZCjTO
	 2LkO/b34Kdx3SidHYhKXDyVrzSjXXCuTgviugAme5T45Tyvt3XAZynMv0xkUmcmWWx
	 vqjZG8bFP1WTHIFt1PzTH3Yn9gCLPFJHnWMD4ZJTYWeXEjcSxIijR9TbKp8xktrsW1
	 UNOqGmf0T5wQNVZp0QG+0PRFnEhEKoSrS+S7JmulUHYdKkZWFMyupvU8MHOBVfKb+q
	 R26u3fX9VsQrw/31wxGShh/MndElBpmrc0tnPCOmf7MR1xzwsquskzi2X1TTkHMkqV
	 S0SabkxB7JMQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gil.fine@linux.intel.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "thunderbolt: Honor TMU requirements in the domain when setting TMU mode" failed to apply to v5.15-stable tree
Date: Tue,  5 Nov 2024 21:12:11 -0500
Message-ID: <20241106021211.182742-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3cea8af2d1a9ae5869b47c3dabe3b20f331f3bbd Mon Sep 17 00:00:00 2001
From: Gil Fine <gil.fine@linux.intel.com>
Date: Thu, 10 Oct 2024 17:29:42 +0300
Subject: [PATCH] thunderbolt: Honor TMU requirements in the domain when
 setting TMU mode

Currently, when configuring TMU (Time Management Unit) mode of a given
router, we take into account only its own TMU requirements ignoring
other routers in the domain. This is problematic if the router we are
configuring has lower TMU requirements than what is already configured
in the domain.

In the scenario below, we have a host router with two USB4 ports: A and
B. Port A connected to device router #1 (which supports CL states) and
existing DisplayPort tunnel, thus, the TMU mode is HiFi uni-directional.

1. Initial topology

          [Host]
         A/
         /
 [Device #1]
   /
Monitor

2. Plug in device #2 (that supports CL states) to downstream port B of
   the host router

         [Host]
        A/    B\
        /       \
 [Device #1]    [Device #2]
   /
Monitor

The TMU mode on port B and port A will be configured to LowRes which is
not what we want and will cause monitor to start flickering.

To address this we first scan the domain and search for any router
configured to HiFi uni-directional mode, and if found, configure TMU
mode of the given router to HiFi uni-directional as well.

Cc: stable@vger.kernel.org
Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/tb.c | 48 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 10e719dd837ce..4f777788e9179 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -288,6 +288,24 @@ static void tb_increase_tmu_accuracy(struct tb_tunnel *tunnel)
 	device_for_each_child(&sw->dev, NULL, tb_increase_switch_tmu_accuracy);
 }
 
+static int tb_switch_tmu_hifi_uni_required(struct device *dev, void *not_used)
+{
+	struct tb_switch *sw = tb_to_switch(dev);
+
+	if (sw && tb_switch_tmu_is_enabled(sw) &&
+	    tb_switch_tmu_is_configured(sw, TB_SWITCH_TMU_MODE_HIFI_UNI))
+		return 1;
+
+	return device_for_each_child(dev, NULL,
+				     tb_switch_tmu_hifi_uni_required);
+}
+
+static bool tb_tmu_hifi_uni_required(struct tb *tb)
+{
+	return device_for_each_child(&tb->dev, NULL,
+				     tb_switch_tmu_hifi_uni_required) == 1;
+}
+
 static int tb_enable_tmu(struct tb_switch *sw)
 {
 	int ret;
@@ -302,12 +320,30 @@ static int tb_enable_tmu(struct tb_switch *sw)
 	ret = tb_switch_tmu_configure(sw,
 			TB_SWITCH_TMU_MODE_MEDRES_ENHANCED_UNI);
 	if (ret == -EOPNOTSUPP) {
-		if (tb_switch_clx_is_enabled(sw, TB_CL1))
-			ret = tb_switch_tmu_configure(sw,
-					TB_SWITCH_TMU_MODE_LOWRES);
-		else
-			ret = tb_switch_tmu_configure(sw,
-					TB_SWITCH_TMU_MODE_HIFI_BI);
+		if (tb_switch_clx_is_enabled(sw, TB_CL1)) {
+			/*
+			 * Figure out uni-directional HiFi TMU requirements
+			 * currently in the domain. If there are no
+			 * uni-directional HiFi requirements we can put the TMU
+			 * into LowRes mode.
+			 *
+			 * Deliberately skip bi-directional HiFi links
+			 * as these work independently of other links
+			 * (and they do not allow any CL states anyway).
+			 */
+			if (tb_tmu_hifi_uni_required(sw->tb))
+				ret = tb_switch_tmu_configure(sw,
+						TB_SWITCH_TMU_MODE_HIFI_UNI);
+			else
+				ret = tb_switch_tmu_configure(sw,
+						TB_SWITCH_TMU_MODE_LOWRES);
+		} else {
+			ret = tb_switch_tmu_configure(sw, TB_SWITCH_TMU_MODE_HIFI_BI);
+		}
+
+		/* If not supported, fallback to bi-directional HiFi */
+		if (ret == -EOPNOTSUPP)
+			ret = tb_switch_tmu_configure(sw, TB_SWITCH_TMU_MODE_HIFI_BI);
 	}
 	if (ret)
 		return ret;
-- 
2.43.0





