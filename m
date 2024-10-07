Return-Path: <stable+bounces-81208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D8F99234C
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 05:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B11B1F229AE
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 03:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D3E3A1AC;
	Mon,  7 Oct 2024 03:58:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842038F97
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 03:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.114.144.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273508; cv=none; b=Zut+e4BxSg9jroLL6/LuSiS7JblpZowTDM5YdEFQiKJ+SsfMHiaNCfjukBaHhQWE55e3OlhYxGXvlVEHrsB858sIFWa5cOw3aG1aWfbWNws8Hm/pWDs2XK/yZ/Kk2aUXlZPrNx45dFzAgWVDcS+QuBqEpvEAHCZZvRzVhHgSDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273508; c=relaxed/simple;
	bh=DJXnbLi01DI3TEm10X4JtJ9D8icxEqwaJHuZb1LPcFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzEyaH8n7qncHvfPOLAuw+3X8aQuYxOfzLQll7fyME6Idy9nvHT9LtAg79RwR2lCt4UaRd+87pinnyqmv5LOYazF/UR7UPmnYQeTpWJ64cOqBgDYZ57yBdZDxD16pbEolh2MqlZZ5/3j6iOQgzIfQ+Y7AmEN9CK7QIRPIvSyh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au; spf=pass smtp.mailfrom=jsg.id.au; arc=none smtp.client-ip=193.114.144.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsg.id.au
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.44])
	by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id e716f3ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 14:58:19 +1100 (AEDT)
Received: from largo.jsg.id.au (localhost [127.0.0.1])
	by largo.jsg.id.au (OpenSMTPD) with ESMTP id fc2e3aaf;
	Mon, 7 Oct 2024 14:58:19 +1100 (AEDT)
From: Jonathan Gray <jsg@jsg.id.au>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.10.y] Revert "drm/amd/display: Skip Recompute DSC Params if no Stream on Link"
Date: Mon,  7 Oct 2024 14:58:19 +1100
Message-ID: <20241007035819.12246-1-jsg@jsg.id.au>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 6f9c39e8169384d2a5ca9bf323a0c1b81b3d0f3a.

duplicated a change made in 6.10.5
70275bb960c71d313254473d38c14e7101cee5ad

Cc: stable@vger.kernel.org # 6.10
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 9a6207731416..71695597b7e3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1264,9 +1264,6 @@ static bool is_dsc_need_re_compute(
 		}
 	}
 
-	if (new_stream_on_link_num == 0)
-		return false;
-
 	if (new_stream_on_link_num == 0)
 		return false;
 
-- 
2.46.1


