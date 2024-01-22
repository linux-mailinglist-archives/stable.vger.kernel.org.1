Return-Path: <stable+bounces-13441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F188837C13
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4687C1F2AF67
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007C42C9A;
	Tue, 23 Jan 2024 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TG/LdS11"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CAD2114;
	Tue, 23 Jan 2024 00:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969495; cv=none; b=DQ7pr77s/xLh7f+CuiuDuwsKKdm7tIPRD8IHJqt+tDVx31vzbXCb9FobPxEKEqFC1YwQK6od52w5CN8wqB23cITq/F4xbayfjHP4DgptQI0t1WAWm8FAD7vh/b9PLPCDVQUaHQBudLRgQrQYOCSQ+fa93A5hcT/Hd1AJh1dZRpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969495; c=relaxed/simple;
	bh=0TpW19L17d+Xn4yj/+DrXg7XGp5D33M2w0Cqs3uY9GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u57FAvMwGhG0OR7AveNPaSeLqYC4HpLon/75zvyin14Q0VRRmLtN03CAzR4+yHSbPVvRd2dVSJddbGQtttC20a8RSjgs30XsxzthGcbV5Kc5ve3Fahu2HNxdiTPe9ZTzVhfxLzM3b1IPi6IY74xX5K+x36vgc6jMx3DP5GEsoA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TG/LdS11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A3DC43390;
	Tue, 23 Jan 2024 00:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969495;
	bh=0TpW19L17d+Xn4yj/+DrXg7XGp5D33M2w0Cqs3uY9GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TG/LdS11YVLww/eCvwmAgcWRb8UQkLmfpSpp5Vgw6YUy3ms0DhGefwshC/UQMChHe
	 mogRNd79wh0BV710elRtsB5Kiv7jL1qLkWus27upgLlx/eU1wsIOBqDYD+NwHA1pJd
	 WOKJrDRkvdltDy86ojSCifXK1N2V7pt6KwQM1nDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Reichel <sre@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 283/641] media: v4l: async: Fix duplicated list deletion
Date: Mon, 22 Jan 2024 15:53:07 -0800
Message-ID: <20240122235826.755138903@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sebastian Reichel <sre@kernel.org>

[ Upstream commit 3de6ee94aae701fa949cd3b5df6b6a440ddfb8f2 ]

The list deletion call dropped here is already called from the
helper function in the line before. Having a second list_del()
call results in either a warning (with CONFIG_DEBUG_LIST=y):

list_del corruption, c46c8198->next is LIST_POISON1 (00000100)

If CONFIG_DEBUG_LIST is disabled the operation results in a
kernel error due to NULL pointer dereference.

Fixes: 28a1295795d8 ("media: v4l: async: Allow multiple connections between entities")
Signed-off-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 091e8cf4114b..8cfd593d293d 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -880,7 +880,6 @@ void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
 				  &asc->notifier->waiting_list);
 
 			v4l2_async_unbind_subdev_one(asc->notifier, asc);
-			list_del(&asc->asc_subdev_entry);
 		}
 	}
 
-- 
2.43.0




