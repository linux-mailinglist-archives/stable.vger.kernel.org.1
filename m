Return-Path: <stable+bounces-51012-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FED906DEC
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51263B2635C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD2146D45;
	Thu, 13 Jun 2024 12:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vPB1XiPY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84DC146D59;
	Thu, 13 Jun 2024 12:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280047; cv=none; b=S+0DpkHKU1RW5ZCBSM9C3+YVEN6+fbTSvB8DZmY6zBYQN5/AE1v8Uh1HqzzVwXPrK1SXK+G9gumApPe+DaCbheU7lwWSGkHWdL/XKlnHlyyBx9UE6lWBkTi1irwGX7PgcZHVFkD17lChtwAvrFTuW63v0jolLSioMakNgbSvbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280047; c=relaxed/simple;
	bh=mr+9tApAAlOZjMaf+GhTPpqJfSLO1DzcXIfGbRkuvVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nyf6aoSf0OkZCG5AXN2bsBdKZEJvpVuEj4huaEPjBV44qzSlzV4OL3SbAsmHWYwcPzFLcc1OiAU2vQYMvfzPhjDsKfd73ocD8sPkl4WBvb6U6kDwg9lXJJ2moQeFiWj/fm+pgC0XcyleUliU54vGnttXzy7yDH1h1ctD+eseep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vPB1XiPY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BD9C32786;
	Thu, 13 Jun 2024 12:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280047;
	bh=mr+9tApAAlOZjMaf+GhTPpqJfSLO1DzcXIfGbRkuvVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vPB1XiPY+rT2bx1UBAhw3evk+HQGrHaMjqP2gZOD26WnnzRPjVMEXfyb5g1fJadLc
	 parLFHqYqAYU1yC7VG9In0nuB1WtpPdyJXTiIltIaFq5mIomRM4ydftaF/DJA2KxzH
	 fnXBU54lGHTOmpUcMfiRbB482t9kIzCZkhEBs/4w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Alex Elder <elder@ieee.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 094/202] greybus: lights: check return of get_channel_from_mode
Date: Thu, 13 Jun 2024 13:33:12 +0200
Message-ID: <20240613113231.397365204@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

From: Rui Miguel Silva <rmfrfs@gmail.com>

[ Upstream commit a1ba19a1ae7cd1e324685ded4ab563e78fe68648 ]

If channel for the given node is not found we return null from
get_channel_from_mode. Make sure we validate the return pointer
before using it in two of the missing places.

This was originally reported in [0]:
Found by Linux Verification Center (linuxtesting.org) with SVACE.

[0] https://lore.kernel.org/all/20240301190425.120605-1-m.lobanov@rosalinux.ru

Fixes: 2870b52bae4c ("greybus: lights: add lights implementation")
Reported-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Suggested-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Suggested-by: Alex Elder <elder@ieee.org>
Signed-off-by: Rui Miguel Silva <rmfrfs@gmail.com>
Link: https://lore.kernel.org/r/20240325221549.2185265-1-rmfrfs@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/greybus/light.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/light.c b/drivers/staging/greybus/light.c
index e59bb27236b9f..7352d7deb8ba0 100644
--- a/drivers/staging/greybus/light.c
+++ b/drivers/staging/greybus/light.c
@@ -147,6 +147,9 @@ static int __gb_lights_flash_brightness_set(struct gb_channel *channel)
 		channel = get_channel_from_mode(channel->light,
 						GB_CHANNEL_MODE_TORCH);
 
+	if (!channel)
+		return -EINVAL;
+
 	/* For not flash we need to convert brightness to intensity */
 	intensity = channel->intensity_uA.min +
 			(channel->intensity_uA.step * channel->led->brightness);
@@ -550,7 +553,10 @@ static int gb_lights_light_v4l2_register(struct gb_light *light)
 	}
 
 	channel_flash = get_channel_from_mode(light, GB_CHANNEL_MODE_FLASH);
-	WARN_ON(!channel_flash);
+	if (!channel_flash) {
+		dev_err(dev, "failed to get flash channel from mode\n");
+		return -EINVAL;
+	}
 
 	fled = &channel_flash->fled;
 
-- 
2.43.0




