Return-Path: <stable+bounces-202781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A176CC6C3C
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 10:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 635C330178B6
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087552BCF5;
	Wed, 17 Dec 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.cn header.i=zyc199902@zohomail.cn header.b="WuaEUSQp"
X-Original-To: stable@vger.kernel.org
Received: from sender2-pp-o92.zoho.com.cn (sender2-pp-o92.zoho.com.cn [163.53.93.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90053293B5F
	for <stable@vger.kernel.org>; Wed, 17 Dec 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=163.53.93.251
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765963200; cv=pass; b=F6hedkaWwrOl2/WdK8Z/rmGT+myDTiTiBdkZaTOCK2r5JrzG16G2bTgMqkNjlMh6Y84qarHKJMgg8qg+KWntKdfDVZyeOvpb/1Y/B45R0ZzJnPqB6WX1K7fOYooOZAxfvMARry4CpEYOhCZ3uxxI0VYJCrw6v4lZOPQlkuaVLU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765963200; c=relaxed/simple;
	bh=GXRe4J6ryUA44SBrp9HS9YZeYca+2/J4Ub7wCP5IIU8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=PC8tR04L2qKauPhdcf+uB079GLQBJeAv3fnCce5hajTrzr7Py7mVmxBAgnjc/d1Ql45LxH4gokNdTCl9kvPg9khGBlwmDvLXsBNTr0hTg8r+1gmT2eXIJI4K+Ie728ZS7UwPJAp8FCdR9ksN8bEciWBQMMJD8otAbpF9tp1XOO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.cn; spf=pass smtp.mailfrom=zohomail.cn; dkim=pass (1024-bit key) header.d=zohomail.cn header.i=zyc199902@zohomail.cn header.b=WuaEUSQp; arc=pass smtp.client-ip=163.53.93.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.cn
ARC-Seal: i=1; a=rsa-sha256; t=1765962243; cv=none; 
	d=zoho.com.cn; s=zohoarc; 
	b=Y77B1k7wGB1b7CgvfXOhYvQrgUkh/v2dQsnrXKx9x+kesoZfPo6aJT7egYajm0pIjYeaGqxRgIbURAOxk8y9tqKnp/7hB+qIXFFhWOOAozn3VCDXnZogr4q/gIs85GQaBhmujZ7NrmQzTLMAaT1YUSRgKNbMmJL95WeyxXWkySo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
	t=1765962243; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=GXRe4J6ryUA44SBrp9HS9YZeYca+2/J4Ub7wCP5IIU8=; 
	b=JRegBDcmz196kZ/Jv9IqQzx6s5axwBWLMicBaUeQPWinN1H00DlBGcSPpsmzPLD2e3v8zTE5d+eSioIYiks0uXZNQAM4zq/UWZ5ycnm+ERTSu8L4m3a3gLXG7ufXCUYAp1S1FB0qDGMlDt+L0gdd8og/H+SpJSDSTgMY8P17Xws=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
	dkim=pass  header.i=zohomail.cn;
	spf=pass  smtp.mailfrom=zyc199902@zohomail.cn;
	dmarc=pass header.from=<zyc199902@zohomail.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765962243;
	s=zoho; d=zohomail.cn; i=zyc199902@zohomail.cn;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=GXRe4J6ryUA44SBrp9HS9YZeYca+2/J4Ub7wCP5IIU8=;
	b=WuaEUSQpstsVyidQ4ZguPwe6ATJ+n2ya9mdQBYxHxCOico7POkKO3gagXuiZaJsk
	n8LVcfU1I7wCkpHXyqcwZBYldIYBQb+TahfyHPyKzchXz9hAwZvacoHFyDfEbVTwGL3
	VFv6rMHci6WEmUoMd1PQWmPA2Q+jJXVO9QRh3Jrw=
Received: from mail.baihui.com by mx.zoho.com.cn
	with SMTP id 1765962240581412.2353038002851; Wed, 17 Dec 2025 17:04:00 +0800 (CST)
Received: from  [73.170.62.200] by mail.zoho.com.cn
	with HTTP;Wed, 17 Dec 2025 11:54:24 +0800 (CST)
Date: Wed, 17 Dec 2025 17:04:00 +0800
From: zyc zyc <zyc199902@zohomail.cn>
To: "William Liu" <will@willsroot.io>
Cc: "Greg KH" <gregkh@linuxfoundation.org>,
	"stable" <stable@vger.kernel.org>
Message-ID: <19b2a71ded6.103a35ff415938.7552395401162922586@zohomail.cn>
In-Reply-To: <_7sb1wYlX1079sj77KxpLIUjYMEqn-J_b431OKc-v1aPiWhfSnwYZ9_C6BAOLW-a2cdngID0Nxqdip95EedRWtV7iMDeIVzFTBTvFbEKczA=@willsroot.io>
References: <19ace674022.114eb26e714992.3171091003233609170@zohomail.cn> <19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn> <2025120248-operation-explain-1991@gregkh> <19ae2d0c40c.1304ed0542955.1614492155671387965@zohomail.cn> <2025120350-encourage-possible-b043@gregkh> <19aed2c0e0e.136fee88813945.4542830906609965797@zohomail.cn> <19af9ef2e7c.cd495a2b18809.5502831741554587778@zohomail.cn> <_7sb1wYlX1079sj77KxpLIUjYMEqn-J_b431OKc-v1aPiWhfSnwYZ9_C6BAOLW-a2cdngID0Nxqdip95EedRWtV7iMDeIVzFTBTvFbEKczA=@willsroot.io>
Subject: =?UTF-8?Q?Re:_=E5=9B=9E=E5=A4=8D:6.12.50_regression:_netem:_cannot_mix_?=
 =?UTF-8?Q?duplicating_netems_with_other_netems_in_tree.?=
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

---- William Liu <will@willsroot.io> =E5=9C=A8 Wed, 2025-12-10 11:31:02 =E5=
=86=99=E5=88=B0=EF=BC=9A---

 > Hi zyc,=20
 > =20
 > The netdev maintainers and I are aware of this issue. This change was ma=
de to prevent a local DOS bug in netem that was extremely trivial to trigge=
r, and some maintainers considered your type of configuration as an extreme=
ly rare use case (but imo still a very valid one). I provided a summary of =
this fix as well as other proposed fixes in both the commit log and [1].=20
 > =20
 > There is currently a patch proposed in [2] to resolve this which technic=
ally obeys man page semantics but was previously rejected. Basically, the D=
OS can be easily resolved by enqueuing duplicated packets to the same netem=
 qdisc, but other maintainers presented valid concerns about changing user =
visible behavior from the past 2 decades and the original commit message me=
ntioned enqueuing from root was necessary to "avoid problems with qlen acco=
unting with nested qdisc."=20
 > =20
 > tc_skb_extensions sounds like a reasonable solution to me that changes n=
o existing behavior and adds no additional restrictions [3], but it has not=
 been further explored or checked for soundness. Hypothetically, it would f=
ix both the DOS bug and allow packets to retain the behavior of enqueuing f=
rom root.=20
 > =20
 > You can follow the status of the fix in [2] - I do not plan to further v=
olunteer myself and my free time in this specific fix process due to the co=
nsistent pattern of unprofessional and patronizing emails from Cong Wang. I=
 am confident the other netdev maintainers should reach a resolution soon.=
=20
 > =20
 > Best,=20
 > Will=20
 > =20
 > [1] https://lore.kernel.org/netdev/PKMd5btHYmJcKSiIJdtxQvZBEfuS4RQkBnE4M=
-TZkjUq_Rdj6Wgm8wDmX-p6rIkSRGDJN8ufn0HcDI6-r2lgibdSk7cn1mHIdbZEohJFKMg=3D@w=
illsroot.io/=20
 > [2] https://lore.kernel.org/netdev/20251126195244.88124-4-xiyou.wangcong=
@gmail.com/=20
 > [3] https://lore.kernel.org/netdev/CAM0EoMmBdZBzfUAms5-0hH5qF5ODvxWfgqrb=
HaGT6p3-uOD6vg@mail.gmail.com/=20
 > =20

Hi Will,

Thanks for the details. We will read the links you provide.


Zhang Yang Chao=20

