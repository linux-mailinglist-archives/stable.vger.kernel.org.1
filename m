Return-Path: <stable+bounces-108551-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA149A0C53F
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 00:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A0B7A22B6
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 23:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C305F1F8933;
	Mon, 13 Jan 2025 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7bgk2cY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8E1D61BF
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809767; cv=none; b=Dde8dtvjscGpe66jN3rhccnzXWVWMmXLn3IWl5lJV9Q+UEOnaXapbK9nqH2fiFggKLrVZYpdlDF4BC9SwCZ8o14vbZ4nNqj81PBfRbKojQA4Zo+qFW7ZIwmory8EjPLnqeAguHKxm7dClNjG2rfByuic+cdb1rCKch9AdzaCFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809767; c=relaxed/simple;
	bh=89tZHP3jZpuV9Y/Zh/wC7wBtnIeL8fJklUGgWrZRLlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PHT0gD5L54B3xfkSt7NCxpGFY5hakgsCL37sFPA9i815yzmLFM/x8huhK2v7U4z7C08E9oZ9XccjyLUrSdRdaX6s0QqqWQuayTkvoAQ/1RO6sjRZCT3q2FmP7fvCw0AP5xbD2Qz3npUUGtNF/5ONyeoNlPtnkHZt05hSpHKXSOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7bgk2cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A225FC4CED6;
	Mon, 13 Jan 2025 23:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809767;
	bh=89tZHP3jZpuV9Y/Zh/wC7wBtnIeL8fJklUGgWrZRLlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L7bgk2cY3UV7SrPZsMjvHQJ6P3w8WizDpTe4bxt3lBAfOX1GKl1SVJp2TnF+D5WZ+
	 vf+JmRik3w+8EzfIfwK3/R305Vt95qzQNF6qSJ5+LdK5Wx1K48NfOBVDNw+4MIr31q
	 QfSbj77ELFKUEzS8D9RIZMzQwwBx259drQVG6BZjZkCexJjQjn9A3JCfcoS1QnlNDc
	 12RiijwzTbEeL5dWBg6atDmulD/3NX571xxX9m6ClZhAKOtQ2RhxPhWxQyM6x7ty82
	 1lO6W9GdNtPSJBvhS+4e3fYwK+HueT+M6huetOl2PaXyA5XT17o9ouddOsZNpU8zoH
	 Lo3i4uvLCNvdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
Date: Mon, 13 Jan 2025 18:09:25 -0500
Message-Id: <20250113160649-c595879e30bf00b9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250113143131.568417-1-inv.git-commit@tdk.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: 65a60a590142c54a3f3be11ff162db2d5b0e1e06

WARNING: Author mismatch between patch and found commit:
Backport author: inv.git-commit@tdk.com
Commit author: Jean-Baptiste Maneyrol<jean-baptiste.maneyrol@tdk.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 7982d8f24a9b)
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  65a60a590142 ! 1:  9c96f19a264e iio: imu: inv_icm42600: fix timestamps after suspend if sensor is on
    @@ Commit message
         Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
         Link: https://patch.msgid.link/20241113-inv_icm42600-fix-timestamps-after-suspend-v1-1-dfc77c394173@tdk.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit 65a60a590142c54a3f3be11ff162db2d5b0e1e06)
     
      ## drivers/iio/imu/inv_icm42600/inv_icm42600_core.c ##
    +@@
    + #include <linux/regmap.h>
    + 
    + #include <linux/iio/iio.h>
    ++#include <linux/iio/common/inv_sensors_timestamp.h>
    + 
    + #include "inv_icm42600.h"
    + #include "inv_icm42600_buffer.h"
     @@ drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: static int inv_icm42600_suspend(struct device *dev)
      static int inv_icm42600_resume(struct device *dev)
      {
      	struct inv_icm42600_state *st = dev_get_drvdata(dev);
    -+	struct inv_icm42600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
    -+	struct inv_icm42600_sensor_state *accel_st = iio_priv(st->indio_accel);
    ++	struct inv_sensors_timestamp *gyro_ts = iio_priv(st->indio_gyro);
    ++	struct inv_sensors_timestamp *accel_ts = iio_priv(st->indio_accel);
      	int ret;
      
      	mutex_lock(&st->lock);
    @@ drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: static int inv_icm42600_resume
      	/* restore FIFO data streaming */
     -	if (st->fifo.on)
     +	if (st->fifo.on) {
    -+		inv_sensors_timestamp_reset(&gyro_st->ts);
    -+		inv_sensors_timestamp_reset(&accel_st->ts);
    ++		inv_sensors_timestamp_reset(gyro_ts);
    ++		inv_sensors_timestamp_reset(accel_ts);
      		ret = regmap_write(st->map, INV_ICM42600_REG_FIFO_CONFIG,
      				   INV_ICM42600_FIFO_CONFIG_STREAM);
     +	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

