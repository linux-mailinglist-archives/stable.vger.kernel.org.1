Return-Path: <stable+bounces-204442-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F2CCEE0DC
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 10:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75AB63007600
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 09:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482412D6E6F;
	Fri,  2 Jan 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aDSBt+A7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HgncAOTv"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95AC1F7580;
	Fri,  2 Jan 2026 09:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767345899; cv=none; b=TkkTLpRWXQjSAaw6Ck9BzNxDM/mF4nPEQT8z/KABfnEbTTDgm+JHwY8aXG+rTBMUX/oXe4vi5F06v/deqzt8b33q4zUTGhcb0hVaZmae9PuvZsLk3Jw6+QZKfnzF7t7jRyqDFlQIA4F71V+rFPE0DD/ONp0KiGFNAZILc/UVN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767345899; c=relaxed/simple;
	bh=xboeX7iqp3yKPiHunSosJbagSL4sCsNu5Hh7gtei0fw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s+mpJZ5mQYqaxii5ZUqXy3K9zVeDeitIZ9S6nNtzQy86IErfbpCMUXV9lqeeU/iX/1f7aqrm1RffPwgQYVCV3aaTKqoQFubceLSC8H6U53zF5uFNBJ1LjyneCBvaLHdZxuGzKtScep5l7mLNcW+L2nPK7UnhPmsnzUvdkxQqPJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=aDSBt+A7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HgncAOTv; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA5F614000AD;
	Fri,  2 Jan 2026 04:24:54 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 02 Jan 2026 04:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767345894;
	 x=1767432294; bh=xboeX7iqp3yKPiHunSosJbagSL4sCsNu5Hh7gtei0fw=; b=
	aDSBt+A79WKXvc4f0lRnxJqT6zEOJQGqJKzz3e0zmZJkSJ+I98bstXT497fL+tFB
	64XDyFgpEIVa8NioYlhI0HrziMsCSN0iU+XXmsn0KAPjGsTsVCt2Dcg3r31poSVc
	W5XnidRgQUtXRZygFuv+TWGQqtFbnYWrrWCs3b9x2Be0+sJLM4w+w8iA1iBuZEdf
	+8EiLJf34Tc7PHog57vADOP8pL+HoRmCkKZ8ikR8NuW/hL4OC5gN+kCYdEn/2NJS
	S/u5ahvNqCPn/ne3n9p3RfSGFCv4L3HnVMI1//ygbE7YCKZFZ1mjcP9Orw66q9MZ
	zkq4O2KDvRG470mIqZNxfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767345894; x=
	1767432294; bh=xboeX7iqp3yKPiHunSosJbagSL4sCsNu5Hh7gtei0fw=; b=H
	gncAOTv5hXasZnfO+DefsoIKG6IcQscodgz1nK3zYRriD4dbYPJUW9OMXhU1MCDo
	ev/NmqZrrb/w7grftiyv2y4H/3cK5kX4RY6NXblDcg8uZtuYjq5DGkC/gzQor3ee
	Gt79KRxlj3XdVtxadlFGLH8WHdsrtBScfBP6FGVZ8D5eUf/xVvadrka7RVZNDQr4
	wVUN1JCjseOCXF1MfpQgr9EtYXsjHdGDaR054RIJfG3BuamBU74W0zrVnS4Bus4n
	eyXYjfF1ZKfkwAaRpbG5A/OF0I31M8oxaE8fVjS0LAmENKOJQ20PQTTLxAcPWHwl
	Z+Mc/XjDX2VkLjITzVJIA==
X-ME-Sender: <xms:5Y5XaYihxTgTDU1PZ-z290UhDEZaTS5s2suS9_yef3GyND0SJtVilQ>
    <xme:5Y5Xab3KNHDn0jKFStcNpwGM4MaHDVjJ-5rVatUc-KGgVgkbrir8d9rx6DpU6uu4k
    Ls1pkf0Ug0-u35alpN3Lqs6-LPgYnPkGiJxudhJuPJmCJZkGQpBscw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekkeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertd
    ertdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhn
    uggsrdguvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhe
    dvvdegjedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtoh
    epkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhn
    uhigrdhorhhgrdhukhdprhgtphhtthhopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuh
    igrdhorhhgrdhukhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhg
    pdhrtghpthhtohepthhhohhmrghsrdifvghishhsshgthhhuhheslhhinhhuthhrohhnih
    igrdguvgdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:5Y5XaRzIjTbUNLrxGr0sqwE_YbxvX-6eNffzwqOge8lpG-o2ae4jTQ>
    <xmx:5Y5XaRsSmW-Q-K1mA_xlGV_8lFLPpH2Iwio-p9VGk-n03dH_YACR0w>
    <xmx:5Y5XacDzW-6O6VxqoF5s4oMP8TDbdqXmRiRW-vjIMMRDuU49G0B1Iw>
    <xmx:5Y5XabEv8cZh6nZOD0UjfmY1X4grWK9bHRazqxmFbV3UnwBikPb-WQ>
    <xmx:5o5XacrIRGAev8YYYemAQzEnmYkiOpUc9zw5f3ALgJqjIDJ-NP0kA6ex>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C5156700065; Fri,  2 Jan 2026 04:24:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AtSnlUpPuEWk
Date: Fri, 02 Jan 2026 10:24:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Russell King" <linux@armlinux.org.uk>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Matthew Wilcox" <willy@infradead.org>
Cc: "Russell King" <rmk+kernel@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Message-Id: <bfd7776e-574a-4828-99a2-f70a3b9015e6@app.fastmail.com>
In-Reply-To: <20260102-armeb-memset64-v1-1-9aa15fb8e820@linutronix.de>
References: <20260102-armeb-memset64-v1-1-9aa15fb8e820@linutronix.de>
Subject: Re: [PATCH] ARM: fix memset64() on big-endian
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 2, 2026, at 08:15, Thomas Wei=C3=9Fschuh wrote:
> On big-endian systems the 32-bit low and high halves need to be swappe=
d,
> for the underlying assembly implemenation to work correctly.
>
> Fixes: fd1d362600e2 ("ARM: implement memset32 & memset64")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
> Found by the string_test_memset64 KUnit test.

Good catch! I guess that likely means you are the first one to
run kunit test on armbe since the tests got added. Did you find
any other differences between BE and LE kernels running kunit?

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

