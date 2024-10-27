Return-Path: <stable+bounces-88223-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45AA59B1C88
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 09:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CC81F21007
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 08:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC43B4AEE0;
	Sun, 27 Oct 2024 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="iC3cRi+e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IpiFXEya"
X-Original-To: stable@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C062905;
	Sun, 27 Oct 2024 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730018439; cv=none; b=YnKoCe1QXykB+fueNXdhU/wyJnYR/LgGzhT9iyBQsu64Ucg7CopLA2BS7kdlfuq6LdyTXuqp/88eSeBlOG/xAyQSYh0QUIYr0ua5VL8Ng06yWjFxRasNFkWMoHc3L4L/dbbVkXGGAZXXMAViBm4mQa4raCnS02LuagO0rJBrpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730018439; c=relaxed/simple;
	bh=EQmy0XTUHn2JD9wDXK7Hv2K9IJnG8aDWMvA/QFheUvo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bQZ8lkwQvT6z1hFdvEQz++Zi9o21oAgFMRYEg5UsWiad7luILsSjdyJ7wtXHzcNgn1bmsk3K9i4Z6U2EvahJo3NNUStpWNdA6u1EiioJi73nfo/a413lnadMHKrkA3m0Gp2ukpMvj3NiEX/elC9lKwqqHBGItuiwzpZaD4c8u6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=iC3cRi+e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IpiFXEya; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2991A13801BB;
	Sun, 27 Oct 2024 04:40:36 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-09.internal (MEProxy); Sun, 27 Oct 2024 04:40:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1730018436;
	 x=1730104836; bh=EQmy0XTUHn2JD9wDXK7Hv2K9IJnG8aDWMvA/QFheUvo=; b=
	iC3cRi+eK3+TlzfrpkQ5BH00Gx+0CGvT033Za4JBqwa2avI2W0k9TqLfvEJGbCbJ
	MZyaJpQskj6xDFm10yzrHs2/6ezxgZ6efg/hRb3U4JsShnNW3kNoQaw9GW56demm
	hNpO2vr0EsmFbYpoS6v9eBJL6cFPvizY1ubuTI8pXx0pAor27idazZMR3AwurCjf
	8bmhwyGxDXcmAliPDjQceiQqDAI6erc3Vi9UCu78Zouz726clcB3ZhxKd5Pivc22
	D07+qg4LzIhk7OU8aKioZVAFJoDzEYsbJNV09KZb0R8vG80T/16ZVI8WM0dZ3R1i
	ee+5aTRpAO6RlOyGQjHSjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730018436; x=
	1730104836; bh=EQmy0XTUHn2JD9wDXK7Hv2K9IJnG8aDWMvA/QFheUvo=; b=I
	piFXEyaA8hvIAHAPi0PJBk+NZw+hyynkqdGvC2A0LZY9/bk+M/ppI83sDNiRAxhG
	NHvlRTUtUKP4uEydO/lJ42TBDiMQOmUj3R/DSaHLeqsCrIPDk9OLf8SM/FO1g44h
	lv0Q0xlnU9uOtKSRobygVQEY7J1Hy3dUY8RdxItAaWMU3HDg6EUoD/psxcEW/yEG
	7dsvZeuyN5JAQNKdzBbnMcbnF/NejLVh09xRv22B9M6yidkB7GquwqsWS4hahmj/
	HMQXdTc0ZkvPu9xuMZ+QCAtZPFEzWr9khEL1e3C2Br++tUFSIVDLIIF6HgE/NbEM
	RousnL85VMVKNc8rXRN4w==
X-ME-Sender: <xms:g_wdZ5JM_0Ugu29HieQ0aSnswQm-2bXEaqRO2dFfNgNOnM2iC18mCg>
    <xme:g_wdZ1LiDKdzOqhIkWS5oSbqufOkEpHACrs3xGLGiQSkK_luNtWGNgFd6O_5gWemM
    _fChnbNyPpSPTTt02M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejhedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdflihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgse
    hflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeejheefuddvtdfggfdvffek
    teehhfelgfdvvedvkeeuffefkeehheegvefhveetjeenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghho
    rghtrdgtohhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepfiesudifthdrvghupdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshh
    hurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslhhinhhu
    gidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuh
    igfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhn
    vghtpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehlihhnuh
    igqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:g_wdZxthymqs3iwR1qjRaTdVjamooQ8O0JQgnKeHJMXE2sTWCazldA>
    <xmx:g_wdZ6YGMX9jgEimZMezO3I60CF_l_j25tHXhmgYZcwqvDXSfQwFVg>
    <xmx:g_wdZwa9JIVVZcSUB51FteVs5Fu0nZDZnYd3L-0iJWO_Gt9lRWH9LA>
    <xmx:g_wdZ-B75qij7SPplLN0M3LMJFeCv2saYYTyH2i21Cq5hFeDkjKHpw>
    <xmx:hPwdZ9Sc7I7sIgRoIqQqcSlxSxS5BshGbnXfDthAY9bZmL9c8p_PpAB0>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1229E1C20066; Sun, 27 Oct 2024 04:40:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Oct 2024 08:40:14 +0000
From: "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To: "Willy Tarreau" <w@1wt.eu>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-doc@vger.kernel.org,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shuah@kernel.org,
 lee@kernel.org, sashal@kernel.org, "Jonathan Corbet" <corbet@lwn.net>,
 linux-kernel@vger.kernel.org
Message-Id: <a4aab1f1-89ed-493c-bd9d-bd2576c1d732@app.fastmail.com>
In-Reply-To: <20241026175446.GA9630@1wt.eu>
References: <73b8017b-fce9-4cb1-be48-fc8085f1c276@app.fastmail.com>
 <20241026145640.GA4029861@mit.edu>
 <522bd817-339a-45b0-84c2-2b1a4a87980a@app.fastmail.com>
 <20241026175446.GA9630@1wt.eu>
Subject: Re: Concerns over transparency of informal kernel groups
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



=E5=9C=A82024=E5=B9=B410=E6=9C=8826=E6=97=A5=E5=8D=81=E6=9C=88 =E4=B8=8B=
=E5=8D=886:54=EF=BC=8CWilly Tarreau=E5=86=99=E9=81=93=EF=BC=9A
[...]
>
> I hope this clarifies its role a bit!

Thanks Willy, very informative reply!

I'll try to incorporate some of that information into the documentation.

> Willy

--=20
- Jiaxun

