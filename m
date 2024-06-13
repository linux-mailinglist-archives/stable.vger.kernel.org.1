Return-Path: <stable+bounces-50899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5311D906D57
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6503F1C22AD7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE305145A03;
	Thu, 13 Jun 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XsiBVDHL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC691143C5F;
	Thu, 13 Jun 2024 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279714; cv=none; b=csD8e73pAAbVI/SMcou0f6KTI6UiXxrJsdP8o5/No8bl2Htzd4yl6ym7MV3ah/6nSXkcYeFUOEdJZ0FiV0rB8JDRamGDNjtBGtfpL9N5r1IB7JtlSL3vGdvDd2EOUQl7LsWA830QMEv1qan6uHsWDVv2dZeIvKSubhTNLY2aYjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279714; c=relaxed/simple;
	bh=qKgM0QBobuI33JkkwSNsHAa6uBKaXI4mootDpCXpVKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP7SKoNRzAkXLaiKS0pmGVFmtBt/E1sDkXVXePqonjcD1RfBpiMHgdQyJ2hCafjbcbiPlSKoXeXN6eGO2ioJ8Y/UdBRTI/RqFpshaEB/rAi+dKorDq8a66h9G9NLjxdTQD6hbBkl7aWVRvDfmbmECdMEWmoI09Lkqg6lxlVtkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XsiBVDHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36222C2BBFC;
	Thu, 13 Jun 2024 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279714;
	bh=qKgM0QBobuI33JkkwSNsHAa6uBKaXI4mootDpCXpVKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XsiBVDHLhngt7+Q3BYO4JQYTuWkOBGZQbNymXG+m6y8GT7A3FRMMI+Tgtxj7QTDcA
	 irZmMihcdhKfHH+MuOY2x+A8MtatQm7FX/Gyw6lwDFEFRJHq7mdSr44kkj3DZch9kA
	 v2ISj+QOa4DcJYkM6J9/ZaIa3YqMEduNLidUqols=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Derek Fang <derek.fang@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 012/202] ASoC: dt-bindings: rt5645: add cbj sleeve gpio property
Date: Thu, 13 Jun 2024 13:31:50 +0200
Message-ID: <20240613113228.236758000@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.759341286@linuxfoundation.org>
References: <20240613113227.759341286@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Derek Fang <derek.fang@realtek.com>

[ Upstream commit 306b38e3fa727d22454a148a364123709e356600 ]

Add an optional gpio property to control external CBJ circuits
to avoid some electric noise caused by sleeve/ring2 contacts floating.

Signed-off-by: Derek Fang <derek.fang@realtek.com>

Link: https://msgid.link/r/20240408091057.14165-2-derek.fang@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5645.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
index a03f9a872a716..bfb2217a9a658 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -16,6 +16,11 @@ Optional properties:
   a GPIO spec for the external headphone detect pin. If jd-mode = 0,
   we will get the JD status by getting the value of hp-detect-gpios.
 
+- cbj-sleeve-gpios:
+  a GPIO spec to control the external combo jack circuit to tie the sleeve/ring2
+  contacts to the ground or floating. It could avoid some electric noise from the
+  active speaker jacks.
+
 - realtek,in2-differential
   Boolean. Indicate MIC2 input are differential, rather than single-ended.
 
@@ -64,6 +69,7 @@ codec: rt5650@1a {
 	compatible = "realtek,rt5650";
 	reg = <0x1a>;
 	hp-detect-gpios = <&gpio 19 0>;
+	cbj-sleeve-gpios = <&gpio 20 0>;
 	interrupt-parent = <&gpio>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 	realtek,dmic-en = "true";
-- 
2.43.0




