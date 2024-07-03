Return-Path: <stable+bounces-57940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7644192633D
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 16:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217171F22093
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 14:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7014D44E;
	Wed,  3 Jul 2024 14:20:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84531854
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016411; cv=none; b=OXvfczW4ZI8jjB6CmeKiu9VM2wv6vfiPeawc/TDCLkCejitqs2R9eYlVixfq1AM4KTnOwl4eC2CtvjGfVkauBNK7NYu90GAqmn6lSzPqmipYhRkp1uZNFKeHkJC3w4H/WQiJFZc6GBxk9+Viw4Bnevf5aLg9l5PB6ZXLa0EO5os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016411; c=relaxed/simple;
	bh=f9G8pGWhv2bWrBBc0Q1Ui58uDe+KhbGzt/8g0E33d08=;
	h=From:Date:Subject:To:Cc:Message-Id; b=Jhwq3CkCh9oEci+tRoyD8sSZ0BVlUFiG+eCEVjoAdmEgABOBlOoDAvKbbP2c8tf4Q534YM1jEjiy4qw5mq+r09l3LejhRTXOGttLAxTRHHsG5YUMdq+h0Qn5ItAL1a0Tr0fOdg7TqJZpdZt6rPCUYwcKNF55oT2XAvIv4ppy618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sP0Ql-0000P2-1L;
	Wed, 03 Jul 2024 13:53:55 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Wed, 03 Jul 2024 13:52:24 +0000
Subject: [git:media_stage/master] media: stm32: dcmipp: correct error handling in dcmipp_create_subdevs
To: linuxtv-commits@linuxtv.org
Cc: Alain Volmat <alain.volmat@foss.st.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sP0Ql-0000P2-1L@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: stm32: dcmipp: correct error handling in dcmipp_create_subdevs
Author:  Alain Volmat <alain.volmat@foss.st.com>
Date:    Wed Jul 3 13:59:16 2024 +0200

Correct error handling within the dcmipp_create_subdevs by properly
decrementing the i counter when releasing the subdevs.

Fixes: 28e0f3772296 ("media: stm32-dcmipp: STM32 DCMIPP camera interface driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
[hverkuil: correct the indices: it's [i], not [i - 1].]

 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

---

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
index 4acc3b90d03a..7f771ea49b78 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
@@ -202,8 +202,8 @@ static int dcmipp_create_subdevs(struct dcmipp_device *dcmipp)
 	return 0;
 
 err_init_entity:
-	while (i > 0)
-		dcmipp->pipe_cfg->ents[i - 1].release(dcmipp->entity[i - 1]);
+	while (i-- > 0)
+		dcmipp->pipe_cfg->ents[i].release(dcmipp->entity[i]);
 	return ret;
 }
 

