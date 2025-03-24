Return-Path: <stable+bounces-125955-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81484A6E247
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF1B3ADAE9
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B81C263F22;
	Mon, 24 Mar 2025 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tidylabs.net header.i=@tidylabs.net header.b="fSen3Vsu";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="YVCIQ9gY"
X-Original-To: stable@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE6264A7E
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840912; cv=none; b=b6xNO9lARKs3K3KPPcSXqy2Nz0LaYeAkz8F2AUQrLp05E/wNWRWQFzCr+sDf6Z7/rNLEZRibE17jlccRw0gVN+Q7fjJ5BiDucsmGDHhQLiH2/cdA+C6plAI8TRO4ehp3Cw1RryrmozVYNoexCI7A6WnuPz815Px/etfaQPepY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840912; c=relaxed/simple;
	bh=hHdftn11UkKaZT6n38eLtiXBRZj0vepRLVgVQs8qgKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vu1reIyUGQaWqnvdYTQLohjIUfuuSLoRBPELDpMPoDilWINMyXiPULThvvQs90bTTkcVXqPjl0qRTS/twb/h3Zvwfm4ayQCl0zQzAPWQUYwuAk82OpeySA1kRRmF6lZj2N/lqdJR0ELhC2sbWX+5HLQnvSIrSCt2uH6o6mi9HY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tidylabs.net; spf=pass smtp.mailfrom=tidylabs.net; dkim=pass (2048-bit key) header.d=tidylabs.net header.i=@tidylabs.net header.b=fSen3Vsu; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=YVCIQ9gY; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tidylabs.net
DKIM-Signature: a=rsa-sha256; b=fSen3VsuvzWvPI6i3lK2at9hgBrRhFJeI5LEsx04zmPlEIEHct1SPMTWZMDdInjrexvoFoqpXthFftaj20WpIIFb4Qo2b7+fm3XG8Ug58TM1DTgwTc335iWCdtfsbYwZNTvILpsjCi02dLu0dyJsCDNI2lub+vAmTphLa+qVpAWRJrb3wFoXOEUgGG/CFlDqcrR+gz6H6dV2/zjBSqPvZLoum2X84jEp7G6CwAGMZjd4BlkPamlirXmGdhwJkSQ7EjJf0OMIBuB/4RC/CBhoSsxiqLVgt6L5XHZF5+IzJUmhvoKR3+rPhF4ThSOq0FWtqAau+IyiK28gZdD00X5zPA==; s=purelymail2; d=tidylabs.net; v=1; bh=hHdftn11UkKaZT6n38eLtiXBRZj0vepRLVgVQs8qgKk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=YVCIQ9gY4h3JI2vxbQmuhfWNzz3p1EmGfQFMxbEtSaw2i1y1KPG8ZZ8xx00bYpE0q+/bOS+PjZkTFHQmbrrniKOZr+HJ+JOxR5BaF9tc4aYSXSXkxntFATbfjUmPAKYdVXMT8aAeTR9DncwlQo58HMHbCBfjQbGxn1s0F8LaTCZhU13Z47dQUiDF8scHVqe0F9aqTeHZDf4X0SBPC6RvG2v34ABsmNeDAmlXD8Krl+OpLKxMtumDcuWdAHIhHzm7ZEtT4TcGPf6HfdNfw50oWRx4JLS5xEJwNz6KE6yWjBEWPNKlhxP3wRYIfy9oyaNQ+5nfoXVgWHspp5OgeY8TwA==; s=purelymail2; d=purelymail.com; v=1; bh=hHdftn11UkKaZT6n38eLtiXBRZj0vepRLVgVQs8qgKk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1379793863;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 24 Mar 2025 18:28:18 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: stable@vger.kernel.org
Cc: Justin Klaassen <justin@tidylabs.net>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.12.y] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
Date: Mon, 24 Mar 2025 18:27:25 +0000
Message-ID: <20250324182725.6771-1-justin@tidylabs.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025032419-amplifier-sympathy-47c6@gregkh>
References: <2025032419-amplifier-sympathy-47c6@gregkh>
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


