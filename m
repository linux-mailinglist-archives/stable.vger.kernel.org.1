Return-Path: <stable+bounces-198363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF949C9F941
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 16:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D966D303B7E3
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 15:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FF4314A97;
	Wed,  3 Dec 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JfLeZn/T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338C314A78;
	Wed,  3 Dec 2025 15:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776293; cv=none; b=qlDwpSKVXGoF3/tQtFt4QlYxII/aDi2O0EoLDpBMCfbSMXWlJgWaPq45VMSW/DpH9A+w8+QG+ltWAqctVnUtyqo2ANHplzTnW17235Jf0vevC5u1r0rYM9yj8+eZjaMRepzVQbWcpxLBnCoH/Q0hfNcIXsdLmsFsZtPb21+Q4p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776293; c=relaxed/simple;
	bh=C0llxzNN3ONfJ87G87/EJK9/Oq5J9Vz1iRCLTLTbTqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnXmUsDKdCBFghcyuDqxv7c+XGSarj3tnsVSoVBcwVtwF5GmG5i9//1V4HgvEwMUSeTgv0mFfqE6g6M+16FT1HQQBnyxdaqqqU79Sqj+oh0UIhZW37yCIMy9d3HlZFOS17l75lPe+tHyUo2sromFwWAYyBWS4lK4Bk06U8VzxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JfLeZn/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AE9C4CEF5;
	Wed,  3 Dec 2025 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764776293;
	bh=C0llxzNN3ONfJ87G87/EJK9/Oq5J9Vz1iRCLTLTbTqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JfLeZn/TqCHKFczUJGAq9W8Cl+xRkObsCuSf3Be/nXHSKy0kInnDbJ49pjlYg1Noo
	 3ayf4xFaySXClReZZXVkViriJBMQnjYBqxxtFHHpb5D48ooaVSlLtGRzLIYO7Mq1a5
	 89JWuMKkVP1/r9g3SG7TgWw2ziv9v7z1Nv6SVyvU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 096/300] mips: lantiq: danube: add missing properties to cpu node
Date: Wed,  3 Dec 2025 16:25:00 +0100
Message-ID: <20251203152404.180266118@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152400.447697997@linuxfoundation.org>
References: <20251203152400.447697997@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aleksander Jan Bajkowski <olek2@wp.pl>

[ Upstream commit e8dee66c37085dc9858eb8608bc783c2900e50e7 ]

This fixes the following warnings:
arch/mips/boot/dts/lantiq/danube_easy50712.dtb: cpus: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cpus.yaml#
arch/mips/boot/dts/lantiq/danube_easy50712.dtb: cpus: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/cpus.yaml#
arch/mips/boot/dts/lantiq/danube_easy50712.dtb: cpu@0 (mips,mips24Kc): 'reg' is a required property
	from schema $id: http://devicetree.org/schemas/mips/cpus.yaml#

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/lantiq/danube.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
index 510be63c8bdf1..ff6ff9568e1bc 100644
--- a/arch/mips/boot/dts/lantiq/danube.dtsi
+++ b/arch/mips/boot/dts/lantiq/danube.dtsi
@@ -5,8 +5,12 @@
 	compatible = "lantiq,xway", "lantiq,danube";
 
 	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
 		cpu@0 {
 			compatible = "mips,mips24Kc";
+			reg = <0>;
 		};
 	};
 
-- 
2.51.0




