Return-Path: <stable+bounces-83214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F9996C1F
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 15:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5091C21352
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 13:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06743193417;
	Wed,  9 Oct 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="GyQ/zVNU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQNxdAVY"
X-Original-To: stable@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34261190462
	for <stable@vger.kernel.org>; Wed,  9 Oct 2024 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480873; cv=none; b=hXL9k99E63YKG8SDcEBDv8Uz8BGY9dtSE8ydoiv7LVAS2jNuYi09sr5wqMP9UyTQxuQ+VLrBfvPLMoM/UjMnX6sHmZwHmIfp+FrLAbw3TypfkYo6oFOIwLo1KMQi4PRfAEkMnRS3y6CMdtmL1Jcpksb8lLnvn6t8NLznliN55hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480873; c=relaxed/simple;
	bh=dQzqHUaJn9F2j2CKQsasbuSrOSpM5gpCZAtpEl1CJqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkoWtBBxwvMFMPI5uzCqo7vGgvS4cNp7kM3v/WAMdevEN7s9jDJU6jwclneEQqbVXdYoUI2rJLu7x51Pm5sfIo97CSFgYkTsn+x1MJztmPli4mtcD73moRkwBY12yACIWdUXuaG3X6O167IUMD6amF1p1V38t3T0xMyncT4aaVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=GyQ/zVNU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQNxdAVY; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 31AB0138018E;
	Wed,  9 Oct 2024 09:34:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 09 Oct 2024 09:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728480870; x=1728567270; bh=UHwl23mLqY
	HlCsHNALTapSvYckMaDcFFeUs+aMAdV4Y=; b=GyQ/zVNUmEjuC5XoaVGTta7TBW
	CUJXMTy4PplfsmmGv0PMCxrUu2HSEZQEvnVZGvSRCYihJtl0lLO0WLC4+jNE48fH
	DiudLXtpqGZxICW/U8/XgdU8oMOb3QhLZfUIcOGBDNHqnFsrp+jw1JqDN6tNQgdb
	aX3U1XA7/5htwwhaf8wFiKUFHUlb9NsRco+3peZgolKB8cww7r465vXTk3Qwpsf1
	XXIGSHBN/ieLKb3ra9yrfo4XH3Ll2s/YB2yl4Td/zaoyZ6Axo4tzljiXAw2/z9qr
	hp0tIMamIUGEHVZAfs9fTYt1ISIfKY/4FX99KI+vHgo3Ae76w1eqklTsKVDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728480870; x=1728567270; bh=UHwl23mLqYHlCsHNALTapSvYckMa
	DcFFeUs+aMAdV4Y=; b=hQNxdAVYgSOUT1GFgrDGjbWUTWVglWAZ/6StEhIbKSKh
	GWO1jkiu/6wQrEcCzWZ+jwgFtjFKtGOiUn8Vy5zoHXKVq82sC1FRBzIVxA945+/B
	60ViVISauI7URyTTuGi+UsaD+utvtyj0aJECDTZdWYW0EFdKuNXYB7CWm9piKerK
	vKyKm34fbKyeul9RmZaZHkFUvhe/UGcayV2aGBDYjjieVA5kRKOLWCj+Myi/U2T/
	XM7qj6ACM2D4YmjG3sS6OOmPibuFoJ82VpZXfWJxcj9ltYJKLD4MjrktMckg9ZdV
	TeeA9KV2nbxKNIsqk/gltmdYXFs2zIwhhcXb0UmITA==
X-ME-Sender: <xms:ZYYGZ3jjm2T_Kx6ig4AwSBpx5VkbeJiYMXBgwHdk9Mu4_1x3PiD5Eg>
    <xme:ZYYGZ0DGU-9pfO__DDHlpHLaMvi8SHUi164rhFIfZ6ZIHpIbc39sUaQ_a2-ZBEeMW
    CgdOfi3hqxFcQ>
X-ME-Received: <xmr:ZYYGZ3FBKWV-ZIObh5xsfuO6UdsdZa2-5o1mbBe8CO--bDXVw_QEU2I8NBT3fspxEJ_3lJ45xE-QmhkJXyfKUOB5VpWcUDpcfwkXUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrf
    grthhtvghrnhepvdegudeffeeuheefueegleffleeifedvkedtgffhjeeujeeluedukedt
    gfekleegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpmhhsghhiugdrlhhinhhkne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghg
    sehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopeigihgrnhhghihurdgthhgvnhesfihinhgurhhivhgvrhdrtghomhdp
    rhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZYYGZ0TPa7oJyb2ArwI7UPbCDhSb3j3XPRQVsaJwg4G9xoa2JEMGRQ>
    <xmx:ZYYGZ0wcEoNhk6s2uUJ_OtR4VEIEnjIb_Ct4e1dI5ZqklrlAt2DFYw>
    <xmx:ZYYGZ67wGJOaMHRUmAjNsklosQvuyA8AlKtvcI31gfNiWOM3e50g6g>
    <xmx:ZYYGZ5xf4EC3FXH1_FtQTPkV3MarBmEKNWkf5IBJeadKWIL3SeH6tA>
    <xmx:ZoYGZ-vFy8I2GvsZ93hVdUynwUiQLQZBTIavK4ppa8wda8u5wvX1kMVn>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:34:29 -0400 (EDT)
Date: Wed, 9 Oct 2024 15:34:26 +0200
From: Greg KH <greg@kroah.com>
To: Xiangyu Chen <xiangyu.chen@windriver.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v2 6.1/6.6] wifi: mac80211: Avoid address calculations
 via out of bounds array indexing
Message-ID: <2024100911-suffix-ranked-5323@gregkh>
References: <20241009081627.354405-1-xiangyu.chen@windriver.com>
 <20241009081627.354405-2-xiangyu.chen@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009081627.354405-2-xiangyu.chen@windriver.com>

On Wed, Oct 09, 2024 at 04:16:27PM +0800, Xiangyu Chen wrote:
> From: Kenton Groombridge <concord@gentoo.org>
> 
> req->n_channels must be set before req->channels[] can be used.
> 
> This patch fixes one of the issues encountered in [1].
> 
> [   83.964255] UBSAN: array-index-out-of-bounds in net/mac80211/scan.c:364:4
> [   83.964258] index 0 is out of range for type 'struct ieee80211_channel *[]'
> [...]
> [   83.964264] Call Trace:
> [   83.964267]  <TASK>
> [   83.964269]  dump_stack_lvl+0x3f/0xc0
> [   83.964274]  __ubsan_handle_out_of_bounds+0xec/0x110
> [   83.964278]  ieee80211_prep_hw_scan+0x2db/0x4b0
> [   83.964281]  __ieee80211_start_scan+0x601/0x990
> [   83.964291]  nl80211_trigger_scan+0x874/0x980
> [   83.964295]  genl_family_rcv_msg_doit+0xe8/0x160
> [   83.964298]  genl_rcv_msg+0x240/0x270
> [...]
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=218810
> 
> Co-authored-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Kenton Groombridge <concord@gentoo.org>
> Link: https://msgid.link/20240605152218.236061-1-concord@gentoo.org
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> [Xiangyu: Modified to apply on 6.1.y and 6.6.y]
> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
> ---
> V1 -> V2:
> add v6.6 support

No hint as to what the git id of this is in Linus's tree, so now
dropping :(

