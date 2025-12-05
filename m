Return-Path: <stable+bounces-200143-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B40ACCA72AF
	for <lists+stable@lfdr.de>; Fri, 05 Dec 2025 11:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DA2B300EE62
	for <lists+stable@lfdr.de>; Fri,  5 Dec 2025 10:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB113093C3;
	Fri,  5 Dec 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.cn header.i=zyc199902@zohomail.cn header.b="ZVUOCcBc"
X-Original-To: stable@vger.kernel.org
Received: from sender3-pp-o92.zoho.com.cn (sender3-pp-o92.zoho.com.cn [124.251.121.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CC230147D
	for <stable@vger.kernel.org>; Fri,  5 Dec 2025 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=124.251.121.251
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764930705; cv=pass; b=n7KRMyXDdhp1oQGSppM+vsl5mWOp1XqDvbEQ4A6fIi92JoaYXqnpYH1JVZHAVD1nALR7aOGogMQT/dmgQ57gJJF2iqVejbSTcggorT6MV0HCsWO/9B1vlUOj7UaW8HFPh5rtNg8MhinJI1xxup5q3CRD0VeDvHepKTfM4DbY8Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764930705; c=relaxed/simple;
	bh=zwBs3fisBvLlD1fCu7/2kxD1Az8TyePsnTK3KzD4FWo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rPvM9/tf1noy3YGmDBIXkm1a7y3ESowJU4AqN4jRKD4eRlHm/mVB8owScm5DN8nxZegxiFrdeORQJeSSnvmguNMP4UlIaXniv+ozTvNw10cdnc/Bexe+Hd1yaccsnUV2i69fC2Cl31xQKjdPtJHajG4+Pnb86GMTUdQ6enultHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.cn; spf=pass smtp.mailfrom=zohomail.cn; dkim=pass (1024-bit key) header.d=zohomail.cn header.i=zyc199902@zohomail.cn header.b=ZVUOCcBc; arc=pass smtp.client-ip=124.251.121.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.cn
ARC-Seal: i=1; a=rsa-sha256; t=1764930664; cv=none; 
	d=zoho.com.cn; s=zohoarc; 
	b=ZT+MUW4IQSEuCcp44Acn6m+X0Zy6Q6RPZVGJRvQZ5Wh9kmaUjkPgQ6CAfhKbbLGQFAoT79PWvpaYLdK6Em1XZWX6TgPVp/K7xeVFl6zNPuZYubok+1xSYtM+DnSpli+EenZrBVOhEIXluK8Ln28cOVzTnJ9WZ4eiz+U6Nu0XuPM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
	t=1764930664; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=geBg6pPjR6gSrWNei1UHgSbTtTOZYyZu8RQG+hGqSZA=; 
	b=X1eHp9r9hkgw1PjfpXa09PkaglQx2bwWKfMA29HuolrEqTsC8Vt/HumqkJxnFT2H3u/b9m1vOuHAWqfIlWrOrRhkH+EgdxXF2OsJj4oXzdMrScQbopAkz5Ql1m86saC4ECCGmpc9ngeHSOyxbnh3cmtNfIh1ZhvhGg+R5q8jodM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
	dkim=pass  header.i=zohomail.cn;
	spf=pass  smtp.mailfrom=zyc199902@zohomail.cn;
	dmarc=pass header.from=<zyc199902@zohomail.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764930664;
	s=zoho; d=zohomail.cn; i=zyc199902@zohomail.cn;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=geBg6pPjR6gSrWNei1UHgSbTtTOZYyZu8RQG+hGqSZA=;
	b=ZVUOCcBcq4AgSkq/c0WkqLg5UHTknrd4g4u+QWGMOTg/7bCzjBCsfDxvm2CfXU0q
	d1l4uNziS/LnXDZ1fY4ZMsBCfjobAXyqQW2HoM5TBJX4GEWLarGsXqyW4jAo2fskLny
	h7v5rxJrnK+PrlKJ2RpbP3lviYoU6+7bEDdFRzQY=
Received: from mail.baihui.com by mx.zoho.com.cn
	with SMTP id 1764930660473848.3504375560245; Fri, 5 Dec 2025 18:31:00 +0800 (CST)
Received: from  [73.170.62.200] by mail.zoho.com.cn
	with HTTP;Fri, 5 Dec 2025 14:21:18 +0800 (CST)
Date: Fri, 05 Dec 2025 18:31:00 +0800
From: zyc zyc <zyc199902@zohomail.cn>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: "stable" <stable@vger.kernel.org>, "will" <will@willsroot.io>
Message-ID: <19aed2c0e0e.136fee88813945.4542830906609965797@zohomail.cn>
In-Reply-To: <2025120350-encourage-possible-b043@gregkh>
References: <19ace674022.114eb26e714992.3171091003233609170@zohomail.cn>
 <19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn>
 <2025120248-operation-explain-1991@gregkh>
 <19ae2d0c40c.1304ed0542955.1614492155671387965@zohomail.cn> <2025120350-encourage-possible-b043@gregkh>
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

---- Greg KH <gregkh@linuxfoundation.org> =E5=9C=A8 Wed, 2025-12-03 19:30:4=
2 =E5=86=99=E5=88=B0=EF=BC=9A---

 > On Wed, Dec 03, 2025 at 07:05:00PM +0800, zyc zyc wrote:=20
 > > ---- Greg KH <gregkh@linuxfoundation.org> =E5=9C=A8 Tue, 2025-12-02 19=
:30:09 =E5=86=99=E5=88=B0=EF=BC=9A---=20
 > >=20
 > >  > On Tue, Dec 02, 2025 at 06:39:00PM +0800, zyc zyc wrote:=20
 > >  > > Hello,=20
 > >  > >=20
 > >  > > Resend my last email without HTML.=20
 > >  > >=20
 > >  > > ---- zyc zyc <zyc199902@zohomail.cn> =E5=9C=A8 Sat, 2025-11-29 18=
:57:01 =E5=86=99=E5=88=B0=EF=BC=9A---=20
 > >  > >=20
 > >  > >  > Hello, maintainer=20
 > >  > >  >=20
 > >  > >  > I would like to report what appears to be a regression in 6.12=
.50 kernel release related to netem.=20
 > >  > >  > It rejects our configuration with the message:=20
 > >  > >  > Error: netem: cannot mix duplicating netems with other netems =
in tree.=20
 > >  > >  >=20
 > >  > >  > This breaks setups that previously worked correctly for many y=
ears.=20
 > >  > >  >=20
 > >  > >  >=20
 > >  > >  > Our team uses multiple netem qdiscs in the same HTB branch, ar=
ranged in a parallel fashion using a prio fan-out. Each branch of the prio =
qdisc has its own distinct netem instance with different duplication charac=
teristics.=20
 > >  > >  >=20
 > >  > >  > This is used to emulate our production conditions where a sing=
le logical path fans out into two downstream segments, for example:=20
 > >  > >  >=20
 > >  > >  > two ECMP next hops with different misbehaviour characteristics=
, or=20
 > >  > >  >=20
 > >  > >  >=20
 > >  > >  > an HA firewall cluster where only one node is replaying frames=
, or=20
 > >  > >  >=20
 > >  > >  >=20
 > >  > >  > two LAG / ToR paths where one path intermittently duplicates p=
ackets.=20
 > >  > >  >=20
 > >  > >  >=20
 > >  > >  > In our environments, only a subset of flows are affected, and =
different downstream devices may cause different styles of duplication.=20
 > >  > >  > This regression breaks existing automated tests, training envi=
ronments, and network simulation pipelines.=20
 > >  > >  >=20
 > >  > >  > I would be happy to provide our reproducer if needed.=20
 > >  > >  >=20
 > >  > >  > Thank you for your time and for maintaining Linux kernel.=20
 > >  >=20
 > >  > Can you use 'git bisect' to find the offending commit?=20
 > >  >=20
 > >  > thanks,=20
 > >  >=20
 > >  > greg k-h=20
 > >  >=20
 > >=20
 > > Hi Greg,=20
 > >=20
 > > The error came from this commit:=20
 > >=20
 > > commit 795cb393e38977aa991e70a9363da0ee734b2114=20
 > > Author: William Liu <will@willsroot.io>=20
 > > Date:   Tue Jul 8 16:43:26 2025 +0000=20
 > >=20
 > >     net/sched: Restrict conditions for adding duplicating netems to qd=
isc tree=20
 > >=20
 > >     [ Upstream commit ec8e0e3d7adef940cdf9475e2352c0680189d14e ]=20
 > =20
 > So is this also an issue for you in the latest 6.17 release (or 6.18)?=
=20
 > If not, what commit fixed this issue?  If so, please contact all of the=
=20
 > developers involved and they will be glad to work to resolve this=20
 > regression in the mainline tree first.=20
 > =20
 > thanks,=20
 > =20
 > greg k-h=20
 >=20

Hi Greg,

I can only test 6.12 stable kernels. Let me add Will.

Best,
zyc

