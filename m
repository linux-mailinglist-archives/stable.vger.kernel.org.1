Return-Path: <stable+bounces-20191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3410A854CA3
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 16:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBBD01F24C23
	for <lists+stable@lfdr.de>; Wed, 14 Feb 2024 15:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9215C8F8;
	Wed, 14 Feb 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ziESBLAH"
X-Original-To: Stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6943157
	for <Stable@vger.kernel.org>; Wed, 14 Feb 2024 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924403; cv=none; b=Mz6iwCuBByXwdGVea9LTdwpf0cJcuq/JIe0Sa42CMdmpnqfBlKCiMO6vyb6MPUaIeHuldO1Nk1PJwnwqrHej11rH850PXm690APjOF21URsKBTWWm8+TNox5XAEQwCz7qI1AKjMciCemVNASnkhZ7++gMCnImpNONBMiNN90KDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924403; c=relaxed/simple;
	bh=zzJvldvdcaWs69weyhEFYurhSIjfGUfD7P6g+4jZinU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=azBDAz8XywCKzLYRpP79u++/oLPojwmE2JmIFgy1FZB2HJ8YtUQQeX3AgOX3vP26/Uz82IW3iIkCcetbllSMucI+Gs64Mfi87Z7+RhOsbbZwUjR8gXTEmbelcDIXY/oAhsxOjiy1iqARbTnlWowtFu0/SOGQ2jOg5Wbu2/pzEMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ziESBLAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD71C433F1;
	Wed, 14 Feb 2024 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707924402;
	bh=zzJvldvdcaWs69weyhEFYurhSIjfGUfD7P6g+4jZinU=;
	h=Subject:To:From:Date:From;
	b=ziESBLAHQq3G97qH3oCWHLthPz5+26Sq6y7CSeRv+d7Tju5OPQftXIaddc8QojLA9
	 ZhChX1URBpTJZdroVEN2sKYK4dcJI77CH9k7gyrD7JIGxue6lnKJvXhrhLdD3UoAqo
	 B/z0buPUlgD3s8eIbZcq7UXOIv7+tMQDL6e7G+KY=
Subject: patch "iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP" added to char-misc-linus
To: srinivas.pandruvada@linux.intel.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Wed, 14 Feb 2024 16:26:10 +0100
Message-ID: <2024021410-recognize-framing-4b70@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 621c6257128149e45b36ffb973a01c3f3461b893 Mon Sep 17 00:00:00 2001
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Sun, 4 Feb 2024 04:56:17 -0800
Subject: iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP

When als_capture_sample() is called with usage ID
HID_USAGE_SENSOR_TIME_TIMESTAMP, return 0. The HID sensor core ignores
the return value for capture_sample() callback, so return value doesn't
make difference. But correct the return value to return success instead
of -EINVAL.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20240204125617.2635574-1-srinivas.pandruvada@linux.intel.com
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/light/hid-sensor-als.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 5cd27f04b45e..b6c4bef2a7bb 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -226,6 +226,7 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
 	case HID_USAGE_SENSOR_TIME_TIMESTAMP:
 		als_state->timestamp = hid_sensor_convert_timestamp(&als_state->common_attributes,
 								    *(s64 *)raw_data);
+		ret = 0;
 		break;
 	default:
 		break;
-- 
2.43.1



