Return-Path: <stable+bounces-235951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK9GNl6l3GkEUgkAu9opvQ
	(envelope-from <stable+bounces-235951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:12:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6333E8ECA
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A50130459DD
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF83A3E91;
	Mon, 13 Apr 2026 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LPttxcex"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5963B37C92E;
	Mon, 13 Apr 2026 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067474; cv=none; b=UY16PAxNvJgTUdCfsgMdnlIv8S02cCABpNhgSOLW5JfAkU73d5bFv4fW3JRO6iLXkAGARtX/HafEmgVONN3kCQu5sT4kcvnoJbxYNwvzHCiSYqmy49lfHXr+GPWDqWbEMY1QGS0T8WlZO1hRngriFDyqycdVVkKpjmEl8LzHqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067474; c=relaxed/simple;
	bh=nRwmameaeIsZPQfij1qNyLreaRDR+ql4yfEH+VgvVs4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OU9FygtHBY/tuKDfof5VEujpAoW5spMxr+nhWRSjJHux/hU2UNX5QW4s37trMuyF2HCJ8t0F9Ru52G8eP+nYnYb4h8n2wgl9eHd1D3sSQK1HGUR89JEblNy6OaOPo4oqx62ceGdrXoztPGcqZ/pZLxv36cj3koD9tUeXa2JJgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LPttxcex; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BD4701A3261;
	Mon, 13 Apr 2026 08:04:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 923D65FFB9;
	Mon, 13 Apr 2026 08:04:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B4AF10450246;
	Mon, 13 Apr 2026 10:04:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776067470; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jeaWaNAvawAg39iZTdMC6jFeHce/2BRX0MTNxqAljDM=;
	b=LPttxcexn+oaDeFgkWoAO0WDpImIBkeUzYnlP/fWz8BA+vHb6j/2ugl//byfEYJb4JSIs6
	DgSkSeFCio+Cti3XrG+HJe3khQRopbUduuRplWxzmdPPAE+H1MbWu9nzTMBFUP5xWgZqBG
	PZIJz/H92OODJQSHecGxXb6WVxx9YwWLI3n/TEDOXqPiBOYBffbdddnavf8hifaDSsqzTv
	be2bIfqYmLHfVZrhjPnXRmX7kLRDAlArdDW3crTok2ine0xEyqZlfyKCm4+VPAkGkQQXuZ
	ecNoZ2Va04cH8idKk0uYWZdHN1b88546HTlutS+NzS9ZSvwwRt8rViRmxLsDbw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 10:04:27 +0200
Message-Id: <DHRVDETB559R.1J1MUGSZ0VVEX@bootlin.com>
Subject: Re: [PATCH v2] clk: eyeq: fix memory leak in eqc_auxdev_create()
 error path
Cc: <stable@vger.kernel.org>
To: "Guangshuo Li" <lgs201920130244@gmail.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 <linux-mips@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260412124247.2494971-1-lgs201920130244@gmail.com>
In-Reply-To: <20260412124247.2494971-1-lgs201920130244@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235951-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,mobileye.com,bootlin.com,baylibre.com,kernel.org,vger.kernel.org];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E6333E8ECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Guangshuo,

Subject is:

> Subject: [PATCH v2] clk: eyeq: fix memory leak in eqc_auxdev_create()
>          error path

I cannot find a public V1?
https://lore.kernel.org/lkml/?q=3Ds%3Aeyeq+f%3AGuangshuo

On Sun Apr 12, 2026 at 2:42 PM CEST, Guangshuo Li wrote:
> eqc_auxdev_create() allocates an auxiliary_device with kzalloc() before
> calling auxiliary_device_init().
>
> When auxiliary_device_init() returns an error, the function exits
> without freeing adev. Since the release callback is only expected to
> handle cleanup after successful initialization, adev should be freed
> explicitly in this path.
>
> Add the missing kfree(adev) before returning from the
> auxiliary_device_init() error path.
>
> Fixes: 25d904946a0b ("clk: eyeq: add driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

I have a guess this is LLM generated?
Are you missing the Assisted-by trailer?
https://docs.kernel.org/process/coding-assistants.html#attribution

The patch could be in theory useful.
In practice however, it's a different story.

 - Comit message says "Since the release callback is only expected to
   handle cleanup after successful initialization, adev should be freed
   explicitly in this path".

   Two things are wrong here:

   1. the driver cannot be removed so there is no "release
      callback" (guessing you mean driver remove?).

   2. this text seems to imply eqc_auxdev_create() makes probe fail,
      which it doesn't. It only generates a warning and keeps probing.

 - This driver cannot be built as module (will always be probed at boot)
   and cannot be removed. So the "leak" we are talking about is
   2 * sizeof(struct auxiliary_device)

   But in no sensible case it can occur. The platforms that use this
   driver probably cannot boot if our auxiliary drivers aren't present.
   So if eqc_auxdev_create() fails then the warning is here to be nice
   but you probably will fail booting afterwards.

   My guess is: you might succeed booting without the reset driver but
   if you fail the pinctrl one then you won't have a UART. Anyway in no
   world do you have a sensible EyeQ kernel config that leads to
   clk-eyeq probing but not its auxdevs.

 - If you fix this then there are other resources cleanup to "fix".

    - ioremap() in eqc_probe()
    - kzalloc of cells in eqc_probe()
    - probably others

   But, same as above, "fixing" those will only be useful in kernels
   that will panic in a few milliseconds.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


