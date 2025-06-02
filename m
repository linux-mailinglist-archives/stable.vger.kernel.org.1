Return-Path: <stable+bounces-148917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B09DACABE6
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838F8189DA3E
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 09:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813A1E3DD0;
	Mon,  2 Jun 2025 09:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k0oO7AHQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584CF1E3790
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748857713; cv=none; b=J+mplgsad5Aqx2X+seu9meNnFo3mA871YC/S/QT6uP4A+YA1EEGQ59I2OqAinTjbgHLTqM2F7T++NFglH3HD7AJIYwuPxRstbkhf4r6AQfa6lmLXKkCpGiBbtUi5XaaUyaJ9Yx/gE94fbA0CSd9P2zZqQpDR5Fzm5BSetJ+yArw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748857713; c=relaxed/simple;
	bh=X6bwypIUW11Fe+Lyoqt4MPj8ZT+/eY8y9icyfT+9Lvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Sgj60LjfnTqX+pmbvPHs8OD8xwY1dJjkCSR7kcissuRvQGSt05gqgN1IhYZwyXCVAatAW32SqUp2wyBfJJd/CIZ2GE45PQGYPfHKgufXsCzaWrqvHLU8ckdjsAVVc2jw2l3Ee+o/jAa1cPsuYBVWam5XNEVd7c95FOC+fhtH6sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k0oO7AHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6322BC4CEEB;
	Mon,  2 Jun 2025 09:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748857712;
	bh=X6bwypIUW11Fe+Lyoqt4MPj8ZT+/eY8y9icyfT+9Lvc=;
	h=Subject:To:Cc:From:Date:From;
	b=k0oO7AHQN6+fKAklovsTbU/DCeGiq9UzbstRUXvtH091USnfZyiY8trR1Ol1A5HPk
	 veBxG0O0ln54pLDfi7MdQf0w3GNXHs4Q57ct3NXM5ws+Dzg4KclDCPist24ICYATVt
	 I6glxEcQ/c8l8uV4PggsDNHGqrQUccD1CpYw8NVg=
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0" failed to apply to 5.10-stable tree
To: jm@ti.com,m-shah@ti.com,nm@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Jun 2025 11:48:19 +0200
Message-ID: <2025060219-slicing-gargle-f481@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f55c9f087cc2e2252d44ffd9d58def2066fc176e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025060219-slicing-gargle-f481@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f55c9f087cc2e2252d44ffd9d58def2066fc176e Mon Sep 17 00:00:00 2001
From: Judith Mendez <jm@ti.com>
Date: Tue, 29 Apr 2025 12:30:08 -0500
Subject: [PATCH] arm64: dts: ti: k3-am65-main: Add missing taps to sdhci0

For am65x, add missing ITAPDLYSEL values for Default Speed and High
Speed SDR modes to sdhci0 node according to the device datasheet [0].

[0] https://www.ti.com/lit/gpn/am6548

Fixes: eac99d38f861 ("arm64: dts: ti: k3-am654-main: Update otap-del-sel values")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://lore.kernel.org/r/20250429173009.33994-1-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 6d3c467d7038..b085e7361116 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -449,6 +449,8 @@ sdhci0: mmc@4f80000 {
 		ti,otap-del-sel-mmc-hs = <0x0>;
 		ti,otap-del-sel-ddr52 = <0x5>;
 		ti,otap-del-sel-hs200 = <0x5>;
+		ti,itap-del-sel-legacy = <0xa>;
+		ti,itap-del-sel-mmc-hs = <0x1>;
 		ti,itap-del-sel-ddr52 = <0x0>;
 		dma-coherent;
 		status = "disabled";


