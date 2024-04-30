Return-Path: <stable+bounces-42673-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE48B7417
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 13:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9D341F21557
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 11:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C21D12CDAE;
	Tue, 30 Apr 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mUlL5hs5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B68D17592;
	Tue, 30 Apr 2024 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476416; cv=none; b=NnRyj2qCW9qgofF/Qz29tEgKe2Zwfy6bZ+AFqk8aVdwKCu3L/YftF4NqKcUWMkYcVuPONROntnY6GFQEdmgxXNT0DgSMtNwtSNoR2DfTsJa1oPd/ZlVPIFDhvtnWHwhUtgn+XPSaXPbHTgl7xDkUkG7GGhamWXs9SQJaTebbkAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476416; c=relaxed/simple;
	bh=IrdqwWEqcGkEZPDr/zACjrltGCO1brGw4QjoCDloe5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p92g9eo0Lhn/SFfUowQGV93/g5WbHejTrh87Ema2yMDdLY3/dxgq5HJmYMX/0zyJ1XoZJLjD7d0aVmZr6bJeq6/KzwX3phcbLsA6SaLYsG+uIziUJvsy7WtENrRvh+pM1Ik6FiAc/KI7aYP5/OczZLivPKDbG18jod300q6iMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mUlL5hs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716E1C4AF19;
	Tue, 30 Apr 2024 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714476415;
	bh=IrdqwWEqcGkEZPDr/zACjrltGCO1brGw4QjoCDloe5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUlL5hs58/SGh0MNnkfkwZubCf883gzLMDyOSy5SnC7G9J7Oo6hiazhdsHbXuTdj+
	 LI6rm2XQj54XIafYWOGlCMh8yk00ua5GkiaSjqF18wnAJBpgX9wIqh4VC6cH623/Jf
	 VKUhzYwyA0HUrW2i/iFDyGpo6aSv100FPzvwddt0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiri Pirko <jiri@resnulli.us>,
	Amit Cohen <amcohen@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 026/110] mlxsw: core: Unregister EMAD trap using FORWARD action
Date: Tue, 30 Apr 2024 12:39:55 +0200
Message-ID: <20240430103048.341744238@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
References: <20240430103047.561802595@linuxfoundation.org>
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

From: Ido Schimmel <idosch@nvidia.com>

[ Upstream commit 976c44af48141cd8595601c0af2a19a43c5b228b ]

The device's manual (PRM - Programmer's Reference Manual) classifies the
trap that is used to deliver EMAD responses as an "event trap". Among
other things, it means that the only actions that can be associated with
the trap are TRAP and FORWARD (NOP).

Currently, during driver de-initialization the driver unregisters the
trap by setting its action to DISCARD, which violates the above
guideline. Future firmware versions will prevent such misuses by
returning an error. This does not prevent the driver from working, but
an error will be printed to the kernel log during module removal /
devlink reload:

mlxsw_spectrum 0000:03:00.0: Reg cmd access status failed (status=7(bad parameter))
mlxsw_spectrum 0000:03:00.0: Reg cmd access failed (reg_id=7003(hpkt),type=write)

Suppress the error message by aligning the driver to the manual and use
a FORWARD (NOP) action when unregistering the trap.

Fixes: 4ec14b7634b2 ("mlxsw: Add interface to access registers and process events")
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Link: https://lore.kernel.org/r/753a89e14008fde08cb4a2c1e5f537b81d8eb2d6.1713446092.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core.c b/drivers/net/ethernet/mellanox/mlxsw/core.c
index e2a985ec2c765..f36a416ffcfe9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core.c
@@ -792,7 +792,7 @@ static void mlxsw_emad_rx_listener_func(struct sk_buff *skb, u16 local_port,
 
 static const struct mlxsw_listener mlxsw_emad_rx_listener =
 	MLXSW_RXL(mlxsw_emad_rx_listener_func, ETHEMAD, TRAP_TO_CPU, false,
-		  EMAD, DISCARD);
+		  EMAD, FORWARD);
 
 static int mlxsw_emad_init(struct mlxsw_core *mlxsw_core)
 {
-- 
2.43.0




