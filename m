Return-Path: <stable+bounces-10126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D74F827290
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66921F23604
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC8D4C3A0;
	Mon,  8 Jan 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I0XIz2Ef"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A026AC1;
	Mon,  8 Jan 2024 15:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0205BC433C9;
	Mon,  8 Jan 2024 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704726841;
	bh=jxo24Twz54QXZWiya9/zEVDswklcCshhDl2+avYbA0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0XIz2EfhQwjB057RiTsuBoZKaxEUmuHhOAmsxqjPT/kB7UDl83hK1d1aNlTbDXcr
	 wqavYGmKmL3P2wjHZmMlruH1OpiYKMT1faRQbbGX71FVu8xNkTCD8w7NHvWw0e2tTD
	 VsT32wKDSs/kpysop5A1Rv7IbgUicDsoVmXDipzg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samson Tam <samson.tam@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 096/124] drm/amd/display: Increase num voltage states to 40
Date: Mon,  8 Jan 2024 16:08:42 +0100
Message-ID: <20240108150607.380958839@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108150602.976232871@linuxfoundation.org>
References: <20240108150602.976232871@linuxfoundation.org>
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

From: Alvin Lee <alvin.lee2@amd.com>

[ Upstream commit 67e38874b85b8df7b23d29f78ac3d7ecccd9519d ]

[Description]
If during driver init stage there are greater than 20
intermediary voltage states while constructing the SOC
BB we could hit issues because we will index outside of the
clock_limits array and start overwriting data. Increase the
total number of states to 40 to avoid this issue.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dc_features.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
index 2cbdd75429ffd..6e669a2c5b2d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dc_features.h
@@ -36,7 +36,7 @@
  * Define the maximum amount of states supported by the ASIC. Every ASIC has a
  * specific number of states; this macro defines the maximum number of states.
  */
-#define DC__VOLTAGE_STATES 20
+#define DC__VOLTAGE_STATES 40
 #define DC__NUM_DPP__4 1
 #define DC__NUM_DPP__0_PRESENT 1
 #define DC__NUM_DPP__1_PRESENT 1
-- 
2.43.0




