Return-Path: <stable+bounces-186346-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77958BE9548
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 231CC35BE23
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176F4337114;
	Fri, 17 Oct 2025 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+GXsLho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC00D3370F7
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712546; cv=none; b=qZmTpBwi6GoctoqorLZFtuAU1lA/UdtnxbiLR2GH2+abitaKsUZb9zJ7nxIBTdXiB6IgswlanH4OrT6jr0yzOMMQJatbrTaKIdjAowqe8UlyMQg0hoLDuC8ublXcqCD6MXUWk9SGVblPnKXuoix7oJY5gnOHm6JBxfXbzw9zG+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712546; c=relaxed/simple;
	bh=lxsVBPBK5V5pV/MIPH6K+Hht2y7s1aoX2EouEfpfoTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9pu131Ktgf/wQJKuWoBb38VrbuNwUCCmpA3vA5sXAi/TVPZ5BNn3tfojbxYQjWE8LE1chZ07IWw8yjzqlJ5CV3rPuSd4iphHiAsC0+k6agvrbZ5WcObixCwhPX2RZiqVciJFNxYDMYzB0/3FI+JtpcxuLfX1ee1bAGOCCEWf+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+GXsLho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DAEC4CEF9;
	Fri, 17 Oct 2025 14:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760712546;
	bh=lxsVBPBK5V5pV/MIPH6K+Hht2y7s1aoX2EouEfpfoTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+GXsLhoJ1LgP9qaGSQ4annXPWgDUfZ0N01JJK1ZiaoFyodhOHz/eNm5lv55zQ3M1
	 zF2fYi+FLOnls2OJ3JpCe2pbdv5UnfMenPfaRM9EgDlbtwLDoxPlYks9VWncuA1UH5
	 LpKphz5sW0ZqTHRkTVk2YC4Ohad8R7LQeC+KEhMkY1ylj1F/F1UDtFEpNSxF9rQ1qi
	 3TG8VBNJB4lrFckOqzIX5so/wV0ZYsHlodrCNk1CxvDPMbPRglMGeNZOZDjalALKNe
	 AA06MwfSwsWzzSzzQWxTF4rVpwmAc1Nvx5wlLRF4DiLgij9Gg0LmiYbcDgJqDtA1U8
	 8CCiyKqMAJi1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] media: s5p-mfc: constify pointers to s5p_mfc_cmd_args
Date: Fri, 17 Oct 2025 10:48:59 -0400
Message-ID: <20251017144900.4007781-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017144900.4007781-1-sashal@kernel.org>
References: <2025101646-overtake-starch-c0ab@gregkh>
 <20251017144900.4007781-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit 60a2a86fb8277ba2b8d26cd49222e92fea36a196 ]

In few places functions do not modify pointed "struct
s5p_mfc_cmd_args", thus the pointer can point to const data for
additional safety and self-documenting intention of the function.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 7fa37ba25a1d ("media: s5p-mfc: remove an unused/uninitialized variable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.h    | 2 +-
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c | 2 +-
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.h
index 945d12fdceb7d..172c5a63b58ea 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd.h
@@ -19,7 +19,7 @@ struct s5p_mfc_cmd_args {
 
 struct s5p_mfc_hw_cmds {
 	int (*cmd_host2risc)(struct s5p_mfc_dev *dev, int cmd,
-				struct s5p_mfc_cmd_args *args);
+			     const struct s5p_mfc_cmd_args *args);
 	int (*sys_init_cmd)(struct s5p_mfc_dev *dev);
 	int (*sleep_cmd)(struct s5p_mfc_dev *dev);
 	int (*wakeup_cmd)(struct s5p_mfc_dev *dev);
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
index 1fbf7ed5d4cca..82ee6d300c738 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
@@ -14,7 +14,7 @@
 
 /* This function is used to send a command to the MFC */
 static int s5p_mfc_cmd_host2risc_v5(struct s5p_mfc_dev *dev, int cmd,
-				struct s5p_mfc_cmd_args *args)
+				    const struct s5p_mfc_cmd_args *args)
 {
 	int cur_cmd;
 	unsigned long timeout;
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
index 740aa4dfae579..47bc3014b5d8b 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -15,7 +15,7 @@
 #include "s5p_mfc_cmd_v6.h"
 
 static int s5p_mfc_cmd_host2risc_v6(struct s5p_mfc_dev *dev, int cmd,
-				struct s5p_mfc_cmd_args *args)
+				    const struct s5p_mfc_cmd_args *args)
 {
 	mfc_debug(2, "Issue the command: %d\n", cmd);
 
-- 
2.51.0


