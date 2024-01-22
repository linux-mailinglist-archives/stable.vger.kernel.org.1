Return-Path: <stable+bounces-12750-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E3E837233
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EE31F2CDD3
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4D841743;
	Mon, 22 Jan 2024 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="heyykCPW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="r07nOuw5"
X-Original-To: stable@vger.kernel.org
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905BC4A9A2
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950127; cv=none; b=LKkpdWDK6swsK2NaM2mJK2In1gsZ7lRBLoFEJrW/5LMAk/FIKsokkFrgE+e672TSm8F1rysBk8+hdfZcHxDCTpMvE84DxlfZs5AuS5QsyVuqx6hxX+vdH+a1yvx/oT3K1THAR6ZrmBq0tnaM+OxXveL7VXJPM5UzxqtYzIqxvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950127; c=relaxed/simple;
	bh=rT0oVNLB/7T11ttzl62ZlKnh/W3/xZKLYSyvvPw4o60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjOgmAL75mzFjU1X95VjGYFnGGcQY1FuCDutBAnV7G8v5bEcPP04PHxt/oa8KmtBg5JUl+CBsxZLpjy+MHsnwjRx1PsFWF7Mgo0JarfbLH1mqzAkfATGgNcTDsyq/6wwin0LijhqXYmn+IG65CJWYzN4dL1xZSmedJLY+aD85hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=heyykCPW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=r07nOuw5; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 8ACEF5C01F9;
	Mon, 22 Jan 2024 14:02:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 22 Jan 2024 14:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705950124; x=1706036524; bh=/3jn0klblO
	JlmE5L7RLA0gOkZzg+qb+808qcNYDq010=; b=heyykCPWh+Xa6vDvp7ZcdHVxU/
	TxfUXFJpV9R1lEO8HMaexmQPhympkFcfigzzA6vrwy0gcpROd5JyeOrXLen3MXoA
	2x3GeGk0021My1fPlupI7JniwqaIVvVsECdmfqFSzLbIErYkewWK2+x413bZHUjx
	lMc7nOOx5dZ4KOC9VsoP9WaZXOvjnyUEKUdYvfEVoXfR9hT8pPheF1qiWpxi6vd4
	C8JyOpwMt+og36JTZcBuXrt5qWGp2FIWPpO11au2Cx9TNlY93xcwJbcLUBwCwP0w
	7YtgpxCAQkU78/ARpWrcTVOvRNnPlCWR5Ia9GdEVG2kU9Mik3FQiiQYmQQ7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705950124; x=1706036524; bh=/3jn0klblOJlmE5L7RLA0gOkZzg+
	qb+808qcNYDq010=; b=r07nOuw5c8s6MBJBuBJqnawdRfqryJM6KUnDAyRjPpc9
	DpUZCfcrbmv7tfa4U+3VsQAGQAjmec6lwcjK0m1HwhTrQvgsXydWKkKs+HYYtd5Y
	WTy2ZkXSIh5UBLAiB+8IxlAWlROq6xMUPdJphXWv83jeO8phgZa9C6iBdI+86bNH
	1SsgzPA2lgg+63jqiNWb2yt+MwrqgCBht9mkYV5JLWpZinKviT/1JjACdyf8uH7f
	Hplju25RYAz9ZMAiL2vofBJ+zMOvkix7OyXFvTKGc+hJ4apcxuG7vaukfPd0HBYU
	Ky4b2wf7dzsSqIJdnh1UqCKXChkl5mZ27Fwayj8RTQ==
X-ME-Sender: <xms:rLuuZZXkVEg-9XYlwFFZHoR_kNN0ng8LXcN3yxoCBLWcbkYglDrLpQ>
    <xme:rLuuZZlN1Uj9KyybnaLPygmi72tYsLLi2RBiF5xQJlv-_omgdN75Nu0P05GBCxxEE
    CwOtrnbMZ9lRA>
X-ME-Received: <xmr:rLuuZVbY9dSidZxnLroOyT3jZwbfig5p8Ab_nNz2VCItMPurdkCXAYkeVHP3eMDXJi1UDHLyQtzvgW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:rLuuZcXMNdWjc29ejrYwOHGMEhn5UmWBt06KtAoYyVihpSO1K6YAcQ>
    <xmx:rLuuZTnywPVcAbSH9HT6nX38KcYYjzf01_6IltHpaBZbImexWtKTfw>
    <xmx:rLuuZZf0ODir7JAmQaC7s5t9CWuRg_x3xNX0DwO-kctKFkCsp8ZRyw>
    <xmx:rLuuZRaZSCbPFmkzWihhgMBQojYOivWrfercD5yXVOUuvkKcYCXfHQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 14:02:03 -0500 (EST)
Date: Mon, 22 Jan 2024 11:01:56 -0800
From: Greg KH <greg@kroah.com>
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: zack.rusin@broadcom.com, stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] drm/vmwgfx backport two fixes to v6.1.x branch
Message-ID: <2024012246-affirm-vixen-e598@gregkh>
References: <20240122172031.243604-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122172031.243604-1-jfalempe@redhat.com>

On Mon, Jan 22, 2024 at 06:10:11PM +0100, Jocelyn Falempe wrote:
> Hi,
> 
> I've backported this two commits:
> f9e96bf19054 drm/vmwgfx: Fix possible invalid drm gem put calls
> 91398b413d03 drm/vmwgfx: Keep a gem reference to user bos in surfaces
> 
> They both fixes a950b989ea29 ("drm/vmwgfx: Do not drop the reference
> to the handle too soon")
> which has been backported to v6.1.x branch as 0a127ac97240
> 
> There was a lot of conflicts, and as I'm not familiar with the vmwgfx
> driver, it's better to review and test them.
> I've run a short test, and it worked, but that's certainly not enough.

All now queued up, thanks.

greg k-h

