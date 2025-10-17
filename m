Return-Path: <stable+bounces-186345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C2BE956F
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC5FA188ADEC
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF81337110;
	Fri, 17 Oct 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMtqFk0k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F29337104
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712546; cv=none; b=k07+GFwrGxnIreFWixR+Elon5PY96TfuqD7Hm2QvseJNAp50Wl6lLQsUFfI8OsoT1exZS2YQjxV5OqF9WTI/3vAv00CSxSUT+YtUCYRzfSZDKlnlNWa8gXifMJf8ABMZoHj08LH2KfOs/m7BzUE3jAc/wZMus8bAosUJGESjnA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712546; c=relaxed/simple;
	bh=RUGwU0HLIxBez3QLkRRH7tHTg6usCxWF4kdtnJNo6oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DM/wwWq99g8sluyW4rzR7nKp+lo3GeOVsZwJZnK4jluxCC9nKaeJ0E00V4Ei/9K+2LRkQKXjKnoCwOoEzI4i0BoNylkuOpi2ntYWnG8aFyPNPSN2A8k7X+363Jy3l1xFGuvnBnzzJHlJNVEh2XyFU1a0X0AmrQkSsrcEHslVQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMtqFk0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C771EC2BCFC;
	Fri, 17 Oct 2025 14:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760712545;
	bh=RUGwU0HLIxBez3QLkRRH7tHTg6usCxWF4kdtnJNo6oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMtqFk0kqaCgExEmBNWv2OnsNIiutS9QJ3OcIOoLe8bJ0A7lWgKXiG23q5/UP9Dvb
	 rk9n+Xt6n8Gps/qMSLULtV/7MEhXhe63/v0xyqhGh0bWN7HHhywpMpdVIxOThAJhqk
	 QeSWNA03DcsH3YY9bPkIXyFw+Wa3KMknwjukcNBtb1y/ffLXycQ1yVVDZgFDib4i3B
	 dP/X5utKKfPT9TLckmQMIUF4hs9Huz3WPEv9Bx9keeKhgUeRbakB+iED5YLEtSYvi7
	 rXqDP54rvRMdkiZMBmtkBm6OUBYtnD6k1cmN9iVzlvcRK0+/aN3suwDEucSvp9QORD
	 LPC+bSUp1fDQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] media: s5p-mfc: constify s5p_mfc_hw_cmds structures
Date: Fri, 17 Oct 2025 10:48:58 -0400
Message-ID: <20251017144900.4007781-3-sashal@kernel.org>
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

[ Upstream commit c76c43d77869adc1709693ba532fe7fb4f30aa45 ]

Static "s5p_mfc_hw_cmds" structures are not modified by the driver, so
they can be made const for code safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 7fa37ba25a1d ("media: s5p-mfc: remove an unused/uninitialized variable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c | 4 ++--
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h | 2 +-
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c | 4 ++--
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h | 2 +-
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
index 327e54e706114..1fbf7ed5d4cca 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.c
@@ -148,7 +148,7 @@ static int s5p_mfc_close_inst_cmd_v5(struct s5p_mfc_ctx *ctx)
 }
 
 /* Initialize cmd function pointers for MFC v5 */
-static struct s5p_mfc_hw_cmds s5p_mfc_cmds_v5 = {
+static const struct s5p_mfc_hw_cmds s5p_mfc_cmds_v5 = {
 	.cmd_host2risc = s5p_mfc_cmd_host2risc_v5,
 	.sys_init_cmd = s5p_mfc_sys_init_cmd_v5,
 	.sleep_cmd = s5p_mfc_sleep_cmd_v5,
@@ -157,7 +157,7 @@ static struct s5p_mfc_hw_cmds s5p_mfc_cmds_v5 = {
 	.close_inst_cmd = s5p_mfc_close_inst_cmd_v5,
 };
 
-struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v5(void)
+const struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v5(void)
 {
 	return &s5p_mfc_cmds_v5;
 }
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
index 6eafa514aebca..c626376053c45 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v5.h
@@ -11,6 +11,6 @@
 
 #include "s5p_mfc_common.h"
 
-struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v5(void);
+const struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v5(void);
 
 #endif /* S5P_MFC_CMD_H_ */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
index 25c4719a5dd05..740aa4dfae579 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c
@@ -154,7 +154,7 @@ static int s5p_mfc_close_inst_cmd_v6(struct s5p_mfc_ctx *ctx)
 }
 
 /* Initialize cmd function pointers for MFC v6 */
-static struct s5p_mfc_hw_cmds s5p_mfc_cmds_v6 = {
+static const struct s5p_mfc_hw_cmds s5p_mfc_cmds_v6 = {
 	.cmd_host2risc = s5p_mfc_cmd_host2risc_v6,
 	.sys_init_cmd = s5p_mfc_sys_init_cmd_v6,
 	.sleep_cmd = s5p_mfc_sleep_cmd_v6,
@@ -163,7 +163,7 @@ static struct s5p_mfc_hw_cmds s5p_mfc_cmds_v6 = {
 	.close_inst_cmd = s5p_mfc_close_inst_cmd_v6,
 };
 
-struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v6(void)
+const struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v6(void)
 {
 	return &s5p_mfc_cmds_v6;
 }
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
index 9dc44460cc38d..29083436f5173 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.h
@@ -11,6 +11,6 @@
 
 #include "s5p_mfc_common.h"
 
-struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v6(void);
+const struct s5p_mfc_hw_cmds *s5p_mfc_init_hw_cmds_v6(void);
 
 #endif /* S5P_MFC_CMD_H_ */
diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index 6a47f3434c60d..9278ed537e9ca 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -339,7 +339,7 @@ struct s5p_mfc_dev {
 	struct s5p_mfc_priv_buf ctx_buf;
 	int warn_start;
 	struct s5p_mfc_hw_ops *mfc_ops;
-	struct s5p_mfc_hw_cmds *mfc_cmds;
+	const struct s5p_mfc_hw_cmds *mfc_cmds;
 	const struct s5p_mfc_regs *mfc_regs;
 	enum s5p_mfc_fw_ver fw_ver;
 	bool fw_get_done;
-- 
2.51.0


