Return-Path: <stable+bounces-63164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323AD9417B1
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D751C22D70
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB4C1917DB;
	Tue, 30 Jul 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wOO3n6XL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECC71917D8;
	Tue, 30 Jul 2024 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355878; cv=none; b=NLg8Zp3N51a6FmsDwzkIb5iEq9rGmOJVIlOej9wmySlDVVxMLA+Tx/s5X0D8FOvtQbbum1sugOBf2I3TrnSmY8N9Fa5z74/EUgyFv4qkJAah1HFHRVGVDaZ/F37Cqvq7aGrBPvEXGDT1NLHqzdDvMCYDS/0Mf86SlohZIS6Kpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355878; c=relaxed/simple;
	bh=gEWcmThATysr7hM0R7uDjMEuP0eQn/1Dev8OTjZIacA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9j+t9fP7CMJKy750BNKWhRmAt4KnL4kkTjdRHBrHABs+ca7G69X2uVnQndnDQieJXrZvca/8hdwB0CosAaBwwuEsB+okWzjzoMMH34MomItBfF0i3iZ1AQL3Ys//TqBtWiQsXwgZkP35rTGrK7YvmowM2rDBsicZYXEWejEK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wOO3n6XL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F4EC32782;
	Tue, 30 Jul 2024 16:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722355878;
	bh=gEWcmThATysr7hM0R7uDjMEuP0eQn/1Dev8OTjZIacA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wOO3n6XL9N1IQIKICO7o6ZkWR6nWAuKj9vGrotvQljGRl85ZpUM2NMPzrz6yR33/X
	 rQq/mmO2TegX5FGwL+yyQhxug9bXf+8howcKWtV7qysCFxgHvbQw2SbMyJPgsQR2dl
	 6MwFrGO7z2pTYQEzVWE5BMEGtWTP6gaPanOU8xzA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ChiYuan Huang <cy_huang@richtek.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 140/440] media: v4l: async: Fix NULL pointer dereference in adding ancillary links
Date: Tue, 30 Jul 2024 17:46:13 +0200
Message-ID: <20240730151621.352668358@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
References: <20240730151615.753688326@linuxfoundation.org>
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

From: ChiYuan Huang <cy_huang@richtek.com>

[ Upstream commit 9b4667ea67854f0b116fe22ad11ef5628c5b5b5f ]

In v4l2_async_create_ancillary_links(), ancillary links are created for
lens and flash sub-devices. These are sub-device to sub-device links and
if the async notifier is related to a V4L2 device, the source sub-device
of the ancillary link is NULL, leading to a NULL pointer dereference.
Check the notifier's sd field is non-NULL in
v4l2_async_create_ancillary_links().

Fixes: aa4faf6eb271 ("media: v4l2-async: Create links during v4l2_async_match_notify()")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
[Sakari Ailus: Reword the subject and commit messages slightly.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 008a2a3e312e0..7471dbd140409 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -302,6 +302,9 @@ static int v4l2_async_create_ancillary_links(struct v4l2_async_notifier *n,
 	    sd->entity.function != MEDIA_ENT_F_FLASH)
 		return 0;
 
+	if (!n->sd)
+		return 0;
+
 	link = media_create_ancillary_link(&n->sd->entity, &sd->entity);
 
 #endif
-- 
2.43.0




