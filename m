Return-Path: <stable+bounces-193755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5ADC4A87E
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2420D4F006B
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C239274FE3;
	Tue, 11 Nov 2025 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CtNmuSHs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ED224466D;
	Tue, 11 Nov 2025 01:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823933; cv=none; b=Zq3rcyM+rB5hOxU3qPx1e+SvwBKaRn9t7X0XfzO3N9+LYo6Aa4EibFLW6ypAQd3E4gYesKBEyGNIsp6Q8DT/VQVwhSv+MOGPAWULLf/yrUTyfrbhMQVDJEkDLIndu4d49dzZ5+48zN8Oi1UHVZTUAKB4EDUbOcmakPk9iITvcKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823933; c=relaxed/simple;
	bh=u7U5S2dSCTuV540p+1oZceXR4nhv3h9azWWEL4m+h/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZz52qpDzSQjNpN2Sd0kx5jZ8mDjbRSZRZCJ1Q8B3hcQP1hxKJd7Rm8htaHhmGCqBDjHAvTfdYbXB3XLZlixXOKDY49jTMNd/D0waqOYGASIjBAwKZFZgKMY+jTbINMN+TdAE2ah8y3nZjonA7SuFQD9TLD6CXbSr5t1RNDNjjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CtNmuSHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAA8C4AF09;
	Tue, 11 Nov 2025 01:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823932;
	bh=u7U5S2dSCTuV540p+1oZceXR4nhv3h9azWWEL4m+h/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CtNmuSHsSoX3UtdgdzizifB+oYZKvKJQEefhzVvL1EMg0yW4ScfIRVtDnlPIr5mBc
	 X25IfRZYE1rjkts1KmiBpHF/cm3Tw72d3vSqshFfMydu+ieXa2Jha7d7jSnCmQbRci
	 6QRZAFVW1o/sna7fTUOEr4Gkkc2ybNXOXj2NaCy0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 400/849] mips: lantiq: danube: rename stp node on EASY50712 reference board
Date: Tue, 11 Nov 2025 09:39:30 +0900
Message-ID: <20251111004546.108664384@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit 2b9706ce84be9cb26be03e1ad2e43ec8bc3986be ]

This fixes the following warning:
arch/mips/boot/dts/lantiq/danube_easy50712.dtb: stp@e100bb0 (lantiq,gpio-stp-xway): $nodename:0: 'stp@e100bb0' does not match '^gpio@[0-9a-f]+$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-stp-xway.yaml#

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/lantiq/danube_easy50712.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/lantiq/danube_easy50712.dts b/arch/mips/boot/dts/lantiq/danube_easy50712.dts
index ab70028dbefcf..c9f7886f57b8c 100644
--- a/arch/mips/boot/dts/lantiq/danube_easy50712.dts
+++ b/arch/mips/boot/dts/lantiq/danube_easy50712.dts
@@ -96,7 +96,7 @@
 			lantiq,tx-burst-length = <4>;
 		};
 
-		stp0: stp@e100bb0 {
+		stp0: gpio@e100bb0 {
 			#gpio-cells = <2>;
 			compatible = "lantiq,gpio-stp-xway";
 			gpio-controller;
-- 
2.51.0




