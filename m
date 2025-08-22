Return-Path: <stable+bounces-172483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 627BFB321AA
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C2091BA3F9B
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B7A229B18;
	Fri, 22 Aug 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkL9eGmU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A316D9C2
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755884771; cv=none; b=rOg/KI3gcmCfrspywbJqntdR44pmrFXzUDmkb7ksyHsVDKhxjMRLwLIZYinjPP3LOsCjVn/V7/VXdiXqMZCudR7oqOVTF6EaUQa+sV0s417EGvVBA1L5UXwmef4kbUHFqpR0fRlWd74hszvZ+WA/llgC2Zrw0Vf8LbDMwKNpJD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755884771; c=relaxed/simple;
	bh=O5mP8RapoZGKRSMiUSLyt9HxQHxjCwOmEwRd400yR8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4TiIrpFKdiMHc+YSrMomqL83ZDaK4t0ZlBnANORUXTOm+HDnKMV4vZrIt/FBVhUbBAnPZ0bU9Lo253hir6fRbRlZwZxATYBHC6izym+HvczJKhU1HvcXFh6CbE8NKM3f+HOK3nbsM9/AW5V11Iuym2Qb42vs3xBs+ZM/NbEcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkL9eGmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F36BC4CEED;
	Fri, 22 Aug 2025 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755884770;
	bh=O5mP8RapoZGKRSMiUSLyt9HxQHxjCwOmEwRd400yR8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jkL9eGmUD0R+C1TczQF8lLZW/mqIjUYSNJ043J5MOjAi4VBOrWhNu75BFTxbVCJ4t
	 mQmLb+7JmBlM4/THwBdUMzEWZO6lSsy5i+fduSmU8BWTDbToCOR1gHsmd+LNd4Hlgh
	 f+XCyEkyFSP0o9If0DfefkqVcNiAgVkiNU79x5bhxQ4HyFIv1zXO7bP6ydzBDrc/Yz
	 GG8n+/nVV2ryI5YhbB22vSQ0hNrCq9Ni0SWSH/ggNsnEKQs6AhXdxWwYu11AT5px1V
	 eIgydpNvbdn76NU0/7XkIoskHy85EAgXGGOQA+tMH+y5I/tBNmtmz2ArJ6q6oQBYym
	 vwEQDc/vKyXNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: adc: ad_sigma_delta: change to buffer predisable
Date: Fri, 22 Aug 2025 13:46:08 -0400
Message-ID: <20250822174608.1341735-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082108-shining-user-b197@gregkh>
References: <2025082108-shining-user-b197@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Lechner <dlechner@baylibre.com>

[ Upstream commit 66d4374d97f85516b5a22418c5e798aed2606dec ]

Change the buffer disable callback from postdisable to predisable.
This balances the existing posteanble callback. Using postdisable
with posteanble can be problematic, for example, if update_scan_mode
fails, it would call postdisable without ever having called posteanble,
so the drivers using this would be in an unexpected state when
postdisable was called.

Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Delta devices")
Signed-off-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20250703-iio-adc-ad_sigma_delta-buffer-predisable-v1-1-f2ab85138f1f@baylibre.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad_sigma_delta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index ed8aa0599b39..e75e524bbb4f 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -371,7 +371,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 	return ret;
 }
 
-static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
+static int ad_sd_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 
@@ -432,7 +432,7 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 
 static const struct iio_buffer_setup_ops ad_sd_buffer_setup_ops = {
 	.postenable = &ad_sd_buffer_postenable,
-	.postdisable = &ad_sd_buffer_postdisable,
+	.predisable = &ad_sd_buffer_predisable,
 	.validate_scan_mask = &iio_validate_scan_mask_onehot,
 };
 
-- 
2.50.1


