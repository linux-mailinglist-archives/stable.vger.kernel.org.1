Return-Path: <stable+bounces-212707-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLOMHJSWemku8QEAu9opvQ
	(envelope-from <stable+bounces-212707-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 00:07:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E83A9D5C
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 00:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06C563014122
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 23:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172B52FFDD8;
	Wed, 28 Jan 2026 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="aCpZZ719";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RWmNXUQa"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACAA2BEFE5;
	Wed, 28 Jan 2026 23:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769641616; cv=none; b=ufn/uYU2SyOygKfV7jQ4cFJ2RaG3WnZpe8YZIl1lD/aaXd6tuWg/kMs03vpEY/eo28+b9b+KPIjB06yQKYSDzgHv0qaNL1dN37xzwcL/gCPTKrlCdIDcx3IIDECXY23R2hSxF3lmGTH7IkMDxJ8DzG2K9b32WD1BCxS4ndCkuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769641616; c=relaxed/simple;
	bh=c4LnXvur3QyML02H0Sb9jnPh9hQ/XeaeU48cHfoLIJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahbsSqHXoDHKabr80sImvGuiUapQERJLslIBJ85P4svdIbbLAQhMnRLahrJ43jcjKmaUhM41FdQwHJIlHfoQ+rcqROlXW/COztE117oMXsNO1AnJA0EcS9F3o+aqULmG3NqxXq68dout7vyDySPuBDc9ceRPMiSkz1WwFUyiSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=aCpZZ719; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RWmNXUQa; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C2991D0008F;
	Wed, 28 Jan 2026 18:06:53 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 28 Jan 2026 18:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1769641613; x=
	1769728013; bh=BARlwKtVzPK1d9frwpszb3CDTNlJmznk2d23dUtnIeM=; b=a
	CpZZ719txoBnwDm0ihtcQR/jJQ/T4PF2TIVvuL9ozth6YLaJhbYYjq2P+dZWt6Ko
	mvYOcDlj0HCSGkN4lLNmDMqGlObAvjx0/uTc3EkuR4szDTGF6u+h8lG9KV2J9A5/
	S+VkAbkHoMyFpBsmPvU8OlyzkGuWzGiQS8cQgP27dHNeVz//Y5bABidTKWUpKEeF
	hoKZy++BLDI2TwBhb8BbXpczzXVdvn+wa3BLlf0bbCbRIQoPLYU9gfBEaA7vwyrB
	8iGsFWc24FPGM+N3TrETE/eld1fuVP3N7ySj/nDrLPPwZJ0TxndKzGwSVY4hFDqp
	AMD43O4FsCUEViWnCiSpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769641613; x=1769728013; bh=BARlwKtVzPK1d9frwpszb3CDTNlJmznk2d2
	3dUtnIeM=; b=RWmNXUQaIaTZeG0JHI1SeyPMfeETquCI4GuAhc93jpglGMQ9sMt
	TvSqrvn1BWFy4/LF10HeASWLFB+JMJY09Kkb3jOqSDBxMKxAr+/0SvEgs0lsIOEY
	IzqLa78r3wAlHbP9ciRNBdpkJbfnJ3JcueOqB/pway3DzIB0ciSsLrIKcG1QUo42
	peD/tm+fLWeohiCRIwElTT3/3ETVpepHTqfytFkPJjLP339jrDil79hTI3fNdN0l
	YkZrQhBcbBt5WhJpZ1RjEUExGVtdhm96KvkML1Kq2t9IjXDqMcDicjcoWZ9nth0W
	PUjCIOpT7v3KL6ExUbvi6P/NzL2thVNAVqQ==
X-ME-Sender: <xms:jJZ6aVzhKS2wPq3LC2iP_8mJjqASf6HpGP1GzMpSshAX7qE_KRxNuA>
    <xme:jJZ6aQvqs7J4TtOawlha76lQvEx_VX9qMqfNZSCIo5I7kJaIf0mWlAYWeuMbeJbgs
    dvOnHYEPdE6SBdZvaPLL1rmAiTIixgPbgfkL6FAk1ICeMpQH8OrmQ>
X-ME-Received: <xmr:jJZ6aS2c746RrKIUHv764KN9pq_LGxHxcH_kg6WFaBvkeyPLq1Bko0EF0teYu4KnNCqg9cpuOJNM7Cv-OIHqpDMm35dnx7mMkL8a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieegheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhh
    ihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
    eqnecuggftrfgrthhtvghrnhepudehgeeuveetuedvkeekvdfgffelieeivdelhfettedt
    veettefgffegjeefleeknecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhi
    sehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvghlsehlihhsthhsrdhs
    ohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheprghnughrvggrshhpheeisehouh
    htlhhoohhkrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:jJZ6ab_T_jxrh2i-7uxWoak46ZsrcEC4PVQxsOjzAVGgU86QeYpEkw>
    <xmx:jJZ6aTNV5GPJ9epF9Q8zOyg_JB6QxoQjpHOK2cftFvNbhKwZ3GxOYQ>
    <xmx:jJZ6afdCaffGtU6gW-dlzJ62f-Jn6ioR8p6yDVOLQ-QyYi8k0_z0LQ>
    <xmx:jJZ6aSUqxQwQyO0crPi1ruiBzMRtpBES4QapaLrmxCL_kVGlR_I8Vg>
    <xmx:jZZ6aevJjcKUNKTtCQ3rQSnCQJOujnkw23gbrtTGx6CfgrOTYhFYqhM->
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Jan 2026 18:06:51 -0500 (EST)
Date: Thu, 29 Jan 2026 08:06:49 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: Andreas Persson <andreasp56@outlook.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] firewire: core: fix race condition against transaction
 list
Message-ID: <20260128230649.GA68719@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	Andreas Persson <andreasp56@outlook.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260127223413.22265-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127223413.22265-1-o-takashi@sakamocchi.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sakamocchi.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sakamocchi.jp:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[outlook.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-212707-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[sakamocchi.jp:+,messagingengine.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o-takashi@sakamocchi.jp,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B7E83A9D5C
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 07:34:13AM +0900, Takashi Sakamoto wrote:
> The list of transaction is enumerated without acquiring card lock when
> processing AR response event. This causes a race condition bug when
> processing AT request completion event concurrently.
> 
> This commit fixes the bug by put timer start for split transaction
> expiration into the scope of lock. The value of jiffies in card structure
> is referred before acquiring the lock.
> 
> Cc: stable@vger.kernel.org # v6.18
> Fixes: b5725cfa4120 ("firewire: core: use spin lock specific to timer for split transaction")
> Reported-by: Andreas Persson <andreasp56@outlook.com>
> Closes: https://github.com/alsa-project/snd-firewire-ctl-services/issues/209
> Tested-by: Andreas Persson <andreasp56@outlook.com>
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-transaction.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)

Applied to for-linus branch. I'll send it to mainline in this weekend in
time for v6.19-rc8 release.


Regards

Takashi Sakamoto

