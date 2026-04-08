Return-Path: <stable+bounces-233903-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BShC0xX1mn5DwgAu9opvQ
	(envelope-from <stable+bounces-233903-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:25:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A7A3BCCF4
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 15:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F3D83045246
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAA238657A;
	Wed,  8 Apr 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lwezwmWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvljHpE6"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB834A3B1;
	Wed,  8 Apr 2026 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775654711; cv=none; b=fvuwYQIdAi3AsrSShzHTp6QRGNA+/pkZCeT0I9966x9/6pW0E4TBrNKLTk+LlWtnm56prCGL0AVA5odipMXESPqPDu7XuM5YkJEzgnDqxgimLG9rxUzZ0ax5SZMUwy+6axOfw71eHxgG830hXX5dOt174fY/SqehKKI4hu9g380=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775654711; c=relaxed/simple;
	bh=s3HLdHq0mCx0fI51u4OAmoW/tximkXL0fROa0ISyseE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJT0Ysl/1DDMZ87ABtqAiX0L5UakmNfJ1xvsyd1/1Ba23BRImPmT4/GQUDIPDdCZfDt6guSt/plsTB9C2lcfinAL6u7uN7gUIfIVTTzJKKDTSFYBv9t2Xk9zv37JdUDtlwB6/Grr6Da1chRUYQ6pO7POrYF318JNvoTmsd5Rc/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=lwezwmWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvljHpE6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9625F7A0206;
	Wed,  8 Apr 2026 09:25:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 08 Apr 2026 09:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775654708; x=1775741108; bh=6conhmiHYN
	nzJRfzO9uyIA91h9+Tm+eF5ZcVZA+Q4TE=; b=lwezwmWl2uSvodc5ZE9mHnS25x
	WFwg45cOzsTV6brNIzT9WD+sYVZwC2bcqioHKuA3kMwFbFyAFw0dQCW0lzUUfnbN
	v4wiwob3l0x3U1sJ8sSGvi7Svj+0Ogj3ghVBRdfP5nRepgK3ajNQOw9xwRoBNTJN
	MXcgkTHvlEGtpbGfRhfRvFGiaqz0q7bePI9Gr3RMIa8sMvBRmgAYbaE8YSv6qsog
	XAeb22bMWDmXPznDHoAkjbgKt73V4dMSNG8kOW8mrC+OzWazJBN2dJhJfbozH1qi
	q4+Ype3Lue5oQ/yOYLyciioQ+ZHgQy6eMqvgSlk6toj5fKIzyPJizZfODU7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775654708; x=1775741108; bh=6conhmiHYNnzJRfzO9uyIA91h9+Tm+eF5Zc
	VZA+Q4TE=; b=HvljHpE6dibFrZbeKioY5VpVmPwVlAaSxh0YKPQ4N0wShhQmjc1
	AGAKAVRxYKRdqfv8IpJ4H02Cdx/ocW+o97FwIN+6/t/JJLbrB0a6wlTu8UmZ1BA5
	DUyGqfEubNEsoUCVpiVy82QkleYFvl6VlE/DvBkM2nOgC5n93dPNyNxBnGc7oY3S
	XC1YauYtXVGqlukEKEKMTd1f80gMJWNSWtdPcBSdpk3SWxPLAEMUgdQ2bEnqB0cm
	K1Ze5xv1ojCT53p6GYR4oXhlY7EFTZVtKmCK+RVeh95tumnkzb1+wcTQsPKBfTVr
	dZEup9MuXxnpxSIsDYq7nnqzS/fGhHai5mw==
X-ME-Sender: <xms:NFfWaeg66H0rWVjptJCgyajjNqYsJsyhPbx72QIT1Hwgrr4RjJbZIw>
    <xme:NFfWaW6PWNnmaICDMc560qps4kadEmeDLf7k44k2eXVcMIDoNffwkU0wq6A6rEz8b
    8qj12A5bM3DOkzsGvSr5ZK6qUBVFMKfnIJVeMetS-RKGcB19A>
X-ME-Received: <xmr:NFfWaVdFrWzj_pQivgV-RLm9AW6ldWc-wdvDw5AtTLu0BCBzsILHRY4Z4QbgxMyiYHRhxvu7dNuP5SVxBLcbOnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecu
    ggftrfgrthhtvghrnhephfeugfdthfeijeekveekuefgudfgffevhfehgeehvdehheetle
    fgkedtlefghefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshihiihkrghllhgv
    rhdrrghpphhsphhothdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhdpnhgspghrtghpthhtohep
    udegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurhhiiidvthesqhhqrdgtoh
    hmpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepgihirghngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrghosehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjvghffhhlvgiguheslhhinhhugidrrghlihgs
    rggsrgdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehshiiisghothdotdduiegukeeiudejleejfhgu
    jedukeegledurgeksehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NFfWafA3mGQJYI7k8TzcFms7cZwGhKRnA7Iv0IiVqiLMs7WK7o40vw>
    <xmx:NFfWaUCv1ydnQeybLW9HOIQ5-40ogz4BPxl4kt8hmjTfs0vaYTAuCg>
    <xmx:NFfWaRY6RUPg3BjSb1EH0mLOcBqM1sDQz_q_yRQTnJWroffr7gPCRw>
    <xmx:NFfWaRzLV0jLGysQBq09kkylEwzJbjNd-aPQQX-WdL55KUgHR4f-ow>
    <xmx:NFfWaU0g26jmuQgQYHK0RCAkvFdIk71p6O_a7-Iiy1vPpbGw74b-TWgu>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 09:25:07 -0400 (EDT)
Date: Wed, 8 Apr 2026 15:25:06 +0200
From: Greg KH <greg@kroah.com>
To: driz2t <driz2t@qq.com>
Cc: stable <stable@vger.kernel.org>, xiang <xiang@kernel.org>,
	chao <chao@kernel.org>, jefflexu <jefflexu@linux.alibaba.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	syzbot+016d861797fd718491a8 <syzbot+016d861797fd718491a8@syzkaller.appspotmail.com>
Subject: Re: [PATCH 6.1.y] erofs: get rid of z_erofs_fill_inode()
Message-ID: <2026040834-mower-award-5880@gregkh>
References: <tencent_4CAC91CB31E29B2052C48E4A15D379060905@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_4CAC91CB31E29B2052C48E4A15D379060905@qq.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233903-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,016d861797fd718491a8];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kroah.com:dkim,alibaba.com:email,qq.com:email,messagingengine.com:dkim,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 83A7A3BCCF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 07:11:22PM +0800, driz2t wrote:
> [ Upstream commit 4fdadd5b0f0c723c812842454f8cca1619f2e731 ]
> 
> Prior to big pclusters, non-compact compression indexes could have
> empty headers.
> 
> Avoid the legacy path since it can be handled properly as a specific
> compression header with z_erofs_fill_inode_lazy() too.
> 
> Tested with existing erofs-utils versions.
> 
> Link: https://lore.kernel.org/r/20230413092241.73829-1-hsiangkao@linux.alibaba.com
> Link: https://syzkaller.appspot.com/bug?extid=016d861797fd718491a8
> Reported-by: syzbot+016d861797fd718491a8@syzkaller.appspotmail.com
> Tested-by: syzbot+016d861797fd718491a8@syzkaller.appspotmail.com
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Changjian Liu <driz2t@qq.com>
> ---
>  fs/erofs/inode.c    | 12 ++++++++----
>  fs/erofs/internal.h |  2 --
>  fs/erofs/zmap.c     | 18 ------------------
>  3 files changed, 8 insertions(+), 24 deletions(-)

I see multiple versions from you sent, yet no clue as to which one is
correct, so I'm dropping them all.  Please fix up and send a new one
properly versioned.

thanks,

greg k-h

