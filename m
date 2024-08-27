Return-Path: <stable+bounces-73651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 318DF96E195
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 20:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3360B2531E
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5934617C9B9;
	Thu,  5 Sep 2024 18:09:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC19917BECA
	for <stable@vger.kernel.org>; Thu,  5 Sep 2024 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559748; cv=none; b=uSRKdb9EIB+8ps2fRLrggoWtroZGVR52TXJJwYIbPKdhn4BL7RMhDSMRk70BeR8cckXNb2/Y5cPXhse8s6Iwo3BXS/zIydyhIVOhZbWQJAXR8/uf31wgsx/+yAX9rq/jFvseiE8z/OhuLBBLUTZSMa3M1mSy4nffZDKbEAx5Mzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559748; c=relaxed/simple;
	bh=m6M/VSFHeyEwWPydHLaOsgXf168UmaHFzr+f0us4/js=;
	h=From:Date:Subject:To:Cc:Message-Id; b=gRlfmB11pzeolbvcrACpfA9pyuD5OH2piFb2Y/jK8G/d7M5BdVlHChrl+2/5QYIAxyCQwyRDVNTX2lP9wmOcsLyviM39rWn7J7CuhF313WBjaK9XfNJa8tkJtVmkE5KSkTIOF6+Bb/Zxs+CNjr3sOZDmWhXITask2UFqZzFXizk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from mchehab by linuxtv.org with local (Exim 4.96)
	(envelope-from <mchehab@linuxtv.org>)
	id 1smGuj-0001Wf-2t;
	Thu, 05 Sep 2024 18:09:03 +0000
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 27 Aug 2024 11:57:38 +0000
Subject: [git:media_tree/master] media: videobuf2: Drop minimum allocation requirement of 2 buffers
To: linuxtv-commits@linuxtv.org
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1smGuj-0001Wf-2t@linuxtv.org>
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

