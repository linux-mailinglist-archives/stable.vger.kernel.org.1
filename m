Return-Path: <stable+bounces-160638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B34DAFD10D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B49486A81
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE7A1D5AC0;
	Tue,  8 Jul 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="trMtvMTS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE108F5B;
	Tue,  8 Jul 2025 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992250; cv=none; b=athQ0CQT1SUBsphmQFbAGtibvKOukcoveTLDvbD63AdbZuP5Iy8UX4PX4gPnxhpZv7OHQbIOD7LNAQFTuFYnpRieZO6HC9CcPYz2ldiPtPYXuf1Hq08PlcndUCXoW6R1fA4EAiXJ5EvGF4EbbWNJDSzOp/mEqSHuKL/kuPb7yKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992250; c=relaxed/simple;
	bh=kTpJvnAea+vJyt7h/Z0FX1xqE0hpC5i+AiIUd/HfCFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edWB7PM0hCHABdFmVqdC8E8CceWFEjQP5874q4wsrHKBv3nrBQbLg8Zzl3lsikQMxrUOd8CN6lSUqy9NGgsiPY9eaDlBx3KBD4Ujh8epKoYqgZ/t1gYhUZt7XdT7+I2Prg3u9XlXxl1GbQQxbA/KtUrKIKvfDrYfcrnInOHgkQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=trMtvMTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9038FC4CEED;
	Tue,  8 Jul 2025 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992249;
	bh=kTpJvnAea+vJyt7h/Z0FX1xqE0hpC5i+AiIUd/HfCFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trMtvMTSLJ/8c3OdLkEPDkEoED9P54kF8AoGNrqOzk3TBuGUaTHYXlczXwxSUUZ28
	 +CNB0PYCndIhuC+YMIm9FTlReUPGtmjdRtL5wmNDfx2eQ0755inGLAzX2gaYDzexEO
	 l9c8xPSZOk46tPeq6dmcmMLJEvNyLbotxVPj1XMM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 029/132] platform/mellanox: nvsw-sn2201: Fix bus number in adapter error message
Date: Tue,  8 Jul 2025 18:22:20 +0200
Message-ID: <20250708162231.562648504@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit d07143b507c51c04c091081627c5a130e9d3c517 ]

change error log to use correct bus number from main_mux_devs
instead of cpld_devs.

Fixes: 662f24826f95 ("platform/mellanox: Add support for new SN2201 system")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Link: https://lore.kernel.org/r/20250622072921.4111552-2-alok.a.tiwari@oracle.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/nvsw-sn2201.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/nvsw-sn2201.c b/drivers/platform/mellanox/nvsw-sn2201.c
index 1a7c45aa41bbf..6b4d3c44d7bd9 100644
--- a/drivers/platform/mellanox/nvsw-sn2201.c
+++ b/drivers/platform/mellanox/nvsw-sn2201.c
@@ -1088,7 +1088,7 @@ static int nvsw_sn2201_i2c_completion_notify(void *handle, int id)
 	if (!nvsw_sn2201->main_mux_devs->adapter) {
 		err = -ENODEV;
 		dev_err(nvsw_sn2201->dev, "Failed to get adapter for bus %d\n",
-			nvsw_sn2201->cpld_devs->nr);
+			nvsw_sn2201->main_mux_devs->nr);
 		goto i2c_get_adapter_main_fail;
 	}
 
-- 
2.39.5




