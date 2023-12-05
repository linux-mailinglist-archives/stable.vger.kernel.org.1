Return-Path: <stable+bounces-4042-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4C68045C2
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DF11C20C49
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F4E6FB8;
	Tue,  5 Dec 2023 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aN5KPWF8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6F6AA0;
	Tue,  5 Dec 2023 03:21:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF9BC433C8;
	Tue,  5 Dec 2023 03:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746470;
	bh=Jg5VteE4TqlzN184PH/4ZIzAO3m4HRhFbdxlW3Dkj5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aN5KPWF8lPR63Oig/upMWlCvCQtFln9x3jELBun7Q1asMaFBD+Yv/TZE8mEKQfTJZ
	 BQmpVqT+pk2UULf2mrxR98HmSQuTTKYD/v7wPSx/EBO7igBDmq0yoWpIEKNFv9rORP
	 mt4aXYko1IspLqNvtHiGxvKQKK0bFWN2Hz3GgEH8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Prike Liang <Prike.Liang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 027/134] drm/amdgpu: correct the amdgpu runtime dereference usage count
Date: Tue,  5 Dec 2023 12:14:59 +0900
Message-ID: <20231205031537.141220738@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
References: <20231205031535.163661217@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prike Liang <Prike.Liang@amd.com>

commit c6df7f313794c3ad41a49b9a7c95da369db607f3 upstream.

Fix the amdgpu runpm dereference usage count.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -340,14 +340,11 @@ int amdgpu_display_crtc_set_config(struc
 		adev->have_disp_power_ref = true;
 		return ret;
 	}
-	/* if we have no active crtcs, then drop the power ref
-	 * we got before
+	/* if we have no active crtcs, then go to
+	 * drop the power ref we got before
 	 */
-	if (!active && adev->have_disp_power_ref) {
-		pm_runtime_put_autosuspend(dev->dev);
+	if (!active && adev->have_disp_power_ref)
 		adev->have_disp_power_ref = false;
-	}
-
 out:
 	/* drop the power reference we got coming in here */
 	pm_runtime_put_autosuspend(dev->dev);



