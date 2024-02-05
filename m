Return-Path: <stable+bounces-18837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A26849BCD
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 14:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBC728166E
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E17F20DD0;
	Mon,  5 Feb 2024 13:30:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD123753
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139820; cv=none; b=nTVGS1B4QScN4ofm0BJS6ZLYUWeebQZA3us2ov4roH0ljE8t653D6h/B07Ya3lApUh6RpwLtU5PPDlZ6ugtrfJRHFz9CmyumFp2gHEDnrczD8GU7i5sWR3VXnzIpiG/T6zH+3amklhq4ZPURgFBvQ5NaZf08vkXEwwlUXmr0mAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139820; c=relaxed/simple;
	bh=l7jB/wp/YGJY5fMN6wygjQo13O4jAqnisZiUIo+yEUk=;
	h=From:Date:Subject:To:Cc:Message-Id; b=tewS66IkANZn7SjUTLkD0dZRfnyimtpP52JJH2mIACYGWHglaYxBIiEjUhB3uZPhFfFMB9/QwJKtR04rtSPh4E6UYVTBLNsDXEUwubqGkpU8yjF6Memf3L6mGXo62eW88HwQxaufsMJHKiyMpsrp9IFFVAGum+Ix3PDB8j0yriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1rWz38-0004Gg-1o;
	Mon, 05 Feb 2024 13:30:14 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Mon, 05 Feb 2024 13:29:34 +0000
Subject: [git:media_stage/master] media: mc: Add local pad to pipeline regardless of the link state
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rWz38-0004Gg-1o@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: mc: Add local pad to pipeline regardless of the link state
Author:  Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:    Sun Jan 14 15:55:40 2024 +0200

When building pipelines by following links, the
media_pipeline_explore_next_link() function only traverses enabled
links. The remote pad of a disabled link is not added to the pipeline,
and neither is the local pad. While the former is correct as disabled
links should not be followed, not adding the local pad breaks processing
of the MEDIA_PAD_FL_MUST_CONNECT flag.

The MEDIA_PAD_FL_MUST_CONNECT flag is checked in the
__media_pipeline_start() function that iterates over all pads after
populating the pipeline. If the pad is not present, the check gets
skipped, rendering it useless.

Fix this by adding the local pad of all links regardless of their state,
only skipping the remote pad for disabled links.

Cc: stable@vger.kernel.org # 6.1
Fixes: ae219872834a ("media: mc: entity: Rewrite media_pipeline_start()")
Reported-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Closes: https://lore.kernel.org/linux-media/7658a15a-80c5-219f-2477-2a94ba6c6ba1@kontron.de
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/mc/mc-entity.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

---

diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index 543a392f8635..a6f28366106f 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -620,13 +620,6 @@ static int media_pipeline_explore_next_link(struct media_pipeline *pipe,
 		link->source->entity->name, link->source->index,
 		link->sink->entity->name, link->sink->index);
 
-	/* Skip links that are not enabled. */
-	if (!(link->flags & MEDIA_LNK_FL_ENABLED)) {
-		dev_dbg(walk->mdev->dev,
-			"media pipeline: skipping link (disabled)\n");
-		return 0;
-	}
-
 	/* Get the local pad and remote pad. */
 	if (link->source->entity == pad->entity) {
 		local = link->source;
@@ -648,13 +641,20 @@ static int media_pipeline_explore_next_link(struct media_pipeline *pipe,
 	}
 
 	/*
-	 * Add the local and remote pads of the link to the pipeline and push
-	 * them to the stack, if they're not already present.
+	 * Add the local pad of the link to the pipeline and push it to the
+	 * stack, if not already present.
 	 */
 	ret = media_pipeline_add_pad(pipe, walk, local);
 	if (ret)
 		return ret;
 
+	/* Similarly, add the remote pad, but only if the link is enabled. */
+	if (!(link->flags & MEDIA_LNK_FL_ENABLED)) {
+		dev_dbg(walk->mdev->dev,
+			"media pipeline: skipping link (disabled)\n");
+		return 0;
+	}
+
 	ret = media_pipeline_add_pad(pipe, walk, remote);
 	if (ret)
 		return ret;

