Return-Path: <stable+bounces-114614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C8A2F04E
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F4018890D5
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4018C204874;
	Mon, 10 Feb 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1qsd9wNU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F5B23CEE4
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199156; cv=none; b=OMLk/q3cgFhphHZMbnY4T18gD9i8pWxh6MdcFtECKzP8yO72teZC59URAj/lbkAKqZX/ZD8eATjmoE4awjEBcJRqjZMvD0n3wnaglNjbv8la2tNbfBz1WEXkDVmvkpXO2I/UG5q9xYrlmWgCNmt2OXCYJHu1xrPalmO512wM6B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199156; c=relaxed/simple;
	bh=RaS+UXgEnrk7+2D0jET4CqBt2W9dsBkRezbdLqGcxuk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=esVK9NaBSRtjxeS7Fwg69gyP0Yt3B/q4rG/nTLMDthJKQMzXVBhx1GZxDhO8HE9paAsvKb7dxdDVBgydwTv6y98Gu0pRc4KGrDkDuEA8J//KMeVkWDrFWqkCOLjVmzTQ6bZIFfOsaSGx3iIm4AFHGsIl4WGAkYHfEdrkU8fY564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1qsd9wNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF91C4CEDF;
	Mon, 10 Feb 2025 14:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199154;
	bh=RaS+UXgEnrk7+2D0jET4CqBt2W9dsBkRezbdLqGcxuk=;
	h=Subject:To:Cc:From:Date:From;
	b=1qsd9wNUMyjK3/3YVQGISW/8YEKLmhpGQ2GNUgBER05J7HlevE+m6F6PcZqmEjI6x
	 i1kf28DFrGV2BxEKMoAN1MW1mTo/FYhW6PazGQ1iU2wbd273wZ8m5FKY+P9j+pR5e7
	 yB6CWgYjI1inuwjxB37riZ6NxS6nOSmtk5bID7dI=
Subject: FAILED: patch "[PATCH] arm64: dts: mediatek: mt8183: Disable DSI display output by" failed to apply to 6.12-stable tree
To: wenst@chromium.org,angelogioacchino.delregno@collabora.com,fshao@chromium.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 15:52:31 +0100
Message-ID: <2025021031-unhappily-scribble-5cef@gregkh>
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
git cherry-pick -x 26f6e91fa29a58fdc76b47f94f8f6027944a490c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021031-unhappily-scribble-5cef@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26f6e91fa29a58fdc76b47f94f8f6027944a490c Mon Sep 17 00:00:00 2001
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 25 Oct 2024 15:56:28 +0800
Subject: [PATCH] arm64: dts: mediatek: mt8183: Disable DSI display output by
 default

Most SoC dtsi files have the display output interfaces disabled by
default, and only enabled on boards that utilize them. The MT8183
has it backwards: the display outputs are left enabled by default,
and only disabled at the board level.

Reverse the situation for the DSI output so that it follows the
normal scheme. For ease of backporting the DPI output is handled
in a separate patch.

Fixes: 88ec840270e6 ("arm64: dts: mt8183: Add dsi node")
Fixes: 19b6403f1e2a ("arm64: dts: mt8183: add mt8183 pumpkin board")
Cc: stable@vger.kernel.org
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Fei Shao <fshao@chromium.org>
Link: https://lore.kernel.org/r/20241025075630.3917458-2-wenst@chromium.org
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
index 61a6f66914b8..dbdee604edab 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts
@@ -522,10 +522,6 @@ &scp {
 	status = "okay";
 };
 
-&dsi0 {
-	status = "disabled";
-};
-
 &dpi0 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&dpi_func_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 8f31fc9050ec..c7008bb8a81d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -1834,6 +1834,7 @@ dsi0: dsi@14014000 {
 			resets = <&mmsys MT8183_MMSYS_SW0_RST_B_DISP_DSI0>;
 			phys = <&mipi_tx0>;
 			phy-names = "dphy";
+			status = "disabled";
 		};
 
 		dpi0: dpi@14015000 {


