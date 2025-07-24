Return-Path: <stable+bounces-164629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 358A0B10ED5
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315A51C283A7
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3202285CA6;
	Thu, 24 Jul 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqQLDOFz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831FD21D584
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371406; cv=none; b=Bww69Bj478LCJRUYXfWzp4KYeaYZ4XsNA4yky6DlFLQXox4pUlHABFyLceoecIOYrYwUNL0NnVppy4d7O74VoQewB24aZINzy5J0jwV0ZYTdSoXVXdMuWpK8tA94Oh8Vs6BrkxwhyCkYy05KcfpROFT0tnnd48TTnZHrzHbgeRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371406; c=relaxed/simple;
	bh=9Uosgts9MNH6vEMRz3QwiMwFcEWHAgY++K96hrW0RzI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtPt0OeaZCKn7Q2KDY2cDKkw7tfSK1wfsPbChZLape3649DzwIAt19hzgISrYzuKI863EZ9Hb4PC0mhaLPe12DTPqQDJVofpTNsdKmZrH1/8a84ggp8xPEgIfuLYnJo/BDopMFrRbcNECkzX8YFk2ya3LGu7xf7EHfRADa3eVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqQLDOFz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06537C4CEED;
	Thu, 24 Jul 2025 15:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753371406;
	bh=9Uosgts9MNH6vEMRz3QwiMwFcEWHAgY++K96hrW0RzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uqQLDOFzDXVY+TonX746hF/eC7c09ad6jB/SO1TTK3NNIve/orsuVEd7c6EoaYKvC
	 pLkiU9ecqxWdMsqoCFzniZMwjuaNsBG0LfhKgGPy7NsfExAmdRGXRE14vhsp85rTTK
	 GeG8GFhXK5Cky/9cUMAfWua+C2BRRQGK6S4Lk/E21lkj6kv4IX39YBq1NF0p1Oe2b+
	 DtmeWjg+vj3HCnH33X+vw1vI4oxul/vCqsIeXF/a8fkKYyJIDLxrtC3XY+0EDgpnaV
	 295S9IK3tl2/2vYy0TCh2iOn6S1xVsNkGHk9IE/nWT+vPQ/6n2A0Pz4kmpn3FkpbmX
	 YbL/5fQd0h2mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: hid-sensor-prox: Fix incorrect OFFSET calculation
Date: Thu, 24 Jul 2025 11:36:40 -0400
Message-Id: <20250724153640.1367316-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025051216-banister-canned-57e2@gregkh>
References: <2025051216-banister-canned-57e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Lixu <lixu.zhang@intel.com>

[ Upstream commit 79dabbd505210e41c88060806c92c052496dd61c ]

The OFFSET calculation in the prox_read_raw() was incorrectly using the
unit exponent, which is intended for SCALE calculations.

Remove the incorrect OFFSET calculation and set it to a fixed value of 0.

Cc: stable@vger.kernel.org
Fixes: 39a3a0138f61 ("iio: hid-sensors: Added Proximity Sensor Driver")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20250331055022.1149736-4-lixu.zhang@intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[ adapted prox_attr array access to single structure member access ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/hid-sensor-prox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index a47591e1bad9d..95f675e2e5327 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -102,8 +102,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		ret_type = prox_state->scale_precision;
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = hid_sensor_convert_exponent(
-				prox_state->prox_attr.unit_expo);
+		*val = 0;
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-- 
2.39.5


