Return-Path: <stable+bounces-208739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0396D26641
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F396F301869B
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D63BF2E0;
	Thu, 15 Jan 2026 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="onm+Cw5r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0FF3BC4D7;
	Thu, 15 Jan 2026 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496708; cv=none; b=igP7ExK8eHhd6mNjJrULd25oBbUS7sJA3MSLBD37eCYnpyI+oyZ3dqJhpm2M8XpbqcMp0efWfG70aXY8XRmmhCY9wR4t4shAZGOMgnnUno5OY4QSHjCij2bdOrMou8S0R81l0KBL+R6xZH8Qu7Q+qgQR//sd3kSeCoZLX05cB5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496708; c=relaxed/simple;
	bh=kcHu9XGAbzoFuXHb+eiQzxUXC7SR0PDNqI23KhfLYP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E36g3f8QYWuXqZSs3LWuxCyDeItW8CVGQiD4d8Qq5XMpsTBywdVi8awvqxAmASgUZh4n/t/8/B3f2C0cyzxNpC5Hvp5hoPtkXrX5wFNMZ9+Zqz65crjrfrZeF1DLBTEhrr2CsO2d4VnIaID9WQ1WbBAghzS2n53jgUQAWr0G2ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=onm+Cw5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50F8C116D0;
	Thu, 15 Jan 2026 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768496708;
	bh=kcHu9XGAbzoFuXHb+eiQzxUXC7SR0PDNqI23KhfLYP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=onm+Cw5rJk5IUD5HiIcJdd/Vk/oUbXCB99hwMfqmIK0xU7UWy5nnBgFLf+vJ4hOGS
	 pLEzl4l4yerkhPR/zNYBiIYeco9db74DO26DYcK0RC6Jb6IH0sp0Xtg7JT8GbHwL2E
	 U211aeqg4JkRPGIjczv25hOQvyvpCgYL2vrGXTUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Elad Nachman <enachman@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 064/119] net: marvell: prestera: fix NULL dereference on devlink_alloc() failure
Date: Thu, 15 Jan 2026 17:47:59 +0100
Message-ID: <20260115164154.265594190@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164151.948839306@linuxfoundation.org>
References: <20260115164151.948839306@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit a428e0da1248c353557970848994f35fd3f005e2 ]

devlink_alloc() may return NULL on allocation failure, but
prestera_devlink_alloc() unconditionally calls devlink_priv() on
the returned pointer.

This leads to a NULL pointer dereference if devlink allocation fails.
Add a check for a NULL devlink pointer and return NULL early to avoid
the crash.

Fixes: 34dd1710f5a3 ("net: marvell: prestera: Add basic devlink support")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Acked-by: Elad Nachman <enachman@marvell.com>
Link: https://patch.msgid.link/20251230052124.897012-1-alok.a.tiwari@oracle.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/prestera/prestera_devlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
index 2a4c9df4eb797..e63d95c1842f3 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_devlink.c
@@ -387,6 +387,8 @@ struct prestera_switch *prestera_devlink_alloc(struct prestera_device *dev)
 
 	dl = devlink_alloc(&prestera_dl_ops, sizeof(struct prestera_switch),
 			   dev->dev);
+	if (!dl)
+		return NULL;
 
 	return devlink_priv(dl);
 }
-- 
2.51.0




