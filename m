Return-Path: <stable+bounces-71402-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A29625A7
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 13:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B14C1C21EA0
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 11:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059E816CD10;
	Wed, 28 Aug 2024 11:13:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70516C874
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 11:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724843607; cv=none; b=Zg/XYGon7+xNJwU6pb7sJrtTiwDuUFwixWRle63tQDufxgcdH7640h0T9cpMwoMFavW3nZ0msXJc7v63DMpXtbA/KOYkiHboJ4J48WdpPZGqMC1fBXR1i91sf2kM022f2GHmuuPqm41lyillnaaSO731WYqRzvdoBwnyYOwvL9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724843607; c=relaxed/simple;
	bh=m6M/VSFHeyEwWPydHLaOsgXf168UmaHFzr+f0us4/js=;
	h=From:Date:Subject:To:Cc:Message-Id; b=b4ZX7sRW8akqXkxlMNzGljDT4VwpnQSqws4E39tYMWosSoFZ5rgvkj/pnCzHNFGCGECb+7iHQ8pEiJJZ+qlh/tFZWWrbJq2IEqSlEqOdxZK4U3NO5YlE0gXhZnq9jQdDS4RQPKMkc0pkew6fDuCjJ7JyZk2IYJmAwm8l6zOV3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sjGc9-0006C5-21;
	Wed, 28 Aug 2024 11:13:25 +0000
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 27 Aug 2024 11:57:38 +0000
Subject: [git:media_stage/master] media: videobuf2: Drop minimum allocation requirement of 2 buffers
To: linuxtv-commits@linuxtv.org
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sjGc9-0006C5-21@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: videobuf2: Drop minimum allocation requirement of 2 buffers
Author:  Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date:    Mon Aug 26 02:24:49 2024 +0300

When introducing the ability for drivers to indicate the minimum number
of buffers they require an application to allocate, commit 6662edcd32cc
("media: videobuf2: Add min_reqbufs_allocation field to vb2_queue
structure") also introduced a global minimum of 2 buffers. It turns out
this breaks the Renesas R-Car VSP test suite, where a test that
allocates a single buffer fails when two buffers are used.

One may consider debatable whether test suite failures without failures
in production use cases should be considered as a regression, but
operation with a single buffer is a valid use case. While full frame
rate can't be maintained, memory-to-memory devices can still be used
with a decent efficiency, and requiring applications to allocate
multiple buffers for single-shot use cases with capture devices would
just waste memory.

For those reasons, fix the regression by dropping the global minimum of
buffers. Individual drivers can still set their own minimum.

Fixes: 6662edcd32cc ("media: videobuf2: Add min_reqbufs_allocation field to vb2_queue structure")
Cc: stable@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Tomasz Figa <tfiga@chromium.org>
Link: https://lore.kernel.org/r/20240825232449.25905-1-laurent.pinchart+renesas@ideasonboard.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

 drivers/media/common/videobuf2/videobuf2-core.c | 7 -------
 1 file changed, 7 deletions(-)

---

diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
index 500a4e0c84ab..29a8d876e6c2 100644
--- a/drivers/media/common/videobuf2/videobuf2-core.c
+++ b/drivers/media/common/videobuf2/videobuf2-core.c
@@ -2632,13 +2632,6 @@ int vb2_core_queue_init(struct vb2_queue *q)
 	if (WARN_ON(q->supports_requests && q->min_queued_buffers))
 		return -EINVAL;
 
-	/*
-	 * The minimum requirement is 2: one buffer is used
-	 * by the hardware while the other is being processed by userspace.
-	 */
-	if (q->min_reqbufs_allocation < 2)
-		q->min_reqbufs_allocation = 2;
-
 	/*
 	 * If the driver needs 'min_queued_buffers' in the queue before
 	 * calling start_streaming() then the minimum requirement is

