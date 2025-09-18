Return-Path: <stable+bounces-173026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 180C9B35B6B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92B91BA223E
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13B633CEB0;
	Tue, 26 Aug 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zmEAKCup"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD7B33CE96;
	Tue, 26 Aug 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207183; cv=none; b=fhM6AdS0GVFwQpzLlrk93JBXspxQB5yaQpdgdp5tBWw9mnfS2K7Yo7O/nz+CL0wjLXNM92V+8uZTbZNnVHkAIpZma6V1szzoBKbMQrojAIqaPLxPnBFc4rIFfnqgtDD+cqguABJDsfXtiJO1vsSRHAtfu4S4C9/sZ45XXlf8ASc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207183; c=relaxed/simple;
	bh=/oFWBYRPJJzc2UuOBtItuHHi7XHIIaglcUqZ9h/DLrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcT6+U26M8lwtnrTBIfpJOJx4PukLXlw1iqHDBMm/KC8mFBz+Ss1XM4TDg8fGfh3yagpGJBHP0TLmRHXPQhYX6O8UedmEcmfUGqdK9EMl2dcxK2JrGBayremkwxaJAP2S3nDsUlr6uOFgY0gdzNKR80FbT72jb6syMjqsHBCwgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zmEAKCup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB2EC4CEF1;
	Tue, 26 Aug 2025 11:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207183;
	bh=/oFWBYRPJJzc2UuOBtItuHHi7XHIIaglcUqZ9h/DLrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zmEAKCupRQg7VQQd4sc3fW88q3Ue9zQNAPoItVYlZ+3l1NN8GWBxMdsyRkjzlpP8t
	 VlKdys3+okEWKzJ0pIKApJgvXPnH0uVyTRTNyxOxv5OaYTw9Wm3h58EgSlO7VgsKLz
	 C90A5oabTGwg2saLPckvhD+4goXBSM6anVKZXwMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 6.16 051/457] arm64: dts: ti: k3-pinctrl: Enable Schmitt Trigger by default
Date: Tue, 26 Aug 2025 13:05:35 +0200
Message-ID: <20250826110938.612511026@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

commit 5b272127884bded21576a6ddceca13725a351c63 upstream.

Switch Schmitt Trigger functions for PIN_INPUT* macros by default. This is
HW PoR configuration, the slew rate requirements without ST enabled are
pretty tough for these devices. We've noticed spurious GPIO interrupts even
with noise-free edges but not meeting slew rate requirements (3.3E+6 V/s
for 3.3v LVCMOS).

It's not obvious why one might want to disable the PoR-enabled ST on any
pin. Just enable it by default. As it's not possible to provide OR-able
macros to disable the ST, shall anyone require it, provide a set of
new macros with _NOST suffix.

Fixes: fe49f2d776f7 ("arm64: dts: ti: Use local header for pinctrl register values")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Link: https://lore.kernel.org/r/20250701105437.3539924-1-alexander.sverdlin@siemens.com
[vigneshr@ti.com: Add Fixes tag]
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/ti/k3-pinctrl.h |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

--- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
+++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
@@ -8,6 +8,7 @@
 #ifndef DTS_ARM64_TI_K3_PINCTRL_H
 #define DTS_ARM64_TI_K3_PINCTRL_H
 
+#define ST_EN_SHIFT		(14)
 #define PULLUDEN_SHIFT		(16)
 #define PULLTYPESEL_SHIFT	(17)
 #define RXACTIVE_SHIFT		(18)
@@ -19,6 +20,10 @@
 #define DS_PULLUD_EN_SHIFT	(27)
 #define DS_PULLTYPE_SEL_SHIFT	(28)
 
+/* Schmitt trigger configuration */
+#define ST_DISABLE		(0 << ST_EN_SHIFT)
+#define ST_ENABLE		(1 << ST_EN_SHIFT)
+
 #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
 #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
 
@@ -32,9 +37,13 @@
 #define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
 #define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
 #define PIN_OUTPUT_PULLDOWN	(INPUT_DISABLE | PULL_DOWN)
-#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
-#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
-#define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)
+#define PIN_INPUT		(INPUT_EN | ST_ENABLE | PULL_DISABLE)
+#define PIN_INPUT_PULLUP	(INPUT_EN | ST_ENABLE | PULL_UP)
+#define PIN_INPUT_PULLDOWN	(INPUT_EN | ST_ENABLE | PULL_DOWN)
+/* Input configurations with Schmitt Trigger disabled */
+#define PIN_INPUT_NOST		(INPUT_EN | PULL_DISABLE)
+#define PIN_INPUT_PULLUP_NOST	(INPUT_EN | PULL_UP)
+#define PIN_INPUT_PULLDOWN_NOST	(INPUT_EN | PULL_DOWN)
 
 #define PIN_DEBOUNCE_DISABLE	(0 << DEBOUNCE_SHIFT)
 #define PIN_DEBOUNCE_CONF1	(1 << DEBOUNCE_SHIFT)



