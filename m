Return-Path: <stable+bounces-110111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B3AA18CC6
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D073A37B4
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D933192B66;
	Wed, 22 Jan 2025 07:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lkPm3qju";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hRSdj6XN"
X-Original-To: stable@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2433E4;
	Wed, 22 Jan 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737531080; cv=none; b=Aod2pYnhBITiX3tmZ7ygLXhqSh3Wq5B98vybkBwaM80cAFWcGKrxmuHvsAoDlMmP2ZB2Lzf9hdO0l2EkMHzfOzOvG/f/ukCf9eKY1Uw4At8Wm6o0tHskucgl8dFipS3LrDkyBcCAXqftuJOK0btgxeZDsWqxD2Nl+zVQCMFkwpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737531080; c=relaxed/simple;
	bh=7cUTDPJtm0n/ukluJZGsYh8eF9XjAPzV1BMpNumqfS0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Yqnbyeopptmw6BDy31L0kI2Y7HiMiX3/5ueqSPT35UwlX+Zky7R0pECdDkDTsNtI7c+ZuEe2/evWqoG8iZhsBckqWirJUdNpbB4vAp/LSsRrjr54XNqc+u9hCvx/lIfZSxsRNVrfbYIK/+Q3pqDud4fkW2NuhzL7si9sKJTXujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lkPm3qju; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hRSdj6XN; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CF7C13801DE;
	Wed, 22 Jan 2025 02:31:13 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 22 Jan 2025 02:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737531073;
	 x=1737617473; bh=ZDZLXUQ3Rhy88CKH1ZL7NXu2AcYKp3fYRM6FtffIWTU=; b=
	lkPm3qjuZjkXMxmsERuN2hsu7+HtEwpKnkj3+dqYn+Dc/HqIv1zEIrCjKNCrARV7
	oNk8TK3xxGYdIbYQj24vLDCYX0puIznlmcbp4lfDB8lyeT6QvCPkSE696XlKGYGi
	tDUi497u9R8iPhLmmUWBOR+vhN63opU57jGaqml7oU8y4r3EjpcRVhh2uyF73TJz
	Jj6R89CrLgO3cgzZ/WORWHDlfO+cFlN3yuNfoEwHCh1tALk3v/bcqVqFb98q4FI2
	GHO7HRtzFAt7aM1ESSAaXiEnH6pyL0k/+3t8Cx0Tq2EziMrAZ9KpCsEhYPwHZLcO
	3Dmu+VdMVx6ldscFkGsYgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737531073; x=
	1737617473; bh=ZDZLXUQ3Rhy88CKH1ZL7NXu2AcYKp3fYRM6FtffIWTU=; b=h
	RSdj6XNjf1gHPcL+det/fKR4L+1QI3T3cscc4cOgo8MTdGKAbghkTboUfzBh+oaU
	29Gz/saxBBZCdbfPUDc9NJXMT/0smOEiiTPzdKyYstD8Mc7AWHSZlql9RWIE1Aqf
	42w/3suvtFD9ic7Wd1UamgyT2a9qUVV79sECrcDGmGcDVuG78sZu04E+L4en1QC6
	NJaK7vGVrEZZrEbShUc6wt/B0WObFo//M1KMOQd6ghhR8rtEZ0rZke7ifmKd1SXX
	4L5HDubEEAjICEW6DmVD6x0N0sFJYjuXuxcNiDRqhEl1SHRPvxwPAsNWVAiKthFm
	nQs0s833418YnWiz/ApYg==
X-ME-Sender: <xms:wJ6QZyy2xh7WA60KPSxbfyku_q7zaTVK2_wTT82s_Wa5R2sH7VvntQ>
    <xme:wJ6QZ-Q0zQKvpcIueza_N84ijGguIm3DEfLGucqk-gIoR5GW9cvPpLmEYEtJzc8cx
    3fcGkUFMlOVUG_EZKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpedvhfdvkeeuudevfffftefgvdevfedvleehvddv
    geejvdefhedtgeegveehfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    hedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhloh
    hfthdrnhgvthdprhgtphhtthhopehgohhrtghunhhovhesghhmrghilhdrtghomhdprhgt
    phhtthhopehrihgthhgrrhgutghotghhrhgrnhesghhmrghilhdrtghomhdprhgtphhtth
    hopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfhhrvgguvghr
    ihgtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehlihhnuhhtrhhonhhigidruggvpdhr
    tghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheprghnug
    hrvgifodhnvghtuggvvheslhhunhhnrdgthh
X-ME-Proxy: <xmx:wJ6QZ0W1dAChiLRFDk1Cu2FH50mABZkdLP4G_DmoeRft5QdPgC95RQ>
    <xmx:wJ6QZ4iYDENA3VjqnR10xK_dYZrwJcUmgO29ezR9VjBr0p9YcLfyBw>
    <xmx:wJ6QZ0DmCqeqMU1Wt7R6p-haPo01RC14w-F9EP9AMxYTV9pQpMdU3w>
    <xmx:wJ6QZ5IlaC5CWbfIW2YURoIOw_cDejk-G586zEU7F0E2QtjzgnQwUw>
    <xmx:wZ6QZ8Zmt-TEtXDG_RFVi6LK82f2zR0BD3TT5ow-uZVnDmbBGnizGjD8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 300B22220072; Wed, 22 Jan 2025 02:31:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 22 Jan 2025 08:30:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "Richard Cochran" <richardcochran@gmail.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "John Stultz" <johnstul@us.ibm.com>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Cyrill Gorcunov" <gorcunov@gmail.com>, stable@vger.kernel.org
Message-Id: <603100b4-3895-4b7c-a70e-f207dd961550@app.fastmail.com>
In-Reply-To: 
 <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
References: 
 <20250121-posix-clock-compat_ioctl-v1-1-c70d5433a825@weissschuh.net>
Subject: Re: [PATCH] posix-clock: Explicitly handle compat ioctls
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025, at 23:41, Thomas Wei=C3=9Fschuh wrote:
> Pointer arguments passed to ioctls need to pass through compat_ptr() to
> work correctly on s390; as explained in Documentation/driver-api/ioctl=
.rst.
> Plumb the compat_ioctl callback through 'struct posix_clock_operations'
> and handle the different ioctls cmds in the new ptp_compat_ioctl().
>
> Using compat_ptr_ioctl is not possible.
> For the commands PTP_ENABLE_PPS/PTP_ENABLE_PPS2 on s390
> it would corrupt the argument 0x80000000, aka BIT(31) to zero.
>
> Fixes: 0606f422b453 ("posix clocks: Introduce dynamic clocks")
> Fixes: d94ba80ebbea ("ptp: Added a brand new class driver for ptp cloc=
ks.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

This looks correct to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> +#ifdef CONFIG_COMPAT
> +long ptp_compat_ioctl(struct posix_clock_context *pccontext, unsigned=20
> int cmd,
> +		      unsigned long arg)
> +{
> +	switch (cmd) {
> +	case PTP_ENABLE_PPS:
> +	case PTP_ENABLE_PPS2:
> +		/* These take in scalar arg, do not convert */
> +		break;

I was confused a bit here because the PTP_ENABLE_PPS and
PTP_ENABLE_PPS2 definitions use _IOW(..., int), suggesting
that the argument is passed through a pointer, when the code
uses the 'arg' as a integer instead. Not your fault of course
but it might help to explain this in the comment.

     Arnd

