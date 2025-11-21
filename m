Return-Path: <stable+bounces-196144-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2024C79E3B
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 306C432B79
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24CD30EF7F;
	Fri, 21 Nov 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ohRDIwKl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB7A34D3AE;
	Fri, 21 Nov 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763732681; cv=none; b=kNGPra3vojXzR204pROc836jdRSnA7xXPqiiuc3a21QIt3p9Hs90zg1o4v56K0QZqDoPkYe63irNz3cIM5aJDGlrSON21tsLqtoy1Sfd/javiPQjcqrYQWUXoGlQu6lkiOC7MQIH72XKG/dvzJ1Pl8wOxgzKli8Y9Hej5SRRj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763732681; c=relaxed/simple;
	bh=4s4Rqalpw+Lo1/5UItsCPARbsCBlc7kVM0HoVqjUNkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGz7ZtZmRKu1WxtP8t4mPPA6OhFNtvRvZejO/3mA5J2MU2Vg8wzzTy4mYHBI2jmvhtaCusV7ouIv5M9oMejmC/XGb+CMmr50xP0g+e+uhZpMIep3y79GYf6jID0O8w7K1RnN6xxdm9suvBFbv/RnUZDlixY3CS7nn1K2i/2P/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ohRDIwKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77B4C4CEF1;
	Fri, 21 Nov 2025 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763732681;
	bh=4s4Rqalpw+Lo1/5UItsCPARbsCBlc7kVM0HoVqjUNkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohRDIwKlVQw41PJOR+2R8e4flaKuHKJaVWXCP65dfX6tsz/12A5Mewq20DJAeW4Kv
	 ll7KmQvU8yXy+uPaSQHIWq6/OPnfXWS4P5QhEvznr0xWItmg6ceRliTXagIl03lOON
	 6esIY22/VBYNkwTF2QV/9hUa4ClJloAA3PVl49Ls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 172/529] mips: lantiq: danube: add model to EASY50712 dts
Date: Fri, 21 Nov 2025 14:07:51 +0100
Message-ID: <20251121130237.139050005@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251121130230.985163914@linuxfoundation.org>
References: <20251121130230.985163914@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit cb96fd880ef78500b34d10fa76ddd3fa070287d6 ]

This fixes the following warning:
arch/mips/boot/dts/lantiq/danube_easy50712.dtb: / (lantiq,xway): 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/lantiq/danube_easy50712.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/lantiq/danube_easy50712.dts b/arch/mips/boot/dts/lantiq/danube_easy50712.dts
index c4d7aa5753b04..ab70028dbefcf 100644
--- a/arch/mips/boot/dts/lantiq/danube_easy50712.dts
+++ b/arch/mips/boot/dts/lantiq/danube_easy50712.dts
@@ -4,6 +4,8 @@
 /include/ "danube.dtsi"
 
 / {
+	model = "Intel EASY50712";
+
 	chosen {
 		bootargs = "console=ttyLTQ0,115200 init=/etc/preinit";
 	};
-- 
2.51.0




