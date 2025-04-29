Return-Path: <stable+bounces-138360-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F30AA17A9
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8AD4C502A
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450D624500A;
	Tue, 29 Apr 2025 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EDWh2GAN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01696221DA7;
	Tue, 29 Apr 2025 17:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745948983; cv=none; b=lj/xXhJuTCxNPcQclDsy2uCMZzU6OfYm4UK7aCLNsao2rZaK+Db6XgCwpnx9P6WiyzsoSjLnrsJIHOJU6eyixn3geeZt2M3yAic7QAzx92hvuhocNMbxr6TaC4a5xFTDokIkq8KI3u+TQ3xE73Of7Z2y7Fwzx0TtimMaReYpFyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745948983; c=relaxed/simple;
	bh=OEEPbKPOQtTCj+Tk5nEHJ55VTnK+hbizZkefjf0usGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gO1wWqQs96m9fwM4JP7ynSk0J7q6/pNlVaiBhWM4SLRfjyQeEfWiiuiPOiRfv7Mivl2dBOgLsz5096uE375GbCJ4jMjpQIipzxLCbYW3Tz4U867FvIZi4OBsVf1lo90dKmRAURJjbmzm4gPcXduif/Blu8xQ7N64q5dv76dDuhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EDWh2GAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6628BC4CEE3;
	Tue, 29 Apr 2025 17:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745948982;
	bh=OEEPbKPOQtTCj+Tk5nEHJ55VTnK+hbizZkefjf0usGg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EDWh2GANpNb3jV56Wymznw/LxzsyWTLKjyJve/fG0f/BbL4PufyT5lRUVDAW7LHdr
	 w9MBdomnMGU70CE5ZkTPQXjNACnbrNdr9/5J40ZqXp9z6aSeoca4HmRdtyP+K2hfrB
	 nrBF71/zyTHsghGg394VpIC2kYa55pNIF7OE9IvA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Denis Arefev <arefev@swemel.ru>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 181/373] drm/amd/pm/swsmu/smu13/smu_v13_0: Prevent division by zero
Date: Tue, 29 Apr 2025 18:40:58 +0200
Message-ID: <20250429161130.610231895@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161123.119104857@linuxfoundation.org>
References: <20250429161123.119104857@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Arefev <arefev@swemel.ru>

commit f23e9116ebb71b63fe9cec0dcac792aa9af30b0c upstream.

The user can set any speed value.
If speed is greater than UINT_MAX/8, division by zero is possible.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c05d1c401572 ("drm/amd/swsmu: add aldebaran smu13 ip support (v3)")
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -1154,7 +1154,7 @@ int smu_v13_0_set_fan_speed_rpm(struct s
 	int ret;
 	uint32_t tach_period, crystal_clock_freq;
 
-	if (!speed)
+	if (!speed || speed > UINT_MAX/8)
 		return -EINVAL;
 
 	ret = smu_v13_0_auto_fan_control(smu, 0);



