Return-Path: <stable+bounces-203667-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F94CE7469
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C07F33017F25
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02F532B9BA;
	Mon, 29 Dec 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hMs2uKQu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDDF32B9A8
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023898; cv=none; b=OCrnrT0GjZIFB/3n08hUrxB5YNO1el98C9oLswk1oaU/4k8O7qicpZuTfasJWuD62g4xvBbBUGgT+uwcCtChU9K8GjH5vWZyUcJLf6DozOM9pvi6PLW5PI5Qj31tpAijkJ5rKZC80p/+KW3pibfQWIg9Mhi5YQBnMvoAe7xyAuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023898; c=relaxed/simple;
	bh=cNRg0bU/H7s+okx5ngJR6Lcm76AyhjTlCTl+hV1SlZk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GboJULNaNwB18m63a3vxtp9gz7UxWXL9ErXM7EMj6Fmd2zm0hVnLZvJ3PWmmxzNOm8fDMImCDG6IyPO5qNn4bEkGWsc7klLAPW+yCbYJC7Uw3PRTWLCMfB9da0fs2V91ger7OyHyN3vfy75RdgUlU3HapPInbibiVda6KD5cFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hMs2uKQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E1AC4CEF7;
	Mon, 29 Dec 2025 15:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767023898;
	bh=cNRg0bU/H7s+okx5ngJR6Lcm76AyhjTlCTl+hV1SlZk=;
	h=Subject:To:Cc:From:Date:From;
	b=hMs2uKQuIEZsxMdfS5C0iqYT9X5rjqFM5ZKjmqg4vrzT/M0OK1iDx5zh/p/RVpd/c
	 Gojz2WCRR4jK7u1SQfSXL0yrCzzWlCiX2n8H1h+KUUU8z+x+RTHKeAVu9S8vn0WMFJ
	 QmPJD7yVd+3U0XE6BMmTmGtdVaLRschWBgkXusaE=
Subject: FAILED: patch "[PATCH] ARM: dts: microchip: sama7g5: fix uart fifo size to 32" failed to apply to 5.10-stable tree
To: nicolas.ferre@microchip.com,claudiu.beznea@tuxon.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 16:58:05 +0100
Message-ID: <2025122905-crawfish-unaware-fb3a@gregkh>
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
git cherry-pick -x 5654889a94b0de5ad6ceae3793e7f5e0b61b50b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122905-crawfish-unaware-fb3a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5654889a94b0de5ad6ceae3793e7f5e0b61b50b6 Mon Sep 17 00:00:00 2001
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Date: Fri, 14 Nov 2025 11:33:13 +0100
Subject: [PATCH] ARM: dts: microchip: sama7g5: fix uart fifo size to 32

On some flexcom nodes related to uart, the fifo sizes were wrong: fix
them to 32 data.

Fixes: 7540629e2fc7 ("ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek")
Cc: stable@vger.kernel.org # 5.15+
Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/r/20251114103313.20220-2-nicolas.ferre@microchip.com
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/boot/dts/microchip/sama7g5.dtsi
index 381cbcfcb34a..03ef3d9aaeec 100644
--- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
@@ -824,7 +824,7 @@ uart4: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};
@@ -850,7 +850,7 @@ uart7: serial@200 {
 				dma-names = "tx", "rx";
 				atmel,use-dma-rx;
 				atmel,use-dma-tx;
-				atmel,fifo-size = <16>;
+				atmel,fifo-size = <32>;
 				status = "disabled";
 			};
 		};


