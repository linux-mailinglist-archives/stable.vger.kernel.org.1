Return-Path: <stable+bounces-156059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFB8AE44F9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 15:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B72044183E
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 13:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEFD252910;
	Mon, 23 Jun 2025 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c2UDhPkR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71F2522A8;
	Mon, 23 Jun 2025 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750686035; cv=none; b=p5mQK4j+PLVoiPeG1kbfJ85V8SlCha8Fuo4KUz1k4kmB1eav11SFLwh8S+/UhLdhN/QyQXtmDaoitY0iXAlJOG+H0wbCcgJGCYLl9QYteMCSIH5rHwihAJQ7BXQA8fPBROUcCbWbMB8sxJRAhtZVhZKY8EJiZR7cm6RDBLzCucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750686035; c=relaxed/simple;
	bh=KDNYyEyFApfX/4sfkVGXVT6G+Z3XfsPX7E52nQXoUxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTZOqubrZXl/QGH2HjkjcR9Qo1k/vlahNxP5AsDnNccFFBD3Lm210M6RJOPdj4gdzClYouYRVIvYLjqNK3sBwumUeCEV5OPjVIt3cvpmjKPJpVnQK/qu5CKejxORscMs6jvjzWG9HtRj+OHlYjikRhFYuUCuLyprgR6Y9N3ychA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c2UDhPkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF230C4CEEA;
	Mon, 23 Jun 2025 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750686035;
	bh=KDNYyEyFApfX/4sfkVGXVT6G+Z3XfsPX7E52nQXoUxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c2UDhPkRpLc4icTMusvtAdM4LVeD2VjmTYnEavFyBiJYkSyJ+1mR36Tpu5VKn9xsE
	 ozfUlJp9bT3oGYXqMazj4ReIisAi+WjFuj1o1k5A/0YehlaK8/BwaqorOFsSXwGkks
	 xQbsJWRXmrwOBqZkhf9/QseGVi3syIFkMGeLQaFY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 076/411] ARM: dts: at91: at91sam9263: fix NAND chip selects
Date: Mon, 23 Jun 2025 15:03:40 +0200
Message-ID: <20250623130635.287247299@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit c72ede1c24be689733bcd2233a3a56f2478429c8 ]

NAND did not work on my USB-A9263. I discovered that the offending
commit converted the PIO bank for chip selects wrongly, so all A9263
boards need to be fixed.

Fixes: 1004a2977bdc ("ARM: dts: at91: Switch to the new NAND bindings")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20250402210446.5972-2-wsa+renesas@sang-engineering.com
Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91sam9263ek.dts | 2 +-
 arch/arm/boot/dts/tny_a9263.dts     | 2 +-
 arch/arm/boot/dts/usb_a9263.dts     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 71f60576761a0..df206bdb67883 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -148,7 +148,7 @@
 				nand@3 {
 					reg = <0x3 0x0 0x800000>;
 					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
-					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
 					nand-bus-width = <8>;
 					nand-ecc-mode = "soft";
 					nand-on-flash-bbt;
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/tny_a9263.dts
index 62b7d9f9a926c..c8b6318aaa838 100644
--- a/arch/arm/boot/dts/tny_a9263.dts
+++ b/arch/arm/boot/dts/tny_a9263.dts
@@ -64,7 +64,7 @@
 				nand@3 {
 					reg = <0x3 0x0 0x800000>;
 					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
-					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
 					nand-bus-width = <8>;
 					nand-ecc-mode = "soft";
 					nand-on-flash-bbt;
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/usb_a9263.dts
index d1c07503ff76f..87a5f96014e01 100644
--- a/arch/arm/boot/dts/usb_a9263.dts
+++ b/arch/arm/boot/dts/usb_a9263.dts
@@ -84,7 +84,7 @@
 				nand@3 {
 					reg = <0x3 0x0 0x800000>;
 					rb-gpios = <&pioA 22 GPIO_ACTIVE_HIGH>;
-					cs-gpios = <&pioA 15 GPIO_ACTIVE_HIGH>;
+					cs-gpios = <&pioD 15 GPIO_ACTIVE_HIGH>;
 					nand-bus-width = <8>;
 					nand-ecc-mode = "soft";
 					nand-on-flash-bbt;
-- 
2.39.5




