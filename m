Return-Path: <stable+bounces-160784-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B709CAFD1DD
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A484879F8
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ECF2E4985;
	Tue,  8 Jul 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jmWXu8y+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECEA23A98D;
	Tue,  8 Jul 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992680; cv=none; b=BnBbRg6rsGPl/4CSnw//1NeWdZ4mMpf7ECUc0eD6S2PwII/8IVL7wNx51X8AUL1fKTwEm9wkAnyG4xPT8LNZQGJ0ZRyQ0HZjKKbHyxLi8obd37vj2z3O6Q9vKGQB/Op3K1Z1FkdYUGGm5uvIrCzJ+YKyAshPZrAjFcsVVa39Cvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992680; c=relaxed/simple;
	bh=1gzgBq5UH7IZbIWr9wom04cDVwT2VEWa1KAnqIMwFPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dlFvFVySsBX0aC2VGz7HDyqmDMlkpVCY93XHbbdLSfoao7mZB264rgig+HvRHBpnzY4inE/zZ1ldenqMYHZEjts2t3d8pXn0h0uyOUUWOLhSxRr9/5UvP96KRipRMDcoaVGjseK461dRpdxmKDgAXO+PQZPjBDLP6uG20UXAijk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jmWXu8y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D36AC4CEED;
	Tue,  8 Jul 2025 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992679;
	bh=1gzgBq5UH7IZbIWr9wom04cDVwT2VEWa1KAnqIMwFPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jmWXu8y+NZ1VZFtZFnizxcqczHfhlcuJ5NACKFVpJ6GF3G5qTQvyvu23Fjepa7xrn
	 CP3KWjDfVF+TLEY0z9HRcxEwrjuHhjNK3Wms14CXkRdeI4dogeNKXH0gRw8g/RrvCV
	 YznW7Kw81DDf5TgVWptri0NHql0cFSLoYDGF4v9w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	David Thompson <davthompson@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 044/232] platform/mellanox: mlxbf-pmc: Fix duplicate event ID for CACHE_DATA1
Date: Tue,  8 Jul 2025 18:20:40 +0200
Message-ID: <20250708162242.615823145@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit 173bbec6693f3f3f00dac144f3aa0cd62fb60d33 ]

same ID (103) was assigned to both GDC_BANK0_G_RSE_PIPE_CACHE_DATA0
and GDC_BANK0_G_RSE_PIPE_CACHE_DATA1. This could lead to incorrect
event mapping.
Updated the ID to 104 to ensure uniqueness.

Fixes: 423c3361855c ("platform/mellanox: mlxbf-pmc: Add support for BlueField-3")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: David Thompson <davthompson@nvidia.com>
Link: https://lore.kernel.org/r/20250619060502.3594350-1-alok.a.tiwari@oracle.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlxbf-pmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/mlxbf-pmc.c b/drivers/platform/mellanox/mlxbf-pmc.c
index 9ff7b487dc489..fbb8128d19de4 100644
--- a/drivers/platform/mellanox/mlxbf-pmc.c
+++ b/drivers/platform/mellanox/mlxbf-pmc.c
@@ -710,7 +710,7 @@ static const struct mlxbf_pmc_events mlxbf_pmc_llt_events[] = {
 	{101, "GDC_BANK0_HIT_DCL_PARTIAL"},
 	{102, "GDC_BANK0_EVICT_DCL"},
 	{103, "GDC_BANK0_G_RSE_PIPE_CACHE_DATA0"},
-	{103, "GDC_BANK0_G_RSE_PIPE_CACHE_DATA1"},
+	{104, "GDC_BANK0_G_RSE_PIPE_CACHE_DATA1"},
 	{105, "GDC_BANK0_ARB_STRB"},
 	{106, "GDC_BANK0_ARB_WAIT"},
 	{107, "GDC_BANK0_GGA_STRB"},
-- 
2.39.5




