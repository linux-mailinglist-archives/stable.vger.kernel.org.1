Return-Path: <stable+bounces-192806-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E967DC437B3
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 04:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F5FE4E18F2
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 03:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BB678F2B;
	Sun,  9 Nov 2025 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lo6Kller"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A27483
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762657969; cv=none; b=pEgmIR804MskKBfFVkldTZQIr8qHKC44PlFb2nwvnA8jOvi0j1nScjafIsjhpiOtbCATlrYN0VoaCHDtcvLjm9B2sLi5zF4Lpdmg9Fv+GCdZNp/zbZOlcba2IyxwIjbDDKadx6ICEtx6XERwcRemHpUQ+tv8edfhFZYCOm4o29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762657969; c=relaxed/simple;
	bh=kho6qm4c9qyMviDljGhc2431wAGC/4iKqY4xRGbgZSI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dCMgwpX8P8+qz4wwX4asy/KMp6Adr/KVCxKVn1cQUbg5uFHRXza+d1oLQ1e2LcydPBQKBjRSYtyk1bcR5M3ccJ8/zIRx9ZYSQ+4XXQBY3iHx5ssz9VuZqndaJtUgtg+YeLuRh6uklVe7BKfW+1oe4EF3FMjUPqO1n6/N3qewBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lo6Kller; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8788DC116D0;
	Sun,  9 Nov 2025 03:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762657967;
	bh=kho6qm4c9qyMviDljGhc2431wAGC/4iKqY4xRGbgZSI=;
	h=Subject:To:Cc:From:Date:From;
	b=lo6KllerVWi3kVIbXvW+j6RowzujBcXagD3DuZOEZ9VThdNltslTCLO1Jc2si7HZr
	 0n8dnn5ikapjwTbBkPnMF0CubgQKDVrWwfxnkxWoXywTX11pym1WeBcOB0Vfu+5ZBC
	 D3rO6rF3fZzCiorHq8P+LqOIvI2bfxS41PDQJqC8=
Subject: FAILED: patch "[PATCH] x86/CPU/AMD: Add missing terminator for zen5_rdseed_microcode" failed to apply to 6.12-stable tree
To: mario.limonciello@amd.com,bp@alien8.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 09 Nov 2025 12:12:44 +0900
Message-ID: <2025110944-strenuous-hydrant-ea0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f1fdffe0afea02ba783acfe815b6a60e7180df40
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025110944-strenuous-hydrant-ea0b@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f1fdffe0afea02ba783acfe815b6a60e7180df40 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 4 Nov 2025 10:10:06 -0600
Subject: [PATCH] x86/CPU/AMD: Add missing terminator for zen5_rdseed_microcode

Running x86_match_min_microcode_rev() on a Zen5 CPU trips up KASAN for an out
of bounds access.

Fixes: 607b9fb2ce248 ("x86/CPU/AMD: Add RDSEED fix for Zen5")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20251104161007.269885-1-mario.limonciello@amd.com

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 8e36964a7721..2ba9f2d42d8c 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1038,6 +1038,7 @@ static void init_amd_zen4(struct cpuinfo_x86 *c)
 static const struct x86_cpu_id zen5_rdseed_microcode[] = {
 	ZEN_MODEL_STEP_UCODE(0x1a, 0x02, 0x1, 0x0b00215a),
 	ZEN_MODEL_STEP_UCODE(0x1a, 0x11, 0x0, 0x0b101054),
+	{},
 };
 
 static void init_amd_zen5(struct cpuinfo_x86 *c)


