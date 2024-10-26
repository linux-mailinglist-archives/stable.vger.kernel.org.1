Return-Path: <stable+bounces-88218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F47B9B1A21
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 19:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A53B6B2162D
	for <lists+stable@lfdr.de>; Sat, 26 Oct 2024 17:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE82172BB9;
	Sat, 26 Oct 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=revi.email header.i=@revi.email header.b="UQhV9nj7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aqm1Zm5/"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D576FB9;
	Sat, 26 Oct 2024 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729964355; cv=none; b=Df+5DzE9n8kanmJhFMQWSMG+llcofkojrGP475zS9KZJz93hnf1Mzp8zs4iQcnNUccFq19iPifR/qsRYpaFjHh1IXp5sH4SFPVWJ0SSEXXi8JtVsmYoKW/Th4LIIkKE6PNKDf+2ZC1YlxHvzsUC0eC/YAmWZICpF3UZEwx6B48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729964355; c=relaxed/simple;
	bh=D3RmwI4bu3/8BxSAVeLi4RAOLqlxj/oLNWo2qcTdduo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:Subject:
	 Content-Type; b=NLFxu67elgqx1JW2C0IZSYYdoIqZBc4pjC12Gzu1Z7OSqw179DXd9DHUb9AeNdttdnafP5j2YmP65HNjRhhseYkxT3S058eRPPKUMobiiUBIuQaoeo4u3VF8DtfmKqwAfPkTRhDWsRcfsOIWr05ftZTUxbGrXahuqp/RYA2vzwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=revi.email; spf=pass smtp.mailfrom=revi.email; dkim=pass (2048-bit key) header.d=revi.email header.i=@revi.email header.b=UQhV9nj7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aqm1Zm5/; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=revi.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=revi.email
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 261621380223;
	Sat, 26 Oct 2024 13:39:11 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-01.internal (MEProxy); Sat, 26 Oct 2024 13:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=revi.email; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1729964351; x=
	1730050751; bh=o3IeO3jQIb1Qjuj3w22aq9LgOdGupsxgBB3CjNvb0n8=; b=U
	QhV9nj7SiWR90hvVN+St8X3/V3Ewu53YNYFmj1fZebZqSiay89B7NWeV0lZ5bwRF
	/9Hp4iQJR69nCLnX+qoXAlTI0Bskg4dKKg471kNJToxp5g7Hv4yMHJK3ViacvnBO
	YMjRHcC2S9a/R+dC/RstCe+CxyjIu9yI2BcFzBN1nMtjapOweQZj997fUpBYSOzz
	IUxDuDKRRe0kN4LpPx/WCLEVPu5jJaw1egVSK3TNbe7LBxCAHDZShvmVlr3PfRUM
	b2Ug+0jMGRX8JzqatPIbSQEWB3gLn8g2KG4qC6z0KHXdTwbEoNlJBoZ51BWt92zQ
	bGhHPi27nozcbViuTlujA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729964351; x=
	1730050751; bh=o3IeO3jQIb1Qjuj3w22aq9LgOdGupsxgBB3CjNvb0n8=; b=a
	qm1Zm5/KxNSuq2Zgrkch09OvXwGuyPrtf/gmMx8UVNUryVB/xF7f7Ng6Fnduhkoy
	n8nxjgKBMhc8Y5JRi+6L/trievSDkyjCCrm7nN2HBay4KmhC5JkEAwxxrr9t6QI2
	2iUTZ29VVHdPpSBwXJlxavPLE34/cjHPUCChYJgAlkpe0dUcibn6Oij30fS75vqd
	egwD9RGYITFAKRAhVV37snjWmcIG2fP/E6VZruT8aRxSONnXVUh+0Cq3c6WwFn/Q
	OQN+3G0rry7Zu13SmdPjbwNaSxXKuQRN4PjfiagS9rKOGTrpnQMBGWQFmaVEEWlp
	qQDSSOjsLbUn0NeKYWWpw==
X-ME-Sender: <xms:PikdZ_GOgoKqi4didu-Nr54oT8dRdr_YTrdJklM-bflPUKPPYw5mxw>
    <xme:PikdZ8V-JeqA4mBh49Aey1Qp16K-KOECikEqfTbZe6zAXvo1rEKmQjsdA5ZshHqMU
    yMaqgKCV_NzlcEhzOc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculd
    dujedmnecujfgurhepofggfffhvfevkfgjufgtgfesthhqredtredtjeenucfhrhhomhep
    jghonhhgmhhinhcuoeihvgifohhnsehrvghvihdrvghmrghilheqnecuggftrfgrthhtvg
    hrnhepffetjeejleevfeelgfelteevheelgfekheevuefgleetlefhtdetveetfeegkeeh
    necuffhomhgrihhnpeifihhkthhiohhnrghrhidrohhrghdprhgvvhhirdighiiipdifih
    hkihhpvgguihgrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhephigvfihonhesrhgvvhhirdgvmhgrihhlpdhnsggprhgtphhtthhope
    dufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomhdprhgtphhtthhopegtohhnughutghtsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegtvhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggv
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghshhgrlheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgvtghurhhithihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslh
    hinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehl
    ihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:PikdZxJQ2AwbB4WTvMzRyJkzHoDhlQFqdOyXE9vTJ-Ki-q0A5ikoig>
    <xmx:PikdZ9GvhYESnUnKlTmZMQjZvAMQGnQWo5ef64YIChqPvL2G5SBroQ>
    <xmx:PikdZ1Vm0dAKN2lGlcmUu7uRoFOU6FYt5-g7xe0qr3yTQSaSdMUjJg>
    <xmx:PikdZ4OMW5gal6-FPlfBllDEnJLG-1zDG_p4cYPMteEsJBNXWVhCww>
    <xmx:PykdZ-uE3iRqM96VVUE4ptaulJnazS5PFyV6NQiRdM283OjcL0_3Go0X>
Feedback-ID: ie2a949ef:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 170D6780068; Sat, 26 Oct 2024 13:39:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Oct 2024 02:38:49 +0900
From: Yongmin <yewon@revi.email>
To: jiaxun.yang@flygoat.com
Cc: conduct@kernel.org, corbet@lwn.net, cve@kernel.org,
 gregkh@linuxfoundation.org, lee@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, sashal@kernel.org, security@kernel.org,
 shuah@kernel.org, stable@vger.kernel.org, torvalds@linux-foundation.org
Message-Id: <166cb904-efb6-4dad-b30c-0dcbc600db5e@app.fastmail.com>
In-Reply-To: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>
Subject: Re: Concerns over transparency of informal kernel groups
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello from random bystander watching all this,

You probably should have used the term 'in camera' [1] instead of inform=
al groups.

[1]: https://en.wiktionary.org/wiki/in_camera : "1. In secret or in priv=
ate (in an enclosed room, behind closed doors)."

Bye,

----
revi | =EB=A0=88=EB=B9=84 (IPA: l=C9=9Bbi)
- https://revi.xyz
- he/him <https://revi.xyz/pronoun-is/>
- What time is it in my timezone? <https://issuetracker.revi.xyz/u/time>
- In this Korean name <https://en.wikipedia.org/wiki/Korean_name>, the f=
amily name is Hong <https://en.wikipedia.org/wiki/Hong_(Korean_surname)>=
, which makes my name HONG Yongmin.
- I reply when my time permits. Don't feel pressured to reply ASAP;
   take your time and respond at your schedule.

