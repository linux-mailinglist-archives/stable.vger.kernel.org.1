Return-Path: <stable+bounces-16182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D9683F191
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FBA6284567
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F18B200AA;
	Sat, 27 Jan 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UoXgZCby"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A91200A0
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397054; cv=none; b=ndW9GB53RT9hgov+wdWjMG2hpuPxghnJWQkuy4hRgoUC/HQwN551uCKfoBOVmOdpOO866BQeU4ZyqPG1J/8p51nvxsAVnm9quw7ku0M7N52QODEmpospF67pU97Es7XnBPS+ymvNThhKHKmyj5RCbLcCJWzSxg97hkvrLLMf4iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397054; c=relaxed/simple;
	bh=BZ/+bO/D1rhWEOANKceucQBlYAOnaZMlu4EXy4DirvA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UasHC2VviPqnoeg8K7m/2HMSKoQt1MVATMZcrXHneKrD+n6QSznf/WhR6mrOA2dmUiRy2VNLNlbKSmbSLjBAi6X09LXPSMe4q0I+95EofuKcjxbMmewsrvGGqyd3vHkfN9JXSI8Lo0wAHryr3hYBWR182Yh3NQOw7QpgbVpwNJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UoXgZCby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C74C433F1;
	Sat, 27 Jan 2024 23:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397053;
	bh=BZ/+bO/D1rhWEOANKceucQBlYAOnaZMlu4EXy4DirvA=;
	h=Subject:To:Cc:From:Date:From;
	b=UoXgZCbyVgj+759wGeQGmE7xJzQhBLeAtsdNOQNMS7LUR3TQzTQPurOfNWWFi+PS3
	 gGC0JH6p232k39pRDXsUkvZIT6ilg8qzVx4OcBSQF9OH+DYxBhMNta3ycxEodSKwRj
	 C40Pk2yIGvBxyuIcF5JNzaGVPW6GK8/81h36SZkM=
Subject: FAILED: patch "[PATCH] drm/amd/display: force toggle rate wa for first link training" failed to apply to 6.7-stable tree
To: zhongwei.zhang@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,michael.strauss@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:10:52 -0800
Message-ID: <2024012752-craving-scale-2cd4@gregkh>
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
git cherry-pick -x 5a9a2cc8ae1889c4002850b00fd4fd9691dfac4e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012752-craving-scale-2cd4@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

5a9a2cc8ae18 ("drm/amd/display: force toggle rate wa for first link training for a retimer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5a9a2cc8ae1889c4002850b00fd4fd9691dfac4e Mon Sep 17 00:00:00 2001
From: Zhongwei <zhongwei.zhang@amd.com>
Date: Wed, 8 Nov 2023 16:34:36 +0800
Subject: [PATCH] drm/amd/display: force toggle rate wa for first link training
 for a retimer

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

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
index fd8f6f198146..68096d12f52f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c
@@ -115,7 +115,7 @@ static enum link_training_result perform_fixed_vs_pe_nontransparent_training_seq
 		lt_settings->cr_pattern_time = 16000;
 
 	/* Fixed VS/PE specific: Toggle link rate */
-	apply_toggle_rate_wa = (link->vendor_specific_lttpr_link_rate_wa == target_rate);
+	apply_toggle_rate_wa = ((link->vendor_specific_lttpr_link_rate_wa == target_rate) || (link->vendor_specific_lttpr_link_rate_wa == 0));
 	target_rate = get_dpcd_link_rate(&lt_settings->link_settings);
 	toggle_rate = (target_rate == 0x6) ? 0xA : 0x6;
 
@@ -271,7 +271,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence_legacy(
 	/* Vendor specific: Toggle link rate */
 	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
 		core_link_write_dpcd(
 				link,
 				DP_LINK_BW_SET,
@@ -617,7 +617,7 @@ enum link_training_result dp_perform_fixed_vs_pe_training_sequence(
 	/* Vendor specific: Toggle link rate */
 	toggle_rate = (rate == 0x6) ? 0xA : 0x6;
 
-	if (link->vendor_specific_lttpr_link_rate_wa == rate) {
+	if (link->vendor_specific_lttpr_link_rate_wa == rate || link->vendor_specific_lttpr_link_rate_wa == 0) {
 		core_link_write_dpcd(
 				link,
 				DP_LINK_BW_SET,


