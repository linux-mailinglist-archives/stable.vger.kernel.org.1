Return-Path: <stable+bounces-18835-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88265849BCA
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 14:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD261C22B2B
	for <lists+stable@lfdr.de>; Mon,  5 Feb 2024 13:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51420B3D;
	Mon,  5 Feb 2024 13:30:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D782374E
	for <stable@vger.kernel.org>; Mon,  5 Feb 2024 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707139820; cv=none; b=sYWPzmCCH3vIa+0Imnj+341f8IR8IRnt5+OWpNfC1dZfnFqizQ12QrOG01ThzhshupYG+TyuMa0thWkkoRgTM12/3YhuTmN24r1S8b1aJJVap9vfWOods7R13ruWlbftT0I+p5+kKfgSnpytj8iNU+0iVaBCFvfIzV+wCnywtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707139820; c=relaxed/simple;
	bh=YgLW7kmCjRBqv5M1aPWisfj67g/GgcIWeyymCXCWY50=;
	h=From:Date:Subject:To:Cc:Message-Id; b=AF5finFgiceqR1c10wU8sn67koJrW9FJi+VripmHcBTL3ME3ezxaWumQwV6jc43ztbkLg8hnO2nrM9ubdquvC3xqgBpaE/4EKBejbLWtpi7s3JPROp2MehBxRPbnGWTewGvnbxB+R/b74U3yJXb2iFUfz6f/dFCMe4mKuRSctSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1rWz38-0004GN-18;
	Mon, 05 Feb 2024 13:30:14 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Mon, 05 Feb 2024 13:29:34 +0000
Subject: [git:media_stage/master] media: mc: Fix flags handling when creating pad links
To: linuxtv-commits@linuxtv.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1rWz38-0004GN-18@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: mc: Fix flags handling when creating pad links
Author:  Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date:    Mon Jan 15 00:24:12 2024 +0200

The media_create_pad_link() function doesn't correctly clear reject link
type flags, nor does it set the DATA_LINK flag. It only works because
the MEDIA_LNK_FL_DATA_LINK flag's value is 0.

Fix it by returning an error if any link type flag is set. This doesn't
introduce any regression, as nobody calls the media_create_pad_link()
function with link type flags (easily checked by grepping for the flag
in the source code, there are very few hits).

Set the MEDIA_LNK_FL_DATA_LINK explicitly, which is a no-op that the
compiler will optimize out, but is still useful to make the code more
explicit and easier to understand.

Cc: stable@vger.kernel.org # 6.1
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/mc/mc-entity.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

---

diff --git a/drivers/media/mc/mc-entity.c b/drivers/media/mc/mc-entity.c
index a6f28366106f..7839e3f68efa 100644
--- a/drivers/media/mc/mc-entity.c
+++ b/drivers/media/mc/mc-entity.c
@@ -1092,6 +1092,11 @@ media_create_pad_link(struct media_entity *source, u16 source_pad,
 	struct media_link *link;
 	struct media_link *backlink;
 
+	if (flags & MEDIA_LNK_FL_LINK_TYPE)
+		return -EINVAL;
+
+	flags |= MEDIA_LNK_FL_DATA_LINK;
+
 	if (WARN_ON(!source || !sink) ||
 	    WARN_ON(source_pad >= source->num_pads) ||
 	    WARN_ON(sink_pad >= sink->num_pads))
@@ -1107,7 +1112,7 @@ media_create_pad_link(struct media_entity *source, u16 source_pad,
 
 	link->source = &source->pads[source_pad];
 	link->sink = &sink->pads[sink_pad];
-	link->flags = flags & ~MEDIA_LNK_FL_INTERFACE_LINK;
+	link->flags = flags;
 
 	/* Initialize graph object embedded at the new link */
 	media_gobj_create(source->graph_obj.mdev, MEDIA_GRAPH_LINK,

