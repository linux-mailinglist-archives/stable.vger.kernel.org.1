Return-Path: <stable+bounces-37966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F3189F3CC
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 15:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04FBE1C20CF8
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 13:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8E915E213;
	Wed, 10 Apr 2024 13:16:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DE15B576
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 13:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754960; cv=none; b=XyGzeXZ4dLG/AlClbaf3bUV4FKCs1ykiWRywdae6qhFkj67hD1MrSVkPG9MKUMjAGLYVWi4uNsXE4KRWeL/WyRVUjWdMOCp1JSaz6A+CdgHa7A53d9EKtecN5o2tV90e0tHiUCkm1u06msBUHiv0g7zcsWsHd7uGlW+bqBQnYcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754960; c=relaxed/simple;
	bh=nAp19hE2qmJ8QmKNGUvM9X6JTkwldoY5+mFadWwSgTI=;
	h=From:Date:Subject:To:Cc:Message-Id; b=qKFbbHRAqyijN5/EpihbtXqxl04T0Z5FVhrCPqOd1cGjtzzEeCRFNe1sauWhw27K6zirSdh9WhZdEKnpQrx5Qrp9el6q99MaYAXmQWsISZu+sCX3gqbU72OdZSgd+IcT4HDNj46tKr5wlwvVzVl6P0h91qBx5/Ia1mBIgY9OvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1ruXnx-0001Bg-2C;
	Wed, 10 Apr 2024 13:15:57 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 10 Apr 2024 13:15:31 +0000
Subject: [git:media_stage/master] media: mc: Fix graph walk in media_pipeline_start
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1ruXnx-0001Bg-2C@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: mc: Fix graph walk in media_pipeline_start
Author:  Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:    Mon Mar 18 11:50:59 2024 +0200

The graph walk tries to follow all links, even if they are not between
pads. This causes a crash with, e.g. a MEDIA_LNK_FL_ANCILLARY_LINK link.

Fix this by allowing the walk to proceed only for MEDIA_LNK_FL_DATA_LINK
links.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: stable@vger.kernel.org # for 6.1 and later
Fixes: ae219872834a ("media: mc: entity: Rewrite media_pipeline_start()")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/mc/mc-entity.c | 6 ++++++
 1 file changed, 6 insertions(+)

---

diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index 0e28b9a7936e..96dd0f6ccd0d 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -619,6 +619,12 @@ static int media_pipeline_explore_next_link(struct media_pipeline *pipe,
 	link = list_entry(entry->links, typeof(*link), list);
 	last_link = media_pipeline_walk_pop(walk);
 
+	if ((link->flags & MEDIA_LNK_FL_LINK_TYPE) != MEDIA_LNK_FL_DATA_LINK) {
+		dev_dbg(walk->mdev->dev,
+			"media pipeline: skipping link (not data-link)\n");
+		return 0;
+	}
+
 	dev_dbg(walk->mdev->dev,
 		"media pipeline: exploring link '%s':%u -> '%s':%u\n",
 		link->source->entity->name, link->source->index,

