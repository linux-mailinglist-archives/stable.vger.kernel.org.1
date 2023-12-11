Return-Path: <stable+bounces-6105-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1195F80D8C6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9BDB2156D
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA44651C2C;
	Mon, 11 Dec 2023 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DzOV7Kf7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09E5102A;
	Mon, 11 Dec 2023 18:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10849C433C8;
	Mon, 11 Dec 2023 18:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702320526;
	bh=IUDbDBvyS6k1gJIZsxJfitIoD5t6F6WnLhtw7IlUMgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DzOV7Kf778QFtKt25aWnseolcLr2tNtNqR6xY3/NHPKLuvzHKjdfnsq7M41uiluer
	 sZOpi4ctq41w/wFO7ZlBdz3mJZSQp9yWWg1UBFcLkpfEINX2UPtLtj6/SqA8PYjy6E
	 sLhZRIZVPrGaD/9Hun3ITtMQy+tY3Y60m7GE97Eo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fabio Estevam <festevam@denx.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 094/194] ARM: dts: imx28-xea: Pass the model property
Date: Mon, 11 Dec 2023 19:21:24 +0100
Message-ID: <20231211182040.665711500@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182036.606660304@linuxfoundation.org>
References: <20231211182036.606660304@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit 63ef8fc9bcee6b73ca445a19a7ac6bd544723c9f ]

Per root-node.yaml, 'model' is a required property.

Pass it to fix the following dt-schema warning:

imx28-xea.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml#

Signed-off-by: Fabio Estevam <festevam@denx.de>
Fixes: 445ae16ac1c5 ("ARM: dts: imx28: Add DTS description of imx28 based XEA board")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx28-xea.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28-xea.dts b/arch/arm/boot/dts/imx28-xea.dts
index a400c108f66a2..6c5e6856648af 100644
--- a/arch/arm/boot/dts/imx28-xea.dts
+++ b/arch/arm/boot/dts/imx28-xea.dts
@@ -8,6 +8,7 @@
 #include "imx28-lwe.dtsi"
 
 / {
+	model = "Liebherr XEA board";
 	compatible = "lwn,imx28-xea", "fsl,imx28";
 };
 
-- 
2.42.0




