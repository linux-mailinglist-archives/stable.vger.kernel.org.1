Return-Path: <stable+bounces-193751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5732AC4AC28
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EAB3B118D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E563126B9;
	Tue, 11 Nov 2025 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wm4VmVYx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC66A24466D;
	Tue, 11 Nov 2025 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823923; cv=none; b=RkAL37SV9g/6cmerTK3AJVV8GkX1eShT9j8+BynatqR6rXb542UubYoe4aRc2GysJIRsKD8SevtHg+WXrwAekvwHdNH8WUgm6PofYkEZVnMZhSV0i6Hjxj/gwdaLR9qvqhmHI66pJ5q7IUgBFCyPa4f84+BHlAbBHY1k3ez6k5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823923; c=relaxed/simple;
	bh=RMXiHBIPCwGW/qspxmwrqH/JCvsn6Jo0uFlZujHjZjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJP5akV5G7VuEnP3cYLDfTee0i5hrD9wcGt80PTOHAzHHFUdAjwyAnEbAAeSSXU26tdNKswKNoWVer1Ji8K+PZn7M6Ou/0zxHnRUNfeo8XXozoOXL+kwK+U70OyOmy7nGu1hJm/XXUiq6T6Z0trfBarHbK3jh2UPwtAPcqLAcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wm4VmVYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30D6C4CEF5;
	Tue, 11 Nov 2025 01:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823923;
	bh=RMXiHBIPCwGW/qspxmwrqH/JCvsn6Jo0uFlZujHjZjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wm4VmVYxpjiltBbHKzQkFsMoJytpdMcHMb10pU1JkupR9TDoXCdWK2DOpQQPaR0U0
	 HNYzjkEEcEHRNLpM8mG32rb0W31UlMxm8VBSAI89ejpU4BTND1uwFbk7Ei6n0OPsVk
	 fy5H4uGuL+ejN9P13A8F2yFnYaQQ/qBQOY+6JNgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 398/849] mips: lantiq: danube: add missing device_type in pci node
Date: Tue, 11 Nov 2025 09:39:28 +0900
Message-ID: <20251111004546.060193723@linuxfoundation.org>
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

[ Upstream commit d66949a1875352d2ddd52b144333288952a9e36f ]

This fixes the following warning:
arch/mips/boot/dts/lantiq/danube_easy50712.dtb: pci@e105400 (lantiq,pci-xway): 'device_type' is a required property
	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/lantiq/danube.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
index 0a942bc091436..650400bd5725f 100644
--- a/arch/mips/boot/dts/lantiq/danube.dtsi
+++ b/arch/mips/boot/dts/lantiq/danube.dtsi
@@ -104,6 +104,8 @@
 				  0x1000000 0 0x00000000 0xae00000 0 0x200000>; /* io space */
 			reg = <0x7000000 0x8000		/* config space */
 				0xe105400 0x400>;	/* pci bridge */
+
+			device_type = "pci";
 		};
 	};
 };
-- 
2.51.0




