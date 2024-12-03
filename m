Return-Path: <stable+bounces-97173-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D72B09E232E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D10169788
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B481F76AE;
	Tue,  3 Dec 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zv7Nyqpa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ECA1F4276;
	Tue,  3 Dec 2024 15:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239724; cv=none; b=U2py3YGwDboWWyV6952jjGbx0dwEznQOo9WNcMnSjyQceVNDFH2TlVqGR2w+/BYJilJ4PM8UKwsgEWBlo4yYcasbV0BNY+ztwYuvyPqbHor8OPDC88QVapWOfTq8+FApsJsd80DnZ2SttMa00fjReUzvslvuNcLqc680GTE/CtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239724; c=relaxed/simple;
	bh=ropwjtgAS8R8IWN0hijVHMBt/RKkk0bIkSUFhJ0RGoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ptDQGU7GwNT4kpoMq11nNVztRKoqgF5UCLBtCrh2hKDtLDODSCtHKfozvVeVrtzw/cor2cXmSe1BMoi1ZOkiEd8N/nuwTGOFit9w3fwrdmj+s9PADKDM0gnGc6jYgc28WyEpsUuXwmAekf7azzfSvQDJ2zKSTrrqJK2hA0z65vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zv7Nyqpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4734FC4CECF;
	Tue,  3 Dec 2024 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239724;
	bh=ropwjtgAS8R8IWN0hijVHMBt/RKkk0bIkSUFhJ0RGoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zv7NyqpaQDVQLeQu8Y/y/f84hLiudy4rdu4JYbxoGS27TTKCz9jQnMcHAQ+K4u8pn
	 RaxWKnqYL/cKLABt1tXp5J5fbkG4uXa4+ijHcgp3yaYtbAX5Z1R51tTPDCD+dUmtPi
	 POUHJ9FPGcOaEleK7vrOfQ10QBMToOAzWgylWJAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 6.11 681/817] ARM: dts: omap36xx: declare 1GHz OPP as turbo again
Date: Tue,  3 Dec 2024 15:44:13 +0100
Message-ID: <20241203144022.549490406@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Kemnade <andreas@kemnade.info>

commit 96a64e9730c2c76cfa5c510583a0fbf40d62886b upstream.

Operating stable without reduced chip life at 1Ghz needs several
technologies working: The technologies involve
- SmartReflex
- DVFS

As this cannot directly specified in the OPP table as dependecies in the
devicetree yet, use the turbo flag again to mark this OPP as something
special to have some kind of opt-in.

So revert commit
5f1bf7ae8481 ("ARM: dts: omap36xx: Remove turbo mode for 1GHz variants")

Practical reasoning:
At least the GTA04A5 (DM3730) has become unstable with that OPP enabled.
Furthermore nothing enforces the availability of said technologies,
even in the kernel configuration, so allow users to rather opt-in.

Cc: Stable@vger.kernel.org
Fixes: 5f1bf7ae8481 ("ARM: dts: omap36xx: Remove turbo mode for 1GHz variants")
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Link: https://lore.kernel.org/r/20241018214727.275162-1-andreas@kemnade.info
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/ti/omap/omap36xx.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap36xx.dtsi
@@ -72,6 +72,7 @@
 					 <1375000 1375000 1375000>;
 			/* only on am/dm37x with speed-binned bit set */
 			opp-supported-hw = <0xffffffff 2>;
+			turbo-mode;
 		};
 	};
 



