Return-Path: <stable+bounces-91916-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF219C1AEC
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 11:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90AB11C24DBB
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 10:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0902E1E32A0;
	Fri,  8 Nov 2024 10:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="rkZu10gd"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46E1E284D;
	Fri,  8 Nov 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062557; cv=none; b=AeWkXcKegsvI2wmMjl2fW3L2FoG4Xbv4dqySPTLw6uUckcZkaOHlOnAow/wtjsGmjaup49SSn1FeTU94aFpEIOYR+uAADH32Q9G4+f7snvLys5XBdsyOdlRxS7s9EfM9/DWJ+6KJ8tKWpLoTEqapwGRyAObGkCORUYb51GxP1ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062557; c=relaxed/simple;
	bh=giq0Hsawlky3Ew4bC1V/a7551kCNbW5EcWaq2soaqHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SVJYPDboZyv7LOKRxId5scuvGHHbLa5/xlMCuFKpDDdayjXHue0gLabd48ufyN9uvJQU+Kl4UihqEwmgnG/u6+mv6Rarqq5UgG6qCPIYvY8QhSzsDClRa+05ttsUOILyUQJvnHKO4g4fEjsgoa1uXwh6kOUF4yAb72QKmXGSPuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=rkZu10gd; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.14])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8517C40777C7;
	Fri,  8 Nov 2024 10:42:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8517C40777C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1731062551;
	bh=K7peh/qccz/koCm9bosthYUMrdTm0HUmjIy0yZegWZA=;
	h=From:To:Cc:Subject:Date:From;
	b=rkZu10gdhum3UxfKRfq18BkpYxNYkjCWDbu49eQ+R+2PR3pFq4ycgHbZO1ZBk18yd
	 Cgr0OUoLBKTeUSyLuYApqs/or7O3QA/8ylHbjBDaoiVbT7KZ6FqaKkUSMcbsHvREUL
	 y9Wa8ufZmr5RXnOGdFRAAZXGzF4+xs3yd/1I7w6Y=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Sasha Levin <sashal@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Jonathan Gray <jsg@jsg.id.au>
Subject: [PATCH 6.1 resend] Revert "drm/amd/display: Skip Recompute DSC Params if no Stream on Link"
Date: Fri,  8 Nov 2024 13:42:24 +0300
Message-Id: <20241108104224.504424-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 7c887efda1201110211fed8921a92a713e0b6bcd which is
commit 8151a6c13111b465dbabe07c19f572f7cbd16fef upstream.

It is a duplicate of the change made in 6.1.105 by commit 282f0a482ee6
("drm/amd/display: Skip Recompute DSC Params if no Stream on Link").

This is a consequence of two different upstream commits performing the
exact same change and one of which has been cherry-picked. No point to
keep it in the stable branch.

Found by Linux Verification Center (linuxtesting.org) with Svace static
analysis tool.

Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
Dropped from other stables by Jonathan Gray
https://lore.kernel.org/stable/20241007035711.46624-1-jsg@jsg.id.au/T/#u

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 1acef5f3838f..855cd71f636f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1255,9 +1255,6 @@ static bool is_dsc_need_re_compute(
 		}
 	}
 
-	if (new_stream_on_link_num == 0)
-		return false;
-
 	if (new_stream_on_link_num == 0)
 		return false;
 
-- 
2.39.5


