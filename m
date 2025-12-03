Return-Path: <stable+bounces-199559-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5ECA024E
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E4D43035C16
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CEC3612C5;
	Wed,  3 Dec 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pKHFuOJy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEA035F8CF;
	Wed,  3 Dec 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764780199; cv=none; b=eXJyjwk40Q66C9wzkwGNov1aYEjDHN56QSoZXdHsVJ9i9V61cQM9sPARF3KdIDHrnjuwRhTjs7E5IyF5ctRLNhxrFFYrrPigaBYerByPJRzop/8dC7c6YPLYWn5HoA6vok7DoVfUNrFpzdoNRwx0TAEDdBq2/c8gvZ0YaaBpIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764780199; c=relaxed/simple;
	bh=2ivvNUiM4Vs7kcF/GQp+iSUYS0zFb11av23IHNzt7yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PFU4kZno5k1SBOASKOclb1r0tRopGlH489BxnjlljSsi0kh3ns9Qw0//kiLPCqErNpdADPCVzqRzFAmRZ1szrSj8p4TBLK5uSLtTbGfEc1yLlwUZHsR2Lq0VJ/xNfgsMgvQC0jRO0yLyWAMequ4rJt1qqiuCqMGWVV98rjxQMO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pKHFuOJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31B0C4CEF5;
	Wed,  3 Dec 2025 16:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764780199;
	bh=2ivvNUiM4Vs7kcF/GQp+iSUYS0zFb11av23IHNzt7yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKHFuOJyoVT+dkNzeQfezDos3xhwNKCT4ewLUBJDFbvdwligU4fTXJskJ11CydVlr
	 lW0UZTI3L+Vrs4kX+VhABLLuARJs/yMO4Rk8+qQnPrHSTx6YCwFB3tIunIgQHwb4Ol
	 K8C2LAICEJvkRYMkaMWxaqF1cJGOIsSr5UDq3R5k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Titas <novatitas366@gmail.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 485/568] HID: amd_sfh: Stop sensor before starting
Date: Wed,  3 Dec 2025 16:28:07 +0100
Message-ID: <20251203152458.466288715@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152440.645416925@linuxfoundation.org>
References: <20251203152440.645416925@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[ Upstream commit 4d3a13afa8b64dc49293b3eab3e7beac11072c12 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_init.c
@@ -163,6 +163,8 @@ static int amd_sfh1_1_hid_client_init(st
 		if (rc)
 			goto cleanup;
 
+		mp2_ops->stop(privdata, cl_data->sensor_idx[i]);
+		amd_sfh_wait_for_response(privdata, cl_data->sensor_idx[i], DISABLE_SENSOR);
 		writel(0, privdata->mmio + AMD_P2C_MSG(0));
 		mp2_ops->start(privdata, info);
 		status = amd_sfh_wait_for_response



