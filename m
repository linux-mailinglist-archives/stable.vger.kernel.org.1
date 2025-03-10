Return-Path: <stable+bounces-122121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD2DA59E04
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AFCA7A4383
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5B234972;
	Mon, 10 Mar 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cyMUNqGs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E8622D4C3;
	Mon, 10 Mar 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627587; cv=none; b=KLpgMYVwsU4KOLn8qd1L2OX2QCtdey//K7ytvoFZ1XJi7dVpayiyldX9Er8HU/eRFDTTA9JnR5T4l2zJtqvQoRfCuOAJyWNHZHMLfkVGObia/XhVote+RzJlGPT3akB0lburLCndTALMvWaPL/QYHYIDXv+hzuOIOnsDuP3Ba2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627587; c=relaxed/simple;
	bh=URe00mRegScVbPr0MhhNUDjSnL7j8ZvTewkGpT7IcJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWRM0oh+JwC55QZAu/glQJ6Hc+ARc/tlao0+s0zemWVV1kre6j5lAUS1qAMx/lkPXQ6qBI/vT8fKqL0OaMuXqaemT1yT5wcQ0kh9B4RsXYTo7vrlkFp8hNhTMkLdGxGgrRMhNB1dpXRCIlS+D2AVWLyz2Py/TWEwY+4cVut5hdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cyMUNqGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A44C4CEE5;
	Mon, 10 Mar 2025 17:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741627587;
	bh=URe00mRegScVbPr0MhhNUDjSnL7j8ZvTewkGpT7IcJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cyMUNqGsmNUk+3M6mCuaSXa8LK1j2AiW/N5zdW6S12lammYGxJtCXW4MRO4vHWOxi
	 yczFMU5HXBAJMLdK3+pcOpiKw37O1iOJNGLcZBCZDVsZr0R22jt09reyBB7Nv0pd+q
	 4tVDvuKCdSOSXvxGDeD+qxK3YapeAIibQK1NOerA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 148/269] HID: intel-ish-hid: Fix use-after-free issue in ishtp_hid_remove()
Date: Mon, 10 Mar 2025 18:05:01 +0100
Message-ID: <20250310170503.615293023@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170457.700086763@linuxfoundation.org>
References: <20250310170457.700086763@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Lixu <lixu.zhang@intel.com>

[ Upstream commit 07583a0010696a17fb0942e0b499a62785c5fc9f ]

The system can experience a random crash a few minutes after the driver is
removed. This issue occurs due to improper handling of memory freeing in
the ishtp_hid_remove() function.

The function currently frees the `driver_data` directly within the loop
that destroys the HID devices, which can lead to accessing freed memory.
Specifically, `hid_destroy_device()` uses `driver_data` when it calls
`hid_ishtp_set_feature()` to power off the sensor, so freeing
`driver_data` beforehand can result in accessing invalid memory.

This patch resolves the issue by storing the `driver_data` in a temporary
variable before calling `hid_destroy_device()`, and then freeing the
`driver_data` after the device is destroyed.

Fixes: 0b28cb4bcb17 ("HID: intel-ish-hid: ISH HID client driver")
Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ishtp-hid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp-hid.c b/drivers/hid/intel-ish-hid/ishtp-hid.c
index 00c6f0ebf3563..be2c62fc8251d 100644
--- a/drivers/hid/intel-ish-hid/ishtp-hid.c
+++ b/drivers/hid/intel-ish-hid/ishtp-hid.c
@@ -261,12 +261,14 @@ int ishtp_hid_probe(unsigned int cur_hid_dev,
  */
 void ishtp_hid_remove(struct ishtp_cl_data *client_data)
 {
+	void *data;
 	int i;
 
 	for (i = 0; i < client_data->num_hid_devices; ++i) {
 		if (client_data->hid_sensor_hubs[i]) {
-			kfree(client_data->hid_sensor_hubs[i]->driver_data);
+			data = client_data->hid_sensor_hubs[i]->driver_data;
 			hid_destroy_device(client_data->hid_sensor_hubs[i]);
+			kfree(data);
 			client_data->hid_sensor_hubs[i] = NULL;
 		}
 	}
-- 
2.39.5




