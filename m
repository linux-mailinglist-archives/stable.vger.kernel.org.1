Return-Path: <stable+bounces-46564-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19728D0852
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 18:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7CA5B31100
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D87169AE8;
	Mon, 27 May 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="j9SWpHo0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o2Hw3g8U"
X-Original-To: stable@vger.kernel.org
Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA7155C91;
	Mon, 27 May 2024 16:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825655; cv=none; b=bI8JJ/LrYCqEillvDiKOi5Z+gWMN2fqHVth6bhQH2VuCv+m6iYZ3XzZJ8wyAjNvpD4yin/fPddoZArirZWgV0kHwXWnjMP14wB3XbYbCHBFihHRE2lmBUwB2wUiqnS7hK4yrTrAHp6QFBDc8ieLYU3xKanV6LqlODa3oiZivj4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825655; c=relaxed/simple;
	bh=eu9ERRY2/2tzbNM7/sRA/5PblbcpQRZ7jEKvETm7HZ8=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=G5UY9Iwh6e+/cx6XiC1FdwxekhDSMZIXH81fQkCx61iPcouR2qqnZn0EeuCwsL2PZrFotZUn21QosagWvB9aV12ahMkhdM5REu+/kba9flWTpdeEdW+W/TbwbgM+1oMusfULdBeo9jVLiJxuy4rHDDRYk82z0fTAaPvPOxPZ1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=j9SWpHo0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o2Hw3g8U; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id D87B61800114;
	Mon, 27 May 2024 12:00:51 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute1.internal (MEProxy); Mon, 27 May 2024 12:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1716825651; x=1716912051; bh=JR/OInhF2POmXtVueCyiCaZ7btN5anbT
	nKy85NzXzCk=; b=j9SWpHo0SpO6FNmBkyvG5sFOOUyDv1WMR2oQv2fxilgGy2Cz
	4f2tYinh11rf1j9bOmjX3pdmOboFrKCih6tbvrq2nx8TREF8IjTYxCvLHg0i7fCL
	neay14nDKND8yud/+lr+gNVjXlce+LeLzmvuk1HjVTat/rb0WMfS4AUSiQp4JRB3
	0ZGLYRMxvwnq7a02yuCZf4+2Xwl0b/8610IU5RboRdwSwNsLeXju7jiUKjyaQzTa
	1ZEI9dGgQGd5breYjYSKzQ0ieeY+uhusK3sf0n4b5BqyZeR3L/OQfQHjudkBM0tw
	FtRm5HTCYcadMLMnxvacMsSHVXyK90f/8CwgOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1716825651; x=
	1716912051; bh=JR/OInhF2POmXtVueCyiCaZ7btN5anbTnKy85NzXzCk=; b=o
	2Hw3g8UFyT1ekXk3sYpkq0UJ38uCCtoe2QUqKq+b/BjKv/S/YEdtZqAMSmnfMcqu
	V9/R3YUapZebOpEdQhwCC0kQTNVpJxksWt7oGyKBoiEPZx3bPR0baZR598HD0c0G
	u2ai5oCETQZNJp4Bko6w7nGNslRgJ0P5mJ06YRQHqunEP5Z3Y9O2UOMG7WNucwE8
	26IJz/d4s/lHSNcB3p5UvLoo0SAa965+C2Dqt9Nm84Z5U5YJ7+HoI0C3Ku4EOxU/
	GMfMYwwvacfEE6BV12j5dUGQ/xwf2ooyxdrOn/XGZW5GeveB8xmEf+phXyxOOBOu
	12r7VP1GO3ImTvdDzChUg==
X-ME-Sender: <xms:Ma5UZmQuy-i7mX6L06GVoRd2VLkTKPolKUU_x3OPFiWYcxr3Bb0jhQ>
    <xme:Ma5UZry0Vm6vxZne454ZX-BC2ZBU8gfOzfRMU2Y_gto4eCJCP1OFCORWJZpOEnkrc
    1bjBS1k4hCO2FYOFGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpeevhedthffgffelhedujefgueduudeutdefleevvdetudelhfeihfdv
    ffelteeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:Ma5UZj00_H1qR9w4vNWL9M_6pIXmLsII72HV6qQbzbYRGzhS9hh2uQ>
    <xmx:Ma5UZiB4cI4yxcQowNiIp_nPK9Ce4JOh7_qmaTNC4sn1-kaZcMRJxw>
    <xmx:Ma5UZvipk2uz2ScAWr7uJfyrZWyfsnnLzj16Ckdnqp_EZr0QM7YbFA>
    <xmx:Ma5UZurKGro4gjMlGxRsfZGiZCRm5tPQq5Z9RNQKxorsa-_K4h9Iyg>
    <xmx:M65UZuPgE5e-z5REWRseR6dWHAIVjDn9O4Ue5F5UMNbZiiMJVTyEPJMe>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 68666A60078; Mon, 27 May 2024 12:00:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <adedfb49-a66c-4e8c-ac4f-bd137c20ec7a@app.fastmail.com>
In-Reply-To: <20240527132552.14119-1-ilpo.jarvinen@linux.intel.com>
References: <20240527132552.14119-1-ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 May 2024 18:00:48 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: hci_bcm4377: Convert PCIBIOS_* return codes to
 errnos
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,


On Mon, May 27, 2024, at 15:25, Ilpo J=C3=A4rvinen wrote:
> bcm4377_init_cfg() uses pci_{read,write}_config_dword() that return
> PCIBIOS_* codes. The return codes are returned into the calling
> bcm4377_probe() which directly returns the error which is of incorrect
> type (a probe should return normal errnos).

Good catch!

>
> Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
> errno before returning it from bcm4377_init_cfg. This conversion is the
> easiest by adding a label next to return and doing the conversion there
> once rather than adding pcibios_err_to_errno() into every single return
> statement.

Given that bcm4377_init_cfg is only called at one place from bcm4377_pro=
be
we could also just do something like

	ret =3D bcm4377_init_cfg(bcm4377);
	if (ret)
		return pcibios_err_to_errno(ret);

there, but either way is fine with me.


Best,


Sven


