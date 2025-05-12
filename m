Return-Path: <stable+bounces-143197-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD90BAB3471
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5231F3A62AF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5AA78C91;
	Mon, 12 May 2025 10:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OtEt5D27"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020A255239
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044276; cv=none; b=Dc+5s3KOG+W/vv5lFcNw+gXTMg4Eq/oemHsuXWc+Qzs3qQeyly00BoB8q1F8jxl4hen3NuwrxwdNO7hgNibRp0MbK7nlmVN7wICFFHIOM43fCUnJqwpUuoWAaSj0R80CbvP37CG+u8LoY5JS74YX/23hLu9ChXDXnLA53OtxGck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044276; c=relaxed/simple;
	bh=MrURSKQgMzUlRVo4WLyelzpZHFCViVokHUXIYA8Kxss=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jV9fJii3P6GjPc4EcsePhKZXWmwjT30PdsjpU1p/xmgqoudl2DY1pwBEs1lBoY5cU8L0eCb1Rx/UctA3NmujO2OYFYRQeIdWWl40sLoe/lG2fx53Bd/PEZEgSKJZ8CMPBcmXugR3poVUtKLGjAR9T1nNBkekxgldmroOqbBNmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OtEt5D27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F88C4CEE7;
	Mon, 12 May 2025 10:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044274;
	bh=MrURSKQgMzUlRVo4WLyelzpZHFCViVokHUXIYA8Kxss=;
	h=Subject:To:Cc:From:Date:From;
	b=OtEt5D27KPmawmejGK/SPnZy2EWoAhnjwAl/Z1cQrPm5URcRx7POxPQ9NsJWMbF6G
	 ej6GQn/ooKlgDAAsFiqOnXMmTi3AS9j1j7k/qGni2FFUME7KTWiI+c1YifrWzLtYJO
	 rsk//EnGXIcvd8/JwZ9ZLKDvyaxQimjmT6/Vc4Eo=
Subject: FAILED: patch "[PATCH] iio: hid-sensor-prox: Fix incorrect OFFSET calculation" failed to apply to 6.1-stable tree
To: lixu.zhang@intel.com,Jonathan.Cameron@huawei.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:04:17 +0200
Message-ID: <2025051217-celestial-untimed-062b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 79dabbd505210e41c88060806c92c052496dd61c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051217-celestial-untimed-062b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79dabbd505210e41c88060806c92c052496dd61c Mon Sep 17 00:00:00 2001
From: Zhang Lixu <lixu.zhang@intel.com>
Date: Mon, 31 Mar 2025 13:50:22 +0800
Subject: [PATCH] iio: hid-sensor-prox: Fix incorrect OFFSET calculation

The OFFSET calculation in the prox_read_raw() was incorrectly using the
unit exponent, which is intended for SCALE calculations.

Remove the incorrect OFFSET calculation and set it to a fixed value of 0.

Cc: stable@vger.kernel.org
Fixes: 39a3a0138f61 ("iio: hid-sensors: Added Proximity Sensor Driver")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://patch.msgid.link/20250331055022.1149736-4-lixu.zhang@intel.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 941508e58286..4c65b32d34ce 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -124,8 +124,7 @@ static int prox_read_raw(struct iio_dev *indio_dev,
 		ret_type = prox_state->scale_precision[chan->scan_index];
 		break;
 	case IIO_CHAN_INFO_OFFSET:
-		*val = hid_sensor_convert_exponent(
-			prox_state->prox_attr[chan->scan_index].unit_expo);
+		*val = 0;
 		ret_type = IIO_VAL_INT;
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:


