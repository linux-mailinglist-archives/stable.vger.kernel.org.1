Return-Path: <stable+bounces-186336-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15043BE9365
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147E83B5CE5
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E436E32C92F;
	Fri, 17 Oct 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qi8eZeT+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A032C928
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711533; cv=none; b=q84lkYar9x5TkBMmSe632oJL81IdPTHbZzQkVuWS6kkVsqPc0tuFM0MFpqgGw9XDSy0clDX04MFUrtz3smjWP+4gm1jmJxEt8Sf48TgKXRWdNdoZWNtIiib4qY6jcO/N0Byb7Sh5cLYAYM45ja50hP2+8RUZwVyG77wFARcY068=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711533; c=relaxed/simple;
	bh=lxsVBPBK5V5pV/MIPH6K+Hht2y7s1aoX2EouEfpfoTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AeUpqfngtKZk/9trmEK5XiAhZA0DHoJqlcmZrWbqGsK3D40u5Ya7fM93kJWXzpBAGI7t7TOqHCfQLIlygyUlr2QBj1t2HkSW0rJMT9I+LI5loxerjRTkMcS/TOBNuZlZ3uqSbUlgv8V/sWovICv2zJLq4hEsgGEKPSnTBaB+SbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qi8eZeT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0515C4CEF9;
	Fri, 17 Oct 2025 14:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760711533;
	bh=lxsVBPBK5V5pV/MIPH6K+Hht2y7s1aoX2EouEfpfoTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qi8eZeT+GxbFpQ1uVbZK+230JZ1Q9qnS22Td6asGwHklv70VcDf+FRL5RHDyP3zDr
	 ll/sUaG1QOW2ODTHyVtgg1LWNuzjIavORb1+S2KQWqj7B29QJME9xa82138bzLnj/+
	 imIFawLg/0APPuW3qGYBPNAY/MvJJxZQJCEmbhbcJX/yWMLiHjwSUqDAOz3zvwk/9V
	 oBQ4T6ee0X4LiQqchNPIQGwePF3CkhOARYQZKlRMsMm9qZtYiDfNd2khzqG0Ryu1Bi
	 ZUZidRTRUV1RuYp29g3/ZsNGWgRYnxJBKffBiBWfun6YfEs52jyOyy9PuGC5j7vYsJ
	 M3TEs9nkm1nqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] media: s5p-mfc: constify pointers to s5p_mfc_cmd_args
Date: Fri, 17 Oct 2025 10:32:07 -0400
Message-ID: <20251017143208.3997488-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017143208.3997488-1-sashal@kernel.org>
References: <2025101646-unfunded-bootlace-0264@gregkh>
 <20251017143208.3997488-1-sashal@kernel.org>
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


