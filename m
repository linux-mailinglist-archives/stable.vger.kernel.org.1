Return-Path: <stable+bounces-51243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AECC3906EF7
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A181F233AB
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F26F144D18;
	Thu, 13 Jun 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hZEVrHbm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237C81ABF;
	Thu, 13 Jun 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280726; cv=none; b=gqYCtAKh/pXO2EItJaB8XYSJz1TImErZgUdRSs/XrUR+uUy8Xlcd8xaV+KvCcq2YDPpHEbFxg+DLV0q/ZppqFMjHKVWGycfLCMt/ulEPAkgV96fT595TGx0lnhHgaoQhHhIkEvGZOgpF/Hgkt74XRPTE3SjYa6GZXC8L0M2QyZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280726; c=relaxed/simple;
	bh=vMFvwmWDdoTj9elLoaSNj/m9pDqVP+qaqkas6m1Kffs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUkEIVIUheErgcj4RK4C7ZlZnllHY/K2qf3F8wSQy45eDQIQaVfX4XuZRS434zN+ABL3UliLRYjEgCs6IxcU5zdh3LNcxHfLJoXUkkpinZaidesyHxva7mZD2AmqQfwu/fz3dkJI6TxF+a4iV4jxCkK3XUpzHJ+cCZeT2zw2MD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hZEVrHbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACABC2BBFC;
	Thu, 13 Jun 2024 12:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280726;
	bh=vMFvwmWDdoTj9elLoaSNj/m9pDqVP+qaqkas6m1Kffs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hZEVrHbmswyP27bRiQWIxejQGxbfNVt71PcIwaqcA/Rqd355N9VFruh4CQs+xOz0/
	 0EhGY7iZx0lIdPMywpeDEXRlxtgLNld1FF7ZlCOcwIXV4rZNiAdc1BSJiGfMRrP3hu
	 pqRleGpOMyGakg+NDGhBr8HGtXkX/94rStg+t428=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Derek Fang <derek.fang@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 014/317] ASoC: dt-bindings: rt5645: add cbj sleeve gpio property
Date: Thu, 13 Jun 2024 13:30:32 +0200
Message-ID: <20240613113248.092073238@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113247.525431100@linuxfoundation.org>
References: <20240613113247.525431100@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

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
index 41a62fd2ae1ff..c1fa379f5f3ea 100644
--- a/Documentation/devicetree/bindings/sound/rt5645.txt
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -20,6 +20,11 @@ Optional properties:
   a GPIO spec for the external headphone detect pin. If jd-mode = 0,
   we will get the JD status by getting the value of hp-detect-gpios.
 
+- cbj-sleeve-gpios:
+  a GPIO spec to control the external combo jack circuit to tie the sleeve/ring2
+  contacts to the ground or floating. It could avoid some electric noise from the
+  active speaker jacks.
+
 - realtek,in2-differential
   Boolean. Indicate MIC2 input are differential, rather than single-ended.
 
@@ -68,6 +73,7 @@ codec: rt5650@1a {
 	compatible = "realtek,rt5650";
 	reg = <0x1a>;
 	hp-detect-gpios = <&gpio 19 0>;
+	cbj-sleeve-gpios = <&gpio 20 0>;
 	interrupt-parent = <&gpio>;
 	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
 	realtek,dmic-en = "true";
-- 
2.43.0




