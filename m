Return-Path: <stable+bounces-198071-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D03C9B311
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 11:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1294A34662D
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 10:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A428330F807;
	Tue,  2 Dec 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.cn header.i=zyc199902@zohomail.cn header.b="oqf5oAFd"
X-Original-To: stable@vger.kernel.org
Received: from sender2-pp-o92.zoho.com.cn (sender2-pp-o92.zoho.com.cn [163.53.93.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187903081C6
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 10:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=163.53.93.251
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764671967; cv=pass; b=Ed1EMytaut8rg6uHcUbeKBlMwO9FVXqOg44ApAoJIzx36u07wFJ05c4nv9WMOnQM4sPmxs+NRPb7xbIPWhPzoCZaIsZYuGG6+OFLmT7a/mi+PAzOGMFJ6+3ESl4HGpKsGIy1z9aa3N0DBXgUiAEQ51KCncM7bR4UEfGWcDJottY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764671967; c=relaxed/simple;
	bh=xl5uEu+CHn+dO7dj5soj+bEl2jiTHUoh+/PjJzQyRHw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Sni7kyjpBXXs5smj/F1xnsFz798FH5ub9LCT1QdkV7U8V+VB2odunKURsIAWc+fir8V3NnOQPXVcKcoFuxQRV/neCUr5rSkdAbakYSOQ5b4UOez2/c1FGZVsTKYCoR6nMLh6i3Kmt7POKAGFwwDjgRs/NXUfvuwoYFEDNluPh+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.cn; spf=pass smtp.mailfrom=zohomail.cn; dkim=pass (1024-bit key) header.d=zohomail.cn header.i=zyc199902@zohomail.cn header.b=oqf5oAFd; arc=pass smtp.client-ip=163.53.93.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.cn
ARC-Seal: i=1; a=rsa-sha256; t=1764671945; cv=none; 
	d=zoho.com.cn; s=zohoarc; 
	b=CA8cYg9eCx+4ChNPR265fN7RsyVtnXKtugfBGhgGEE5TGz7UIO2TymlVC93lTwAupiWP8pjnFPyHobiYQ6QER126dJ4Wqm0F60H65Rid8MzPJOexgYkcoggdTVowygu9kf1bOL9rkKAfm8p71EanToV/4mr1IPKPD+Gl51ESknc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
	t=1764671945; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xl5uEu+CHn+dO7dj5soj+bEl2jiTHUoh+/PjJzQyRHw=; 
	b=HACvvp7aDTL/yB/ei8B2bt2LwdHqvoViTbo/ahkl4v5Sxzq1VcIRmmeav4aqQUiRKrBcioYfsLgGEDopJShFDfsOMEVMJ4diZUHGoM53LSISlrPFc8UHPXgqNusMICzNAdVjkd84SE0PY2XjNLVrZg2klKk1xjOvPpat2JtQhCs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
	dkim=pass  header.i=zohomail.cn;
	spf=pass  smtp.mailfrom=zyc199902@zohomail.cn;
	dmarc=pass header.from=<zyc199902@zohomail.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764671945;
	s=zoho; d=zohomail.cn; i=zyc199902@zohomail.cn;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xl5uEu+CHn+dO7dj5soj+bEl2jiTHUoh+/PjJzQyRHw=;
	b=oqf5oAFdAb3I3MtlM/BqpNWCVwxuvG6fHlr6fROUL4NpNbogU/OWFHBHcG7MkBwp
	XqxzdHrPVDiOjwZUI9XZA4yGlmfSmbnHKWd4ptzNJJNpkczAdMNX+4fcFXUl+CK965F
	3JH2HX+GI2Zw3xroOqANTqvrof2eniO5HPhIvxyg=
Received: from mail.baihui.com by mx.zoho.com.cn
	with SMTP id 1764671940297952.5369812016864; Tue, 2 Dec 2025 18:39:00 +0800 (CST)
Received: from  [73.170.62.200] by mail.zoho.com.cn
	with HTTP;Tue, 2 Dec 2025 14:00:10 +0800 (CST)
Date: Tue, 02 Dec 2025 18:39:00 +0800
From: zyc zyc <zyc199902@zohomail.cn>
To: "gregkh" <gregkh@linuxfoundation.org>
Cc: "stable" <stable@vger.kernel.org>
Message-ID: <19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn>
In-Reply-To: <19ace674022.114eb26e714992.3171091003233609170@zohomail.cn>
References: <19ace674022.114eb26e714992.3171091003233609170@zohomail.cn>
Subject: =?UTF-8?Q?=E5=9B=9E=E5=A4=8D:6.12.50_regression:_netem:_cannot_mix_du?=
 =?UTF-8?Q?plicating_netems_with_other_netems_in_tree.?=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
X-ZohoCNMail-Sender: zyc zyc

Hello,

Resend my last email without HTML.

---- zyc zyc <zyc199902@zohomail.cn> =E5=9C=A8 Sat, 2025-11-29 18:57:01 =E5=
=86=99=E5=88=B0=EF=BC=9A---

 > Hello, maintainer
 >=20
 > I would like to report what appears to be a regression in 6.12.50 kernel=
 release related to netem.
 > It rejects our configuration with the message:
 > Error: netem: cannot mix duplicating netems with other netems in tree.
 >=20
 > This breaks setups that previously worked correctly for many years.
 >=20
 >=20
 > Our team uses multiple netem qdiscs in the same HTB branch, arranged in =
a parallel fashion using a prio fan-out. Each branch of the prio qdisc has =
its own distinct netem instance with different duplication characteristics.
 >=20
 > This is used to emulate our production conditions where a single logical=
 path fans out into two downstream segments, for example:
 >=20
 > two ECMP next hops with different misbehaviour characteristics, or
 >=20
 >=20
 > an HA firewall cluster where only one node is replaying frames, or
 >=20
 >=20
 > two LAG / ToR paths where one path intermittently duplicates packets.
 >=20
 >=20
 > In our environments, only a subset of flows are affected, and different =
downstream devices may cause different styles of duplication.
 > This regression breaks existing automated tests, training environments, =
and network simulation pipelines.
 >=20
 > I would be happy to provide our reproducer if needed.
 >=20
 > Thank you for your time and for maintaining Linux kernel.
 >=20
 >=20
 >=20
 > Best regards,
 > zyc
 >=20
 >=20
 >=20


