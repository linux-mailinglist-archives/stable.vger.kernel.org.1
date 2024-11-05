Return-Path: <stable+bounces-89930-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1669BD903
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 23:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16A4C1F23981
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 22:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79C21642A;
	Tue,  5 Nov 2024 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alfmarius.net header.i=@alfmarius.net header.b="waeDF8k5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9e3CEbU"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4144F216420
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730846895; cv=none; b=kvMwKwPNxxiO40jdCbLeqGYYBC7a1yDTaNd9nbhDU1I3IpQI+v0aYRCYG0FJPmRZVmXSSub7XWrwA8KHbFR1SMnt/3SsC76LKuG9QXaysTlx1SQYsKAdXr8tVbinkZHcFmvUFv7cjs7LWOZYzdZP+KiPaXNqg22kgEv3Hl9ouC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730846895; c=relaxed/simple;
	bh=iW1tNc9O7uEvjUQwmdt1RUFW81Id0+IQ9wZ8Pyt34VM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=c7cXahG1ckq59YO+RY7i9mtlCHLM9Z6PR1/TL90aDa9xIQmD1D8Kt27xhc00DBsnPE5yWt36xEYnQuEs7t5vQ6btRARHDEWtT6btnHcLYlBrJAYfTaBfcqHX6fduobO9z+aTMRMgNCrn0hzd5qryk9hwP86bvqYhED96faR+G5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alfmarius.net; spf=pass smtp.mailfrom=alfmarius.net; dkim=pass (2048-bit key) header.d=alfmarius.net header.i=@alfmarius.net header.b=waeDF8k5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9e3CEbU; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alfmarius.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alfmarius.net
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 39AFC2540160;
	Tue,  5 Nov 2024 17:48:12 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-03.internal (MEProxy); Tue, 05 Nov 2024 17:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alfmarius.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1730846892; x=
	1730933292; bh=RoPwgRrou0yJo6bFtd+HRP8JHVcoD8XHfthAs6rLsJg=; b=w
	aeDF8k5qY+ondh/tCB92iLXE8d4ozutzyovOrR16PVtwfQd/4OnKeTidTxExdgYv
	o718JYqiBPZaWDqV4j0venioR2D52g4KBBzVWQj6otGVLsLAq4UaRLNDJ+QfcMwS
	MOlpDVTpwJwYkilmbwoW1JsyBPkjCEDqggow1BvBVvV4nIX9knvZDzM4PXJ2ELk9
	oA5koaegs1BJl6GG+L5v7CWcBwpQ/QGZta0XaTr4RVPRN+HsYDoczY1zhe5bpvrZ
	PJ6SPbuEQk38Ddt256K+1IwDkEyw/kl4dmIyOUiVBh/PcTbf+rUn5CdrD/pwMCA+
	fq3e8KE8SGXmu1HsnMHqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1730846892; x=1730933292; bh=RoPwgRrou0yJo6bFtd+HRP8JHVco
	D8XHfthAs6rLsJg=; b=g9e3CEbUK9HPPvfU/KNzDlWFi/StOsLVs4+FRo674fC6
	N1jA6y1oitkt/U2jOPzIJJww7nBhe2+OUA18mDRdXzlL/S54wwWMXkZ7GPKqvYa2
	kclbte++zPuEwESEba/BgIIrGWbG0aaJ/WbCe8IwPub18sKP/KB/MFC1U7h+ZrRu
	W0bKy/Sc6nW2YBjZnHa3t5AsNeE8i2R6O9Y98ykVeIwxVHWQ7L4D5Df3X5T5RIlZ
	gmmjNcd+8lvx4eQWI1tuPUtSruzKFmg0FFbpShKpK7qOYGr/ZjRbUumA3h5jFTLk
	BWbGj7sgWdNDwq/99Vv5OmU/7lBjMGifgNCcFKSMUw==
X-ME-Sender: <xms:q6AqZ9VCkq_DLNM-6rpPlXe8dRajsl63jdwfvxt4HMn2LOFghgJs7g>
    <xme:q6AqZ9nuo8OQr7-zLznfKwv4MgOx565qxsh2RVAmgCegwcbXFj9zWLn13xbu1dExg
    V5lGXPUfAobZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddugddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkufgtgfesthejredtredttdenucfh
    rhhomhepfdetlhhfucforghrihhushdfuceophhoshhtsegrlhhfmhgrrhhiuhhsrdhnvg
    htqeenucggtffrrghtthgvrhhnpeegtdekvdejffffuddvgeektddtfeekheeigeegffei
    udfgteeghfejudelgfduvdenucffohhmrghinheprghrtghhlhhinhhugidrohhrghdpgh
    hithhhuhgsrdgtohhmpdhpkhhgsghuihhlugdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpohhsthesrghlfhhmrghrihhushdrnh
    gvthdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    sggrthihihgvvhesghhmrghilhdrtghomhdprhgtphhtthhopehkvhgrlhhosehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehrvghgrhgvshhsihhonhhssehlihhsthhsrdhlihhn
    uhigrdguvghvpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:q6AqZ5YA0OrE8FoTdKh5wJ0juiptQhQcNg5VKbJtM5raIYfpfyjEWg>
    <xmx:q6AqZwVwQr49VjsJmxTSdaecstGBTDJrNOswkF9pKT6Y3-Yfyf5hig>
    <xmx:q6AqZ3n0zYliajz3ocPusEPqKE5vbXCU7Qys34LD1SYebkZcQPNP1Q>
    <xmx:q6AqZ9dpyISGk_ymKrx0ARh0k1T6IR5Ca9nuHPCO3gIZkUEIJzwRBg>
    <xmx:rKAqZ1iTTVLOb-k3zGqFvY4iid7X5d0wbTFLzvt9teFTJbobjQbbr8Fn>
Feedback-ID: ib5844192:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9D75418A0068; Tue,  5 Nov 2024 17:48:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 05 Nov 2024 23:47:08 +0100
From: "Alf Marius" <post@alfmarius.net>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, "Andrii Batyiev" <batyiev@gmail.com>,
 "Kalle Valo" <kvalo@kernel.org>
Message-Id: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
Subject: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10 and 6.11.5
 (probably 6.11rc)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,
I recently installed Arch Linux on an old laptop (Fujitsu-Siemens AMILO Xi 2550) and noticed that:

- when booting Linux from the Arch ISO (kernel version 6.10.10) WIFI is working fine
- after installing Arch Linux from the ISO and booting (kernel version 6.11.5) WIFI was not working properly

By "not working properly" I mean: 
downloading small files or installing a few small packages was working ok, but when downloading larger files or installing larger packages with lots of dependencies, the connection would gradually slow down and eventually die.

I reported this on the Arch Linux forum (https://bbs.archlinux.org/viewtopic.php?pid=2206757)
and some helpful memeber suggested that this might be the commit that broke things:
https://github.com/torvalds/linux/commit/02b682d54598f61cbb7dbb14d98ec1801112b878

An Arch Linux packet manager (gromit) helped me debug this issue by building a couple of kernels that I tested.

- https://pkgbuild.com/\~gromit/linux-bisection-kernels/linux-mainline-6.12rc5-1-x86_64.pkg.tar.zst
- https://pkgbuild.com/\~gromit/linux-bisection-kernels/linux-mainline-6.12rc5-1.1-x86_64.pkg.tar.zst

The first one didn't work, but the second (in which he reverted the commit linked above) did fix my problem.
So, I guess this commit should be investigated by those in the know.
Thats why I also added Andrii and Kalle to CC as they are listed in the commit message.

My network controller: Intel corporation PRO/Wireless 4965 AG or AGN [Kedron] Network Connection (rev 61)
Kernel driver in use: iwl4965

This is my first kernel bug report, hope I did everything right :)
I'm ofc willing to help provide more info and debug locally here to help solve this issue.

Thanks and good night
Alf :)
-- 
"The generation of random numbers is too important to be left to chance."

