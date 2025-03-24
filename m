Return-Path: <stable+bounces-125963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C669A6E2B1
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8084916FF6C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB91266EFC;
	Mon, 24 Mar 2025 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tidylabs.net header.i=@tidylabs.net header.b="UblN7ckh";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="EYXMG1po"
X-Original-To: stable@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F48263C90
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842215; cv=none; b=oxFwl7SFEG3Asl4qTcvc6p3fHIwQT8uY3VBnGeoR4itML27lva8n9OSbFKiLU+xE7ggmLsS6APmn4vgpBJSwfTYROh+qJromnqwbB2o67Kxzn2+2vx0Hxee823xseix6SYH47MHBxD9FsgrS09CVQfrtQ/Ee5C8inafuHxbjhHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842215; c=relaxed/simple;
	bh=Mo85v4HyA/zQVSg919l4zcv37hW2tCoJwsjVbQ05Mlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8l1mB6xqfA/eqmSQBtkCSmlREU0M1Tplk1WX9Z3jy7yFGRZzo4hav3ce22B9g2r9bPjGTfoc1IVgu6cqbcEaHP4QBfi6Atl4HdXNmDw8RqPO3ytKRa13Hu7yWkHzcFXEcbfzVcjR3Gg3U37Pe00nvFvaG1HWnIKeoe726AFpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tidylabs.net; spf=pass smtp.mailfrom=tidylabs.net; dkim=pass (2048-bit key) header.d=tidylabs.net header.i=@tidylabs.net header.b=UblN7ckh; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=EYXMG1po; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tidylabs.net
DKIM-Signature: a=rsa-sha256; b=UblN7ckh/M8xFygh084hVA/wuSnXd8A3z0Ordx+qzjlNjhMrHbGrNVICeKooEqc4bCkWHHuhuMwFEzAmT0g793JrqCUT+9QAukfiUhYCq2SEfLECdatMUYr+pkrPL5Olm7BgO/zzRdD4cwneJb4Z8wxxiJF5XstcxmvRj0MHbvdcbwI3YaGW6nSyVboUQTg+1NAqJds6C/qEdBltYgjgkxfUR94H3VFzbj/pOuhyQgM7rj8Thx6IGyo8x39G04QqSjxAsrrmJfj4Nekf4yDTdbTjGu1h4H1HXr8VUG4c8ynl6McT43C1M3INO3ymfBTN8biMoDtapNLYuLYSBNdEGQ==; s=purelymail2; d=tidylabs.net; v=1; bh=Mo85v4HyA/zQVSg919l4zcv37hW2tCoJwsjVbQ05Mlg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=EYXMG1po4FTkWDWsq+S+2EyXXM9pRXzM5bUoApPGUGP2tS3l399RFgBjKF6jHUuRAjsPg7jyQNkUiHrfsd3Nz3o0BGJ5eZuF4r1+NuWH1QuDQ6NpqsTm3nZdOb0XPA47L9Z/HPulj6v5aB9sCC762okIcDqeIRcM1ve2xh/GkI2a0KvWWzNGK0W3GfVCh2vJBLxkoXaHK/IFbZWP+BXVGhGxAdxWfDV6ZqWntH7Of7AZ0z2dddjeb4+tnnQpg2w0eVcrjVmn423dC23l4HLoufLXIdKxjsqXw8nz9Awd+caELr9wjVIxrdbmXDZUOicbxTJHdHB43Azd1xx3D/gvQQ==; s=purelymail2; d=purelymail.com; v=1; bh=Mo85v4HyA/zQVSg919l4zcv37hW2tCoJwsjVbQ05Mlg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1978714667;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 24 Mar 2025 18:50:10 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: stable@vger.kernel.org
Cc: Justin Klaassen <justin@tidylabs.net>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 5.15.y] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
Date: Mon, 24 Mar 2025 18:49:49 +0000
Message-ID: <20250324184949.15360-1-justin@tidylabs.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025032421-charging-glucose-8b79@gregkh>
References: <2025032421-charging-glucose-8b79@gregkh>
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
index cef4d18b599d..a992a6ac5e9f 100644
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


