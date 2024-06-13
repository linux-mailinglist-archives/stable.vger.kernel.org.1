Return-Path: <stable+bounces-51121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC32906E6F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5794B25162
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F12D145A05;
	Thu, 13 Jun 2024 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lBtsyXD4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DAD13C805;
	Thu, 13 Jun 2024 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280371; cv=none; b=KTWJvwA05Y6Yufr8rvtYjdTMPOgABQIC5iupqYy3uM6i+o2S+Xug7E6qGVDp9xxZgKdZDfN0JoOyQIcj46Skai4OuT09gKOZ6zBUbBRE0nEfRnfCRm3/UziotTufhQ055fSPJwc18GoUWFaLANshh2mBTP0vK0gIZd3n8oFBkSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280371; c=relaxed/simple;
	bh=B9N6I5srzqdL6lO2LeDN2qwdhb1OhZKQDScMIL3/h9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvKweWM4bLWjTp7ngDg6QPZzslzWw0+gbwTLMhHRyCrp7aKRZq391Dj7LcbcexSnieLVQ57t8iFQm8L5blapCUJ2eFBABfmse1UgJSD7grg8J838IbzuFP0sybmNFKpoecK1Ka4qxT4pvOM9diWwXqva/ujBqCDdPQVdGHPPOcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lBtsyXD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794DDC2BBFC;
	Thu, 13 Jun 2024 12:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280370;
	bh=B9N6I5srzqdL6lO2LeDN2qwdhb1OhZKQDScMIL3/h9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBtsyXD4WoSL73GyVzYCug2Djj8nfvD4ZEgmZAnKAYx6CjpkZ5QPUkL8VL88Xo/zB
	 66wqgroCtbg+FGtElb7vTdPg0hx/qXqYWWF99E9aSQx+yjeISLuOxrj2DigSNdeW8Y
	 UNJcL95pFbEjGVipFd4cwrcTolgzk8BervXd9p/Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan+linaro@kernel.org>,
	Bryan ODonoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.6 030/137] arm64: dts: qcom: qcs404: fix bluetooth device address
Date: Thu, 13 Jun 2024 13:33:30 +0200
Message-ID: <20240613113224.456586179@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
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

From: Johan Hovold <johan+linaro@kernel.org>

commit f5f390a77f18eaeb2c93211a1b7c5e66b5acd423 upstream.

The 'local-bd-address' property is used to pass a unique Bluetooth
device address from the boot firmware to the kernel and should otherwise
be left unset so that the OS can prevent the controller from being used
until a valid address has been provided through some other means (e.g.
using btmgmt).

Fixes: 60f77ae7d1c1 ("arm64: dts: qcom: qcs404-evb: Enable uart3 and add Bluetooth")
Cc: stable@vger.kernel.org	# 5.10
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Link: https://lore.kernel.org/r/20240501075201.4732-1-johan+linaro@kernel.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -62,7 +62,7 @@
 		vddrf-supply = <&vreg_l1_1p3>;
 		vddch0-supply = <&vdd_ch0_3p3>;
 
-		local-bd-address = [ 02 00 00 00 5a ad ];
+		local-bd-address = [ 00 00 00 00 00 00 ];
 
 		max-speed = <3200000>;
 	};



