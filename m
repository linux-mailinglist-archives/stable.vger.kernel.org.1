Return-Path: <stable+bounces-114541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F7A2ED41
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E3218892C0
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D94C22258D;
	Mon, 10 Feb 2025 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tQRP44sk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BAC1B0F00
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193031; cv=none; b=VKevU1WcLBJthyj4F0GTFBP7Itce+hVN5BKJE/xd/cG4VXaHAPvmFlxYGIAZR7WBooBJFE1D+HuUKn6Cm4Td/xV9ntaW75iZbRSehx6RyBARvCv4O24I5ybLi2tFNh0+W8IPHrP11QncMvkpTggdDiYQSyMNAMSfWytBWsIr9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193031; c=relaxed/simple;
	bh=f2y8NlxTVICQdj7gPCwVeCViQRrU4ZOR4EOXkxpga8I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hR6ZQkS+4KokTw/MQ/5FyLBb2Yv1N9NRN5A1ipct93zH2fcTmbxbnL7SeYHZhwe7+pFPGyk0wbs+Ujg7pjYKNOY9SQgzVNpYPT9mrR4G8dfwh+njfvmYkLSw9YQfh8jEsz5dlGF0ypkLhLyqznVKtACvw6Ja7NkvAUqtxiB8jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tQRP44sk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D116EC4CED1;
	Mon, 10 Feb 2025 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739193031;
	bh=f2y8NlxTVICQdj7gPCwVeCViQRrU4ZOR4EOXkxpga8I=;
	h=Subject:To:Cc:From:Date:From;
	b=tQRP44skdT0VLlEen0TrlwjsfTVtb5+XNg14dpKjSyMLutFKy5j/Mp/JMwTiQJohH
	 GJqVUqMJVTRef511EBLGA444ru5bu0XQ6Fjh8fxQvOL7CyQJCpdX32k7rt+KxY4/Bj
	 A8FYh2wwN2j+nB0oNu0Mse6WAK3pqna29tSfGw7Q=
Subject: FAILED: patch "[PATCH] drm/amd/display: Correct register address in dcn35" failed to apply to 6.13-stable tree
To: lo-an.chen@amd.com,alexander.deucher@amd.com,charlene.liu@amd.com,daniel.wheeler@amd.com,zaeem.mohamed@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:10:28 +0100
Message-ID: <2025021028-primp-darkening-0a43@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x f88192d2335b5a911fcfa09338cc00624571ec5e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021028-primp-darkening-0a43@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f88192d2335b5a911fcfa09338cc00624571ec5e Mon Sep 17 00:00:00 2001
From: loanchen <lo-an.chen@amd.com>
Date: Wed, 15 Jan 2025 17:43:29 +0800
Subject: [PATCH] drm/amd/display: Correct register address in dcn35

[Why]
the offset address of mmCLK5_spll_field_8 was incorrect for dcn35
which causes SSC not to be enabled.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Lo-An Chen <lo-an.chen@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 1f974ea3b0c6..1648226586e2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -89,7 +89,7 @@
 #define mmCLK1_CLK4_ALLOW_DS 0x16EA8
 #define mmCLK1_CLK5_ALLOW_DS 0x16EB1
 
-#define mmCLK5_spll_field_8 0x1B04B
+#define mmCLK5_spll_field_8 0x1B24B
 #define mmDENTIST_DISPCLK_CNTL 0x0124
 #define regDENTIST_DISPCLK_CNTL 0x0064
 #define regDENTIST_DISPCLK_CNTL_BASE_IDX 1


