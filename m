Return-Path: <stable+bounces-88179-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37519B0870
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 17:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC161F24012
	for <lists+stable@lfdr.de>; Fri, 25 Oct 2024 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEC1158DDC;
	Fri, 25 Oct 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="QM7LPu1s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RW8JfO4s"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1821A4DC;
	Fri, 25 Oct 2024 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870619; cv=none; b=iZUzjuS4lAT4586hdVuhKQvX+uRQjwpizcMAh3U4KcvOtwgFW+gndT1qIf0pnJdoUye+1MiVX54AgbNYkMNWfsjdmDox3sp/bnqcUAlpIKSZdm2Yd0z36ELG9rbAbYLnsr0J6/qOiKuWPPHC9gs2hLrHTeMGLB8OJTn6JKuPxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870619; c=relaxed/simple;
	bh=58tBmcAbE8WDoQiDmb6MuPoQvbEp4xrH1h7S3g7lf+w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=N+Lcj3VwN1QEOQeEhV+PsPkCHpm1csI9LSvAJoRNbOJme5uxUpBvL7p0hACMtHjAav2ZVGffG5tgE39doeT343b91YDM0mB4fAVnWXNyO4zJUuzeZ1JdTbZYlCjD+3e5CmX+todX6XnSwPvIaUTMWe4/8HevqdLP/+VtVxabN14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=QM7LPu1s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RW8JfO4s; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EE13B1140132;
	Fri, 25 Oct 2024 11:36:55 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Fri, 25 Oct 2024 11:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729870615;
	 x=1729957015; bh=58tBmcAbE8WDoQiDmb6MuPoQvbEp4xrH1h7S3g7lf+w=; b=
	QM7LPu1sE/1gaomj169CAn9tUlZtCIlFjvM0oahlEnGMSlntIOM0omjP8XTA5rpY
	D0wiG6/NEK7Sln53HVUXKXqFc8fJYv0kMl8RRoVquEF9a+In6+ttOtMINAx0DSjQ
	A/Hky49COGSuVFYcuv48K3kTnncH3s0Yakvm9yPVvT7aOSk+cWQVCWBJ/+Jngcxa
	s2OuEKNxgmHQg9wo7V5MkHKkLsbnO/F0l1wQBMrsln7hGOHn3r9tYD+hguQyVu0h
	+eGFvJ6TaBNFqeo02SjQqS/AtQsPrr7XjiVguQzzQmN5jPbrGVa6MpbQ+nkpkhkU
	rQRiq0oFX0v71OWOkxDERg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729870615; x=
	1729957015; bh=58tBmcAbE8WDoQiDmb6MuPoQvbEp4xrH1h7S3g7lf+w=; b=R
	W8JfO4sypxJs2giDiVRpKk05PpxYancMlUZntgGZR0KqQ/vCp9SLwRzZ6rU89ElA
	Xb0ps7bN9M8UXPjLiWBAF8ZAPb7273jdubPAGNCRmZIYISFXLRfDJd5ABaC7Dnj9
	nxmTd5pcgQ9rSnb5c8MZp1q5qjGVfmdXhcy8YOBN9WGkGm5BCcGF5oiYILUhSoJy
	t8ppWAs+GSzWeBQvwEw1DEkfuej5yNgqUeLlJvGcqInqWHWFYSG9R+LQOOmpiwWv
	awtoRY2zbbTFKO7SjlPlUBkxkg+z4xWLyPtXcC8Evfwosf7lUVNfvM8aUtPAPc0K
	DSnzyOe/AIvkQ5wUeL8PA==
X-ME-Sender: <xms:F7sbZ6ncZUg_4q5YhdgWD8ZEvNBX10sKPZnbYJNwz2EUAX1v5VSXvw>
    <xme:F7sbZx3mYJkPTeDNQtovtRWdg9aqyBb88yYq86bHVtDHT95cDCMnigNhY0G6uucua
    v50QNv2L9JOrtpVgu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfh
    hlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepffekveettdeuveefhfekhfdu
    gfegteejffejudeuheeujefgleduveekuddtueehnecuffhomhgrihhnpehkvghrnhgvlh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmpdhnsggprhgtphhtthhope
    duvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghonhguuhgttheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsvggtuhhrihhthieskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhorhhvrghl
    ughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehgrhgvgh
    hkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegtohhrsggv
    theslhifnhdrnhgvth
X-ME-Proxy: <xmx:F7sbZ4pgHJ2nIeTaTeZcMO1OtHN63xfzLvKWCQ0kFQhP4QTxdMp7xQ>
    <xmx:F7sbZ-mC7FMPBlVLDNK9F-Q7y8Gy3DBQwj9D51w9SXQFi-9im0CCEQ>
    <xmx:F7sbZ43XYDJnSIvmqWCJqs6EEp1MUkHZffQ4KfIIpWn5dTbG5VX5nA>
    <xmx:F7sbZ1sRx_FMfb0LY7bLU1OXEcUjds4o3do-W2nj7fSfsiutCV6czQ>
    <xmx:F7sbZ9swgC2uWQ3P5xU_U5EzKYTY4gL2rwCeHxHwVEQMgxZRg5fExanl>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 927BB1C20067; Fri, 25 Oct 2024 11:36:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 25 Oct 2024 16:36:35 +0100
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: linux-kernel@vger.kernel.org, conduct@kernel.org, security@kernel.org,
 cve@kernel.org, linux-doc@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shuah@kernel.org,
 lee@kernel.org, sashal@kernel.org, "Jonathan Corbet" <corbet@lwn.net>
Message-Id: <0ac6833c-8e7e-458f-a7c8-833901b3e990@app.fastmail.com>
In-Reply-To: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>
References: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>
Subject: Re: Concerns over transparency of informal kernel groups
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8825=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=884:15=EF=BC=8CJiaxun Yang=E5=86=99=E9=81=93=EF=BC=9A
> Dear Linux Community Members,
>
> Over recent events, I've taken a closer look at how our community's=20
> governance
> operates, only to find that there's remarkably little public=20
> information available
> about those informal groups. With the exception of the Linux kernel=20
> hardware security
> team, it seems none of these groups maintain a public list of members=20
> that I can
> easily find.

Just to correct, people notified me that a membership list for Code of
Conduct Committee is available at kernel.org [1] instead of in source tr=
ee.

[...]

Thanks

[1]: https://kernel.org/code-of-conduct.html

--=20
- Jiaxun

