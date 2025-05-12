Return-Path: <stable+bounces-143199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88142AB3473
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 12:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 023E73A67BC
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF662259CAC;
	Mon, 12 May 2025 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="evAssfHs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E332255239
	for <stable@vger.kernel.org>; Mon, 12 May 2025 10:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044282; cv=none; b=LTyjeHoFHfjCVsY6mImzDS7UhA6voAVEYnTVSfT6D0/5xcVQd1BO13vlA+JbH9w4Hxcri91QJLT82QL2f2CmL9Pl3MnaCe9WwPNVmGvc1LYH9ih9j75ruLTzKsVIzea+wX6IzRjKJ+b62J1MePYpKw97iAUaOzuxLoK+04AF82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044282; c=relaxed/simple;
	bh=YWffNqGAOaN/x6j6OFVJ7PygMcAYVjOkIhXazt2OWQE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CD5WhZRKupyRaej0sBDP4tjwGEM/3yyxihjIvJ6bW7LlySnCMokZQz/M3G+arnIW0HKfqiLaF9eoKRM4xmX/T8uJSXXtBKvpK7pNWDH6BSpckz23MTQbsiPYwNFF/+0ylARUIOQaSL7Tw+MFrLtPCKB2+KFjf6YUCo0BIMs+FRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=evAssfHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA85C4CEED;
	Mon, 12 May 2025 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747044281;
	bh=YWffNqGAOaN/x6j6OFVJ7PygMcAYVjOkIhXazt2OWQE=;
	h=Subject:To:Cc:From:Date:From;
	b=evAssfHs2NhS+/zSSaJAYMFYXuk6lH1nNR61uW14rhbgKPRRn7p7HZl3HcPNx9hZr
	 s1zlDPxgXjBr8DdCe3msgIhOEXX45qct9OjehWhJ1w3kOuF3ELJCYaL31Z4gK1n0JO
	 VXwXEcLK53IS1Bocv02oipbvD9QYB+y1z7WUS7VE=
Subject: FAILED: patch "[PATCH] iio: hid-sensor-prox: Fix incorrect OFFSET calculation" failed to apply to 5.10-stable tree
To: lixu.zhang@intel.com,Jonathan.Cameron@huawei.com,srinivas.pandruvada@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 May 2025 12:04:18 +0200
Message-ID: <2025051218-levitator-october-5d50@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 79dabbd505210e41c88060806c92c052496dd61c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025051218-levitator-october-5d50@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


