Return-Path: <stable+bounces-88177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9003A9B07E0
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 17:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2136D1F25929
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 15:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070C0185E50;
	Fri, 25 Oct 2024 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="cjaqCGAD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fkBaxrbN"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42252170A20;
	Fri, 25 Oct 2024 15:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729869434; cv=none; b=oF1S0mb2ijGFTFR+lv/l7ofAqm0V7W4KstohLihdm6fK+3Rhoa77bo6JWXq0Dn6o9gn6CA6Ka9z4fmj3c6eovejta6e2pGCzzxu4lZeL64wRxszwNCZMIzPsYBugZAs24la1u8zp42QU3Qi6kuBc3wOQPZtVMVCXV1logOodxTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729869434; c=relaxed/simple;
	bh=36irzOhZbIRw7cPQRnWTvJeq+F1VD8ZJ4OsqbkyP5S8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=GYJF6X4JCC7EmsjVqO5EPu+Nk0G3Udjnxg/ZEKL9hI/tMI85pXBr+OotmEyNqKyD/8cvfj32SXd/bGTNyGGX7BdeVl1/XYlizVvGTSQLiK+pqU88UvIxH2+MZyHl27QNlJgJtrF6JvG9dUQxZHpRCkRNfv0qt8u3Lgvbyo6ChTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=cjaqCGAD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fkBaxrbN; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4ECA611400FE;
	Fri, 25 Oct 2024 11:17:11 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Fri, 25 Oct 2024 11:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1729869431; x=1729955831; bh=Qq
	75eh/iLSb6i7lwJ20sbQlkVHzVLepTD+MIIfFJCwc=; b=cjaqCGAD2SWOFqbT9+
	hIt4ky/8BRDwinooMMmT5mEEANsjbiJ1WoDpHF3zaeG0wUkxJHEM1cwWr/pbgtCk
	iumZVyIcr1b8wKTjTnYYw6uRWKNCrN4ypY591+oPd/qua/3GiCuTaTBIY+j80lFe
	rvIkTJRvaiJDXUp06x0gKzEWjl66S7qgh0KaNCmEgSCwcAV0VXQCX1+ZP7HK0lVy
	hJUvTAgQOzlkYX9fk11BYCygHjwkj9qy2BDHCZjrWpXURz3DUF72Gx7xEJ2kHQEX
	u7U13OO7vWr6rtROBDm/YRmhm7um9Rk5Cv7pbHCprNo7bGuUDs4mmZ+0uUlukQn9
	A2FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1729869431; x=1729955831; bh=Qq75eh/iLSb6i
	7lwJ20sbQlkVHzVLepTD+MIIfFJCwc=; b=fkBaxrbNvDFcDExScVgLalEmYGlFb
	PAlkOnvWKBVl5cJgS+jLD4cgs5Y+QnLat5CWRvxRZnxDeuqlf8UoSyAmLz+0xTcZ
	tLD4CDF6kILZfDTVUqd2SPOPFL/dbjzub1qP9xEF5df3pmRRS5A5ofG4RLseIlXF
	9Ao+6daQUW9ly5qHSrsWL9GoP5oM8fC71pW9ixAZSuuybOzwFwzJ48Jt+X5oA6F4
	1arnz+CfMePs+qeujQ+QXsssyGFozrLAUkvTRZG9fYs0p+/mzRvNwVQ0vFkshuwe
	cwArs97qWX9ZsvhFgHT0+Jly80ozIroevU8RmOSbSKOrgeW0nuT6h8a4Q==
X-ME-Sender: <xms:drYbZ9HBq7cVT2j6k0BNK9p17lYIWLxiT01b2vpOfkX0q1T2gL5V6w>
    <xme:drYbZyVo5bb6RWL-iS-rXHPCw32H_MWCY9hyRungLpommhfnVFR_2z4vwZo1SKqO1
    22V--PzV0ae4SwUqKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkffutgfgsehtqhertdertdejnecu
    hfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfedtteelgfeugfdugefhjeetgfei
    uedvfeehleeghefhgefhffduveelveevfeefnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegtohhnughutghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtvhgvsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehsrghshhgrlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgvtghurhhithih
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhugidqfhhouhhnuggrthhiohhnrdho
    rhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-ME-Proxy: <xmx:drYbZ_Ltugr73YXgEN9QJBaM0iiXyRDfwgtp4zIi808m-m7Fy7zI1w>
    <xmx:drYbZzEoWv87H-oHg1DY5jMvI3ZG7bv8hpjO64_iezs4k18Yd3TaxQ>
    <xmx:drYbZzXn7oA5KU42_2P5pwmMsStXxGA-iTsAxaFgequfl76pqkIOKA>
    <xmx:drYbZ-OrNCXSEtRWJq0KpzEJuwDdQjqUkoZEaKHX9awoc8laGePqdw>
    <xmx:d7YbZ2N9KR0f5_QeVE6_ZJDrEk48Szd_s9J_oCZgSro0JlSRehc6gO-S>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B49061C20066; Fri, 25 Oct 2024 11:17:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 16:15:42 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: linux-kernel@vger.kernel.org, conduct@kernel.org, security@kernel.org,
 cve@kernel.org, linux-doc@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shuah@kernel.org,
 lee@kernel.org, sashal@kernel.org, corbet@lwn.net
Message-Id: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>
Subject: Concerns over transparency of informal kernel groups
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Linux Community Members,

Over the years, various informal groups have formed within our community,
serving purposes such as maintaining connections with companies and exte=
rnal
bodies, handling sensitive information, making challenging decisions, an=
d,
at times, representing the community as a whole. These groups contribute=
 significantly
to our community's development and deserve our recognition and appreciat=
ion.

I'll name a few below that I identified from  `Documentation/`:
- Code of Conduct Committee <conduct@kernel.org>
- Linux kernel security team <security@kernel.org>
- Linux kernel hardware security team <hardware-security@kernel.org>
- Kernel CVE assignment team <cve@kernel.org>
- Stable Team for unpublished vulnerabilities <stable@kernel.org>
  (I suspect it's just an alias to regular stable team, but I found no e=
vidence).

Over recent events, I've taken a closer look at how our community's gove=
rnance
operates, only to find that there's remarkably little public information=
 available
about those informal groups. With the exception of the Linux kernel hard=
ware security
team, it seems none of these groups maintain a public list of members th=
at I can
easily find.

Upon digging into the details, I=E2=80=99d like to raise a few concerns =
and offer some thoughts
for further discussion:

- Absence of a Membership Register
Our community is built on mutual trust. Without knowing who comprises th=
ese groups,
it's understandably difficult for people to have full confidence in thei=
r work.
A publicly available membership list would not only foster trust but als=
o allow us to
address our recognition and appreciation.

- Lack of Guidelines for Actions
Many of these groups appear to operate without documented guidelines. Wh=
ile I trust each
respectful individual's integrity, documented guidelines would enable th=
e wider community
to better understand and appreciate the roles and responsibilities invol=
ved.

- Insufficient Transparency in Decision-Making
I fully respect the need for confidentiality in handling security matter=
s, yet some
degree of openness around decision-making processes is essential in my o=
pinion.
Releasing communications post-embargo, for instance, could promote under=
standing and
prevent potential abuse of confidential procedures.

- No Conflict of Interest Policy
Particularly in the case of the Code of Conduct Committee, there may ari=
se situations
where individuals face challenging decisions involving personal connecti=
ons. A conflict
of interest policy would provide valuable guidance in such circumstances.

Thank you for reading. I know none of us enjoy being pulled away by thes=
e non-technical
concerns, we love coding after all. However, I feel these concerns are v=
ital for the
community's continued health. It might be a candidate of Linux TAB discu=
ssion.

I'm looking forward to everyone's input.

Thanks
- Jiaxun

