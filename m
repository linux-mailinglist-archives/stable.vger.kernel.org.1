Return-Path: <stable+bounces-55944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15791A497
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 13:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016C01F229B7
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9CB145341;
	Thu, 27 Jun 2024 11:07:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from linuxtv.org (140-211-166-241-openstack.osuosl.org [140.211.166.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31C145323
	for <stable@vger.kernel.org>; Thu, 27 Jun 2024 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486472; cv=none; b=koLeFJPSNdsN1Yz8P2og4xtmPlrr/6LOCEVUBskX6BARWKb+/3/onihvwKVeH8oqNB6TaTTSpPG8BI/v4fAPG4dOuzhIJGOCE/b0TBWvjBdl52rLg2fg16owr0YH5veGDyczHbxX7OYdfGHmM/jxrlwxeHD209q8682AZyBWnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486472; c=relaxed/simple;
	bh=gHLoQdDZRjkVQjXFmi3H0NTYNXdUUGrZDZ1XaCK+KPE=;
	h=From:Date:Subject:To:Cc:Message-Id; b=qPdST4h6kd9Zuc3R8TUJOj3l3OGRWoz24FkMPxWD2P9CfenS4EOLSgmcRQwu8qJSiCzTwuEXVL9LHVLJkGmMK/V6hsPEOMlnSNwLQW3zZDkVR0PGWd/G+oKfaX003ZQ3j+a1d+vF7wIgYkA3LMMNPp6fqOb5qUAInO1EFUdr22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=linuxtv.org; arc=none smtp.client-ip=140.211.166.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtv.org
Received: from hverkuil by linuxtv.org with local (Exim 4.96)
	(envelope-from <hverkuil@linuxtv.org>)
	id 1sMmyi-0001tL-2C;
	Thu, 27 Jun 2024 11:07:49 +0000
From: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date: Thu, 27 Jun 2024 11:06:47 +0000
Subject: [git:media_stage/master] media: stm32: dcmipp: correct error handling in dcmipp_create_subdevs
To: linuxtv-commits@linuxtv.org
Cc: Alain Volmat <alain.volmat@foss.st.com>, stable@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1sMmyi-0001tL-2C@linuxtv.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: stm32: dcmipp: correct error handling in dcmipp_create_subdevs
Author:  Alain Volmat <alain.volmat@foss.st.com>
Date:    Mon Jun 24 10:41:22 2024 +0200

Correct error handling within the dcmipp_create_subdevs by properly
decrementing the i counter when releasing the subdeves.

Fixes: 28e0f3772296 ("media: stm32-dcmipp: STM32 DCMIPP camera interface driver")
Cc: stable@vger.kernel.org
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

diff --git a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
index 4acc3b90d03a..4924ee36cfda 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c
@@ -202,7 +202,7 @@ static int dcmipp_create_subdevs(struct dcmipp_device *dcmipp)
 	return 0;
 
 err_init_entity:
-	while (i > 0)
+	while (i-- > 0)
 		dcmipp->pipe_cfg->ents[i - 1].release(dcmipp->entity[i - 1]);
 	return ret;
 }

