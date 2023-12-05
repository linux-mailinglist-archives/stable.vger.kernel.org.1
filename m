Return-Path: <stable+bounces-4043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E858045C4
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8CE282240
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C576FAF;
	Tue,  5 Dec 2023 03:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UimgKPSM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9479B6AA0;
	Tue,  5 Dec 2023 03:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194A7C433C7;
	Tue,  5 Dec 2023 03:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701746473;
	bh=e26Iqwi2oMrhAuX8N0ilSZ7lcaCWuRCxiMzdRVjyz6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UimgKPSMdnriq+a0G2W3lyajSP0kHC1zOo72WuXDYRIwkI5uovWOZ+uTdOLnW0l4f
	 RKa4UqZe533nvbBalenUiwQqiPEcPzENYFfDiE7f1ttkqpHTjMzygPiFW6zzFIk262
	 X08r6FIQi2565rzNWlQxr5qLML6ZgHfdITa5PjrA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Michael Strauss <michael.strauss@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Zhongwei <zhongwei.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.6 036/134] drm/amd/display: force toggle rate wa for first link training for a retimer
Date: Tue,  5 Dec 2023 12:15:08 +0900
Message-ID: <20231205031537.777745704@linuxfoundation.org>
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

From: Zhongwei <zhongwei.zhang@amd.com>

commit eb28018943fed7639dfea1c9ec9c756ec692b99a upstream.

[WHY]
Handover from DMUB to driver does not perform link rate toggle.
It might cause link training failure for boot up.

[HOW]
Force toggle rate wa for first link train.
link->vendor_specific_lttpr_link_rate_wa should be zero then.

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Zhongwei <zhongwei.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -115,7 +115,7 @@ static enum link_training_result perform
 		lt_settings->cr_pattern_time = 16000;
 
 	/* Fixed VS/PE specific: Toggle link rate */
-	apply_toggle_rate_wa = (link->vendor_specific_lttpr_link_rate_wa == target_rate);
+	apply_toggle_rate_wa = ((link->vendor_specific_lttpr_link_rate_wa == target_rate) || (link->vendor_specific_lttpr_link_rate_wa == 0));
 	target_rate = get_dpcd_link_rate(&lt_settings->link_settings);
 	toggle_rate = (target_rate == 0x6) ? 0xA : 0x6;
 
@@ -271,7 +271,7 @@ enum link_training_result dp_perform_fix
 	/* Vendor specific: Toggle link rate */
 	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
 		core_link_write_dpcd(
 				link,
 				DP_LINK_BW_SET,
@@ -617,7 +617,7 @@ enum link_training_result dp_perform_fix
 	/* Vendor specific: Toggle link rate */
 	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
 		core_link_write_dpcd(
 				link,
 				DP_LINK_BW_SET,



