Return-Path: <stable+bounces-72008-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811479678CC
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3731C1F21683
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D9217E900;
	Sun,  1 Sep 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wFcyjpAa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1130117DFFC;
	Sun,  1 Sep 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725208542; cv=none; b=eyW1HrYxs61TeMTXd0JoyRkWj4enWso8+BQ3h+69a29O/uMufegGmxzKelrHgf4e+8uAKblZ4FFuh/x/1albkFlk5yCDCFxpinPSsPBFHSMworu0eADboTwMS1uXJpPPxSphfV0c3AxtfzlLNC+ePZOPUmUyyl5AP1NnfFiOVd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725208542; c=relaxed/simple;
	bh=JHwSZg/VkqZiIf0HlBv0bwc7I45hBT34kJ+yXmvlq6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9TE7evM1oBEeaXK3JZVK9w5p8icZUOKWJa9o1aZbZ6TJj+26IcfAN3ycVII2Hjb1ytdJ21I/E9/6F9ka+zm3Zo02KTb01Zu7fuyGupOf1r4S1+ec3NRvOWWR7Wyxk27szllXajL2zwxKoR4H/lF74pfMOXUHC0yCQqef/zo0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wFcyjpAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A83C4CEC3;
	Sun,  1 Sep 2024 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725208541;
	bh=JHwSZg/VkqZiIf0HlBv0bwc7I45hBT34kJ+yXmvlq6E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wFcyjpAal5PHWDFJdxjpB97rgzVqwr5cbsPi3Wq1Z0PMXlG9DwjlZhPLvsFxlDsDb
	 wqDZCkt32xXtRjrpw/nEgkyhWB1wucPzKqBOLHMFfKgAQBnydI9WRRa9PHW9Lt89fK
	 u5EX5zNVNbFcYTsCJvXk8sv7dOEX2UBTURavuAq8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Karthik Poosa <karthik.poosa@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 113/149] drm/xe/hwmon: Fix WRITE_I1 param from u32 to u16
Date: Sun,  1 Sep 2024 18:17:04 +0200
Message-ID: <20240901160821.704072665@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160817.461957599@linuxfoundation.org>
References: <20240901160817.461957599@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karthik Poosa <karthik.poosa@intel.com>

[ Upstream commit 59d237c8a241168c7ae34c48244059b7bafaff38 ]

WRITE_I1 sub-command of the POWER_SETUP pcode command accepts a u16
parameter instead of u32. This change prevents potential illegal
sub-command errors.

v2: Mask uval instead of changing the prototype. (Badal)

v3: Rephrase commit message. (Badal)

Signed-off-by: Karthik Poosa <karthik.poosa@intel.com>
Fixes: 92d44a422d0d ("drm/xe/hwmon: Expose card reactive critical power")
Reviewed-by: Badal Nilawar <badal.nilawar@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240827155301.183383-1-karthik.poosa@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit a7f657097e96d8fa745c74bb1a239ebd5a8c971c)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_hwmon.c b/drivers/gpu/drm/xe/xe_hwmon.c
index d37f1dea9f8b8..bb815dbde63a6 100644
--- a/drivers/gpu/drm/xe/xe_hwmon.c
+++ b/drivers/gpu/drm/xe/xe_hwmon.c
@@ -443,7 +443,7 @@ static int xe_hwmon_pcode_write_i1(struct xe_gt *gt, u32 uval)
 {
 	return xe_pcode_write(gt, PCODE_MBOX(PCODE_POWER_SETUP,
 			      POWER_SETUP_SUBCOMMAND_WRITE_I1, 0),
-			      uval);
+			      (uval & POWER_SETUP_I1_DATA_MASK));
 }
 
 static int xe_hwmon_power_curr_crit_read(struct xe_hwmon *hwmon, int channel,
-- 
2.43.0




