Return-Path: <stable+bounces-181062-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444DBB92D0D
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 21:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97242A5BC2
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 19:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BA025F780;
	Mon, 22 Sep 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ScOur/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734A9C8E6;
	Mon, 22 Sep 2025 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758569594; cv=none; b=cxT9DiqGwHKt5HfrRbpvD4DO7XICiSWuqAnIfF3u8STj9FMHc2LzoTBYI1FQ1XX7thQ7DNFZso5ZzEf0CrNUAsHG/7wGbx59E6tNgnn4jjbB027iHPaTVe6MprEhr+kGjK33IkEdnx7SynWWg/gS/UMJBAjL7jscrSeuR5E3pM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758569594; c=relaxed/simple;
	bh=rEofYuHiVp4aT1zObbtngoEfsMEYK5lGMoYKnnvHbk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8ZyhhRXDdhHRfUCemgRwNO3rEB6LhOVPJNjdhkf0QqC33dGMbcVsrgwS+uzXVHCrdsc9Vy5xK+dV4WAb3zj1AMvrA80JF6gIXpUwuq1F9ATjbLg/HEfKsp4c7QAEyqX2abmzUgnalY53v/evfLL0cXOftu1aHnJuZIF2p0nCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ScOur/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA6AC4CEF0;
	Mon, 22 Sep 2025 19:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758569594;
	bh=rEofYuHiVp4aT1zObbtngoEfsMEYK5lGMoYKnnvHbk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ScOur/cbyuCsrKl9g8U7aMx0qp2q63FASe7zc/UG8vAVGL73YkMaEWrN56rVjL73
	 fSLBvcH4tLCtO8fE5QsUsRkZU+ZGh1KGvGm/lxydo/yesiG/i/+UiEeEB9mTbm1c5P
	 AThyGe8GAYghBERPJJp0MUxOiJWXPt3bnFmLhNsw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hulk Robot <hulkci@huawei.com>,
	Qi Xi <xiqi2@huawei.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 42/61] drm: bridge: cdns-mhdp8546: Fix missing mutex unlock on error path
Date: Mon, 22 Sep 2025 21:29:35 +0200
Message-ID: <20250922192404.734071508@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922192403.524848428@linuxfoundation.org>
References: <20250922192403.524848428@linuxfoundation.org>
User-Agent: quilt/0.68
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

From: Qi Xi <xiqi2@huawei.com>

[ Upstream commit 288dac9fb6084330d968459c750c838fd06e10e6 ]

Add missing mutex unlock before returning from the error path in
cdns_mhdp_atomic_enable().

Fixes: 935a92a1c400 ("drm: bridge: cdns-mhdp8546: Fix possible null pointer dereference")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qi Xi <xiqi2@huawei.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20250904034447.665427-1-xiqi2@huawei.com
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 1b7c14d7c5ee3..aaa9f44d27be5 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2042,8 +2042,10 @@ static void cdns_mhdp_atomic_enable(struct drm_bridge *bridge,
 	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
 
 	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
-	if (!mhdp_state->current_mode)
-		return;
+	if (!mhdp_state->current_mode) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	drm_mode_set_name(mhdp_state->current_mode);
 
-- 
2.51.0




