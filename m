Return-Path: <stable+bounces-125959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2546A6E291
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 19:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55FB4168F44
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 18:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911A225E44D;
	Mon, 24 Mar 2025 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tidylabs.net header.i=@tidylabs.net header.b="fvwodPCn";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WQQ9tZMj"
X-Original-To: stable@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470191411DE
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841747; cv=none; b=QdT32g8JL31SPCH5pLPIXQ1h8gzO6ig8zVIXxgfq6gDnF+lQTTgnRZCuiU+l/31KAFxv4yJpVK3dzBPtTGWZbiULmOUj2LyekdMfGpDYVZb42zKk4XBlnazIzMM7J8wT1b8PtlaBswMJQtUaUs80B5IcdePBlRNuC0k+uLznhV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841747; c=relaxed/simple;
	bh=hHdftn11UkKaZT6n38eLtiXBRZj0vepRLVgVQs8qgKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CN+rpZhSAmUkdgclBuzNvdowpkOGq5hvioxixR6iThnkGjQiliIp5NHRn9zewpy9Xjj82fEgsxWelysX7V876Ad9UfIdyoiPT1og6qWOJuRzAF5cQlLZRsvki8pLHEoc0/H5UKd/MVrF1u6qese1c5fMl9M7s6VXCMCkH9Ufha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tidylabs.net; spf=pass smtp.mailfrom=tidylabs.net; dkim=pass (2048-bit key) header.d=tidylabs.net header.i=@tidylabs.net header.b=fvwodPCn; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WQQ9tZMj; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tidylabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tidylabs.net
DKIM-Signature: a=rsa-sha256; b=fvwodPCnGikti/7uFLcFPcI90d2SJMCn2TNTMWWJIpGk7NLwPyKmckkVhXNHjTA8UqFsINGW7RcDziRh+fS1DOfBwyKNIIpp8na/uNW38YBjCnRrjHzijUg8Jc9qvOtW++8f7AwlKJMq4RPAT9Uk+SCdPmM0v9ZiyVOrwM7cxhDmH4KfePCUvHt1rAj9RZsuiqgSRF+NgQwnrAUo2i+s72PxOuNAB3T2hkdFshi4J6fj3rgKkYRBQCZd4enbZGtJabQtPKY/M/kwoDraOlz7KfwdDZejNDy6bmKFmf8+BeHpdCY9iGF+f/MWYlsTAlG7A7d0rPhIIo6hQjofG5D4Pw==; s=purelymail2; d=tidylabs.net; v=1; bh=hHdftn11UkKaZT6n38eLtiXBRZj0vepRLVgVQs8qgKk=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=WQQ9tZMj6T6Ipr2hmYl087MtJRE0l12zDFxQZpKM2Mw8MMWnHqV3tV2L5HAEjm0LuQwsUmbWTD9a/U4+a+VhKRdT9FqvpdLXFcnKv8goxS/oCA7Dtoc8Matydix90BmxkW9t8zmuHQslibmVLayRiq9xu10MlJKsRdGgaTFlCGTLkwaAtOvJP7yur+flgLMNdhH67J3DMzvrkoRCyvA7wfr6m+qiVZpZiTfmwx3Ln4EENE96enDykYB2aRqwZE7NK/KIn1i59r6WlmapLWYOw507nuxMBS/jYY6kWoflzMNGpsqoVvbwoHjpejSR//dh+Y1p4gZVgdDgKWgMiNMkeA==; s=purelymail2; d=purelymail.com; v=1; bh=hHdftn11UkKaZT6n38eLtiXBRZj0vepRLVgVQs8qgKk=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 81901:11097:null:purelymail
X-Pm-Original-To: stable@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1100330336;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 24 Mar 2025 18:42:23 +0000 (UTC)
From: Justin Klaassen <justin@tidylabs.net>
To: stable@vger.kernel.org
Cc: Justin Klaassen <justin@tidylabs.net>,
	Dragan Simic <dsimic@manjaro.org>,
	Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 6.1.y] arm64: dts: rockchip: fix u2phy1_host status for NanoPi R4S
Date: Mon, 24 Mar 2025 18:41:37 +0000
Message-ID: <20250324184137.11437-1-justin@tidylabs.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025032420-nag-conclude-f944@gregkh>
References: <2025032420-nag-conclude-f944@gregkh>
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


