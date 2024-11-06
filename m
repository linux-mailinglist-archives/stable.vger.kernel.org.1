Return-Path: <stable+bounces-90043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8417C9BDCDB
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0849C28931D
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4154321949D;
	Wed,  6 Nov 2024 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nO9n2cDy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A51D86C9;
	Wed,  6 Nov 2024 02:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859287; cv=none; b=mBoKvLI9X8XNt/qDKL37vmbWGyUv5XDHzPnF5jXQ8gpdW5icqX3NU8Me67pqsIRCH5DX6b0Ik2N/UExwd0nvW/TfODzEzznlNa7MZ/+EQB7bhYHPrBPFWtdAdwV4UpyrhEhVt+AqJ1envaBGz3oyCsx68ecMQDzodGytiNaPzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859287; c=relaxed/simple;
	bh=JyPJGtsm3K6JU32Nz/iopXhqEVlPNysU3RBw17FVilc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFRAffa6O2t3gR1LyugU4QD7HM3NKdkI9V01L8ZAUSvnf8xlRtspV2H77+WRRIa/hUeohXXw6I7RF7Uv1H5kKzQjyXmtj+9A0bhcym81yaV0vwC70rV/UYhbae4+LdaFJcGLH8VOifrRknwhb/mIGIMtl6pK9KW6NraXT9z8ywE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nO9n2cDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F88C4CECF;
	Wed,  6 Nov 2024 02:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859286;
	bh=JyPJGtsm3K6JU32Nz/iopXhqEVlPNysU3RBw17FVilc=;
	h=From:To:Cc:Subject:Date:From;
	b=nO9n2cDy4CLNx+EX4Zmsxf8FZyiuKHxz5VoZi4tQXlEGmmKl5yOpEGI60uUeHBkT1
	 Yukp8Tb6dgy1ltoHvY5KnzTUSmTGiuh7evRLKPzpnDdAua3c7VINfot1WzyUi8VQVV
	 6Q9IOzlWYKvud1rnhcwBOkWpO0MsW9XM40hqjMMIhkpORJkvTdbZF9/IhfhbW2R0l7
	 xvMuXVFKTDjPnYcdmYLU9yzbySzboE6g3rZlsg+y4Zb1eDJ5qD08uRuvicI4F/OyWu
	 WacVGFZF/j2PuyzmGnNK7U1WjzRXV9VcNCsP9VyHa/TGSmsjU/7UWvMW3eqnUohffd
	 1Pmag3ke3A5+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gil.fine@linux.intel.com
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "thunderbolt: Honor TMU requirements in the domain when setting TMU mode" failed to apply to v4.19-stable tree
Date: Tue,  5 Nov 2024 21:14:43 -0500
Message-ID: <20241106021444.184480-1-sashal@kernel.org>
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

The patch below does not apply to the v4.19-stable tree.
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





