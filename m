Return-Path: <stable+bounces-161055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFB0AFD32C
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7204A587B
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7425314A60D;
	Tue,  8 Jul 2025 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UveOoyKO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B62E54C4;
	Tue,  8 Jul 2025 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993466; cv=none; b=PyZPC6rTmZNyjXZW/oGlSstUFR8BgRXXJizuMbQDfz5L+IpdeyVl8M4LFpEdoAAtIT2Or+SBN9TTOq7owWReb6GXcKnst9ryeHhSmf3/VZV9evOoLAhKkOBZuG7alsfRycjAmF1rQtPaDCdnwpK/S854WE2aQnhyXfhpHBLoG04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993466; c=relaxed/simple;
	bh=Q1kS5/3k/2k+0FC2BeDDz17/vnXk1SpoqkFOLHzSr3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRDukbWc4N7ajQBKy+xT49N16Khl+9VWvhaf5HqdtuEgWk7BFAYxOdu9JZNR+4icunjjDahvnTW8pZu/22K8F1SgOaaBWtBHgXuCIr5wBRAnTqhfOsPU4d3oi6HaSJBjHu/gIrsO7tRgTHWbjAKcc0aA/3z6RyAlEGA9FZiaKQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UveOoyKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5B3C4CEF0;
	Tue,  8 Jul 2025 16:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993466;
	bh=Q1kS5/3k/2k+0FC2BeDDz17/vnXk1SpoqkFOLHzSr3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UveOoyKODrrb/Foh29JIBb7P5Yc8k/7BgeebZl9yTXi1lP1LnKju/j9zp7t6b4iKO
	 3wQdOnTdxajTBj8rl2MZDAc9amzdzaaOVpzr9KpDLkn5cFInv4JKmCHI8Q8UY9Vj/p
	 8yfU+G4RUWbuRQ49wYKOt4sYGpau+aDF0YSMH6Xs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vadim Pasternak <vadimp@nvidia.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 084/178] platform/mellanox: mlxreg-lc: Fix logic error in power state check
Date: Tue,  8 Jul 2025 18:22:01 +0200
Message-ID: <20250708162238.874830982@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit 644bec18e705ca41d444053407419a21832fcb2f ]

Fixes a logic issue in mlxreg_lc_completion_notify() where the
intention was to check if MLXREG_LC_POWERED flag is not set before
powering on the device.

The original code used "state & ~MLXREG_LC_POWERED" to check for the
absence of the POWERED bit. However this condition evaluates to true
even when other bits are set, leading to potentially incorrect
behavior.

Corrected the logic to explicitly check for the absence of
MLXREG_LC_POWERED using !(state & MLXREG_LC_POWERED).

Fixes: 62f9529b8d5c ("platform/mellanox: mlxreg-lc: Add initial support for Nvidia line card devices")
Suggested-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Link: https://lore.kernel.org/r/20250630105812.601014-1-alok.a.tiwari@oracle.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxreg-lc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/mlxreg-lc.c b/drivers/platform/mellanox/mlxreg-lc.c
index aee395bb48ae4..8681ceb7144ba 100644
--- a/drivers/platform/mellanox/mlxreg-lc.c
+++ b/drivers/platform/mellanox/mlxreg-lc.c
@@ -688,7 +688,7 @@ static int mlxreg_lc_completion_notify(void *handle, struct i2c_adapter *parent,
 	if (regval & mlxreg_lc->data->mask) {
 		mlxreg_lc->state |= MLXREG_LC_SYNCED;
 		mlxreg_lc_state_update_locked(mlxreg_lc, MLXREG_LC_SYNCED, 1);
-		if (mlxreg_lc->state & ~MLXREG_LC_POWERED) {
+		if (!(mlxreg_lc->state & MLXREG_LC_POWERED)) {
 			err = mlxreg_lc_power_on_off(mlxreg_lc, 1);
 			if (err)
 				goto mlxreg_lc_regmap_power_on_off_fail;
-- 
2.39.5




