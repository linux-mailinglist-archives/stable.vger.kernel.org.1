Return-Path: <stable+bounces-110994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AB2A20F77
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 18:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23837188A018
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239F91DE3C5;
	Tue, 28 Jan 2025 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ZDWDGg5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="caAuWWWq"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB841AA1F6
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084360; cv=none; b=Bu9FeXNDK+oWwXkiUXBuKZZDSyxgrST6u+tpWjWtslEHAEPu7Vzzs84AhQwURBRYfm8gJ4uFM4/+2651gWNA5T8Th0ILn3lbG//r7RNKEdYLkLELGgbzWnn4CaO2AQO1SMYBEeHyvIn8mFbWsDoUlEJexZT9DWNwglARzHYYJPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084360; c=relaxed/simple;
	bh=0plhGdker4HRGhx8Fou9n8nVpk3IUzxZ63BZXOBnS+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdZYgO3uyt6kxzKUwaWTUpFVjifsoY1T/hvta1E6lwIImRH/sfXUJuao7lTtgMAbfBwqM7S4/V9n/CJZK4o+/zkloyITd5mR26Zq3+PrOnO8qcnKityI6s5CZC+lUMjhBiegPbgIOticNkHJrL/3y/AxBJbnc3/G7IoZjBVdsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ZDWDGg5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=caAuWWWq; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CC4CF2540108;
	Tue, 28 Jan 2025 12:12:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 28 Jan 2025 12:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738084356; x=1738170756; bh=pO9u+wk/NH
	g0qmMpuzrhyzTBHGPnxv6vqY7iLSSRJvE=; b=ZDWDGg5y1CV2sP7tFOxpSvwuNw
	sqpJhaWR4ZyX+FWWfRw3xkrapKbPXK/fMrtiG6posKeoMAsNSB2lVDB15wppfZx0
	5jX/p7HitzOkr088CzsTsVIEJRjaFlvfKiXXTwa03d2KBXfymWypvY/w0e90L7B+
	93juOq+RgGn+oVFSJbrmqmIFvsDgU3EYpVt/jIikBMilv4pmAB4S5BNz7CNVsysc
	o8g8IaDUxDtuVMImS8wUvQHvXHIDMhDSmNkm+YQnQcUPxZCX05bgslrIwaWgNQNy
	q02mSUauGMG+USStCr41/xm0g5HOZ4XQYVkDS47XLfNyJimlwTYNfCQQOF7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738084356; x=1738170756; bh=pO9u+wk/NHg0qmMpuzrhyzTBHGPnxv6vqY7
	iLSSRJvE=; b=caAuWWWq0RoNjDFcE9jc1OCXBSh9MuD/9yWDid6k77wCwPZH6p3
	6EJuamkXZBir4XwX1WKMrOj2fOMLe7TbWti3NZ18XbZhnG0y6nXV9fVRCsV57pnX
	HLoLaG3bZrRhW8Rva2D/mipLFuvhNT5RLgHPE6+4SHxNUXY8/GeHIrwGwiQPEr1w
	Ru1oORxZ9b9p58H6MHSsh7NboJVMl3Wc/NrNnZFMkBOV509Sh5BQqd88Uu/27cYt
	WZr+VmRsOhkfyJ14JvYdN7S6jx6kg7Y34Q6X/s5OvWJwJtNPilcQrqaFMOZF7xNa
	uYDdqhiYg77wxmlaDXr9leaxEv2ppYckSZw==
X-ME-Sender: <xms:AxCZZ1zjnNb419U61bCeS1lUZoS2BsGjqJGUZzelmtd2ngfkOnOWfw>
    <xme:AxCZZ1SS1_0xe031RlE5N_IUmCiodeJXnRLk3im4zKvHhPhkMT__Dl3UnrctQri_d
    GV5Td_GbAq9tw>
X-ME-Received: <xmr:AxCZZ_UdEXebh2-t30soEG1Xc35r-Xxk_PP0RwhPzu4RZGEmkkkPtQUoL-jHk6XUYZDVIS4gCUAfpJ2u3dwA5ZFElwZf4gQ8maATOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvddufeefleev
    tddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghiph
    hrihgvthhtihesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhtrggslhgvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephigrnhhgvghrkhhunheshhhurgifvg
    hirdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AxCZZ3hL82sb_PljEjGOgroFSxbTKKkZj6pJJWyzsiqYhdHrkievGg>
    <xmx:AxCZZ3C2SGvcYxoTAu9BBpfmHL-o1fH9-mzAEDevzcMqg9CV08S9sQ>
    <xmx:AxCZZwLqBNIqAibW6dKZwsXl5XKjVxU5T4LjCw5hwMfKuryjYJuobg>
    <xmx:AxCZZ2AAy76hpPRDmB1-41fWf7rO918xeddYhri9lMRhSGomLPBZHA>
    <xmx:BBCZZ77ECQriMThwZdFarTFZ_btry3nWRR4z6TNdlCaT7jtRoArnMsyr>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 12:12:35 -0500 (EST)
Date: Tue, 28 Jan 2025 18:12:33 +0100
From: Greg KH <greg@kroah.com>
To: ciprietti@google.com
Cc: stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] libfs: fix infinite directory reads for offset dir
Message-ID: <2025012815-talisman-ageless-45f9@gregkh>
References: <20250128150322.2242111-1-ciprietti@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128150322.2242111-1-ciprietti@google.com>

On Tue, Jan 28, 2025 at 03:03:22PM +0000, ciprietti@google.com wrote:
> From: yangerkun <yangerkun@huawei.com>
> 
> [ Upstream commit 64a7ce76fb901bf9f9c36cf5d681328fc0fd4b5a ]
> 
> After we switch tmpfs dir operations from simple_dir_operations to
> simple_offset_dir_operations, every rename happened will fill new dentry
> to dest dir's maple tree(&SHMEM_I(inode)->dir_offsets->mt) with a free
> key starting with octx->newx_offset, and then set newx_offset equals to
> free key + 1. This will lead to infinite readdir combine with rename
> happened at the same time, which fail generic/736 in xfstests(detail show
> as below).
> 
> 1. create 5000 files(1 2 3...) under one dir
> 2. call readdir(man 3 readdir) once, and get one entry
> 3. rename(entry, "TEMPFILE"), then rename("TEMPFILE", entry)
> 4. loop 2~3, until readdir return nothing or we loop too many
>    times(tmpfs break test with the second condition)
> 
> We choose the same logic what commit 9b378f6ad48cf ("btrfs: fix infinite
> directory reads") to fix it, record the last_index when we open dir, and
> do not emit the entry which index >= last_index. The file->private_data
> now used in offset dir can use directly to do this, and we also update
> the last_index when we llseek the dir file.
> 
> Fixes: a2e459555c5f ("shmem: stable directory offsets")
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> Link: https://lore.kernel.org/r/20240731043835.1828697-1-yangerkun@huawei.com
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
> [brauner: only update last_index after seek when offset is zero like Jan suggested]
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Andrea Ciprietti <ciprietti@google.com>
> ---
>  fs/libfs.c | 39 ++++++++++++++++++++++++++++-----------
>  1 file changed, 28 insertions(+), 11 deletions(-)

No hint as to what kernel tree(s) this is for?


