Return-Path: <stable+bounces-52380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A7990ADEB
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 14:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD85F1F2277A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41142195806;
	Mon, 17 Jun 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="fXAxbDmH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JDZyf9zI"
X-Original-To: stable@vger.kernel.org
Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD43190052
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718627300; cv=none; b=TthLFU5kEh9fkKk1SB5X7QokuOm2Irs20FQkbS2rb/AUXeGNAY7O1lJwUqfwVKEv0NXvZMTr56LP7UyFn2dSdVez/dqdi462Z3SmfnXGYUxXlQbUEU59X17tAGqyiugAUkllK7rhylWVfe1rLaEKKMExLFhW5VIsNYJwJbhbRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718627300; c=relaxed/simple;
	bh=0ShDpU+dWVmLkVhJEvq3QSRLNWtie9HFsvSRkpafCwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2L5GvJT1Rw1cZpiuRKivHBMQvuyvZhvW228NX5JR4W7LVC1TsRWz4TN8CLu4qOIXkpKmVFP8Cf9iBiS5k8IeBz8V0S74kWK7HG0+MbBS6mtEG+dwm1u96a/w7OjG+D7dzojjzUhcywCfvWLaMPYUXiwNf+b7AC5mPyc2aEFpLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=fXAxbDmH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JDZyf9zI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id CBB991380293;
	Mon, 17 Jun 2024 08:28:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 17 Jun 2024 08:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718627297; x=1718713697; bh=UZ5o3jqx9C
	riZhvR5DdY+AJpqF7Ix3G5yRFHi2wSlnI=; b=fXAxbDmH+8Ptt6hj5HTbwoxXTG
	47zANe9drycRjwo5QfBSBebhxahzfmBZInXBAJ73FBvLr/yzrdxZdWeuZOLVSiu+
	FplqWFRBZq+OwA4ml/T3oloOkq6Rwn2DzRAUBol6kG86l1tlm0nRz+1WEG5g51pj
	OYJwHHm5E2mEeO19K3E9qkngmAOi5hkszmJIJ3VhVq+75AW2NInlRC/IUB9J0Br6
	l4EDRHr9DnW/BHXDwEo0zrI3fgEU0IGJf/3ZgEcX/qCJGR3sxGifpobQpngUoQXa
	wqNleOj/hvqJ2Ht2yO3w7Ufr4al82pWorFGD5I7hvFm8zyLtnRJQ0GgVqtjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718627297; x=1718713697; bh=UZ5o3jqx9CriZhvR5DdY+AJpqF7I
	x3G5yRFHi2wSlnI=; b=JDZyf9zI6PsCMDsJN4mfa4A8WH9qH1fJ0dtt7UWe9FAm
	/utRTXJQoGD+5ox+4oL4noFSaFU5BcFDXTHFeWfr2k2g5hHduDYRSvWN2MGA+X4i
	WRwJG9QDO3yNK0A82538O6xETZLPvDaIB/R+oR6dxFjAAwE7b2DfmYfycxUj2Hfx
	PLDA4zprmjYOAuUryuH0eYuoBY8thVVUbGuwnYsRRGJHg/pQoqi4Q+120fPyoPzz
	/ycqzkNRinu1/xFkD90rKlzuSc+wdi8Z+/rw4uBPEIdL3FTGdSsDTHHIk+zd7QDJ
	lpmQQwniwpLuq46AYwH04o0aa8kS/DVR5w3qxJRIWg==
X-ME-Sender: <xms:4StwZrpRueeAjuIIMisbDkDqcc5g7X1hEFv6fdi5YNSTHG02J4eDjw>
    <xme:4StwZloEwxTR_kfZlFPMKGDOra5wK9dsJRHKtJcBdiFS-UuVFuBB3YI2LKQP6cQ0c
    c8vvOvXyyHXLg>
X-ME-Received: <xmr:4StwZoMOShPllUDYHfGW13Vo8hvAKXr2BKqApX9Hb92efkr4_u3ai7dfRfsdRjB4x4BbOs_SKXiTQ7OLQiVruMvrThQsdHR4N-BjPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhm
    qeenucggtffrrghtthgvrhhnpeehgedvvedvleejuefgtdduudfhkeeltdeihfevjeekje
    euhfdtueefhffgheekteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:4StwZu5LOf8qaAEyFQJJ6uT8EwPU9byioEcibyDepwJWYqhRVwNNWg>
    <xmx:4StwZq7sSMVq7gD-hwxSaI9iU-bGDg0fQQqEnTvnx1Y07etB_A-PwQ>
    <xmx:4StwZmi2_xlvxCtltmUqgoxiisgNjdzJFb34AnUPnxYwe3eCvdB26g>
    <xmx:4StwZs6rP5p3iz_KpWJ3CPb1JUgOqxGCaC1bHe5e3oV8UUKdWxtJTw>
    <xmx:4StwZnuZZrz5BSF9aRYYNR-4JjYaK-F1kpYw5XZnwq24lPEkcMqQhejC>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jun 2024 08:28:17 -0400 (EDT)
Date: Mon, 17 Jun 2024 14:28:14 +0200
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v5.10] powerpc/uaccess: Fix build errors seen with GCC
 13/14
Message-ID: <2024061706-dingy-constant-fd27@gregkh>
References: <20240614112714.3482739-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614112714.3482739-1-mpe@ellerman.id.au>

On Fri, Jun 14, 2024 at 09:27:14PM +1000, Michael Ellerman wrote:
> commit 2d43cc701b96f910f50915ac4c2a0cae5deb734c upstream.
> 
> Building ppc64le_defconfig with GCC 14 fails with assembler errors:
> 

All backports now queued up,t hanks!

greg k-h

