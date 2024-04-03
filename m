Return-Path: <stable+bounces-35741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B0897562
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 18:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4073A1C25D05
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97996147C6C;
	Wed,  3 Apr 2024 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="WGjU5H9S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EjwoRexx"
X-Original-To: stable@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393901B7F4;
	Wed,  3 Apr 2024 16:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712162416; cv=none; b=qglSHO+XDtLECPUjKIIfRp0yIC4DqcBiMoVk8gJwmmXMkkjNbSmLS9mvXU2/CCkrAqfsDV3pcCQ4Q1exLMQGp8aTHFoDwqBGz6n/X+qDaJFLVqAMeYZfuQbOPfJkAd7+koNiA8/vtw1kGl5YxB4WbzwPYrhuEZd0dcFQC9KLlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712162416; c=relaxed/simple;
	bh=dTIthPAnIZzCGrQwhzH0M3Kl/pDj/tBBQTx/+Azf2ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJQHvNjx3yWunAgse4HjoeYxwGfeJAWUaygyuGNzfX3JgLPIBIBOHdznZ4LTTFYPRpgnsbOfGNN8vbHYv2iB40Bcywh2/iuVVi+26B7RThsLtXh4GqNhuaQE2gJ4QZpoQuhjdbDD0ZHLC36p07QxnHNsaRLa8fug8wgURrJ9f78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=WGjU5H9S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EjwoRexx; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 23DB81380150;
	Wed,  3 Apr 2024 12:40:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 03 Apr 2024 12:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712162413; x=1712248813; bh=8ZFtARQa2q
	P/2W1HJo7i0y1PHdqP0ZUupT7RfXWRXOY=; b=WGjU5H9S4EcIyJrZnkkO4nMzqA
	6T0T4CKtqBEVA1UppJ2a4JTiA7wXmYf2FUyYKiH/Wu1hKn8op/e4cfxh6d5q6KTH
	OZvz/feEOhNu9idtugOaykMK+rDGV5ayVX5kdCrBW+Cj0YOmkHw2ZAnfplIndhzv
	uH/Rc6L0Z5qtyG9UW5CTM69BXnuA/Ndp+IzqXFwyRxtK+5JE49EB9La2A5bx+Z81
	GfA37twkP7D0EviQ3KxcSF2uOP7Fjv+9oSpotRjegdb9gkM3Xcz+DxzyhpgaSCWS
	0O7miPTu7S2TGplLgTzXfRPr4/WuNjLhx7mqN2i84zSPojpTZ4hRc3zAz0Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712162413; x=1712248813; bh=8ZFtARQa2qP/2W1HJo7i0y1PHdqP
	0ZUupT7RfXWRXOY=; b=EjwoRexxCwl2hzF7yNHf0gc84mCq1lg6jvk/j5aWMRVE
	RCW9bLI685MNCHtQAunDsBvgv0jyylHy151T8sWmYqQShW22RYtb7hB0eTv51coB
	FQ4AoRW0KW5AkpeiGxxBlfNYf+Af1kbEDuAUXNUvzv7LAOutT1Wo1JlG+2xNZ+hH
	HH2L0ekoPGFtQ+iN0fyouqJECXRjASfFCPYsnsAwbYrK8rNtJl6+AMqV3fqWmzbC
	y8jtHqfvd8+g9zZ8XVQ16x7VX8fcT+m5DhWZDXMrWQA+QAuJZRbguCUO5kU9wi37
	T/wnnB18PAkmc+pvUnbblHUwkxmug29NgIM4XDOpUg==
X-ME-Sender: <xms:bIYNZiWeaAzeVHwEo3OuOPIPwUUJWoEcWf-0qidCuZZpeFBAf0UvVw>
    <xme:bIYNZumvsm6Ib-OILDGu0spHXfh2UeIq3zrO_dVcQV_h4eDlsufBQkPl2abXv4y_n
    Fz42OjGfV7YrQ>
X-ME-Received: <xmr:bIYNZmaUTNxWMshpGhrTD9fZHdQqOIqBUPebZoER__A57nRyF9bvkcwf5vu5eb8onf2cfjqmE8naCG1YSORJKhZtxezmifcx6vc44A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefiedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:bIYNZpU_2iBlFgCRBT6-CwaAwJLvUDM-h0ijBChkatfLnNmwwFK9YQ>
    <xmx:bIYNZsm0rCHQNCnTVxfg7zqo23kj7G75zjKo1G-oxhPuMHrEX3Kumg>
    <xmx:bIYNZucrKPm5_j6LcvoXNCthirXMf8Fw4IRg7rmsU4G7zpZvR-4Ygg>
    <xmx:bIYNZuHMHWsrzEsRoQRYa7IfH5BWrFwXAUXbe_YErtFqZl-WyGSEqA>
    <xmx:bYYNZgmarBeF0ec989afBy0HkG6ODe1fPR3bsQWhwl8N8u-qyFBdMFas>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 12:40:12 -0400 (EDT)
Date: Wed, 3 Apr 2024 18:40:10 +0200
From: Greg KH <greg@kroah.com>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, yangxingui@huawei.com,
	John Garry <john.g.garry@oracle.com>,
	Jason Yan <yanaijie@huawei.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: Patch "scsi: libsas: Fix disk not being scanned in after being
 removed" has been added to the 5.15-stable tree
Message-ID: <2024040358-coleslaw-trouble-6009@gregkh>
References: <20240403160823.273053-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403160823.273053-1-sashal@kernel.org>

On Wed, Apr 03, 2024 at 12:08:23PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     scsi: libsas: Fix disk not being scanned in after being removed
> 
> to the 5.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      scsi-libsas-fix-disk-not-being-scanned-in-after-bein.patch
> and it can be found in the queue-5.15 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Nope, breaks the build, I'll go drop this, sorry.

greg k-h

