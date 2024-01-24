Return-Path: <stable+bounces-15656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E483AB2A
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF65CB23360
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E57477F22;
	Wed, 24 Jan 2024 13:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="LvSf3Roc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k67KqZny"
X-Original-To: stable@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC7F8F72
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 13:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706104244; cv=none; b=gVJasB4cHK0nUMxu27StH0fyZiM87M5ciS3D0noIGJkE2mBfjMMse7sWDkQwtE4RNheVcqozQQJoFRKiiMK6t3RTUSAjKKBuuu0vFVT6+z1jRD0TuM0RIyqXw+DbmiupYbR61ogLT6QRTtQXps8AXhRbajA+p8pgh0PhwlcxAK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706104244; c=relaxed/simple;
	bh=WWOr42HUJFVpGitdwC+c5hweoSeLOebdW5dDIq8nBhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbZ67xbRh2W8CTpTIZZbRNI99jDfgvOnQju0E6rgL44aQT8Q3eIff/59KL4hpeIWWuLyKqG4dHJKfZpy7Z3vk9vhrGQPne3y7J22t2Lv1lvsbJjPHF/ZtRXNtTwu43ss8PY/DEWQxfjEB1MqNmICRyCaJM4pFFy6AwWSWcfMTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=LvSf3Roc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k67KqZny; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id E08675C0108;
	Wed, 24 Jan 2024 08:50:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Jan 2024 08:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706104241; x=1706190641; bh=SnjodOxOpa
	oV0YLeIgILlE7GrANxq2sZbRCPm9RYo6c=; b=LvSf3RocCQls8AkrG3Geyf28gm
	cdP+e2qe/FQn1EGq9tJpucyUYTokMwVzwTY03ikfrIl60cff85fp69dulq6+gQy/
	Avl+WzcUQ6tC9VIJ6YGTezHqVOCypi8Wc5++MS6emiSSRbDDzWjzE4Dli039sTPD
	DfJ5akHo1A+SASPzckQK7REA8PN2cEJkPtATTQewpX2FeMfe0h6vMpTMK6VBQZ8i
	5qmCzknU08jow09y6yYxQYe973yJFmNZ27LX8ztwDLwlt51vvLgA8QXhQvwlpAe3
	wHAfPVhH0oB2zTaiN/uY4M3ozlmDrPZs1f6qDPUquLVirxwc+ISo2SC3RUPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706104241; x=1706190641; bh=SnjodOxOpaoV0YLeIgILlE7GrANx
	q2sZbRCPm9RYo6c=; b=k67KqZnyZ2Cx2+639P0k3wY+smXZqaoc4Ko6c6zK0Kdc
	15c0d1k9U6zFIlSH6DIB/85LLCjp2IqWp2614p2uUoVPFnMgxBldXZ48xny2Nw5Z
	85FDtcJ9M2nHj1Ji6JNZlNnIOAIAfS2Emk/U2YIMgRBredcJ9Thn8so58QanP3WD
	4Ps8BqQes1QdAuy5IfcXGezVAcMnMeGrIDdt93/rF7M3s9obJZY8zNUya8QFTtCQ
	79tFec3W9Qlo845Z6sIs6Wn4Y2GUY2IKTxz/mLiS+5RIR+taJsLTycvn69fwnQQU
	70sgW/rtpfhRc/FX7tkJ5z8xG8OnSu/+iHAIp/lpUQ==
X-ME-Sender: <xms:sRWxZcVt_kxrdpQ3FqhIGq9pYKYQvKo1l4LM4eG2fpJ_exgZizptpw>
    <xme:sRWxZQnXha4MM4MTfPOlzjp5qvtedRFptjjNjxu_39PEs95wPjyIoXEiL5ehh4XAH
    _RAsD54Trj78g>
X-ME-Received: <xmr:sRWxZQb92o9dsp9VSWp1NVac4CYiqbIgz326jtCGw7H6xOatKSH0AZIMFkekRY0wuA_sElKqcZYkZ30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeluddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:sRWxZbWL_LlHQQr-TSfmjQ1JX1QWnNGPbVrvpXCWm1OQU3A3jAN7yA>
    <xmx:sRWxZWneKxOdNQn5vP7tmt9z5a3n0r8mby-Ab0zMXCT0-2OiYBrfZw>
    <xmx:sRWxZQelMitLZS9J6QmEvFfn3ZPBV9S9wJk9D9ICBGUBZKfDsnSpeQ>
    <xmx:sRWxZUbOJtIIBUef8neWT_wWPSlAtG7OabTIgQ0vg9GnJv-wZQMugg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 08:50:40 -0500 (EST)
Date: Wed, 24 Jan 2024 05:50:39 -0800
From: Greg KH <greg@kroah.com>
To: kernel test robot <lkp@intel.com>
Cc: Mahmoud Adam <mngyadam@amazon.com>, stable@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 2/2] fs: move S_ISGID stripping into the vfs_*() helpers
Message-ID: <2024012432-approach-expedited-bbfc@gregkh>
References: <20240124130025.2292-3-mngyadam@amazon.com>
 <ZbEKpvaVHrsXzISK@6c5a10f2f1e6>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbEKpvaVHrsXzISK@6c5a10f2f1e6>

On Wed, Jan 24, 2024 at 09:03:34PM +0800, kernel test robot wrote:
> Hi,
> 
> Thanks for your patch.
> 
> FYI: kernel test robot notices the stable kernel rule is not satisfied.
> 
> The check is based on https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1
> 
> Rule: add the tag "Cc: stable@vger.kernel.org" in the sign-off area to have the patch automatically included in the stable tree.
> Subject: [PATCH 2/2] fs: move S_ISGID stripping into the vfs_*() helpers
> Link: https://lore.kernel.org/stable/20240124130025.2292-3-mngyadam%40amazon.com

False positive :(

