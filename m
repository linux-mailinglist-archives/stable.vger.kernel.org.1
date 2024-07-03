Return-Path: <stable+bounces-57643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1C925D58
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDDD1F216FE
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C71181312;
	Wed,  3 Jul 2024 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OilT06q5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642E0181308;
	Wed,  3 Jul 2024 11:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005499; cv=none; b=O57ftn1E6xef12saqTJS4RkR46cIERRJGY78VkN/2lH12Hjxr9w7LaAlpGF4naRzTbkUfy429/qutTBz4BKuwfdSpW9/XL5Xb034OFMYAYx4UjcHvXk5ze+r1ZHXptzgs+c3cSfLZf/lQFJKM6XpJ5Dpl+h0RLZTSl7yzEwHTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005499; c=relaxed/simple;
	bh=DybWm2nm2Hax/t5OD16dgZHMyxl0ExQZ/dvR3XjvtZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBp0FpQaHrflgDwtiTJnXiWbMCSsL4i6fB2e+Vz4AdyX34WS4vZy3Bdh/H/DisLatcU7uro4tRN4L999NfobYm5p3FiYBZGfeGiP8oelSXw/tyWLk/c3yOatItCk6+J/UP0SOirbx4OOkJJ/RzvrVxNSqYkuC84DE9x81PgBXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OilT06q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8FFC2BD10;
	Wed,  3 Jul 2024 11:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720005499;
	bh=DybWm2nm2Hax/t5OD16dgZHMyxl0ExQZ/dvR3XjvtZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OilT06q531ChhopB3aaFbUSvfNvtTlBSdjpSHH6HwxYHDyTi/fEiVMN264VmKOPUb
	 iTsHwk5m9pibl0m+uWE+jY8+UWyOhUhQlcFVmBeoLnAibqn29HZN0TN3x+HXbCHSQ1
	 Jove5UWv4EPo+b2FmvBgX0bNWswbhKVXj5/xwYig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 101/356] drm/komeda: check for error-valued pointer
Date: Wed,  3 Jul 2024 12:37:17 +0200
Message-ID: <20240703102916.923752679@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102913.093882413@linuxfoundation.org>
References: <20240703102913.093882413@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>

[ Upstream commit b880018edd3a577e50366338194dee9b899947e0 ]

komeda_pipeline_get_state() may return an error-valued pointer, thus
check the pointer for negative or null value before dereferencing.

Fixes: 502932a03fce ("drm/komeda: Add the initial scaler support for CORE")
Signed-off-by: Amjad Ouled-Ameur <amjad.ouled-ameur@arm.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240610102056.40406-1-amjad.ouled-ameur@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index 88b58153f9d66..c956fda918beb 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -259,7 +259,7 @@ komeda_component_get_avail_scaler(struct komeda_component *c,
 	u32 avail_scalers;
 
 	pipe_st = komeda_pipeline_get_state(c->pipeline, state);
-	if (!pipe_st)
+	if (IS_ERR_OR_NULL(pipe_st))
 		return NULL;
 
 	avail_scalers = (pipe_st->active_comps & KOMEDA_PIPELINE_SCALERS) ^
-- 
2.43.0




