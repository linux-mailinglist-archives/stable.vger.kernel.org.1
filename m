Return-Path: <stable+bounces-54938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C67913B5F
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 15:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F1EB281E44
	for <lists+stable@lfdr.de>; Sun, 23 Jun 2024 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D91419AA64;
	Sun, 23 Jun 2024 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD8p4s6r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD90819AA53;
	Sun, 23 Jun 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150330; cv=none; b=NqVdtiXXbjo40aW1DShzgvHvann+DZoOwRfL7FPKFAlCaB1B7YKMZkfdte1exxDPjIo7DGHgOQkdtc0Wu4CPnVZ8Q2zL7gAGyhQSqSzom/Ytyz2M15gUs14akEnOYjHp5MTTbdpnWf2PwR9oqHm5oO+cQ2G8JbrmMOethHmXgjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150330; c=relaxed/simple;
	bh=X1iC3sddQmVWeyzVFvUszlUmeUuSju0drVTWCbktHoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz8VO7b055luDkhto2aaPeNkmeCmrJs0Yh8KStgUqqWhsbH+BrMcV2CLwct7fr5G0tq95sBN2MH/PXAPm6xh5J2b/HS8U+PN5w9+aIRpZAeg7L7z1P2W369lminub6Gig/ioIPcE7SH2ru7AImHeeElBshZCpTvIjhoJQGR5aiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD8p4s6r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C83C2BD10;
	Sun, 23 Jun 2024 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150330;
	bh=X1iC3sddQmVWeyzVFvUszlUmeUuSju0drVTWCbktHoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gD8p4s6rFUUt+77xBQsfGHBbwVOIJkHGRZZJ7I0eg30JGElaY7bQc+sVqV5e9PVKh
	 HkuXV2QTa6KHTIOuBorOoLVabFDiYuu240cXf8IS3cgBPqQ985gjS3x6u1CYKCutmY
	 RMliIMIBZx8P3Y0swiO3Oc26/wgEjpgQ7phuQepUcc2dpq7/Une6A/yq3htKGPYGa+
	 DtOoPXHliby+2buRFeRJyItJt9TuWO5pi7q7blWP9lI47H4bHhYU1kHIIvgQ+DxFho
	 Gs01womoKUh3j+DoQMVrrh208WLwnrE7F0zfTnRaEYEqve8kGDSudCDYei9ZniaIOj
	 04wlHo1Wj90pQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 08/12] mei: demote client disconnect warning on suspend to debug
Date: Sun, 23 Jun 2024 09:45:11 -0400
Message-ID: <20240623134518.809802-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134518.809802-1-sashal@kernel.org>
References: <20240623134518.809802-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.95
Content-Transfer-Encoding: 8bit

From: Alexander Usyskin <alexander.usyskin@intel.com>

[ Upstream commit 1db5322b7e6b58e1b304ce69a50e9dca798ca95b ]

Change level for the "not connected" client message in the write
callback from error to debug.

The MEI driver currently disconnects all clients upon system suspend.
This behavior is by design and user-space applications with
open connections before the suspend are expected to handle errors upon
resume, by reopening their handles, reconnecting,
and retrying their operations.

However, the current driver implementation logs an error message every
time a write operation is attempted on a disconnected client.
Since this is a normal and expected flow after system resume
logging this as an error can be misleading.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20240530091415.725247-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 930887e7e38d6..615fafb0366a8 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -327,7 +327,7 @@ static ssize_t mei_write(struct file *file, const char __user *ubuf,
 	}
 
 	if (!mei_cl_is_connected(cl)) {
-		cl_err(dev, cl, "is not connected");
+		cl_dbg(dev, cl, "is not connected");
 		rets = -ENODEV;
 		goto out;
 	}
-- 
2.43.0


