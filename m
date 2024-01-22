Return-Path: <stable+bounces-13089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9396B837B3D
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0918B2D5AF
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 00:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA912CDA7;
	Tue, 23 Jan 2024 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gExWwxfw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249712CDA3;
	Tue, 23 Jan 2024 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705968962; cv=none; b=OgUoQAqBi3pEVzVqsPaU7MpiEOqdb53ln6n02sHpJIf230usMsKWou8M2i8m0GHksjUR4eS8AuMn4WFyjC3aq7+YC9jaohvhCxK8S5BEpVbmcJmkE9UtAboLcuz2lH9ezkZp0CQ/1IPtGy6Vsm3cTagx225TrxD6F5S+FVwcrZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705968962; c=relaxed/simple;
	bh=kSuf6m6gQz5IDHApD7370nNmPGPaYFolgHVk2V3lKhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc/q5FkPJqp64JxJrj4dcm4WGLx4BmS8SbEE9gfJkzN9F9vzkbwdJhhx4fJafdRnK8kJeBK/GLHTMcFesCrunxIVAWHbbu739T0L7Ln7+vZ96AhOTxGS7qQsu7WLYVs1vU6y8KG4wmYF5TLQgzSmk7SJTJkezvfQxP2Z/T86zsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gExWwxfw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4373C433C7;
	Tue, 23 Jan 2024 00:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705968962;
	bh=kSuf6m6gQz5IDHApD7370nNmPGPaYFolgHVk2V3lKhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gExWwxfwgNJoQ7qs7ZokL+kNNIYJn7o0TaslnVdQJo0IPPSQXLYS229t7nbv8GIVn
	 +4+PesFcwHyXFlKaGXUjgcced9oLhrPWjH5xrWeWxMgUCleJnHGno1xN3GrLXSfM0M
	 OuC6RtSYpnw1DZy50u6lt2KF0UlqJEj1mygQgcPw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maxime Ripard <mripard@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 124/194] drm/bridge: tc358767: Fix return value on error case
Date: Mon, 22 Jan 2024 15:57:34 -0800
Message-ID: <20240122235724.552333723@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235719.206965081@linuxfoundation.org>
References: <20240122235719.206965081@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 32bd29b619638256c5b75fb021d6d9f12fc4a984 ]

If the hpd_pin is invalid, the driver returns 'ret'. But 'ret' contains
0, instead of an error value.

Return -EINVAL instead.

Fixes: f25ee5017e4f ("drm/bridge: tc358767: add IRQ and HPD support")
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231103-uninit-fixes-v2-4-c22b2444f5f5@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 0454675a44cb..a58943115241 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1574,7 +1574,7 @@ static int tc_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	} else {
 		if (tc->hpd_pin < 0 || tc->hpd_pin > 1) {
 			dev_err(dev, "failed to parse HPD number\n");
-			return ret;
+			return -EINVAL;
 		}
 	}
 
-- 
2.43.0




