Return-Path: <stable+bounces-131404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE4A80997
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D641BA2ACF
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C615F268FE4;
	Tue,  8 Apr 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P2G9MKCC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD226983B;
	Tue,  8 Apr 2025 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116305; cv=none; b=SR8VA5W8TZmWgnxrjWPKxGra7Nrj33ez0TYY9rnAltxy3dMT09PrlFod1rES7voId/dQsVxhAFhzUgMGCYRzsRNo+B57VKxrxZ5LVnnUi4KUJQwIzYnzBeqS5Zx4mo46EcBW8/+g0YZR/kRisyAaHar53k3zklGAKUZCDEv3iJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116305; c=relaxed/simple;
	bh=V31CkFDVEMXWJpzkDgIYkykToty07YD4AclOfY0Dvrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQfXUKoQyiyrJAT2WBqVHLxh/tT0nuuCqb8RrzuWovbdKTG4yRXqcNaIUfdjad5SenX8ZB+LfSbaZpRGu/+s0zEfuQ2CqZzw82FzylfRVLqBdxpWHkG0Kk5M8QB/raH5TfJWPhz60hP8M5xYzOpHXR1RQIILvk/Dbvj6Wh3moXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P2G9MKCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C60C4CEE5;
	Tue,  8 Apr 2025 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116305;
	bh=V31CkFDVEMXWJpzkDgIYkykToty07YD4AclOfY0Dvrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2G9MKCCD42uyN8rLuaV9bVlEk8zOv3Pnmr71P2YUflXifjQufyEryq/TJ+W9UP/w
	 d4Zy/vEotc0WT70HmvAeJ/rqjjr40MBhPP8JIgZmvfUd0ZYd0DHWd9ax9pWahSbuyM
	 Tk1TQdlJv2G2XZmT5N4LgFboe1jyf/oc0sE/WNU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Imre Deak <imre.deak@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Harry Wentland <hwentlan@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Wayne Lin <Wayne.Lin@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 051/423] drm/dp_mst: Fix drm RAD print
Date: Tue,  8 Apr 2025 12:46:17 +0200
Message-ID: <20250408104846.936724026@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wayne Lin <Wayne.Lin@amd.com>

[ Upstream commit 6bbce873a9c97cb12f5455c497be279ac58e707f ]

[Why]
The RAD of sideband message printed today is incorrect.
For RAD stored within MST branch
- If MST branch LCT is 1, it's RAD array is untouched and remained as 0.
- If MST branch LCT is larger than 1, use nibble to store the up facing
  port number in cascaded sequence as illustrated below:

  u8 RAD[0] = (LCT_2_UFP << 4) | LCT_3_UFP
     RAD[1] = (LCT_4_UFP << 4) | LCT_5_UFP
     ...

In drm_dp_mst_rad_to_str(), it wrongly to use BIT_MASK(4) to fetch the port
number of one nibble.

[How]
Adjust the code by:
- RAD array items are valuable only for LCT >= 1.
- Use 0xF as the mask to replace BIT_MASK(4)

V2:
- Document how RAD is constructed (Imre)

V3:
- Adjust the comment for rad[] so kdoc formats it properly (Lyude)

Fixes: 2f015ec6eab6 ("drm/dp_mst: Add sideband down request tracing + selftests")
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Lyude Paul <lyude@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250113091100.3314533-2-Wayne.Lin@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 8 ++++----
 include/drm/display/drm_dp_mst_helper.h       | 7 +++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index da6ff36623d30..3e5f721d75400 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -179,13 +179,13 @@ static int
 drm_dp_mst_rad_to_str(const u8 rad[8], u8 lct, char *out, size_t len)
 {
 	int i;
-	u8 unpacked_rad[16];
+	u8 unpacked_rad[16] = {};
 
-	for (i = 0; i < lct; i++) {
+	for (i = 1; i < lct; i++) {
 		if (i % 2)
-			unpacked_rad[i] = rad[i / 2] >> 4;
+			unpacked_rad[i] = rad[(i - 1) / 2] >> 4;
 		else
-			unpacked_rad[i] = rad[i / 2] & BIT_MASK(4);
+			unpacked_rad[i] = rad[(i - 1) / 2] & 0xF;
 	}
 
 	/* TODO: Eventually add something to printk so we can format the rad
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/drm_dp_mst_helper.h
index a80ba457a858f..6398a6b50bd1b 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -222,6 +222,13 @@ struct drm_dp_mst_branch {
 	 */
 	struct list_head destroy_next;
 
+	/**
+	 * @rad: Relative Address of the MST branch.
+	 * For &drm_dp_mst_topology_mgr.mst_primary, it's rad[8] are all 0,
+	 * unset and unused. For MST branches connected after mst_primary,
+	 * in each element of rad[] the nibbles are ordered by the most
+	 * signifcant 4 bits first and the least significant 4 bits second.
+	 */
 	u8 rad[8];
 	u8 lct;
 	int num_ports;
-- 
2.39.5




