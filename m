Return-Path: <stable+bounces-196690-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634D3C80B3D
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B323A6D56
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0032F84F;
	Mon, 24 Nov 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k1Tinxyi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57B1A275
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763990357; cv=none; b=FbUk7FDwpf9+85iCHu01h+V4FzojxU87xMtkMkBaUf8uoXjbGygGqwO/6NB9F/hhBBqaoMDX4FsV5OIF5hsdILniz6b6RGeo/GNJp2bF+4x9u6ZfJun3NfxvN2EgDNAj6Pmp2ghnRSx6aoWJVTnAqQP/r/C1IGM+3OiR6egHVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763990357; c=relaxed/simple;
	bh=IZvllBSJq9F8VtImLleNZ6e/nR8JZvrduxaRum2rlEM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N3RR2qX79LD0FBN39vlCwFL3RtYN1rV0mUftgTZmfeCupOwsDXwIuJ0jaFndQEJMreOq1DtIMw+T19jMsu7wVpRtblf48cDrcmJ6vn3wxyJd+VjSCndk5WJaDNN24+pKhDDxE/FQATJYC8jhZLX5UcC4G04dFualJQULpV/oj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k1Tinxyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D511EC4CEF1;
	Mon, 24 Nov 2025 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763990357;
	bh=IZvllBSJq9F8VtImLleNZ6e/nR8JZvrduxaRum2rlEM=;
	h=Subject:To:Cc:From:Date:From;
	b=k1Tinxyi4hLc9S6VJvRuUJfDZmgQgGun69PppuYE74ywwtIKJD8jHT6ENBWxJo8sa
	 1wWw0j4G4cazmKJQYdQL4c4vq3G9Xw4/DUXNjtCV3TKaf4EW7sEa57ug3ObTczwob9
	 hjkbZ0PXFfYVrYmloXZz4/nSjBO7mjrgdIEsutxY=
Subject: FAILED: patch "[PATCH] HID: amd_sfh: Stop sensor before starting" failed to apply to 6.1-stable tree
To: superm1@kernel.org,jkosina@suse.com,novatitas366@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:19:05 +0100
Message-ID: <2025112405-dispense-dealing-3eec@gregkh>
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
git cherry-pick -x 4d3a13afa8b64dc49293b3eab3e7beac11072c12
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112405-dispense-dealing-3eec@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4d3a13afa8b64dc49293b3eab3e7beac11072c12 Mon Sep 17 00:00:00 2001
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Date: Mon, 20 Oct 2025 10:50:42 -0500
Subject: [PATCH] HID: amd_sfh: Stop sensor before starting

Titas reports that the accelerometer sensor on their laptop only
works after a warm boot or unloading/reloading the amd-sfh kernel
module.

Presumably the sensor is in a bad state on cold boot and failing to
start, so explicitly stop it before starting.

Cc: stable@vger.kernel.org
Fixes: 93ce5e0231d79 ("HID: amd_sfh: Implement SFH1.1 functionality")
Reported-by: Titas <novatitas366@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220670
Tested-by: Titas <novatitas366@gmail.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
index 0a9b44ce4904..b0bab2a1ddcc 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -194,6 +194,8 @@ static int amd_sfh1_1_hid_client_init(struct amd_mp2_dev *privdata)
 		if (rc)
 			goto cleanup;
 
+		mp2_ops->stop(privdata, cl_data->sensor_idx[i]);
+		amd_sfh_wait_for_response(privdata, cl_data->sensor_idx[i], DISABLE_SENSOR);
 		writel(0, privdata->mmio + amd_get_p2c_val(privdata, 0));
 		mp2_ops->start(privdata, info);
 		status = amd_sfh_wait_for_response


