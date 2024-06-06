Return-Path: <stable+bounces-49177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2171E8FEC31
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA57A1F2998C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D4B1AD9FD;
	Thu,  6 Jun 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IiBdbAM/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92446198858;
	Thu,  6 Jun 2024 14:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683339; cv=none; b=esivL1X96mdDsPxQGmguLKJ4ULsl0vucdtgOIYN1HwvKNtEpXwMlBvOvXJUFbnGxa8xDwI9+g5m4QY9XmOTEeqnJGL/68mSgKqUpj1jjo6boWpjVkpEVvZReLpWMCg0jAEt2V2m55AYH1BjxAOx/XPn+D0b22IXvRsoo2DbyEPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683339; c=relaxed/simple;
	bh=EulsvdkFI9ToXBiBeJ2Xn+NRhJS7KmAcwqnaoGlRlRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ST+HJGPjXwuHtk4uUiJh8RJj/GJc5gB0aEw8/Y9xhGMKbd49P7tsz3OQZUKuANADqzopaNSFB3Hm9cQTQjxr9rvYzIENiGP6X8uDaxWQFboS10Rbq/5hTF6r9c+qaIdJ9edhSanglkkZSsAg4+No6OihUq27F2X7j7kN25j9v7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IiBdbAM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F29BC2BD10;
	Thu,  6 Jun 2024 14:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683339;
	bh=EulsvdkFI9ToXBiBeJ2Xn+NRhJS7KmAcwqnaoGlRlRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IiBdbAM/7CMDyskdKTBXplxekhP1zL0pje+/3YCnBftv4o9pGGRYQKHGHMyoZSAam
	 SYR0ae1x7e6PtKib5W7Sl6ejsT+uBxBXdF6MkUUWvT2uBqiwOWuWvbJ5lro7snPb+9
	 P3go0oU45HQEaNrcb+/v3rPtYcoDowWU6sdSni0E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Huai-Yuan Liu <qq810974084@gmail.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 221/473] drm/arm/malidp: fix a possible null pointer dereference
Date: Thu,  6 Jun 2024 16:02:30 +0200
Message-ID: <20240606131707.196581778@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131659.786180261@linuxfoundation.org>
References: <20240606131659.786180261@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Huai-Yuan Liu <qq810974084@gmail.com>

[ Upstream commit a1f95aede6285dba6dd036d907196f35ae3a11ea ]

In malidp_mw_connector_reset, new memory is allocated with kzalloc, but
no check is performed. In order to prevent null pointer dereferencing,
ensure that mw_state is checked before calling
__drm_atomic_helper_connector_reset.

Fixes: 8cbc5caf36ef ("drm: mali-dp: Add writeback connector")
Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240407063053.5481-1-qq810974084@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/arm/malidp_mw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index ef76d0e6ee2fc..389d32994135b 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -72,7 +72,10 @@ static void malidp_mw_connector_reset(struct drm_connector *connector)
 		__drm_atomic_helper_connector_destroy_state(connector->state);
 
 	kfree(connector->state);
-	__drm_atomic_helper_connector_reset(connector, &mw_state->base);
+	connector->state = NULL;
+
+	if (mw_state)
+		__drm_atomic_helper_connector_reset(connector, &mw_state->base);
 }
 
 static enum drm_connector_status
-- 
2.43.0




