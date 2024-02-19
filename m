Return-Path: <stable+bounces-20572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6E385A853
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BBC28643C
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0913B7A8;
	Mon, 19 Feb 2024 16:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y07bobX9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDC23B181
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359015; cv=none; b=skpirr7fY3ymtq1Uk0FKtLUIxLDHzaRFQxdMy6/6oI/SNVloF3xPoBs0WnzD/vGS1w49T6E0B+MRYwd5k6BOYwWvjnyAYPLL14Q5AYyVpA8VkSrYbhXg7QL1TWEaA8y88c9nd3qdu3zgJAQZ4lCcSjPUA9vHFhPYYMNXeUdWeGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359015; c=relaxed/simple;
	bh=y/WfKmPvlmMzxa3QyMB2NHDNCGTi7rPkBDKNsBeAsp0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pEE1KG+PAwyDkmlAAQ5iUpqD79i9V1rR3+tvf6hs53po+12qvFq0qI62ZsXtKwBVMRU5+e1HlugCr1cRddm0iwIPKFlnQhsBsZ0zktNTMR9QPLrEs+MkvOHNFDDdBtABWM7HNTeK882vHCz+gHKXWco32k4YQEFtWcrue9zUcPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y07bobX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE61C433F1;
	Mon, 19 Feb 2024 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359014;
	bh=y/WfKmPvlmMzxa3QyMB2NHDNCGTi7rPkBDKNsBeAsp0=;
	h=Subject:To:Cc:From:Date:From;
	b=Y07bobX9I8dfqhz0JqmCDYRr2s+C/h5Lg4e2ABphb5Z3AfMD71FmxWUGz0HfDJDY3
	 gQs41MZvX4BYJ1CKxvseDFblUY2c3CjUyj0kTinyH+YtXc9HmHiCsb6COaCL4w3g4g
	 tpa5Ywg5P3nt2F9WJ38K5FK5KKVDGklBzVjZs/jY=
Subject: FAILED: patch "[PATCH] drm/amdgpu/pm: Use inline function for IP version check" failed to apply to 6.7-stable tree
To: Jun.Ma2@amd.com,alexander.deucher@amd.com,kevinyang.wang@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:10:11 +0100
Message-ID: <2024021911-upstate-pavestone-eed5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 6813cdca4ab94a238f8eb0cef3d3f3fcbdfb0ee0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021911-upstate-pavestone-eed5@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

6813cdca4ab9 ("drm/amdgpu/pm: Use inline function for IP version check")
18df969b44a0 ("drm/amd/pm: enable Wifi RFI mitigation feature support for SMU13.0.0")
b8b39de64627 ("drm/amd/pm: setup the framework to support Wifi RFI mitigation feature")
2e9b152325f6 ("drm/amdgpu: optimize RLC powerdown notification on Vangogh")
12c2d3b5f5bc ("drm/amd/pm: Add support to fetch pm metrics sample")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6813cdca4ab94a238f8eb0cef3d3f3fcbdfb0ee0 Mon Sep 17 00:00:00 2001
From: Ma Jun <Jun.Ma2@amd.com>
Date: Wed, 31 Jan 2024 10:19:20 +0800
Subject: [PATCH] drm/amdgpu/pm: Use inline function for IP version check

Use existing inline function for IP version check.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 3230701d0d38..a9954ffc02c5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2944,7 +2944,7 @@ static bool smu_v13_0_0_wbrf_support_check(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	switch (adev->ip_versions[MP1_HWIP][0]) {
+	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 	case IP_VERSION(13, 0, 0):
 		return smu->smc_fw_version >= 0x004e6300;
 	case IP_VERSION(13, 0, 10):


