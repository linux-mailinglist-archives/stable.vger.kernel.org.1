Return-Path: <stable+bounces-24521-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6598694E8
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEC41C25D93
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABE113B78A;
	Tue, 27 Feb 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Py78akij"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9877A2F2D;
	Tue, 27 Feb 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042239; cv=none; b=n3dG2VXMrww1Lx3A7t1PUtAIWoXdJIv3XNXFRfmn4d7LJoxKAG/kZDagPfWlWKtwDaMKWhLhyCabz02XHI+KbXXYZPWwKc/gEYuuVpUeQiqRy5joaGJ+jORPsvzO3H7G+BWUoTpVCOkDFwTBhBT2wnkz12JXanHmdeN+8V6YRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042239; c=relaxed/simple;
	bh=rJdcQbFzdMcifnKhF4cs9R6EevEvioyVNp42uSQSMto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGZCpLsl2KKxmhnwe1UGp5IL4v1QS6kqsth8ZNZtxLNfT5Tz5fQqMgpjSkNBFIMSnp9YEkGN8ri/Z1Q46zIxhoOkbSs0mH8pPHOWF8TVeXz0rxow15QOijMvzRP3fMFAv6V70mAt2n0CFjsrqQmBw9bOBbDQngVXisL0fZ2z0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Py78akij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B56C433F1;
	Tue, 27 Feb 2024 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042239;
	bh=rJdcQbFzdMcifnKhF4cs9R6EevEvioyVNp42uSQSMto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Py78akijjWPMLYowkpvRLiwzLnHRnCIQLfhbVp6gB6Z4X7VySb0PPLn1p0pOfBz7G
	 a6pyspTbmnXVHsmJ2PstHXQHW7ZagqwQFW0/v3akdsfVB6atxqHKjEOdWPf0vDu58w
	 Fl6UtV7vnJs+6/NeJPbb2yGOXicelATiYIYfrWdQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Morgan <macromorgan@hotmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 228/299] arm64: dts: rockchip: Correct Indiedroid Nova GPIO Names
Date: Tue, 27 Feb 2024 14:25:39 +0100
Message-ID: <20240227131633.091219691@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Morgan <macromorgan@hotmail.com>

[ Upstream commit c22d03a95b0d815cd186302fdd93f74d99f1c914 ]

Correct the names given to a few of the GPIO pins. The original names
were unknowingly based on the header from a pre-production board. The
production board has a slightly different pin assignment for the 40-pin
GPIO header.

Fixes: 3900160e164b ("arm64: dts: rockchip: Add Indiedroid Nova board")
Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Link: https://lore.kernel.org/r/20240125201943.90476-2-macroalpha82@gmail.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/rockchip/rk3588s-indiedroid-nova.dts      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
index d1503a4b233a3..9299fa7e3e215 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-indiedroid-nova.dts
@@ -163,13 +163,13 @@
 
 &gpio1 {
 	gpio-line-names = /* GPIO1 A0-A7 */
-			  "HEADER_27_3v3", "HEADER_28_3v3", "", "",
+			  "HEADER_27_3v3", "", "", "",
 			  "HEADER_29_1v8", "", "HEADER_7_1v8", "",
 			  /* GPIO1 B0-B7 */
 			  "", "HEADER_31_1v8", "HEADER_33_1v8", "",
 			  "HEADER_11_1v8", "HEADER_13_1v8", "", "",
 			  /* GPIO1 C0-C7 */
-			  "", "", "", "",
+			  "", "HEADER_28_3v3", "", "",
 			  "", "", "", "",
 			  /* GPIO1 D0-D7 */
 			  "", "", "", "",
@@ -193,11 +193,11 @@
 
 &gpio4 {
 	gpio-line-names = /* GPIO4 A0-A7 */
-			  "", "", "HEADER_37_3v3", "HEADER_32_3v3",
-			  "HEADER_36_3v3", "", "HEADER_35_3v3", "HEADER_38_3v3",
+			  "", "", "HEADER_37_3v3", "HEADER_8_3v3",
+			  "HEADER_10_3v3", "", "HEADER_32_3v3", "HEADER_35_3v3",
 			  /* GPIO4 B0-B7 */
 			  "", "", "", "HEADER_40_3v3",
-			  "HEADER_8_3v3", "HEADER_10_3v3", "", "",
+			  "HEADER_38_3v3", "HEADER_36_3v3", "", "",
 			  /* GPIO4 C0-C7 */
 			  "", "", "", "",
 			  "", "", "", "",
-- 
2.43.0




