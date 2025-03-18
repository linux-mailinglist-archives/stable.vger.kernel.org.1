Return-Path: <stable+bounces-124841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAB7A679DC
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 17:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE250177710
	for <lists+stable@lfdr.de>; Tue, 18 Mar 2025 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE03A211466;
	Tue, 18 Mar 2025 16:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="OlYT0IG3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJUUG/yt"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871AB211491
	for <stable@vger.kernel.org>; Tue, 18 Mar 2025 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742316180; cv=none; b=sYvPbt3kqJTxA+0r+G1B7V3DpRtkF2NOeDsvPs+T1J0vsd2fGhEzNpav30uV7ea7Sbym8ecA/IGAcjB4ODKAME0IIoQCjh/HrWv8O0kEUU61B/pHBFKS5FXCkTBmvT057FeFqL9TI5f+kVaIMwgvnblWjvnZmJMxRqO5bZCyW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742316180; c=relaxed/simple;
	bh=l15G3XEk5X9jP54KFLebfa3JKFlzRrbDZ1NbpmrMg3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaFcCmJgCaEzUKN1Pnmoo3xHkzFxqFEt1uDTJKNEFalHbFo28V2ztOI/laVQPoZlU1UUapQ+jIozAhKChNtuCfi+zC4CfaKge905DOaYmhMP3mQAwd6/VH8O30m4KBKepwEikHoJk/JY7piEEQ1ZG1cNWUwVs3JV9LjvoAbLl7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=OlYT0IG3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJUUG/yt; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 67906114013D;
	Tue, 18 Mar 2025 12:42:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 18 Mar 2025 12:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742316176; x=1742402576; bh=azhEX8iKHF
	BQmwfTll3H37NojbeUzoOHf+36Oak1wyI=; b=OlYT0IG3u4/BW0LqsGCUlrNmgP
	9wE0C9ZUEi24nTtKXhXNwQdg275FNL1y0yzqB0AG2S1oyD+Zf0KZ3R3qVZ31mlqF
	2nVJjp+tO7uatDgphEXG5zKiLFmRvlpZy1Nx5z6FtbLhpWWMDWiS4JNftqINZdnX
	zOlBFPJxt6Ix1Eyn/TTnoPNHqc/X8fHdq86LUdZzsuc0LJMujszIy3C+xrVeHDOj
	66NdfQnEpDa8EulSNbMZZ7ss25khFC6dFSRIi+Za8B8uK+aSiKuI4KaPdeOdf1fH
	8H5esJimfphusmX70n99nTtUh1dZciR/hWXuTvZryp9H5cio1QcCxVzm1+hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742316176; x=1742402576; bh=azhEX8iKHFBQmwfTll3H37NojbeUzoOHf+3
	6Oak1wyI=; b=dJUUG/ytFZUWBBzHbkrlJIvuk+bPPDs1fVHS+VDZoKOyTvAlgkz
	0yCmRqsiI+8zgVjGVNvsEif57dsbbi2tkq2/naZpZ1CktxzRTVH6P/OZ7g7dRSyI
	3Xu6jgCZ4DC3I7BQjecux81uRaLoCy84RNrQLz2Kyz0IR1Cq9hiJjniXV/iQpDZZ
	OqXpuU4eXLjJZl69JEYGeP1A5BTQ1cYg0yWD1wXUyebH4558YCoa92ICKtgNrk05
	xVRAogOYqHjx1BKXHoCoP8J6NaDu0GKRQWjPj5A9o3qWd5a/LOZf4rg/R78hMbqV
	/GKeK3p3HLpqy6ONGhA6EP/KFeC0UH5KD5w==
X-ME-Sender: <xms:kKLZZ0pNxGxpH-9KwmPEfm6bV5JV2qBHKJcThNfzuDfI0E5bX0EjSQ>
    <xme:kKLZZ6qAM2F2QoBpdl477IFS1qtILHo8ZrTuQMXibt-UFYtoNI8hRpTWSswB9ARDB
    KtulONWBrGB3w>
X-ME-Received: <xmr:kKLZZ5PcnqjPD80_uStZHalDQwlXAvgVwkLTTvP4u1i3v6yzwm88xXIOI4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeu
    fefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehhvghnrhhiqhhuvgdrtggrrhhvrghlhhhosehsuh
    hsvgdrtghomhdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvmhgrthhsuhhmihihrgesshhushgvrdguvgdprhgtphhtthhope
    hsthhfrhgvnhgthhesmhhitghrohhsohhfthdrtghomh
X-ME-Proxy: <xmx:kKLZZ75oN5zKRkx4dT8EAOyTFRpeJksgauqxj79CHOSgHb8ml_uCkQ>
    <xmx:kKLZZz4RHtukYCVF1OrCjljUf8z7f6nmCuifcAGZd14836cm0T0Ncg>
    <xmx:kKLZZ7inWXmht3yzQpRJ6ee5C9mfkl7jrR2x3jtuZP3xfTnlXHJWMA>
    <xmx:kKLZZ95KGdhUIPSpF02Mh-NZiUoqMz273b_tQdoamiYJ8iKH6MaM5w>
    <xmx:kKLZZ9sPWljzv_jHTE1MHuOaqRViTHYJev-5MV3VpmvsDgGi681Ygg-f>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 12:42:55 -0400 (EDT)
Date: Tue, 18 Mar 2025 17:41:36 +0100
From: Greg KH <greg@kroah.com>
To: Henrique Carvalho <henrique.carvalho@suse.com>
Cc: stable@vger.kernel.org, Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 6.13.y] smb: client: Fix match_session bug preventing
 session reuse
Message-ID: <2025031806-shininess-starter-54a9@gregkh>
References: <2025031652-spider-flying-c68b@gregkh>
 <20250317181622.2243629-1-henrique.carvalho@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317181622.2243629-1-henrique.carvalho@suse.com>

On Mon, Mar 17, 2025 at 03:16:22PM -0300, Henrique Carvalho wrote:
> Fix a bug in match_session() that can causes the session to not be
> reused in some cases.
> 
> Reproduction steps:
> 
> mount.cifs //server/share /mnt/a -o credentials=creds
> mount.cifs //server/share /mnt/b -o credentials=creds,sec=ntlmssp
> cat /proc/fs/cifs/DebugData | grep SessionId | wc -l
> 
> mount.cifs //server/share /mnt/b -o credentials=creds,sec=ntlmssp
> mount.cifs //server/share /mnt/a -o credentials=creds
> cat /proc/fs/cifs/DebugData | grep SessionId | wc -l
> 
> Cc: stable@vger.kernel.org
> Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
> Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> (cherry picked from commit 605b249ea96770ac4fac4b8510a99e0f8442be5e)
> ---
>  fs/smb/client/connect.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

I see 2 different versions of this, with no versioning.  Which one is
correct?

Please fix up and send a v3 with the proper information, as-is I have no
idea what to do :(

thanks,

greg k-h

