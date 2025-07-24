Return-Path: <stable+bounces-164623-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB32B10E60
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 17:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0BB5683A4
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C02C15A2;
	Thu, 24 Jul 2025 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPiSVK7s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33FF255240
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370044; cv=none; b=JVyhyxaRTEruFPyqjekmYFMYmTnWtdtPhjM4KFIUeb4esWF/enpmfiMRbuZqMJuVv2ZhTPp5z6WsAD+4mIZjHVx6IULBMONxdpmpk+GFsUrBOGFZMFr0LCXID3AH668oMJLF4YniHCO4vXX4uYSJeimVCi/vcWqYvoFcFG2vfRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370044; c=relaxed/simple;
	bh=D1+hUKx5IDaq33FclriZfIM6K/rUq5bCY/BhHYrTlR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jhGL1USbtNPRBZGJw8CfwqL6XD5fIVeKzkRsekAsdk63xjC4ZI1Dup9+1SODtwHadrUfAA6eeEUSn7QSvID8K2vNybkMH69TytRK5UK8e8zHiHSzRi7ApxCXJF6m2ZinDMlQM/VfyANhexAAvEjwFSp32Im4V+KQ0g+iB3+0Xjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPiSVK7s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC37C4CEED;
	Thu, 24 Jul 2025 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370044;
	bh=D1+hUKx5IDaq33FclriZfIM6K/rUq5bCY/BhHYrTlR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPiSVK7sICz5ob3ABuADGa6bJzHKIxcCfAkIk3m8vBax0sUJta3mrtEzPdfazxP3d
	 QlZv/cQB0Hkrn7oCcxVUDkIHdv3vjnljJbm29tteJ6I8JKjVdbegGl2KvDYTN9YX+5
	 TNXmah1XeaOqUK0CVTmkilhfSdCHqOVFPG8pzaESDoAgRpkpCZaQE2yQziBLxStaCY
	 s3e8c5FYQ3xoyuwhSs/y6dwm1WMvM2LeLNQrqkcBs6wXf8uyJqSH5+/tNpypECBWOV
	 JR5cYZp1IcnLMHnQc1gbdk6xfm7i/Geh5nMvywcEn0xJOpSiVAgUC/zRzs7J+/lBFW
	 qFa7DfxArTyBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] iio: hid-sensor-prox: Fix incorrect OFFSET calculation
Date: Thu, 24 Jul 2025 11:14:00 -0400
Message-Id: <20250724151400.1363747-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025051217-job-sleek-cd29@gregkh>
References: <2025051217-job-sleek-cd29@gregkh>
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
index f10fa2abfe725..ffd4ffbcd996e 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -103,8 +103,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
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


