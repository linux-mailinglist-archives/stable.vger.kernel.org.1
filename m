Return-Path: <stable+bounces-100000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCDE9E7C45
	for <lists+stable@lfdr.de>; Sat,  7 Dec 2024 00:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111AF18861B9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 23:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A534212FA1;
	Fri,  6 Dec 2024 23:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHVm69yM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D561EF090
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 23:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733526707; cv=none; b=t7HEzKMuKAuvqrHEQemULHJGNFy5hhfXpkY9XeqhSlKU7nobq0P35wM0zLme5S2n3F2jKGAC7tbYGg3AE65F6T7VYEjygef2V/Z88ViIpjWGrTH9jCzJoF69ylfQkOqV9wJpePIwYNDSm3iT4pl2a+ocLSZUch9ly70zUO+fkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733526707; c=relaxed/simple;
	bh=2KsXCXBftlKpjn/Z4Vcdm9/BQGDvb1g17o2zkl9QMlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvtYphrRrpaZX0f4oryVCpzN3UDPAMP1Nwh2OWXlURPNixldJvKRGeNmSDgIPlRVukL4ejP7tbzzpqRINngpIYINh71OeBDIDyA7gxAOaSTiAqGcmYHC15MY/a7sF23nOg7QHpX+KyP3KVVXeI2c97lUAPGWp5VC/OXNYFc45Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHVm69yM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE511C4CED1;
	Fri,  6 Dec 2024 23:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733526707;
	bh=2KsXCXBftlKpjn/Z4Vcdm9/BQGDvb1g17o2zkl9QMlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHVm69yM+YwqPvP3CXy4qjQBw1e4IindAcrxfzOha/2INmcTedUGtJtDxD3DM8Gs9
	 1x/V3oMz3mBR8HDIkucQADHfACm8Ot1SirXUPxdDW2ctduJ3iybcJ+u/jqfg8p5fXa
	 8nJcITvfI254J02qnuKAqvDYGr8oB9oOCPenC3+DYtu9arGXjgwQYKgVOv1MvV3DbS
	 x0oYumPpnVLwEKEr6rbWONdKrGNAxIo+0W/d/YxU7bBgycl318q9GGOMd2qtKrus8Q
	 rbOZQvaEWU/Irdhgy4dSLW4rcUrhu1pSLT8RTxutrz/4BC/nI6ThURfCl1HKyUCfB4
	 qnH057ArGwwvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: inv.git-commit@tdk.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] iio: invensense: fix multiple odr switch when FIFO is off
Date: Fri,  6 Dec 2024 18:11:44 -0500
Message-ID: <20241206124259-3ac772796a15af83@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241206134922.57001-1-inv.git-commit@tdk.com>
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

Found matching upstream commit: ef5f5e7b6f73f79538892a8be3a3bee2342acc9f

WARNING: Author mismatch between patch and found commit:
Backport author: inv.git-commit@tdk.com
Commit author: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>


Status in newer kernel trees:
6.12.y | Not found
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  ef5f5e7b6f73f ! 1:  cd8eeb84a6377 iio: invensense: fix multiple odr switch when FIFO is off
    @@ Commit message
         Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
         Link: https://patch.msgid.link/20241021-invn-inv-sensors-timestamp-fix-switch-fifo-off-v2-1-39ffd43edcc4@tdk.com
         Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
    +    (cherry picked from commit ef5f5e7b6f73f79538892a8be3a3bee2342acc9f)
     
      ## drivers/iio/common/inv_sensors/inv_sensors_timestamp.c ##
     @@ drivers/iio/common/inv_sensors/inv_sensors_timestamp.c: int inv_sensors_timestamp_update_odr(struct inv_sensors_timestamp *ts,
    @@ drivers/iio/common/inv_sensors/inv_sensors_timestamp.c: int inv_sensors_timestam
     
      ## drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c ##
     @@ drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c: static int inv_icm42600_accel_update_scan_mode(struct iio_dev *indio_dev,
    + 					       const unsigned long *scan_mask)
      {
      	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
    - 	struct inv_icm42600_sensor_state *accel_st = iio_priv(indio_dev);
    --	struct inv_sensors_timestamp *ts = &accel_st->ts;
    +-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
      	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
      	unsigned int fifo_en = 0;
      	unsigned int sleep_temp = 0;
    @@ drivers/iio/imu/inv_icm42600/inv_icm42600_gyro.c: static int inv_icm42600_gyro_u
      					      const unsigned long *scan_mask)
      {
      	struct inv_icm42600_state *st = iio_device_get_drvdata(indio_dev);
    --	struct inv_icm42600_sensor_state *gyro_st = iio_priv(indio_dev);
    --	struct inv_sensors_timestamp *ts = &gyro_st->ts;
    +-	struct inv_sensors_timestamp *ts = iio_priv(indio_dev);
      	struct inv_icm42600_sensor_conf conf = INV_ICM42600_SENSOR_CONF_INIT;
      	unsigned int fifo_en = 0;
      	unsigned int sleep_gyro = 0;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

