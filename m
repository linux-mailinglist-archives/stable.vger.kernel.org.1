Return-Path: <stable+bounces-1432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7137F7F9E
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E7E81C214CB
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9B1D685;
	Fri, 24 Nov 2023 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qM0HsDcs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4332F364C1;
	Fri, 24 Nov 2023 18:43:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA88C433C7;
	Fri, 24 Nov 2023 18:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851384;
	bh=/CASP2R8gYmFzkM0ZqXpYOAAY6gDtIIcM91IBTOG87k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qM0HsDcsyT47dTLFCHhV0M2IWKDIt/NBYPjl3q9Y9zhhwb1ZgWN23JY8wJXmS6PXE
	 FfbafT/GS7USRObrxWUkJohyBGn+AbLFwnlAMNTL43rp7cKUxAMIy9ye3FhH9R1Uio
	 JRmMZktGA56kSNASSzTdPXIzkdt8irp5ZOc7PrPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.5 426/491] media: ccs: Correctly initialise try compose rectangle
Date: Fri, 24 Nov 2023 17:51:02 +0000
Message-ID: <20231124172037.411559825@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 724ff68e968b19d786870d333f9952bdd6b119cb upstream.

Initialise the try sink compose rectangle size to the sink compose
rectangle for binner and scaler sub-devices. This was missed due to the
faulty condition that lead to the compose rectangles to be initialised for
the pixel array sub-device where it is not relevant.

Fixes: ccfc97bdb5ae ("[media] smiapp: Add driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ccs/ccs-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/i2c/ccs/ccs-core.c
+++ b/drivers/media/i2c/ccs/ccs-core.c
@@ -3097,7 +3097,7 @@ static int ccs_open(struct v4l2_subdev *
 		try_fmt->code = sensor->internal_csi_format->code;
 		try_fmt->field = V4L2_FIELD_NONE;
 
-		if (ssd != sensor->pixel_array)
+		if (ssd == sensor->pixel_array)
 			continue;
 
 		try_comp = v4l2_subdev_get_try_compose(sd, fh->state, i);



