Return-Path: <stable+bounces-88763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA879B2764
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332F3283B0A
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152118DF80;
	Mon, 28 Oct 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eu2hTdoy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E77E1DFFD;
	Mon, 28 Oct 2024 06:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730098068; cv=none; b=eZSrAAGS/wFfIIIcf4aICmbKZ08Zb22QXJpdLWv12M1H3T6uYwugdywgAsLhvt2miXehV9tf+ZCGs/ljj8KARUpbeb9qheaX4syAI7su5XAQl3Tqx37WHDhM6fL/LmYnXC9a1sUUlmFG/Uq5b6QjKL5xC6sJ+Lh+VFsHIsifckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730098068; c=relaxed/simple;
	bh=2Bxy0KzWRLTuYf6fZvKKxIeb3Tjp08r8ZEt4lxqVtF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KA/HmNcI1g87XXAesMPZTuMyHAcSUSHEFn8Zd/avJr91fTZfcK/zO/e7LPWvygK7277PG2nn20jeQcvfr/JXr7vhk7FzGVRsJVoH/qnrI+hznp9XmhVyGu4Sj1thjKhP8EMQVGHXXfoOStqrQnYrjMEvhAZXt8oxSWrSJ+aHoTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eu2hTdoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45CDC4CEC3;
	Mon, 28 Oct 2024 06:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730098068;
	bh=2Bxy0KzWRLTuYf6fZvKKxIeb3Tjp08r8ZEt4lxqVtF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eu2hTdoyN7esM1CKJrbAaWdFP6xa+jn7dVLevhRQvKhrgRE5TZm+XTfojBv+I6eRw
	 c/lr6zpB0RW9XHmc9VJTGwXlyidzt1K1ful7tmOLkohOD08rEJEOPhvxMmmotLcRGp
	 EYJAMxSA84Nl31kqZJ+VpQ+DxAj4d6MFK/R5iBgg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ian Forbes <ian.forbes@broadcom.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Martin Krastev <martin.krastev@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 026/261] drm/vmwgfx: Handle possible ENOMEM in vmw_stdu_connector_atomic_check
Date: Mon, 28 Oct 2024 07:22:48 +0100
Message-ID: <20241028062312.672744901@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062312.001273460@linuxfoundation.org>
References: <20241028062312.001273460@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Forbes <ian.forbes@broadcom.com>

[ Upstream commit 4809a017a2bc42ff239d53ade4b2e70f2fe81348 ]

Handle unlikely ENOMEN condition and other errors in
vmw_stdu_connector_atomic_check.

Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: 75c3e8a26a35 ("drm/vmwgfx: Trigger a modeset when the screen moves")
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Martin Krastev <martin.krastev@broadcom.com>
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240809183756.27283-1-ian.forbes@broadcom.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index fab155a68054a..82d18b88f4a7e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -886,6 +886,10 @@ static int vmw_stdu_connector_atomic_check(struct drm_connector *conn,
 	struct drm_crtc_state *new_crtc_state;
 
 	conn_state = drm_atomic_get_connector_state(state, conn);
+
+	if (IS_ERR(conn_state))
+		return PTR_ERR(conn_state);
+
 	du = vmw_connector_to_stdu(conn);
 
 	if (!conn_state->crtc)
-- 
2.43.0




