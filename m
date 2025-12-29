Return-Path: <stable+bounces-203663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C840CE745D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029B8301EC5D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1911B32C92D;
	Mon, 29 Dec 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zf6ZdHHl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACDA32B98B
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767023881; cv=none; b=nvq3aXAfoJYmRr6jozeDfg6Dy9TzqaAFkhShnDSk5YkMuZ7B3gcK2fDnqcvjN+7ztA6H4Y0BzA23UILxCG/oWyHmVWOdU8ZrjRGC06ZBF3tFQfsLXqTI4d7RZxclKd4cHoVYCyN/mfSNjx1f0OZ94tCRcJcnNvNlw4bU1eNApaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767023881; c=relaxed/simple;
	bh=GI7akux6Uy+T0xyK20ls9XEh821erwd0415iZiUlxQc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A5j60ZQJznl0NJXpeih7nwq+pFk/lnSMgc8hi9u8DT4ITMDgx1yx75sI1CuEvY/o73QllZPLBYEWuWiwWiGVsZavn+HkJ7gPsUbWILBNFKf+5W1BjmMDxlwpReTjx6nenH/5SuHYvzpZLKCTBybTvkRagJALDtYb+B10Mq30T7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zf6ZdHHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F301C16AAE;
	Mon, 29 Dec 2025 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767023881;
	bh=GI7akux6Uy+T0xyK20ls9XEh821erwd0415iZiUlxQc=;
	h=Subject:To:Cc:From:Date:From;
	b=zf6ZdHHlJ754B2reG6ePyWqssEehCYCncRIaDq6YMmYFdwpZHKYkuZZVdAVhsfYwt
	 qu2RLBlDXrn023D7nIWbogug+obIJe5JTgcaNps0Scn3BZjqTVLH/wXgYJIoFn3dO/
	 xzHeoVJXFu9mmqHQHuc0z6gbqQClcpBlO6rMtgKk=
Subject: FAILED: patch "[PATCH] ARM: dts: microchip: sama7g5: fix uart fifo size to 32" failed to apply to 6.12-stable tree
To: nicolas.ferre@microchip.com,claudiu.beznea@tuxon.dev
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 16:57:58 +0100
Message-ID: <2025122958-dingbat-canary-d44c@gregkh>
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
git cherry-pick -x 5654889a94b0de5ad6ceae3793e7f5e0b61b50b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122958-dingbat-canary-d44c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


