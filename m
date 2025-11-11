Return-Path: <stable+bounces-193595-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6470C4A7C7
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD713B5955
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 01:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1713343214;
	Tue, 11 Nov 2025 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hM5rLcJc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB0C261573;
	Tue, 11 Nov 2025 01:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823555; cv=none; b=ESUnUQERjyCJTBmGEuDnHJ+L56cwI8SNDuwB4i9wBsNy7uc7w7l4GgDL/9LPX/nf5IOVTa5e0D0rFyR62LhbXN1UDwNuygz7JZ+bGjMUp8tEV4C2y/6jKrBO2DJKyRmF6mDbqynk7NV7ylBmj5uf8a1F97AFRzaSdbYZzwJ6k9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823555; c=relaxed/simple;
	bh=M3Nm5rYGR4UhJoSceLzjDg4d5PxElO59jsYSx50UZX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXA3rYOrBzLXiEIpaS8/zlx5KYoAGNQiP0LlPEnBnuanEDd4gUXoT7MZSME7NV7fG1BUSnzdWfYzQqK8oIwLhJ+rIN7laB6r6QX5EsPyeq3xFtAsST5PmSgSYELN40L6gZYFbvlcgi7Us8asJ0PNQ427+PGnwRqShNe9eSX981Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hM5rLcJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EACC4CEFB;
	Tue, 11 Nov 2025 01:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762823555;
	bh=M3Nm5rYGR4UhJoSceLzjDg4d5PxElO59jsYSx50UZX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hM5rLcJcuKlO35a3QAB3Lg5MtXvpYWi02WDhE9Wp8KRexFRrHhZiiijA/jvg4CTXT
	 fTEO512Dh8Lu4JATAKuoF5yKF6l5vt2XDbikS3/R/c/ZOiXKA/BBZP5EDm6WTyQH1Z
	 /rzLVbA/nZhPeyTcfjjkSj3xNL+YtstKZjUB1XJM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 269/565] mips: lantiq: danube: add missing properties to cpu node
Date: Tue, 11 Nov 2025 09:42:05 +0900
Message-ID: <20251111004532.939532103@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004526.816196597@linuxfoundation.org>
References: <20251111004526.816196597@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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
index 7a7ba66aa5349..0a942bc091436 100644
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




