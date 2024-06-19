Return-Path: <stable+bounces-53721-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F8290E5CF
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 10:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6DE1C216B2
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 08:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B00779B84;
	Wed, 19 Jun 2024 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HWKvTcNe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595BD5FBB1
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 08:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786233; cv=none; b=BjYVdDuvcs966BeTG/hTMbcSwuBlwxiayMWV+sZysdWIUanGmdslnTUXyX4fhUARMiTVlIqLIoPT28xvSIom9uI7QS2y5HilsZFdC5PWNO90w6XzpsOyAiGkKx4ChkwitVAi4TpxpeChTwTSYm4NzUiX2kM99ARPlco8R4UHezE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786233; c=relaxed/simple;
	bh=bE3vXBEYda/jkCpg0QD88hKR6uOIHoKb5qB0rewcZLM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lUEQK6/hRxgl9CaQkbdRzP3FWku2fbsQSQUBt8i+Bq4Nscoqu0LxH6Z0946YKQijM7azFhbLvhXd0fP1NjnI0FapbySE1C//PyvEy2fSWZ+DneZlY5/OeTRyh5jORR7TEmPzh52T744bzE1rY4VhTClP2o/hsWGu81Y00TGAooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HWKvTcNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2558C4AF48;
	Wed, 19 Jun 2024 08:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718786233;
	bh=bE3vXBEYda/jkCpg0QD88hKR6uOIHoKb5qB0rewcZLM=;
	h=Subject:To:Cc:From:Date:From;
	b=HWKvTcNelDE6drHw2EEaqUbnanOl/Tou/37Cxslmrh1frsSzTpn33QGmiJUTmefya
	 c6eQ+JDLFe/uY4rr7bfu1Ve7IoS7F7j3ww0kWlwpc24PnYgFtidJ7OwXIZy5m3rVW9
	 vAaxVsEPhcUZj2KSPf4EIQIDvfqfGGBN1jAkfsSQ=
Subject: FAILED: patch "[PATCH] drm/amd/display: Fix bounds check for dcn35 DcfClocks" failed to apply to 6.9-stable tree
To: roman.li@amd.com,alexander.deucher@amd.com,chiahsuan.chung@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com,sunpeng.li@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Jun 2024 10:37:06 +0200
Message-ID: <2024061905-smile-justice-3ee1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.9-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.9.y
git checkout FETCH_HEAD
git cherry-pick -x a13ad81951c1334a2ddd0225929552f2eb7f074c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061905-smile-justice-3ee1@gregkh' --subject-prefix 'PATCH 6.9.y' HEAD^..

Possible dependencies:

a13ad81951c1 ("drm/amd/display: Fix bounds check for dcn35 DcfClocks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a13ad81951c1334a2ddd0225929552f2eb7f074c Mon Sep 17 00:00:00 2001
From: Roman Li <roman.li@amd.com>
Date: Wed, 13 Mar 2024 18:35:13 -0400
Subject: [PATCH] drm/amd/display: Fix bounds check for dcn35 DcfClocks

[Why]
NumFclkLevelsEnabled is used for DcfClocks bounds check
instead of designated NumDcfClkLevelsEnabled.
That can cause array index out-of-bounds access.

[How]
Use designated variable for dcn35 DcfClocks bounds check.

Fixes: a8edc9cc0b14 ("drm/amd/display: Fix array-index-out-of-bounds in dcn35_clkmgr")
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 928d61f9f858..8efde1cfb49a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -715,7 +715,7 @@ static void dcn35_clk_mgr_helper_populate_bw_params(struct clk_mgr_internal *clk
 		clock_table->NumFclkLevelsEnabled;
 	max_fclk = find_max_clk_value(clock_table->FclkClocks_Freq, num_fclk);
 
-	num_dcfclk = (clock_table->NumFclkLevelsEnabled > NUM_DCFCLK_DPM_LEVELS) ? NUM_DCFCLK_DPM_LEVELS :
+	num_dcfclk = (clock_table->NumDcfClkLevelsEnabled > NUM_DCFCLK_DPM_LEVELS) ? NUM_DCFCLK_DPM_LEVELS :
 		clock_table->NumDcfClkLevelsEnabled;
 	for (i = 0; i < num_dcfclk; i++) {
 		int j;


