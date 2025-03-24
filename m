Return-Path: <stable+bounces-125961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B928AA6E2A1
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3050616B2B8
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A652E26560A;
	Mon, 24 Mar 2025 18:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tidylabs.net header.i=@tidylabs.net header.b="YUmlIQQD";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="DbK10uj8"
X-Original-To: stable@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC8A265616
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 18:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841937; cv=none; b=hVYFXf7h1ZcYcoURA8BfV2csE8XdRhZMGP9giG64TAwgC09fYSSOG9dwHxPd90n2lQKjF8OapBxizu60K4+ACJFv8EPaSMHtl+S7SrBkNN9uT2it9VK+QtxIFd27orB65jmk/MK8FWzXh3wjP6tsip+6Jqv0SIGMHFnquRsuE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841937; c=relaxed/simple;
	bh=hHdftn11UkKaZT6n38eLtiXBRZj0vepRLVgVQs8qgKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqe7AvDkLLX2KCXYImalL9tzWAYachMJhTrq5sQlvYCUimZa1sxhkgwCO3kdfvTt59Tij7J3reWHXmB3pKcJHzh0Xq63DkkKnp+JsZY4zNzK2ZLAR8uxfs4D1tzZLSMuidVhjsjKPLPcZAiPh+ArFjV05JwgiePo/TEdBlEh03Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tidylabs.net; spf=pass smtp.mailfrom=tidylabs.net; dkim=pass (2048-bit key) header.d=tidylabs.net header.i=@tidylabs.net header.b=YUmlIQQD; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=DbK10uj8; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tidylabs.net
DKIM-Signature: a=rsa-sha256; b=YUmlIQQDSPqQin0ihxKCr66ZmRSINrRJ6euTMDutY5fMO6rRAwRTMroNRCzJJLMn1pA6TQ8kgbQLOBE3ccO9wZ1saPFwtH/pd9AJzH2Vs9WzRiKW9/caBR3PPouF1ulaaBGPn2FRkfR79zSpOZFFnotByumqgdtrwA4ywwI4sMRJgGWh/TOH7PJPK44/Coxfl0PZTJSWqdPdEsX89zQzI18dT+rU+1pmr30LvyvN8nD3t0/f/gTK1EFOH/0zDQY3844KDAUTe+++54x3mc/NNViE0OjmHDqbxCJE4mvoeve4xtA+yVubdpHpe2RjBDUtuWPGSGcOScABrAQxu/VEoA==; s=purelymail2; d=tidylabs.net; v=1; bh=hHdftn11UkKaZT6n38eLtiXBRZj0vepRLVgVQs8qgKk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=DbK10uj8iyBNRfdRj5k3KCU1CLnQ9ASFfntqKGIUMRG/5xf2PE2DelOEjYiM8j0iFzQg2HRZHMy7Xl3TQroO8KPvPGGfhw1h7DTpXyPs5EUMrNJDzXtL7ZXFOM3Gn+xAee/blIqthAXJzgUztxWorq1VsCv18ksLR2FtTCvnIJGxA77oD7WHvG8P8hPnESeXKh/PPURbbGXwX2lcitu00voMOIAmN/jVwT9CH+9sJ71h3yG4qx5tFxNt5hCSKGlnICNgvkcnlxTW6m42zvJGwgLRUJKOV8K+CtmFp3eX7g4Em4boWl4oon+FOO/d7ctSq56A3sEbVAXCNZ1pDyRc9w==; s=purelymail2; d=purelymail.com; v=1; bh=hHdftn11UkKaZT6n38eLtiXBRZj0vepRLVgVQs8qgKk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1427942629;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 24 Mar 2025 18:45:33 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: stable@vger.kernel.org
Cc: Justin Klaassen <justin@tidylabs.net>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.6.y] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
Date: Mon, 24 Mar 2025 18:45:09 +0000
Message-ID: <20250324184509.13634-1-justin@tidylabs.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025032419-glaucoma-ascertain-be6e@gregkh>
References: <2025032419-glaucoma-ascertain-be6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The u2phy1_host should always have the same status as usb_host1_ehci
and usb_host1_ohci, otherwise the EHCI and OHCI drivers may be
initialized for a disabled usb port.

Per the NanoPi R4S schematic, the phy-supply for u2phy1_host is set to
the vdd_5v regulator.

Fixes: db792e9adbf8 ("rockchip: rk3399: Add support for FriendlyARM NanoPi =
R4S")
Cc: stable@vger.kernel.org
Signed-off-by: Justin Klaassen <justin@tidylabs.net>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Link: https://lore.kernel.org/r/20250225170420.3898-1-justin@tidylabs.net
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
(cherry picked from commit 38f4aa34a5f737ea8588dac320d884cc2e762c03)
---
 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm6=
4/boot/dts/rockchip/rk3399-nanopi-r4s.dts
index fe5b52610010..6a6b36c36ce2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
@@ -117,7 +117,7 @@ &u2phy0_host {
 };
=20
 &u2phy1_host {
-=09status =3D "disabled";
+=09phy-supply =3D <&vdd_5v>;
 };
=20
 &uart0 {
--=20
2.47.1


