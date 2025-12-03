Return-Path: <stable+bounces-198188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF6CC9ECE4
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EF65347ADE
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E72F12DA;
	Wed,  3 Dec 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.cn header.i=zyc199902@zohomail.cn header.b="fZoatRy3"
X-Original-To: stable@vger.kernel.org
Received: from sender2-pp-o92.zoho.com.cn (sender2-pp-o92.zoho.com.cn [163.53.93.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBD2E8B74
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=163.53.93.251
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764759923; cv=pass; b=pWmjdxZcLKBnHT5lsz9JPr+EAVBvmrJikqER1Y90gkFhpo8Z2B5hMwMd2MioV9AjtKTaUFIDG5JVDTZiU4Ud6K9WC721ZpnrMMf2RowHT70t0XoETGfei90exAVgoEWvmKuA3kffwg4NB/TZOy+Oa81Uy0akUbg7HIZ7m9R7vNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764759923; c=relaxed/simple;
	bh=od+TUbTKMHvUtvWQ9xli+OUC6g6Al1mWtnnNUzmoiZs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=uyZ6iHXPF/8xd1ZkUNixfGla8jnQCQ8UgS5qHcYttt2YQEbk/zvHyJ4RyZz0PAgG4p/q/Mf6JT4PGXrSCt4hGlF9m5kU11c0OJlT8VmZC/QoOXDwVbPoqWOS56Cp/QFYQv2IreAjslZROENxCEKOT4rZ7JxftdhQydcbG1K2hfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.cn; spf=pass smtp.mailfrom=zohomail.cn; dkim=pass (1024-bit key) header.d=zohomail.cn header.i=zyc199902@zohomail.cn header.b=fZoatRy3; arc=pass smtp.client-ip=163.53.93.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.cn
ARC-Seal: i=1; a=rsa-sha256; t=1764759902; cv=none; 
	d=zoho.com.cn; s=zohoarc; 
	b=IRQ6M7c5DIQ0y3LjkFSrAeJWr881wCaRS/D8wZbW38CvkPIyfnxFXGjPPR9tTiXVKBtB0Rq++sSAiUczTbt86NycMkaYCu+RjXKEjtpPPxMa9bhwfYpUDsCkPxopzwopWW6RQC6kF4zGscFuOLcVYqUWyVWw0QtH+GWdJc6lj2Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
	t=1764759902; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HDZ7mQ2+VFrGJG1MA+Ab0mOWoSY8QCfMJdwqqSfq6tU=; 
	b=WbDWxsKUEVw7sV611SgRXzxqThXC6X4V/1JIy2Lp1XGMqAyZbNuGmVGxohjoKU0nWREcmzze656SHSzxE6uEh+rVODFV73ukEJszahntI9AVJlkCittHCb4r6CA5a4Nx8GCvt/FTjm2YjjbOpla+cEhm1rLJo8gDXhGZkosFVGI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
	dkim=pass  header.i=zohomail.cn;
	spf=pass  smtp.mailfrom=zyc199902@zohomail.cn;
	dmarc=pass header.from=<zyc199902@zohomail.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764759902;
	s=zoho; d=zohomail.cn; i=zyc199902@zohomail.cn;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HDZ7mQ2+VFrGJG1MA+Ab0mOWoSY8QCfMJdwqqSfq6tU=;
	b=fZoatRy3BfTiLBF+39SCo1IzCnvgTHqiq21MF3jJMuXLNIs+Lwrm7M8x4t29B+ZL
	4k6ksIJmWXAcezX3qJ8rpHHOxxS+sHLuMY8Bxv9Iab69lleTtHQbS2oFlTGM1IdUqNG
	eKGTUxREpDWINifb2R0gXSKYEW18iA3zStR+PRnA=
Received: from mail.baihui.com by mx.zoho.com.cn
	with SMTP id 176475990029128.676885623777252; Wed, 3 Dec 2025 19:05:00 +0800 (CST)
Received: from  [73.170.62.200] by mail.zoho.com.cn
	with HTTP;Wed, 3 Dec 2025 14:05:23 +0800 (CST)
Date: Wed, 03 Dec 2025 19:05:00 +0800
From: zyc zyc <zyc199902@zohomail.cn>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: "stable" <stable@vger.kernel.org>
Message-ID: <19ae2d0c40c.1304ed0542955.1614492155671387965@zohomail.cn>
In-Reply-To: <2025120248-operation-explain-1991@gregkh>
References: <19ace674022.114eb26e714992.3171091003233609170@zohomail.cn>
 <19adda5a1e2.12410b78222774.9191120410578703463@zohomail.cn> <2025120248-operation-explain-1991@gregkh>
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

---- Greg KH <gregkh@linuxfoundation.org> =E5=9C=A8 Tue, 2025-12-02 19:30:0=
9 =E5=86=99=E5=88=B0=EF=BC=9A---

 > On Tue, Dec 02, 2025 at 06:39:00PM +0800, zyc zyc wrote:=20
 > > Hello,=20
 > >=20
 > > Resend my last email without HTML.=20
 > >=20
 > > ---- zyc zyc <zyc199902@zohomail.cn> =E5=9C=A8 Sat, 2025-11-29 18:57:0=
1 =E5=86=99=E5=88=B0=EF=BC=9A---=20
 > >=20
 > >  > Hello, maintainer=20
 > >  >=20
 > >  > I would like to report what appears to be a regression in 6.12.50 k=
ernel release related to netem.=20
 > >  > It rejects our configuration with the message:=20
 > >  > Error: netem: cannot mix duplicating netems with other netems in tr=
ee.=20
 > >  >=20
 > >  > This breaks setups that previously worked correctly for many years.=
=20
 > >  >=20
 > >  >=20
 > >  > Our team uses multiple netem qdiscs in the same HTB branch, arrange=
d in a parallel fashion using a prio fan-out. Each branch of the prio qdisc=
 has its own distinct netem instance with different duplication characteris=
tics.=20
 > >  >=20
 > >  > This is used to emulate our production conditions where a single lo=
gical path fans out into two downstream segments, for example:=20
 > >  >=20
 > >  > two ECMP next hops with different misbehaviour characteristics, or=
=20
 > >  >=20
 > >  >=20
 > >  > an HA firewall cluster where only one node is replaying frames, or=
=20
 > >  >=20
 > >  >=20
 > >  > two LAG / ToR paths where one path intermittently duplicates packet=
s.=20
 > >  >=20
 > >  >=20
 > >  > In our environments, only a subset of flows are affected, and diffe=
rent downstream devices may cause different styles of duplication.=20
 > >  > This regression breaks existing automated tests, training environme=
nts, and network simulation pipelines.=20
 > >  >=20
 > >  > I would be happy to provide our reproducer if needed.=20
 > >  >=20
 > >  > Thank you for your time and for maintaining Linux kernel.=20
 > =20
 > Can you use 'git bisect' to find the offending commit?=20
 > =20
 > thanks,=20
 > =20
 > greg k-h=20
 >=20

Hi Greg,

The error came from this commit:

commit 795cb393e38977aa991e70a9363da0ee734b2114
Author: William Liu <will@willsroot.io>
Date:   Tue Jul 8 16:43:26 2025 +0000

    net/sched: Restrict conditions for adding duplicating netems to qdisc t=
ree
   =20
    [ Upstream commit ec8e0e3d7adef940cdf9475e2352c0680189d14e ]
   =20
    netem_enqueue's duplication prevention logic breaks when a netem
    resides in a qdisc tree with other netems - this can lead to a
    soft lockup and OOM loop in netem_dequeue, as seen in [1].
    Ensure that a duplicating netem cannot exist in a tree with other
    netems.
   =20
    Previous approaches suggested in discussions in chronological order:
   =20
    1) Track duplication status or ttl in the sk_buff struct. Considered
    too specific a use case to extend such a struct, though this would
    be a resilient fix and address other previous and potential future
    DOS bugs like the one described in loopy fun [2].
   =20
    2) Restrict netem_enqueue recursion depth like in act_mirred with a
    per cpu variable. However, netem_dequeue can call enqueue on its
    child, and the depth restriction could be bypassed if the child is a
    netem.
   =20
    3) Use the same approach as in 2, but add metadata in netem_skb_cb
    to handle the netem_dequeue case and track a packet's involvement
    in duplication. This is an overly complex approach, and Jamal
    notes that the skb cb can be overwritten to circumvent this
    safeguard.
   =20
    4) Prevent the addition of a netem to a qdisc tree if its ancestral
    path contains a netem. However, filters and actions can cause a
    packet to change paths when re-enqueued to the root from netem
    duplication, leading us to the current solution: prevent a
    duplicating netem from inhabiting the same tree as other netems.
   =20
    [1] https://lore.kernel.org/netdev/8DuRWwfqjoRDLDmBMlIfbrsZg9Gx50DHJc1i=
lxsEBNe2D6NMoigR_eIRIG0LOjMc3r10nUUZtArXx4oZBIdUfZQrwjcQhdinnMis_0G7VEk=3D@=
willsroot.io/
    [2] https://lwn.net/Articles/719297/
   =20
    Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
    Reported-by: William Liu <will@willsroot.io>
    Reported-by: Savino Dicanosa <savy@syst3mfailure.io>
    Signed-off-by: William Liu <will@willsroot.io>
    Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
    Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
    Link: https://patch.msgid.link/20250708164141.875402-1-will@willsroot.i=
o
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>
    Signed-off-by: Sasha Levin <sashal@kernel.org>


zyc

