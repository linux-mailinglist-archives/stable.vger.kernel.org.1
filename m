Return-Path: <stable+bounces-200334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 551BACACC70
	for <lists+stable@lfdr.de>; Mon, 08 Dec 2025 11:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3E483029D34
	for <lists+stable@lfdr.de>; Mon,  8 Dec 2025 09:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6562D46B3;
	Mon,  8 Dec 2025 09:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.cn header.i=zyc199902@zohomail.cn header.b="HiMjU+QO"
X-Original-To: stable@vger.kernel.org
Received: from sender3-pp-o92.zoho.com.cn (sender3-pp-o92.zoho.com.cn [124.251.121.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A8286891
	for <stable@vger.kernel.org>; Mon,  8 Dec 2025 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=124.251.121.251
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765187988; cv=pass; b=THwdXicNNV8HSzp8t+LoDxUJll008T88wpGUhswnT+MmxtQG81/k+dQgJaCjrlPWtVMUsRGGBVT2ekCYQUQkDJ87hAwKybgJsGLM0H+0Vz9AfmXhnU13Kk/QnEtcqaxPow2LtvufeKxPanXGQqhxgNWEBYVq1dkdpikBYoDmEM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765187988; c=relaxed/simple;
	bh=xZybzYfFi0h0Sb8Djtf8yfrTK9/s8YzPMSZt55gxDJ4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jfH5xp953JEe6/SaXVI1Cwm+4l9yDOAOoTPon65srWD0TORIZEnrYIYYdtHRlH2UmV0LpKaYmIOpCz2Dem7ZXal7IgGEGrNna/YnfOfTiaOhXvhHdpfmw9disAJYYMWJOeLajDV16BNj6ltEKDcOX+2uF2r2m17a8g1fuKKKgr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.cn; spf=pass smtp.mailfrom=zohomail.cn; dkim=pass (1024-bit key) header.d=zohomail.cn header.i=zyc199902@zohomail.cn header.b=HiMjU+QO; arc=pass smtp.client-ip=124.251.121.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.cn
ARC-Seal: i=1; a=rsa-sha256; t=1765187949; cv=none; 
	d=zoho.com.cn; s=zohoarc; 
	b=CejfARNcAgFjpJCnPR+tTuJigptQ7NBcBYhB9DEx96y0znvw+/XKCwpxjAIRHo8YPSGsI520iaKCtxP+D3n1DtIge96nN1ccug9am8p2IKCUQadpS0bgpb7cN7aL8jA9xe62hJnK7rxzLb0uKxR/Bo7WzVFT7jkce4uEt0iOdcA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
	t=1765187949; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=e55kGcM0YxUrptd4Daldaur30VucQqhil8JU4qvAdiY=; 
	b=lu/Xworh44ql1TbZqrHZvzVhWhdccaAZVlF3/1yQomqh2RKllpTZS9of4nkcoBU3rrHoPFfrl1V0FJQxoi9yitlVYvuWGxbt7r/cyRh5X0RM9LDPwvkj1eW1fuqtk3y9AlnsIUMkOEE/kSjlVjHbPVFgNQgmYQPTXVZVVf7BjBs=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
	dkim=pass  header.i=zohomail.cn;
	spf=pass  smtp.mailfrom=zyc199902@zohomail.cn;
	dmarc=pass header.from=<zyc199902@zohomail.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765187949;
	s=zoho; d=zohomail.cn; i=zyc199902@zohomail.cn;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=e55kGcM0YxUrptd4Daldaur30VucQqhil8JU4qvAdiY=;
	b=HiMjU+QOpdfRr1XEFdzhTAahh/bc0waMX2XkS3i9x0m3ir8aiOIma89Pwm4sQBMn
	WTBodkuJucslWqVjGP5Yak7rlbhouiDWaAVXJp55IhhyjOIl4Qs1wPirU6ahkJ9+em9
	S+cd03Asj69QcaGrxCTgsDHN6ifJnfdm+C50GmOc=
Received: from mail.baihui.com by mx.zoho.com.cn
	with SMTP id 176518794064039.56305506335718; Mon, 8 Dec 2025 17:59:00 +0800 (CST)
Received: from  [73.170.62.200] by mail.zoho.com.cn
	with HTTP;Mon, 8 Dec 2025 01:49:53 +0800 (CST)
Date: Mon, 08 Dec 2025 17:59:00 +0800
From: zyc zyc <zyc199902@zohomail.cn>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: "stable" <stable@vger.kernel.org>, "will" <will@willsroot.io>
Message-ID: <19af9ef2e7c.cd495a2b18809.5502831741554587778@zohomail.cn>
In-Reply-To: <19aed2c0e0e.136fee88813945.4542830906609965797@zohomail.cn>
References: <19ace674022.114eb26e714992.3171091003233609170@zohomail.cn>
 <19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn>
 <2025120248-operation-explain-1991@gregkh>
 <19ae2d0c40c.1304ed0542955.1614492155671387965@zohomail.cn> <2025120350-encourage-possible-b043@gregkh> <19aed2c0e0e.136fee88813945.4542830906609965797@zohomail.cn>
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

---- zyc zyc <zyc199902@zohomail.cn> =E5=9C=A8 Fri, 2025-12-05 18:31:00 =E5=
=86=99=E5=88=B0=EF=BC=9A---

 > ---- Greg KH <gregkh@linuxfoundation.org> =E5=9C=A8 Wed, 2025-12-03 19:3=
0:42 =E5=86=99=E5=88=B0=EF=BC=9A---=20
 > =20
 >  > On Wed, Dec 03, 2025 at 07:05:00PM +0800, zyc zyc wrote:=20
 >  > > ---- Greg KH <gregkh@linuxfoundation.org> =E5=9C=A8 Tue, 2025-12-02=
 19:30:09 =E5=86=99=E5=88=B0=EF=BC=9A---=20
 >  > >=20
 >  > >  > On Tue, Dec 02, 2025 at 06:39:00PM +0800, zyc zyc wrote:=20
 >  > >  > > Hello,=20
 >  > >  > >=20
 >  > >  > > Resend my last email without HTML.=20
 >  > >  > >=20
 >  > >  > > ---- zyc zyc <zyc199902@zohomail.cn> =E5=9C=A8 Sat, 2025-11-29=
 18:57:01 =E5=86=99=E5=88=B0=EF=BC=9A---=20
 >  > >  > >=20
 >  > >  > >  > Hello, maintainer=20
 >  > >  > >  >=20
 >  > >  > >  > I would like to report what appears to be a regression in 6=
.12.50 kernel release related to netem.=20
 >  > >  > >  > It rejects our configuration with the message:=20
 >  > >  > >  > Error: netem: cannot mix duplicating netems with other nete=
ms in tree.=20
 >  > >  > >  >=20
 >  > >  > >  > This breaks setups that previously worked correctly for man=
y years.=20
 >  > >  > >  >=20
 >  > >  > >  >=20
 >  > >  > >  > Our team uses multiple netem qdiscs in the same HTB branch,=
 arranged in a parallel fashion using a prio fan-out. Each branch of the pr=
io qdisc has its own distinct netem instance with different duplication cha=
racteristics.=20
 >  > >  > >  >=20
 >  > >  > >  > This is used to emulate our production conditions where a s=
ingle logical path fans out into two downstream segments, for example:=20
 >  > >  > >  >=20
 >  > >  > >  > two ECMP next hops with different misbehaviour characterist=
ics, or=20
 >  > >  > >  >=20
 >  > >  > >  >=20
 >  > >  > >  > an HA firewall cluster where only one node is replaying fra=
mes, or=20
 >  > >  > >  >=20
 >  > >  > >  >=20
 >  > >  > >  > two LAG / ToR paths where one path intermittently duplicate=
s packets.=20
 >  > >  > >  >=20
 >  > >  > >  >=20
 >  > >  > >  > In our environments, only a subset of flows are affected, a=
nd different downstream devices may cause different styles of duplication.=
=20
 >  > >  > >  > This regression breaks existing automated tests, training e=
nvironments, and network simulation pipelines.=20
 >  > >  > >  >=20
 >  > >  > >  > I would be happy to provide our reproducer if needed.=20
 >  > >  > >  >=20
 >  > >  > >  > Thank you for your time and for maintaining Linux kernel.=
=20
 >  > >  >=20
 >  > >  > Can you use 'git bisect' to find the offending commit?=20
 >  > >  >=20
 >  > >  > thanks,=20
 >  > >  >=20
 >  > >  > greg k-h=20
 >  > >  >=20
 >  > >=20
 >  > > Hi Greg,=20
 >  > >=20
 >  > > The error came from this commit:=20
 >  > >=20
 >  > > commit 795cb393e38977aa991e70a9363da0ee734b2114=20
 >  > > Author: William Liu <will@willsroot.io>=20
 >  > > Date:   Tue Jul 8 16:43:26 2025 +0000=20
 >  > >=20
 >  > >     net/sched: Restrict conditions for adding duplicating netems to=
 qdisc tree=20
 >  > >=20
 >  > >     [ Upstream commit ec8e0e3d7adef940cdf9475e2352c0680189d14e ]=20
 >  >=20
 >  > So is this also an issue for you in the latest 6.17 release (or 6.18)=
?=20
 >  > If not, what commit fixed this issue?  If so, please contact all of t=
he=20
 >  > developers involved and they will be glad to work to resolve this=20
 >  > regression in the mainline tree first.=20
 >  >=20
 >  > thanks,=20
 >  >=20
 >  > greg k-h=20
 >  >=20
 > =20
 > Hi Greg,=20
 > =20
 > I can only test 6.12 stable kernels. Let me add Will.=20
 > =20
 > Best,=20
 > zyc=20
 >=20

Hello Will

Could you help? This breaks our lab simulation.

Best,
Zhang Yang Chao

