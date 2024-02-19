Return-Path: <stable+bounces-20603-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0624085A8BB
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABE01F22366
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A163D558;
	Mon, 19 Feb 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJxfUZ9G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DA03D553
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359595; cv=none; b=uRziXbS94AgSS6GpGp5ut0kumgLnTmN2n0cat8sYCbjT5x933hAKkwZ9Vpc7w1I6M8c41jcB8MAVyrU9NVrvteVYO3KULLMGEPB42ZRm6zz53SxxiwHpc+aziEmXGkkR1d0mk5LiAZg++Ak24sKaGLNyAqXPl0IX7X5EZIONb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359595; c=relaxed/simple;
	bh=jqUv6gOrASFFAoii57v0YkmDrHftMjRUoLAi/Wlvv9I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Zb2m40UeBb270vMbziRtmdB+BtL4D3aH+1xleph6cWcwxcjKzS8D4H87MAsdxxY4KNwA+r1YeYmLPuqBhVdE02g8bTiag6a3nfZcSzBIb3jjGh8SxeBnsOiwquPXGkTDt7VP+cEQG1N3j5OAutwY5u3B2s/7LxN/qEaZhexH/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJxfUZ9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B46C433C7;
	Mon, 19 Feb 2024 16:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359594;
	bh=jqUv6gOrASFFAoii57v0YkmDrHftMjRUoLAi/Wlvv9I=;
	h=Subject:To:Cc:From:Date:From;
	b=UJxfUZ9Guat0lemu8Zqiex6+/13bQ1HntAjxDIjTrQH59AUsxD/6jrgkqjTr+agju
	 ewkBaW9dRZZ9Vwr04f28a27gDHz6PABAjxG1u4MQP399bzInWUhzvgvKxu2sNmMfC4
	 v8FNEdwUsXL79LDkGnHEUomAySSd/N84ttJUshuk=
Subject: FAILED: patch "[PATCH] Revert "drm/amd/display: increased min_dcfclk_mhz and" failed to apply to 6.6-stable tree
To: sohaib.nadeem@amd.com,alexander.deucher@amd.com,alvin.lee2@amd.com,aurabindo.pillai@amd.com,daniel.wheeler@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:19:43 +0100
Message-ID: <2024021943-laziness-crabgrass-a841@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a538dabf772c169641e151834e161e241802ab33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021943-laziness-crabgrass-a841@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

a538dabf772c ("Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"")
2ff33c759a42 ("drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a538dabf772c169641e151834e161e241802ab33 Mon Sep 17 00:00:00 2001
From: Sohaib Nadeem <sohaib.nadeem@amd.com>
Date: Mon, 29 Jan 2024 17:33:40 -0500
Subject: [PATCH] Revert "drm/amd/display: increased min_dcfclk_mhz and
 min_fclk_mhz"

[why]:
This reverts commit 2ff33c759a4247c84ec0b7815f1f223e155ba82a.

The commit caused corruption when running some applications in fullscreen

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sohaib Nadeem <sohaib.nadeem@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index ba76dd4a2ce2..a0a65e099104 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2760,7 +2760,7 @@ static int build_synthetic_soc_states(bool disable_dc_mode_overwrite, struct clk
 	struct _vcs_dpi_voltage_scaling_st entry = {0};
 	struct clk_limit_table_entry max_clk_data = {0};
 
-	unsigned int min_dcfclk_mhz = 399, min_fclk_mhz = 599;
+	unsigned int min_dcfclk_mhz = 199, min_fclk_mhz = 299;
 
 	static const unsigned int num_dcfclk_stas = 5;
 	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {199, 615, 906, 1324, 1564};


