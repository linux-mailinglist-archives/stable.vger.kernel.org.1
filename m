Return-Path: <stable+bounces-121726-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EF0A59AD1
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D97C43A3288
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA02422F166;
	Mon, 10 Mar 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="mJPHNxVn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0bsqmPFC"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D93222371A
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741623629; cv=none; b=oJlSO7WKfnlwlIhz8Vn/OHXBQKeAjiX+7qmvPa3Msd0jvM+qNEWIEgUVKgnAJVSEli+O14MYU+z7MH7y0oRZPrUnZSgsZum3Er96/Bi7IQD1bfXfKJuqgYCBgGoRVPaLb5csqKdfZSgKsvhPzMnn3IBksX+G1Dc88EHIbY77yrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741623629; c=relaxed/simple;
	bh=NfX2BzHZy2dXMGH4MhtqrQQip8UJ+okrMo+4JKziqC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG1sPkAS7/0L1ZMJdIATp/YlcZJviC0+nm/p0YzFt3REfGEfMCJoWJH9+cuhoJ5mTlc6T3i4lIUAWNi8SCqDIijC7YrliDPvVUPewHNfd40kKVYu4jwIEHCzwuIOPBs2rFgnjKlZST2hH2nkRfCokzGE9CiJ+GxJ3pLo//G4tt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=mJPHNxVn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0bsqmPFC; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E5F0B25401FC;
	Mon, 10 Mar 2025 12:20:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 10 Mar 2025 12:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741623625;
	 x=1741710025; bh=+17yUYaYG34nsL5NNS2xNcyXTzLTY6YNQ9ECnv69cZk=; b=
	mJPHNxVnwtJlDcXHPIL8Za2WC0yqMJMWmykbZhXPob46LtXT26OqrOflHy6ast+k
	+HpF8xOVyERBHWA8Z4UGavOYx0djwXyP8fGoBzHCM+Cso4ZBaxj4SyIo6zJiLbRP
	lyU0Gp4ZG5Zi+Tn6q2w0w5Gkjue/pW6fyjysn7vip4bkQ3tVy01ouhXNM/tUAvf1
	TgpXZcyAOEdsENL+CnWeU4it6R87sJPAa6Gdb+gLX+HY5SS+XbNUDeoHCgVGk9qB
	jylEivKi82hYMdhuOeUv+t5QPlIcG1f4CBd2kpUn7/AwBysmC1J/aky9X06QpCEA
	5E7sISrj5t4dgiju7K7kUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741623625; x=
	1741710025; bh=+17yUYaYG34nsL5NNS2xNcyXTzLTY6YNQ9ECnv69cZk=; b=0
	bsqmPFCG53CsCZjRB7UlBtF9u5AKUeRrDufrXHRzn/i8uWqOXNpp2E5loFrp2i+N
	iN8h5gt/q5Mpj+MnsNit/f3qPpAmdB22RHkZdUcsYzU2aSX078sjHidVP2o3WsAn
	RAOACZragbL14bc7EogP+J9A/JrQu+Zxe1SRHqPtnbNE3fESjUfK4Bkh4Yi8YhLy
	pjz3KVZE9ZHfLy3GZGEUaMAPDs5sNxYGVD7IvX/6/M956jpMqeFWEcJ0qnjUorkX
	nqSesLBFOaHIK2RHphz2a0HpQZMjRa/JEDFCko5xtddYM4/tixLDWLj1PcA7Yo7C
	0COJkIm9vzxo6BxjhOybQ==
X-ME-Sender: <xms:SRHPZ9CRcZt6_OG5suKjNml-sRQJOO0aDSTFNkfqpoDbEsh9rHL3PQ>
    <xme:SRHPZ7gREkyIHF8szK5XZpyDQxj6FZ8R7QL1h90DQURpGpvCLUiYNf1M6MfeblCWs
    c5TCwzEw-Q-6Q>
X-ME-Received: <xmr:SRHPZ4kznXyRo-JXpExUaZCDnQPTJ_WghWf4R1LK-6I74oBl83KuL4rO1t3z66cnxHe_kzRfaoY4mhUpURZLUMriLOKL7VnHmnQ3Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepifhrvghgucfmjfcuoehg
    rhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgfduvdfgveeludeffe
    fgveevkeffleelkeeigfejvedviefhgeffhfffffekudelnecuffhomhgrihhnpehshiii
    khgrlhhlvghrrdgrphhpshhpohhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgt
    phhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhighhuvghlgh
    grrhgtihgrrhhomhgrnheksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhkhhgrnheslhhinhhugi
    hfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrlhhmrgiirdgrlhgvgigrnhgu
    rhhovhhitghhsehprghrrghgohhnqdhsohhfthifrghrvgdrtghomhdprhgtphhtthhope
    hshiiisghothdotddutdelkeeisggvtgguieehuggsfhelgeeigegssehshiiikhgrlhhl
    vghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:SRHPZ3xza-BpgwFMgVD3SbIoTXcG_Kh5TMwNQGeCRpJJeqg-rFF2Ug>
    <xmx:SRHPZyRYFVKLL4ugm_WFwVn7bEQlmgb4MQUCgD-V7fDcJR8f-j-P8g>
    <xmx:SRHPZ6Z7XRpvqXQsXGPS3sU-DyCIlEBhVi5jZTUbOWvEePANCoY2Ig>
    <xmx:SRHPZzRbiprqRXNfRKv774zorDLgYv657_hDVLLVnGfuS52zitHFDg>
    <xmx:SRHPZ3I70gIqx8kyNNBJkBmd4xoDbysSCAPDAPO98OzEhQR4IQ7_1HuF>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 12:20:25 -0400 (EDT)
Date: Mon, 10 Mar 2025 17:20:22 +0100
From: Greg KH <greg@kroah.com>
To: Miguel =?iso-8859-1?Q?Garc=EDa?= <miguelgarciaroman8@gmail.com>
Cc: stable@vger.kernel.org, skhan@linuxfoundation.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+010986becd65dbf9464b@syzkaller.appspotmail.com
Subject: Re: [PATCH 5.15.y] fs/ntfs3: Fix shift-out-of-bounds in
 ntfs_fill_super
Message-ID: <2025031013-crabmeat-spectator-aa37@gregkh>
References: <20250309200218-b44aeb59f6c61146@stable.kernel.org>
 <20250310084820.20680-1-miguelgarciaroman8@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310084820.20680-1-miguelgarciaroman8@gmail.com>

On Mon, Mar 10, 2025 at 09:48:21AM +0100, Miguel García wrote:
> From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> 
> commit 91a4b1ee78cb100b19b70f077c247f211110348f upstream.
> 
> This patch is a backport and fixes an UBSAN warning about shift-out-of-bounds in
> ntfs_fill_super() function of the NTFS3 driver. The original code
> incorrectly calculated MFT record size, causing undefined behavior
> when performing bit shifts with values that exceed type limits.
> 
> The fix has been verified by executing the syzkaller reproducer test case.
> After applying this patch, the system successfully handles the test case
> without kernel panic or UBSAN warnings.
> 
> Bug: https://syzkaller.appspot.com/bug?extid=010986becd65dbf9464b
> Reported-by: syzbot+010986becd65dbf9464b@syzkaller.appspotmail.com
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> Signed-off-by: Miguel Garcia Roman <miguelgarciaroman8@gmail.com>
> (cherry picked from commit 91a4b1ee78cb100b19b70f077c247f211110348f)
> ---
>  fs/ntfs3/ntfs_fs.h |  2 ++
>  fs/ntfs3/super.c   | 63 +++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 50 insertions(+), 15 deletions(-)

Why was this resent?

confused,

greg k-h

